#Requires -Version 5.1
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Security
Add-Type -Name ConsoleHelper -Namespace Native -MemberDefinition '
    [DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")]   public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
'

Set-StrictMode -Off
$ErrorActionPreference = 'Stop'

$ScriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigPath  = Join-Path $ScriptDir 'config.json'
$ProfilePath = Join-Path $ScriptDir 'profile.json'

# ── Utility functions ─────────────────────────
. "$ScriptDir\src\Config.ps1"
. "$ScriptDir\src\OpenAI.ps1"
. "$ScriptDir\src\Profile.ps1"
. "$ScriptDir\src\Async.ps1"

# ── Global state ──────────────────────────────
# $ConfigPath and $ProfilePath are used explicitly here so dot-sourced files
# inherit them via scope chain without triggering "unused variable" warnings.
$Global:ApiKey  = Load-ApiKey  $ConfigPath
$Global:Profile = Load-Profile $ProfilePath
. "$ScriptDir\src\GlobalState.ps1"

# ── UI ────────────────────────────────────────
. "$ScriptDir\src\ui\StyleTokens.ps1"
. "$ScriptDir\src\ui\SettingsDialog.ps1"
. "$ScriptDir\src\ui\MainForm.ps1"
. "$ScriptDir\src\ui\Tab1-Setup.ps1"
. "$ScriptDir\src\ui\Tab2-Questions.ps1"
. "$ScriptDir\src\ui\Tab3-Goals.ps1"     # declares $btnSaveProgress etc. — must precede Tab5
. "$ScriptDir\src\ui\Tab5-Progress.ps1"  # consumes $btnSaveProgress etc. from Tab3
. "$ScriptDir\src\ui\Tab4-Meeting.ps1"

# ── Launch ────────────────────────────────────
. "$ScriptDir\src\Launch.ps1"
