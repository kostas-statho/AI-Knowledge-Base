# ChatForm.ps1 — OIM Dev Assistant WinForms chat UI.
# Dot-sourced by OIM_Chat.ps1 after StyleTokens.ps1.
# Expects: $Script:ApiKey, $Script:SystemPrompt, $colXxx, $fontXxx variables already loaded.

# ── Async helper (adapted from GoalSetter Invoke-Async) ────────────────────────
function Invoke-Async {
    param(
        [scriptblock]$Script,
        [hashtable]$Params,
        [scriptblock]$OnDone,
        [scriptblock]$OnError
    )
    $rs = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace()
    $rs.Open()
    $ps = [System.Management.Automation.PowerShell]::Create()
    $ps.Runspace = $rs
    [void]$ps.AddScript($Script)
    [void]$ps.AddParameters($Params)
    $handle = $ps.BeginInvoke()

    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 300
    $timer.Add_Tick({
        if ($handle.IsCompleted) {
            $timer.Stop()
            $timer.Dispose()
            try {
                $result   = $ps.EndInvoke($handle)
                $errMsg   = if ($ps.Streams.Error.Count -gt 0) { $ps.Streams.Error[0].ToString() } else { $null }
                $ps.Dispose(); $rs.Dispose()
                if ($errMsg) { & $OnError $errMsg } else { & $OnDone $result }
            } catch {
                $ps.Dispose(); $rs.Dispose()
                & $OnError $_.Exception.Message
            }
        }
    }.GetNewClosure())
    $timer.Start()
}

# ── OpenAI call script (runs inside runspace) ───────────────────────────────────
$Script:OpenAICallScript = {
    param([string]$ApiKey, [object[]]$Messages)
    $body = @{
        model      = 'gpt-4.1'
        messages   = $Messages
        max_tokens = 2000
    } | ConvertTo-Json -Depth 10 -Compress

    $wc = New-Object System.Net.WebClient
    $wc.Encoding = [System.Text.Encoding]::UTF8
    $wc.Headers.Add('Authorization', "Bearer $ApiKey")
    $wc.Headers.Add('Content-Type', 'application/json')
    $response = $wc.UploadString('https://api.openai.com/v1/chat/completions', $body)
    return ($response | ConvertFrom-Json).choices[0].message.content
}

# ── Chat history ────────────────────────────────────────────────────────────────
$Script:ChatHistory  = New-Object System.Collections.Generic.List[hashtable]
$Script:MaxHistory   = 20   # number of user+assistant turns to keep (each turn = 2 messages)

# ── RichTextBox append helpers ──────────────────────────────────────────────────
function Append-Styled {
    param(
        [System.Windows.Forms.RichTextBox]$Rtb,
        [string]$Text,
        [System.Drawing.Color]$Color,
        [System.Drawing.Font]$Font
    )
    $Rtb.SelectionStart  = $Rtb.TextLength
    $Rtb.SelectionLength = 0
    $Rtb.SelectionColor  = $Color
    $Rtb.SelectionFont   = $Font
    $Rtb.AppendText($Text)
    $Rtb.SelectionColor  = $Script:colTextDark
    $Rtb.SelectionFont   = $Script:fontChatNormal
}

function Append-ChatBubble {
    param(
        [System.Windows.Forms.RichTextBox]$Rtb,
        [string]$Role,     # 'You' or 'Assistant'
        [string]$Content
    )
    # Separator line
    if ($Rtb.TextLength -gt 0) {
        Append-Styled $Rtb "`n-----------------------------------------------------`n" $Script:colSeparator $Script:fontChatNormal
    }

    # Role label
    $labelColor = if ($Role -eq 'You') { $Script:colTeal } else { $Script:colPurple }
    Append-Styled $Rtb "$Role`n" $labelColor $Script:fontSubhead

    # Content: detect code lines (4+ leading spaces or starts with common code chars)
    foreach ($line in $Content -split "`n") {
        if ($line -match '^\s{4,}' -or $line -match '^(//|#|```)') {
            Append-Styled $Rtb ($line + "`n") $Script:colTextMuted $Script:fontChat
        } else {
            Append-Styled $Rtb ($line + "`n") $Script:colTextDark $Script:fontChatNormal
        }
    }

    $Rtb.SelectionStart = $Rtb.TextLength
    $Rtb.ScrollToCaret()
}

function Append-ErrorLine {
    param([System.Windows.Forms.RichTextBox]$Rtb, [string]$Msg)
    Append-Styled $Rtb "`n[Error] $Msg`n" $Script:colError $Script:fontChatNormal
    $Rtb.ScrollToCaret()
}

# ── Send message ────────────────────────────────────────────────────────────────
function Send-Message {
    param([string]$UserText)
    $UserText = $UserText.Trim()
    if (-not $UserText) { return }

    # Add to history and display
    $Script:ChatHistory.Add(@{ role = 'user'; content = $UserText })
    Append-ChatBubble $Script:rtbChat 'You' $UserText

    # Trim history (keep system prompt separate, so cap user+assistant turns)
    while ($Script:ChatHistory.Count -gt $Script:MaxHistory) {
        $Script:ChatHistory.RemoveAt(0)
    }

    # Build messages array: system prompt first, then history
    $messages = @(@{ role = 'system'; content = $Script:SystemPrompt })
    foreach ($h in $Script:ChatHistory) { $messages += $h }

    # Disable input
    $Script:txtInput.Text    = ''
    $Script:txtInput.Enabled = $false
    $Script:btnSend.Enabled  = $false
    $Script:lblStatus.Text   = 'Thinking…'

    Invoke-Async `
        -Script  $Script:OpenAICallScript `
        -Params  @{ ApiKey = $Script:ApiKey; Messages = $messages } `
        -OnDone  {
            param($result)
            $reply = if ($result -is [System.Array]) { $result[0] } else { $result }
            $Script:ChatHistory.Add(@{ role = 'assistant'; content = $reply })
            Append-ChatBubble $Script:rtbChat 'Assistant' $reply
            $Script:lblStatus.Text   = 'Ready'
            $Script:txtInput.Enabled = $true
            $Script:btnSend.Enabled  = $true
            $Script:txtInput.Focus()
        } `
        -OnError {
            param($errMsg)
            Append-ErrorLine $Script:rtbChat $errMsg
            $Script:lblStatus.Text   = 'Ready'
            $Script:txtInput.Enabled = $true
            $Script:btnSend.Enabled  = $true
            $Script:txtInput.Focus()
        }
}

# ── Build the form ──────────────────────────────────────────────────────────────
$form                  = New-Object System.Windows.Forms.Form
$form.Text             = 'OIM Dev Assistant'
$form.Size             = New-Object System.Drawing.Size(900, 700)
$form.MinimumSize      = New-Object System.Drawing.Size(600, 450)
$form.StartPosition    = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.BackColor        = $colBackground
$form.Font             = $fontLabel

# Header (Dock=Top, added first)
$pnlHeader             = New-Object System.Windows.Forms.Panel
$pnlHeader.Dock        = [System.Windows.Forms.DockStyle]::Top
$pnlHeader.Height      = 56
$pnlHeader.BackColor   = $colPurple
$form.Controls.Add($pnlHeader)

$lblTitle              = New-Object System.Windows.Forms.Label
$lblTitle.Text         = 'OIM Dev Assistant'
$lblTitle.Font         = $fontTitle
$lblTitle.ForeColor    = [System.Drawing.Color]::White
$lblTitle.AutoSize     = $true
$lblTitle.Location     = New-Object System.Drawing.Point(16, 14)
$pnlHeader.Controls.Add($lblTitle)

# Gold accent strip (Dock=Top, added second → appears below header)
$pnlAccent             = New-Object System.Windows.Forms.Panel
$pnlAccent.Dock        = [System.Windows.Forms.DockStyle]::Top
$pnlAccent.Height      = 3
$pnlAccent.BackColor   = $colGold
$form.Controls.Add($pnlAccent)

# Status bar (Dock=Bottom, add before input panel)
$pnlStatus             = New-Object System.Windows.Forms.Panel
$pnlStatus.Dock        = [System.Windows.Forms.DockStyle]::Bottom
$pnlStatus.Height      = 26
$pnlStatus.BackColor   = $colBackground
$form.Controls.Add($pnlStatus)

$Script:lblStatus      = New-Object System.Windows.Forms.Label
$Script:lblStatus.Text = 'Loading knowledge base…'
$Script:lblStatus.Font = $fontLabel
$Script:lblStatus.ForeColor = $colTextMuted
$Script:lblStatus.AutoSize  = $true
$Script:lblStatus.Location  = New-Object System.Drawing.Point(8, 5)
$pnlStatus.Controls.Add($Script:lblStatus)

# Input panel (Dock=Bottom, added after status)
$pnlInput              = New-Object System.Windows.Forms.Panel
$pnlInput.Dock         = [System.Windows.Forms.DockStyle]::Bottom
$pnlInput.Height       = 46
$pnlInput.BackColor    = $colPanel
$pnlInput.Padding      = New-Object System.Windows.Forms.Padding(6, 6, 6, 6)
$form.Controls.Add($pnlInput)

$Script:btnClear       = New-Object System.Windows.Forms.Button
$Script:btnClear.Text  = 'Clear'
$Script:btnClear.Width = 60
$Script:btnClear.Dock  = [System.Windows.Forms.DockStyle]::Right
Set-SecondaryButton $Script:btnClear
$pnlInput.Controls.Add($Script:btnClear)

$Script:btnSend        = New-Object System.Windows.Forms.Button
$Script:btnSend.Text   = 'Send'
$Script:btnSend.Width  = 80
$Script:btnSend.Dock   = [System.Windows.Forms.DockStyle]::Right
Set-PrimaryButton $Script:btnSend
$pnlInput.Controls.Add($Script:btnSend)

$Script:txtInput       = New-Object System.Windows.Forms.TextBox
$Script:txtInput.Dock  = [System.Windows.Forms.DockStyle]::Fill
$Script:txtInput.Font  = $fontChatNormal
$Script:txtInput.BackColor = $colBackground
$Script:txtInput.ForeColor = $colTextDark
$Script:txtInput.Enabled = $false   # enabled once knowledge loaded
$pnlInput.Controls.Add($Script:txtInput)

# Chat output (Dock=Fill — must be added LAST)
$Script:rtbChat              = New-Object System.Windows.Forms.RichTextBox
$Script:rtbChat.Dock         = [System.Windows.Forms.DockStyle]::Fill
$Script:rtbChat.ReadOnly     = $true
$Script:rtbChat.BackColor    = $colPanel
$Script:rtbChat.ForeColor    = $colTextDark
$Script:rtbChat.Font         = $fontChatNormal
$Script:rtbChat.WordWrap     = $true
$Script:rtbChat.ScrollBars   = [System.Windows.Forms.RichTextBoxScrollBars]::Vertical
$Script:rtbChat.BorderStyle  = [System.Windows.Forms.BorderStyle]::None
$Script:rtbChat.Padding      = New-Object System.Windows.Forms.Padding(8)
$form.Controls.Add($Script:rtbChat)

# Make module-level color/font variables accessible inside closures
$Script:colSeparator  = $colSeparator
$Script:colTeal       = $colTeal
$Script:colPurple     = $colPurple
$Script:colTextDark   = $colTextDark
$Script:colTextMuted  = $colTextMuted
$Script:colError      = $colError
$Script:fontSubhead   = $fontSubhead
$Script:fontChatNormal= $fontChatNormal
$Script:fontChat      = $fontChat

# ── Event handlers ──────────────────────────────────────────────────────────────
$Script:btnSend.Add_Click({
    Send-Message $Script:txtInput.Text
})

$Script:txtInput.Add_KeyDown({
    if ($_.KeyCode -eq [System.Windows.Forms.Keys]::Enter -and -not $_.Shift) {
        $_.SuppressKeyPress = $true
        $Script:btnSend.PerformClick()
    }
})

$Script:btnClear.Add_Click({
    $Script:ChatHistory.Clear()
    $Script:rtbChat.Clear()
    $Script:lblStatus.Text = 'Ready'
})

$form.Add_Shown({
    $Script:txtInput.Focus()
})
