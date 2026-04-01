# ----------------------------------------------
# SETTINGS DIALOG
# ----------------------------------------------
function Show-SettingsDialog {
    $dlg = New-Object System.Windows.Forms.Form
    $dlg.Text            = 'Settings  -  OpenAI API Key'
    $dlg.Size            = New-Object System.Drawing.Size(440, 200)
    $dlg.StartPosition   = 'CenterParent'
    $dlg.FormBorderStyle = 'FixedDialog'
    $dlg.MaximizeBox     = $false
    $dlg.BackColor       = $colBackground

    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text     = 'OpenAI API Key:'
    $lbl.Location = New-Object System.Drawing.Point(12, 18)
    $lbl.AutoSize = $true
    $lbl.Font     = $fontLabel

    $txt = New-Object System.Windows.Forms.TextBox
    $txt.Location     = New-Object System.Drawing.Point(12, 40)
    $txt.Width        = 400
    $txt.PasswordChar = '*'
    $txt.Font         = $fontInput
    $txt.BackColor    = $colPanel
    $txt.Text         = if ($Global:ApiKey) { $Global:ApiKey } else { '' }

    $btnSave = New-Object System.Windows.Forms.Button
    $btnSave.Text     = 'Save'
    $btnSave.Location = New-Object System.Drawing.Point(12, 78)
    Set-PrimaryButton $btnSave
    $btnSave.Add_Click({
        if ($txt.Text.Trim()) {
            Save-ApiKey $txt.Text.Trim()
            $Global:ApiKey = $txt.Text.Trim()
            [System.Windows.Forms.MessageBox]::Show('Key saved and encrypted.', 'Saved') | Out-Null
            $dlg.Close()
        } else {
            [System.Windows.Forms.MessageBox]::Show('Please enter a key.', 'Required') | Out-Null
        }
    })

    $btnTest = New-Object System.Windows.Forms.Button
    $btnTest.Text     = 'Test Key'
    $btnTest.Location = New-Object System.Drawing.Point(12, 115)
    $btnTest.Width    = 90
    Set-SecondaryButton $btnTest
    $btnTest.Add_Click({
        $key = $txt.Text.Trim()
        if (-not $key) { [System.Windows.Forms.MessageBox]::Show('Enter a key first.', 'Required') | Out-Null; return }
        $btnTest.Enabled = $false
        $btnTest.Text = 'Testing...'
        try {
            $body = '{"model":"gpt-4.1","messages":[{"role":"user","content":"Hi"}],"max_tokens":1}'
            $wc = New-Object System.Net.WebClient
            $wc.Encoding = [System.Text.Encoding]::UTF8
            $wc.Headers.Add('Authorization', "Bearer $key")
            $wc.Headers.Add('Content-Type', 'application/json')
            $resp = $wc.UploadString('https://api.openai.com/v1/chat/completions', $body) | ConvertFrom-Json
            if ($resp.choices) {
                [System.Windows.Forms.MessageBox]::Show('API key is valid and working.', 'Success') | Out-Null
            } else {
                [System.Windows.Forms.MessageBox]::Show("Unexpected response: $($resp | ConvertTo-Json -Compress)", 'Warning') | Out-Null
            }
        } catch {
            $msg = if ($_.Exception.InnerException) { $_.Exception.InnerException.Message } else { $_.Exception.Message }
            [System.Windows.Forms.MessageBox]::Show("Key test failed:`n$msg", 'Error') | Out-Null
        }
        $btnTest.Enabled = $true
        $btnTest.Text = 'Test Key'
    })

    $btnCancel = New-Object System.Windows.Forms.Button
    $btnCancel.Text     = 'Cancel'
    $btnCancel.Location = New-Object System.Drawing.Point(100, 78)
    Set-SecondaryButton $btnCancel
    $btnCancel.Add_Click({ $dlg.Close() })

    $dlg.Controls.AddRange(@($lbl, $txt, $btnSave, $btnCancel, $btnTest))
    $dlg.ShowDialog() | Out-Null
}
