# ==============================================
# CHAT PANEL
# RichTextBox (Dock=Fill) + rendering helpers + Send-Message + history I/O.
# Must be dot-sourced AFTER MainForm.ps1 so the RichTextBox fills remaining space.
# NOTE: No non-ASCII characters in strings -- PS 5.1 reads files as CP-1252.
# ==============================================

# -- Chat history (List of hashtables {role, content}) ------------------------
$Script:ChatHistory = New-Object 'System.Collections.Generic.List[hashtable]'
$Script:MaxHistory  = 20   # max user+assistant turns kept in context

# -- RichTextBox -- Dock=Fill, added last so it takes all remaining space ------
$Script:rtbChat              = New-Object System.Windows.Forms.RichTextBox
$Script:rtbChat.Dock         = 'Fill'
$Script:rtbChat.ReadOnly     = $true
$Script:rtbChat.BackColor    = $colPanel
$Script:rtbChat.ForeColor    = $colTextDark
$Script:rtbChat.Font         = $fontChatNormal
$Script:rtbChat.WordWrap     = $true
$Script:rtbChat.ScrollBars   = 'Vertical'
$Script:rtbChat.BorderStyle  = 'None'
$Script:rtbChat.Padding      = New-Object System.Windows.Forms.Padding(8, 6, 8, 6)
$form.Controls.Add($Script:rtbChat)

# -- Rendering helpers ---------------------------------------------------------
function Append-Styled {
    param(
        [System.Windows.Forms.RichTextBox] $Rtb,
        [string]                           $Text,
        [System.Drawing.Color]             $Color,
        [System.Drawing.Font]              $Font
    )
    $Rtb.SelectionStart  = $Rtb.TextLength
    $Rtb.SelectionLength = 0
    $Rtb.SelectionColor  = $Color
    $Rtb.SelectionFont   = $Font
    $Rtb.AppendText($Text)
    # Reset to defaults after each append
    $Rtb.SelectionColor = $colTextDark
    $Rtb.SelectionFont  = $fontChatNormal
}

function Append-ChatBubble {
    param(
        [System.Windows.Forms.RichTextBox] $Rtb,
        [string] $Role,
        [string] $Content
    )
    # Separator line between turns (ASCII only)
    if ($Rtb.TextLength -gt 0) {
        Append-Styled $Rtb "`n-----------------------------------------`n" $colSeparator $fontChatNormal
    }

    # Role label: "You" in teal, "Assistant" in purple
    $labelColor = if ($Role -eq 'You') { $colTeal } else { $colPurple }
    Append-Styled $Rtb ($Role + "`n") $labelColor $fontSubhead

    # Content: detect code lines and render in Consolas
    foreach ($line in ($Content -split "`n")) {
        $isCode = $line -match '^\s{4,}' -or $line -match '^(//|#|\$[A-Z])'
        if ($isCode) {
            Append-Styled $Rtb ($line + "`n") $colTextMuted $fontChatCode
        } else {
            Append-Styled $Rtb ($line + "`n") $colTextDark $fontChatNormal
        }
    }

    $Rtb.SelectionStart = $Rtb.TextLength
    $Rtb.ScrollToCaret()
}

function Append-ErrorLine {
    param([System.Windows.Forms.RichTextBox] $Rtb, [string] $Msg)
    Append-Styled $Rtb ("`n[Error] $Msg`n") $colError $fontChatNormal
    $Rtb.ScrollToCaret()
}

# -- History persistence -------------------------------------------------------
function Save-ChatHistory($path) {
    $Script:ChatHistory | ConvertTo-Json -Depth 3 | Set-Content $path -Encoding UTF8
}

function Load-ChatHistory($path) {
    $Script:ChatHistory.Clear()
    $Script:rtbChat.Clear()
    $raw = Get-Content $path -Raw | ConvertFrom-Json
    if ($raw -isnot [System.Array]) { $raw = @($raw) }
    foreach ($item in $raw) {
        $Script:ChatHistory.Add(@{ role = $item.role; content = $item.content })
        $label = if ($item.role -eq 'user') { 'You' } else { 'Assistant' }
        Append-ChatBubble $Script:rtbChat $label $item.content
    }
    $Script:lblStatus.Text = "History loaded ($($Script:ChatHistory.Count) messages)"
}

# -- Send-Message --------------------------------------------------------------
function Send-Message($userText) {
    $userText = $userText.Trim()
    if (-not $userText) { return }

    # Prompt for API key if not configured
    if (-not $Global:ApiKey) {
        Show-SettingsDialog
        if (-not $Global:ApiKey) { return }
    }

    # Add to history and render
    $Script:ChatHistory.Add(@{ role = 'user'; content = $userText })
    Append-ChatBubble $Script:rtbChat 'You' $userText

    # Trim history to MaxHistory turns
    while ($Script:ChatHistory.Count -gt $Script:MaxHistory) {
        $Script:ChatHistory.RemoveAt(0)
    }

    # Build messages: system prompt (active context) + history
    $sysPrompt = $Global:ContextPresets[$Global:ActiveContext]
    $messages  = @()
    if ($sysPrompt) { $messages += @{ role = 'system'; content = $sysPrompt } }
    foreach ($h in $Script:ChatHistory) { $messages += $h }

    # Disable UI during call
    $Script:txtInput.Text     = ''
    $Script:txtInput.Enabled  = $false
    $Script:btnSend.Enabled   = $false
    $Script:lblStatus.Text    = 'Thinking...'

    $apiKey = $Global:ApiKey
    $model  = $Global:Model

    Invoke-Async $Script:ApiCallScript @{ ApiKey = $apiKey; Messages = $messages; Model = $model } `
        -onDone {
            param($result)
            $reply = if ($result -is [System.Array]) { $result[0] } else { $result }
            $Script:ChatHistory.Add(@{ role = 'assistant'; content = $reply })
            Append-ChatBubble $Script:rtbChat 'Assistant' $reply
            $Script:lblStatus.Text   = 'Ready'
            $Script:txtInput.Enabled = $true
            $Script:btnSend.Enabled  = $true
            $Script:txtInput.Focus()
        } `
        -onError {
            param($errMsg)
            Write-ErrorLog $errMsg
            Append-ErrorLine $Script:rtbChat $errMsg
            $Script:lblStatus.Text   = 'Ready'
            $Script:txtInput.Enabled = $true
            $Script:btnSend.Enabled  = $true
            $Script:txtInput.Focus()
        }
}

# -- Input event handlers ------------------------------------------------------
$Script:btnSend.Add_Click({
    Send-Message $Script:txtInput.Text
})

$Script:txtInput.Add_KeyDown({
    if ($_.KeyCode -eq [System.Windows.Forms.Keys]::Enter -and -not $_.Shift) {
        $_.SuppressKeyPress = $true
        $Script:btnSend.PerformClick()
    }
})

# -- File menu handlers (menu items declared in MainForm.ps1) ------------------
$mNewChat.Add_Click({
    $Script:ChatHistory.Clear()
    $Script:rtbChat.Clear()
    $Script:lblStatus.Text = 'Ready'
})

$mSaveHistory.Add_Click({
    if ($Script:ChatHistory.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show('No conversation to save.', 'Save History') | Out-Null
        return
    }
    $sfd           = New-Object System.Windows.Forms.SaveFileDialog
    $sfd.Filter    = 'JSON files (*.json)|*.json|All files (*.*)|*.*'
    $sfd.FileName  = "chat-$(Get-Date -Format 'yyyy-MM-dd').json"
    if ($sfd.ShowDialog() -eq 'OK') {
        Save-ChatHistory $sfd.FileName
        $Script:lblStatus.Text = "Saved to $([System.IO.Path]::GetFileName($sfd.FileName))"
    }
})

$mLoadHistory.Add_Click({
    $ofd        = New-Object System.Windows.Forms.OpenFileDialog
    $ofd.Filter = 'JSON files (*.json)|*.json|All files (*.*)|*.*'
    if ($ofd.ShowDialog() -eq 'OK') {
        try {
            Load-ChatHistory $ofd.FileName
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to load history: $($_.Exception.Message)", 'Error') | Out-Null
        }
    }
})
