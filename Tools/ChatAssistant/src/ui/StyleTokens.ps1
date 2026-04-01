# StyleTokens.ps1 — Company color palette and font definitions.
# Dot-sourced by ChatForm.ps1 and OIM_Chat.ps1.
# Adapted from GoalSetter StyleTokens.ps1 (same brand colors).

# --- Colors ---
$colBackground  = [System.Drawing.Color]::FromArgb(245, 241, 234)   # #F5F1EA  warm off-white
$colPanel       = [System.Drawing.Color]::White
$colPurple      = [System.Drawing.Color]::FromArgb(112,  48, 105)   # #703069  Intragen purple
$colGold        = [System.Drawing.Color]::FromArgb(214, 182, 105)   # #D6B669  accent gold
$colTeal        = [System.Drawing.Color]::FromArgb(120, 172, 156)   # #78AC9C  action teal
$colTextDark    = [System.Drawing.Color]::FromArgb( 45,  35,  50)   # near-black
$colTextMuted   = [System.Drawing.Color]::FromArgb(130, 120, 125)   # muted gray
$colSeparator   = [System.Drawing.Color]::FromArgb(220, 215, 210)   # light rule
$colError       = [System.Drawing.Color]::FromArgb(180,  50,  50)   # error red

# --- Fonts ---
$fontTitle      = New-Object System.Drawing.Font('Segoe UI', 14, [System.Drawing.FontStyle]::Bold)
$fontSubhead    = New-Object System.Drawing.Font('Segoe UI Semibold', 10)
$fontLabel      = New-Object System.Drawing.Font('Segoe UI', 9)
$fontButton     = New-Object System.Drawing.Font('Segoe UI Semibold', 10)
$fontChat       = New-Object System.Drawing.Font('Consolas', 10)       # used for code lines in replies
$fontChatNormal = New-Object System.Drawing.Font('Segoe UI', 10)       # used for prose in replies

# --- Button style helpers ---
function Set-PrimaryButton([System.Windows.Forms.Button]$btn) {
    $btn.BackColor   = $colTeal
    $btn.ForeColor   = [System.Drawing.Color]::White
    $btn.FlatStyle   = [System.Windows.Forms.FlatStyle]::Flat
    $btn.FlatAppearance.BorderSize  = 0
    $btn.Font        = $fontButton
    $btn.Cursor      = [System.Windows.Forms.Cursors]::Hand
}

function Set-SecondaryButton([System.Windows.Forms.Button]$btn) {
    $btn.BackColor   = $colBackground
    $btn.ForeColor   = $colTextDark
    $btn.FlatStyle   = [System.Windows.Forms.FlatStyle]::Flat
    $btn.FlatAppearance.BorderSize  = 1
    $btn.FlatAppearance.BorderColor = $colSeparator
    $btn.Font        = $fontButton
    $btn.Cursor      = [System.Windows.Forms.Cursors]::Hand
}
