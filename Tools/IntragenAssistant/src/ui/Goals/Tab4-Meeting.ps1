# ==============================================
# TAB 4  -  MEETING
# ==============================================
$pnlMeeting = New-Object System.Windows.Forms.Panel
$pnlMeeting.Dock = 'Fill'
$tabMeeting.Controls.Add($pnlMeeting)

$grpMeeting = New-Object System.Windows.Forms.GroupBox
$grpMeeting.Text      = '1-on-1 Goal Review with Team Leader'
$grpMeeting.Location  = New-Object System.Drawing.Point(10,10)
$grpMeeting.Size      = New-Object System.Drawing.Size(800, 545)
$grpMeeting.Dock      = 'Fill'
$grpMeeting.ForeColor = $colPurple
$grpMeeting.Font      = $fontSubhead

# -- Row 1: Team Leader name + date -------------------------------------------
$lblTLName = New-Object System.Windows.Forms.Label
$lblTLName.Text = 'Team Leader Name:'; $lblTLName.Location = New-Object System.Drawing.Point(10,25); $lblTLName.AutoSize = $true
$txtTLName = New-Object System.Windows.Forms.TextBox
$txtTLName.Location = New-Object System.Drawing.Point(135,22); $txtTLName.Width = 220
$txtTLName.BackColor = $colPanel; $txtTLName.Font = $fontInput

$lblMeetDate = New-Object System.Windows.Forms.Label
$lblMeetDate.Text = "Date: $(Get-Date -Format 'yyyy-MM-dd')"
$lblMeetDate.Location = New-Object System.Drawing.Point(375,25); $lblMeetDate.AutoSize = $true; $lblMeetDate.ForeColor = $colTextMuted; $lblMeetDate.Anchor = 'Top,Right'
$lblMeetDate.Font      = $fontCaption

# -- Row 2: Goals snapshot (auto-loaded from Tab 3) ---------------------------
$lblGoalsSnap = New-Object System.Windows.Forms.Label
$lblGoalsSnap.Text = 'Goals & Progress Snapshot:'; $lblGoalsSnap.Location = New-Object System.Drawing.Point(10,58); $lblGoalsSnap.AutoSize = $true

$txtGoalsSnap = New-Object System.Windows.Forms.TextBox
$txtGoalsSnap.Location = New-Object System.Drawing.Point(10,78)
$txtGoalsSnap.Size   = New-Object System.Drawing.Size(670,140)
$txtGoalsSnap.Anchor = 'Top,Left,Right'
$txtGoalsSnap.Multiline = $true; $txtGoalsSnap.ReadOnly = $true; $txtGoalsSnap.ScrollBars = 'Vertical'
$txtGoalsSnap.BackColor = $colBackground
$txtGoalsSnap.Font      = $fontCode

$btnRefreshGoals = New-Object System.Windows.Forms.Button
$btnRefreshGoals.Text     = "Refresh`nGoals"
$btnRefreshGoals.Location = New-Object System.Drawing.Point(688,78)
$btnRefreshGoals.Size     = New-Object System.Drawing.Size(82,80)
Set-SecondaryButton $btnRefreshGoals
$btnRefreshGoals.Anchor = 'Top,Right'

# -- Row 3: Extra notes --------------------------------------------------------
$lblNotes = New-Object System.Windows.Forms.Label
$lblNotes.Text = 'Additional Topics / Notes (optional):'; $lblNotes.Location = New-Object System.Drawing.Point(10,230); $lblNotes.AutoSize = $true
$txtMeetNotes = New-Object System.Windows.Forms.TextBox
$txtMeetNotes.Location = New-Object System.Drawing.Point(10,250)
$txtMeetNotes.Size   = New-Object System.Drawing.Size(760,60)
$txtMeetNotes.Anchor = 'Top,Left,Right'
$txtMeetNotes.Multiline = $true; $txtMeetNotes.ScrollBars = 'Vertical'
$txtMeetNotes.BackColor = $colPanel; $txtMeetNotes.Font = $fontInput

# -- Generate button -----------------------------------------------------------
$btnGenMeeting = New-Object System.Windows.Forms.Button
$btnGenMeeting.Text     = 'Generate 1-on-1 Brief'
$btnGenMeeting.Location = New-Object System.Drawing.Point(10,322)
$btnGenMeeting.Width    = 175
Set-PrimaryButton $btnGenMeeting
$lblMeetingStatus = New-Object System.Windows.Forms.Label
$lblMeetingStatus.Text      = ''
$lblMeetingStatus.Location  = New-Object System.Drawing.Point(196,327)
$lblMeetingStatus.AutoSize  = $true
$lblMeetingStatus.ForeColor = $colTextMuted
$lblMeetingStatus.Font      = $fontCaption

# -- Summary output ------------------------------------------------------------
$lblSummary = New-Object System.Windows.Forms.Label
$lblSummary.Text = 'Meeting Brief:'; $lblSummary.Location = New-Object System.Drawing.Point(10,358); $lblSummary.AutoSize = $true
$txtMeetingSummary = New-Object System.Windows.Forms.TextBox
$txtMeetingSummary.Location = New-Object System.Drawing.Point(10,378)
$txtMeetingSummary.Size   = New-Object System.Drawing.Size(760,120)
$txtMeetingSummary.Anchor = 'Top,Bottom,Left,Right'
$txtMeetingSummary.Multiline = $true; $txtMeetingSummary.ReadOnly = $true; $txtMeetingSummary.ScrollBars = 'Vertical'
$txtMeetingSummary.BackColor = $colPanel

$btnSaveSummary = New-Object System.Windows.Forms.Button
$btnSaveSummary.Text     = 'Save Brief'
$btnSaveSummary.Location = New-Object System.Drawing.Point(10,510)
$btnSaveSummary.Width    = 100
$btnSaveSummary.Enabled  = $false
Set-SecondaryButton $btnSaveSummary
$btnSaveSummary.Anchor = 'Bottom,Left'

$grpMeeting.Controls.AddRange(@(
    $lblTLName,$txtTLName,$lblMeetDate,
    $lblGoalsSnap,$txtGoalsSnap,$btnRefreshGoals,
    $lblNotes,$txtMeetNotes,
    $btnGenMeeting,$lblMeetingStatus,
    $lblSummary,$txtMeetingSummary,$btnSaveSummary
))
$pnlMeeting.Padding = New-Object System.Windows.Forms.Padding(10)
$pnlMeeting.Controls.Add($grpMeeting)

# -- Helper: build goals snapshot text ----------------------------------------
$getGoalsSnapshot = {
    if (-not $Global:Goals -or $Global:Goals.Count -eq 0) {
        return '(No goals finalized yet  -  complete Tab 3 first.)'
    }
    $lines = @()
    foreach ($g in $Global:Goals) {
        $total = $g.checkboxes.Count
        $done  = ($g.checkboxes | Where-Object { $_.Checked }).Count
        $pct   = if ($total -gt 0) { [int](($done / $total) * 100) } else { 0 }
        $lines += "GOAL: $($g.title)  -- $done/$total milestones ($pct%)"
        if ($g.approach) { $lines += "  Approach: $($g.approach)" }
        foreach ($cb in $g.checkboxes) {
            $tick = if ($cb.Checked) { '[x]' } else { '[ ]' }
            $lines += "  $tick $($cb.Text)"
        }
        $lines += ''
    }
    return ($lines -join "`r`n").TrimEnd()
}

$btnRefreshGoals.Add_Click({
    $txtGoalsSnap.Text = & $getGoalsSnapshot
}.GetNewClosure())

# Auto-populate when user switches to Tab 4
$tabsGoals.Add_SelectedIndexChanged({
    if ($tabsGoals.SelectedTab -eq $tabMeeting -and $txtGoalsSnap.Text -eq '') {
        $txtGoalsSnap.Text = & $getGoalsSnapshot
    }
}.GetNewClosure())

# -- Generate brief ------------------------------------------------------------
$btnGenMeeting.Add_Click({
    if (-not $Global:ApiKey) { Show-SettingsDialog; if (-not $Global:ApiKey) { return } }

    $tlName    = $txtTLName.Text.Trim()
    $goalsSnap = $txtGoalsSnap.Text.Trim()
    $notes     = $txtMeetNotes.Text.Trim()
    $userName  = if ($Global:Profile.name) { $Global:Profile.name } else { 'Employee' }
    $meetDate  = Get-Date -Format 'yyyy-MM-dd'

    if ($goalsSnap -eq '' -or $goalsSnap -like '*(No goals*') {
        [System.Windows.Forms.MessageBox]::Show('No goals data found. Please finalize goals on Tab 3 first.','No Goals') | Out-Null
        return
    }

    $lblMeetingStatus.Text   = 'Generating brief...'
    $btnGenMeeting.Enabled   = $false
    $btnSaveSummary.Enabled  = $false

    $sysMsg = @'
You are a career coach writing a 1-on-1 meeting brief. Output ONLY plain text  -  no markdown, no asterisks, no hashtags. Use this exact layout with the separator lines shown:

================================================
  1-ON-1 GOAL REVIEW BRIEF
================================================

MEETING CONTEXT
  Employee  : [name]
  Team Lead : [name]
  Date      : [date]
  Purpose   : Goal progress review and alignment

------------------------------------------------
GOALS OVERVIEW
------------------------------------------------
For each goal write a block like:
  Goal      : [title]
  Progress  : X/Y milestones ([Z]% complete)
  Pace      : On Track / At Risk / Behind Schedule
  Hrs/week  : N
  Note      : one-sentence assessment

------------------------------------------------
KEY DISCUSSION POINTS
------------------------------------------------
  * [point 1]
  * [point 2]
  * [point 3]

------------------------------------------------
BLOCKERS & SUPPORT NEEDED
------------------------------------------------
  * [blocker or "None identified"]

------------------------------------------------
COMMITMENTS FOR NEXT REVIEW
------------------------------------------------
  * [SMART action 1]
  * [SMART action 2]

================================================

Be concise and action-oriented. Replace all bracketed placeholders with real content.
'@
    $domain       = ($Script:DomainChips | ForEach-Object { $_.Name }) -join ', '
    $skillsStr    = ($Script:SkillChips    | ForEach-Object { "$($_.Name) [$($_.Level)]" }) -join ', '
    $interestsStr = ($Script:InterestChips | ForEach-Object { "$($_.Name) [$($_.Level)]" }) -join ', '
    $swotContext = if ($Global:SwotJson) {
        "Strengths: $($Global:SwotJson.Strengths -join '; '). Weaknesses: $($Global:SwotJson.Weaknesses -join '; ')."
    } else { '' }

    $usrMsg  = "Employee      : $userName`n"
    $usrMsg += "Domain(s)     : $domain`n"
    $usrMsg += "Skills        : $skillsStr`n"
    $usrMsg += "Interests     : $interestsStr`n"
    if ($swotContext) { $usrMsg += "SWOT context  : $swotContext`n" }
    $usrMsg += "Team Leader   : $tlName`n"
    $usrMsg += "Date          : $meetDate`n"
    $usrMsg += "`nGoals & Progress (with approach and milestones):`n$goalsSnap"
    if ($notes) { $usrMsg += "`n`nAdditional Topics:`n$notes" }

    $apiKey = $Global:ApiKey
    Invoke-Async $Script:ApiCallScript @{ApiKey=$apiKey;Model=$Global:OAISettings.model;SystemMsg=$sysMsg;UserMsg=$usrMsg;MaxTokens=2500;Temperature=$Global:OAISettings.temperature;TopP=$Global:OAISettings.topP} `
        -onDone {
            param($result)
            $txtMeetingSummary.Text  = $result[0] -replace "(?<!\r)`n", "`r`n"
            $btnSaveSummary.Enabled  = $true
            $lblMeetingStatus.Text   = 'Done.'
            $btnGenMeeting.Enabled   = $true
        } `
        -onError {
            param($err)
            Write-ErrorLog $err
            $lblMeetingStatus.Text = "Error: $err"
            $btnGenMeeting.Enabled = $true
        }
})

$btnSaveSummary.Add_Click({
    $sfd = New-Object System.Windows.Forms.SaveFileDialog
    $sfd.Filter = 'Text files (*.txt)|*.txt|All files (*.*)|*.*'
    $sfd.FileName = "1on1-brief-$(Get-Date -Format 'yyyy-MM-dd').txt"
    if ($sfd.ShowDialog() -eq 'OK') {
        $txtMeetingSummary.Text | Set-Content $sfd.FileName -Encoding UTF8
        [System.Windows.Forms.MessageBox]::Show('Brief saved.','Saved') | Out-Null
    }
})
