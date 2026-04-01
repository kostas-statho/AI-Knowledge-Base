# ==============================================
# STYLE TOKENS — Intragen visual language
# Matches the One Identity Manager desktop style guide.
# Based on GoalSetter/src/ui/StyleTokens.ps1 + chat-specific additions.
# All variables available to every dot-sourced UI file via shared scope.
# ==============================================

# --- Core palette ---
$colBackground  = [System.Drawing.Color]::FromArgb(245, 241, 234)   # #F5F1EA  warm canvas
$colPanel       = [System.Drawing.Color]::White                      # #FFFFFF  content cards
$colPurple      = [System.Drawing.Color]::FromArgb(112,  48, 105)   # #703069  brand / headers
$colGold        = [System.Drawing.Color]::FromArgb(214, 182, 105)   # #D6B669  accent / separator
$colTeal        = [System.Drawing.Color]::FromArgb(120, 172, 156)   # #78AC9C  primary actions
$colTextDark    = [System.Drawing.Color]::FromArgb( 45,  35,  50)   # #2D2332  main body text
$colTextMuted   = [System.Drawing.Color]::FromArgb(130, 120, 125)   # #82787D  hints / captions
$colBorder      = [System.Drawing.Color]::FromArgb(210, 200, 195)   # #D2C8C3  dividers
$colWhite       = [System.Drawing.Color]::White                      # #FFFFFF  text on dark fills

# --- State colors ---
$colError       = [System.Drawing.Color]::FromArgb(180,  50,  50)   # #B43232  error text
$colSuccess     = [System.Drawing.Color]::FromArgb( 60, 140,  80)   # #3C8C50  success text

# --- Chat-specific additions ---
$colSeparator   = [System.Drawing.Color]::FromArgb(220, 215, 210)   # light rule between turns

# --- Font tokens ---
$fontTitle      = New-Object System.Drawing.Font('Segoe UI',          16, [System.Drawing.FontStyle]::Bold)
$fontSubhead    = New-Object System.Drawing.Font('Segoe UI Semibold', 10)
$fontLabel      = New-Object System.Drawing.Font('Segoe UI',           9)
$fontButton     = New-Object System.Drawing.Font('Segoe UI Semibold', 10)
$fontCaption    = New-Object System.Drawing.Font('Segoe UI',           8,  [System.Drawing.FontStyle]::Italic)
$fontInput      = New-Object System.Drawing.Font('Segoe UI',           9.5)

# --- Chat-specific fonts ---
$fontChatNormal = New-Object System.Drawing.Font('Segoe UI',  10)    # prose body in chat
$fontChatCode   = New-Object System.Drawing.Font('Consolas',   9.5)  # code blocks in replies

# --- Button style helpers ---
function Set-PrimaryButton($btn) {
    $btn.FlatStyle = 'Flat'
    $btn.BackColor = $colTeal
    $btn.ForeColor = $colWhite
    $btn.Font      = $fontButton
    $btn.FlatAppearance.BorderSize = 0
    $btn.Cursor    = [System.Windows.Forms.Cursors]::Hand
}

function Set-SecondaryButton($btn) {
    $btn.FlatStyle = 'Flat'
    $btn.BackColor = $colBackground
    $btn.ForeColor = $colPurple
    $btn.Font      = $fontButton
    $btn.FlatAppearance.BorderSize  = 1
    $btn.FlatAppearance.BorderColor = $colPurple
    $btn.Cursor    = [System.Windows.Forms.Cursors]::Hand
}
