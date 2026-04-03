---
name: kb-import
description: Validate metadata headers and intake new content into the Knowledge Base, then auto-generate the INDEX.md entry. Use before adding any new file to the KB.
argument-hint: "<file-path> [<content-type>]"
user-invocable: true
allowed-tools: "Read, Write, Glob, Grep"
---

Validate and intake new content into the Knowledge Base. Ensures consistent metadata headers and keeps INDEX.md up to date.

## Content type auto-detection

If `<content-type>` is not provided, infer it from the file extension and path:

| Extension / Path | Content type |
|---|---|
| `.cs` in `OIM/Plugins/` | C# plugin file |
| `.sql` | SQL query |
| `.vb` in `OIM/VBNet/` | VB.NET script |
| `.ps1` | PowerShell script |
| `.py` | Python automation |
| `.md` | Markdown guide or documentation |
| `.html` in `Learning/Mentoring/` | Mentor guide or presentation |
| `.html` elsewhere | Documentation page |

## Step 1 — Read the file

Read the first 30 lines to check for an existing metadata header.

## Step 2 — Validate or generate metadata header

### SQL header

```sql
-- Purpose:  <one-line description>
-- Tables:   <comma-separated table names>
-- Category: Attestation|BAS|Compliance|ITShop|Membership|Queue|Sampling|Sync|Reports|_Scratch
-- Status:   Verified|Exploratory
-- OIM-Ver:  9.3
-- Added:    <YYYY-MM-DD>
```

### C# plugin file header

```csharp
// Plugin:   <plugin name, e.g. CCC_BulkActions>
// Endpoint: <route, e.g. webportalplus/myfeature/action>
// Role:     Entry|Endpoint|BulkStart|BulkValidate|BulkAction|BulkEnd|Reference
// Status:   Production|Learning|Academy-Ref
// OIM-Ver:  9.3
// Added:    <YYYY-MM-DD>
```

### VB.NET script header

```vbnet
' Purpose:  <one-line description>
' Category: <from 12 VBNet categories>
' OIM-Ver:  9.3
' Added:    <YYYY-MM-DD>
```

### PowerShell / Python header

```powershell
# Script:  <filename>
# Purpose: <one-line description>
# Target:  Designer|Manager|Launchpad|JobQueue|Window|Admin|Connector
# Type:    GUI-automation|Window-capture|CLI|Admin
# Added:   <YYYY-MM-DD>
```

### Markdown / HTML guide

```yaml
---
title: "<title>"
category: Architecture|Comparison|Exercise|Implementation|Reference
scenario: "<scenario name if applicable>"
status: Draft|Review|Complete
oim_ver: "9.3"
added: "<YYYY-MM-DD>"
---
```

If the header is missing or incomplete, **add it** at the top of the file.

## Step 3 — Suggest destination path

Based on content type, recommend the correct destination path from CONVENTIONS.md:

| Content Type | Destination |
|---|---|
| New C# plugin | `OIM/Plugins/PluginName/` |
| New SQL (verified) | `OIM/SQL/<Category>/` |
| New SQL (exploratory) | `OIM/SQL/_Scratch/YYYY-MM-DD_topic.sql` |
| New VB.NET script | `OIM/VBNet/NN_Category/` |
| New implementation guide | `Learning/Guides/ScenarioName/` |
| New Academy module | `Learning/Mentoring/guides/` + `presentations/` |
| Generated artifact | `OIM/Automation/GUI/data/` |

## Step 4 — Generate INDEX.md entry

Produce one line for the relevant section INDEX.md (e.g. `OIM/SQL/INDEX.md`) and one line for the root `INDEX.md`:

```
- [filename.sql](OIM/SQL/Category/filename.sql) — <one-line purpose>
```

For root `INDEX.md`, find the matching section (e.g. `OIM/SQL/Membership/`) and insert the new row.

## Step 5 — Output

Print:
1. The metadata header to add (if missing)
2. The recommended destination path
3. The INDEX.md line(s) to add
4. Reminder: run `/git-commit-push` after adding the content

Do NOT move or write files without user confirmation — this skill is advisory.
