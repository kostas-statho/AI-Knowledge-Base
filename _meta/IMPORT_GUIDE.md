# KB Import Guide

> Follow this guide whenever adding new content. Run `/kb-import` skill to validate.

---

## Universal Intake Checklist

1. Identify content type → find correct destination (table below)
2. Add metadata header to the file
3. Add an entry to the relevant `INDEX.md`
4. Update root `INDEX.md` if a new folder was created
5. Commit: `/git-commit-push`

---

## Destinations by Content Type

| Content Type | Destination | Index to Update |
|---|---|---|
| New C# plugin project | `OIM/Plugins/PluginName/` | Root INDEX + CLAUDE.md plugin table |
| New endpoint (existing plugin) | `OIM/Plugins/ExistingPlugin/` | Root INDEX |
| New SQL — verified | `OIM/SQL/Category/DescriptiveName.sql` | `OIM/SQL/INDEX.md` |
| New SQL — exploratory | `OIM/SQL/_Scratch/YYYY-MM-DD_topic.sql` | None (promote when verified) |
| New VB.NET script | `OIM/VBNet/NN_Category/` | `OIM/VBNet/INDEX.md` |
| New PowerShell (admin) | `OIM/PowerShell/Admin/` | `OIM/Automation/README.md` |
| New Python automation | `OIM/Automation/GUI/python/` | `OIM/Automation/README.md` |
| New PowerShell window script | `OIM/Automation/Window/` | `OIM/Automation/README.md` |
| Generated artifact (menu map, tree dump) | `OIM/Automation/GUI/data/` | None |
| Refreshed DB schema | `_meta/db_discovery.md` | None (auto by `/oim-db-structure`) |
| New implementation guide | `Learning/Guides/ScenarioName/` | `Learning/Guides/INDEX.md` |
| New Academy module guide | `Learning/Mentoring/guides/module_NNN_guide.html` | `Learning/Mentoring/INDEX.md` + `Learning/Mentoring/index.html` |
| New Academy presentation | `Learning/Mentoring/presentations/module_NNN_*.html` | `Learning/Mentoring/INDEX.md` |
| New SDK sample | `Learning/Training/SDK_Samples/SdkNN_Name/` | `Learning/Training/INDEX.md` |
| New reference implementation | `Learning/Training/Reference_Implementations/Feature_Ref/` | `Learning/Training/INDEX.md` |
| New exercise summary | `Learning/Training/Exercises/Module_NNN_Name.md` | `Learning/Training/INDEX.md` |
| Personal notes | `Personal/Notes/` | Not indexed (gitignored) |

---

## Metadata Header Formats

### SQL
```sql
-- Purpose  : one-line description
-- Tables   : comma-separated table names
-- Category : Attestation|BAS|Compliance|ITShop|Membership|Queue|Sampling|Sync|Reports|_Scratch
-- Status   : Verified|Exploratory
-- OIM-Ver  : 9.3
-- Added    : YYYY-MM-DD
```

### C# (plugin or reference implementation)
```csharp
// Plugin   : plugin name
// Endpoint : route path (e.g. webportalplus/feature/action)
// Role     : Entry|Endpoint|BulkStart|BulkValidate|BulkAction|BulkEnd|Reference
// Status   : Production|Learning|Academy-Ref
// OIM-Ver  : 9.3
// Added    : YYYY-MM-DD
```

### VB.NET script
```vb
' Purpose  : one-line description
' Category : Common|Database|Objects|Templates|Processes|Files|Expert|ITShop|COM|SpecialCases|PowerShell|WebService
' OIM-Ver  : 9.3
' Added    : YYYY-MM-DD
```

### Python/PowerShell automation script
```python
# Script  : filename.py
# Purpose : one-line description
# Target  : Designer|Manager|Launchpad|JobQueue|Window
# Type    : GUI-automation|Window-capture|CLI
# Added   : YYYY-MM-DD
```

### Markdown guide/doc
```markdown
---
title: Guide Title
category: Architecture|Comparison|Exercise|Implementation|Reference
scenario: (optional, e.g. AAD_NoMailbox)
status: Draft|Review|Complete
oim_ver: "9.3"
added: YYYY-MM-DD
---
```

### HTML implementation guide
```html
<!-- Guide    : title
     Scenario : scenario key (e.g. AAD_NoMailbox)
     Status   : Draft|Review|Complete
     OIM-Ver  : 9.3
     Added    : YYYY-MM-DD
-->
```

---

## Promoting a _Scratch SQL Query

1. Verify query works against live DB
2. Add metadata header with `Status: Verified`
3. Rename from `YYYY-MM-DD_topic.sql` to a descriptive name
4. Move from `OIM/SQL/_Scratch/` to the correct category folder
5. Add to `OIM/SQL/INDEX.md`

---

## New Scenario (Implementation Guide)

1. Create `Learning/Guides/ScenarioName/` folder
2. Put all scenario files in it (HTML guides, Markdown docs)
3. Put shared HTML fragments in `Learning/Guides/resources/`
4. Add row to `Learning/Guides/INDEX.md`
5. Add row to root `INDEX.md`

---

## Naming Conventions

- SQL: `PascalCase.sql` (e.g. `BusinessRole_Membership.sql`)
- C#: follows OIM naming (e.g. `CCCFeatureAction.cs`)
- VB.NET: `NN_Category/description.vb`
- Python scripts: `oim_purpose.py` (snake_case)
- PowerShell scripts: `Verb-Action.ps1` (PascalCase)
- Markdown: `Module_NNN_ShortName.md` for exercises
- HTML guides: `module_NNN_guide.html` / `module_NNN_presentation.html`
