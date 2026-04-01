# ==============================================
# TAB 1  -  GOALS (nested TabControl wrapper)
# Creates the nested GoalSetter wizard inside $tabMainGoals.
# Defines: $tabSetup, $tabQuestions, $tabGoals, $tabMeeting, $tabProgress
# so the GoalSetter content files (Goals/*.ps1) work unchanged.
# ==============================================
$tabsGoals = New-Object System.Windows.Forms.TabControl
$tabsGoals.Dock = 'Fill'
$tabMainGoals.Controls.Add($tabsGoals)

$tabSetup     = New-Object System.Windows.Forms.TabPage('Setup')
$tabQuestions = New-Object System.Windows.Forms.TabPage('Questions')
$tabGoals     = New-Object System.Windows.Forms.TabPage('Goals')
$tabMeeting   = New-Object System.Windows.Forms.TabPage('1-1 Meeting')
$tabProgress  = New-Object System.Windows.Forms.TabPage('Progress')

$tabsGoals.TabPages.AddRange(@($tabSetup, $tabQuestions, $tabGoals, $tabMeeting, $tabProgress))

# ── Populate each sub-tab using GoalSetter content files ──
. "$ScriptDir\src\ui\Goals\Tab1-Setup.ps1"
. "$ScriptDir\src\ui\Goals\Tab2-Questions.ps1"
. "$ScriptDir\src\ui\Goals\Tab3-Goals.ps1"
. "$ScriptDir\src\ui\Goals\Tab5-Progress.ps1"   # must follow Tab3 (uses $btnSaveProgress etc.)
. "$ScriptDir\src\ui\Goals\Tab4-Meeting.ps1"
