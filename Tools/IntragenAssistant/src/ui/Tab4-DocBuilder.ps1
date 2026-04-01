# ==============================================
# TAB 4  -  DOC BUILDER
# Transform raw notes → Intragen-style documentation
# ==============================================
$Script:DocHistory  = @()
$Script:DocRound    = 0

$pnlDoc = New-Object System.Windows.Forms.Panel
$pnlDoc.Dock      = 'Fill'
$pnlDoc.Padding   = New-Object System.Windows.Forms.Padding(10)
$pnlDoc.BackColor = $colBackground
$tabDocBuilder.Controls.Add($pnlDoc)

# ── Doc Type + Format ─────────────────────────
$lblDocType = New-Object System.Windows.Forms.Label
$lblDocType.Text     = 'Doc Type:'
$lblDocType.Location = New-Object System.Drawing.Point(0, 0)
$lblDocType.AutoSize = $true; $lblDocType.Font = $fontSubhead
$pnlDoc.Controls.Add($lblDocType)

$cboDocType = New-Object System.Windows.Forms.ComboBox
$cboDocType.DropDownStyle = 'DropDownList'
@('Module Guide','Code Documentation','SQL Reference','Meeting Notes','Training Material','Custom') | ForEach-Object { [void]$cboDocType.Items.Add($_) }
$cboDocType.SelectedIndex = 0
$cboDocType.Location = New-Object System.Drawing.Point(80, 0)
$cboDocType.Width    = 180; $cboDocType.Font = $fontInput
$pnlDoc.Controls.Add($cboDocType)

$lblFormat = New-Object System.Windows.Forms.Label
$lblFormat.Text     = 'Format:'
$lblFormat.Location = New-Object System.Drawing.Point(272, 0)
$lblFormat.AutoSize = $true; $lblFormat.Font = $fontSubhead
$pnlDoc.Controls.Add($lblFormat)

$cboFormat = New-Object System.Windows.Forms.ComboBox
$cboFormat.DropDownStyle = 'DropDownList'
@('Markdown','HTML','Plain Text') | ForEach-Object { [void]$cboFormat.Items.Add($_) }
$selFmt = "$($Global:DocStyle.format)"
if ($cboFormat.Items.Contains($selFmt)) { $cboFormat.SelectedItem = $selFmt } else { $cboFormat.SelectedIndex = 0 }
$cboFormat.Location = New-Object System.Drawing.Point(330, 0)
$cboFormat.Width    = 140; $cboFormat.Font = $fontInput
$pnlDoc.Controls.Add($cboFormat)

# ── Raw Notes Input ───────────────────────────
$lblRawNotes = New-Object System.Windows.Forms.Label
$lblRawNotes.Text     = 'Raw Notes / Source Content:'
$lblRawNotes.Location = New-Object System.Drawing.Point(0, 36)
$lblRawNotes.AutoSize = $true; $lblRawNotes.Font = $fontSubhead
$pnlDoc.Controls.Add($lblRawNotes)

$btnBrowseNotes = New-Object System.Windows.Forms.Button
$btnBrowseNotes.Text     = 'Browse file...'
$btnBrowseNotes.Location = New-Object System.Drawing.Point(780, 32)
$btnBrowseNotes.Width    = 120
Set-SecondaryButton $btnBrowseNotes
$btnBrowseNotes.Add_Click({
    $ofd = New-Object System.Windows.Forms.OpenFileDialog
    $ofd.Filter = 'Text files|*.md;*.txt;*.sql;*.cs;*.ps1;*.psm1|All files (*.*)|*.*'
    if ($ofd.ShowDialog() -eq 'OK') {
        $txtRawNotes.Text = Get-Content $ofd.FileName -Raw -Encoding UTF8
    }
})
$pnlDoc.Controls.Add($btnBrowseNotes)

$txtRawNotes = New-Object System.Windows.Forms.TextBox
$txtRawNotes.Location   = New-Object System.Drawing.Point(0, 58)
$txtRawNotes.Size       = New-Object System.Drawing.Size(910, 140)
$txtRawNotes.Multiline  = $true
$txtRawNotes.ScrollBars = 'Vertical'
$txtRawNotes.Font       = $fontInput; $txtRawNotes.BackColor = $colPanel
$pnlDoc.Controls.Add($txtRawNotes)

$btnGenDoc = New-Object System.Windows.Forms.Button
$btnGenDoc.Text     = 'Generate Documentation'
$btnGenDoc.Location = New-Object System.Drawing.Point(0, 206)
$btnGenDoc.Width    = 200
Set-PrimaryButton $btnGenDoc
$pnlDoc.Controls.Add($btnGenDoc)

$lblDocStatus = New-Object System.Windows.Forms.Label
$lblDocStatus.Location = New-Object System.Drawing.Point(210, 212)
$lblDocStatus.AutoSize = $true; $lblDocStatus.Font = $fontCaption; $lblDocStatus.ForeColor = $colTextMuted
$pnlDoc.Controls.Add($lblDocStatus)

# ── Output ────────────────────────────────────
$lblOutput = New-Object System.Windows.Forms.Label
$lblOutput.Text     = 'Output:'
$lblOutput.Location = New-Object System.Drawing.Point(0, 238)
$lblOutput.AutoSize = $true; $lblOutput.Font = $fontSubhead
$pnlDoc.Controls.Add($lblOutput)

$rtbDocOutput = New-Object System.Windows.Forms.RichTextBox
$rtbDocOutput.Location   = New-Object System.Drawing.Point(0, 260)
$rtbDocOutput.Size       = New-Object System.Drawing.Size(910, 260)
$rtbDocOutput.Font       = $fontCode
$rtbDocOutput.BackColor  = $colPanel
$rtbDocOutput.ReadOnly   = $true
$rtbDocOutput.ScrollBars = 'Vertical'
$pnlDoc.Controls.Add($rtbDocOutput)

$btnCopyDoc = New-Object System.Windows.Forms.Button
$btnCopyDoc.Text     = 'Copy to Clipboard'
$btnCopyDoc.Location = New-Object System.Drawing.Point(0, 528)
$btnCopyDoc.Width    = 150
Set-SecondaryButton $btnCopyDoc
$btnCopyDoc.Add_Click({
    if ($rtbDocOutput.Text.Trim()) {
        [System.Windows.Forms.Clipboard]::SetText($rtbDocOutput.Text)
        $lblDocStatus.Text = 'Copied to clipboard.'
    }
})
$pnlDoc.Controls.Add($btnCopyDoc)

$btnSaveMd = New-Object System.Windows.Forms.Button
$btnSaveMd.Text     = 'Save as .md'
$btnSaveMd.Location = New-Object System.Drawing.Point(158, 528)
$btnSaveMd.Width    = 110
Set-SecondaryButton $btnSaveMd
$btnSaveMd.Add_Click({
    if (-not $rtbDocOutput.Text.Trim()) { return }
    $sfd = New-Object System.Windows.Forms.SaveFileDialog
    $sfd.Filter = 'Markdown (*.md)|*.md'
    if ($sfd.ShowDialog() -eq 'OK') {
        $rtbDocOutput.Text | Set-Content $sfd.FileName -Encoding UTF8
        $lblDocStatus.Text = "Saved: $($sfd.FileName)"
    }
})
$pnlDoc.Controls.Add($btnSaveMd)

$btnSaveHtml = New-Object System.Windows.Forms.Button
$btnSaveHtml.Text     = 'Save as .html'
$btnSaveHtml.Location = New-Object System.Drawing.Point(276, 528)
$btnSaveHtml.Width    = 120
Set-SecondaryButton $btnSaveHtml
$btnSaveHtml.Add_Click({
    if (-not $rtbDocOutput.Text.Trim()) { return }
    $sfd = New-Object System.Windows.Forms.SaveFileDialog
    $sfd.Filter = 'HTML (*.html)|*.html'
    if ($sfd.ShowDialog() -eq 'OK') {
        $safeContent = $rtbDocOutput.Text -replace '&','&amp;' -replace '<','&lt;' -replace '>','&gt;'
        $htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Intragen Documentation</title>
<style>
  body { font-family: 'Segoe UI', sans-serif; background: #F5F1EA; color: #2D2332; max-width: 900px; margin: 40px auto; padding: 0 20px; }
  h1,h2,h3 { color: #703069; }
  code, pre { background: #fff; border: 1px solid #D2C8C3; padding: 2px 6px; border-radius: 3px; font-family: Consolas, monospace; }
  pre { padding: 12px; overflow-x: auto; white-space: pre-wrap; }
  table { border-collapse: collapse; width: 100%; }
  th { background: #703069; color: #fff; padding: 8px; }
  td { padding: 8px; border-bottom: 1px solid #D2C8C3; }
  .header { background: #703069; color: #fff; padding: 20px; border-bottom: 3px solid #D6B669; margin-bottom: 30px; }
</style>
</head>
<body>
<div class="header"><strong>Intragen</strong> — Documentation</div>
<pre>$safeContent</pre>
</body>
</html>
"@
        $htmlContent | Set-Content $sfd.FileName -Encoding UTF8
        $lblDocStatus.Text = "Saved: $($sfd.FileName)"
    }
})
$pnlDoc.Controls.Add($btnSaveHtml)

# ── Chat / Refine ─────────────────────────────
$grpDocChat = New-Object System.Windows.Forms.GroupBox
$grpDocChat.Text     = 'Chat / Refine'
$grpDocChat.Location = New-Object System.Drawing.Point(0, 556)
$grpDocChat.Size     = New-Object System.Drawing.Size(920, 72)
$grpDocChat.Font     = $fontSubhead
$pnlDoc.Controls.Add($grpDocChat)

$txtDocChat = New-Object System.Windows.Forms.TextBox
$txtDocChat.Location = New-Object System.Drawing.Point(10, 26)
$txtDocChat.Width    = 680; $txtDocChat.Font = $fontInput; $txtDocChat.BackColor = $colPanel
$grpDocChat.Controls.Add($txtDocChat)

$btnRefineDoc = New-Object System.Windows.Forms.Button
$btnRefineDoc.Text     = 'Refine'
$btnRefineDoc.Location = New-Object System.Drawing.Point(698, 23)
$btnRefineDoc.Width    = 100
Set-SecondaryButton $btnRefineDoc
$btnRefineDoc.Enabled  = $false
$grpDocChat.Controls.Add($btnRefineDoc)

$lblDocRound = New-Object System.Windows.Forms.Label
$lblDocRound.Location = New-Object System.Drawing.Point(806, 30)
$lblDocRound.AutoSize = $true; $lblDocRound.Font = $fontCaption; $lblDocRound.ForeColor = $colTextMuted
$grpDocChat.Controls.Add($lblDocRound)

# ── Build system prompt ───────────────────────
function Build-DocSystemPrompt {
    $style   = $Global:DocStyle
    $prof    = $Global:Profile
    $profName = if ($prof.name) { $prof.name } else { 'the user' }
    $profRole = if ($prof.PSObject.Properties['role']) { $prof.role } else { 'OIM Developer' }
    $profOrg  = if ($prof.PSObject.Properties['organisation']) { $prof.organisation } else { 'Intragen' }
    $docType  = $cboDocType.SelectedItem
    $fmt      = $cboFormat.SelectedItem
    $append   = if ($Global:OAISettings.systemPromptAppend) { "`n$($Global:OAISettings.systemPromptAppend)" } else { '' }

    return @"
You are a technical documentation writer for $profOrg. The author is $profName, a $profRole.
Transform the provided raw notes into a well-structured $docType in $fmt format.

Documentation style:
- Tone: $($style.tone)
- Target audience: $($style.targetAudience)
- Include examples: $($style.includeExamples)
- Include table of contents: $($style.includeTableOfContents)
- Language: $($style.language)
- Branding notes: $($style.brandingNotes)

Output ONLY the documentation content in $fmt format. Do not add preamble or meta-commentary.
$append
"@
}

# ── Generate handler ──────────────────────────
$btnGenDoc.Add_Click({
    $notes = $txtRawNotes.Text.Trim()
    if (-not $notes) {
        [System.Windows.Forms.MessageBox]::Show('Please enter or browse raw notes first.','Required') | Out-Null
        return
    }

    $btnGenDoc.Enabled  = $false
    $btnGenDoc.Text     = 'Generating...'
    $lblDocStatus.Text  = 'Sending to OpenAI...'
    $rtbDocOutput.Clear()
    $Script:DocRound    = 0
    $Script:DocHistory  = @()

    $sysMsg = Build-DocSystemPrompt
    $userMsg = "Please transform these raw notes into the requested documentation format:`n`n$notes"

    $Script:DocHistory = @(
        @{ role = 'system'; content = $sysMsg },
        @{ role = 'user';   content = $userMsg }
    )

    $params = @{
        ApiKey      = $Global:ApiKey
        Model       = $Global:OAISettings.model
        SystemMsg   = ''; UserMsg = ''
        MaxTokens   = [int]$Global:OAISettings.maxTokens
        JsonMode    = $false
        Messages    = $Script:DocHistory
        Temperature = [double]$Global:OAISettings.temperature
        TopP        = [double]$Global:OAISettings.topP
    }

    Invoke-Async $Script:ApiCallScript $params {
        param($result)
        $content = $result[0]
        $Script:DocHistory += @{ role = 'assistant'; content = $content }
        $Script:DocRound++
        $rtbDocOutput.Text    = $content
        $t = Get-Date -Format 'HH:mm'
        $lblDocStatus.Text    = "Generated $t  ($($result[1]) tokens)"
        $btnRefineDoc.Enabled = ($Script:DocRound -lt 5)
        $lblDocRound.Text     = "Round $Script:DocRound/5"
        $btnGenDoc.Enabled    = $true
        $btnGenDoc.Text       = 'Generate Documentation'
    } {
        param($err)
        Write-ErrorLog "DocBuilder: $err"
        $lblDocStatus.Text = "Error: $err"
        $btnGenDoc.Enabled = $true
        $btnGenDoc.Text    = 'Generate Documentation'
    }
})

# ── Refine handler ────────────────────────────
$btnRefineDoc.Add_Click({
    $refinement = $txtDocChat.Text.Trim()
    if (-not $refinement) {
        [System.Windows.Forms.MessageBox]::Show('Enter a refinement instruction.','Required') | Out-Null
        return
    }
    if ($Script:DocRound -ge 5) {
        [System.Windows.Forms.MessageBox]::Show('Maximum 5 rounds reached. Generate fresh to reset.','Limit') | Out-Null
        return
    }

    $btnRefineDoc.Enabled = $false
    $lblDocStatus.Text    = 'Refining...'

    $Script:DocHistory += @{ role = 'user'; content = $refinement }

    $params = @{
        ApiKey      = $Global:ApiKey
        Model       = $Global:OAISettings.model
        SystemMsg   = ''; UserMsg = ''
        MaxTokens   = [int]$Global:OAISettings.maxTokens
        JsonMode    = $false
        Messages    = $Script:DocHistory
        Temperature = [double]$Global:OAISettings.temperature
        TopP        = [double]$Global:OAISettings.topP
    }

    Invoke-Async $Script:ApiCallScript $params {
        param($result)
        $content = $result[0]
        $Script:DocHistory += @{ role = 'assistant'; content = $content }
        $Script:DocRound++
        $rtbDocOutput.Text    = $content
        $txtDocChat.Clear()
        $t = Get-Date -Format 'HH:mm'
        $lblDocStatus.Text    = "Refined round $Script:DocRound ($t)  ($($result[1]) tokens)"
        $lblDocRound.Text     = "Round $Script:DocRound/5"
        $btnRefineDoc.Enabled = ($Script:DocRound -lt 5)
    } {
        param($err)
        Write-ErrorLog "DocBuilder: $err"
        $lblDocStatus.Text    = "Error: $err"
        $btnRefineDoc.Enabled = ($Script:DocRound -lt 5)
    }
})
