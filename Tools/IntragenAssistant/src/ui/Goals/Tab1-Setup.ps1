# ==============================================
# TAB 1  -  SETUP
# ==============================================
$pnlSetup = New-Object System.Windows.Forms.Panel
$pnlSetup.Dock      = 'Fill'
$pnlSetup.Padding   = New-Object System.Windows.Forms.Padding(10)
$pnlSetup.BackColor = $colBackground
$tabSetup.Controls.Add($pnlSetup)

# ----------------------------------------------
# Script-scope chip tracking arrays
# ----------------------------------------------
$Script:SkillChips    = @()   # @{ Name=''; Level='Beginner'; Panel=$pnl }
$Script:InterestChips = @()   # same shape
$Script:DomainChips   = @()   # @{ Name=''; Panel=$pnl }

# ----------------------------------------------
# Chip helper functions
# ----------------------------------------------
function Add-SkillChip {
    param([string]$name, [string]$level = 'Beginner')
    $name = $name.Trim()
    if (-not $name) { return }
    if ($Script:SkillChips | Where-Object { $_.Name -ieq $name }) { return }

    $entry = @{ Name = $name; Level = $level; Panel = $null }

    $chip = New-Object System.Windows.Forms.Panel
    $chip.Width       = 250
    $chip.Height      = 26
    $chip.BackColor   = $colPanel
    $chip.BorderStyle = 'FixedSingle'
    $chip.Margin      = New-Object System.Windows.Forms.Padding(2)

    $lblW = [System.Windows.Forms.TextRenderer]::MeasureText($name, $fontCaption).Width + 10
    $cboX = 4 + $lblW + 4
    $btnX = $cboX + 115 + 4

    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text      = $name
    $lbl.Location  = New-Object System.Drawing.Point(4, 5)
    $lbl.AutoSize  = $false
    $lbl.Width     = $lblW
    $lbl.ForeColor = $colTextMuted
    $lbl.Font      = $fontCaption

    $cbo = New-Object System.Windows.Forms.ComboBox
    $cbo.DropDownStyle = 'DropDownList'
    @('Beginner','Intermediate','Advanced','Expert') | ForEach-Object { [void]$cbo.Items.Add($_) }
    $cbo.SelectedItem = if ($level -in @('Beginner','Intermediate','Advanced','Expert')) { $level } else { 'Beginner' }
    $cbo.Location  = New-Object System.Drawing.Point($cboX, 3)
    $cbo.Width     = 115
    $cbo.Height    = 20
    $cbo.Font      = $fontCaption
    $cbo.BackColor = $colPanel

    $btnRem = New-Object System.Windows.Forms.Button
    $btnRem.Text     = '-'
    $btnRem.Location = New-Object System.Drawing.Point($btnX, 3)
    $btnRem.Width    = 28
    $btnRem.Height   = 20
    Set-SecondaryButton $btnRem

    $chip.Width = $btnX + 28 + 4

    $entry.Panel = $chip
    $Script:SkillChips += $entry

    $cbo.Add_SelectedIndexChanged({
        $entry.Level = $cbo.SelectedItem
    }.GetNewClosure())

    $localFlow = $flowSkills
    $btnRem.Add_Click({
        $localFlow.Controls.Remove($chip)
        $Script:SkillChips = @($Script:SkillChips | Where-Object { $_.Panel -ne $chip })
    }.GetNewClosure())

    $chip.Controls.AddRange(@($lbl, $cbo, $btnRem))
    $flowSkills.Controls.Add($chip)
}

function Add-InterestChip {
    param([string]$name, [string]$level = 'Beginner')
    $name = $name.Trim()
    if (-not $name) { return }
    if ($Script:InterestChips | Where-Object { $_.Name -ieq $name }) { return }

    $entry = @{ Name = $name; Level = $level; Panel = $null }

    $chip = New-Object System.Windows.Forms.Panel
    $chip.Width       = 250
    $chip.Height      = 26
    $chip.BackColor   = $colPanel
    $chip.BorderStyle = 'FixedSingle'
    $chip.Margin      = New-Object System.Windows.Forms.Padding(2)

    $lblW = [System.Windows.Forms.TextRenderer]::MeasureText($name, $fontCaption).Width + 10
    $cboX = 4 + $lblW + 4
    $btnX = $cboX + 115 + 4

    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text      = $name
    $lbl.Location  = New-Object System.Drawing.Point(4, 5)
    $lbl.AutoSize  = $false
    $lbl.Width     = $lblW
    $lbl.ForeColor = $colTextMuted
    $lbl.Font      = $fontCaption

    $cbo = New-Object System.Windows.Forms.ComboBox
    $cbo.DropDownStyle = 'DropDownList'
    @('Beginner','Intermediate','Advanced','Expert') | ForEach-Object { [void]$cbo.Items.Add($_) }
    $cbo.SelectedItem = if ($level -in @('Beginner','Intermediate','Advanced','Expert')) { $level } else { 'Beginner' }
    $cbo.Location  = New-Object System.Drawing.Point($cboX, 3)
    $cbo.Width     = 115
    $cbo.Height    = 20
    $cbo.Font      = $fontCaption
    $cbo.BackColor = $colPanel

    $btnRem = New-Object System.Windows.Forms.Button
    $btnRem.Text     = '-'
    $btnRem.Location = New-Object System.Drawing.Point($btnX, 3)
    $btnRem.Width    = 28
    $btnRem.Height   = 20
    Set-SecondaryButton $btnRem

    $chip.Width = $btnX + 28 + 4

    $entry.Panel = $chip
    $Script:InterestChips += $entry

    $cbo.Add_SelectedIndexChanged({
        $entry.Level = $cbo.SelectedItem
    }.GetNewClosure())

    $localFlow = $flowInterests
    $btnRem.Add_Click({
        $localFlow.Controls.Remove($chip)
        $Script:InterestChips = @($Script:InterestChips | Where-Object { $_.Panel -ne $chip })
    }.GetNewClosure())

    $chip.Controls.AddRange(@($lbl, $cbo, $btnRem))
    $flowInterests.Controls.Add($chip)
}

function Add-DomainChip {
    param([string]$name)
    $name = $name.Trim()
    if (-not $name) { return }
    if ($Script:DomainChips | Where-Object { $_.Name -ieq $name }) { return }

    $entry = @{ Name = $name; Panel = $null }

    $chip = New-Object System.Windows.Forms.Panel
    $chip.Width       = 170
    $chip.Height      = 26
    $chip.BackColor   = $colPanel
    $chip.BorderStyle = 'FixedSingle'
    $chip.Margin      = New-Object System.Windows.Forms.Padding(2)

    $lblW = [System.Windows.Forms.TextRenderer]::MeasureText($name, $fontCaption).Width + 10
    $btnX = 4 + $lblW + 4

    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text      = $name
    $lbl.Location  = New-Object System.Drawing.Point(4, 5)
    $lbl.AutoSize  = $false
    $lbl.Width     = $lblW
    $lbl.ForeColor = $colTextMuted
    $lbl.Font      = $fontCaption

    $btnRem = New-Object System.Windows.Forms.Button
    $btnRem.Text     = '-'
    $btnRem.Location = New-Object System.Drawing.Point($btnX, 3)
    $btnRem.Width    = 28
    $btnRem.Height   = 20
    Set-SecondaryButton $btnRem

    $chip.Width = $btnX + 28 + 4

    $entry.Panel = $chip
    $Script:DomainChips += $entry

    $localFlow = $flowDomains
    $btnRem.Add_Click({
        $localFlow.Controls.Remove($chip)
        $Script:DomainChips = @($Script:DomainChips | Where-Object { $_.Panel -ne $chip })
    }.GetNewClosure())

    $chip.Controls.AddRange(@($lbl, $btnRem))
    $flowDomains.Controls.Add($chip)
}

# =============================================
# PROFILE group  (Name + Import)
# =============================================
$grpProfile = New-Object System.Windows.Forms.GroupBox
$grpProfile.Text      = 'User Profile'
$grpProfile.Dock      = 'Top'
$grpProfile.Height    = 60
$grpProfile.ForeColor = $colPurple
$grpProfile.Font      = $fontSubhead

$pnlNameRow = New-Object System.Windows.Forms.Panel
$pnlNameRow.Dock   = 'Fill'
$pnlNameRow.Height = 30

$lblName = New-Object System.Windows.Forms.Label
$lblName.Text     = 'Name:'
$lblName.Location = New-Object System.Drawing.Point(8, 8)
$lblName.AutoSize = $true
$lblName.Font     = $fontLabel

$txtName = New-Object System.Windows.Forms.TextBox
$txtName.Location  = New-Object System.Drawing.Point(55, 5)
$txtName.Width     = 220
$txtName.Text      = $Global:Profile.name
$txtName.BackColor = $colPanel
$txtName.Font      = $fontInput

$pnlNameRow.Controls.AddRange(@($lblName, $txtName))
$grpProfile.Controls.Add($pnlNameRow)

# =============================================
# SKILLS group
# =============================================
$grpSkills = New-Object System.Windows.Forms.GroupBox
$grpSkills.Text      = 'Skills'
$grpSkills.Dock      = 'Top'
$grpSkills.Height    = 90
$grpSkills.ForeColor = $colPurple
$grpSkills.Font      = $fontSubhead

# Chip display area
$flowSkills = New-Object System.Windows.Forms.FlowLayoutPanel
$flowSkills.Dock          = 'Top'
$flowSkills.AutoSize      = $true
$flowSkills.AutoSizeMode  = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$flowSkills.MinimumSize   = New-Object System.Drawing.Size(0, 32)
$flowSkills.WrapContents  = $true
$flowSkills.AutoScroll    = $false
$flowSkills.BackColor     = $colBackground
$flowSkills.Padding       = New-Object System.Windows.Forms.Padding(2)

# Add-row panel
$pnlSkillAdd = New-Object System.Windows.Forms.Panel
$pnlSkillAdd.Dock   = 'Top'
$pnlSkillAdd.Height = 30

$txtSkillEntry = New-Object System.Windows.Forms.TextBox
$txtSkillEntry.Location  = New-Object System.Drawing.Point(8, 5)
$txtSkillEntry.Width     = 180
$txtSkillEntry.BackColor = $colPanel
$txtSkillEntry.Font      = $fontInput

$cboSkillLevel = New-Object System.Windows.Forms.ComboBox
$cboSkillLevel.DropDownStyle = 'DropDownList'
@('Beginner','Intermediate','Advanced','Expert') | ForEach-Object { [void]$cboSkillLevel.Items.Add($_) }
$cboSkillLevel.SelectedIndex = 0
$cboSkillLevel.Location  = New-Object System.Drawing.Point(196, 4)
$cboSkillLevel.Width     = 115
$cboSkillLevel.Font      = $fontCaption
$cboSkillLevel.BackColor = $colPanel

$btnAddSkill = New-Object System.Windows.Forms.Button
$btnAddSkill.Text     = '+'
$btnAddSkill.Location = New-Object System.Drawing.Point(318, 4)
$btnAddSkill.Width    = 28
$btnAddSkill.Height   = 22
Set-SecondaryButton $btnAddSkill

$btnAddSkill.Add_Click({
    Add-SkillChip $txtSkillEntry.Text $cboSkillLevel.SelectedItem
    $txtSkillEntry.Text  = ''
    $cboSkillLevel.SelectedIndex = 0
    $txtSkillEntry.Focus()
})

$txtSkillEntry.Add_KeyDown({
    if ($_.KeyCode -eq 'Return') {
        Add-SkillChip $txtSkillEntry.Text $cboSkillLevel.SelectedItem
        $txtSkillEntry.Text  = ''
        $cboSkillLevel.SelectedIndex = 0
        $_.SuppressKeyPress = $true
    }
})

$pnlSkillAdd.Controls.AddRange(@($txtSkillEntry, $cboSkillLevel, $btnAddSkill))

# Stack inside grpSkills: add-row at top, flow below (reverse visual order for Dock=Top)
$grpSkills.Controls.AddRange(@($flowSkills, $pnlSkillAdd))

$flowSkills.Add_SizeChanged({
    $newH = $flowSkills.Height + $pnlSkillAdd.Height + 25
    if ($grpSkills.Height -ne $newH) { $grpSkills.Height = $newH }
})

# =============================================
# INTERESTS group
# =============================================
$grpInterests = New-Object System.Windows.Forms.GroupBox
$grpInterests.Text      = 'Interests'
$grpInterests.Dock      = 'Top'
$grpInterests.Height    = 90
$grpInterests.ForeColor = $colPurple
$grpInterests.Font      = $fontSubhead

$flowInterests = New-Object System.Windows.Forms.FlowLayoutPanel
$flowInterests.Dock         = 'Top'
$flowInterests.AutoSize     = $true
$flowInterests.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$flowInterests.MinimumSize  = New-Object System.Drawing.Size(0, 32)
$flowInterests.WrapContents = $true
$flowInterests.AutoScroll   = $false
$flowInterests.BackColor    = $colBackground
$flowInterests.Padding      = New-Object System.Windows.Forms.Padding(2)

$pnlInterestAdd = New-Object System.Windows.Forms.Panel
$pnlInterestAdd.Dock   = 'Top'
$pnlInterestAdd.Height = 30

$txtInterestEntry = New-Object System.Windows.Forms.TextBox
$txtInterestEntry.Location  = New-Object System.Drawing.Point(8, 5)
$txtInterestEntry.Width     = 180
$txtInterestEntry.BackColor = $colPanel
$txtInterestEntry.Font      = $fontInput

$cboInterestLevel = New-Object System.Windows.Forms.ComboBox
$cboInterestLevel.DropDownStyle = 'DropDownList'
@('Beginner','Intermediate','Advanced','Expert') | ForEach-Object { [void]$cboInterestLevel.Items.Add($_) }
$cboInterestLevel.SelectedIndex = 0
$cboInterestLevel.Location  = New-Object System.Drawing.Point(196, 4)
$cboInterestLevel.Width     = 115
$cboInterestLevel.Font      = $fontCaption
$cboInterestLevel.BackColor = $colPanel

$btnAddInterest = New-Object System.Windows.Forms.Button
$btnAddInterest.Text     = '+'
$btnAddInterest.Location = New-Object System.Drawing.Point(318, 4)
$btnAddInterest.Width    = 28
$btnAddInterest.Height   = 22
Set-SecondaryButton $btnAddInterest

$btnAddInterest.Add_Click({
    Add-InterestChip $txtInterestEntry.Text $cboInterestLevel.SelectedItem
    $txtInterestEntry.Text = ''
    $cboInterestLevel.SelectedIndex = 0
    $txtInterestEntry.Focus()
})

$txtInterestEntry.Add_KeyDown({
    if ($_.KeyCode -eq 'Return') {
        Add-InterestChip $txtInterestEntry.Text $cboInterestLevel.SelectedItem
        $txtInterestEntry.Text = ''
        $cboInterestLevel.SelectedIndex = 0
        $_.SuppressKeyPress = $true
    }
})

$pnlInterestAdd.Controls.AddRange(@($txtInterestEntry, $cboInterestLevel, $btnAddInterest))
$grpInterests.Controls.AddRange(@($flowInterests, $pnlInterestAdd))

$flowInterests.Add_SizeChanged({
    $newH = $flowInterests.Height + $pnlInterestAdd.Height + 25
    if ($grpInterests.Height -ne $newH) { $grpInterests.Height = $newH }
})

# =============================================
# DOMAIN group
# =============================================
$grpDomain = New-Object System.Windows.Forms.GroupBox
$grpDomain.Text      = 'Domain Selection'
$grpDomain.Dock      = 'Top'
$grpDomain.Height    = 90
$grpDomain.ForeColor = $colPurple
$grpDomain.Font      = $fontSubhead

$flowDomains = New-Object System.Windows.Forms.FlowLayoutPanel
$flowDomains.Dock         = 'Top'
$flowDomains.AutoSize     = $true
$flowDomains.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$flowDomains.MinimumSize  = New-Object System.Drawing.Size(0, 32)
$flowDomains.WrapContents = $true
$flowDomains.AutoScroll   = $false
$flowDomains.BackColor    = $colBackground
$flowDomains.Padding      = New-Object System.Windows.Forms.Padding(2)

$pnlDomainAdd = New-Object System.Windows.Forms.Panel
$pnlDomainAdd.Dock   = 'Top'
$pnlDomainAdd.Height = 30

$txtDomainEntry = New-Object System.Windows.Forms.TextBox
$txtDomainEntry.Location  = New-Object System.Drawing.Point(8, 5)
$txtDomainEntry.Width     = 180
$txtDomainEntry.BackColor = $colPanel
$txtDomainEntry.Font      = $fontInput

$btnAddDomain = New-Object System.Windows.Forms.Button
$btnAddDomain.Text     = '+'
$btnAddDomain.Location = New-Object System.Drawing.Point(195, 4)
$btnAddDomain.Width    = 28
$btnAddDomain.Height   = 22
Set-SecondaryButton $btnAddDomain

$btnAddDomain.Add_Click({
    Add-DomainChip $txtDomainEntry.Text
    $txtDomainEntry.Text = ''
    $txtDomainEntry.Focus()
})

$txtDomainEntry.Add_KeyDown({
    if ($_.KeyCode -eq 'Return') {
        Add-DomainChip $txtDomainEntry.Text
        $txtDomainEntry.Text = ''
        $_.SuppressKeyPress = $true
    }
})

$lblPreset = New-Object System.Windows.Forms.Label
$lblPreset.Text     = 'Quick add:'
$lblPreset.Location = New-Object System.Drawing.Point(235, 7)
$lblPreset.AutoSize = $true
$lblPreset.Font     = $fontCaption

$cboDomain = New-Object System.Windows.Forms.ComboBox
$cboDomain.Location      = New-Object System.Drawing.Point(305, 4)
$cboDomain.Width         = 140
$cboDomain.DropDownStyle = 'DropDownList'
$cboDomain.Font          = $fontCaption
@(' -  pick  - ','Coding','Git','Soft Skills','Presentations','MBA','Leadership','Data Science','Marketing','Project Management') | ForEach-Object { [void]$cboDomain.Items.Add($_) }
$cboDomain.SelectedIndex = 0

$cboDomain.Add_SelectedIndexChanged({
    if ($cboDomain.SelectedIndex -gt 0) {
        Add-DomainChip $cboDomain.SelectedItem.ToString()
        $cboDomain.SelectedIndex = 0
    }
}.GetNewClosure())

$pnlDomainAdd.Controls.AddRange(@($txtDomainEntry, $btnAddDomain, $lblPreset, $cboDomain))
$grpDomain.Controls.AddRange(@($flowDomains, $pnlDomainAdd))

$flowDomains.Add_SizeChanged({
    $newH = $flowDomains.Height + $pnlDomainAdd.Height + 25
    if ($grpDomain.Height -ne $newH) { $grpDomain.Height = $newH }
})

# =============================================
# Pre-populate chips from profile
# =============================================
foreach ($s in $Global:Profile.skills) {
    if ($s -is [string]) { Add-SkillChip $s 'Beginner' }
    elseif ($s.name)     { Add-SkillChip $s.name $s.level }
}
foreach ($i in $Global:Profile.interests) {
    if ($i -is [string]) { Add-InterestChip $i 'Beginner' }
    elseif ($i.name)     { Add-InterestChip $i.name $i.level }
}
if ($Global:Profile.PSObject.Properties['domains']) {
    foreach ($d in $Global:Profile.domains) { if ($d) { Add-DomainChip $d } }
}
if ($Script:DomainChips.Count -eq 0) { Add-DomainChip 'Coding' }

# =============================================
# Time commitment group
# =============================================
$grpTimeCommit = New-Object System.Windows.Forms.GroupBox
$grpTimeCommit.Text      = 'Time Commitment'
$grpTimeCommit.Dock      = 'Top'
$grpTimeCommit.Height    = 58
$grpTimeCommit.ForeColor = $colPurple
$grpTimeCommit.Font      = $fontSubhead

$lblTargetDays = New-Object System.Windows.Forms.Label
$lblTargetDays.Text     = 'Target working days to complete goal:'
$lblTargetDays.Location = New-Object System.Drawing.Point(10, 22)
$lblTargetDays.AutoSize = $true

$nudTargetDays = New-Object System.Windows.Forms.NumericUpDown
$nudTargetDays.Location = New-Object System.Drawing.Point(255, 20)
$nudTargetDays.Width    = 65
$nudTargetDays.Minimum  = 7; $nudTargetDays.Maximum = 730; $nudTargetDays.Value = 90

$lblHrsPerDay = New-Object System.Windows.Forms.Label
$lblHrsPerDay.Text     = 'Hours / working day available:'
$lblHrsPerDay.Location = New-Object System.Drawing.Point(345, 22)
$lblHrsPerDay.AutoSize = $true

$nudHoursPerDay = New-Object System.Windows.Forms.NumericUpDown
$nudHoursPerDay.Location = New-Object System.Drawing.Point(540, 20)
$nudHoursPerDay.Width    = 55
$nudHoursPerDay.Minimum  = 1; $nudHoursPerDay.Maximum = 16; $nudHoursPerDay.Value = 2

$grpTimeCommit.Controls.AddRange(@($lblTargetDays, $nudTargetDays, $lblHrsPerDay, $nudHoursPerDay))

# =============================================
# Actions panel
# =============================================
$pnlActions = New-Object System.Windows.Forms.Panel
$pnlActions.Dock      = 'Top'
$pnlActions.Height    = 72
$pnlActions.BackColor = $colBackground

$lblSetupHint = New-Object System.Windows.Forms.Label
$lblSetupHint.Text      = 'Fill in your profile, add skills/interests/domains, set time commitment, then click Analyse.'
$lblSetupHint.Dock      = 'Top'
$lblSetupHint.AutoSize  = $true
$lblSetupHint.ForeColor = $colTextMuted
$lblSetupHint.Font      = $fontCaption

$pnlActionBtns = New-Object System.Windows.Forms.Panel
$pnlActionBtns.Dock   = 'Top'
$pnlActionBtns.Height = 32

$btnAnalyse = New-Object System.Windows.Forms.Button
$btnAnalyse.Text     = 'Analyse (SWOT)'
$btnAnalyse.Location = New-Object System.Drawing.Point(0, 2)
$btnAnalyse.Width    = 130
Set-PrimaryButton $btnAnalyse
$btnAnalyse.Add_Click({
    if (-not $Global:ApiKey) { Show-SettingsDialog; if (-not $Global:ApiKey) { return } }

    # Persist profile from chip data
    $Global:Profile.name      = $txtName.Text.Trim()
    $Global:Profile.skills    = @($Script:SkillChips    | ForEach-Object { [PSCustomObject]@{ name = $_.Name; level = $_.Level } })
    $Global:Profile.interests = @($Script:InterestChips | ForEach-Object { [PSCustomObject]@{ name = $_.Name; level = $_.Level } })
    $Global:Profile.domains   = @($Script:DomainChips   | ForEach-Object { $_.Name })

    $domain = ($Script:DomainChips | ForEach-Object { $_.Name }) -join ', '
    if (-not $domain) { [System.Windows.Forms.MessageBox]::Show('Please add at least one domain.', 'Required') | Out-Null; return }

    $btnAnalyse.Enabled = $false
    $btnAnalyse.Text    = 'Working...'
    $lblSpinner.ForeColor = $colTextMuted
    $lblSpinner.Text  = '|'
    $lblSpinner.Visible = $true
    $Script:SpinIndex = 0
    $Script:SpinTimer.Start()

    $targetDays  = [int]$nudTargetDays.Value
    $hoursPerDay = [int]$nudHoursPerDay.Value

    $skillsStr    = ($Script:SkillChips    | ForEach-Object { "$($_.Name) [$($_.Level)]" }) -join ', '
    $interestsStr = ($Script:InterestChips | ForEach-Object { "$($_.Name) [$($_.Level)]" }) -join ', '

    $sysMsg  = @'
You are a career coach performing a personal SWOT analysis. Return JSON exactly:
{"Strengths":[],"Weaknesses":[],"Opportunities":[],"Threats":[]}
Rules: (1) Each quadrant has 4-6 complete, actionable sentences  -  no generic filler. (2) STRENGTHS must each name a specific skill from the user's skill list and explain why it is an asset in their target domain. (3) WEAKNESSES must each name a specific skill gap or interest that is underdeveloped relative to the target domain. (4) OPPORTUNITIES must each name a concrete career/learning opportunity within the target domain that aligns with the user's interests and fits within the time constraint. (5) THREATS must name real external risks (market, competition, time pressure) specific to the domain and user profile. (6) Strengths/Weaknesses are internal; Opportunities/Threats are external. No markdown fences.
'@
    $usrMsg  = "Name: $($Global:Profile.name)`nDomain(s) to improve: $domain`nSkills: $skillsStr`nInterests: $interestsStr`nTime available: $targetDays working days at $hoursPerDay hrs/day."
    $apiKey  = $Global:ApiKey

    $pp = Get-ProviderParams 'providerGoals'
    Invoke-Async $Script:ApiCallScript @{ApiKey=$pp.ApiKey;Model=$pp.Model;Provider=$pp.Provider;SystemMsg=$sysMsg;UserMsg=$usrMsg;MaxTokens=2000;Temperature=$Global:OAISettings.temperature;TopP=$Global:OAISettings.topP} `
        -onDone {
            param($result)
            $raw = $result[0]
            $Script:SpinTimer.Stop()
            try {
                $clean = ($raw -replace '(?s)```json','' -replace '(?s)```','').Trim()
                $parsed = $clean | ConvertFrom-Json
                # Accept flat {"Strengths":[...]} or wrapped {"swot":{"Strengths":[...]}}
                if ($parsed.Strengths) {
                    $Global:SwotJson = $parsed
                } elseif ($parsed.swot -and $parsed.swot.Strengths) {
                    $Global:SwotJson = $parsed.swot
                } else {
                    throw "Unexpected response structure. Raw:`n$($clean.Substring(0, [Math]::Min(300, $clean.Length)))"
                }
                $lblSpinner.Text      = [char]0x2713   # ✓
                $lblSpinner.ForeColor = [System.Drawing.Color]::LightGreen
                $btnGenQuestions.Enabled = $true
            } catch {
                $lblSpinner.Text      = [char]0x2717   # ✗
                $lblSpinner.ForeColor = [System.Drawing.Color]::IndianRed
                [System.Windows.Forms.MessageBox]::Show("Analyse failed: $_`n`nCheck your API key and try again.", 'Error') | Out-Null
            }
            $btnAnalyse.Enabled = $true
            $btnAnalyse.Text    = 'Analyse (SWOT)'
        } `
        -onError {
            param($err)
            Write-ErrorLog $err
            $Script:SpinTimer.Stop()
            $lblSpinner.Text      = [char]0x2717   # ✗
            $lblSpinner.ForeColor = [System.Drawing.Color]::IndianRed
            $btnAnalyse.Enabled = $true
            $btnAnalyse.Text    = 'Analyse (SWOT)'
            [System.Windows.Forms.MessageBox]::Show("Analyse error:`n$err", 'Error') | Out-Null
        }
})

$btnGenQuestions = New-Object System.Windows.Forms.Button
$btnGenQuestions.Text     = 'Generate Questions ->'
$btnGenQuestions.Location = New-Object System.Drawing.Point(140, 2)
$btnGenQuestions.Width    = 165
$btnGenQuestions.Enabled  = $false
Set-PrimaryButton $btnGenQuestions

$lblSpinner = New-Object System.Windows.Forms.Label
$lblSpinner.Location  = New-Object System.Drawing.Point(315, 4)
$lblSpinner.Width     = 26
$lblSpinner.Height    = 24
$lblSpinner.Font      = New-Object System.Drawing.Font('Consolas', 13, [System.Drawing.FontStyle]::Bold)
$lblSpinner.ForeColor = $colTextMuted
$lblSpinner.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$lblSpinner.Visible   = $false

$Script:SpinChars = @('|', '/', '-', '\')
$Script:SpinIndex = 0
$Script:SpinTimer = New-Object System.Windows.Forms.Timer
$Script:SpinTimer.Interval = 100
$Script:SpinTimer.Add_Tick({
    $lblSpinner.Text = $Script:SpinChars[$Script:SpinIndex % 4]
    $Script:SpinIndex++
})

$pnlActionBtns.Controls.AddRange(@($btnAnalyse, $btnGenQuestions, $lblSpinner))
$pnlActions.Controls.AddRange(@($lblSetupHint, $pnlActionBtns))

# =============================================
# Scrollable top wrapper + final assembly
# =============================================
$pnlTopScroll = New-Object System.Windows.Forms.Panel
$pnlTopScroll.Dock       = 'Fill'
$pnlTopScroll.AutoScroll = $true
$pnlTopScroll.BackColor  = $colBackground

# Dock=Top controls are added in REVERSE visual order (last in array = topmost)
$pnlTopScroll.Controls.AddRange(@($pnlActions, $grpTimeCommit, $grpDomain, $grpInterests, $grpSkills, $grpProfile))

$pnlSetup.Controls.Add($pnlTopScroll)
