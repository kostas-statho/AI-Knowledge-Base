# Person Assistant — Known UI Issues
Generated: 2026-04-02 17:55
Screenshots: tests/screenshots/20260402_173804/ (16/24 states — Settings tabs from prior run 20260402_142548)

> **Note:** Screenshots 14–21 (Settings tabs) could not be captured in this run due to `SendKeys`
> "Access is denied" in non-interactive bash-spawned processes. Settings screenshots are sourced
> from the prior run (20260402_142548). Dropdown captures (02, 03, 09, 12, 13, 16, 18, 21)
> did not capture open dropdown state — dropdowns close before screenshot is taken.

---

## Summary

| Severity | Count |
|----------|-------|
| High     | 1     |
| Medium   | 2     |
| Low      | 3     |
| **Total (open)**| **6** |
| Fixed    | 6     |

---

## Fixed Issues (applied 2026-04-02)

| ID | File | Fix Applied |
|----|------|-------------|
| UI-001 | `src/ui/MainForm.ps1:40` | Replaced U+00B7 `·` with ASCII `\|` |
| UI-002 | `src/ui/Tab2-QueryEval.ps1:121` | Added `$lblScoreHint`; hidden in `Render-EvalResult` |
| UI-003 | `src/ui/SettingsDialog.ps1:16` | `$dlgTabs.SizeMode = 'FillToRight'` |
| UI-004 | `src/ui/SettingsDialog.ps1:40-53` | Added `.PlaceholderText` to Key, Model, Temp, MaxTok |
| UI-005 | `src/ui/SettingsDialog.ps1:190` | `$tMP.AutoScroll = $true` |
| UI-006 | `src/ui/Tab2-QueryEval.ps1:12` | Toggle AutoScroll to force VerticalScroll visible |

---

## Open Issue Registry

| ID | Tab / Screen | Severity | Short Description | Screenshot | Source File | Fix Approach |
|----|-------------|----------|-------------------|------------|-------------|--------------|
| UI-007 | Goals > 1-1 Meeting | Medium | "Save Brief" button clipped at form bottom | 06_goals_meeting.png | src/ui/Tab1-Goals-Meeting.ps1 | Reduce content height or enable form AutoScroll |
| UI-008 | Goals > Progress | Medium | Buttons at form bottom partially clipped | 07_goals_progress.png | src/ui/Tab1-Goals-Progress.ps1 | Same — reduce whitespace or enable AutoScroll |
| UI-009 | Presentations | Low | "Recent" section cut off at form bottom | 10_presentations.png | src/ui/Tab3-Presentations.ps1 | Enable pnlPres AutoScroll or reduce content |
| UI-010 | Doc Builder | Low | "Chat / Refine" input box cut off at bottom | 22_settings_closed.png | src/ui/Tab4-DocBuilder.ps1 | Enable content panel AutoScroll |

---

## Detailed Notes — Open Issues

### UI-007 — 1-1 Meeting "Save Brief" button clipped

**Screenshot:** 06_goals_meeting.png
**Observed:** The Goals > 1-1 Meeting sub-tab shows "Goals Progress Snapshot", "Additional Topics /
Notes", "Generate 1-on-1 Brief", and "Meeting Brief" text area. The "Save Brief" button at the
bottom of the tab is only partially visible — only the top edge of the button can be seen. It is
cut off by the form boundary.
**Suggested fix:** In `src/ui/Tab1-Goals-Meeting.ps1` (or equivalent meeting sub-tab file):
enable `AutoScroll = $true` on the containing panel, or reduce the overall content height so
"Save Brief" fits within the 660px tab content area.

---

### UI-008 — Progress tab buttons clipped

**Screenshot:** 07_goals_progress.png
**Observed:** The Goals > Progress sub-tab shows a progress bar (0/0 milestones, 0%) and an
instructional label "Finalize goals on the Goals tab to see your progress here." Below this is a
large empty area, and action buttons at the very bottom are partially cut off. The empty area
indicates the tab was designed for filled data but has excess padding in the empty state.
**Suggested fix:** Anchor bottom buttons to the bottom of the panel (`Anchor = 'Bottom, Left'`)
so they remain visible regardless of content above.

---

### UI-009 — Presentations "Recent" section clipped

**Screenshot:** 10_presentations.png
**Observed:** The Presentations tab shows a "Template" section, "Create New Presentation" section
(File Name + Output Folder + Create from Template button), "Extra Notes / Outline" text area,
"Chat (advisory)" section. Below these is a "Recent" section label + list box that is cut off
at the form bottom — the list and "Open" button are not fully visible.
**Suggested fix:** In `src/ui/Tab3-Presentations.ps1`: enable `AutoScroll = $true` on the
presentations panel, or reduce the height of the "Extra Notes" text area.

---

### UI-010 — Doc Builder "Chat / Refine" input cut off

**Screenshot:** 22_settings_closed.png (shows Doc Builder after closing Settings)
**Observed:** The Doc Builder tab shows Doc Type, Format, Raw Notes input, Generate button,
Output area, "Copy to Clipboard / Save as .md / Save as .html" buttons, and "Chat / Refine"
section header with a text input. The Refine text box is only partially visible at the form
bottom.
**Suggested fix:** In `src/ui/Tab4-DocBuilder.ps1`: enable `AutoScroll = $true` on the Doc
Builder content panel.

---

## Fix Plan — Open Issues (prioritised)

| ID | Severity | File | Approx Line | Fix | Effort |
|----|----------|------|-------------|-----|--------|
| UI-007 | Medium | Tab1-Goals-Meeting.ps1 | ~last panel | AutoScroll or anchor bottom button | S |
| UI-008 | Medium | Tab1-Goals-Progress.ps1 | ~last panel | Anchor bottom buttons | S |
| UI-009 | Low | Tab3-Presentations.ps1 | ~pnlPres | AutoScroll = $true | S |
| UI-010 | Low | Tab4-DocBuilder.ps1 | ~pnlDoc | AutoScroll = $true | S |

---

## Test-UI.ps1 Known Capture Limitations

| Issue | Root Cause | Status |
|-------|-----------|--------|
| Settings dialog not captured | `SendKeys` "Access is denied" in non-interactive process | Open — use separate interactive PS window |
| Dropdowns not open in screenshots | Click+screenshot timing; dropdown closes before capture | Open — increase delay or use `WM_LBUTTONDOWN` to ComboBox button HWND |
