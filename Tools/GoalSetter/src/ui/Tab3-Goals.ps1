# ==============================================
# TAB 3  -  GOALS
# ==============================================
# NOTE: $btnSaveProgress, $btnExportTxt, $btnExportProfile are declared here
# but are physically added to Tab 5's $flowGoalBtns panel (Tab5-Progress.ps1).
# Tab5-Progress.ps1 MUST be dot-sourced after this file.
#
# NOTE: Render-Goals writes to $scrollProgress and calls Update-ProgressBar,
# both defined in Tab5-Progress.ps1. These are resolved at runtime (not load
# time), so the dot-source order is sufficient.
# ----------------------------------------------
$pnlGoals = New-Object System.Windows.Forms.Panel
$pnlGoals.Dock = 'Fill'
$tabGoals.Controls.Add($pnlGoals)

$lblGoalStatus = New-Object System.Windows.Forms.Label
$lblGoalStatus.Text = 'Goals will appear here after generation.'
$lblGoalStatus.Location = New-Object System.Drawing.Point(10,10)
$lblGoalStatus.AutoSize = $true

$scrollGoals = New-Object System.Windows.Forms.Panel
$scrollGoals.AutoScroll  = $true
$scrollGoals.BorderStyle = 'FixedSingle'
$scrollGoals.BackColor   = $colBackground
$scrollGoals.Dock        = 'Fill'

$btnFinalizeGoals = New-Object System.Windows.Forms.Button
$btnFinalizeGoals.Text    = 'Finalize Selected Goals ->'
$btnFinalizeGoals.Width   = 185
$btnFinalizeGoals.Visible = $false
$btnFinalizeGoals.Enabled = $false
Set-PrimaryButton $btnFinalizeGoals

# Save/export buttons declared here; added to Tab 5's FlowLayoutPanel in Tab5-Progress.ps1
$btnSaveProgress  = New-Object System.Windows.Forms.Button; $btnSaveProgress.Text  = 'Save Progress';       $btnSaveProgress.Width  = 120; $btnSaveProgress.Enabled  = $false; Set-PrimaryButton $btnSaveProgress
$btnExportTxt     = New-Object System.Windows.Forms.Button; $btnExportTxt.Text     = 'Export Goals as Text'; $btnExportTxt.Width     = 150; $btnExportTxt.Enabled     = $false; Set-SecondaryButton $btnExportTxt
$btnExportProfile = New-Object System.Windows.Forms.Button; $btnExportProfile.Text = 'Export Profile';       $btnExportProfile.Width = 110; $btnExportProfile.Enabled = $false; Set-SecondaryButton $btnExportProfile

# Header panel: status label pinned to top
$pnlGoalsHeader = New-Object System.Windows.Forms.Panel
$pnlGoalsHeader.Dock = 'Top'; $pnlGoalsHeader.Height = 32
$lblGoalStatus.Location = New-Object System.Drawing.Point(10, 8)
$pnlGoalsHeader.Controls.Add($lblGoalStatus)

# Footer panel: Finalize button pinned to bottom
$pnlGoalsFooter = New-Object System.Windows.Forms.Panel
$pnlGoalsFooter.Dock = 'Bottom'; $pnlGoalsFooter.Height = 38
$btnFinalizeGoals.Location = New-Object System.Drawing.Point(10, 5)
$pnlGoalsFooter.Controls.Add($btnFinalizeGoals)

$pnlGoals.Controls.AddRange(@($pnlGoalsHeader, $pnlGoalsFooter, $scrollGoals))

# -- Phase 1: show proposed goals for selection -------------------------------
function Render-GoalProposals($goals) {
    $scrollGoals.Controls.Clear()
    $Global:GoalProposals = @()
    $btnSaveProgress.Enabled  = $false
    $btnExportTxt.Enabled     = $false
    $btnExportProfile.Enabled = $false

    $y = 8
    foreach ($g in $goals) {
        $milestones = if ($g.milestones -is [array]) { $g.milestones } else { @($g.milestones) }
        $proposal = @{ goal=$g; checkbox=$null; milestoneCbs=@(); otherCb=$null; otherTxt=$null }

        # Goal title checkbox (pre-selected)
        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Text    = $g.title
        $cb.Checked = $true
        $cb.Location = New-Object System.Drawing.Point(5,$y)
        $cb.Size     = New-Object System.Drawing.Size(($scrollGoals.ClientSize.Width - 20), 22)
        $cb.Font      = $fontSubhead
        $cb.ForeColor = $colPurple
        $scrollGoals.Controls.Add($cb)
        $proposal.checkbox = $cb
        $y += 26

        # Each milestone as a pre-checked checkbox
        foreach ($m in $milestones) {
            $mText = if ($m -is [string]) { $m } else { $m.step }
            $mcb = New-Object System.Windows.Forms.CheckBox
            $mcb.Text     = $mText
            $mcb.Checked  = $true
            $mcb.Location = New-Object System.Drawing.Point(22,$y)
            $mcb.Size     = New-Object System.Drawing.Size(($scrollGoals.ClientSize.Width - 40), 20)
            $mcb.ForeColor = $colTextDark
            $scrollGoals.Controls.Add($mcb)
            $proposal.milestoneCbs += $mcb
            $y += 22
        }

        # "Other" milestone row
        $cbOther = New-Object System.Windows.Forms.CheckBox
        $cbOther.Text      = 'Other:'
        $cbOther.Location  = New-Object System.Drawing.Point(22,$y)
        $cbOther.Size      = New-Object System.Drawing.Size(65,20)
        $cbOther.ForeColor = $colTextMuted
        $txtOther = New-Object System.Windows.Forms.TextBox
        $txtOther.Location = New-Object System.Drawing.Point(92,$y)
        $txtOther.Size     = New-Object System.Drawing.Size(($scrollGoals.ClientSize.Width - 142), 20)
        $txtOther.Enabled  = $false
        $txtOther.BackColor = $colPanel; $txtOther.Font = $fontLabel
        $captureTxt = $txtOther
        $cbOther.Add_CheckedChanged({ $captureTxt.Enabled = $this.Checked }.GetNewClosure())
        $scrollGoals.Controls.Add($cbOther)
        $scrollGoals.Controls.Add($txtOther)
        $proposal.otherCb  = $cbOther
        $proposal.otherTxt = $txtOther
        $y += 26

        # Separator
        $sep = New-Object System.Windows.Forms.Label
        $sep.BorderStyle = 'None'
        $sep.Location    = New-Object System.Drawing.Point(5, $y)
        $sep.Size        = New-Object System.Drawing.Size(($scrollGoals.ClientSize.Width - 20), 2)
        $sep.BackColor   = $colGold
        $scrollGoals.Controls.Add($sep)
        $y += 12

        $Global:GoalProposals += $proposal
    }

    $btnFinalizeGoals.Visible = $true
    $btnFinalizeGoals.Enabled = $true
    $lblGoalStatus.Text = 'Select the goals and milestones you want, then click "Finalize Selected Goals ->".'
}

# -- Phase 2: finalized goals with milestone tracking -------------------------
# Runtime dependencies from Tab5-Progress.ps1: $scrollProgress, $lblProgressStatus, Update-ProgressBar
function Render-Goals($goals) {
    $scrollProgress.Controls.Clear()
    $Global:Goals = @()
    $y = 8
    foreach ($g in $goals) {
        $milestones = if ($g.milestones -is [array]) { $g.milestones } else { @($g.milestones) }
        $approach   = if ($g.approach) { $g.approach } else { '' }

        $entry = @{ title=$g.title; approach=$approach; targetDays=$g.targetDays; hoursPerDay=$g.hoursPerDay; checkboxes=@() }

        $lblTitle = New-Object System.Windows.Forms.Label
        $lblTitle.Text = $g.title
        $lblTitle.Location = New-Object System.Drawing.Point(5,$y)
        $lblTitle.Size = New-Object System.Drawing.Size(($scrollProgress.ClientSize.Width - 20), 22)
        $lblTitle.Font      = New-Object System.Drawing.Font('Segoe UI Semibold', 10, [System.Drawing.FontStyle]::Bold)
        $lblTitle.ForeColor = $colPurple
        $scrollProgress.Controls.Add($lblTitle)
        $y += 26

        if ($approach) {
            $lblApproach = New-Object System.Windows.Forms.Label
            $lblApproach.Text = $approach
            $lblApproach.Location = New-Object System.Drawing.Point(8,$y)
            $lblApproach.MaximumSize = New-Object System.Drawing.Size(($scrollProgress.ClientSize.Width - 20), 0)
            $lblApproach.AutoSize = $true
            $lblApproach.Font      = New-Object System.Drawing.Font('Segoe UI', 8.5, [System.Drawing.FontStyle]::Italic)
            $lblApproach.ForeColor = $colTextMuted
            $scrollProgress.Controls.Add($lblApproach)
            $y += $lblApproach.GetPreferredSize([System.Drawing.Size]::new(772, 0)).Height + 8
        }

        foreach ($m in $milestones) {
            $cb = New-Object System.Windows.Forms.CheckBox
            if ($m -is [string]) {
                $cb.Text = $m
                $cb.Tag  = @{ step=$m; done=$false }
            } else {
                $cb.Text    = $m.step
                $cb.Checked = [bool]$m.done
                $cb.Tag     = @{ step=$m.step; done=[bool]$m.done }
            }
            $cb.Location = New-Object System.Drawing.Point(20,$y)
            $cb.Size = New-Object System.Drawing.Size(($scrollProgress.ClientSize.Width - 30), 20)
            $cb.Add_CheckedChanged({ $this.Tag.done = $this.Checked; Update-ProgressBar })
            $scrollProgress.Controls.Add($cb)
            $entry.checkboxes += $cb
            $y += 22
        }
        $y += 16
        $Global:Goals += $entry
    }
    $btnFinalizeGoals.Visible = $false
    $btnFinalizeGoals.Enabled = $false
    $btnSaveProgress.Enabled  = $true
    $btnExportTxt.Enabled     = $true
    $btnExportProfile.Enabled = $true
    $lblProgressStatus.Text = 'Check off milestones as you complete them.'
    Update-ProgressBar
}

$btnFinalizeGoals.Add_Click({
    $selected = @()
    foreach ($p in $Global:GoalProposals) {
        if ($p.checkbox.Checked) {
            # Collect checked milestones
            $ms = @()
            foreach ($mcb in $p.milestoneCbs) {
                if ($mcb.Checked) { $ms += $mcb.Text }
            }
            if ($p.otherCb.Checked -and $p.otherTxt.Text.Trim()) {
                $ms += $p.otherTxt.Text.Trim()
            }
            if ($ms.Count -eq 0) {
                [System.Windows.Forms.MessageBox]::Show(
                    "Please select at least one milestone for:`n$($p.goal.title)", 'Required') | Out-Null
                return
            }
            $selected += [PSCustomObject]@{
                title        = $p.goal.title
                approach     = $p.goal.approach
                targetDays   = $p.goal.targetDays
                hoursPerDay  = if ($Global:HoursPerDay) { $Global:HoursPerDay } else { [int]$nudHoursPerDay.Value }
                milestones   = $ms
            }
        }
    }
    if ($selected.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show('Please select at least one goal.', 'Required') | Out-Null
        return
    }
    Render-Goals $selected
})

$btnSaveProgress.Add_Click({
    # Rebuild goals on profile
    $Global:Profile.name      = $txtName.Text.Trim()
    $Global:Profile.skills    = @($Script:SkillChips    | ForEach-Object { [PSCustomObject]@{ name = $_.Name; level = $_.Level } })
    $Global:Profile.interests = @($Script:InterestChips | ForEach-Object { [PSCustomObject]@{ name = $_.Name; level = $_.Level } })
    $Global:Profile.domains   = @($Script:DomainChips   | ForEach-Object { $_.Name })

    $updatedGoals = @()
    foreach ($g in $Global:Goals) {
        $ms = @()
        foreach ($cb in $g.checkboxes) {
            $ms += @{ step=$cb.Text; done=$cb.Checked }
        }
        $updatedGoals += @{ title=$g.title; approach=$g.approach; targetDays=$g.targetDays; hoursPerDay=$g.hoursPerDay; milestones=$ms }
    }
    $Global:Profile.goals = $updatedGoals
    Save-Profile $Global:Profile
    [System.Windows.Forms.MessageBox]::Show('Progress saved to profile.json','Saved') | Out-Null
})

$btnExportTxt.Add_Click({
    $sfd = New-Object System.Windows.Forms.SaveFileDialog
    $sfd.Filter = 'Text files (*.txt)|*.txt|All files (*.*)|*.*'
    $sfd.FileName = 'goals.txt'
    if ($sfd.ShowDialog() -eq 'OK') {
        $lines = @()
        foreach ($g in $Global:Goals) {
            $lines += "GOAL: $($g.title)"
            if ($g.approach) { $lines += "  $($g.approach)" }
            foreach ($cb in $g.checkboxes) {
                $tick = if ($cb.Checked) { '[x]' } else { '[ ]' }
                $lines += "  $tick $($cb.Text)"
            }
            $lines += ''
        }
        $lines | Set-Content $sfd.FileName -Encoding UTF8
        [System.Windows.Forms.MessageBox]::Show('Goals exported.','Exported') | Out-Null
    }
})

$btnExportProfile.Add_Click({
    $sfd = New-Object System.Windows.Forms.SaveFileDialog
    $sfd.Filter = 'JSON files (*.json)|*.json|All files (*.*)|*.*'
    $sfd.FileName = 'profile.json'
    if ($sfd.ShowDialog() -eq 'OK') {
        $Global:Profile | ConvertTo-Json -Depth 10 | Set-Content $sfd.FileName -Encoding UTF8
        [System.Windows.Forms.MessageBox]::Show('Profile exported.','Exported') | Out-Null
    }
})

# Wire Generate Goals button (defined in Tab2-Questions.ps1)
$btnGenGoals.Add_Click({
    if (-not $Global:ApiKey) { Show-SettingsDialog; if (-not $Global:ApiKey) { return } }

    # Require at least one question answered
    $anyAnswered = $false
    foreach ($entry in $Global:McqData) {
        if (@($entry.selectedIndices).Count -gt 0 -or ($entry.otherChecked -and $entry.otherText)) {
            $anyAnswered = $true; break
        }
    }
    if (-not $anyAnswered) {
        [System.Windows.Forms.MessageBox]::Show(
            'Please answer at least one question before generating goals.',
            'Answer Required',
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        ) | Out-Null
        return
    }

    $answers = @()
    foreach ($entry in $Global:McqData) {
        $selected = @()
        foreach ($i in @($entry.selectedIndices)) {
            if ($null -ne $i -and $i -ge 0) { $selected += $entry.options[$i] }
        }
        if ($entry.otherChecked -and $entry.otherText) { $selected += "Other: $($entry.otherText)" }
        $sel = if ($selected.Count -gt 0) { $selected -join '; ' } else { '(no answer)' }
        $answers += "$($entry.question): $sel"
    }
    $answersStr = $answers -join ' | '

    $domain       = ($Script:DomainChips | ForEach-Object { $_.Name }) -join ', '
    $swotStr      = if ($Global:SwotJson) { $Global:SwotJson | ConvertTo-Json -Compress } else { '' }
    $apiKey       = $Global:ApiKey
    $targetDays  = [int]$nudTargetDays.Value
    $hoursPerDay = [int]$nudHoursPerDay.Value
    $Global:TargetDays  = $targetDays
    $Global:HoursPerDay = $hoursPerDay

    $lblQStatus.Text = 'Generating goals... please wait.'
    $btnGenGoals.Enabled = $false

    $totalHours = $targetDays * $hoursPerDay

    # Scale goal count: 20 working hours minimum per goal
    $maxGoals     = [Math]::Max(1, [Math]::Min(5, [int][Math]::Floor($totalHours / 20.0)))
    $minGoals     = [Math]::Max(1, $maxGoals - 2)
    $goalCountStr = if ($minGoals -eq $maxGoals) { "exactly $maxGoals" } else { "$minGoals-$maxGoals" }

    # Milestones: hard cap at 3 per goal
    $maxMilestones = 3
    $minMilestones = 2

    $sysMsg = @"
You are an expert goal-setting coach. Return a JSON array of $goalCountStr highly personalised, SMART goals achievable in $targetDays working days at $hoursPerDay hrs/day (total $totalHours hours):
[{"title":"<action-verb + specific outcome>","approach":"<2-3 sentences naming the exact tools, platforms, or methods the user should use  -  referencing their named skills and interests>","targetDays":$targetDays,"milestones":["<specific actionable step>",...]},...]
Requirements: (1) Goal titles start with a verb and are specific to the user's domain(s). (2) The 'approach' explicitly names real tools/courses/frameworks tailored to the user's exact skills and interests listed below  -  never generic advice. (3) Each goal has exactly $minMilestones-$maxMilestones ordered, concrete milestones sized to fit the $totalHours-hour total budget  -  not vague phases. (4) Goals directly address the SWOT weaknesses and leverage the SWOT strengths. (5) Every goal must explicitly build on or improve at least one of the user's stated skills. (6) Every goal must connect to at least one of the user's stated interests. (7) All goals together are achievable within the total time budget. No markdown fences.
"@
    $skillsStr    = ($Script:SkillChips    | ForEach-Object { "$($_.Name) [$($_.Level)]" }) -join ', '
    $interestsStr = ($Script:InterestChips | ForEach-Object { "$($_.Name) [$($_.Level)]" }) -join ', '
    $usrMsg = "Domain(s) to improve: $domain`nName: $($Global:Profile.name)`nSkills: $skillsStr`nInterests: $interestsStr`nSWOT Analysis: $swotStr`nDiagnostic MCQ Answers: $answersStr"

    Invoke-Async $Script:ApiCallScript @{ApiKey=$apiKey;Model='gpt-4.1';SystemMsg=$sysMsg;UserMsg=$usrMsg;MaxTokens=2500} `
        -onDone {
            param($result)
            try {
                $clean = ($result[0] -replace '(?s)```json','' -replace '(?s)```','').Trim()
                $goals = $clean | ConvertFrom-Json
                Render-GoalProposals $goals
                $tabs.SelectedTab = $tabGoals
                $lblQStatus.Text = 'Goals proposed. Review and finalize on Tab 3.'
            } catch {
                $lblQStatus.Text = "Parse error: $_"
            }
            $btnGenGoals.Enabled = $true
        } `
        -onError {
            param($err)
            Write-ErrorLog $err
            $lblQStatus.Text = "Error: $err"
            $btnGenGoals.Enabled = $true
        }
})
