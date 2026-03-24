# Knowledge Base — One Identity Manager (OIM) Development

Consolidated repository of all OIM development work: C# CompositionAPI server plugins, PowerShell export tooling, and SQL scripts.

## Directory Map

```
Knowledge_Base/
├── Plugins/                    C# REST API plugins for the OIM Web Portal
│   ├── CCC_BulkActions/        Bulk CSV import/action endpoints
│   ├── DataExplorerEndpoints/  Data Explorer membership-removal endpoints
│   └── StathopoulosK.Plugin/   Sample/learning plugin (API exercises)
│
├── PowerShell/
│   └── OIM_ExportTool/
│       ├── src/                Source code (entry: MainPsModule.ps1)
│       └── docs/               HTML docs + README
│
├── SQL/
│   ├── Membership/             AD membership and manager queries
│   ├── Queue/                  Queue management scripts
│   ├── BAS/                    Business Access/Service ticket queries
│   └── Reports/                Reporting and ad-hoc queries
│
└── Docs/
    └── Architecture.md         Plugin patterns, bulk lifecycle, PS tool reference
```

---

## C# Plugins

All plugins target **.NET 8.0** and reference DLLs from `C:\Program Files\One Identity\One Identity Manager\`.

| Plugin | Endpoints | Build |
|---|---|---|
| `CCC_BulkActions` | `webportalplus/*/startaction`, `/validate`, `/action`, `/endaction` | `dotnet build CCC_BulkActions.sln` |
| `DataExplorerEndpoints` | `webportalplus/de/*` | `dotnet build DataExplorerEndpoints.sln` |
| `StathopoulosK.Plugin` | Various sample endpoints | `dotnet build StathopoulosK.CompositionApi.Server.Plugin.sln` |

See [`Docs/Architecture.md`](Docs/Architecture.md) for the full plugin pattern.

---

## PowerShell OIM Export Tool

Extracts and exports object data from OIM Transport ZIP files.

```powershell
cd PowerShell\OIM_ExportTool\src
.\MainPsModule.ps1 -ZipPath "C:\path\to\export.zip"
```

Config defaults in `src\config.json`. Full documentation in [`PowerShell/OIM_ExportTool/docs/README.md`](PowerShell/OIM_ExportTool/docs/README.md).

**Supported object types:** DBObjects, Process, Templates, Scripts, TableScripts, FormatScripts, CanSeeScripts, CanEditScripts

---

## SQL Scripts

| Category | Files | Purpose |
|---|---|---|
| `SQL/Membership/` | AD_Memberships, IsInternalManager | AD group membership and manager lookups |
| `SQL/Queue/` | ClearQueue | Process queue maintenance |
| `SQL/BAS/` | BAS-5, BAS-6, BAS-8 | Business Access/Service request queries |
| `SQL/Reports/` | Report3, SQLQuery1, SQLQuery2, With | Reporting and exploratory queries |
