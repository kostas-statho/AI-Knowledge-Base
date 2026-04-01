# ----------------------------------------------
# MAIN FORM
# ----------------------------------------------
$form = New-Object System.Windows.Forms.Form
$form.Text          = 'Goal Setting Helper'
$form.Size          = New-Object System.Drawing.Size(860, 720)
$form.StartPosition = 'CenterScreen'
$form.MinimumSize   = New-Object System.Drawing.Size(640, 480)
$form.Font          = $fontLabel
$form.BackColor     = $colBackground

# Menu bar
$menu      = New-Object System.Windows.Forms.MenuStrip
$mFile     = New-Object System.Windows.Forms.ToolStripMenuItem('&File')
$mImportProfile = New-Object System.Windows.Forms.ToolStripMenuItem('&Import Profile...')
$mImportProfile.Add_Click({
    $ofd = New-Object System.Windows.Forms.OpenFileDialog
    $ofd.Filter = 'JSON files (*.json)|*.json|All files (*.*)|*.*'
    if ($ofd.ShowDialog() -eq 'OK') {
        try {
            $imported = Get-Content $ofd.FileName -Raw -Encoding UTF8 | ConvertFrom-Json
            $Global:Profile = $imported

            $txtName.Text = $Global:Profile.name

            $flowSkills.Controls.Clear()
            $Script:SkillChips = @()
            foreach ($s in $Global:Profile.skills) {
                if ($s -is [string]) { Add-SkillChip $s 'Beginner' }
                elseif ($s.name)     { Add-SkillChip $s.name $s.level }
            }

            $flowInterests.Controls.Clear()
            $Script:InterestChips = @()
            foreach ($i in $Global:Profile.interests) {
                if ($i -is [string]) { Add-InterestChip $i 'Beginner' }
                elseif ($i.name)     { Add-InterestChip $i.name $i.level }
            }

            $flowDomains.Controls.Clear()
            $Script:DomainChips = @()
            if ($imported.PSObject.Properties['domains']) {
                foreach ($d in $imported.domains) { if ($d) { Add-DomainChip $d } }
            }
            if ($Script:DomainChips.Count -eq 0) { Add-DomainChip 'Coding' }

            [System.Windows.Forms.MessageBox]::Show('Profile loaded.', 'Imported') | Out-Null
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Error loading profile: $_", 'Error') | Out-Null
        }
    }
})
$mSettings = New-Object System.Windows.Forms.ToolStripMenuItem('&Settings...')
$mExit     = New-Object System.Windows.Forms.ToolStripMenuItem('E&xit')
$mSettings.Add_Click({ Show-SettingsDialog })
$mExit.Add_Click({ $form.Close() })
[void]$mFile.DropDownItems.Add($mImportProfile)
[void]$mFile.DropDownItems.Add($mSettings)
[void]$mFile.DropDownItems.Add($mExit)
[void]$menu.Items.Add($mFile)
$form.Controls.Add($menu)
$form.MainMenuStrip = $menu

# Purple brand header  -  Dock=Top stacks below the menu strip automatically
$pnlHeader = New-Object System.Windows.Forms.Panel
$pnlHeader.Dock      = 'Top'
$pnlHeader.Height    = 70
$pnlHeader.BackColor = $colPurple
$lblHeaderTitle = New-Object System.Windows.Forms.Label
$lblHeaderTitle.Text      = 'Goal Setting Helper'
$lblHeaderTitle.Font      = $fontTitle
$lblHeaderTitle.ForeColor = $colWhite
$lblHeaderTitle.Location  = New-Object System.Drawing.Point(24, 18)
$lblHeaderTitle.AutoSize  = $true
$pnlHeader.Controls.Add($lblHeaderTitle)
$form.Controls.Add($pnlHeader)

# Gold accent strip  -  Dock=Top, stacks directly below the header
$pnlAccent = New-Object System.Windows.Forms.Panel
$pnlAccent.Dock      = 'Top'
$pnlAccent.Height    = 3
$pnlAccent.BackColor = $colGold
$form.Controls.Add($pnlAccent)

# Tab control  -  explicit position so it never conflicts with Dock layout
# y = menu(24) + header(70) + accent(3) = 97
$tabs = New-Object System.Windows.Forms.TabControl
$tabs.Location = New-Object System.Drawing.Point(0, 97)
$tabs.Size     = New-Object System.Drawing.Size(860, 620)
$tabs.Anchor   = 'Top,Bottom,Left,Right'

$tabSetup     = New-Object System.Windows.Forms.TabPage('Setup')
$tabQuestions = New-Object System.Windows.Forms.TabPage('Questions')
$tabGoals     = New-Object System.Windows.Forms.TabPage('Goals')
$tabMeeting   = New-Object System.Windows.Forms.TabPage('1-1 Meeting Preparation')
$tabProgress  = New-Object System.Windows.Forms.TabPage('Progress')

$tabs.TabPages.AddRange(@($tabSetup, $tabQuestions, $tabGoals, $tabMeeting, $tabProgress))
$form.Controls.Add($tabs)
