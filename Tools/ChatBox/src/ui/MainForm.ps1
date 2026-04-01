# ==============================================
# MAIN FORM
# Shell: form + menu + purple header + gold accent + context toolbar + input bar + status bar.
# ChatPanel.ps1 adds the RichTextBox (Dock=Fill) AFTER this file — order matters.
# ==============================================

$form                 = New-Object System.Windows.Forms.Form
$form.Text            = 'Intragen Chat Assistant'
$form.Size            = New-Object System.Drawing.Size(860, 680)
$form.MinimumSize     = New-Object System.Drawing.Size(600, 450)
$form.StartPosition   = 'CenterScreen'
$form.BackColor       = $colBackground
$form.Font            = $fontLabel

# ── Menu bar ─────────────────────────────────────────────────────────────────
$menu              = New-Object System.Windows.Forms.MenuStrip
$menu.BackColor    = $colBackground

$mFile             = New-Object System.Windows.Forms.ToolStripMenuItem('&File')
$mNewChat          = New-Object System.Windows.Forms.ToolStripMenuItem('&New Chat')
$mLoadHistory      = New-Object System.Windows.Forms.ToolStripMenuItem('&Load History…')
$mSaveHistory      = New-Object System.Windows.Forms.ToolStripMenuItem('&Save History…')
$mSep              = New-Object System.Windows.Forms.ToolStripSeparator
$mSettings         = New-Object System.Windows.Forms.ToolStripMenuItem('S&ettings…')
$mExit             = New-Object System.Windows.Forms.ToolStripMenuItem('E&xit')

[void]$mFile.DropDownItems.Add($mNewChat)
[void]$mFile.DropDownItems.Add($mLoadHistory)
[void]$mFile.DropDownItems.Add($mSaveHistory)
[void]$mFile.DropDownItems.Add($mSep)
[void]$mFile.DropDownItems.Add($mSettings)
[void]$mFile.DropDownItems.Add($mExit)
[void]$menu.Items.Add($mFile)

$mSettings.Add_Click({ Show-SettingsDialog })
$mExit.Add_Click({ $form.Close() })
# mNewChat, mLoadHistory, mSaveHistory handlers wired in ChatPanel.ps1

$form.Controls.Add($menu)
$form.MainMenuStrip = $menu

# ── Purple brand header (Dock=Top, stacks below menu) ────────────────────────
$pnlHeader            = New-Object System.Windows.Forms.Panel
$pnlHeader.Dock       = 'Top'
$pnlHeader.Height     = 70
$pnlHeader.BackColor  = $colPurple

$lblHeaderTitle       = New-Object System.Windows.Forms.Label
$lblHeaderTitle.Text  = 'Intragen Chat Assistant'
$lblHeaderTitle.Font  = $fontTitle
$lblHeaderTitle.ForeColor = $colWhite
$lblHeaderTitle.Location  = New-Object System.Drawing.Point(24, 18)
$lblHeaderTitle.AutoSize  = $true
$pnlHeader.Controls.Add($lblHeaderTitle)

$form.Controls.Add($pnlHeader)

# ── Gold accent strip ─────────────────────────────────────────────────────────
$pnlAccent            = New-Object System.Windows.Forms.Panel
$pnlAccent.Dock       = 'Top'
$pnlAccent.Height     = 3
$pnlAccent.BackColor  = $colGold
$form.Controls.Add($pnlAccent)

# ── Context toolbar (Dock=Top, 36px) ─────────────────────────────────────────
$pnlContext           = New-Object System.Windows.Forms.Panel
$pnlContext.Dock      = 'Top'
$pnlContext.Height    = 36
$pnlContext.BackColor = $colBackground
$pnlContext.Padding   = New-Object System.Windows.Forms.Padding(10, 0, 10, 0)

$lblCtx               = New-Object System.Windows.Forms.Label
$lblCtx.Text          = 'Context:'
$lblCtx.Font          = $fontLabel
$lblCtx.ForeColor     = $colTextMuted
$lblCtx.Location      = New-Object System.Drawing.Point(12, 10)
$lblCtx.AutoSize      = $true

$Script:cmbContext              = New-Object System.Windows.Forms.ComboBox
$Script:cmbContext.Location     = New-Object System.Drawing.Point(68, 7)
$Script:cmbContext.Width        = 180
$Script:cmbContext.DropDownStyle= 'DropDownList'
$Script:cmbContext.Font         = $fontLabel
$Script:cmbContext.BackColor    = $colPanel
$Global:ContextPresets.Keys | ForEach-Object { [void]$Script:cmbContext.Items.Add($_) }
$Script:cmbContext.SelectedItem = $Global:ActiveContext

$lblSep               = New-Object System.Windows.Forms.Label
$lblSep.Text          = '|  Model:'
$lblSep.Font          = $fontLabel
$lblSep.ForeColor     = $colTextMuted
$lblSep.Location      = New-Object System.Drawing.Point(258, 10)
$lblSep.AutoSize      = $true

$Script:cmbModel              = New-Object System.Windows.Forms.ComboBox
$Script:cmbModel.Location     = New-Object System.Drawing.Point(322, 7)
$Script:cmbModel.Width        = 130
$Script:cmbModel.DropDownStyle= 'DropDownList'
$Script:cmbModel.Font         = $fontLabel
$Script:cmbModel.BackColor    = $colPanel
$Script:ModelList | ForEach-Object { [void]$Script:cmbModel.Items.Add($_) }
$Script:cmbModel.SelectedItem = $Global:Model

$pnlContext.Controls.AddRange(@($lblCtx, $Script:cmbContext, $lblSep, $Script:cmbModel))
$form.Controls.Add($pnlContext)

# ── Context / model change handlers ──────────────────────────────────────────
$Script:cmbContext.Add_SelectedIndexChanged({
    $Global:ActiveContext = $Script:cmbContext.SelectedItem
})

$Script:cmbModel.Add_SelectedIndexChanged({
    $Global:Model = $Script:cmbModel.SelectedItem
    Save-Model $Global:Model $ConfigPath
})

# ── Status bar (Dock=Bottom — must be added before input panel) ───────────────
$pnlStatus            = New-Object System.Windows.Forms.Panel
$pnlStatus.Dock       = 'Bottom'
$pnlStatus.Height     = 24
$pnlStatus.BackColor  = $colBackground

$Script:lblStatus           = New-Object System.Windows.Forms.Label
$Script:lblStatus.Text      = 'Ready'
$Script:lblStatus.Font      = $fontCaption
$Script:lblStatus.ForeColor = $colTextMuted
$Script:lblStatus.AutoSize  = $true
$Script:lblStatus.Location  = New-Object System.Drawing.Point(8, 5)
$pnlStatus.Controls.Add($Script:lblStatus)

$form.Controls.Add($pnlStatus)

# ── Input panel (Dock=Bottom — added after status so it sits above it) ────────
$pnlInput             = New-Object System.Windows.Forms.Panel
$pnlInput.Dock        = 'Bottom'
$pnlInput.Height      = 46
$pnlInput.BackColor   = $colPanel
$pnlInput.Padding     = New-Object System.Windows.Forms.Padding(6)

# Controls added right-to-left so Dock=Right stacks correctly
$Script:btnSend       = New-Object System.Windows.Forms.Button
$Script:btnSend.Text  = 'Send'
$Script:btnSend.Width = 80
$Script:btnSend.Dock  = 'Right'
Set-PrimaryButton $Script:btnSend
$pnlInput.Controls.Add($Script:btnSend)

$Script:txtInput          = New-Object System.Windows.Forms.TextBox
$Script:txtInput.Dock     = 'Fill'
$Script:txtInput.Font     = $fontChatNormal
$Script:txtInput.BackColor= $colBackground
$Script:txtInput.ForeColor= $colTextDark
$Script:txtInput.BorderStyle = 'None'
$pnlInput.Controls.Add($Script:txtInput)

$form.Controls.Add($pnlInput)

# NOTE: ChatPanel.ps1 adds $Script:rtbChat (Dock=Fill) AFTER this — correct order.
