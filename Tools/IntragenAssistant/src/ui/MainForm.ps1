# ==============================================
# MAIN FORM — Intragen Assistant
# ==============================================
$form = New-Object System.Windows.Forms.Form
$form.Text          = 'Intragen Assistant'
$form.Size          = New-Object System.Drawing.Size(980, 760)
$form.StartPosition = 'CenterScreen'
$form.MinimumSize   = New-Object System.Drawing.Size(980, 720)
$form.Font          = $fontLabel
$form.BackColor     = $colBackground
$form.KeyPreview    = $true

# ── Menu bar ──────────────────────────────────
$menu      = New-Object System.Windows.Forms.MenuStrip
$mFile     = New-Object System.Windows.Forms.ToolStripMenuItem('&File')
$mSettings = New-Object System.Windows.Forms.ToolStripMenuItem('&Settings...')
$mExit     = New-Object System.Windows.Forms.ToolStripMenuItem('E&xit')
$mSettings.Add_Click({ Show-SettingsDialog })
$mExit.Add_Click({ $form.Close() })
[void]$mFile.DropDownItems.Add($mSettings)
[void]$mFile.DropDownItems.Add($mExit)
[void]$menu.Items.Add($mFile)
$form.Controls.Add($menu)
$form.MainMenuStrip = $menu

# ── Purple header ─────────────────────────────
$pnlHeader = New-Object System.Windows.Forms.Panel
$pnlHeader.Dock      = 'Top'
$pnlHeader.Height    = 70
$pnlHeader.BackColor = $colPurple

$lblHeaderTitle = New-Object System.Windows.Forms.Label
$lblHeaderTitle.Text      = 'Intragen Assistant'
$lblHeaderTitle.Font      = $fontTitle
$lblHeaderTitle.ForeColor = $colWhite
$lblHeaderTitle.Location  = New-Object System.Drawing.Point(24, 12)
$lblHeaderTitle.AutoSize  = $true

$lblHeaderSub = New-Object System.Windows.Forms.Label
$lblHeaderSub.Text      = 'Goals  ·  Query Evaluator  ·  Presentations  ·  Doc Builder'
$lblHeaderSub.Font      = $fontCaption
$lblHeaderSub.ForeColor = [System.Drawing.Color]::FromArgb(200, 180, 200)
$lblHeaderSub.Location  = New-Object System.Drawing.Point(26, 44)
$lblHeaderSub.AutoSize  = $true

$pnlHeader.Controls.AddRange(@($lblHeaderTitle, $lblHeaderSub))
$form.Controls.Add($pnlHeader)

# ── Gold accent strip ─────────────────────────
$pnlAccent = New-Object System.Windows.Forms.Panel
$pnlAccent.Dock      = 'Top'
$pnlAccent.Height    = 3
$pnlAccent.BackColor = $colGold
$form.Controls.Add($pnlAccent)

# ── Main TabControl ───────────────────────────
# y = menu(24) + header(70) + accent(3) = 97
$tabs = New-Object System.Windows.Forms.TabControl
$tabs.Location = New-Object System.Drawing.Point(0, 97)
$tabs.Size     = New-Object System.Drawing.Size(980, 660)
$tabs.Anchor   = 'Top,Bottom,Left,Right'

$tabMainGoals      = New-Object System.Windows.Forms.TabPage('Goals')
$tabQueryEval      = New-Object System.Windows.Forms.TabPage('Query Evaluator')
$tabPresentations  = New-Object System.Windows.Forms.TabPage('Presentations')
$tabDocBuilder     = New-Object System.Windows.Forms.TabPage('Doc Builder')

$tabs.TabPages.AddRange(@($tabMainGoals, $tabQueryEval, $tabPresentations, $tabDocBuilder))
$form.Controls.Add($tabs)
