# OIM Tables — Quick Reference (Top 50)

> Fast-load context reference. For full schema (691 tables), see `_meta/db_discovery.md`.
> Regenerate with: `/oim-db-structure`
> Last updated: 2026-03-30 | DB: STATHOPOULOSK\OneIM

---

## Identity & Accounts

| Table | Key Columns | Rows | Purpose |
|---|---|---|---|
| Person | UID_Person, CentralAccount, FirstName, LastName, DefaultEmailAddress, UID_PersonHead, IsExternal, ExitDate, CustomProperty02 | ~500 | Core identity records |
| ADSAccount | UID_ADSAccount, UID_Person, SAMAccountName, IsLocked, UID_ADSDomain | ~500 | Active Directory accounts |
| AADUser | UID_AADUser, UID_Person, UserPrincipalName, DisplayName | ~50 | Azure AD users |
| ADSGroup | UID_ADSGroup, CN, DistinguishedName, GroupType, UID_ADSDomain | ~200 | AD security/distribution groups |
| AADGroup | UID_AADGroup, UID_AADOrganization, DisplayName, MailNickName, Description | ~30 | Azure AD groups |

## Memberships

| Table | Key Columns | Rows | Purpose |
|---|---|---|---|
| ADSAccountInADSGroup | UID_ADSAccountInADSGroup, UID_ADSAccount, UID_ADSGroup, XOrigin | ~1000 | AD group memberships |
| ADSGroupInADSGroup | UID_ADSGroupInADSGroup, UID_ADSGroupChild, UID_ADSGroupParent | ~200 | Nested AD group hierarchy |
| AADUserInGroup | UID_AADUserInGroup, UID_AADUser, UID_AADGroup | ~50 | AAD group memberships |

## Business Roles

| Table | Key Columns | Rows | Purpose |
|---|---|---|---|
| Org | UID_Org, Ident_Org, Description, UID_OrgHead, UID_OrgRoot | ~100 | Business roles (Org tree) |
| PersonInOrg | UID_PersonInOrg, UID_Person, UID_Org, XOrigin, XDateInserted | ~300 | Business role assignments |
| BaseTree | UID_BaseTree, Ident_BaseTree | ~100 | Business role hierarchy base |
| BaseTreeHasESet | UID_BaseTree, UID_ESet | ~55 | Business role → system role mappings |
| PersonInBaseTree | UID_Person, UID_BaseTree, XOrigin | ~300 | Business role tree memberships |
| HelperHeadPerson | UID_Person, UID_PersonHead, LevelNumber | ~2000 | Flattened manager chain (all levels) |

## Application Roles

| Table | Key Columns | Rows | Purpose |
|---|---|---|---|
| AERole | UID_AERole, Ident_AERole, Description, UID_AERoleOwner | ~20 | Application roles |
| PersonInAERole | UID_PersonInAERole, UID_Person, UID_AERole, XOrigin | ~50 | App role assignments |

## System Roles & Service Items

| Table | Key Columns | Rows | Purpose |
|---|---|---|---|
| ESet | UID_ESet, Ident_ESet, UID_AccProduct, Description | ~30 | System roles |
| PersonHasESet | UID_PersonHasESet, UID_Person, UID_ESet, XOrigin | ~100 | System role assignments |
| AccProduct | UID_AccProduct, Ident_AccProduct, IsITShopProduct, UID_AccProductParent | ~30 | Service items / entitlements |

## IT Shop (Requests)

| Table | Key Columns | Rows | Purpose |
|---|---|---|---|
| PersonWantsOrg | UID_PersonWantsOrg, UID_PersonOrdered, UID_PersonHead, OrderState, DisplayOrg, ValidFrom, ValidUntil, OrderReason | ~100 | IT Shop requests — no UID_Person col, use UID_PersonOrdered |
| PWODecisionHistory | UID_PWODecisionHistory, UID_PersonWantsOrg, Decision, Reason | ~200 | Request approval/rejection trail |
| ITShopOrg | UID_ITShopOrg, Ident_Org | ~20 | IT Shop shelf/service category |

**OrderState values:** Unsubscribed, Aborted, Assigned, Dismissed, Waiting, New, OrderProduct, Granted, Canceled, OrderProlongate

## Attestation

| Table | Key Columns | Rows | Purpose |
|---|---|---|---|
| AttestationPolicy | UID_AttestationPolicy, Ident_AttestationPolicy, SolutionDays, RiskIndex | ~63 | Attestation policies |
| AttestationRun | UID_AttestationRun, UID_AttestationPolicy, PolicyProcessed, HistoryNumber, CountChunksUnderConstruction | ~20 | Attestation run history — no IsCompleted col, use PolicyProcessed IS NOT NULL |
| AttestationCase | UID_AttestationCase, IsClosed, IsGranted, DisplayName, DisplayPersonHead, ToSolveTill | ~50 | Attestation cases — IsGranted: NULL=pending, 1=approved, 0=denied |
| AttestationHistory | UID_AttestationHistory, UID_AttestationCase, DecisionType, DisplayPersonHead, ReasonHead, DateHead | ~1998 | Attestation decisions — DecisionType: Create/Grant/Dismiss/Abort/Escalate |
| ATT_VAttestationDecisionPerson | UID_AttestationCase, UID_Person | View | Approver eligibility (always check before MakeDecision) |

## Job Queue & Processing

| Table | Key Columns | Rows | Purpose |
|---|---|---|---|
| JobQueue | UID_Job, TaskName, JobChainName, Queue, Ready2EXE, WasError, ErrorMessages, Retries | ~1571+ | Pending/active job tasks — Ready2EXE: TRUE/FINISHED/OVERLIMIT |
| JobHistory | UID_Job, TaskName, JobChainName, Queue, WasError, ErrorMessages, StartAt, EndedAt, BasisObjectKey | ~38K | Completed job history |
| JobChain | UID_JobChain, Name, ProcessDisplay, LimitationCount | ~50+ | Registered process chain definitions |
| QBMJobqueueOverview | QueueName, CountTrue(pending), CountProcessing, CountFalse(blocked), CountFrozen, CountOverlimt, CountFinished, IsInvalid | View | Job queue health dashboard |
| QBMDBQueueCurrent | UID_DialogDBQueue, UID_Task, SlotNumber, StartedAt | View | DB queue active slots — negative SlotNumber=problem |
| QBMDBQueueTask | UID_Task, ProcedureName | View | DB queue task name lookup |

## Synchronization

| Table | Key Columns | Rows | Purpose |
|---|---|---|---|
| DPRProjectionConfig | UID_DPRProjectionConfig, Name, DisplayName, ProjectionDirection, ConflictResolution, ExceptionHandling | ~9 | Sync project configurations — use Name not Ident_ |
| DPRJournal | UID_DPRJournal, UID_DPRProjectionConfig, ProjectionConfigDisplay, ProjectionState, CreationTime, CompletionTime | ~3 | Sync run journal — use CreationTime/CompletionTime not StartTime |

**ProjectionDirection:** ToTheLeft (sync from target), ToTheRight (provision to target), Inherite

## Compliance & Risk

| Table | Key Columns | Rows | Purpose |
|---|---|---|---|
| QERPolicy | UID_QERPolicy, Ident_QERPolicy, IsViolationsCritical | ~5 | Compliance/SOD policies |
| NonCompliance | UID_NonCompliance, Ident_NonCompliance, DisplayName, FullPath, ApprovalState | ~20 | SOD violation rule objects — no UID_Person, join via PersonInNonCompliance |
| PersonInNonCompliance | UID_NonCompliance, UID_Person, IsDecisionMade, IsExceptionGranted | ~20 | Person ↔ violation link |
| QERRiskIndex | UID_QERRiskIndex, Ident_QERRiskIndex, RiskWeight | ~10 | Risk index rules and weights |

## Configuration & Process Chains

| Table | Key Columns | Purpose |
|---|---|---|
| DialogConfigParm | UID_ConfigParm, ConfigParm, FullPath, Value, Enabled, IsEnabledResulting, IsCrypted, DisplayName | OIM system configuration parameters (459 enabled, 8 top categories) |
| JobChain | UID_JobChain, Name, ProcessDisplay, LimitationCount | Registered process chain definitions (Designer-managed) |

## Dynamic Groups

| Table | Key Columns | Purpose |
|---|---|---|
| DynamicGroup | UID_DynamicGroup, WhereClause, UID_DialogTable | Dynamic membership rule definitions |
| DialogTable | UID_DialogTable, TableName | Schema table registry |

## Audit / Common Columns (on every table)

| Column | Type | Purpose |
|---|---|---|
| XObjectKey | varchar(138) | Unique cross-table object identifier `<Key><T>TableName</T><P>UID</P></Key>` |
| XOrigin | int | Assignment origin bitfield: 1=direct, 2=inherited, 4=dynamic, 8=requested |
| XDateInserted | datetime | Record creation timestamp |
| XDateUpdated | datetime | Last update timestamp |
| XMarkedForDeletion | int | Soft-delete flag |
| XTouched | nchar(1) | Sync touch marker |

---

## Notes

- `XOrigin` is used on all assignment tables. Check `(XOrigin & 1) = 1` for direct-only.
- `XObjectKey` format: `<Key><T>TableName</T><P>UID_Column=value</P></Key>`
- `ESet.UID_AccProduct` is a **direct FK** — no `AccProductInESet` junction table exists
- Full schema: `_meta/db_discovery.md` (15,000+ lines, 691 tables, 11,620 columns)
