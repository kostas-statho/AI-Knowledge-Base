# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A PowerShell 5.1 WinForms desktop application that helps users set and track personal/professional goals using OpenAI's GPT-4o API. Windows-only (depends on WinForms, DPAPI).

## Running

```powershell
# Launch the GUI (Windows only, requires PowerShell 5.1+)
powershell -ExecutionPolicy Bypass -File GoalSetter.ps1
```

On first run, the app prompts for an OpenAI API key, which is stored DPAPI-encrypted in `config.json` (auto-created, not checked in).

## Architecture

`GoalSetter.ps1` is a slim entry point (~40 lines) that dot-sources everything from `src/`. All files share the same scope — no module isolation, no parameter threading — so UI controls defined in one tab file are directly accessible in another.

### Directory Structure

```
GoalSetter/
├── GoalSetter.ps1          Entry point: assemblies, paths, dot-source order, launch
├── profile.json            User profile + goal progress (committed as empty template)
├── config.json             DPAPI-encrypted API key (auto-created, do not commit)
└── src/
    ├── Config.ps1          Save-ApiKey / Load-ApiKey (DPAPI)
    ├── OpenAI.ps1          Invoke-OpenAI / Parse-Json
    ├── Profile.ps1         Load-Profile / Save-Profile
    ├── Async.ps1           Invoke-Async (runspace + WinForms timer)
    ├── GlobalState.ps1     $Global:SwotJson, McqData, Goals, etc.
    └── ui/
        ├── SettingsDialog.ps1  Show-SettingsDialog (API key dialog)
        ├── MainForm.ps1        $form, menu, $tabs, 5 × TabPage objects
        ├── Tab1-Setup.ps1      Profile, domain, time commitment, SWOT
        ├── Tab2-Questions.ps1  MCQ generation + Render-MCQs
        ├── Tab3-Goals.ps1      Goal proposals + Render-Goals + save/export
        ├── Tab4-Meeting.ps1    1-on-1 brief generator
        ├── Tab5-Progress.ps1   Progress bar + milestone scroll panel
        └── Launch.ps1          form.Add_Shown + ShowDialog
```

### Dot-Source Order (critical)

The order in `GoalSetter.ps1` is load-order sensitive:

1. `Config`, `OpenAI`, `Profile`, `Async` — pure utilities, no dependencies
2. `GlobalState` — calls `Load-ApiKey`/`Load-Profile` (needs step 1)
3. `SettingsDialog`, `MainForm` — needs global state
4. `Tab1` → `Tab2` → `Tab3` → **`Tab5`** → `Tab4` — Tab3 declares `$btnSaveProgress` etc. that Tab5 adds to its FlowLayoutPanel; Tab5 must follow Tab3.
5. `Launch` — last, after all UI is built

### Data Flow (5-tab wizard)

1. **Tab 1 — Setup**: Profile (name, skills, interests) + domain + time commitment. "Analyse" calls o4-mini → SWOT JSON (`$Global:SwotJson`).
2. **Tab 2 — Questions**: "Generate Questions" sends SWOT + profile to GPT-4o → 5 diagnostic MCQs (`$Global:McqData`).
3. **Tab 3 — Goals**: "Generate Goals" sends MCQ answers + SWOT → 3-5 SMART goals with milestones. User selects/deselects, then finalizes.
4. **Tab 4 — Meeting**: 1-on-1 brief generator — auto-loads goal snapshot, GPT-4o produces a structured plain-text brief.
5. **Tab 5 — Progress**: Milestone checkboxes with overall progress bar. Save/export buttons.

### Key Patterns

- **Async API calls**: Each OpenAI call runs in a separate PowerShell runspace via `Invoke-Async` (`src/Async.ps1`). A WinForms `Timer` polls for completion to avoid blocking the UI thread. Each runspace scriptblock redefines its own `Invoke-OpenAI` variant (numbered 2–5) because runspaces are isolated and cannot call the parent scope's functions.
- **API key storage**: DPAPI encryption (`ProtectedData.Protect`) → Base64 → `config.json`. Decrypted on load. Tied to the current Windows user/machine.
- **Profile persistence**: `profile.json` stores name, skills, interests, and finalized goal progress. Loaded at startup; saved via "Save Progress".
- **JSON parsing from LLM**: All GPT-4o responses are expected as raw JSON. Inline cleanup strips markdown fences before `ConvertFrom-Json`.
- **Cross-tab variable access**: Because all UI files are dot-sourced into the same script scope, controls like `$scrollProgress` (Tab5) can be written to by `Render-Goals` (Tab3) at runtime without any parameter passing.

### Global State

| Variable | Set by | Used by |
|---|---|---|
| `$Global:ApiKey` | `GoalSetter.ps1` startup | All API call handlers |
| `$Global:Profile` | `GoalSetter.ps1` startup | Tab1, Tab3, Tab4 |
| `$Global:SwotJson` | Tab1 SWOT callback | Tab2, Tab3, Tab4 |
| `$Global:McqData` | `Render-MCQs` (Tab2) | Tab3 goal generation |
| `$Global:GoalProposals` | `Render-GoalProposals` (Tab3) | Tab3 finalize handler |
| `$Global:Goals` | `Render-Goals` (Tab3) | Tab4 snapshot, Tab5 progress bar |
| `$Global:TargetDays` / `$Global:HoursPerWeek` | Tab3 goal generation | Tab3 finalize handler |

## Important Notes

- All API calls use `gpt-4.1` via the shared `$Script:ApiCallScript` in `src/OpenAI.ps1`. MaxTokens: 2000 (Tab1/Tab2), 2500 (Tab3/Tab4).
- The shared `$Script:ApiCallScript` is passed directly to `Invoke-Async` — no per-tab function redefinitions needed.
- `Add-Type` for assemblies and the `ConsoleHelper` P/Invoke type must stay in `GoalSetter.ps1` only — repeating them in dot-sourced files would cause "type already defined" errors.
