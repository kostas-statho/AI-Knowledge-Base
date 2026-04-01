# Skills Quick Reference

> Always prefer a skill over reading files manually — each skill saves 1,000–5,000 tokens.
> Invoke with `/project:<skill-name>` or `/<skill-name>` in Claude Code.

---

## Scaffold / Generate Code

| Command | When to Use | Output | Token Saving |
|---|---|---|---|
| `/oim-endpoint` | Add 1 new REST endpoint to an existing plugin | `.cs` file | Avoids reading Templates/v1/ + Architecture.md |
| `/oim-plugin` | Start a brand-new plugin project | `.cs` + `.csproj` + `.sln` | Avoids reading full plugin entry point pattern |
| `/oim-bulk` | Implement a full 4-endpoint bulk CSV feature | 4 `.cs` files | Avoids reading all 4 bulk action templates |
| `/oim-vbnet` | Generate a VB.NET OIM script from plain English | `.vb` snippet | Avoids reading 121 VBNet sample files |
| `/oim-posh` | Generate PowerShell using IdentityManager.PoSh (New/Get/Set/Remove-Entity) | `.ps1` | Avoids reading PoSh module documentation |
| `/oim-process` | Generate an OIM process chain definition | XML + description | Avoids reading Academy/007-Processes/ exercises |
| `/oim-testassist` | Generate a Pester test stub or Gherkin feature file | `.tests.ps1` or `.feature` | Avoids reading TestAssist framework docs |

---

## Query & Data

| Command | When to Use | Output | Token Saving |
|---|---|---|---|
| `/oim-query-builder` | Need SQL for any OIM scenario | Verified `.sql` | Avoids reading SQL/Category/ files to find a template |
| `/oim-db-structure` | Refresh live DB schema after schema changes | `_meta/db_discovery.md` | Avoids manual oim_db_discover.py execution |
| `/oim-discover` | Screenshot active OIM GUI window and extract config | Structured config data | Avoids manual screenshot + typing |

---

## Review & Deploy

| Command | When to Use | Output | Token Saving |
|---|---|---|---|
| `/oim-review` | Before deployment or after major changes | Audit report | Avoids mentally checking all conventions |
| `/oim-deploy` | Plugin is code-complete and ready to ship | Deployment checklist + release notes | Avoids writing checklist from scratch |
| `/oim-troubleshoot` | Something is broken in OIM — what to check | Diagnostic checklist by symptom | Avoids searching community forum |

---

## Knowledge Base

| Command | When to Use | Output | Token Saving |
|---|---|---|---|
| `/kb-import` | Adding any new content to the KB | Validates metadata, suggests INDEX entry | Avoids manual index maintenance |
| `/oim-academy-search` | Need a specific exercise or code sample | File paths + summaries | Avoids loading 1,280 Academy files |
| `/intragen-guide` | New OIM Academy module guide needed | HTML guide (Learning/Mentoring/guides/) | Avoids reading 18 existing guides to match style |
| `/intragen-presentation` | New OIM Academy presentation needed | HTML presentation (Learning/Mentoring/presentations/) | Avoids reading 18 existing presentations |
| `/intragen-test` | Verify IntragenAssistant is ready to launch (automated) | 15-test pass/fail report + per-test fix steps | Avoids manual pre-flight checks across 5 config areas |
| `/create-notion-documentation` | Convert docs to Notion-ready format | CSV databases + Markdown pages | Avoids manual Notion formatting |

---

## DevOps

| Command | When to Use | Output | Token Saving |
|---|---|---|---|
| `/git-commit-push` | Stage, commit (conventional message), push to GitHub | Git commit + push | Avoids git syntax lookup |
| `/gdrive-sync` | Sync repo to Google Drive via rclone | rclone transfer | Avoids rclone syntax lookup |

---

## When NOT to Use a Skill

- Reading a specific known file → use `Read` tool directly (faster)
- Simple one-liner edits → edit directly without scaffolding
- Quick SQL lookups → read `OIM/SQL/INDEX.md` first; only use `/oim-query-builder` if no existing query fits

---

## Skills Update Log

| Skill | Last Verified | Notes |
|---|---|---|
| oim-endpoint | 2026-03-30 | Template path: `OIM/Templates/v1/oim_endpoint.cs` |
| oim-plugin | 2026-03-30 | Template path: `OIM/Templates/v1/oim_plugin_entry.cs` |
| oim-bulk | 2026-03-30 | Template path: `OIM/Templates/v1/oim_bulk_action/` |
| oim-query-builder | 2026-03-30 | SQL library: `OIM/SQL/` |
| oim-db-structure | 2026-03-30 | Output: `_meta/db_discovery.md` (was Implementation_Guides/resources/) |
| intragen-guide | 2026-04-01 | Output: `Learning/Mentoring/guides/` (was Mentoring_Documentation/guides/) |
| intragen-presentation | 2026-04-01 | Output: `Learning/Mentoring/presentations/` (was Mentoring_Documentation/presentations/) |
| intragen-test | 2026-04-02 | Script: `Tools/IntragenAssistant/Test-IntragenAssistant.ps1` — 15 tests, 5 groups, -SkipApi flag |
