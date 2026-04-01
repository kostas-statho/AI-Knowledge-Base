# ==============================================
# TAB 5  -  PROGRESS
# ==============================================
# NOTE: $btnSaveProgress, $btnExportTxt, $btnExportProfile are declared in
# Tab3-Goals.ps1 and added to $flowGoalBtns here. Tab3 MUST be dot-sourced first.
# ----------------------------------------------
$pnlProgress = New-Object System.Windows.Forms.Panel
$pnlProgress.Dock = 'Fill'
$tabProgress.Controls.Add($pnlProgress)

# Status label — auto-height, full width at top
$lblProgressStatus = New-Object System.Windows.Forms.Label
$lblProgressStatus.Text      = 'Finalize goals on the Goals tab to see your progress here.'
$lblProgressStatus.Dock      = 'Top'
$lblProgressStatus.AutoSize  = $true
$lblProgressStatus.ForeColor = $colTextMuted
$lblProgressStatus.Font      = $fontCaption

# Progress bar row: pct label docks right, bar fills the rest
$pnlProgressBar = New-Object System.Windows.Forms.Panel
$pnlProgressBar.Dock   = 'Top'
$pnlProgressBar.Height = 28

$prgMilestones = New-Object System.Windows.Forms.ProgressBar
$prgMilestones.Dock    = 'Fill'
$prgMilestones.Minimum = 0; $prgMilestones.Maximum = 100; $prgMilestones.Value = 0
$prgMilestones.Style   = 'Continuous'

$lblPrgPct = New-Object System.Windows.Forms.Label
$lblPrgPct.Text      = '0 / 0 milestones (0%)'
$lblPrgPct.Dock      = 'Right'
$lblPrgPct.AutoSize  = $false
$lblPrgPct.Width     = 210
$lblPrgPct.ForeColor = $colPurple
$lblPrgPct.Font      = $fontSubhead
$lblPrgPct.TextAlign = 'MiddleLeft'

# Dock=Right first so the bar (Fill) gets remaining width
$pnlProgressBar.Controls.AddRange(@($lblPrgPct, $prgMilestones))

# Footer panel: Save/Export buttons pinned to bottom
$pnlProgressFooter = New-Object System.Windows.Forms.Panel
$pnlProgressFooter.Dock    = 'Bottom'
$pnlProgressFooter.Height  = 40
$pnlProgressFooter.Padding = New-Object System.Windows.Forms.Padding(10, 5, 10, 5)

$flowGoalBtns = New-Object System.Windows.Forms.FlowLayoutPanel
$flowGoalBtns.Dock          = 'Fill'
$flowGoalBtns.FlowDirection = 'LeftToRight'
$flowGoalBtns.Controls.AddRange(@($btnSaveProgress,$btnExportTxt,$btnExportProfile))
$pnlProgressFooter.Controls.Add($flowGoalBtns)

# Scroll panel fills all space between header and footer
$scrollProgress = New-Object System.Windows.Forms.Panel
$scrollProgress.Dock        = 'Fill'
$scrollProgress.AutoScroll  = $true
$scrollProgress.BorderStyle = 'FixedSingle'
$scrollProgress.BackColor   = $colPanel

# Add order: Top controls first, then Bottom, then Fill
$pnlProgress.Controls.AddRange(@(
    $lblProgressStatus,
    $pnlProgressBar,
    $pnlProgressFooter,
    $scrollProgress
))

function Update-ProgressBar {
    $total = 0; $done = 0
    foreach ($g in $Global:Goals) {
        $total += $g.checkboxes.Count
        $done  += ($g.checkboxes | Where-Object { $_.Checked }).Count
    }
    $pct = if ($total -gt 0) { [int](($done / $total) * 100) } else { 0 }
    $prgMilestones.Value = $pct
    $lblPrgPct.Text = "$done / $total milestones ($pct%)"
}
