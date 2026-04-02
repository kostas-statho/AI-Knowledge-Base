# ==============================================
# TAB 3  -  PRESENTATIONS
# ==============================================
$Script:PresentChatHistory = @()

$pnlPres = New-Object System.Windows.Forms.Panel
$pnlPres.Dock       = 'Fill'
$pnlPres.Padding    = New-Object System.Windows.Forms.Padding(10)
$pnlPres.BackColor  = $colBackground
$pnlPres.AutoScroll = $true
$tabPresentations.Controls.Add($pnlPres)

# ── Template section ──────────────────────────
$grpTemplate = New-Object System.Windows.Forms.GroupBox
$grpTemplate.Text     = 'Template'
$grpTemplate.Location = New-Object System.Drawing.Point(0, 0)
$grpTemplate.Size     = New-Object System.Drawing.Size(920, 70)
$grpTemplate.Font     = $fontSubhead
$pnlPres.Controls.Add($grpTemplate)

$txtTemplatePath = New-Object System.Windows.Forms.TextBox
$txtTemplatePath.Location  = New-Object System.Drawing.Point(10, 28)
$txtTemplatePath.Width     = 680
$txtTemplatePath.Font      = $fontInput
$txtTemplatePath.BackColor = $colPanel
$txtTemplatePath.Text      = "$($Global:PresentConfig.templatePath)"
$grpTemplate.Controls.Add($txtTemplatePath)

$btnBrowseTemplate = New-Object System.Windows.Forms.Button
$btnBrowseTemplate.Text     = 'Browse...'
$btnBrowseTemplate.Location = New-Object System.Drawing.Point(698, 25)
$btnBrowseTemplate.Width    = 90
Set-SecondaryButton $btnBrowseTemplate
$btnBrowseTemplate.Add_Click({
    $ofd = New-Object System.Windows.Forms.OpenFileDialog
    $ofd.Filter = 'PowerPoint (*.pptx;*.ppt)|*.pptx;*.ppt|All files (*.*)|*.*'
    if ($ofd.ShowDialog() -eq 'OK') {
        $txtTemplatePath.Text = $ofd.FileName
    }
})
$grpTemplate.Controls.Add($btnBrowseTemplate)

$btnSaveTemplate = New-Object System.Windows.Forms.Button
$btnSaveTemplate.Text     = 'Save Path'
$btnSaveTemplate.Location = New-Object System.Drawing.Point(796, 25)
$btnSaveTemplate.Width    = 90
Set-PrimaryButton $btnSaveTemplate
$btnSaveTemplate.Add_Click({
    $Global:PresentConfig.templatePath = $txtTemplatePath.Text.Trim()
    $Global:PresentConfig | ConvertTo-Json | Set-Content $PresentConfigPath -Encoding UTF8
    [System.Windows.Forms.MessageBox]::Show('Template path saved.','Saved') | Out-Null
})
$grpTemplate.Controls.Add($btnSaveTemplate)

# ── Create section ────────────────────────────
$grpCreate = New-Object System.Windows.Forms.GroupBox
$grpCreate.Text     = 'Create New Presentation'
$grpCreate.Location = New-Object System.Drawing.Point(0, 80)
$grpCreate.Size     = New-Object System.Drawing.Size(920, 110)
$grpCreate.Font     = $fontSubhead
$pnlPres.Controls.Add($grpCreate)

$lblPresName = New-Object System.Windows.Forms.Label
$lblPresName.Text     = 'File Name (without extension):'
$lblPresName.Location = New-Object System.Drawing.Point(10, 28)
$lblPresName.AutoSize = $true; $lblPresName.Font = $fontLabel
$grpCreate.Controls.Add($lblPresName)

$txtPresName = New-Object System.Windows.Forms.TextBox
$txtPresName.Location  = New-Object System.Drawing.Point(10, 46)
$txtPresName.Width     = 400
$txtPresName.Font      = $fontInput; $txtPresName.BackColor = $colPanel
$grpCreate.Controls.Add($txtPresName)

$lblOutputDir = New-Object System.Windows.Forms.Label
$lblOutputDir.Text     = 'Output Folder:'
$lblOutputDir.Location = New-Object System.Drawing.Point(10, 72)
$lblOutputDir.AutoSize = $true; $lblOutputDir.Font = $fontLabel
$grpCreate.Controls.Add($lblOutputDir)

$txtOutputDir = New-Object System.Windows.Forms.TextBox
$txtOutputDir.Location  = New-Object System.Drawing.Point(10, 88)
$txtOutputDir.Width     = 600; $txtOutputDir.Font = $fontInput; $txtOutputDir.BackColor = $colPanel
$txtOutputDir.Text      = "$($Global:PresentConfig.outputDirectory)"
$grpCreate.Controls.Add($txtOutputDir)

$btnBrowseOutput = New-Object System.Windows.Forms.Button
$btnBrowseOutput.Text     = 'Browse...'
$btnBrowseOutput.Location = New-Object System.Drawing.Point(618, 85)
$btnBrowseOutput.Width    = 90
Set-SecondaryButton $btnBrowseOutput
$btnBrowseOutput.Add_Click({
    $fbd = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($fbd.ShowDialog() -eq 'OK') { $txtOutputDir.Text = $fbd.SelectedPath }
})
$grpCreate.Controls.Add($btnBrowseOutput)

$btnCreatePres = New-Object System.Windows.Forms.Button
$btnCreatePres.Text     = 'Create from Template'
$btnCreatePres.Location = New-Object System.Drawing.Point(718, 85)
$btnCreatePres.Width    = 170
Set-PrimaryButton $btnCreatePres
$grpCreate.Controls.Add($btnCreatePres)

# ── Extra Notes ───────────────────────────────
$grpNotes = New-Object System.Windows.Forms.GroupBox
$grpNotes.Text     = 'Extra Notes / Outline (optional)'
$grpNotes.Location = New-Object System.Drawing.Point(0, 200)
$grpNotes.Size     = New-Object System.Drawing.Size(920, 130)
$grpNotes.Font     = $fontSubhead
$pnlPres.Controls.Add($grpNotes)

$txtPresNotes = New-Object System.Windows.Forms.TextBox
$txtPresNotes.Location   = New-Object System.Drawing.Point(10, 22)
$txtPresNotes.Size       = New-Object System.Drawing.Size(895, 96)
$txtPresNotes.Multiline  = $true
$txtPresNotes.ScrollBars = 'Vertical'
$txtPresNotes.Font       = $fontInput; $txtPresNotes.BackColor = $colPanel
$grpNotes.Controls.Add($txtPresNotes)

# ── Chat ─────────────────────────────────────
$grpPresChat = New-Object System.Windows.Forms.GroupBox
$grpPresChat.Text     = 'Chat (advisory)'
$grpPresChat.Location = New-Object System.Drawing.Point(0, 340)
$grpPresChat.Size     = New-Object System.Drawing.Size(920, 155)
$grpPresChat.Font     = $fontSubhead
$pnlPres.Controls.Add($grpPresChat)

$txtPresChat = New-Object System.Windows.Forms.TextBox
$txtPresChat.Location = New-Object System.Drawing.Point(10, 26)
$txtPresChat.Width    = 700; $txtPresChat.Font = $fontInput; $txtPresChat.BackColor = $colPanel
$grpPresChat.Controls.Add($txtPresChat)

$btnApplySuggestion = New-Object System.Windows.Forms.Button
$btnApplySuggestion.Text     = 'Apply suggestion'
$btnApplySuggestion.Location = New-Object System.Drawing.Point(718, 23)
$btnApplySuggestion.Width    = 160
Set-SecondaryButton $btnApplySuggestion
$grpPresChat.Controls.Add($btnApplySuggestion)

$rtbPresResponse = New-Object System.Windows.Forms.RichTextBox
$rtbPresResponse.Location   = New-Object System.Drawing.Point(10, 54)
$rtbPresResponse.Size       = New-Object System.Drawing.Size(868, 72)
$rtbPresResponse.Font       = $fontCaption
$rtbPresResponse.BackColor  = $colPanel
$rtbPresResponse.ReadOnly   = $true
$rtbPresResponse.ScrollBars = 'Vertical'
$rtbPresResponse.Text       = ''
$grpPresChat.Controls.Add($rtbPresResponse)

$lblPresChatStatus = New-Object System.Windows.Forms.Label
$lblPresChatStatus.Location = New-Object System.Drawing.Point(10, 132)
$lblPresChatStatus.AutoSize = $true
$lblPresChatStatus.Font     = $fontCaption
$lblPresChatStatus.ForeColor = $colTextMuted
$grpPresChat.Controls.Add($lblPresChatStatus)

# ── Recent ────────────────────────────────────
$grpRecent = New-Object System.Windows.Forms.GroupBox
$grpRecent.Text     = 'Recent'
$grpRecent.Location = New-Object System.Drawing.Point(0, 505)
$grpRecent.Size     = New-Object System.Drawing.Size(920, 130)
$grpRecent.Font     = $fontSubhead
$pnlPres.Controls.Add($grpRecent)

$lstRecent = New-Object System.Windows.Forms.ListBox
$lstRecent.Location  = New-Object System.Drawing.Point(10, 22)
$lstRecent.Size      = New-Object System.Drawing.Size(790, 96)
$lstRecent.Font      = $fontLabel
foreach ($r in @($Global:PresentConfig.recent)) { if ($r) { [void]$lstRecent.Items.Add($r) } }
$grpRecent.Controls.Add($lstRecent)

$btnOpenRecent = New-Object System.Windows.Forms.Button
$btnOpenRecent.Text     = 'Open'
$btnOpenRecent.Location = New-Object System.Drawing.Point(808, 22)
$btnOpenRecent.Width    = 80
Set-SecondaryButton $btnOpenRecent
$btnOpenRecent.Add_Click({
    if ($lstRecent.SelectedItem) { Start-Process "$($lstRecent.SelectedItem)" }
})
$grpRecent.Controls.Add($btnOpenRecent)

# ── Create handler ────────────────────────────
$btnCreatePres.Add_Click({
    $template = $txtTemplatePath.Text.Trim()
    $name     = $txtPresName.Text.Trim()
    $outDir   = $txtOutputDir.Text.Trim()

    if (-not $template) { [System.Windows.Forms.MessageBox]::Show('Please specify a template path.','Required') | Out-Null; return }
    if (-not (Test-Path $template)) { [System.Windows.Forms.MessageBox]::Show('Template file not found.','Error') | Out-Null; return }
    if (-not $name)    { [System.Windows.Forms.MessageBox]::Show('Please enter a file name.','Required') | Out-Null; return }
    if (-not $outDir)  { [System.Windows.Forms.MessageBox]::Show('Please select an output folder.','Required') | Out-Null; return }
    if (-not (Test-Path $outDir)) { New-Item $outDir -ItemType Directory | Out-Null }

    $outputPath = Join-Path $outDir "$name.pptx"
    try {
        Copy-Item -Path $template -Destination $outputPath -Force

        $notes = $txtPresNotes.Text.Trim()
        if ($notes) {
            $notesPath = Join-Path $outDir "$name`_notes.txt"
            $notes | Set-Content $notesPath -Encoding UTF8
        }

        Start-Process $outputPath

        # Update recent list
        $recent = @($outputPath) + @($Global:PresentConfig.recent | Where-Object { $_ -ne $outputPath }) | Select-Object -First 10
        $Global:PresentConfig.recent          = $recent
        $Global:PresentConfig.outputDirectory = $outDir
        $Global:PresentConfig.templatePath    = $template
        $Global:PresentConfig | ConvertTo-Json | Set-Content $PresentConfigPath -Encoding UTF8

        $lstRecent.Items.Clear()
        foreach ($r in $recent) { if ($r) { [void]$lstRecent.Items.Add($r) } }

        $lblPresChatStatus.Text = "Created: $outputPath"
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to create presentation:`n$_",'Error') | Out-Null
    }
})

# ── Chat/Advisory handler ─────────────────────
$btnApplySuggestion.Add_Click({
    $suggestion = $txtPresChat.Text.Trim()
    if (-not $suggestion) {
        [System.Windows.Forms.MessageBox]::Show('Enter a suggestion first.','Required') | Out-Null
        return
    }

    $lblPresChatStatus.Text     = ''
    $btnApplySuggestion.Enabled = $false
    $txtPresChat.Enabled        = $false
    $txtPresNotes.Enabled       = $false
    $lblPresChatStatus.Text     = 'Getting AI suggestion...'

    $style = $Global:PresentStyle
    $prof  = $Global:Profile
    $profRole = if ($prof.PSObject.Properties['role']) { $prof.role } else { 'OIM Developer' }
    $profOrg  = if ($prof.PSObject.Properties['organisation']) { $prof.organisation } else { '' }

    $sysMsg = @"
You are a presentation advisor for $profOrg. The user is a $profRole.
Presentation style preferences:
- Colour scheme: $($style.colourScheme)
- Tone: $($style.tone)
- Target audience: $($style.targetAudience)
- Language: $($style.language)
- Branding notes: $($style.brandingNotes)

Provide concise, actionable advice the user can apply manually in PowerPoint.
"@

    $notes    = $txtPresNotes.Text.Trim()
    $template = $txtTemplatePath.Text.Trim()
    $userMsg  = "Template: $template`n`nCurrent notes:`n$notes`n`nUser request: $suggestion"

    $Script:PresentChatHistory += @{ role = 'user'; content = $userMsg }

    $msgs = @(@{ role = 'system'; content = $sysMsg }) + $Script:PresentChatHistory

    $pp = Get-ProviderParams 'providerPresent'
    $params = @{
        ApiKey      = $pp.ApiKey
        Model       = $pp.Model
        Provider    = $pp.Provider
        SystemMsg   = ''; UserMsg = ''
        MaxTokens   = 1500
        JsonMode    = $false
        Messages    = $msgs
        Temperature = [double]$Global:OAISettings.temperature
        TopP        = [double]$Global:OAISettings.topP
    }

    Invoke-Async $Script:ApiCallScript $params {
        param($result)
        $advice = $result[0]
        $Script:PresentChatHistory += @{ role = 'assistant'; content = $advice }

        $current = $txtPresNotes.Text.Trim()
        $sep     = if ($current) { "`r`n`r`n--- AI Suggestion ---`r`n" } else { '--- AI Suggestion ---`r`n' }
        $txtPresNotes.Text = $current + $sep + $advice

        $rtbPresResponse.Text = $advice

        $t = Get-Date -Format 'HH:mm'
        $lblPresChatStatus.Text     = "Suggestion added ($t)  ($($result[1]) tokens)"
        $btnApplySuggestion.Enabled = $true
        $txtPresChat.Enabled        = $true
        $txtPresNotes.Enabled       = $true
        $txtPresChat.Clear()
    } {
        param($err)
        Write-ErrorLog "Presentations: $err"
        $lblPresChatStatus.Text     = "Error: $err"
        $btnApplySuggestion.Enabled = $true
        $txtPresChat.Enabled        = $true
        $txtPresNotes.Enabled       = $true
    }
})
