# ----------------------------------------------
# First-run key prompt + launch
# ----------------------------------------------
$form.Add_Shown({
    if (-not $Global:ApiKey) {
        $r = [System.Windows.Forms.MessageBox]::Show(
            'No OpenAI API key found. Open Settings to add one?',
            'Setup Required',
            [System.Windows.Forms.MessageBoxButtons]::YesNo)
        if ($r -eq 'Yes') { Show-SettingsDialog }
    }
    # Pre-populate goals if profile already has them
    if ($Global:Profile.goals -and $Global:Profile.goals.Count -gt 0) {
        Render-Goals $Global:Profile.goals
    }
})

[System.Windows.Forms.Application]::EnableVisualStyles()
[Native.ConsoleHelper]::ShowWindow([Native.ConsoleHelper]::GetConsoleWindow(), 0)
[void]$form.ShowDialog()
