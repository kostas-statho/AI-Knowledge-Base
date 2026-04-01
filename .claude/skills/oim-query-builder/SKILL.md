---
name: oim-query-builder
description: >
  Generate a ready-to-run OIM SQL query from a plain-English description.
  8 categories: Sampling, Queue, Membership, Attestation, IT Shop, BAS, Sync, Compliance.
  Prints verified SQL only — no execution, no file writes.
argument-hint: >
  "top 50 from ESet" | "stuck jobs in queue StathopoulosK" | "failed jobs history"
  | "app role memberships for jsmith" | "nested AD groups for Domain Admins"
  | "dynamic groups" | "open attestation cases" | "pending IT Shop requests for jsmith"
  | "who approved request X" | "business role to system role mapping"
  | "sync status" | "risk index rules" | "rule violations" | "orphaned accounts"
  | "direct system role assignments for jsmith" | "AAD groups for upn"
user-invocable: true
allowed-tools: "Read, Grep"
---

Generate a ready-to-run OIM SQL query from the plain-English argument.
All templates are **verified against the live `STATHOPOULOSK/OneIM` database (2026-03-30)**.
Print only — no execution, no file writes.

## Step 1 — Classify the request

Match the argument to one category and one template file using this table:

| Category | Trigger keywords | Template files |
|---|---|---|
| **Sampling** | sample, top, peek, explore, count, rows, list, orphan, orphaned, unlinked | `SQL/Sampling/Table_TopN.sql`, `RowCounts.sql`, `OrphanedAccounts.sql` |
| **Queue** | job, queue, stuck, pending, blocked, frozen, overview, dbqueue, slot, history, error, failed | `SQL/Queue/JobQueue_Overview.sql` (default), `JobQueue_Status.sql`, `JobQueue_ByQueue.sql`, `DBQueue_Current.sql`, `JobHistory_Recent.sql` |
| **Membership** | member, membership, ad group, nested group, business role, org, app role, aerole, manager, aad, azure, dynamic group, system role, eset direct | `SQL/Membership/BusinessRole_Membership.sql`, `AppRole_Membership.sql`, `AD_Memberships.sql`, `ManagerHierarchy.sql`, `AAD_Membership.sql`, `ADSGroup_Nested.sql`, `DynamicGroups.sql`, `SystemRole_Direct.sql` |
| **Attestation** | attest, attestation, case, open, deadline, campaign, run, decision, approved, denied, policy | `SQL/Attestation/OpenCases.sql`, `CasesByDate.sql`, `AttestationRuns.sql`, `AttestationDecisions.sql`, `AttestationPolicies.sql` |
| **IT Shop** | itshop, shop, request, pending request, approval, approve, denied, waiting, assigned, workflow, order | `SQL/ITShop/PendingRequests.sql`, `ApprovalHistory.sql` |
| **BAS** | bas, service item, shelf, accproduct, role mapping, business role system | `SQL/BAS/BAS-5.sql`, `BAS-6.sql`, `RoleMapping.sql` |
| **Sync** | sync, synchronisation, projection, dpr, connected system, provision | `SQL/Sync/SyncConfig.sql`, `SyncJournal.sql` |
| **Compliance** | compliance, risk, risk index, qer, weight, violation, rule violation, sod, noncompliance | `SQL/Compliance/RiskIndex.sql`, `RuleViolations.sql` |

**Disambiguation rules:**
- "queue" alone → `JobQueue_Overview.sql`
- "queue <name>" → `JobQueue_ByQueue.sql`; substitute queue name
- "failed jobs" / "error jobs" → `JobHistory_Recent.sql`
- "dbqueue" / "slot" → `DBQueue_Current.sql`
- "business role" + "system role" / "mapping" → `BAS/RoleMapping.sql` (BaseTreeHasESet)
- "system role" alone / "eset" / "direct" → `Membership/SystemRole_Direct.sql` (PersonHasESet)
- "risk" / "risk index" → `Compliance/RiskIndex.sql`
- "violation" / "sod" / "noncompliance" → `Compliance/RuleViolations.sql`
- "orphaned" / "unlinked" → `Sampling/OrphanedAccounts.sql`

## Step 2 — Read the template

Use the `Read` tool on the chosen file under `SQL/`. The base path is:
```
C:/Users/OneIM/Knowledge_Base/SQL/
```

Example: `Read` → `C:/Users/OneIM/Knowledge_Base/SQL/Queue/JobQueue_ByQueue.sql`

## Step 3 — Customise placeholders

Replace these placeholders if the user supplied values:

| Placeholder | Replace with |
|---|---|
| `<account>` | CentralAccount value (e.g. `jsmith`) |
| `<QueueName>` | Queue name (e.g. `StathopoulosK`) |
| `<upn>` | Azure AD UPN (e.g. `jsmith@domain.com`) |
| `<uid_person>` | UID_Person GUID |
| `<uid_aerole>` | UID_AERole GUID |
| `<uid_personwantsorg>` | UID_PersonWantsOrg GUID |
| `<uid_attestationcase>` | UID_AttestationCase GUID |
| `<uid_manager>` | UID_Person of the manager |
| `<ObjectKey>` | BasisObjectKey string |
| `<TableName>` | Any OIM table name |
| `<group_cn>` | AD group CN (e.g. `Domain Admins`) |
| `<eset_name>` | Ident_ESet value |
| Date literals | Use ISO format `'YYYY-MM-DD'` |

If no value is provided, leave the placeholder so the user can fill it in SSMS.

## Step 4 — Print the query

Output a fenced SQL block:

````
```sql
-- Purpose : <from template header>
-- Tables  : <from template header>
-- Notes   : <from template header>
-- Source  : <from template header>

<customised SQL here>
```
````

## Step 5 — Print a one-line footer

End with exactly one line indicating safety and target:

- If the query is read-only: `Safe read-only — run in SSMS against STATHOPOULOSK / OneIM`
- If the query modifies data: `⚠ Modifies data — run in dev/test only — STATHOPOULOSK / OneIM`

## Error handling

| Situation | Action |
|---|---|
| Argument is ambiguous (matches 2+ categories) | Pick the most specific match; state your reasoning in one sentence |
| No category matches | Ask the user to clarify which table or area they want to query |
| Template file not found | State the expected path and ask the user to verify the SQL library is present |
