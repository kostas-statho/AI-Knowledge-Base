# ChatBox — Claude Code Instructions

PowerShell 5.1 WinForms chat tool. Companion to GoalSetter. Windows-only (WinForms, DPAPI).

## Running

```powershell
powershell -ExecutionPolicy Bypass -File ChatBox.ps1
```

First run prompts for an OpenAI API key (stored DPAPI-encrypted in `config.json`).

## Architecture

`ChatBox.ps1` is a slim entry point that dot-sources everything from `src/`. All files share the same scope — no module isolation, no parameter threading.

### Directory Structure

```
ChatBox/
├── ChatBox.ps1             Entry point: assemblies, dot-source order, launch
├── config.json             DPAPI-encrypted API key + model pref (auto-created, not committed)
└── src/
    ├── Config.ps1          Save/Load-ApiKey (DPAPI) + Save/Load-Model
    ├── API.ps1             $Script:ApiCallScript (runspace scriptblock for OpenAI)
    ├── Async.ps1           Invoke-Async (runspace + WinForms timer) — identical to GoalSetter
    ├── Contexts.ps1        $Global:ContextPresets ordered hashtable (5 presets)
    └── ui/
        ├── StyleTokens.ps1     Brand colors + fonts (GoalSetter palette + fontChatNormal/Code)
        ├── SettingsDialog.ps1  Show-SettingsDialog: API key + model selection
        ├── MainForm.ps1        Form shell: header, accent, context toolbar, input bar, status
        ├── ChatPanel.ps1       RichTextBox + Append-ChatBubble + Send-Message + history I/O
        └── Launch.ps1          form.Add_Shown + ShowDialog
```

### Dot-Source Order (critical)

1. `Config`, `API`, `Async`, `Contexts` — pure utilities, no UI dependencies
2. `$Global:ApiKey`, `$Global:Model` — loaded from config (needs step 1)
3. `StyleTokens`, `SettingsDialog`, `MainForm` — UI shell; MainForm adds all Dock=Top/Bottom panels
4. `ChatPanel` — adds RichTextBox (`Dock=Fill`); **must follow MainForm** or the chat area won't fill correctly
5. `Launch` — last; calls ShowDialog

### Key Patterns

- **Async API calls**: `Invoke-Async` (src/Async.ps1) runs the OpenAI call in an isolated runspace. A WinForms `Timer` polls every 300ms. The `$Script:ApiCallScript` in API.ps1 is a self-contained scriptblock (no parent scope functions accessible inside runspaces).
- **Context presets**: `$Global:ContextPresets` in Contexts.ps1. Changing the combo updates `$Global:ActiveContext`. `Send-Message` reads this to build the system prompt.
- **History trimming**: `$Script:MaxHistory = 20` — oldest turns removed first when exceeded. System prompt is always prepended fresh per request (not stored in history).
- **Chat rendering**: `Append-ChatBubble` uses `SelectionColor`/`SelectionFont` on a RichTextBox for per-segment styling. "You" label = teal; "Assistant" label = purple; code lines = Consolas muted; prose = Segoe UI 10.
- **Enter to send, Shift+Enter for newline**: wired in ChatPanel.ps1 via `Add_KeyDown`.

### Global State

| Variable | Set by | Used by |
|---|---|---|
| `$Global:ApiKey` | `ChatBox.ps1` startup | `Send-Message`, `Show-SettingsDialog` |
| `$Global:Model` | `ChatBox.ps1` startup | `Send-Message`, model combo |
| `$Global:ContextPresets` | `Contexts.ps1` | MainForm combo, `Send-Message` |
| `$Global:ActiveContext` | MainForm combo change | `Send-Message` |
| `$Script:ChatHistory` | `ChatPanel.ps1` | `Send-Message`, `Save/Load-ChatHistory` |
| `$Script:rtbChat` | `ChatPanel.ps1` | All render helpers |
| `$Script:txtInput` | `MainForm.ps1` | `Send-Message`, `ChatPanel.ps1` |
| `$Script:btnSend` | `MainForm.ps1` | `ChatPanel.ps1` |
| `$Script:lblStatus` | `MainForm.ps1` | `Send-Message`, `Launch.ps1` |
| `$Script:cmbContext` | `MainForm.ps1` | Context combo change handler |
| `$Script:cmbModel` | `MainForm.ps1` | Model combo + SettingsDialog sync |

## Adding a New Context Preset

Edit `src/Contexts.ps1` — add a new key/value to `$Global:ContextPresets`. The combo in MainForm is populated from the hashtable keys at startup.

## Changing the Model List

Edit the `@(...)` array in both `MainForm.ps1` (context toolbar combo) and `SettingsDialog.ps1` (settings dialog combo).
