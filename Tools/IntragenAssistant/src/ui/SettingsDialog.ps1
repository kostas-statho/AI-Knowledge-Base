# ----------------------------------------------
# SETTINGS DIALOG — tabbed: API / Presentation Style / Doc Style / Profile / Models & Providers
# ----------------------------------------------
function Show-SettingsDialog {
    $dlg = New-Object System.Windows.Forms.Form
    $dlg.Text            = 'Settings'
    $dlg.Size            = New-Object System.Drawing.Size(560, 580)
    $dlg.StartPosition   = 'CenterParent'
    $dlg.FormBorderStyle = 'FixedDialog'
    $dlg.MaximizeBox     = $false
    $dlg.BackColor       = $colBackground

    $dlgTabs = New-Object System.Windows.Forms.TabControl
    $dlgTabs.Location = New-Object System.Drawing.Point(8, 8)
    $dlgTabs.Size     = New-Object System.Drawing.Size(532, 490)
    $dlg.Controls.Add($dlgTabs)

    # ── Tab: API ──────────────────────────────
    $tAPI = New-Object System.Windows.Forms.TabPage('API')
    $dlgTabs.TabPages.Add($tAPI)

    $y = 12
    function Dlg-Label($text, $tabPage, $yPos) {
        $l = New-Object System.Windows.Forms.Label
        $l.Text = $text; $l.Location = New-Object System.Drawing.Point(10, $yPos)
        $l.AutoSize = $true; $l.Font = $fontLabel
        $tabPage.Controls.Add($l)
    }
    function Dlg-TextBox($tabPage, $yPos, $width = 490, $pass = $false) {
        $t = New-Object System.Windows.Forms.TextBox
        $t.Location = New-Object System.Drawing.Point(10, $yPos)
        $t.Width = $width; $t.Font = $fontInput
        $t.BackColor = $colPanel
        if ($pass) { $t.PasswordChar = '*' }
        $tabPage.Controls.Add($t)
        return $t
    }

    Dlg-Label 'OpenAI API Key:' $tAPI 12
    $txtKey = Dlg-TextBox $tAPI 30 490 $true
    $txtKey.Text = if ($Global:ApiKey) { $Global:ApiKey } else { '' }

    Dlg-Label 'Model:' $tAPI 70
    $txtModel = Dlg-TextBox $tAPI 88 220
    $txtModel.Text = $Global:OAISettings.model

    Dlg-Label 'Temperature (0.0–2.0):' $tAPI 118
    $txtTemp = Dlg-TextBox $tAPI 136 80
    $txtTemp.Text = "$($Global:OAISettings.temperature)"

    Dlg-Label 'Max Tokens:' $tAPI 166
    $txtMaxTok = Dlg-TextBox $tAPI 184 80
    $txtMaxTok.Text = "$($Global:OAISettings.maxTokens)"

    Dlg-Label 'System prompt append (optional):' $tAPI 214
    $txtSysAppend = Dlg-TextBox $tAPI 232 490
    $txtSysAppend.Text = "$($Global:OAISettings.systemPromptAppend)"

    Dlg-Label 'SQL Library Path (for Tab2 browser):' $tAPI 262
    $txtSqlLib = Dlg-TextBox $tAPI 280 400
    $txtSqlLib.Text = "$($Global:OAISettings.sqlLibraryPath)"
    $ttip = New-Object System.Windows.Forms.ToolTip
    $ttip.SetToolTip($txtSqlLib, 'Root folder for .sql files — Tab 2 browser lists all .sql recursively')
    $btnBrowseSqlLib = New-Object System.Windows.Forms.Button
    $btnBrowseSqlLib.Text     = 'Browse...'
    $btnBrowseSqlLib.Location = New-Object System.Drawing.Point(418, 278)
    $btnBrowseSqlLib.Width    = 80
    Set-SecondaryButton $btnBrowseSqlLib
    $btnBrowseSqlLib.Add_Click({
        $fbd = New-Object System.Windows.Forms.FolderBrowserDialog
        $fbd.Description = 'Select root folder of your SQL library'
        if ($fbd.ShowDialog() -eq 'OK') { $txtSqlLib.Text = $fbd.SelectedPath }
    })
    $tAPI.Controls.Add($btnBrowseSqlLib)

    $btnTestKey = New-Object System.Windows.Forms.Button
    $btnTestKey.Text     = 'Test Key'
    $btnTestKey.Location = New-Object System.Drawing.Point(10, 320)
    $btnTestKey.Width    = 90
    Set-SecondaryButton $btnTestKey
    $btnTestKey.Add_Click({
        $key = $txtKey.Text.Trim()
        if (-not $key) { [System.Windows.Forms.MessageBox]::Show('Enter a key first.','Required') | Out-Null; return }
        $btnTestKey.Enabled = $false; $btnTestKey.Text = 'Testing...'
        try {
            $body = '{"model":"gpt-4o","messages":[{"role":"user","content":"Hi"}],"max_tokens":1}'
            $wc = New-Object System.Net.WebClient
            $wc.Encoding = [System.Text.Encoding]::UTF8
            $wc.Headers.Add('Authorization', "Bearer $key")
            $wc.Headers.Add('Content-Type', 'application/json')
            $resp = $wc.UploadString('https://api.openai.com/v1/chat/completions', $body) | ConvertFrom-Json
            if ($resp.choices) { [System.Windows.Forms.MessageBox]::Show('API key is valid.','Success') | Out-Null }
        } catch {
            $msg = if ($_.Exception.InnerException) { $_.Exception.InnerException.Message } else { $_.Exception.Message }
            [System.Windows.Forms.MessageBox]::Show("Key test failed:`n$msg",'Error') | Out-Null
        }
        $btnTestKey.Enabled = $true; $btnTestKey.Text = 'Test Key'
    })
    $tAPI.Controls.Add($btnTestKey)

    # ── Tab: Presentation Style ───────────────
    $tPS = New-Object System.Windows.Forms.TabPage('Presentation Style')
    $dlgTabs.TabPages.Add($tPS)

    Dlg-Label 'Colour Scheme:' $tPS 12
    $txtPSColour = Dlg-TextBox $tPS 30 300
    $txtPSColour.Text = "$($Global:PresentStyle.colourScheme)"

    Dlg-Label 'Tone:' $tPS 62
    $cboPSTone = New-Object System.Windows.Forms.ComboBox
    $cboPSTone.DropDownStyle = 'DropDownList'
    @('Professional','Formal','Casual','Technical','Friendly') | ForEach-Object { [void]$cboPSTone.Items.Add($_) }
    $cboPSTone.Location = New-Object System.Drawing.Point(10, 80); $cboPSTone.Width = 180
    $cboPSTone.Font = $fontInput
    $sel = $Global:PresentStyle.tone
    if ($cboPSTone.Items.Contains($sel)) { $cboPSTone.SelectedItem = $sel } else { $cboPSTone.SelectedIndex = 0 }
    $tPS.Controls.Add($cboPSTone)

    Dlg-Label 'Target Audience:' $tPS 112
    $txtPSAudience = Dlg-TextBox $tPS 130 300
    $txtPSAudience.Text = "$($Global:PresentStyle.targetAudience)"

    Dlg-Label 'Language:' $tPS 162
    $txtPSLang = Dlg-TextBox $tPS 180 150
    $txtPSLang.Text = "$($Global:PresentStyle.language)"

    Dlg-Label 'Branding Notes:' $tPS 212
    $txtPSBrand = New-Object System.Windows.Forms.TextBox
    $txtPSBrand.Location = New-Object System.Drawing.Point(10, 230); $txtPSBrand.Width = 490; $txtPSBrand.Height = 60
    $txtPSBrand.Multiline = $true; $txtPSBrand.Font = $fontInput; $txtPSBrand.BackColor = $colPanel
    $txtPSBrand.Text = "$($Global:PresentStyle.brandingNotes)"
    $tPS.Controls.Add($txtPSBrand)

    # ── Tab: Documentation Style ──────────────
    $tDS = New-Object System.Windows.Forms.TabPage('Documentation Style')
    $dlgTabs.TabPages.Add($tDS)

    Dlg-Label 'Format:' $tDS 12
    $cboDSFormat = New-Object System.Windows.Forms.ComboBox
    $cboDSFormat.DropDownStyle = 'DropDownList'
    @('Markdown','HTML','Plain Text') | ForEach-Object { [void]$cboDSFormat.Items.Add($_) }
    $cboDSFormat.Location = New-Object System.Drawing.Point(10, 30); $cboDSFormat.Width = 150
    $cboDSFormat.Font = $fontInput
    $selF = $Global:DocStyle.format
    if ($cboDSFormat.Items.Contains($selF)) { $cboDSFormat.SelectedItem = $selF } else { $cboDSFormat.SelectedIndex = 0 }
    $tDS.Controls.Add($cboDSFormat)

    Dlg-Label 'Tone:' $tDS 62
    $cboDSTone = New-Object System.Windows.Forms.ComboBox
    $cboDSTone.DropDownStyle = 'DropDownList'
    @('Formal','Technical','Professional','Casual','Friendly') | ForEach-Object { [void]$cboDSTone.Items.Add($_) }
    $cboDSTone.Location = New-Object System.Drawing.Point(10, 80); $cboDSTone.Width = 180; $cboDSTone.Font = $fontInput
    $selDT = $Global:DocStyle.tone
    if ($cboDSTone.Items.Contains($selDT)) { $cboDSTone.SelectedItem = $selDT } else { $cboDSTone.SelectedIndex = 0 }
    $tDS.Controls.Add($cboDSTone)

    Dlg-Label 'Target Audience:' $tDS 112
    $txtDSAudience = Dlg-TextBox $tDS 130 300
    $txtDSAudience.Text = "$($Global:DocStyle.targetAudience)"

    Dlg-Label 'Language:' $tDS 162
    $txtDSLang = Dlg-TextBox $tDS 180 150
    $txtDSLang.Text = "$($Global:DocStyle.language)"

    Dlg-Label 'Branding Notes:' $tDS 212
    $txtDSBrand = New-Object System.Windows.Forms.TextBox
    $txtDSBrand.Location = New-Object System.Drawing.Point(10, 230); $txtDSBrand.Width = 490; $txtDSBrand.Height = 60
    $txtDSBrand.Multiline = $true; $txtDSBrand.Font = $fontInput; $txtDSBrand.BackColor = $colPanel
    $txtDSBrand.Text = "$($Global:DocStyle.brandingNotes)"
    $tDS.Controls.Add($txtDSBrand)

    # ── Tab: Profile ──────────────────────────
    $tProf = New-Object System.Windows.Forms.TabPage('Profile')
    $dlgTabs.TabPages.Add($tProf)

    Dlg-Label 'Name:' $tProf 12
    $txtProfName = Dlg-TextBox $tProf 30 300
    $txtProfName.Text = "$($Global:Profile.name)"

    Dlg-Label 'Role:' $tProf 62
    $txtProfRole = Dlg-TextBox $tProf 80 300
    $txtProfRole.Text = if ($Global:Profile.PSObject.Properties['role']) { "$($Global:Profile.role)" } else { 'OIM Developer' }

    Dlg-Label 'Organisation:' $tProf 112
    $txtProfOrg = Dlg-TextBox $tProf 130 300
    $txtProfOrg.Text = if ($Global:Profile.PSObject.Properties['organisation']) { "$($Global:Profile.organisation)" } else { 'Intragen' }

    # ── Tab: Models & Providers ───────────────
    $tMP = New-Object System.Windows.Forms.TabPage('Models & Providers')
    $dlgTabs.TabPages.Add($tMP)

    # Section 1 — API Keys
    $lblMPKeys = New-Object System.Windows.Forms.Label
    $lblMPKeys.Text = 'API Keys'
    $lblMPKeys.Location = New-Object System.Drawing.Point(10, 10)
    $lblMPKeys.AutoSize = $true; $lblMPKeys.Font = $fontSubhead
    $tMP.Controls.Add($lblMPKeys)

    Dlg-Label 'Anthropic (Claude) Key:' $tMP 34
    $txtAnthropicKey = Dlg-TextBox $tMP 52 390 $true
    $txtAnthropicKey.Text = if ($Global:AnthropicKey) { $Global:AnthropicKey } else { '' }

    $btnTestAnthropic = New-Object System.Windows.Forms.Button
    $btnTestAnthropic.Text     = 'Test'
    $btnTestAnthropic.Location = New-Object System.Drawing.Point(408, 50)
    $btnTestAnthropic.Width    = 80
    Set-SecondaryButton $btnTestAnthropic
    $btnTestAnthropic.Add_Click({
        $key = $txtAnthropicKey.Text.Trim()
        if (-not $key) { [System.Windows.Forms.MessageBox]::Show('Enter a key first.','Required') | Out-Null; return }
        $btnTestAnthropic.Enabled = $false; $btnTestAnthropic.Text = 'Testing...'
        try {
            $body = '{"model":"claude-haiku-4-5-20251001","max_tokens":1,"messages":[{"role":"user","content":"Hi"}]}'
            $wc2 = New-Object System.Net.WebClient
            $wc2.Encoding = [System.Text.Encoding]::UTF8
            $wc2.Headers.Add('x-api-key', $key)
            $wc2.Headers.Add('anthropic-version', '2023-06-01')
            $wc2.Headers.Add('Content-Type', 'application/json')
            $resp = $wc2.UploadString('https://api.anthropic.com/v1/messages', $body) | ConvertFrom-Json
            if ($resp.content) { [System.Windows.Forms.MessageBox]::Show('Anthropic key is valid.','Success') | Out-Null }
        } catch {
            $msg = if ($_.Exception.InnerException) { $_.Exception.InnerException.Message } else { $_.Exception.Message }
            [System.Windows.Forms.MessageBox]::Show("Key test failed:`n$msg",'Error') | Out-Null
        }
        $btnTestAnthropic.Enabled = $true; $btnTestAnthropic.Text = 'Test'
    })
    $tMP.Controls.Add($btnTestAnthropic)

    Dlg-Label 'Grok (xAI) Key:' $tMP 82
    $txtGrokKey = Dlg-TextBox $tMP 100 390 $true
    $txtGrokKey.Text = if ($Global:GrokKey) { $Global:GrokKey } else { '' }

    $btnTestGrok = New-Object System.Windows.Forms.Button
    $btnTestGrok.Text     = 'Test'
    $btnTestGrok.Location = New-Object System.Drawing.Point(408, 98)
    $btnTestGrok.Width    = 80
    Set-SecondaryButton $btnTestGrok
    $btnTestGrok.Add_Click({
        $key = $txtGrokKey.Text.Trim()
        if (-not $key) { [System.Windows.Forms.MessageBox]::Show('Enter a key first.','Required') | Out-Null; return }
        $btnTestGrok.Enabled = $false; $btnTestGrok.Text = 'Testing...'
        try {
            $body = '{"model":"grok-3-fast","messages":[{"role":"user","content":"Hi"}],"max_completion_tokens":1}'
            $wc3 = New-Object System.Net.WebClient
            $wc3.Encoding = [System.Text.Encoding]::UTF8
            $wc3.Headers.Add('Authorization', "Bearer $key")
            $wc3.Headers.Add('Content-Type', 'application/json')
            $resp = $wc3.UploadString('https://api.x.ai/v1/chat/completions', $body) | ConvertFrom-Json
            if ($resp.choices) { [System.Windows.Forms.MessageBox]::Show('Grok key is valid.','Success') | Out-Null }
        } catch {
            $msg = if ($_.Exception.InnerException) { $_.Exception.InnerException.Message } else { $_.Exception.Message }
            [System.Windows.Forms.MessageBox]::Show("Key test failed:`n$msg",'Error') | Out-Null
        }
        $btnTestGrok.Enabled = $true; $btnTestGrok.Text = 'Test'
    })
    $tMP.Controls.Add($btnTestGrok)

    # Section 2 — Provider per Tab
    $lblMPProv = New-Object System.Windows.Forms.Label
    $lblMPProv.Text = 'Provider per Tab'
    $lblMPProv.Location = New-Object System.Drawing.Point(10, 138)
    $lblMPProv.AutoSize = $true; $lblMPProv.Font = $fontSubhead
    $tMP.Controls.Add($lblMPProv)

    $provItems = @('openai','claude','grok')
    $provY = 162
    $provRows = @(
        @{ label = 'Query Evaluator:';      key = 'providerQueryEval' }
        @{ label = 'Goals (SWOT/plans):';   key = 'providerGoals'     }
        @{ label = 'Meeting Notes:';        key = 'providerMeeting'   }
        @{ label = 'Presentations:';        key = 'providerPresent'   }
        @{ label = 'Doc Builder:';          key = 'providerDocBuild'  }
    )
    $provCombos = @{}
    foreach ($row in $provRows) {
        $lbl2 = New-Object System.Windows.Forms.Label
        $lbl2.Text = $row.label; $lbl2.Location = New-Object System.Drawing.Point(10, ($provY + 4))
        $lbl2.Width = 165; $lbl2.Font = $fontLabel
        $tMP.Controls.Add($lbl2)

        $cbo = New-Object System.Windows.Forms.ComboBox
        $cbo.DropDownStyle = 'DropDownList'
        $provItems | ForEach-Object { [void]$cbo.Items.Add($_) }
        $cbo.Location = New-Object System.Drawing.Point(180, $provY)
        $cbo.Width = 140; $cbo.Font = $fontInput
        $cur = if ($Global:OAISettings.PSObject.Properties[$row.key]) { $Global:OAISettings.($row.key) } else { 'openai' }
        if ($cbo.Items.Contains($cur)) { $cbo.SelectedItem = $cur } else { $cbo.SelectedIndex = 0 }
        $tMP.Controls.Add($cbo)
        $provCombos[$row.key] = $cbo
        $provY += 30
    }

    # Section 3 — Model per Provider
    $lblMPMod = New-Object System.Windows.Forms.Label
    $lblMPMod.Text = 'Model per Provider'
    $lblMPMod.Location = New-Object System.Drawing.Point(10, ($provY + 10))
    $lblMPMod.AutoSize = $true; $lblMPMod.Font = $fontSubhead
    $tMP.Controls.Add($lblMPMod)

    $modY = $provY + 34
    Dlg-Label 'Claude model:' $tMP $modY
    $txtClaudeModel = Dlg-TextBox $tMP ($modY + 18) 300
    $txtClaudeModel.Text = "$($Global:OAISettings.claudeModel)"

    $modY += 50
    Dlg-Label 'Grok model:' $tMP $modY
    $txtGrokModel = Dlg-TextBox $tMP ($modY + 18) 300
    $txtGrokModel.Text = "$($Global:OAISettings.grokModel)"

    # ── Save / Cancel ─────────────────────────
    $btnSave = New-Object System.Windows.Forms.Button
    $btnSave.Text     = 'Save All'
    $btnSave.Location = New-Object System.Drawing.Point(10, 508)
    $btnSave.Width    = 100
    Set-PrimaryButton $btnSave
    $btnSave.Add_Click({
        # API Key
        if ($txtKey.Text.Trim()) {
            Save-ApiKey $txtKey.Text.Trim()
            $Global:ApiKey = $txtKey.Text.Trim()
        }
        # OAI Settings
        $Global:OAISettings.model = $txtModel.Text.Trim()
        if ((Get-Variable cboModel -EA SilentlyContinue) -and $cboModel.Items.Contains($Global:OAISettings.model)) {
            $cboModel.SelectedItem = $Global:OAISettings.model
        }
        $Global:OAISettings.temperature        = [double]$txtTemp.Text
        $Global:OAISettings.maxTokens          = [int]$txtMaxTok.Text
        $Global:OAISettings.systemPromptAppend = $txtSysAppend.Text.Trim()
        if (-not $Global:OAISettings.PSObject.Properties['sqlLibraryPath']) {
            $Global:OAISettings | Add-Member -NotePropertyName 'sqlLibraryPath' -NotePropertyValue ''
        }
        $Global:OAISettings.sqlLibraryPath = $txtSqlLib.Text.Trim()

        # Models & Providers
        $anthropicKeyNew = $txtAnthropicKey.Text.Trim()
        if ($anthropicKeyNew) { Save-AnthropicKey $anthropicKeyNew; $Global:AnthropicKey = $anthropicKeyNew }
        $grokKeyNew = $txtGrokKey.Text.Trim()
        if ($grokKeyNew) { Save-GrokKey $grokKeyNew; $Global:GrokKey = $grokKeyNew }

        $Global:OAISettings.claudeModel = $txtClaudeModel.Text.Trim()
        $Global:OAISettings.grokModel   = $txtGrokModel.Text.Trim()
        foreach ($row in $provRows) {
            $Global:OAISettings.($row.key) = $provCombos[$row.key].SelectedItem
        }

        $Global:OAISettings | ConvertTo-Json | Set-Content $OAISettingsPath -Encoding UTF8
        if (Get-Command Refresh-SqlLibrary -EA SilentlyContinue) { Refresh-SqlLibrary }

        # Presentation Style
        $Global:PresentStyle.colourScheme   = $txtPSColour.Text.Trim()
        $Global:PresentStyle.tone           = $cboPSTone.SelectedItem
        $Global:PresentStyle.targetAudience = $txtPSAudience.Text.Trim()
        $Global:PresentStyle.language       = $txtPSLang.Text.Trim()
        $Global:PresentStyle.brandingNotes  = $txtPSBrand.Text.Trim()
        $Global:PresentStyle | ConvertTo-Json | Set-Content $PresentStylePath -Encoding UTF8

        # Documentation Style
        $Global:DocStyle.format               = $cboDSFormat.SelectedItem
        $Global:DocStyle.tone                 = $cboDSTone.SelectedItem
        $Global:DocStyle.targetAudience       = $txtDSAudience.Text.Trim()
        $Global:DocStyle.language             = $txtDSLang.Text.Trim()
        $Global:DocStyle.brandingNotes        = $txtDSBrand.Text.Trim()
        $Global:DocStyle | ConvertTo-Json | Set-Content $DocStylePath -Encoding UTF8

        # Profile basics
        $Global:Profile.name = $txtProfName.Text.Trim()
        if (-not $Global:Profile.PSObject.Properties['role']) {
            $Global:Profile | Add-Member -NotePropertyName 'role' -NotePropertyValue ''
        }
        if (-not $Global:Profile.PSObject.Properties['organisation']) {
            $Global:Profile | Add-Member -NotePropertyName 'organisation' -NotePropertyValue ''
        }
        $Global:Profile.role         = $txtProfRole.Text.Trim()
        $Global:Profile.organisation = $txtProfOrg.Text.Trim()
        Save-Profile $Global:Profile $ProfilePath

        [System.Windows.Forms.MessageBox]::Show('Settings saved.','Saved') | Out-Null
        $dlg.Close()
    })

    $btnCancel = New-Object System.Windows.Forms.Button
    $btnCancel.Text     = 'Cancel'
    $btnCancel.Location = New-Object System.Drawing.Point(120, 508)
    $btnCancel.Width    = 80
    Set-SecondaryButton $btnCancel
    $btnCancel.Add_Click({ $dlg.Close() })

    $dlg.Controls.AddRange(@($btnSave, $btnCancel))
    $dlg.ShowDialog() | Out-Null
}
