# ==============================================
# SETTINGS DIALOG
# API key entry + model selector.
# Mirrors GoalSetter's SettingsDialog pattern.
# ==============================================
function Show-SettingsDialog {
    $dlg                  = New-Object System.Windows.Forms.Form
    $dlg.Text             = 'Settings'
    $dlg.Size             = New-Object System.Drawing.Size(440, 280)
    $dlg.MinimumSize      = New-Object System.Drawing.Size(440, 280)
    $dlg.MaximumSize      = New-Object System.Drawing.Size(440, 280)
    $dlg.StartPosition    = 'CenterParent'
    $dlg.FormBorderStyle  = 'FixedDialog'
    $dlg.MaximizeBox      = $false
    $dlg.MinimizeBox      = $false
    $dlg.BackColor        = $colBackground
    $dlg.Font             = $fontLabel

    # Purple header
    $pnlH             = New-Object System.Windows.Forms.Panel
    $pnlH.Dock        = 'Top'
    $pnlH.Height      = 50
    $pnlH.BackColor   = $colPurple
    $lblH             = New-Object System.Windows.Forms.Label
    $lblH.Text        = 'Settings'
    $lblH.Font        = New-Object System.Drawing.Font('Segoe UI', 13, [System.Drawing.FontStyle]::Bold)
    $lblH.ForeColor   = $colWhite
    $lblH.AutoSize    = $true
    $lblH.Location    = New-Object System.Drawing.Point(16, 12)
    $pnlH.Controls.Add($lblH)
    $dlg.Controls.Add($pnlH)

    # Gold accent
    $pnlA             = New-Object System.Windows.Forms.Panel
    $pnlA.Dock        = 'Top'
    $pnlA.Height      = 3
    $pnlA.BackColor   = $colGold
    $dlg.Controls.Add($pnlA)

    # Content panel
    $pnlC             = New-Object System.Windows.Forms.Panel
    $pnlC.Dock        = 'Fill'
    $pnlC.Padding     = New-Object System.Windows.Forms.Padding(20, 14, 20, 10)
    $dlg.Controls.Add($pnlC)

    # ── API Key row ──────────────────────────────────
    $lblKey           = New-Object System.Windows.Forms.Label
    $lblKey.Text      = 'OpenAI API Key'
    $lblKey.Font      = $fontSubhead
    $lblKey.ForeColor = $colPurple
    $lblKey.Location  = New-Object System.Drawing.Point(20, 20)
    $lblKey.AutoSize  = $true

    $txtKey                      = New-Object System.Windows.Forms.TextBox
    $txtKey.Location             = New-Object System.Drawing.Point(20, 42)
    $txtKey.Width                = 320
    $txtKey.Height               = 24
    $txtKey.UseSystemPasswordChar= $true
    $txtKey.BackColor            = $colPanel
    $txtKey.Font                 = $fontInput
    $txtKey.BorderStyle          = 'FixedSingle'
    $txtKey.Text                 = if ($Global:ApiKey) { $Global:ApiKey } else { '' }

    $btnShow          = New-Object System.Windows.Forms.Button
    $btnShow.Text     = 'Show'
    $btnShow.Location = New-Object System.Drawing.Point(348, 41)
    $btnShow.Width    = 56
    $btnShow.Height   = 26
    Set-SecondaryButton $btnShow
    $btnShow.Add_Click({
        $txtKey.UseSystemPasswordChar = -not $txtKey.UseSystemPasswordChar
        $btnShow.Text = if ($txtKey.UseSystemPasswordChar) { 'Show' } else { 'Hide' }
    })

    # ── Model row ────────────────────────────────────
    $lblModel         = New-Object System.Windows.Forms.Label
    $lblModel.Text    = 'Model'
    $lblModel.Font    = $fontSubhead
    $lblModel.ForeColor = $colPurple
    $lblModel.Location= New-Object System.Drawing.Point(20, 82)
    $lblModel.AutoSize= $true

    $cmbDlgModel      = New-Object System.Windows.Forms.ComboBox
    $cmbDlgModel.Location   = New-Object System.Drawing.Point(20, 104)
    $cmbDlgModel.Width      = 200
    $cmbDlgModel.DropDownStyle = 'DropDownList'
    $cmbDlgModel.Font       = $fontInput
    $Script:ModelList | ForEach-Object { [void]$cmbDlgModel.Items.Add($_) }
    $cmbDlgModel.SelectedItem = if ($Global:Model) { $Global:Model } else { 'gpt-4.1' }

    # ── Action buttons ───────────────────────────────
    $btnSave          = New-Object System.Windows.Forms.Button
    $btnSave.Text     = 'Save'
    $btnSave.Size     = New-Object System.Drawing.Size(100, 34)
    $btnSave.Location = New-Object System.Drawing.Point(20, 148)
    Set-PrimaryButton $btnSave

    $btnCancel        = New-Object System.Windows.Forms.Button
    $btnCancel.Text   = 'Cancel'
    $btnCancel.Size   = New-Object System.Drawing.Size(90, 34)
    $btnCancel.Location = New-Object System.Drawing.Point(130, 148)
    Set-SecondaryButton $btnCancel

    $pnlC.Controls.AddRange(@($lblKey, $txtKey, $btnShow, $lblModel, $cmbDlgModel, $btnSave, $btnCancel))
    $dlg.AcceptButton = $btnSave
    $dlg.CancelButton = $btnCancel

    $btnSave.Add_Click({
        $key = $txtKey.Text.Trim()
        if (-not $key) {
            [System.Windows.Forms.MessageBox]::Show('API key cannot be empty.', 'Validation') | Out-Null
            return
        }
        Save-ApiKey  $key           $ConfigPath
        Save-Model   $cmbDlgModel.SelectedItem $ConfigPath
        $Global:ApiKey = $key
        $Global:Model  = $cmbDlgModel.SelectedItem
        # Sync model combo on main form if it exists
        if ($Script:cmbModel) { $Script:cmbModel.SelectedItem = $Global:Model }
        $dlg.Close()
    })

    $btnCancel.Add_Click({ $dlg.Close() })

    [void]$dlg.ShowDialog($form)
}
