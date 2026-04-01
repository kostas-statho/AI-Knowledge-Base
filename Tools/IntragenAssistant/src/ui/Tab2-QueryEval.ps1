# ==============================================
# TAB 2  -  QUERY EVALUATOR
# ==============================================
$Script:EvalHistory   = @()   # multi-turn conversation history
$Script:EvalRound     = 0     # current round (max 5)
$Script:ScorePanels   = @{}   # dim name → @{track; fill; lblPct; lblStatus}

$pnlQE = New-Object System.Windows.Forms.Panel
$pnlQE.Dock      = 'Fill'
$pnlQE.Padding   = New-Object System.Windows.Forms.Padding(10)
$pnlQE.BackColor = $colBackground
$tabQueryEval.Controls.Add($pnlQE)

# ── Intent ────────────────────────────────────
$lblIntent = New-Object System.Windows.Forms.Label
$lblIntent.Text     = 'Intent (what should this query do?):'
$lblIntent.Location = New-Object System.Drawing.Point(0, 0)
$lblIntent.AutoSize = $true
$lblIntent.Font     = $fontSubhead
$pnlQE.Controls.Add($lblIntent)

$txtIntent = New-Object System.Windows.Forms.TextBox
$txtIntent.Location    = New-Object System.Drawing.Point(0, 22)
$txtIntent.Width       = 900
$txtIntent.Font        = $fontInput
$txtIntent.BackColor   = $colPanel
$pnlQE.Controls.Add($txtIntent)

# ── SQL Input ─────────────────────────────────
$lblSQL = New-Object System.Windows.Forms.Label
$lblSQL.Text     = 'SQL:'
$lblSQL.Location = New-Object System.Drawing.Point(0, 54)
$lblSQL.AutoSize = $true; $lblSQL.Font = $fontSubhead
$pnlQE.Controls.Add($lblSQL)

$btnBrowseSQL = New-Object System.Windows.Forms.Button
$btnBrowseSQL.Text     = 'Browse .sql...'
$btnBrowseSQL.Location = New-Object System.Drawing.Point(800, 50)
$btnBrowseSQL.Width    = 110
Set-SecondaryButton $btnBrowseSQL
$btnBrowseSQL.Add_Click({
    $ofd = New-Object System.Windows.Forms.OpenFileDialog
    $ofd.Filter = 'SQL files (*.sql)|*.sql|All files (*.*)|*.*'
    if ($ofd.ShowDialog() -eq 'OK') {
        $txtSQL.Text = Get-Content $ofd.FileName -Raw -Encoding UTF8
    }
})
$pnlQE.Controls.Add($btnBrowseSQL)

$txtSQL = New-Object System.Windows.Forms.TextBox
$txtSQL.Location   = New-Object System.Drawing.Point(0, 76)
$txtSQL.Size       = New-Object System.Drawing.Size(910, 100)
$txtSQL.Multiline  = $true
$txtSQL.ScrollBars = 'Vertical'
$txtSQL.Font       = $fontCode
$txtSQL.BackColor  = $colPanel
$pnlQE.Controls.Add($txtSQL)

$btnEvaluate = New-Object System.Windows.Forms.Button
$btnEvaluate.Text     = 'Evaluate Query'
$btnEvaluate.Location = New-Object System.Drawing.Point(0, 184)
$btnEvaluate.Width    = 140
Set-PrimaryButton $btnEvaluate

$btnClear = New-Object System.Windows.Forms.Button
$btnClear.Text     = 'Clear'
$btnClear.Location = New-Object System.Drawing.Point(148, 184)
$btnClear.Width    = 70
Set-SecondaryButton $btnClear
$btnClear.Add_Click({
    $txtSQL.Clear(); $txtIntent.Clear(); $txtEvalChat.Clear()
    $rtbIssues.Clear()
    $lblVerdict.Text = ''
    $Script:EvalHistory = @(); $Script:EvalRound = 0
    $lblEvalRound.Text = ''
    foreach ($k in $Script:ScorePanels.Keys) {
        $sp = $Script:ScorePanels[$k]
        $sp.fill.Width = 0
        $sp.fill.BackColor = [System.Drawing.Color]::LightGray
        $sp.lblPct.Text = ''
        $sp.lblStatus.Text = ''
    }
})
$pnlQE.Controls.AddRange(@($btnEvaluate, $btnClear))

$lblQEStatus = New-Object System.Windows.Forms.Label
$lblQEStatus.Location = New-Object System.Drawing.Point(228, 190)
$lblQEStatus.AutoSize = $true
$lblQEStatus.Font     = $fontCaption
$lblQEStatus.ForeColor = $colTextMuted
$pnlQE.Controls.Add($lblQEStatus)

# ── Scorecard ─────────────────────────────────
$lblScorecard = New-Object System.Windows.Forms.Label
$lblScorecard.Text     = 'Scorecard'
$lblScorecard.Location = New-Object System.Drawing.Point(0, 218)
$lblScorecard.AutoSize = $true; $lblScorecard.Font = $fontSubhead
$pnlQE.Controls.Add($lblScorecard)

$dimensions = @(
    @{ key = 'safety';          label = 'Safety' }
    @{ key = 'sargability';     label = 'SARGability' }
    @{ key = 'oim_correctness'; label = 'OIM Correctness' }
    @{ key = 'optimization';    label = 'Optimization' }
    @{ key = 'structural_opt';  label = 'Structural Opt.' }
    @{ key = 'academic_risk';   label = 'Academic Risk' }
    @{ key = 'code_quality';    label = 'Code Quality' }
)

$scoreY = 240
$barW   = 220
$rowH   = 24

foreach ($dim in $dimensions) {
    # Label
    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text     = $dim.label
    $lbl.Location = New-Object System.Drawing.Point(0, ($scoreY + 4))
    $lbl.Width    = 140; $lbl.Font = $fontLabel
    $pnlQE.Controls.Add($lbl)

    # Track panel (grey background)
    $pnlTrack = New-Object System.Windows.Forms.Panel
    $pnlTrack.Location    = New-Object System.Drawing.Point(145, $scoreY)
    $pnlTrack.Size        = New-Object System.Drawing.Size($barW, $rowH)
    $pnlTrack.BorderStyle = 'FixedSingle'
    $pnlTrack.BackColor   = [System.Drawing.Color]::FromArgb(220, 215, 210)

    # Fill panel (colored bar)
    $pnlFill = New-Object System.Windows.Forms.Panel
    $pnlFill.Location  = New-Object System.Drawing.Point(0, 0)
    $pnlFill.Size      = New-Object System.Drawing.Size(0, $rowH)
    $pnlFill.BackColor = [System.Drawing.Color]::LightGray
    $pnlTrack.Controls.Add($pnlFill)
    $pnlQE.Controls.Add($pnlTrack)

    # Percentage label
    $lblPct = New-Object System.Windows.Forms.Label
    $lblPct.Location  = New-Object System.Drawing.Point(372, ($scoreY + 4))
    $lblPct.Width     = 40; $lblPct.Font = $fontLabel
    $lblPct.Text      = ''
    $pnlQE.Controls.Add($lblPct)

    # Status icon label
    $lblStatus = New-Object System.Windows.Forms.Label
    $lblStatus.Location  = New-Object System.Drawing.Point(416, ($scoreY + 4))
    $lblStatus.Width     = 120; $lblStatus.Font = $fontCaption
    $lblStatus.ForeColor = $colTextMuted
    $lblStatus.Text      = ''
    $pnlQE.Controls.Add($lblStatus)

    $Script:ScorePanels[$dim.key] = @{
        track     = $pnlTrack
        fill      = $pnlFill
        lblPct    = $lblPct
        lblStatus = $lblStatus
    }

    $scoreY += ($rowH + 4)
}

# Overall row
$lblOverallKey = New-Object System.Windows.Forms.Label
$lblOverallKey.Text     = 'Overall'
$lblOverallKey.Location = New-Object System.Drawing.Point(0, ($scoreY + 4))
$lblOverallKey.Width    = 140; $lblOverallKey.Font = $fontSubhead
$pnlQE.Controls.Add($lblOverallKey)

$pnlOverallTrack = New-Object System.Windows.Forms.Panel
$pnlOverallTrack.Location    = New-Object System.Drawing.Point(145, $scoreY)
$pnlOverallTrack.Size        = New-Object System.Drawing.Size($barW, $rowH)
$pnlOverallTrack.BorderStyle = 'FixedSingle'
$pnlOverallTrack.BackColor   = [System.Drawing.Color]::FromArgb(220, 215, 210)

$pnlOverallFill = New-Object System.Windows.Forms.Panel
$pnlOverallFill.Location  = New-Object System.Drawing.Point(0, 0)
$pnlOverallFill.Size      = New-Object System.Drawing.Size(0, $rowH)
$pnlOverallFill.BackColor = [System.Drawing.Color]::LightGray
$pnlOverallTrack.Controls.Add($pnlOverallFill)
$pnlQE.Controls.Add($pnlOverallTrack)

$lblOverallPct = New-Object System.Windows.Forms.Label
$lblOverallPct.Location = New-Object System.Drawing.Point(372, ($scoreY + 4))
$lblOverallPct.Width    = 40; $lblOverallPct.Font = $fontSubhead; $lblOverallPct.Text = ''
$pnlQE.Controls.Add($lblOverallPct)

$lblOverallVerb = New-Object System.Windows.Forms.Label
$lblOverallVerb.Location  = New-Object System.Drawing.Point(416, ($scoreY + 4))
$lblOverallVerb.Width     = 200; $lblOverallVerb.Font = $fontSubhead
$lblOverallVerb.ForeColor = $colPurple; $lblOverallVerb.Text = ''
$pnlQE.Controls.Add($lblOverallVerb)

$scoreY += ($rowH + 8)

# ── Issues ────────────────────────────────────
$lblIssues = New-Object System.Windows.Forms.Label
$lblIssues.Text     = 'Issues'
$lblIssues.Location = New-Object System.Drawing.Point(0, $scoreY)
$lblIssues.AutoSize = $true; $lblIssues.Font = $fontSubhead
$pnlQE.Controls.Add($lblIssues)

$rtbIssues = New-Object System.Windows.Forms.RichTextBox
$rtbIssues.Location   = New-Object System.Drawing.Point(0, ($scoreY + 22))
$rtbIssues.Size       = New-Object System.Drawing.Size(910, 110)
$rtbIssues.Font       = $fontCode
$rtbIssues.BackColor  = $colPanel
$rtbIssues.ReadOnly   = $true
$rtbIssues.ScrollBars = 'Vertical'
$pnlQE.Controls.Add($rtbIssues)

$scoreY += 140

# ── Verdict ───────────────────────────────────
$lblVerdictHead = New-Object System.Windows.Forms.Label
$lblVerdictHead.Text     = 'Verdict'
$lblVerdictHead.Location = New-Object System.Drawing.Point(0, $scoreY)
$lblVerdictHead.AutoSize = $true; $lblVerdictHead.Font = $fontSubhead
$pnlQE.Controls.Add($lblVerdictHead)

$lblVerdict = New-Object System.Windows.Forms.Label
$lblVerdict.Location = New-Object System.Drawing.Point(0, ($scoreY + 22))
$lblVerdict.Size     = New-Object System.Drawing.Size(910, 44)
$lblVerdict.Font     = $fontLabel
$lblVerdict.ForeColor = $colTextDark
$pnlQE.Controls.Add($lblVerdict)

$scoreY += 74

# ── Chat / Override ───────────────────────────
$lblChatHead = New-Object System.Windows.Forms.Label
$lblChatHead.Text     = 'Chat / Override'
$lblChatHead.Location = New-Object System.Drawing.Point(0, $scoreY)
$lblChatHead.AutoSize = $true; $lblChatHead.Font = $fontSubhead
$pnlQE.Controls.Add($lblChatHead)

$txtEvalChat = New-Object System.Windows.Forms.TextBox
$txtEvalChat.Location = New-Object System.Drawing.Point(0, ($scoreY + 22))
$txtEvalChat.Width    = 710
$txtEvalChat.Font     = $fontInput
$txtEvalChat.BackColor = $colPanel
$pnlQE.Controls.Add($txtEvalChat)

$btnReEval = New-Object System.Windows.Forms.Button
$btnReEval.Text     = 'Re-evaluate with note'
$btnReEval.Location = New-Object System.Drawing.Point(718, ($scoreY + 19))
$btnReEval.Width    = 160
Set-SecondaryButton $btnReEval
$btnReEval.Enabled  = $false
$pnlQE.Controls.Add($btnReEval)

$lblEvalRound = New-Object System.Windows.Forms.Label
$lblEvalRound.Location  = New-Object System.Drawing.Point(0, ($scoreY + 50))
$lblEvalRound.AutoSize  = $true
$lblEvalRound.Font      = $fontCaption
$lblEvalRound.ForeColor = $colTextMuted
$pnlQE.Controls.Add($lblEvalRound)

# ── Helper: score color ───────────────────────
function Get-ScoreColor($score) {
    if ($score -ge 85) { return $colTeal }
    if ($score -ge 70) { return [System.Drawing.Color]::FromArgb(195, 150, 0) }
    if ($score -ge 50) { return [System.Drawing.Color]::FromArgb(200, 100, 0) }
    return [System.Drawing.Color]::FromArgb(180, 50, 50)
}

function Get-IssueSeverityColor($deduction) {
    if ($deduction -ge 25) { return [System.Drawing.Color]::FromArgb(180, 50, 50) }
    if ($deduction -ge 15) { return [System.Drawing.Color]::FromArgb(200, 100, 0) }
    return [System.Drawing.Color]::FromArgb(180, 130, 0)
}

# ── Render evaluation result ──────────────────
function Render-EvalResult($eval) {
    # Scorecard bars
    foreach ($dim in $dimensions) {
        $key = $dim.key
        $sp = $Script:ScorePanels[$key]
        $score = 0
        try { $score = [int]($eval.dimensions.$key.score) } catch { }
        $score = [Math]::Max(0, [Math]::Min(100, $score))

        $fillW = [int]($sp.track.Width * ($score / 100.0))
        $sp.fill.Width     = $fillW
        $sp.fill.BackColor = Get-ScoreColor $score
        $sp.lblPct.Text    = "$score%"

        $issueCount = 0
        try { $issueCount = @($eval.dimensions.$key.issues).Count } catch { }
        if ($issueCount -eq 0) {
            $sp.lblStatus.Text      = 'OK'
            $sp.lblStatus.ForeColor = $colTeal
        } else {
            $sp.lblStatus.Text      = "$issueCount issue$(if($issueCount -ne 1){'s'} else {''})"
            $sp.lblStatus.ForeColor = Get-ScoreColor $score
        }
    }

    # Overall
    $overall = 0
    try { $overall = [int]($eval.overall) } catch { }
    $overall = [Math]::Max(0, [Math]::Min(100, $overall))
    $ovFillW = [int]($pnlOverallTrack.Width * ($overall / 100.0))
    $pnlOverallFill.Width     = $ovFillW
    $pnlOverallFill.BackColor = Get-ScoreColor $overall
    $lblOverallPct.Text       = "$overall%"
    if ($overall -ge 85)     { $lblOverallVerb.Text = 'GOOD'; $lblOverallVerb.ForeColor = $colTeal }
    elseif ($overall -ge 70) { $lblOverallVerb.Text = 'REVIEW RECOMMENDED'; $lblOverallVerb.ForeColor = [System.Drawing.Color]::FromArgb(150,100,0) }
    elseif ($overall -ge 50) { $lblOverallVerb.Text = 'REVIEW NEEDED'; $lblOverallVerb.ForeColor = [System.Drawing.Color]::FromArgb(180,80,0) }
    else                     { $lblOverallVerb.Text = 'DO NOT RUN'; $lblOverallVerb.ForeColor = [System.Drawing.Color]::FromArgb(160,40,40) }

    # Issues RichTextBox
    $rtbIssues.Clear()
    foreach ($dim in $dimensions) {
        $key = $dim.key
        $issues = @()
        try { $issues = @($eval.dimensions.$key.issues) } catch { }
        if ($issues.Count -eq 0) { continue }

        $rtbIssues.SelectionColor = $colPurple
        $rtbIssues.SelectionFont  = New-Object System.Drawing.Font('Consolas', 9, [System.Drawing.FontStyle]::Bold)
        $rtbIssues.AppendText("[$($dim.label)]`r`n")

        foreach ($issue in $issues) {
            $ded = 0; try { $ded = [int]($issue.deduction) } catch { }
            $color = Get-IssueSeverityColor ([Math]::Abs($ded))
            $rtbIssues.SelectionColor = $color
            $rtbIssues.SelectionFont  = New-Object System.Drawing.Font('Consolas', 9)
            $dedStr = if ($ded -gt 0) { "-$ded" } else { "$ded" }
            $rtbIssues.AppendText("  [$dedStr pts]  $($issue.description)`r`n")
            if ($issue.fix) {
                $rtbIssues.SelectionColor = $colTextMuted
                $rtbIssues.SelectionFont  = New-Object System.Drawing.Font('Consolas', 8, [System.Drawing.FontStyle]::Italic)
                $rtbIssues.AppendText("           Fix: $($issue.fix)`r`n")
            }
        }
    }

    # Verdict
    $lblVerdict.Text = if ($eval.verdict) { $eval.verdict } else { '' }

    $btnReEval.Enabled = ($Script:EvalRound -lt 5)
    $lblEvalRound.Text = if ($Script:EvalRound -gt 0) { "Round $($Script:EvalRound)/5" } else { '' }
}

# ── Build system prompt for Query Eval ───────
function Build-EvalSystemPrompt {
    $rules  = Get-RulesContext  $Global:OAISettings
    $schema = Get-SchemaContext $Global:OAISettings
    $role   = if ($Global:Profile.PSObject.Properties['role']) { $Global:Profile.role } else { 'OIM Developer' }
    $append = if ($Global:OAISettings.systemPromptAppend) { "`n$($Global:OAISettings.systemPromptAppend)" } else { '' }

    return @"
You are an expert SQL Server query analyzer specialized in One Identity Manager (OIM).
The user is a $role. Analyze the provided SQL query and return a JSON evaluation.

## Analysis Rules
$rules

## OIM Schema Reference
$schema
$append

Return ONLY valid JSON matching this schema exactly:
{
  "dimensions": {
    "safety":          { "score": 0-100, "issues": [{"deduction": int, "code": "S1", "description": "...", "fix": "..."}] },
    "sargability":     { "score": 0-100, "issues": [...] },
    "oim_correctness": { "score": 0-100, "issues": [...] },
    "optimization":    { "score": 0-100, "issues": [...] },
    "structural_opt":  { "score": 0-100, "issues": [...] },
    "academic_risk":   { "score": 0-100, "issues": [...] },
    "code_quality":    { "score": 0-100, "issues": [...] }
  },
  "overall": 0-100,
  "verdict": "2-3 sentence summary",
  "top_priority_fix": "single most important fix"
}
"@
}

# ── Evaluate button handler ───────────────────
$btnEvaluate.Add_Click({
    $sql = $txtSQL.Text.Trim()
    if (-not $sql) {
        [System.Windows.Forms.MessageBox]::Show('Please enter or browse a SQL query.','Required') | Out-Null
        return
    }

    $btnEvaluate.Enabled  = $false
    $btnEvaluate.Text     = 'Evaluating...'
    $lblQEStatus.Text     = 'Sending to OpenAI...'

    $intentText = $txtIntent.Text.Trim()
    $userMsg    = if ($intentText) { "Query intent: $intentText`n`nSQL:`n$sql" } else { "Evaluate this SQL query:`n`n$sql" }
    $sysMsg     = Build-EvalSystemPrompt

    $Script:EvalHistory = @(
        @{ role = 'system'; content = $sysMsg },
        @{ role = 'user';   content = $userMsg }
    )
    $Script:EvalRound = 0

    $params = @{
        ApiKey    = $Global:ApiKey
        Model     = $Global:OAISettings.model
        SystemMsg = ''
        UserMsg   = ''
        MaxTokens = [int]$Global:OAISettings.maxTokens
        JsonMode  = $true
        Messages  = $Script:EvalHistory
    }

    Invoke-Async $Script:ApiCallScript $params {
        param($result)
        $raw = $result[0]
        try {
            $eval = Parse-Json $raw
            # Append assistant response to history for multi-turn
            $Script:EvalHistory += @{ role = 'assistant'; content = $raw }
            $Script:EvalRound++
            Render-EvalResult $eval
            $lblQEStatus.Text = "Evaluated $(Get-Date -Format 'HH:mm')"
        } catch {
            $lblQEStatus.Text = "Parse error: $_"
        }
        $btnEvaluate.Enabled = $true
        $btnEvaluate.Text    = 'Evaluate Query'
    } {
        param($err)
        $lblQEStatus.Text    = "Error: $err"
        $btnEvaluate.Enabled = $true
        $btnEvaluate.Text    = 'Evaluate Query'
    }
})

# ── Re-evaluate with note handler ─────────────
$btnReEval.Add_Click({
    $note = $txtEvalChat.Text.Trim()
    if (-not $note) {
        [System.Windows.Forms.MessageBox]::Show('Enter a note before re-evaluating.','Required') | Out-Null
        return
    }
    if ($Script:EvalRound -ge 5) {
        [System.Windows.Forms.MessageBox]::Show('Maximum 5 rounds reached. Use Clear to start fresh.','Limit reached') | Out-Null
        return
    }

    $btnReEval.Enabled   = $false
    $lblQEStatus.Text    = 'Re-evaluating...'

    # Append user note + instruction to maintain JSON output
    $Script:EvalHistory += @{ role = 'user'; content = "$note`n`nPlease re-evaluate and return updated JSON using the same schema." }

    $params = @{
        ApiKey    = $Global:ApiKey
        Model     = $Global:OAISettings.model
        SystemMsg = ''
        UserMsg   = ''
        MaxTokens = [int]$Global:OAISettings.maxTokens
        JsonMode  = $true
        Messages  = $Script:EvalHistory
    }

    Invoke-Async $Script:ApiCallScript $params {
        param($result)
        $raw = $result[0]
        try {
            $eval = Parse-Json $raw
            $Script:EvalHistory += @{ role = 'assistant'; content = $raw }
            $Script:EvalRound++
            Render-EvalResult $eval
            $txtEvalChat.Clear()
            $t = Get-Date -Format 'HH:mm'
            $lblQEStatus.Text = "Re-evaluated round $Script:EvalRound ($t)"
        } catch {
            $lblQEStatus.Text = "Parse error: $_"
        }
        $btnReEval.Enabled = ($Script:EvalRound -lt 5)
    } {
        param($err)
        $lblQEStatus.Text  = "Error: $err"
        $btnReEval.Enabled = ($Script:EvalRound -lt 5)
    }
})
