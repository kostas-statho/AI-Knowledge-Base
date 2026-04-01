# Knowledge Base — One Identity Manager (OIM) Development

Consolidated repository for OIM development: C# CompositionAPI plugins, SQL scripts, VB.NET samples, Python/PowerShell automation, training materials, and Intragen OIM Academy content.

**Master index:** [`INDEX.md`](INDEX.md) | **KB guide:** [`CLAUDE.md`](CLAUDE.md) | **DB schema:** [`_meta/db_discovery.md`](_meta/db_discovery.md)

---

## Directory Map

```
Knowledge_Base/
├── _meta/                      KB infrastructure (IMPORT_GUIDE, SKILLS_GUIDE, CONVENTIONS, db_discovery)
├── OIM/                        OIM runtime code: Plugins, SQL, VBNet, PowerShell, Automation, Templates
│   ├── Plugins/                3 C# REST plugins (.NET 8): CCC_BulkActions, DataExplorerEndpoints, StathopoulosK
│   ├── SQL/                    Query library (9 categories + _Scratch/)
│   ├── VBNet/                  VB.NET script samples (12 categories)
│   ├── PowerShell/             OIM_ExportTool/ + Connector/ + Admin/
│   ├── Automation/             GUI/python/ (pywinauto) + GUI/data/ + Window/ (PS)
│   ├── Templates/v1/           C# boilerplate (endpoint, plugin entry, bulk action 4-pack, .csproj)
│   └── TestAssist/             Pester/Gherkin test framework (TestAssist v1.2.2)
├── Docs/                       Reference documentation: Architecture, Tables, SQL rules, training HTML
├── Learning/                   All educational content
│   ├── Training/               Curated: SDK_Samples/, Reference_Implementations/, Exercises/
│   ├── Mentoring/              18 Intragen-branded OIM Academy module guides + presentations
│   └── Guides/                 Scenario implementation guides (AAD_NoMailbox, Control3, O3EMailbox)
├── Tools/                      Personal tools: IntragenAssistant/, ChatAssistant/, ChatBox/, GoalSetter/, Office_Productivity/
├── Academy/                    Raw OIM Academy training — 1,280 files (READ-ONLY source)
├── Personal/                   Local only (.gitignored)
└── Archive/                    OneIdentityManager9.3/ SDK backup + OIM_93_Manuals/ PDFs (gitignored)
```

---

## C# Plugins

All plugins target **.NET 8.0**, reference DLLs from `C:\Program Files\One Identity\One Identity Manager\`.

| Plugin | Endpoints | Build |
|---|---|---|
| `CCC_BulkActions` | InsertIdentities, addEntitlement, removeEntitlement | `dotnet build OIM/Plugins/CCC_BulkActions/CCC_BulkActions.sln` |
| `DataExplorerEndpoints` | approveattestation, removebusinessrole, removeallmemberships, updatemaindata | `dotnet build OIM/Plugins/DataExplorerEndpoints/DataExplorerEndpoints.sln` |
| `StathopoulosK.Plugin` | Sample/learning endpoints | `dotnet build OIM/Plugins/StathopoulosK.Plugin/StathopoulosK.CompositionApi.Server.Plugin.sln` |

Reference: [`Docs/Architecture.md`](Docs/Architecture.md) | Boilerplate: [`OIM/Templates/v1/`](OIM/Templates/v1/)

---

## Development Workflow

```
1. Scaffold      /oim-plugin MyPlugin            → creates project structure
2. Add endpoints /oim-endpoint ClassName route    → or /oim-bulk Feature
3. Build         dotnet build OIM/Plugins/MyPlugin/MyPlugin.sln
4. Review        /oim-review OIM/Plugins/MyPlugin/
5. Deploy        copy .dll to OIM API Server plugin dir → restart API Server
6. Release notes /oim-deploy MyPlugin 1.0
7. Commit        /git-commit-push
```

---

## Skills (invoke with `/skill-name`)

| Category | Skills |
|---|---|
| **Generate C#** | `/oim-endpoint`, `/oim-plugin`, `/oim-bulk` |
| **Generate other code** | `/oim-vbnet`, `/oim-posh`, `/oim-process`, `/oim-testassist` |
| **Query & data** | `/oim-query-builder`, `/oim-db-structure`, `/oim-discover` |
| **Review & deploy** | `/oim-review`, `/oim-deploy`, `/oim-troubleshoot` |
| **KB management** | `/kb-import`, `/oim-academy-search`, `/intragen-guide`, `/intragen-presentation` |
| **DevOps** | `/git-commit-push`, `/gdrive-sync` |

Full skills reference: [`_meta/SKILLS_GUIDE.md`](_meta/SKILLS_GUIDE.md)

---

## PowerShell OIM Export Tool

```powershell
cd OIM\PowerShell\OIM_ExportTool\src
.\MainPsModule.ps1 -ZipPath "C:\path\to\export.zip"
```
Config: `src\config.json` | Docs: [`OIM/PowerShell/OIM_ExportTool/docs/`](OIM/PowerShell/OIM_ExportTool/docs/)

---

## SQL Query Library

23 scripts across 9 categories. See [`OIM/SQL/INDEX.md`](OIM/SQL/INDEX.md) for per-script detail.

| Category | Scripts | Purpose |
|---|---|---|
| Membership | 9 | AD, AAD, business/app/system roles, manager chain, dynamic groups |
| Queue | 6 | Job queue health, DB queue, history — ClearQueue is **DESTRUCTIVE** |
| Attestation | 5 | Open cases, runs, decisions, policies |
| BAS | 4 | ESet↔AccProduct mappings, role mappings |
| Sampling | 4 | Row counts, orphaned objects, sync gaps |
| Compliance | 2 | SOD violations, risk index |
| ITShop | 2 | Pending requests, approval history |
| Sync | 2 | Sync configs, run journal |
| _Scratch | 4 | Unverified exploratory queries |

---

## OIM Academy Content

- **Raw source** (read-only): [`Academy/`](Academy/) — 1,280 files, 18 exercise modules (005–024)
- **Curated training**: [`Learning/Training/SDK_Samples/`](Learning/Training/SDK_Samples/) — 58 C# CompositionAPI samples
- **Reference implementations**: [`Learning/Training/Reference_Implementations/`](Learning/Training/Reference_Implementations/)
- **Module guides**: [`Learning/Mentoring/index.html`](Learning/Mentoring/index.html) — 18 Intragen-branded HTML guides

Adding new content: [`_meta/IMPORT_GUIDE.md`](_meta/IMPORT_GUIDE.md)
