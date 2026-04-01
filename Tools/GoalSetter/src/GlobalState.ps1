# ----------------------------------------------
# Global application state
# $Global:ApiKey and $Global:Profile are initialized in GoalSetter.ps1
# ----------------------------------------------
$Global:SwotJson      = $null
$Global:ThinkingText  = ''
$Global:McqData       = @()    # array of {question, options, answer, selectedIndex}
$Global:GoalProposals = @()    # array of {goal, checkbox, txtHours}  -  proposal phase
$Global:Goals         = @()    # array of goal objects with milestone checkboxes
$Global:TargetDays    = $null  # set when Generate Goals is clicked
$Global:HoursPerDay   = $null  # set when Generate Goals is clicked
