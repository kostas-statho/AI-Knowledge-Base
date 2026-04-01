# SQL Scripts Reference

All scripts are reference/ad-hoc queries for OIM database work. Not production migrations.

**Convention:** Every script should have a header comment block:

```sql
-- Purpose : <one-line description>
-- Tables  : <comma-separated table names touched>
-- Notes   : <any caveats or prerequisites>
-- Source  : <KB article, community post, or "live DB verified">
```

Use `/project:oim-query-builder <description>` to generate a customised query from any template.

---

## Sampling/

Quick diagnostics — sample rows, count tables, find gaps.

| File | Purpose | Key Tables |
|---|---|---|
| `Table_TopN.sql` | TOP-N row sample of any table | `<TableName>` |
| `RowCounts.sql` | Row counts across all key OIM tables | `sys.tables`, `sys.partitions` |
| `PersonWithoutADSAccount.sql` | Employees with no AD account — sync gap | `Person`, `ADSAccount` |
| `OrphanedAccounts.sql` | Accounts not linked to any Person | `ADSAccount`, `AADUser` |

## Queue/

OIM job queue and DB queue monitoring.

| File | Purpose | Key Tables |
|---|---|---|
| `ClearQueue.sql` | Reassigns tasks to a specific queue (dev/test only) | `JobQueue` |
| `JobQueue_Overview.sql` | Per-queue counts — first stop for health check | `QBMJobqueueOverview` |
| `JobQueue_Status.sql` | Pending and stuck jobs with status breakdown | `JobQueue` |
| `JobQueue_ByQueue.sql` | Filter pending jobs by queue name | `JobQueue` |
| `DBQueue_Current.sql` | DBQueue slot diagnostics | `QBMDBQueueCurrent`, `QBMDBQueueTask` |
| `JobHistory_Recent.sql` | Recent job execution history + errors | `JobHistory` |

> **Warning:** `ClearQueue.sql` modifies job scheduling. Only run in dev/test environments.
> Do NOT directly `UPDATE`/`INSERT` `JobQueue` — blocked by `QBM_TUJobQueue` trigger.

## Membership/

Identity memberships across all role types.

| File | Purpose | Key Tables |
|---|---|---|
| `AD_Memberships.sql` | AD accounts and group memberships for identities | `ADSAccount`, `ADSAccountInADSGroup`, `ADSGroup`, `Person` |
| `IsInternalManager.sql` | Inline function — checks if a request's manager chain has an internal manager | `HelperHeadPerson`, `PersonWantsOrg`, `Person` |
| `BusinessRole_Membership.sql` | Business role (Org) memberships for an identity | `PersonInOrg`, `Org`, `Person` |
| `AppRole_Membership.sql` | Application role (AERole) memberships | `PersonInAERole`, `AERole`, `Person` |
| `ManagerHierarchy.sql` | Direct reports + full upward manager chain | `HelperHeadPerson`, `Person` |
| `AAD_Membership.sql` | Azure AD group memberships + OIM Person link | `AADUser`, `AADUserInGroup`, `AADGroup` |
| `ADSGroup_Nested.sql` | Nested AD group hierarchy (recursive) | `ADSGroupInADSGroup`, `ADSGroup` |
| `DynamicGroups.sql` | All dynamic groups with their WHERE clause | `DynamicGroup`, `DialogTable` |
| `SystemRole_Direct.sql` | Direct system role (ESet) assignments — excludes inherited | `PersonHasESet`, `ESet`, `Person` |

**XOrigin values (all membership tables):** 1=direct, 2=inherited, 4=dynamic (bitfield)

## Attestation/

Attestation case management and reporting.

| File | Purpose | Key Tables |
|---|---|---|
| `OpenCases.sql` | Active (open, undecided) cases within deadline | `AttestationCase` |
| `CasesByDate.sql` | Cases updated within a date range | `AttestationCase` |
| `AttestationRuns.sql` | Recent attestation run history | `AttestationRun`, `AttestationPolicy` |
| `AttestationDecisions.sql` | Who approved/denied/aborted each case | `AttestationHistory`, `AttestationCase` |
| `AttestationPolicies.sql` | All attestation policies with schedule and risk | `AttestationPolicy` |

## ITShop/

IT Shop request lifecycle and approval history.

| File | Purpose | Key Tables |
|---|---|---|
| `PendingRequests.sql` | Active and pending requests for an identity | `PersonWantsOrg`, `Person` |
| `ApprovalHistory.sql` | Approval/rejection history for requests | `PWODecisionHistory`, `PersonWantsOrg` |

**Live OrderState values:** Unsubscribed, Aborted, Assigned, Dismissed, Waiting, New, OrderProduct, Granted, Canceled, OrderProlongate

## BAS/

Business Access / Service — service items, system roles, and role mappings.

| File | Purpose | Key Tables |
|---|---|---|
| `BAS-5.sql` | ESet and AccProduct relationship | `ESet`, `AccProduct` |
| `BAS-6.sql` | Extended BAS relationship query | `ESet`, `AccProduct` |
| `BAS-8.sql` | Further BAS relationship query | `ESet`, `AccProduct` |
| `RoleMapping.sql` | Business role (Org) → System role (ESet) mappings | `BaseTreeHasESet`, `BaseTree`, `ESet`, `AccProduct` |

> **Note:** `ESet.UID_AccProduct` is a direct FK — there is no `AccProductInESet` junction table.

## Sync/

Synchronisation configuration and run history.

| File | Purpose | Key Tables |
|---|---|---|
| `SyncConfig.sql` | All sync configurations with direction | `DPRProjectionConfig` |
| `SyncJournal.sql` | Recent sync run journal + currently running syncs | `DPRJournal` |

**ProjectionDirection values:** ToTheLeft=sync from target, ToTheRight=provision to target, Inherite

## Compliance/

Risk index rules and SOD/policy violation tracking.

| File | Purpose | Key Tables |
|---|---|---|
| `RiskIndex.sql` | Risk index rule definitions and weights | `QERRiskIndex` |
| `RuleViolations.sql` | SOD rule violations per identity + compliance policies | `NonCompliance`, `PersonInNonCompliance`, `QERPolicy`, `Person` |

## Reports/

Ad-hoc and exploratory reporting queries.

| File | Purpose | Key Tables |
|---|---|---|
| `Report3.sql` | Custom report query | (see file) |
| `SQLQuery1.sql` | Exploratory query | (see file) |
| `SQLQuery2.sql` | Exploratory query | (see file) |
| `With.sql` | Query using CTE (WITH clause) | (see file) |

---

## Common OIM Tables Quick Reference

| Table | Contains |
|---|---|
| `Person` | Identities (employees, contractors) |
| `ADSAccount` | Active Directory accounts |
| `ADSGroup` | Active Directory groups |
| `ADSAccountInADSGroup` | AD account → group memberships |
| `ADSGroupInADSGroup` | Nested AD group memberships |
| `PersonInOrg` | Identity → business role (Org) memberships |
| `PersonInAERole` | Identity → application role memberships |
| `PersonHasESet` | Identity → system role (direct + inherited) |
| `PersonInBaseTree` | Identity → business role via BaseTree (system-managed) |
| `HelperHeadPerson` | Manager chain helper (flattened) |
| `DynamicGroup` | Dynamic group definitions with SQL WHERE clause |
| `AttestationCase` | Active and historical attestation cases |
| `AttestationRun` | One record per policy execution run |
| `AttestationHistory` | Decision history per case |
| `AttestationPolicy` | Attestation policy definitions |
| `JobQueue` | OIM process/task queue |
| `JobHistory` | Job execution history |
| `QBMJobqueueOverview` | Per-queue count summary view |
| `QBMDBQueueCurrent` | DBQueue processor slot status |
| `QBMDBQueueTask` | DBQueue task definitions |
| `ESet` | System roles |
| `AccProduct` | Service catalogue items |
| `PersonWantsOrg` | IT Shop requests |
| `PWODecisionHistory` | IT Shop approval/rejection history |
| `BaseTree` | Business role hierarchy (Org tree) |
| `BaseTreeHasESet` | Business role → system role mappings |
| `AADUser` | Azure AD user accounts |
| `AADGroup` | Azure AD groups |
| `AADUserInGroup` | Azure AD user → group memberships |
| `DPRProjectionConfig` | Sync configuration per target system |
| `DPRJournal` | Sync run journal |
| `QERRiskIndex` | Risk index rule definitions |
| `NonCompliance` | Compliance rule violation records |
| `PersonInNonCompliance` | Identity → violation mappings |
| `QERPolicy` | Compliance policy definitions |
