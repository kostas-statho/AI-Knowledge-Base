# Knowledge Base — Master Index

> One-liner per section. Update this file whenever a folder is added or removed.
> Last updated: 2026-04-01

---

## OIM/ — OIM Runtime Code

| Area | Path | Description |
|---|---|---|
| C# Plugins | `OIM/Plugins/CCC_BulkActions/` | Production: bulk CSV import (InsertIdentities, addEntitlement, removeEntitlement) |
| C# Plugins | `OIM/Plugins/DataExplorerEndpoints/` | Production: attestation approval, membership removal, data updates |
| C# Plugins | `OIM/Plugins/StathopoulosK.Plugin/` | Learning: API exercise implementations |
| SQL Attestation | `OIM/SQL/Attestation/` | Open cases, runs, decisions, policies (5 queries) |
| SQL BAS | `OIM/SQL/BAS/` | ESet↔AccProduct mappings, role mappings (4 queries) |
| SQL Compliance | `OIM/SQL/Compliance/` | Risk index, SOD violations (2 queries) |
| SQL ITShop | `OIM/SQL/ITShop/` | PersonWantsOrg requests, approval history (2 queries) |
| SQL Membership | `OIM/SQL/Membership/` | AD, AAD, business/app/system roles, manager chain, team roles (9 queries) |
| SQL Queue | `OIM/SQL/Queue/` | Job queue health, DB queue, job history, process chain — ClearQueue is DESTRUCTIVE (8 queries) |
| SQL Sampling | `OIM/SQL/Sampling/` | Row counts, orphaned accounts, persons without AD, config params (5 queries) |
| SQL Sync | `OIM/SQL/Sync/` | Sync configs, run journal (2 queries) |
| SQL _Scratch | `OIM/SQL/_Scratch/` | Unverified/exploratory — promote to category when verified |
| VB.NET Scripts | `OIM/VBNet/` | VB.NET script samples in 12 categories |
| PowerShell Export | `OIM/PowerShell/OIM_ExportTool/` | DM Export Tool — MainPsModule.ps1, config.json |
| PowerShell Connector | `OIM/PowerShell/Connector/` | PS Connector scripts |
| Automation Python | `OIM/Automation/GUI/python/` | pywinauto scripts: oim_find, oim_inspect, oim_launchpad, oim_designer, oim_db_discover |
| Automation Data | `OIM/Automation/GUI/data/` | Generated artifacts: menu maps, tree dumps, GUI structures, SESSION_HANDOFF.md |
| Automation Window | `OIM/Automation/Window/` | PowerShell P/Invoke window scripts (capture, nav, extract) |
| C# Templates | `OIM/Templates/v1/` | Boilerplate: oim_endpoint.cs, oim_plugin_entry.cs, oim_plugin.csproj, bulk action 4-pack |
| TestAssist | `OIM/TestAssist/` | Pester/Gherkin test framework (from Academy/024_004) |

---

## Docs/ — Reference Documentation

| File | Description |
|---|---|
| `Docs/Architecture.md` | Plugin registration, session helpers, common pitfalls |
| `Docs/Comparison.md` | Live plugins vs Academy reference — known gaps |
| `Docs/Tables.md` | 50 most-used OIM tables with key columns and row counts |
| `Docs/SQL_Optimization_Rules.md` | SARGability, index design, joins, parameter sniffing, OIM traps |
| `Docs/OIM_93_Training_Documentation.html` | OIM 9.3 training reference (Intragen branded) |
| `Docs/AAD_NoMailbox_MailTemplates_Intragen.html` | AAD No-Mailbox mail template creation guide |
| `Docs/index.html` | ACL Recovery PWA (installable, offline) |

---

## Academy/ — Raw Training Source (1,280 files, do not modify)

| Area | Path | Description |
|---|---|---|
| Exercises | `Academy/Excercises/` | 18 modules (005–024): .docx, PDF, code, CSV files |
| VB.NET Samples | `Academy/ScriptSamples/` | 12-category VB script library |
| SharePoint Samples | `Academy/SharePoint_ScriptSamples/` | SharePoint-specific VB scripts |
| Presentations | `Academy/Presentations/` | .pptx training presentations |
| AI Training | `Academy/AI training/` | n8n MCP server guides |
| DM Tool | `Academy/DM_tool/` | Deployment Manager files |

---

## Learning/ — All Educational Content

| Area | Path | Description |
|---|---|---|
| SDK Samples | `Learning/Training/SDK_Samples/` | 58 C# CompositionAPI samples (Sdk01–Sdk07 + docs) |
| Reference Impls | `Learning/Training/Reference_Implementations/` | BulkActions_Ref (5 groups), DataExplorer_Ref (8 files), API_Exercises, VBNet |
| Exercises | `Learning/Training/Exercises/` | 18 Markdown summaries of Academy exercise modules |
| PS Training | `Learning/Training/PowerShell/` | AllInOne_Final.ps1, PS connector scripts |
| Mentoring Portal | `Learning/Mentoring/index.html` | HTML nav portal (entry point for all 18 guides) |
| Mentoring Guides | `Learning/Mentoring/guides/` | 18 HTML guides (module_005 through module_024) |
| Mentoring Presentations | `Learning/Mentoring/presentations/` | 18 HTML presentations |
| Registry | `Learning/Mentoring/INDEX.md` | Module table with links |
| Guide — AAD No-Mailbox | `Learning/Guides/AAD_NoMailbox/` | Complete — 6 files (impl guide, bare min, 3 process chains, mail templates guide) |
| Guide — Control3 AD Group Audit | `Learning/Guides/Control3_ADGroup_Audit/` | New — audit_guide.html |
| Guide — O3 Mailbox Conversion | `Learning/Guides/O3EMailbox_Conversion/` | New — o3emailbox_conversion_impl_guide.html |
| Shared resources | `Learning/Guides/resources/` | alert_html_body.html, escalation_html_body.html |

---

## Tools/ — Personal & Productivity Tools

| Tool | Path | Description |
|---|---|---|
| IntragenAssistant | `Tools/IntragenAssistant/` | 4-tab OIM assistant: Goals, Query Evaluator, Presentations, Doc Builder |
| ChatAssistant | `Tools/ChatAssistant/` | GPT-4o WinForms OIM Q&A (KB context loaded as system prompt) |
| ChatBox | `Tools/ChatBox/` | General-purpose AI chat panel (PowerShell WinForms) |
| GoalSetter | `Tools/GoalSetter/` | 5-tab goal planning tool with 1-on-1 meeting support |
| Office Productivity | `Tools/Office_Productivity/` | VBA macros, VB.NET library, Graph API, MCP server |

---

## _meta/ — KB Infrastructure

| File | Purpose |
|---|---|
| `_meta/db_discovery.md` | Live OIM DB schema — 691 tables, 11,620 columns (regenerate with `/oim-db-structure`) |
| `_meta/IMPORT_GUIDE.md` | Step-by-step intake for every content type |
| `_meta/SKILLS_GUIDE.md` | All skills with token cost and use cases |
| `_meta/CONVENTIONS.md` | Naming rules, metadata header formats |

---

## Archive/ — Deprecated Content

| Item | Notes |
|---|---|
| `Archive/OneIdentityManager9.3/` | 1.2 GB OIM SDK backup — gitignored, local only |
| `Archive/OIM_93_Manuals/` | 86 official One Identity 9.3 PDF manuals |
| `OneIdentityManager9.3.zip` (root) | 965 MB zip — gitignored, local only |

---

## Other Root Content

| File | Purpose |
|---|---|
| `CLAUDE.md` | Claude Code instructions for this KB |
| `README.md` | Human quick-start guide |
| `.claude/` | Project skills, hooks, settings |
