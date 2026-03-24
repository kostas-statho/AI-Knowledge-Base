# Live Plugins vs Academy Reference — Comparison

Cross-reference between production plugin code (`Plugins/`) and academy training implementations (`Training/CustomCode/`). Use this to identify gaps, upgrade opportunities, and intentional differences.

---

## A — CCC_BulkActions vs Training/CustomCode/BulkActions_Ref

The `BulkActions_Ref` folder contains the exercise endpoint implementations from Academy module 024_002.

### File Mapping

| Live file (`Plugins/CCC_BulkActions/`) | Academy file (`BulkActions_Ref/`) | Status |
|---|---|---|
| `startAction.cs` (InsertIdentitiesStartAction) | `insrtPerson_startAction.cs` | **Identical** |
| `startValidate.cs` | `insrtPerson_startValidate.cs` | **Identical** |
| `Validate.cs` | `insrtPerson_Validate.cs` | **Identical** |
| `endAction.cs` | `insrtPerson_endAction.cs` | **Identical** |
| `CSVtemplate.cs` | `insrtPerson_CSVtemplate.cs` | **Identical** |
| `Action.cs` (InsertIdentitiesAction) | *(no counterpart)* | **Live-only** |
| `addEnt_startAction.cs` | `addEnt_startAction.cs` | **Identical** |
| `addEnt_startValidate.cs` | `addEnt_startValidate.cs` | **Identical** |
| `addEnt_Action.cs` | `addEnt_Action.cs` | **Identical** |
| `addEnt_Validate.cs` | `addEnt_Validate.cs` | **Identical** |
| `addEnt_csvTemplate.cs` | `addEnt_csvTemplate.cs` | **Identical** |
| `addEnt_endAction.cs` | `addEnt_endAction.cs` | **Identical** |
| `removeEnt.cs` | `removeEnt.cs` | **Identical** |

### Notes

**Live-only: `Action.cs`**
The per-row action handler for the InsertIdentities bulk action has no academy counterpart — the exercise set (`insrtPerson_*`) was never completed with the action step. The live `Action.cs` (`InsertIdentitiesAction`) at `webportalplus/InsertIdentities/action`:
- Iterates `posted.columns` for FirstName, LastName, Email, Remarks, PersonalTitle, PersonnelNumber
- Resolves the calling user's department via `UID_PersonHead` on the `Department` table
- Creates a new `Person` entity (`EntityCreationType.DelayedLogic`) and commits via `UnitOfWork`

**Naming convention:** The live project uses generic names (`Action.cs`, `startAction.cs`) while the academy uses descriptive names (`insrtPerson_startAction.cs`). Both approaches work — the descriptive names are clearer when multiple bulk action groups coexist.

**Official reference samples** (`Training/CustomCode/BulkActions_Ref` from 024_002 OneDrive docs) contain 5 complete action groups with the action step: DeactivateIdentities, DeleteIdentities, InsertIdentities, UpdateIdentities, Unsubscribe, newEntitlement. These provide complete reference patterns for future bulk action implementations.

---

## B — DataExplorerEndpoints vs Training/CustomCode/DataExplorer_Ref

The `DataExplorer_Ref` folder contains the official reference sample endpoints from Academy module 024_003.

### File Mapping

| Live file (`Plugins/DataExplorerEndpoints/`) | Academy file (`DataExplorer_Ref/`) | Status |
|---|---|---|
| `DE_Action.cs` (CCCApproveAttestationAction) | `CCCApproveAttestationAction.cs` | **Similar — minor differences** |
| `DE_Validate.cs` | `CCCApproveAttestationValidate.cs` | Similar |
| `DE_RemoveMembership_Action.cs` | `CCCRemoveMembershipAction.cs` | **Diverged — live is subset** |
| `DE_RemoveMembership_Validate.cs` | `CCCRemoveMembershipValidate.cs` | Similar |
| `DE_RemoveAllMembership_Action.cs` | `CCCRemoveAllMoverBRMembershipsAction.cs` | Similar |
| `DE_RemoveAllMembership_Validate.cs` | `CCCRemoveAllMoverBRMembershipsValidate.cs` | Similar |
| *(no counterpart)* | `CCCUpdateMainDataAction.cs` | **Academy-only** |
| *(no counterpart)* | `CCCUpdateMainDataValidate.cs` | **Academy-only** |

### Key Difference: `DE_RemoveMembership_Action.cs` vs `CCCRemoveMembershipAction.cs`

**Live version** (`webportalplus/removebusinessrole/action`):
- Handles `PersonInOrg` table only
- Does **not** handle `PersonInAERole` assignments
- Does **not** read `xRisk` or `#LDS#Affected right` from posted columns
- Does **not** call `CCC_AttestationHistoryDE` process

**Academy reference** (`webportalplus/removemembership/action`):
- Handles `PersonInOrg` AND `PersonInAERole` tables
- Reads `xRisk` and `#LDS#Affected right` fields
- After deletion, calls `u.GenerateAsync("CCC_AttestationHistoryDE", htParameter, ct)` with `access`, `datehead`, `approverUid`, `affectedright`, `riskindex`, `type: "denySINGLE"` — this fires the history process
- URL uses `removemembership` vs live `removebusinessrole`

**Missing from live plugin:**
1. `PersonInAERole` removal (Application Entitlement Role memberships are not handled)
2. Risk index and affected right tracking
3. `CCC_AttestationHistoryDE` process invocation (attestation history is not recorded)

### Academy-only: `CCCUpdateMainData*`

The academy reference includes two endpoints for updating an identity's main data (e.g., department, manager) directly from the Data Explorer. The live `DataExplorerEndpoints` plugin does not have this capability. These files live at `Training/CustomCode/DataExplorer_Ref/` as reference for a potential future addition.

---

## C — StathopoulosK.Plugin vs Training/CustomCode/API_Exercises

### File Mapping

| Live file (`Plugins/StathopoulosK.Plugin/`) | Academy file (`API_Exercises/`) | Status |
|---|---|---|
| `CCC_StathopoulosK.cs` | `CCC_StathopoulosK.cs` | **Origin — identical** |
| `ApiSamples.cs` | `ApiSamples.cs` | **Origin — identical** |
| `ApiSamples_Basic.cs` | `ApiSamples_Basic.cs` | **Origin — identical** |
| `API_Exercises.cs` | `API_Exercises.cs` | **Origin — identical** |

The `StathopoulosK.Plugin` **is** the exercise implementation — the live project was built directly from the API exercise module. No divergence expected.

---

## D — VB.NET Custom Scripts (no live plugin counterpart)

These inline scripts live in OIM script editors, not in a C# plugin project.
Reference copies are at `Training/CustomCode/VBNet/`.

### `CCC_Generate_CentralAccount.txt`
- **Table:** `Person.CentralAccount`
- **Purpose:** Generates a unique `T#####` (T + 5-digit random number) central account identifier
- **Pattern:** `Session.Source.TryGetSingleValue()` to check uniqueness, loop up to 10 attempts

**Known bug — missing `Exit Do`:**
The loop runs all 10 iterations regardless of whether a valid account was found on the first try.
`valueToReturn` is overwritten on every iteration where no conflict exists, so the function returns whatever was last generated without conflict — not necessarily the first valid one.
This is harmless functionally (any non-conflicting value is valid), but wastes up to 9 unnecessary DB checks.

### `custom_property_03.txt`
- **Table:** `Person.CustomProperty03`
- **Purpose:** Ensures uniqueness of `CustomProperty03` by appending an incrementing numeric suffix (value → value1 → value2 …) when a duplicate is detected
- **Guard:** `If DbVal.IsEmpty($CustomProperty03[o]:String$, ValType.String)` — only executes when the *old* value was empty, i.e., first assignment only
- **Pattern:** LIKE query to get all matching rows, then loops checking for exact match with counter suffix

---

## SDK Reference Coverage

The live plugins use the following patterns from the SDK. Official examples are in `Training/API_SDK/`:

| Pattern used in live code | SDK reference |
|---|---|
| `Method.Define().Handle<T>()` POST handler | `Sdk01_Basics/03-CustomMethod.cs` |
| `qr.Session.Source().TryGetAsync()` | `Sdk04_WritingData/01-WriteDelayedLogicEntity.cs` |
| `qr.Session.Source().ExistsAsync()` | `Sdk01_Basics/07-DeletionMethod.cs` |
| `qr.Session.Source().CreateNewAsync()` | `Sdk04_WritingData/05-NewDelayedLogicEntity.cs` |
| `qr.Session.StartUnitOfWork()` + `CommitAsync()` | `Sdk04_WritingData/01-WriteDelayedLogicEntity.cs` |
| `entity.MarkForDeletion()` + `u.PutAsync()` | `Sdk01_Basics/07-DeletionMethod.cs` |
| `entity.CallMethodAsync()` | `Sdk01_Basics/10-Scripts.cs` |
| `u.GenerateAsync()` | *(no SDK sample — OIM-internal pattern)* |
| `qr.Session.Config().GetConfigParmAsync()` | `Sdk03_Customization/07-Configuration.cs` |
| `qr.Session.Resolve<IStatementRunner>()` | `Sdk01_Basics/02-BasicSqlMethod.cs` |
