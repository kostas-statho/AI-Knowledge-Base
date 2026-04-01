# OIM SQL Query Library — Index

> All scripts are reference/ad-hoc queries, not production migrations.
> Add metadata header to every new script. See `_meta/CONVENTIONS.md`.
> Use `/oim-query-builder <description>` to generate new queries from plain English.
> Use `/oim-query-evaluation <file|query|inline SQL> [--fix]` to score any query across 6 dimensions (Safety, SARGability, OIM Correctness, Optimization Health, Academic Risk, Code Quality).

---

## Common Tables Quick Reference

> Verified against live DB 2026-03-30. All column names confirmed.

| Table | Key Columns (verified) | Purpose |
|---|---|---|
| Person | UID_Person, CentralAccount, FirstName, LastName, DefaultEmailAddress, UID_PersonHead | Identities |
| ADSAccount | UID_ADSAccount, UID_Person, SAMAccountName, IsDisabled, UID_ADSDomain | AD accounts |
| ADSGroup | UID_ADSGroup, CN, DistinguishedName, GroupType | AD groups |
| ADSAccountInADSGroup | UID_ADSAccount, UID_ADSGroup, XOrigin | AD group memberships |
| ADSGroupInADSGroup | UID_ADSGroupChild, UID_ADSGroupParent | Nested AD groups |
| AADUser | UID_AADUser, UID_Person, UserPrincipalName, DisplayName | Azure AD users |
| AADGroup | UID_AADGroup, DisplayName, MailNickName, IsSecurityEnabled | Azure AD groups |
| AADUserInGroup | UID_AADUser, UID_AADGroup, XOrigin | AAD group memberships |
| Org | UID_Org, Ident_Org, UID_OrgHead, UID_OrgRoot | Business roles |
| PersonInOrg | UID_PersonInOrg, UID_Person, UID_Org, XOrigin | Business role assignments |
| AERole | UID_AERole, Ident_AERole, Description | Application roles |
| PersonInAERole | UID_PersonInAERole, UID_Person, UID_AERole, XOrigin | App role assignments |
| ESet | UID_ESet, Ident_ESet, UID_AccProduct, DisplayName | System roles |
| PersonHasESet | UID_PersonHasESet, UID_Person, UID_ESet, XOrigin | System role assignments |
| AccProduct | UID_AccProduct, Ident_AccProduct, IsITShopProduct | Service items (IT Shop) |
| QERAssign | UID_QERAssign, UID_AccProduct, ObjectKeyAssignTarget, Ident_QERAssign | Assignment resources (business role → product) |
| PersonWantsOrg | UID_PersonWantsOrg, UID_PersonOrdered, UID_PersonHead, OrderState, DisplayOrg, ValidFrom, ValidUntil | IT Shop requests |
| PWODecisionHistory | UID_PersonWantsOrg, DecisionType, DisplayPersonHead, DateHead, OrderState | Request approval history |
| AttestationCase | UID_AttestationCase, IsClosed, IsGranted, DisplayName, DisplayPersonHead, ToSolveTill | Attestation cases — IsGranted: NULL=pending, 1=approved, 0=denied |
| AttestationRun | UID_AttestationRun, UID_AttestationPolicy, PolicyProcessed, HistoryNumber | Attestation runs |
| AttestationHistory | UID_AttestationHistory, UID_AttestationCase, DecisionType, DisplayPersonHead, DateHead | Attestation decisions |
| AttestationPolicy | UID_AttestationPolicy, Ident_AttestationPolicy, SolutionDays, RiskIndex | Attestation policies |
| ATT_VAttestationDecisionPerson | UID_AttestationCase, UID_Person | Approver eligibility view |
| JobQueue | UID_Job, TaskName, JobChainName, Queue, Ready2EXE, WasError, ErrorMessages, Retries | Job queue tasks |
| JobHistory | UID_Job, TaskName, JobChainName, Queue, WasError, ErrorMessages, StartAt, EndedAt, BasisObjectKey | Job execution history |
| JobChain | UID_JobChain, Name, ProcessDisplay, LimitationCount | Registered process chain definitions |
| QBMJobqueueOverview | QueueName, CountTrue(pending), CountProcessing, CountFalse(blocked), CountFrozen, CountOverlimt, CountFinished, IsInvalid | Job queue health view |
| QBMDBQueueCurrent | UID_DialogDBQueue, UID_Task, SlotNumber, StartedAt | DB queue active slot status |
| DPRProjectionConfig | UID_DPRProjectionConfig, Name, DisplayName, ProjectionDirection, ConflictResolution, ExceptionHandling | Sync configurations |
| DPRJournal | UID_DPRJournal, UID_DPRProjectionConfig, ProjectionConfigDisplay, ProjectionState, CreationTime, CompletionTime | Sync run history |
| NonCompliance | UID_NonCompliance, Ident_NonCompliance, DisplayName, FullPath, ApprovalState | SOD violation rule objects |
| PersonInNonCompliance | UID_NonCompliance, UID_Person, IsDecisionMade, IsExceptionGranted | Person ↔ violation link |
| QERRiskIndex | UID_QERRiskIndex, DisplayValue, TypeOfCalculation, Weight, IsInActive | Risk index rules |
| HelperHeadPerson | UID_Person, UID_PersonHead, XOrigin | Flattened manager chain (all levels) |
| DynamicGroup | UID_DynamicGroup, WhereClause, UID_DialogTable | Dynamic group SQL rules |
| BaseTreeHasESet | UID_Org, UID_ESet, XOrigin | Business role (Org) → system role (ESet) mappings |
| DialogConfigParm | UID_ConfigParm, ConfigParm, FullPath, Value, Enabled, IsEnabledResulting, IsCrypted | OIM configuration parameters |

**XOrigin bitfield:** `1`=direct, `2`=inherited, `4`=dynamic, `8`=requested

---

## Query Index

### Attestation/

| File | Purpose | Key Tables |
|---|---|---|
| OpenCases.sql | Active cases within deadline | AttestationCase |
| CasesByDate.sql | Cases updated in a date range | AttestationCase |
| AttestationRuns.sql | Recent run history | AttestationRun, AttestationPolicy |
| AttestationDecisions.sql | Who approved/denied each case | AttestationHistory, AttestationCase |
| AttestationPolicies.sql | All policies with schedule | AttestationPolicy |

### BAS/

| File | Purpose | Key Tables |
|---|---|---|
| BAS-5.sql | System role (ESet) ↔ service item (AccProduct) + IT Shop shelf mapping | ESet, AccProduct, ITShopOrgHasESet |
| BAS-6.sql | Business role (Org) ↔ service item via QERAssign + IT Shop shelf mapping | QERAssign, Org, AccProduct, ITShopOrgHasQERAssign |
| BAS-8.sql | IT Shop approval chain — PWO ruler origin + manager chain (uses QER_FGIPWORulerOrigin function) | Person, ADSAccount, PersonWantsOrg, HelperHeadPerson |
| RoleMapping.sql | Business role → system role mappings (55 in this env) | BaseTreeHasESet, BaseTree, ESet, AccProduct |

### Compliance/

| File | Purpose | Key Tables |
|---|---|---|
| RiskIndex.sql | Risk index rule definitions | QERRiskIndex |
| RuleViolations.sql | SOD violations per identity | NonCompliance, PersonInNonCompliance, QERPolicy |

### ITShop/

| File | Purpose | Key Tables |
|---|---|---|
| PendingRequests.sql | Active/pending requests for an identity | PersonWantsOrg |
| ApprovalHistory.sql | Approval/rejection history | PWODecisionHistory |

### Membership/

| File | Purpose | Key Tables |
|---|---|---|
| AAD_Membership.sql | AAD group memberships + OIM Person link | AADUser, AADUserInGroup, AADGroup |
| AD_Memberships.sql | AD group memberships per person | Person, ADSAccount, ADSAccountInADSGroup, ADSGroup |
| ADSGroup_Nested.sql | Nested AD group hierarchy (recursive CTE) | ADSGroupInADSGroup, ADSGroup |
| AppRole_Membership.sql | Application role memberships | PersonInAERole, AERole, Person |
| BusinessRole_Membership.sql | Business role memberships + linked AD groups | PersonInOrg, Org, OrgHasADSGroup, Person |
| DynamicGroups.sql | Dynamic groups + WHERE clauses (13 in this env) | DynamicGroup, DialogTable |
| ManagerHierarchy.sql | Direct reports + full manager chain (recursive CTE, 10-level cap) | HelperHeadPerson, Person |
| ManagerTeamRoles.sql | All App/System/Business roles assigned to a manager's team | PersonInAERole, PersonHasESet, PersonInOrg, HelperHeadPerson |
| SystemRole_Direct.sql | Direct system role assignments (XOrigin=1 filter) | PersonHasESet, ESet, Person |

### Queue/

| File | Purpose | Notes |
|---|---|---|
| JobQueue_Overview.sql | Per-queue health — first stop for diagnostics | QBMJobqueueOverview |
| JobQueue_Status.sql | Pending and stuck jobs (all queues) | JobQueue |
| JobQueue_ByQueue.sql | Filter pending jobs by specific queue name | JobQueue |
| DBQueue_Current.sql | DB queue slot diagnostics (negative SlotNumber = problem) | QBMDBQueueCurrent, QBMDBQueueTask |
| JobHistory_Recent.sql | Recent job execution + errors (38K rows, 113 errors as of 2026-03-30) | JobHistory |
| ProcessChain.sql | Monitor jobs by process chain name; list all registered chains | JobQueue, JobHistory, JobChain |
| JobQueue_Reassign_Admin.sql | Reassign pending tasks to a queue (dev/test only) | **DESTRUCTIVE — QBM_PTriggerDisable/Enable** |
| ClearQueue.sql | Bulk reassign all tasks in a queue | **DESTRUCTIVE — dev/test only** |

### Sampling/

| File | Purpose | Key Tables |
|---|---|---|
| Table_TopN.sql | TOP 100 rows from any table (replace TableName) | Any |
| RowCounts.sql | Row counts across key OIM tables (sys.partitions — no table scan) | sys.tables, sys.partitions |
| PersonWithoutADSAccount.sql | Employees with no AD account (sync gap diagnostic) | Person, ADSAccount |
| OrphanedAccounts.sql | Accounts not linked to any Person (leaver/orphan diagnostic) | ADSAccount, AADUser |
| ConfigParams.sql | Search and browse OIM configuration parameters (459 enabled in this env) | DialogConfigParm |

### Sync/

| File | Purpose | Key Tables |
|---|---|---|
| SyncConfig.sql | All sync configs with direction | DPRProjectionConfig |
| SyncJournal.sql | Recent sync runs + currently running | DPRJournal |

### _Scratch/

Unverified/exploratory queries. Promote to a category folder after verifying against live DB.

| File | Contents | Notes |
|---|---|---|
| SQLQuery1.sql | Ad-hoc AccProduct/FirmPartner/Person lookups with hardcoded UIDs | Keep as reference |
| Report3.sql | Manager-team roles report (multi-union: App+System+Business) | Promoted → Membership/ManagerTeamRoles.sql |
| SQLQuery2.sql | JobQueue task reassignment script | Promoted → Queue/JobQueue_Reassign_Admin.sql |
| With.sql | Recursive CTE: find nearest non-external manager for a request | Keep, hardcoded UIDs — parameterise before use |

---

## Adding a New Query

1. Pick category folder (or `_Scratch/` if unverified)
2. Add metadata header (see `_meta/CONVENTIONS.md`)
3. Add row to this INDEX.md
4. Update root `INDEX.md` if it's a new category
