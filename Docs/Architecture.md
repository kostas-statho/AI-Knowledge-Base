# OIM Developer Architecture Reference

## Projects Overview

| Project | Type | Purpose |
|---|---|---|
| `Plugins/CCC_BulkActions` | C# .NET 8.0 | Bulk CSV import/action endpoints for OIM Web Portal |
| `Plugins/DataExplorerEndpoints` | C# .NET 8.0 | Data Explorer API endpoints (attestation, membership removal, main data update) |
| `Plugins/StathopoulosK.Plugin` | C# .NET 8.0 | Learning/sample plugin with API exercises |
| `PowerShell/OIM_ExportTool` | PowerShell | Extracts and processes OIM Transport ZIP files |

---

## C# Plugin Architecture

### Build

All projects target `.NET 8.0`. DLL dependencies come from:
```
C:\Program Files\One Identity\One Identity Manager\
```

Key DLLs (all referenced via `<HintPath>` in .csproj — no NuGet):
- `QBM.CompositionApi.dll` — core composition API
- `QBM.CompositionApi.Server.dll` — server-side extensions
- `QER.CompositionApi.dll` — portal project types
- `QER.CompositionApi.Server.PlugIn.dll` — plugin discovery
- `VI.Base.dll` — OIM base utilities
- `VI.DB.dll` — database access (Query, Entity, UnitOfWork)

Build commands:
```bash
dotnet build CCC_BulkActions.sln
dotnet build DataExplorerEndpoints.sln
dotnet build StathopoulosK.CompositionApi.Server.Plugin.sln
```

Deploy: copy `*.CompositionApi.Server.Plugin.dll` to the OIM API Server plugin directory, then restart the API Server service.

### Why HintPath, not NuGet

OIM DLLs are not published to NuGet. They ship with the OIM installation and must be referenced directly:

```xml
<Reference Include="QBM.CompositionApi">
  <HintPath>..\..\..\..\..\Program Files\One Identity\One Identity Manager\QBM.CompositionApi.dll</HintPath>
</Reference>
```

Use `templates/oim_plugin.csproj` as the starting point — it already has all required references.

### Plugin Registration

```
IPlugInMethodSetProvider          ← discovered by API Server on startup
    └─> IMethodSetProvider        ← wires up all endpoints
         └─> IExtensibilityService.FindAttributeBasedApiProviders<T>()
              └─> IApiProvider (×N)    ← one class per endpoint
```

ASCII diagram:

```
API Server startup
      │
      ▼
 [assembly: Module("CCC")]
 CustomApiPlugin : IPlugInMethodSetProvider
      │  .Build(resolver)
      ▼
 MyCCCPlugin : IMethodSetProvider
      │  new MethodSet { AppId = "MyPlugin" }
      │  svc.FindAttributeBasedApiProviders<MyCCCPlugin>()
      │       ─────────────────────────────────
      │       discovers all classes in this assembly that implement
      │       IApiProviderFor<PortalApiProject> + IApiProvider
      ▼
 [MyFeatureAction, MyFeatureValidate, ...]
      │  each .Build(IApiBuilder) registers one endpoint
      ▼
 Method.Define("webportalplus/myfeature/action")
 .Handle<PostedID, object>("POST", async (posted, qr, ct) => { ... })
```

### Endpoint Classes

Each endpoint is a separate class:

```csharp
public class MyFeatureAction :
    IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
{
    public void Build(IApiBuilder builder)
    {
        builder.AddMethod(Method.Define("webportalplus/myfeature/action")
            .Handle<PostedID, object>("POST", async (posted, qr, ct) =>
            {
                string uid = qr.Session.User().Uid;

                // DB read
                var q = Query.From("TableName").Select("Column").Where($"...");
                var result = await qr.Session.Source()
                    .TryGetAsync(q, EntityLoadType.DelayedLogic, ct)
                    .ConfigureAwait(false);

                // DB write
                using var u = qr.Session.StartUnitOfWork();
                await u.PutAsync(entity, ct).ConfigureAwait(false);
                await u.CommitAsync(ct).ConfigureAwait(false);
            }));
    }
}
```

Key session helpers:
- `qr.Session.User().Uid` — current user UID
- `qr.Session.Source()` — DB access (`TryGetAsync`, `ExistsAsync`, `CreateNewAsync`)
- `qr.Session.Config().GetConfigParmAsync("Custom\\Path\\...", ct)` — config params
- `qr.Session.Resolve<IStatementRunner>()` — raw SQL execution

### Bulk Action Lifecycle (4-Endpoint Contract)

Web portal calls these endpoints in sequence for bulk CSV operations:

```
Web Portal
    │
    ▼
POST /startaction    { headerNames[], totalRows }
    │  ← { message, permission, collectImportData? }
    │
    ▼ (for each CSV row)
POST /validate       { index, columns[{ column, value }] }
    │  ← object[] — [{ column } | { column, errorMsg }]
    │
    ▼ (for each valid row)
POST /action         { index, columns[{ column, value }] }
    │  ← void
    │
    ▼
POST /endaction      { totalRows, SuccessfulRowsCount, ErrorRowsCount, ... }
    └─ ← { message, allImported, ... stats }
```

All web portal endpoints are registered under `webportalplus/` and implement `IApiProviderFor<PortalApiProject>`.

---

## Common Pitfalls

### 1. Missing ConfigureAwait(false)

```csharp
// WRONG — can cause deadlocks in library code
var result = await qr.Session.Source().TryGetAsync(q, EntityLoadType.DelayedLogic, ct);

// CORRECT — always on every await
var result = await qr.Session.Source().TryGetAsync(q, EntityLoadType.DelayedLogic, ct)
    .ConfigureAwait(false);
```

### 2. string.Format with \n

```csharp
// WRONG — produces \\n instead of \n in the response
{ "message", string.Format(@"Row {0} failed.\nCheck the value.", index) }

// CORRECT — use $ interpolation
{ "message", $"Row {index} failed.\nCheck the value." }
```

### 3. Not checking TryGetAsync success

```csharp
// WRONG — .Result throws if !Success
var entity = (await qr.Session.Source().TryGetAsync(q, ..., ct)).Result;

// CORRECT
var tryGet = await qr.Session.Source().TryGetAsync(q, EntityLoadType.DelayedLogic, ct)
    .ConfigureAwait(false);
if (!tryGet.Success) throw new InvalidOperationException("Not found.");
var entity = tryGet.Result;
```

### 4. Writing outside a UnitOfWork

```csharp
// WRONG — direct SaveAsync works but bypasses UoW tracking
await entity.SaveAsync(qr.Session, ct).ConfigureAwait(false);

// CORRECT — use UnitOfWork for all writes
using var u = qr.Session.StartUnitOfWork();
await u.PutAsync(entity, ct).ConfigureAwait(false);
await u.CommitAsync(ct).ConfigureAwait(false);
```

### 5. DLL output conflict

If the build copies OIM DLLs to the output folder (causing assembly conflicts), add to .csproj:
```xml
<Reference Include="QBM.CompositionApi">
  <HintPath>...</HintPath>
  <Private>false</Private>  <!-- prevents copy to output -->
</Reference>
```

---

## PowerShell OIM Export Tool

**Location:** `PowerShell/OIM_ExportTool/src/`

### Entry Point

```powershell
.\MainPsModule.ps1 -ZipPath "C:\path\to\export.zip" [-DMPassword]
```

Defaults come from `config.json`. Key config keys:

| Key | Purpose |
|---|---|
| `OutPath` | Output directory for exported files |
| `LogPath` | NLog log directory |
| `NLoggerDLL` | Path to NLog.dll |
| `DMDll` | Path to DeploymentManager DLL |
| `DMPassword` | Plain or `[E]`-prefixed encrypted password |
| `CSVMode` | Export as CSV instead of XML |
| `PreviewXml` | Show XML preview without writing |
| `ExcludedColumnsCSV` | Path to column exclusion list |

### Architecture Flow

```
MainPsModule.ps1
  └─> InputValidator.psm1      (merge CLI args + config.json)
       └─> Per-object-type modules (in src/ subdirs):
            Common/             ApiLogin, ExtractXMLFromZip, PsModuleLogin, XDateCheck
            DBObjects/          Main, XmlParser, XmlExporter, CsvExporter, FilterColumns
            Process/            Main, XmlParser, Export-Process, DmDoc
            Templates/          Main, XmlParser, Exporter
            Scripts/            Main, XmlParser, Exporter
            TableScripts/       Main, XmlParser, Exporter
            FormatScripts/      Main, XmlParser, Exporter
            CanSeeScripts/      Main, XmlParser, Exporter
            CanEditScripts/     Main, XmlParser, Exporter
```

### Support Modules

- `DmDoc.psm1` — builds Deployment Manager XML documents
- `NLogger.psm1` — wraps NLog (7-day rolling archive)
- `PasswordEncryption.psm1` — handles `[E]`-prefixed encrypted passwords
- `Encrypt-Password.ps1` — utility to pre-encrypt a password

### PowerShell 5.1 Compatibility Notes

- Use `[ValidateNotNullOrEmpty()]` not `[ValidateNotNullOrWhiteSpace()]` (PS 6.0+ only)
- Wrap `Get-ChildItem` results with `@()` — returns single object (not array) for 1 result in PS5.1
- Use `New-Object GenericType[T](args)` not `[GenericType[T]]::new(args)` constructor overloads

### Adding a New Object Type

Each object type needs three modules:
- `<Type>_Main_PsModule.psm1` — orchestrates the type's export
- `<Type>_XmlParser.psm1` — parses the XML from the ZIP
- `<Type>_Exporter_PsModule.psm1` — writes the output files
