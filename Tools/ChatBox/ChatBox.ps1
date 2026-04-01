#Requires -Version 5.1
<#
.SYNOPSIS
    Intragen Chat Assistant — PowerShell WinForms chat powered by OpenAI.
.DESCRIPTION
    A conversational chat tool styled to match the Intragen desktop visual language
    (purple header, gold accent, teal actions). Supports multiple context presets
    for OIM development, SQL, C# review, and PowerShell work.
    On first run, a Settings dialog prompts for your OpenAI API key (stored DPAPI-encrypted).
.EXAMPLE
    powershell -ExecutionPolicy Bypass -File ChatBox.ps1
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Security
Add-Type -Name ConsoleHelper -Namespace Native -MemberDefinition '
    [DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")]   public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
' -ErrorAction SilentlyContinue

Set-StrictMode -Off
$ErrorActionPreference = 'Stop'

$ScriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigPath = Join-Path $ScriptDir 'config.json'

# ── Utilities (no UI dependencies) ───────────────────────────────────────────
. "$ScriptDir\src\Config.ps1"
. "$ScriptDir\src\API.ps1"
. "$ScriptDir\src\Async.ps1"
. "$ScriptDir\src\Contexts.ps1"

# ── Global state (needs utilities loaded first) ───────────────────────────────
$Global:ApiKey = Load-ApiKey $ConfigPath
$Global:Model  = Load-Model  $ConfigPath

# ── UI (order is load-order sensitive) ───────────────────────────────────────
. "$ScriptDir\src\ui\StyleTokens.ps1"
. "$ScriptDir\src\ui\SettingsDialog.ps1"
. "$ScriptDir\src\ui\MainForm.ps1"     # builds form + all Dock=Top/Bottom panels
. "$ScriptDir\src\ui\ChatPanel.ps1"    # adds RichTextBox (Dock=Fill) — must follow MainForm
. "$ScriptDir\src\ui\Launch.ps1"       # ShowDialog — must be last
