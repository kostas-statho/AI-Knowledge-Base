# ==============================================
# LAUNCH
# Must be dot-sourced LAST — all UI is built at this point.
# ==============================================

$form.Add_Shown({
    # Prompt for API key on first run
    if (-not $Global:ApiKey) {
        $Script:lblStatus.Text = 'No API key — opening Settings…'
        Show-SettingsDialog
    }
    $Script:txtInput.Focus()
    $Script:lblStatus.Text = 'Ready'
})

try {
    [Native.ConsoleHelper]::ShowWindow([Native.ConsoleHelper]::GetConsoleWindow(), 0)
} catch { <# ignore — console may already be hidden #> }

[System.Windows.Forms.Application]::EnableVisualStyles()
[void]$form.ShowDialog()
