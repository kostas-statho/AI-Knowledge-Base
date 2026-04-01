# KB Conventions

---

## File Naming

| Type | Convention | Example |
|---|---|---|
| SQL | `PascalCase_With_Underscores.sql` | `BusinessRole_Membership.sql` |
| SQL (scratch) | `YYYY-MM-DD_topic.sql` | `2026-03-30_joiner_query.sql` |
| C# (plugin) | OIM naming convention | `CCCFeatureAction.cs` |
| VB.NET | `description_verb.vb` | `create_person_template.vb` |
| Python | `oim_purpose.py` (snake_case) | `oim_designer.py` |
| PowerShell | `Verb-Object.ps1` or `action_target.ps1` | `capture_window.ps1` |
| Markdown guides | `Module_NNN_ShortName.md` | `Module_005_BAS.md` |
| HTML guides | `module_NNN_guide.html` | `module_017_api_guide.html` |
| HTML presentations | `module_NNN_presentation.html` | `module_017_api_presentation.html` |

---

## Metadata Headers (required on every new file)

### SQL
```sql
-- Purpose  : <one-line description>
-- Tables   : <comma-separated table names>
-- Category : Attestation|BAS|Compliance|ITShop|Membership|Queue|Sampling|Sync|Reports|_Scratch
-- Status   : Verified|Exploratory
-- OIM-Ver  : 9.3
-- Added    : YYYY-MM-DD
```

### C#
```csharp
// Plugin   : <plugin name>
// Endpoint : <route path>
// Role     : Entry|Endpoint|BulkStart|BulkValidate|BulkAction|BulkEnd|Reference
// Status   : Production|Learning|Academy-Ref
// OIM-Ver  : 9.3
// Added    : YYYY-MM-DD
```

### VB.NET
```vb
' Purpose  : <one-line description>
' Category : Common|Database|Objects|Templates|Processes|Files|Expert|ITShop|COM|SpecialCases|PowerShell|WebService
' OIM-Ver  : 9.3
' Added    : YYYY-MM-DD
```

### Python/PowerShell automation
```python
# Script  : <filename>
# Purpose : <one-line description>
# Target  : Designer|Manager|Launchpad|JobQueue|Window
# Type    : GUI-automation|Window-capture|CLI
# Added   : YYYY-MM-DD
```

### Markdown doc
```markdown
---
title: <title>
category: Architecture|Comparison|Exercise|Implementation|Reference
scenario: <optional — e.g. AAD_NoMailbox>
status: Draft|Review|Complete
oim_ver: "9.3"
added: YYYY-MM-DD
---
```

---

## C# Plugin Conventions (CRITICAL)

1. `ConfigureAwait(false)` on **every** `await` — plugins are library code (prevents deadlocks)
2. Use `$"text\nnewline"` — never `string.Format` for strings with `\n`
3. Every endpoint class: `IApiProviderFor<PortalApiProject>, IApiProvider`
4. Entry point file: `[assembly: Module("CCC")]`
5. All DB writes inside `qr.Session.StartUnitOfWork()` → `u.PutAsync()` → `u.CommitAsync()`
6. Always check `.Success` after `TryGetAsync()`
7. DLLs via HintPath (not NuGet): `C:\Program Files\One Identity\One Identity Manager\`
8. AssemblyName must end in `.CompositionApi.Server.Plugin`

---

## SQL Conventions

- All SQL scripts are **reference/ad-hoc**, not production migrations
- Always add metadata header (see above)
- Use `WITH (NOLOCK)` for read-only diagnostic queries
- Use `YYYY-MM-DD_topic.sql` naming in `_Scratch/` until verified
- XOrigin bitfield: `1`=direct, `2`=inherited, `4`=dynamic, `8`=requested

---

## Index Maintenance

After adding any file:
1. Add entry to the section-specific `INDEX.md` (e.g. `OIM/SQL/INDEX.md`)
2. Add or update the row in root `INDEX.md`
3. If creating a new section/folder, add it to root `INDEX.md` under the correct heading

---

## Versioning

- Templates use `v1/`, `v2/` subfolders — never overwrite a version
- When OIM SDK changes require template updates, create `v2/` alongside `v1/`
- Stale versions are kept in place; `_meta/SKILLS_GUIDE.md` tracks which version is current
