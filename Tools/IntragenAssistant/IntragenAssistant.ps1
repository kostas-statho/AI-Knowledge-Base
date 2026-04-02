#Requires -Version 5.1
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Security
if (-not ([System.Management.Automation.PSTypeName]'Native.ConsoleHelper').Type) {
    Add-Type -Name ConsoleHelper -Namespace Native -MemberDefinition '
        [DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
        [DllImport("user32.dll")]   public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    '
}

Set-StrictMode -Off
$ErrorActionPreference = 'Stop'

$ScriptDir = if ($PSScriptRoot) { $PSScriptRoot } `
             elseif ($MyInvocation.MyCommand.Path) { Split-Path -Parent $MyInvocation.MyCommand.Path } `
             else { Split-Path -Parent $MyInvocation.MyCommand.Definition }
$ConfigPath          = Join-Path $ScriptDir 'config.json'
$AnthropicConfigPath = Join-Path $ScriptDir 'config_anthropic.json'
$GrokConfigPath      = Join-Path $ScriptDir 'config_grok.json'
$ProfilePath         = Join-Path $ScriptDir 'profile.json'
$OAISettingsPath     = Join-Path $ScriptDir 'openai-settings.json'
$PresentConfigPath   = Join-Path $ScriptDir 'presentation_config.json'
$PresentStylePath    = Join-Path $ScriptDir 'presentation_style.json'
$DocStylePath        = Join-Path $ScriptDir 'documentation_style.json'

try {
    # ── Utilities ─────────────────────────────────
    . "$ScriptDir\src\Config.ps1"
    . "$ScriptDir\src\OpenAI.ps1"
    . "$ScriptDir\src\Profile.ps1"
    . "$ScriptDir\src\Async.ps1"
    . "$ScriptDir\src\RulesLoader.ps1"
    . "$ScriptDir\src\ProviderHelper.ps1"

    # ── Global state ──────────────────────────────
    $Global:ApiKey       = Load-ApiKey      $ConfigPath
    $Global:AnthropicKey = Load-AnthropicKey $AnthropicConfigPath
    $Global:GrokKey      = Load-GrokKey      $GrokConfigPath
    $Global:Profile      = Load-Profile      $ProfilePath
    . "$ScriptDir\src\GlobalState.ps1"

    # ── UI ────────────────────────────────────────
    . "$ScriptDir\src\ui\StyleTokens.ps1"
    . "$ScriptDir\src\ui\SettingsDialog.ps1"
    . "$ScriptDir\src\ui\MainForm.ps1"
    . "$ScriptDir\src\ui\Tab1-Goals.ps1"
    . "$ScriptDir\src\ui\Tab2-QueryEval.ps1"
    . "$ScriptDir\src\ui\Tab3-Presentations.ps1"
    . "$ScriptDir\src\ui\Tab4-DocBuilder.ps1"

    # ── Launch ────────────────────────────────────
    . "$ScriptDir\src\ui\Launch.ps1"
} catch {
    [void][System.Windows.Forms.MessageBox]::Show(
        "Startup error:`n`n$_`n`nAt: $($_.InvocationInfo.PositionMessage)",
        'Person Assistant — Error',
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error)
}
