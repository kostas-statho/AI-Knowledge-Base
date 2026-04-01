# Knowledge_Base — Claude Code Instructions

> Supplements `C:\Users\OneIM\CLAUDE.md`. Read both. This file adds KB-specific detail.

## Repo Map

```
OIM/                   OIM runtime code (Plugins, SQL, VBNet, PowerShell, Automation, Templates, TestAssist)
  Plugins/             3 C# CompositionAPI plugins (.NET 8)
  SQL/                 Query library across 9 categories + _Scratch/
  VBNet/               VB.NET OIM script samples (12 categories)
  PowerShell/          OIM_ExportTool/ + Connector/ + Admin/
  Automation/          GUI/python/ (pywinauto) + GUI/data/ (artifacts) + Window/ (PS scripts)
  Templates/v1/        C# boilerplate: oim_endpoint.cs, oim_plugin_entry.cs, oim_plugin.csproj, bulk action 4-pack
  TestAssist/          Pester/Gherkin test framework
Docs/                  All reference documentation: Architecture.md, Comparison.md, Tables.md, SQL_Optimization_Rules.md, OIM training HTML
Learning/              All educational content
  Training/            Curated: SDK_Samples/ (58 C#) + Reference_Implementations/ + Exercises/ (18 summaries)
  Mentoring/           18 OIM Academy HTML guides + presentations (Intragen branded) + INDEX.md
  Guides/              Scenario implementation guides: AAD_NoMailbox/ + Control3_ADGroup_Audit/ + O3EMailbox_Conversion/
Tools/                 All personal tools: IntragenAssistant/ + ChatAssistant/ + ChatBox/ + GoalSetter/ + Office_Productivity/
Academy/               Raw training source — 1,280 files. READ-ONLY. Use /oim-academy-search to find content.
_meta/                 KB infrastructure: db_discovery.md, IMPORT_GUIDE.md, SKILLS_GUIDE.md, CONVENTIONS.md
Personal/              Local only (.gitignored) — notes, snippets, scratch
Archive/               OneIdentityManager9.3/ SDK backup (gitignored) + OIM_93_Manuals/ (86 PDFs)
INDEX.md               Master registry — one-liner per section, auto-updated
```

## Token-First: Always Use a Skill Before Reading Files

| Task | Skill | What it saves |
|---|---|---|
| Write C# endpoint | `/oim-endpoint` or `/oim-bulk` | Reading Templates/v1/ + Architecture.md |
| Write SQL | `/oim-query-builder` | Reading OIM/SQL/ files |
| Evaluate SQL query | `/oim-query-evaluation` | Reading SQL_Optimization_Rules.md manually |
| Write VB.NET | `/oim-vbnet` | Reading OIM/VBNet/ samples |
| Write PowerShell | `/oim-posh` | Reading PoSh module docs |
| Find Academy exercise | `/oim-academy-search` | Loading 1,280 Academy/ files |
| Diagnose OIM issue | `/oim-troubleshoot` | Searching community forum |
| Add new content | `/kb-import` | Manual INDEX.md maintenance |
| Refresh DB schema | `/oim-db-structure` | Running oim_db_discover.py manually |
| Review code | `/oim-review` | Mentally checking all conventions |
| Deploy plugin | `/oim-deploy` | Writing checklist from scratch |
| New module guide | `/intragen-guide` | Reading 18 guides in Learning/Mentoring/guides/ |
| New module presentation | `/intragen-presentation` | Reading 18 presentations in Learning/Mentoring/ |
| New module doc (HTML) | `/intragen-doc` | Reading existing doc style + templates |
| Validate IntragenAssistant (automated) | `/intragen-test` | Automated 15-test pre-flight + per-test fix guidance |
| Validate IntragenAssistant (manual) | `/intragen-validate` | Manual tab-by-tab walkthrough with sample data |

## C# Plugins — Quick Reference

**DLL path:** `C:\Program Files\One Identity\One Identity Manager\`
**Namespace:** `QBM.CompositionApi`
**URL prefix:** `webportalplus/`

| Plugin | Key Endpoints | Build Command |
|---|---|---|
| `CCC_BulkActions` | InsertIdentities, addEntitlement, removeEntitlement | `dotnet build OIM/Plugins/CCC_BulkActions/CCC_BulkActions.sln` |
| `DataExplorerEndpoints` | approveattestation, removemembership, removeallmemberships, updateMainData | `dotnet build OIM/Plugins/DataExplorerEndpoints/DataExplorerEndpoints.sln` |
| `StathopoulosK.Plugin` | Sample/learning endpoints | `dotnet build OIM/Plugins/StathopoulosK.Plugin/StathopoulosK.CompositionApi.Server.Plugin.sln` |

**Plugin entry point pattern:**
```csharp
[assembly: Module("CCC")]
public class CustomApiPlugin : IPlugInMethodSetProvider {
    public IMethodSetProvider Build(IResolve resolver) => new MyCCCPlugin(resolver);
}
public class MyCCCPlugin : IMethodSetProvider {
    private readonly MethodSet _project;
    public MyCCCPlugin(IResolve resolver) {
        _project = new MethodSet { AppId = "MyPlugin" };
        var svc = resolver.Resolve<IExtensibilityService>();
        _project.Configure(resolver, svc.FindAttributeBasedApiProviders<MyCCCPlugin>());
        _project.SessionConfig = new Session.SessionAuthDbConfig {
            AuthenticationType = Config.AuthType.AllManualModules
        };
    }
    public Task<IEnumerable<IMethodSet>> GetMethodSetsAsync(CancellationToken ct = default)
        => Task.FromResult<IEnumerable<IMethodSet>>(new[] { _project });
}
```

**Bulk action lifecycle (4-endpoint contract):**
`/startaction` → `/validate` (per row) → `/action` (per row) → `/endaction`

## Key C# Conventions

- `ConfigureAwait(false)` on **every** await — plugins are library code
- `$"text {var}\nnewline"` — use interpolation, NOT `string.Format` for strings with `\n`
- `IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>` on every endpoint class
- `[assembly: Module("CCC")]` at the top of the entry point file
- All writes inside `StartUnitOfWork()` → `PutAsync()` → `CommitAsync()`
- Always check `.Success` after `TryGetAsync()`

## PowerShell Export Tool

```powershell
cd OIM\PowerShell\OIM_ExportTool\src
.\MainPsModule.ps1 -ZipPath "C:\path\to\export.zip"
```
Config: `src\config.json` | Log: 7-day NLog rolling | PS 5.1 compatible

## SQL Guidelines

Scripts in `OIM/SQL/` are reference/ad-hoc queries, not production migrations.
- Add metadata header: purpose, tables, category, status, OIM version, date (see `_meta/CONVENTIONS.md`)
- New exploratory queries → `OIM/SQL/_Scratch/YYYY-MM-DD_topic.sql`
- Promote to category folder after verifying against live DB
- Full schema: `_meta/db_discovery.md` | Top-50 table reference: `Docs/Tables.md`
- Optimization rules (SARGability, joins, parameter sniffing, OIM-specific traps): `Docs/SQL_Optimization_Rules.md`
- Use `/oim-query-evaluation` to score any query across 7 dimensions before sharing

## Automation Scripts

Python GUI automation: `OIM/Automation/GUI/python/` — pywinauto scripts (Designer, Manager, Launchpad)
PowerShell window scripts: `OIM/Automation/Window/` — P/Invoke window capture, nav tree extraction
Generated artifacts: `OIM/Automation/GUI/data/` — menu maps, tree dumps, session handoffs
**Resume OIM Python automation:** read `OIM/Automation/GUI/data/SESSION_HANDOFF.md`

## Training Reference Paths

- Academy reference implementations: `Learning/Training/Reference_Implementations/BulkActions_Ref/`, `Learning/Training/Reference_Implementations/DataExplorer_Ref/`
- SDK samples: `Learning/Training/SDK_Samples/Sdk01_Basics/` through `Learning/Training/SDK_Samples/Sdk07_Services/`
- These are the **source of truth** when live plugins diverge from Academy spec

## Import Workflow (quick reference)

See `_meta/IMPORT_GUIDE.md` for full detail. Quick table:

| Content Type | Destination |
|---|---|
| New C# plugin | `OIM/Plugins/PluginName/` |
| New SQL (verified) | `OIM/SQL/Category/` |
| New SQL (exploratory) | `OIM/SQL/_Scratch/YYYY-MM-DD_topic.sql` |
| New VB.NET script | `OIM/VBNet/NN_Category/` |
| New implementation guide | `Learning/Guides/ScenarioName/` |
| New Academy module | `Learning/Mentoring/guides/` + `Learning/Mentoring/presentations/` |
| Generated artifact | `OIM/Automation/GUI/data/` |

After every import: update the relevant `INDEX.md` → run `/git-commit-push`

## Do Not Touch

- `Archive/OneIdentityManager9.3/` — OIM 9.3 SDK backup, 1.2 GB, gitignored
- `Tools/Office_Productivity/src/McpServer/` — compiled MCP server binaries
- `~/.claude/commands/intragen-*.md` — user-level skills, do not move to project level
- `Academy/` — raw source archive, read-only

## All Skills (this project)

| Skill | Use When |
|---|---|
| `oim-endpoint` | Adding a single new REST endpoint |
| `oim-plugin` | Starting a brand new plugin project |
| `oim-bulk` | Implementing a full 4-endpoint bulk CSV feature |
| `oim-review` | Auditing a plugin file for best practices |
| `oim-deploy` | Generating deployment checklist + release notes |
| `oim-query-builder` | Generating SQL from plain-English description |
| `oim-db-structure` | Fetch live OIM DB schema → update `_meta/db_discovery.md` |
| `oim-discover` | Screenshot active OIM GUI window, extract config |
| `oim-vbnet` | Generate VB.NET OIM script from natural language |
| `oim-posh` | Generate PowerShell using IdentityManager.PoSh module |
| `oim-troubleshoot` | Diagnose OIM issue from symptoms |
| `kb-import` | Validate + intake new content, auto-update indexes |
| `oim-academy-search` | Find relevant exercise/sample in Academy/ |
| `intragen-guide` | Create new Intragen-branded OIM Academy module guide |
| `intragen-presentation` | Create new Intragen-branded module presentation |
| `intragen-doc` | Create a new Intragen HTML documentation page |
| `intragen-test` | Automated 15-test pre-flight for IntragenAssistant — no GUI, per-test fix steps |
| `intragen-validate` | Full manual validation walkthrough for IntragenAssistant (all 4 tabs) |
| `oim-query-evaluation` | Score an OIM SQL query on 7 dimensions (Safety, SARGability, OIM Correctness, etc.) |
| `git-commit-push` | Stage, commit (conventional message), and push to GitHub |
| `gdrive-sync` | Sync repo to Google Drive via rclone (service account key) or SSH |
