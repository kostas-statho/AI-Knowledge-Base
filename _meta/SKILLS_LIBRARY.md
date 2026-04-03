# Skills Library — One Identity Manager Developer Workspace

> **claude.ai import:** Add this file as Project Knowledge in any claude.ai project to make all skills available without Claude Code CLI.  
> **Claude Code:** Skills auto-load from `.claude/skills/` and `~/.claude/commands/` — no import needed.  
> **Last updated:** 2026-04-02 | **Total skills:** 28

---

## How to use

Invoke with `/skill-name` followed by arguments. Claude will follow the skill's step-by-step instructions.

Example: `/oim-endpoint UserStatusUpdate webportalplus/user/status PUT`

---

## OIM — Scaffold / Generate Code

### `/oim-endpoint <ClassName> <route/path> [GET|POST|DELETE]`
Generate a new OIM CompositionAPI endpoint `.cs` file.  
Uses: `IApiProvider`, `IApiProviderFor<PortalApiProject>`, `ConfigureAwait(false)`, `webportalplus/` prefix.  
Output: `.cs` file in the appropriate plugin directory.

### `/oim-bulk <FeatureName> "<description>"`
Generate all 4 bulk-action endpoints (startaction, validate, action, endaction) for a CSV import feature.  
Output: 4 `.cs` files — one per endpoint in the lifecycle.

### `/oim-plugin`
Scaffold a complete new OIM CompositionAPI plugin project: entry point, first endpoint, `.csproj`, and `.sln`.  
Output: Full plugin directory structure.

### `/oim-vbnet "<description>" [<category>]`
Generate a VB.NET script for OIM Designer: process steps, mail templates, scheduled tasks, custom functions.  
Categories: Processes, MailTemplates, Schedulers, CustomFunctions, Provisioning, Attestation, ITShop, Roles, Compliance, DataQuality, Notifications, Misc.  
Output: `.vb` file in `OIM/VBNet/NN_Category/` with metadata header.

### `/oim-posh "<description>" [admin|connector|export]`
Generate a PowerShell script using the IdentityManager.PoSh module.  
Includes: Connect/Disconnect pattern, Get/New/Set/Remove-IMObject, Invoke-IMQuery, error handling.  
Output: `.ps1` file in `OIM/PowerShell/`.

### `/oim-process "<process name>" <trigger-event> [<table>]`
Generate an OIM process chain specification: steps, parameters, conditions, VB.NET scripts.  
Output: Structured spec (console) — configure manually in OIM Designer.

### `/oim-testassist <plugin-path-or-route> [--gherkin]`
Generate a Pester test stub (default) or Gherkin feature file for an OIM plugin endpoint.  
Output: `.Tests.ps1` or `.feature` in `OIM/TestAssist/`.

---

## OIM — Query & Data

### `/oim-query-builder "<plain-English description>"`
Generate a verified OIM SQL query from plain English.  
Categories: Sampling, Queue, Membership, Attestation, IT Shop, BAS, Sync, Compliance, Reports.  
Output: Console (no file writes — copy manually).

### `/oim-query-evaluation [inline SQL | file_path | query_name] [--fix]`
Score any OIM SQL query across 7 dimensions: Safety (22%), SARGability (18%), OIM Correctness (18%), Optimization (12%), Structural (15%), Academic (8%), Code Quality (7%).  
With `--fix`: also outputs a corrected query.

### `/oim-db-structure`
Fetch the live OIM database schema and update `_meta/db_discovery.md`.  
Reports: table counts, row counts, highlights key tables (691 tables, 11,620 columns).

### `/oim-discover [--screen | --clipboard | <screenshot-path>] [--save] [--doc]`
Screenshot an active OIM GUI window and extract structured configuration data.  
Supports: Designer, Manager, Job Queue, Object Browser, Web Portal, Sync History, Attestation.  
Checks 11 anti-patterns at HIGH/MEDIUM severity.

---

## OIM — Review, Deploy & Troubleshoot

### `/oim-review [file-path | directory]`
Audit an OIM CompositionAPI plugin file or directory for correctness, best practices, security, and completeness.  
Checks: ConfigureAwait, IApiProviderFor, namespace, UnitOfWork, TryGetAsync, assembly attribute, string.Format.

### `/oim-hook [<file-path>]`
Pre-commit validator for staged `.cs` files — checks 8 critical OIM C# conventions.  
Output: PASS/FAIL/WARN per convention. Blocks commit on any FAIL.

### `/oim-deploy`
Generate a deployment checklist and release notes for an OIM plugin.  
Covers: build, test, DLL copy, API Server restart, post-deploy verification.

### `/oim-troubleshoot "<symptom description>"`
Diagnose OIM issues from symptoms with a prioritized investigation checklist.  
Categories: Job Queue, Sync/Provisioning, Plugin/API, Attestation, IT Shop, Performance, Config/Crypto, Login/Auth.

---

## Knowledge Base

### `/oim-academy-search "<topic or keywords>"`
Search the 1,280-file Academy/ archive for exercises, code samples, and reference implementations.  
Also searches: `Learning/Training/SDK_Samples/`, `Reference_Implementations/`, mentor guides.  
Output: Ranked top-5 results with file paths + preview of top match.

### `/kb-import <file-path> [<content-type>]`
Validate metadata headers and intake new content into the Knowledge Base.  
Generates: correct metadata header, destination path, INDEX.md entry line.  
Content types: C# plugin, SQL, VBNet, PowerShell, Python, Markdown, HTML guide.

### `/intragen-guide <module_code> "<module_name>" <level>`
Create a new Intragen-branded mentor guide HTML for an OIM Academy module.  
Output: `Learning/Mentoring/guides/module_<code>_guide.html`.  
Brand: Inter font, purple #7B2D8B, teal #007B77, amber #F0A800.

### `/intragen-presentation <module_code> "<module_name>" <level>`
Create a new Intragen-branded HTML slide presentation for an OIM Academy module.  
Output: `Learning/Mentoring/presentations/module_<code>_presentation.html`.  
Structure: 6 slides (Title, What You'll Learn, Prerequisites, Exercises Overview, Mentor Tips, Ready to Begin).

### `/intragen-doc <source-html-path> [output-html-path]`
Apply the Intragen brand documentation template to a source HTML file.  
Output: Single self-contained HTML with Intragen PDF style (cover, TOC, content pages).

### `/create-notion-documentation`
Convert any documentation source (HTML, Markdown, plain text) into a Notion-ready workspace folder.  
Output: CSV databases, Markdown reference pages, and a setup guide.

---

## Intragen Assistant (IntragenAssistant WinForms Tool)

### `/intragen-test [-SkipApi]`
Run the automated 15-test pre-flight suite for IntragenAssistant.  
Test groups: File Integrity (5), Configuration (4), Context Files (2), Profile (2), API Connectivity (2).  
Verdicts: READY TO LAUNCH / MINOR ISSUES / BLOCKED.

### `/intragen-validate [quick | full]`
Full validation walkthrough for IntragenAssistant — automated pre-flight + guided manual testing of all 4 tabs.  
Output: 10-row PASS/FAIL summary table.

### `/intragen-ui-audit`
Full QA audit of Person Assistant WinForms app. Captures 24 screenshots, analyzes with vision, web-searches WinForms fixes.  
Output: `Tools/IntragenAssistant/KNOWN_ISSUES.md` with severity + effort estimates.

---

## DevOps & Repository

### `/git-commit-push`
Stage, commit with a conventional commit message, and push the Knowledge_Base repo to GitHub.  
Format: `<type>(<scope>): <message>` — conventional commits.

### `/pr-description [<base-branch>]`
Generate a PR title and body from the current git diff and commit history.  
Output: `gh pr create`-ready markdown with Summary bullets and Test plan checklist.

### `/changelog-update [<tag-or-version>]`
Build a CHANGELOG.md entry from commits since the last git tag.  
Format: Keep a Changelog (Added / Changed / Fixed / Removed / Security).

### `/gdrive-sync`
Sync the Knowledge_Base to Google Drive using rclone with a service account JSON key.

---

## GoalSetter Tool (project-level only)

### `/screenshot [tab-name]`
Capture a screenshot of the GoalSetter app, analyze all tabs for visual issues.  
Output: Issue list with severity (HIGH/MED/LOW), control description, source file + line, and fix suggestion.

---

## Skill File Locations

| Location | Format | Scope | Skills |
|---|---|---|---|
| `Knowledge_Base/.claude/skills/*/SKILL.md` | New SKILL.md | Project | oim-endpoint, oim-bulk, oim-plugin, oim-query-builder, oim-review, oim-deploy, oim-db-structure, git-commit-push, gdrive-sync, create-notion-documentation, oim-vbnet, oim-posh, oim-process, oim-troubleshoot, oim-testassist, oim-academy-search, kb-import, pr-description, changelog-update, oim-hook |
| `~/.claude/commands/*.md` | Legacy command | User (all projects) | intragen-doc, intragen-guide, intragen-presentation, intragen-test, intragen-ui-audit, intragen-validate, oim-discover, oim-query-evaluation |
| `Tools/GoalSetter/.claude/commands/screenshot.md` | Legacy command | GoalSetter project | screenshot |

---

## claude.ai Import Instructions

1. Open [claude.ai](https://claude.ai) → select or create a Project
2. Click **Project knowledge** → **Add content**
3. Upload this file (`_meta/SKILLS_LIBRARY.md`) as a document
4. Also upload `CLAUDE.md` for the full workspace context

Claude will then recognize `/skill-name` invocations and follow the skill instructions from this library.

> For the richest experience, also use Claude Code CLI which auto-loads skills from `.claude/skills/` and `~/.claude/commands/` directly.
