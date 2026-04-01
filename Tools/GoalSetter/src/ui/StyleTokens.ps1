# ==============================================
# STYLE TOKENS  -  company visual language
# Matches the One Identity Manager desktop style guide.
# All variables are available to every dot-sourced UI file via shared scope.
# ==============================================

# Color tokens
$colBackground  = [System.Drawing.Color]::FromArgb(245, 241, 234)   # #F5F1EA  warm canvas
$colPanel       = [System.Drawing.Color]::White                      # #FFFFFF  content cards
$colPurple      = [System.Drawing.Color]::FromArgb(112, 48, 105)    # #703069  brand / headers
$colGold        = [System.Drawing.Color]::FromArgb(214, 182, 105)   # #D6B669  accent / separator
$colTeal        = [System.Drawing.Color]::FromArgb(120, 172, 156)   # #78AC9C  primary actions
$colTextDark    = [System.Drawing.Color]::FromArgb(45, 35, 50)      # #2D2332  main body text
$colTextMuted   = [System.Drawing.Color]::FromArgb(130, 120, 125)   # #82787D  hints / captions
$colBorder      = [System.Drawing.Color]::FromArgb(210, 200, 195)   # #D2C8C3  dividers
$colWhite       = [System.Drawing.Color]::White                      # #FFFFFF  text on dark fills

# Font tokens
$fontTitle   = New-Object System.Drawing.Font('Segoe UI',          16, [System.Drawing.FontStyle]::Bold)
$fontSubhead = New-Object System.Drawing.Font('Segoe UI Semibold', 10)
$fontLabel   = New-Object System.Drawing.Font('Segoe UI',           9)
$fontButton  = New-Object System.Drawing.Font('Segoe UI Semibold', 10)
$fontCaption = New-Object System.Drawing.Font('Segoe UI',           8,  [System.Drawing.FontStyle]::Italic)
$fontInput   = New-Object System.Drawing.Font('Segoe UI',           9.5)
$fontCode    = New-Object System.Drawing.Font('Consolas',          10)

# Button style helpers  -  available to all tabs via shared dot-source scope
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
