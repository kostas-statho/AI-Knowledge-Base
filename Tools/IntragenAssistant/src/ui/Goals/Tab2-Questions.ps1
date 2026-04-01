# ==============================================
# TAB 2  -  QUESTIONS
# ==============================================
$pnlQ = New-Object System.Windows.Forms.Panel
$pnlQ.Dock = 'Fill'
$tabQuestions.Controls.Add($pnlQ)

$lblQStatus = New-Object System.Windows.Forms.Label
$lblQStatus.Text = 'Run "Analyse (SWOT)" on Tab 1, then click "Generate Questions ->".'
$lblQStatus.Location = New-Object System.Drawing.Point(10,10)
$lblQStatus.AutoSize = $true

# Scrollable panel for MCQs
$scrollQ = New-Object System.Windows.Forms.Panel
$scrollQ.AutoScroll  = $true
$scrollQ.BorderStyle = 'FixedSingle'
$scrollQ.BackColor   = $colBackground
$scrollQ.Dock        = 'Fill'

$btnGenGoals = New-Object System.Windows.Forms.Button
$btnGenGoals.Text    = 'Generate Goals ->'
$btnGenGoals.Width   = 150
$btnGenGoals.Enabled = $false
Set-PrimaryButton $btnGenGoals

# Header panel: status label pinned to top
$pnlQHeader = New-Object System.Windows.Forms.Panel
$pnlQHeader.Dock = 'Top'; $pnlQHeader.Height = 32
$lblQStatus.Location = New-Object System.Drawing.Point(10, 8)
$pnlQHeader.Controls.Add($lblQStatus)

# Footer panel: Generate Goals button pinned to bottom
$pnlQFooter = New-Object System.Windows.Forms.Panel
$pnlQFooter.Dock = 'Bottom'; $pnlQFooter.Height = 38
$btnGenGoals.Location = New-Object System.Drawing.Point(10, 5)
$pnlQFooter.Controls.Add($btnGenGoals)

$pnlQ.Controls.AddRange(@($pnlQHeader, $pnlQFooter, $scrollQ))

function Render-MCQs($mcqs) {
    $scrollQ.Controls.Clear()
    $Global:McqData = @()
    $y = 10
    foreach ($q in $mcqs) {
        $qNum = $Global:McqData.Count + 1
        $entry = @{ question=$q.question; options=$q.options; answer=$q.answer; checkboxes=@(); selectedIndices=@(); otherChecked=$false; otherText='' }

        # Question label  -  wraps to as many lines as needed
        $lbl = New-Object System.Windows.Forms.Label
        $lbl.Text = "Q$qNum.  $($q.question)"
        $lbl.Location = New-Object System.Drawing.Point(5,$y)
        $lbl.MaximumSize = New-Object System.Drawing.Size(($scrollQ.ClientSize.Width - 20), 0)
        $lbl.AutoSize = $true
        $lbl.Font      = New-Object System.Drawing.Font('Segoe UI Semibold', 9)
        $lbl.ForeColor = $colPurple
        $scrollQ.Controls.Add($lbl)
        $y += $lbl.GetPreferredSize([System.Drawing.Size]::new(760, 0)).Height + 4

        # Options panel  -  height calculated dynamically from actual option heights
        $grpPanel = New-Object System.Windows.Forms.Panel
        $grpPanel.Location  = New-Object System.Drawing.Point(5,$y)
        $grpPanel.BackColor = $colPanel

        $ry = 4
        for ($i = 0; $i -lt $q.options.Count; $i++) {
            $cb = New-Object System.Windows.Forms.CheckBox
            $cb.Text = $q.options[$i]
            $cb.AutoSize = $true
            $cb.MaximumSize = New-Object System.Drawing.Size(($scrollQ.ClientSize.Width - 60), 0)
            $cb.Location = New-Object System.Drawing.Point(15,$ry)
            $captureEntry = $entry
            $captureI = $i
            $cb.Add_CheckedChanged({
                if ($this.Checked) {
                    $captureEntry['selectedIndices'] = @($captureEntry['selectedIndices']) + $captureI
                } else {
                    $captureEntry['selectedIndices'] = @($captureEntry['selectedIndices'] | Where-Object { $_ -ne $captureI })
                }
            }.GetNewClosure())
            $grpPanel.Controls.Add($cb)
            $entry.checkboxes += $cb
            $textSize = [System.Windows.Forms.TextRenderer]::MeasureText($cb.Text, $cb.Font, [System.Drawing.Size]::new(700, 0), [System.Windows.Forms.TextFormatFlags]::WordBreak)
            $ry += [Math]::Max($textSize.Height, 17) + 6
        }

        # "Other" row  -  checkbox + text input
        $cbOther = New-Object System.Windows.Forms.CheckBox
        $cbOther.Text = 'Other:'
        $cbOther.Location = New-Object System.Drawing.Point(15,$ry)
        $cbOther.Size = New-Object System.Drawing.Size(65,20)
        $txtOther = New-Object System.Windows.Forms.TextBox
        $txtOther.Location = New-Object System.Drawing.Point(85,$ry)
        $txtOther.Size     = New-Object System.Drawing.Size(($scrollQ.ClientSize.Width - 155), 20)
        $txtOther.Enabled  = $false
        $txtOther.BackColor = $colPanel; $txtOther.Font = $fontLabel
        $captureEntry2 = $entry
        $captureTxtOther = $txtOther
        $cbOther.Add_CheckedChanged({
            $captureTxtOther.Enabled = $this.Checked
            $captureEntry2['otherChecked'] = $this.Checked
        }.GetNewClosure())
        $txtOther.Add_TextChanged({
            $captureEntry2['otherText'] = $this.Text
        }.GetNewClosure())
        $grpPanel.Controls.Add($cbOther)
        $grpPanel.Controls.Add($txtOther)
        $ry += 30  # Other row height + bottom padding

        $grpPanel.Size = New-Object System.Drawing.Size(($scrollQ.ClientSize.Width - 20), $ry)
        $scrollQ.Controls.Add($grpPanel)
        $y += $ry + 12
        $Global:McqData += $entry
    }
    $btnGenGoals.Enabled = $true
    $lblQStatus.Text = 'Answer at least one question (select all that apply), then click "Generate Goals ->".'
}

$btnGenQuestions.Add_Click({
    if (-not $Global:ApiKey) { Show-SettingsDialog; if (-not $Global:ApiKey) { return } }
    if (-not $Global:SwotJson) {
        [System.Windows.Forms.MessageBox]::Show('Please run Analyse on Tab 1 first.','Required') | Out-Null
        return
    }
    $tabsGoals.SelectedTab = $tabQuestions
    $domain     = ($Script:DomainChips | ForEach-Object { $_.Name }) -join ', '
    $swotStr    = $Global:SwotJson | ConvertTo-Json -Compress
    $apiKey     = $Global:ApiKey

    $lblQStatus.Text = 'Generating questions... please wait.'
    $btnGenQuestions.Enabled = $false

    $targetDays  = [int]$nudTargetDays.Value
    $hoursPerDay = [int]$nudHoursPerDay.Value

    $sysMsg = @'
You are a goal-setting coach. Given the user's profile and SWOT analysis, generate exactly 5 simple, focused MCQs that reveal what the user knows and how they want to improve in their domain. One question per dimension, in this order:

1. Skill confidence  -  which of their listed skills do they feel most capable of applying in the domain right now?
2. Biggest gap  -  what is the most important thing they still need to learn in this domain?
3. Learning approach  -  how do they prefer to build new skills? Options must fit their listed interests and domain.
4. Desired outcome  -  what does success look like for them in this domain within the available time?
5. Main obstacle  -  what do they think will most get in their way?

Rules: Keep each question short (one sentence). Keep each option short (one short phrase or sentence). Options must reference the user's actual skills, interests, domain, or SWOT items  -  no generic placeholders.
Return ONLY a JSON array of exactly 5 objects: [{"question":"...","options":["A. text","B. text","C. text","D. text"],"answer":"A"},...]. No markdown fences.
'@
    $usrMsg = "Name: $($Global:Profile.name)`nDomain(s) to improve: $domain`nSkills: $($Global:Profile.skills -join ', ')`nInterests: $($Global:Profile.interests -join ', ')`nSWOT Analysis: $swotStr`nTime commitment: $targetDays working days at $hoursPerDay hrs/day."

    Invoke-Async $Script:ApiCallScript @{ApiKey=$apiKey;Model=$Global:OAISettings.model;SystemMsg=$sysMsg;UserMsg=$usrMsg;MaxTokens=2000;Temperature=$Global:OAISettings.temperature;TopP=$Global:OAISettings.topP} `
        -onDone {
            param($result)
            try {
                $clean = ($result[0] -replace '(?s)```json','' -replace '(?s)```','').Trim()
                $mcqs = $clean | ConvertFrom-Json
                Render-MCQs $mcqs
            } catch {
                $lblQStatus.Text = "Parse error: $_"
            }
            $btnGenQuestions.Enabled = $true
        } `
        -onError {
            param($err)
            Write-ErrorLog $err
            $lblQStatus.Text = "Error: $err"
            $btnGenQuestions.Enabled = $true
        }
})
