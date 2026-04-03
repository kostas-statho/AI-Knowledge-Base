---
name: screenshot
description: Capture a screenshot of the GoalSetter app (auto-launches if not running), analyze every tab for visual issues, and report findings with severity and fix targets.
argument-hint: "[tab-name]"
user-invocable: true
allowed-tools: "Bash, Read, Write"
---

# /screenshot — GoalSetter Visual Audit

Capture a screenshot of the GoalSetter app, analyze it for visual issues, and report every finding with severity and the source file to fix.

## Steps

### Step 1 — Capture

```powershell
powershell -ExecutionPolicy Bypass -File scripts/Take-Screenshot.ps1
```

The script auto-launches the app if not running, waits for the window, captures it, and prints the saved path. If a `[tab-name]` argument was provided, send a tab-click first before capturing (Tab key or Windows message).

### Step 2 — Analyze

Use the Read tool to view the captured image. Scan for issues in every visible category:

| Category | What to check |
|---|---|
| Layout | Overlapping controls, clipped edges, controls outside panel bounds |
| Labels | Truncated text, ellipsis where full text is expected, misaligned captions |
| Buttons | Cut-off buttons, buttons hidden behind scroll panels, inconsistent sizing |
| Spacing | Excessive gaps, zero-margin crowding, inconsistent padding between groups |
| Scroll panels | Content not visible without scroll when it should fit, scroll bar appearing unnecessarily |
| Fonts | Mismatched sizes between similar controls, bold vs. normal inconsistency |
| Colors | Wrong background color for a tab, disabled control still shows active color |
| State | Loading spinner still visible when data is loaded, progress bar stuck |

### Step 3 — Iterate per tab

Switch to each tab (1–5) in sequence, re-run the script, read the new screenshot, and check for per-tab issues.

### Step 4 — Report

Output a structured issue list:

```
## GoalSetter Visual Issues — <date>

### [SEV: HIGH] Tab 1 — Setup
- LAYOUT-001: "Analyse" button clipped at right edge (src/ui/Tab1-Setup.ps1 ~L85)
  Fix: Increase $panel.Width or reduce button $Width by 8px

### [SEV: MED] Tab 3 — Goals
- LABEL-003: Goal title label truncated to 2 lines; should show 3 (src/ui/Tab3-Goals.ps1 ~L120)
  Fix: Set $lbl.AutoSize = $false; $lbl.Height = 60

### [SEV: LOW] Tab 5 — Progress
- SPACING-007: 20px gap between milestone checkboxes (src/ui/Tab5-Progress.ps1 ~L44)
  Fix: Set FlowLayoutPanel Margin to 4
```

**Severity levels:**
- **HIGH** — Feature is unusable or controls are inaccessible
- **MED** — Content is cut off or misleading but feature still works
- **LOW** — Cosmetic only (spacing, alignment, minor font inconsistency)

### Step 5 — Fix

Edit the identified `src/ui/Tab*.ps1` file at the noted line. Re-run `/screenshot` after each HIGH fix to verify.

## Source file map

| Tab | File |
|---|---|
| Tab 1 — Setup | `src/ui/Tab1-Setup.ps1` |
| Tab 2 — Questions | `src/ui/Tab2-Questions.ps1` |
| Tab 3 — Goals | `src/ui/Tab3-Goals.ps1` |
| Tab 4 — Meeting | `src/ui/Tab4-Meeting.ps1` |
| Tab 5 — Progress | `src/ui/Tab5-Progress.ps1` |
| Main form / menus | `src/ui/MainForm.ps1` |
| Settings dialog | `src/ui/SettingsDialog.ps1` |
