---
description: Full validation walkthrough for IntragenAssistant — runs automated pre-flight checks then guides manual testing of all 4 tabs (Goals, Query Evaluator, Presentations, Doc Builder) with ready-to-use sample data.
argument-hint: [quick | full]
allowed-tools: [Bash, Read, Glob, Grep]
---

# /intragen-validate

Validate the IntragenAssistant WinForms app end-to-end.

- `quick` — pre-flight checks only (no manual test guide)
- `full` or no argument — pre-flight checks + full manual test guide with samples

---

## Step 1 — Pre-flight checks (automated)

Run all of these in sequence. Report PASS / FAIL for each.

### 1a. Required files exist

Check each path — FAIL if missing:

```
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\IntragenAssistant.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\openai-settings.json
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\profile.json
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\presentation_style.json
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\documentation_style.json
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\presentation_config.json
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\rules\SQL_Optimization_Rules.md
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\schema\Tables.md
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\Config.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\OpenAI.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\Profile.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\Async.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\RulesLoader.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\GlobalState.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\StyleTokens.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\SettingsDialog.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\MainForm.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\Tab1-Goals.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\Tab2-QueryEval.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\Tab3-Presentations.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\Tab4-DocBuilder.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\Launch.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\Goals\Tab1-Setup.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\Goals\Tab2-Questions.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\Goals\Tab3-Goals.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\Goals\Tab4-Meeting.ps1
C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\src\ui\Goals\Tab5-Progress.ps1
```

### 1b. JSON files parse correctly

Run this command and report any errors:
```powershell
powershell -Command "
  @('openai-settings.json','profile.json','presentation_style.json','documentation_style.json','presentation_config.json') | ForEach-Object {
    \$p = 'C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\' + \$_
    try { Get-Content \$p -Raw | ConvertFrom-Json | Out-Null; Write-Host \"PASS: \$_\" }
    catch { Write-Host \"FAIL: \$_ — \$(\$_.Exception.Message)\" }
  }
"
```

### 1c. PowerShell syntax check — all .ps1 files

Run:
```powershell
powershell -Command "
  Get-ChildItem 'C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant' -Recurse -Filter '*.ps1' | ForEach-Object {
    \$errors = \$null
    [System.Management.Automation.Language.Parser]::ParseFile(\$_.FullName, [ref]\$null, [ref]\$errors) | Out-Null
    if (\$errors.Count -gt 0) { Write-Host \"FAIL: \$(\$_.Name) — \$(\$errors[0].Message)\" }
    else { Write-Host \"PASS: \$(\$_.Name)\" }
  }
"
```

### 1d. API key status

Check whether `config.json` exists:
- EXISTS → key is saved (DPAPI encrypted) — decryption is tested only when the app runs
- MISSING → user must set key via File → Settings on first run (expected on first run)

### 1e. Known incompatibility scan

Grep all .ps1 files for `.PlaceholderText` — should return 0 matches after the fix. Report FAIL if any found.

---

If `quick` mode: stop here, print summary table, done.

---

## Step 2 — Launch the app

Tell the user to run:
```
powershell -ExecutionPolicy Bypass -File "C:\Users\OneIM\Knowledge_Base\Tools\IntragenAssistant\IntragenAssistant.ps1"
```

Expected: Intragen purple header + 4 tabs (Goals / Query Evaluator / Presentations / Doc Builder) appear within 2 seconds.

If a MessageBox error appears instead: read it and diagnose before continuing.

Ask the user: "Did the app open?" — wait for confirmation before proceeding.

---

## Step 3 — Settings & API key

**Test: Settings dialog**

1. Click **File → Settings**
2. Verify 4 tabs: API / Presentation Style / Documentation Style / Profile
3. In **Profile** tab: enter Name = `Validation Test`, Role = `OIM Developer`, Organisation = `Intragen`
4. In **API** tab: enter the OpenAI API key (skip if already set — key field will be populated)
5. Click **Test Key** — expect "API key is valid." MessageBox
6. Click **Save All** — expect "Settings saved." MessageBox

✅ Pass criteria: Settings dialog opens, all 4 tabs visible, Save All completes without error.

---

## Step 4 — Tab 1: Goals

**Sample profile data to enter:**

- Name: `Konstantinos` (or your name)
- Skills: `PowerShell` (Advanced), `SQL` (Intermediate), `OIM` (Advanced)
- Interests: `Process Automation` (Intermediate), `API Design` (Beginner)
- Domain: `Coding` (use Quick add dropdown)
- Target working days: `90`
- Hours/day: `2`

**Test steps:**

1. Switch to **Goals** tab → nested sub-tabs should appear (Setup / Questions / Goals / 1-1 Meeting / Progress)
2. On **Setup** sub-tab: fill in the sample data above
3. Click **Analyse (SWOT)** → spinner appears → after ~5–10s, spinner shows ✓ and "Generate Questions →" becomes enabled
4. Click **Generate Questions →** → switches to **Questions** sub-tab, 5 MCQs appear
5. Answer at least 2 questions (select any options), click **Generate Goals →** → switches to Goals sub-tab with proposed goals
6. Select at least 1 goal + milestones, click **Finalize Selected Goals →** → switches to **Progress** sub-tab showing milestone checkboxes and progress bar
7. Check 1 milestone → progress bar updates
8. On **1-1 Meeting** sub-tab: click **Refresh Goals** → goals snapshot loads in text area
9. Enter Team Leader name, click **Generate 1-on-1 Brief** → brief text appears

✅ Pass criteria: SWOT → Questions → Goals → Progress pipeline completes, progress bar updates.

---

## Step 5 — Tab 2: Query Evaluator

**Sample SQL (paste this exactly):**

```sql
SELECT p.UID_Person, p.CentralAccount, p.DisplayName,
       a.UID_ADSAccount, a.SAMAccountName,
       g.UID_ADSGroup, g.CN
FROM Person p, ADSAccount a, ADSAccountInADSGroup ag, ADSGroup g
WHERE p.UID_Person = a.UID_Person
AND   a.UID_ADSAccount = ag.UID_ADSAccount
AND   ag.UID_ADSGroup = g.UID_ADSGroup
AND   a.AccountDisabled = 0
AND   LEFT(p.CentralAccount, 1) = 'k'
```

**Intent to enter:** `Find all enabled AD accounts and their group memberships for accounts starting with 'k'`

**Test steps:**

1. Switch to **Query Evaluator** tab
2. Paste the SQL above into the SQL text box
3. Enter the intent text in the Intent field
4. Click **Evaluate Query** → status label shows "Sending to OpenAI..." → after ~10–15s, scorecard bars fill with color, issues appear in red/orange in the Issues box
5. Verify expected issues are flagged:
   - Safety: `SELECT *` or missing NOLOCK → score < 100
   - SARGability: `LEFT(col,1)` on filter column → deduction
   - OIM Correctness: implicit join syntax (`FROM a, b WHERE`)
   - Code Quality: no metadata header → score low
6. In Chat / Override box enter: `The implicit join syntax is acceptable for this legacy query — please re-evaluate ignoring CO5`
7. Click **Re-evaluate with note** → updated scores appear, "Round 2/5" shown

✅ Pass criteria: scorecard renders with colored bars, issues list has content, re-evaluate updates scores.

---

## Step 6 — Tab 3: Presentations

**Test steps:**

1. Switch to **Presentations** tab
2. In the **Template** group: click **Browse...** and select any existing .pptx file on your machine (or skip if none — the error message for missing template is also a valid test)
3. In **Create New Presentation**: enter File Name = `IntragenTest_2026`, browse to a temp output folder (e.g. Desktop)
4. Click **Create from Template** → a .pptx copy is created and opens in PowerPoint, status label shows "Created: ..."
5. The new file appears in the **Recent** list
6. In the **Chat** box enter: `Suggest 3 slide titles for an OIM provisioning overview presentation`
7. Click **Apply suggestion** → AI response is appended to the Extra Notes text area, status label updates

✅ Pass criteria: .pptx file created, opens in PowerPoint, Recent list updated, AI suggestion appended to notes.

---

## Step 7 — Tab 4: Doc Builder

**Sample raw notes to paste:**

```
OIM Job Queue Overview

Purpose: The JobQueue table drives all provisioning in One Identity Manager.
Each row is a single task to be executed by the DBQueue Processor.

Key columns:
- UID_Job: unique identifier
- TaskName: name of the process step
- Ready2EXE: status flag — TRUE=ready, FALSE=waiting, OVERLIMIT=throttled, FINISHED=done
- QueuePriority: lower number = higher priority

Common issues:
- Jobs stuck in FALSE state: usually means a predecessor job failed
- OVERLIMIT state: too many concurrent jobs, will auto-resume
- Checking queue health: filter WHERE Ready2EXE = 'TRUE' AND IsLoaded = 0

Related tables: JobQueueHistory, QBMDBQueueConfig
```

**Test steps:**

1. Switch to **Doc Builder** tab
2. Select Doc Type = **SQL Reference**, Format = **Markdown**
3. Paste the sample notes above into the Raw Notes box
4. Click **Generate Documentation** → status label shows "Sending to OpenAI..." → after ~10–15s, a structured Markdown document appears in the Output box with headings and formatting
5. Click **Copy to Clipboard** → paste into a text editor to verify
6. Click **Save as .md** → SaveFileDialog appears → save to Desktop as `JobQueue_Reference.md` → file created, status label shows path
7. In **Chat / Refine** box enter: `Add a troubleshooting section with 3 common problems and solutions`
8. Click **Refine** → "Round 2/5" shown, output updates with the troubleshooting section added
9. Click **Save as .html** → saves Intragen-branded HTML file, open in browser to verify styling

✅ Pass criteria: Doc generated from raw notes, copy/save work, refine round updates content.

---

## Step 8 — Final report

Print a summary table:

```
VALIDATION SUMMARY — IntragenAssistant
========================================
Pre-flight checks
  File structure         : PASS / FAIL
  JSON validity          : PASS / FAIL
  Syntax check           : PASS / FAIL
  PlaceholderText scan   : PASS / FAIL

Manual tests
  App launches           : PASS / FAIL / SKIP
  Settings dialog        : PASS / FAIL / SKIP
  Tab 1 – Goals          : PASS / FAIL / SKIP
  Tab 2 – Query Eval     : PASS / FAIL / SKIP
  Tab 3 – Presentations  : PASS / FAIL / SKIP
  Tab 4 – Doc Builder    : PASS / FAIL / SKIP

Overall: X/10 PASS
========================================
```

For any FAIL, include the exact error observed and the recommended fix.
