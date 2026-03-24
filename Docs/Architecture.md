# OIM Developer Architecture Reference

## Projects Overview

| Project | Type | Purpose |
|---|---|---|
| `Plugins/CCC_BulkActions` | C# .NET 8.0 | Bulk CSV import/action endpoints for OIM Web Portal |
| `Plugins/DataExplorerEndpoints` | C# .NET 8.0 | Data Explorer API endpoints (membership removal) |
| `Plugins/StathopoulosK.Plugin` | C# .NET 8.0 | Learning/sample plugin with API exercises |
| `PowerShell/OIM_ExportTool` | PowerShell | Extracts and processes OIM Transport ZIP files |

---

## C# Plugin Architecture

### Build

All projects target `.NET 8.0`. DLL dependencies come from:
```
C:\Program Files\One Identity\One Identity Manager\
```

Build:
```bash
dotnet build CCC_BulkActions.sln
dotnet build DataExplorerEndpoints.sln
dotnet build StathopoulosK.CompositionApi.Server.Plugin.sln
```

Deploy the built `.dll` to the OIM API Server plugin directory.

### Plugin Registration

Entry point implements `IPlugInMethodSetProvider`. It:
1. Creates a `MethodSet` with an `AppId`
2. Wires up all `IApiProvider` implementations via `IExtensibilityService.FindAttributeBasedApiProviders<T>()`
3. Sets `SessionConfig`

### Endpoint Classes

Each endpoint is a separate class implementing `IApiProvider` + `IApiProviderFor<TProject>`.

The `Build(IApiBuilder builder)` method registers one endpoint:

```csharp
builder.AddMethod(Method.Define("webportalplus/myfeature/action")
    .Handle<PostedID, object>("POST", async (posted, qr, ct) =>
    {
        string uid = qr.Session.User().Uid;
        var q = Query.From("TableName").Select("Column").Where($"...");
        var result = await qr.Session.Source().TryGetAsync(q, EntityLoadType.DelayedLogic, ct);

        using var u = qr.Session.StartUnitOfWork();
        await u.PutAsync(entity, ct);
        await u.CommitAsync(ct);
    }));
```

Key session helpers:
- `qr.Session.User().Uid` — current user UID
- `qr.Session.Source()` — DB access (`TryGetAsync`, `ExistsAsync`, `CreateNewAsync`)
- `qr.Session.Config().GetConfigParmAsync("Custom\\Path\\...", ct)` — config params
- All DB calls use `.ConfigureAwait(false)`
- Namespace: `QBM.CompositionApi`

### Bulk Action Lifecycle (4-Endpoint Contract)

Web portal calls these endpoints in sequence for bulk CSV operations:

| Suffix | Method | Purpose |
|---|---|---|
| `/startaction` | POST | Pre-flight: returns `{ message, permission, collectImportData? }` |
| `/validate` | POST | Per-row: returns `object[]` with `{ column }` or `{ column, errorMsg }` |
| `/action` | POST | Per-row: performs the actual DB write/delete |
| `/endaction` | POST | Post-flight: receives import stats, returns summary message |

All web portal endpoints are registered under `webportalplus/` and implement `IApiProviderFor<PortalApiProject>`.

### String Formatting Note

Use `$"..."` interpolation (not `string.Format`) when the string contains `\n` line breaks — `Format` with verbatim strings produces `\\n` instead of `\n`.

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

### Adding a New Object Type

Each object type needs three modules following the naming pattern:
- `<Type>_Main_PsModule.psm1` — orchestrates the type's export
- `<Type>_XmlParser.psm1` — parses the XML from the ZIP
- `<Type>_Exporter_PsModule.psm1` — writes the output files
