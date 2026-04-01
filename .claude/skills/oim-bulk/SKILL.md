---
name: oim-bulk
description: Generate all 4 bulk-action endpoints for a new OIM CSV bulk feature (startaction, validate, action, endaction). Use when implementing a full bulk import/action workflow.
argument-hint: "<FeatureName> \"<description of what the action does>\""
user-invocable: true
allowed-tools: "Read, Write, Glob"
---

Generate all 4 bulk-action endpoint files for a new feature. Read `templates/oim_bulk_action/` first, then adapt.

## The 4 files to create

Given `<FeatureName>` (e.g. "UpdateDepartment"):

| File | Class | Endpoint | Purpose |
|---|---|---|---|
| `<FeatureName>StartAction.cs` | `<FeatureName>StartAction` | `webportalplus/<featurename>/startaction` | Pre-flight: permission check, config read, return `{ message, permission }` |
| `<FeatureName>Validate.cs` | `<FeatureName>Validate` | `webportalplus/<featurename>/validate` | Per-row: return `object[]` with `{ column }` (ok) or `{ column, errorMsg }` (fail) |
| `<FeatureName>Action.cs` | `<FeatureName>Action` | `webportalplus/<featurename>/action` | Per-row: perform DB write/update/delete |
| `<FeatureName>EndAction.cs` | `<FeatureName>EndAction` | `webportalplus/<featurename>/endaction` | Post-flight: receive stats, return summary `{ message }` |

## Required rules

- `ConfigureAwait(false)` on every await
- `$"..."` for strings with `\n`
- All 4 classes implement `IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider`
- Namespace: `QBM.CompositionApi`
- Each file has its own `PostedID` / `PostedData` class matching the web portal's JSON contract

## startaction contract

```csharp
// Input: { headerNames: string[], totalRows: int }
// Output: { message: string, permission: bool, collectImportData?: bool }
```

## validate contract

```csharp
// Input: { index: string, columns: [{ column, value }] }
// Output: object[] — each element is { column } for ok, { column, errorMsg } for error
```

## action contract

```csharp
// Input: { index: string, columns: [{ column, value }] }
// Output: void (no return)
```

## endaction contract

```csharp
// Input: { totalRows, SuccessfulRowsCount, ErrorRowsCount, SuccessfulRows[], ErrorRows[] }
// Output: { message: string, allImported: bool, ... stats }
```

## After generating

State: all 4 file paths, the endpoint URLs, and remind to add to an existing plugin's entry point or use `/project:oim-plugin` to scaffold a new plugin.
