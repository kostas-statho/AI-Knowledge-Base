#Requires -Version 5.1
<#
.SYNOPSIS
    OIM Dev Assistant — PowerShell WinForms chat powered by GPT-4o.
.DESCRIPTION
    Loads the OIM Knowledge_Base as a system prompt, then opens a WinForms
    chat window for natural-language OIM 9.3 developer questions.
    Run Encrypt-Key.ps1 ONCE before first use to create config.json.
.EXAMPLE
    powershell -ExecutionPolicy Bypass -File OIM_Chat.ps1
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Security
[System.Windows.Forms.Application]::EnableVisualStyles()

# Hide the console window (same Win32 pattern as GoalSetter)
Add-Type -Name ConsoleHelper -Namespace Native -MemberDefinition '
    [DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")]   public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
' -ErrorAction SilentlyContinue

$ScriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigPath = Join-Path $ScriptDir 'config.json'
$KbRoot     = Split-Path $ScriptDir -Parent   # Knowledge_Base root (one level up from ChatAssistant/)

# ── Load API key ─────────────────────────────────────────────────────────────────
if (-not (Test-Path $ConfigPath)) {
    [System.Windows.Forms.MessageBox]::Show(
        "config.json not found.`nRun Encrypt-Key.ps1 first to set up your OpenAI API key.",
        'OIM Dev Assistant — Setup Required',
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Warning)
    exit 1
}

try {
    $cfg = Get-Content $ConfigPath -Raw | ConvertFrom-Json
    $Script:ApiKey = [System.Text.Encoding]::UTF8.GetString(
        [System.Security.Cryptography.ProtectedData]::Unprotect(
            [Convert]::FromBase64String($cfg.key), $null, 'CurrentUser'))
} catch {
    [System.Windows.Forms.MessageBox]::Show(
        "Failed to decrypt API key: $($_.Exception.Message)`nRun Encrypt-Key.ps1 again.",
        'OIM Dev Assistant — Key Error',
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error)
    exit 1
}

# ── Dot-source UI tokens ─────────────────────────────────────────────────────────
. (Join-Path $ScriptDir 'src\ui\StyleTokens.ps1')

# ── Build form (establishes $form and $Script:lblStatus etc.) ───────────────────
. (Join-Path $ScriptDir 'src\ui\ChatForm.ps1')

# ── Load knowledge base in background after form is shown ───────────────────────
$form.Add_Shown({
    $Script:lblStatus.Text   = 'Loading knowledge base…'
    $Script:txtInput.Enabled = $false
    $Script:btnSend.Enabled  = $false

    Import-Module (Join-Path $ScriptDir 'src\KnowledgeLoader.psm1') -Force -ErrorAction Stop

    # Build-SystemPrompt can be slow (reading large HTML) — run on UI thread but
    # show a status update so the window doesn't appear frozen.
    [System.Windows.Forms.Application]::DoEvents()

    try {
        $Script:SystemPrompt = Build-SystemPrompt -BasePath $KbRoot
        $Script:lblStatus.Text   = 'Ready'
        $Script:txtInput.Enabled = $true
        $Script:btnSend.Enabled  = $true
        $Script:txtInput.Focus()
    } catch {
        $Script:lblStatus.Text = "Knowledge load failed: $($_.Exception.Message)"
        # Still allow the user to chat — just without full KB context
        $Script:SystemPrompt = 'You are an expert OIM 9.3 developer assistant. Knowledge base failed to load; answer from general knowledge.'
        $Script:txtInput.Enabled = $true
        $Script:btnSend.Enabled  = $true
    }
})

# ── Hide console and show form ───────────────────────────────────────────────────
try {
    [Native.ConsoleHelper]::ShowWindow([Native.ConsoleHelper]::GetConsoleWindow(), 0)
} catch { <# ignore if already hidden or add-type failed #> }

[void]$form.ShowDialog()
