<#
.SYNOPSIS
    Headless UI screenshot capture for Person Assistant — 24 states with sample data.
.NOTES
    - PrintWindow: captures without needing screen DC access
    - Cross-process TCM_GETITEMRECT: accurate tab header clicks (VirtualAllocEx + ReadProcessMemory)
    - PostMessage WM_LBUTTONDOWN: send clicks to tab controls without keyboard/focus (no SendKeys)
    - WM_SETTEXT: inject text into textboxes cross-process via SendMessageStr
    - PID-validated window find: avoids latching onto stale windows from prior runs
    Save as UTF-8 with BOM.
#>
param()
Set-StrictMode -Off
$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;

public class UI {
    public delegate bool EnumWinCB(IntPtr h, IntPtr l);
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWinCB cb, IntPtr lp);
    [DllImport("user32.dll")] public static extern int  GetWindowText(IntPtr h, StringBuilder s, int m);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
    [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr h, out uint pid);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int cmd);
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
    [DllImport("user32.dll")] public static extern bool ClientToScreen(IntPtr h, ref POINT p);
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern IntPtr SendMessage(IntPtr h, uint msg, IntPtr w, IntPtr l);
    [DllImport("user32.dll", EntryPoint="SendMessageW", CharSet=CharSet.Unicode)]
    public static extern IntPtr SendMessageStr(IntPtr h, uint msg, IntPtr w, string s);
    [DllImport("user32.dll")] public static extern bool PostMessage(IntPtr h, uint msg, IntPtr w, IntPtr l);
    public delegate bool EnumChildCB(IntPtr h, IntPtr l);
    [DllImport("user32.dll")] public static extern bool EnumChildWindows(IntPtr parent, EnumChildCB cb, IntPtr lp);
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int GetClassName(IntPtr h, StringBuilder s, int m);
    [DllImport("user32.dll")] public static extern bool SetCursorPos(int x, int y);
    [DllImport("user32.dll")] public static extern void mouse_event(uint flags, int x, int y, uint d, int e);
    [DllImport("user32.dll")] public static extern bool PrintWindow(IntPtr hwnd, IntPtr hdcBlt, uint nFlags);
    [DllImport("user32.dll")] public static extern IntPtr GetDC(IntPtr h);
    [DllImport("user32.dll")] public static extern int ReleaseDC(IntPtr h, IntPtr dc);
    [DllImport("gdi32.dll")]  public static extern int GetDeviceCaps(IntPtr dc, int idx);

    [StructLayout(LayoutKind.Sequential)] public struct RECT  { public int Left, Top, Right, Bottom; }
    [StructLayout(LayoutKind.Sequential)] public struct POINT { public int X, Y; }

    public const uint MOUSEEVENTF_LEFTDOWN = 0x0002;
    public const uint MOUSEEVENTF_LEFTUP   = 0x0004;
    public const uint TCM_GETITEMRECT      = 0x130A;
    public const uint TCM_GETITEMCOUNT     = 0x1304;
    public const uint WM_LBUTTONDOWN       = 0x0201;
    public const uint WM_LBUTTONUP         = 0x0202;
    public const uint WM_SETTEXT           = 0x000C;
    public const uint WM_CLOSE             = 0x0010;
    public const uint WM_KEYDOWN           = 0x0100;
    public const uint WM_KEYUP             = 0x0101;
    public const int  VK_ESCAPE            = 0x1B;
    public const int  LOGPIXELSX          = 88;
    public const int  SW_RESTORE          = 9;
}

public class Kernel32 {
    [DllImport("kernel32.dll")]
    public static extern IntPtr OpenProcess(uint dwAccess, bool bInherit, int dwPid);
    [DllImport("kernel32.dll")]
    public static extern IntPtr VirtualAllocEx(IntPtr hProc, IntPtr lpAddr, int dwSize, uint flType, uint flProt);
    [DllImport("kernel32.dll")]
    public static extern bool WriteProcessMemory(IntPtr hProc, IntPtr lpBase, byte[] lpBuf, int nSize, out IntPtr lpWritten);
    [DllImport("kernel32.dll")]
    public static extern bool ReadProcessMemory(IntPtr hProc, IntPtr lpBase, byte[] lpBuf, int nSize, out IntPtr lpRead);
    [DllImport("kernel32.dll")]
    public static extern bool VirtualFreeEx(IntPtr hProc, IntPtr lpAddr, int dwSize, uint dwType);
    [DllImport("kernel32.dll")]
    public static extern bool CloseHandle(IntPtr h);
}
"@

$ScriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }
$Ts        = Get-Date -Format 'yyyyMMdd_HHmmss'
$OutDir    = Join-Path $ScriptDir "tests\screenshots\$Ts"
New-Item $OutDir -ItemType Directory -Force | Out-Null

# ============================================================================
#  Sample data
# ============================================================================
$SampleIntent = "Get all active persons with their department assignments, excluding security incidents"
$SampleSQL = "SELECT p.UID_Person, p.FirstName, p.LastName, p.CentralAccount,`r`n       o.UID_Org, o.IdentOrg`r`nFROM Person p`r`nINNER JOIN PersonInOrg pio ON p.UID_Person = pio.UID_Person`r`nINNER JOIN Org o ON pio.UID_Org = o.UID_Org`r`nWHERE p.IsSecurityIncident = 0 AND p.XMarkedForDeletion = 0`r`nORDER BY p.LastName, p.FirstName"
$SamplePresName  = "OIM_Role_Management_Overview"
$SampleDocNotes  = "Topic: OIM Role Management`r`nKey concepts:`r`n- IT Roles vs Business Roles`r`n- Role mining workflow`r`n- Attestation/certification campaigns`r`nAudience: Junior OIM Developers"

# ============================================================================
#  Helpers
# ============================================================================

function Get-DpiScale {
    $dc  = [UI]::GetDC([IntPtr]::Zero)
    $dpi = [UI]::GetDeviceCaps($dc, [UI]::LOGPIXELSX)
    [UI]::ReleaseDC([IntPtr]::Zero, $dc) | Out-Null
    return [double]$dpi / 96.0
}

# Find window by title AND owner PID (avoids latching onto stale windows from prior runs)
function Find-ProcessWindow([int]$targetPid, [int]$timeoutMs = 9000) {
    $script:_tgtPid = $targetPid
    $deadline = [DateTime]::Now.AddMilliseconds($timeoutMs)
    while ([DateTime]::Now -lt $deadline) {
        $script:_wndFound = [IntPtr]::Zero
        $cb = [UI+EnumWinCB]{
            param($h, $l)
            if ([UI]::IsWindowVisible($h)) {
                $sb = New-Object Text.StringBuilder 256
                [UI]::GetWindowText($h, $sb, 256) | Out-Null
                if ($sb.ToString() -eq 'Person Assistant') {
                    $wpid = [uint32]0
                    [UI]::GetWindowThreadProcessId($h, [ref]$wpid) | Out-Null
                    if ([int]$wpid -eq $script:_tgtPid) { $script:_wndFound = $h; return $false }
                }
            }
            return $true
        }
        [UI]::EnumWindows($cb, [IntPtr]::Zero) | Out-Null
        if ($script:_wndFound.ToInt64() -ne 0) {
            $r = New-Object UI+RECT
            [UI]::GetWindowRect($script:_wndFound, [ref]$r) | Out-Null
            if (($r.Right - $r.Left) -ge 200) { return $script:_wndFound }
        }
        Start-Sleep -Milliseconds 100
    }
    return [IntPtr]::Zero
}

function Find-ExactWindow([string]$title, [int]$timeoutMs = 3000) {
    $script:_wndTitle = $title
    $deadline = [DateTime]::Now.AddMilliseconds($timeoutMs)
    while ([DateTime]::Now -lt $deadline) {
        $script:_wndFound = [IntPtr]::Zero
        $cb = [UI+EnumWinCB]{
            param($h, $l)
            if ([UI]::IsWindowVisible($h)) {
                $sb = New-Object Text.StringBuilder 256
                [UI]::GetWindowText($h, $sb, 256) | Out-Null
                if ($sb.ToString() -eq $script:_wndTitle) { $script:_wndFound = $h; return $false }
            }
            return $true
        }
        [UI]::EnumWindows($cb, [IntPtr]::Zero) | Out-Null
        if ($script:_wndFound.ToInt64() -ne 0) {
            $r = New-Object UI+RECT
            [UI]::GetWindowRect($script:_wndFound, [ref]$r) | Out-Null
            if (($r.Right - $r.Left) -ge 200) { return $script:_wndFound }
        }
        Start-Sleep -Milliseconds 100
    }
    return [IntPtr]::Zero
}

# Capture via PrintWindow — works without screen DC / desktop access
function Capture-Hwnd([IntPtr]$hwnd, [string]$filename) {
    if ($hwnd.ToInt64() -eq 0) { Write-Warning "  [!] Skip $filename -- null HWND"; return }
    $r = New-Object UI+RECT
    [UI]::GetWindowRect($hwnd, [ref]$r) | Out-Null
    $w = $r.Right - $r.Left;  $h = $r.Bottom - $r.Top
    if ($w -le 0 -or $h -le 0 -or $w -gt 4096 -or $h -gt 4096) {
        Write-Warning "  [!] Skip $filename -- bad rect ($($r.Left),$($r.Top),$($r.Right),$($r.Bottom))"
        return
    }
    $bmp = New-Object System.Drawing.Bitmap($w, $h)
    $g   = [System.Drawing.Graphics]::FromImage($bmp)
    $hdc = $g.GetHdc()
    try   { [UI]::PrintWindow($hwnd, $hdc, 0x00000002) | Out-Null }  # PW_RENDERFULLCONTENT
    finally { $g.ReleaseHdc($hdc) }
    $g.Dispose()
    $bmp.Save((Join-Path $OutDir $filename), [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "  [+] $filename"
}

function Click-ScreenPt([int]$x, [int]$y) {
    [UI]::SetCursorPos($x, $y) | Out-Null
    Start-Sleep -Milliseconds 80
    [UI]::mouse_event([UI]::MOUSEEVENTF_LEFTDOWN, $x, $y, 0, 0)
    Start-Sleep -Milliseconds 50
    [UI]::mouse_event([UI]::MOUSEEVENTF_LEFTUP,   $x, $y, 0, 0)
}

function Click-ClientPt([IntPtr]$hwnd, [int]$cx, [int]$cy) {
    $pt = New-Object UI+POINT; $pt.X = $cx; $pt.Y = $cy
    [UI]::ClientToScreen($hwnd, [ref]$pt) | Out-Null
    Click-ScreenPt $pt.X $pt.Y
}

# Send WM_LBUTTONDOWN/UP directly to a control HWND (works without screen focus)
function PostClick-ClientPt([IntPtr]$hwnd, [int]$cx, [int]$cy) {
    $lp = [IntPtr](($cy -shl 16) -bor ($cx -band 0xFFFF))
    [UI]::PostMessage($hwnd, [UI]::WM_LBUTTONDOWN, [IntPtr]1, $lp) | Out-Null
    Start-Sleep -Milliseconds 30
    [UI]::PostMessage($hwnd, [UI]::WM_LBUTTONUP,   [IntPtr]0, $lp) | Out-Null
}

# Click tab header by cross-process TCM_GETITEMRECT; fallback to hardcoded offsets
function Click-TabItem([IntPtr]$tabHwnd, [int]$idx, [int]$procPid) {
    $PROCESS_ALL_ACCESS = 0x1F0FFF
    $MEM_COMMIT_RESERVE = 0x3000
    $PAGE_READWRITE     = 0x04
    $MEM_RELEASE        = 0x8000

    # How many tabs?
    $count = [int]([UI]::SendMessage($tabHwnd, [UI]::TCM_GETITEMCOUNT, [IntPtr]::Zero, [IntPtr]::Zero).ToInt64())
    Write-Host "  Tab[$idx]/$count HWND=$tabHwnd"

    $tabRect = New-Object UI+RECT
    [UI]::GetWindowRect($tabHwnd, [ref]$tabRect) | Out-Null

    $clicked = $false

    $hProc = [Kernel32]::OpenProcess($PROCESS_ALL_ACCESS, $false, $procPid)
    if ($hProc.ToInt64() -ne 0) {
        try {
            $remBuf = [Kernel32]::VirtualAllocEx($hProc, [IntPtr]::Zero, 16, $MEM_COMMIT_RESERVE, $PAGE_READWRITE)
            if ($remBuf.ToInt64() -ne 0) {
                try {
                    $zero = [byte[]]::new(16); $wr = [IntPtr]::Zero
                    [Kernel32]::WriteProcessMemory($hProc, $remBuf, $zero, 16, [ref]$wr) | Out-Null
                    $smRes = [UI]::SendMessage($tabHwnd, [UI]::TCM_GETITEMRECT, [IntPtr]$idx, $remBuf)
                    $buf = [byte[]]::new(16); $rd = [IntPtr]::Zero
                    [Kernel32]::ReadProcessMemory($hProc, $remBuf, $buf, 16, [ref]$rd) | Out-Null
                    $left   = [BitConverter]::ToInt32($buf,  0)
                    $top    = [BitConverter]::ToInt32($buf,  4)
                    $right  = [BitConverter]::ToInt32($buf,  8)
                    $bottom = [BitConverter]::ToInt32($buf, 12)
                    Write-Host "    TCM_GETITEMRECT: ret=$($smRes.ToInt64()) rect=($left,$top,$right,$bottom) rd=$($rd.ToInt64())"
                    if ($right -gt $left -and $bottom -gt $top -and $left -ge 0 -and $top -ge 0 -and $right -lt 2000) {
                        $clientX = [int](($left + $right) / 2)
                        $clientY = [int](($top + $bottom) / 2)
                        $pt = New-Object UI+POINT; $pt.X = $clientX; $pt.Y = $clientY
                        [UI]::ClientToScreen($tabHwnd, [ref]$pt) | Out-Null
                        Write-Host "    => screen=($($pt.X),$($pt.Y))"
                        Click-ScreenPt $pt.X $pt.Y
                        $clicked = $true
                    }
                } finally {
                    [Kernel32]::VirtualFreeEx($hProc, $remBuf, 0, $MEM_RELEASE) | Out-Null
                }
            }
        } finally {
            [Kernel32]::CloseHandle($hProc) | Out-Null
        }
    }

    if (-not $clicked) {
        # Fallback: PostMessage WM_LBUTTONDOWN at estimated client coords
        if ($count -le 0) { $count = 4 }
        $tcW     = $tabRect.Right - $tabRect.Left  # screen width of tab control
        # Estimate tab widths from typical WinForms rendering (8.25pt font ~7px/char + 24px padding)
        $estW    = [int]($tcW / $count)
        $clientX = $idx * $estW + [int]($estW / 2)
        $clientY = 13
        Write-Warning "    Fallback PostMessage click at client=($clientX,$clientY)"
        PostClick-ClientPt $tabHwnd $clientX $clientY
    }
}

function Find-TabControl([IntPtr]$parent) {
    $script:_tabCtrl = [IntPtr]::Zero
    $cb = [UI+EnumChildCB]{
        param($h, $l)
        $sb = New-Object Text.StringBuilder 256
        [UI]::GetClassName($h, $sb, 256) | Out-Null
        if ($sb.ToString() -match 'SysTabControl32') { $script:_tabCtrl = $h; return $false }
        return $true
    }
    [UI]::EnumChildWindows($parent, $cb, [IntPtr]::Zero) | Out-Null
    return $script:_tabCtrl
}

function Get-AllTabControls([IntPtr]$parent) {
    $list = [System.Collections.Generic.List[IntPtr]]::new()
    $script:_tabListRef = $list
    $cb2 = [UI+EnumChildCB]{
        param($h, $l)
        $sb = New-Object Text.StringBuilder 256
        [UI]::GetClassName($h, $sb, 256) | Out-Null
        if ($sb.ToString() -match 'SysTabControl32') { $script:_tabListRef.Add($h) }
        return $true
    }
    [UI]::EnumChildWindows($parent, $cb2, [IntPtr]::Zero) | Out-Null
    return $list
}

# Collect EDIT HWNDs in callback (no struct ops), process GetWindowRect outside — avoids PS5.1
# delegate callback [ref] marshaling issues with nested structs.
# Returns the Nth visible EDIT control sorted top-to-bottom (n=0 = topmost).
function Get-NthEditHwnd([IntPtr]$parent, [int]$n) {
    $script:_editHwnds = [System.Collections.Generic.List[IntPtr]]::new()
    $cbE = [UI+EnumChildCB]{
        param($h, $l)
        $sb = New-Object Text.StringBuilder 256
        [UI]::GetClassName($h, $sb, 256) | Out-Null
        if ($sb.ToString() -match 'EDIT') { $script:_editHwnds.Add($h) }
        return $true
    }
    [UI]::EnumChildWindows($parent, $cbE, [IntPtr]::Zero) | Out-Null
    $items = @()
    foreach ($h in $script:_editHwnds) {
        $r2 = New-Object UI+RECT
        [UI]::GetWindowRect($h, [ref]$r2) | Out-Null
        if ([UI]::IsWindowVisible($h) -and ($r2.Bottom - $r2.Top) -gt 0) {
            $items += [PSCustomObject]@{Hwnd=$h; Top=$r2.Top}
        }
    }
    $sorted = $items | Sort-Object Top
    if ($sorted -and $n -lt @($sorted).Count) { return [IntPtr]($sorted[$n].Hwnd) }
    Write-Warning "  Get-NthEditHwnd: n=$n not found (total visible: $(@($sorted).Count))"
    return [IntPtr]::Zero
}

# Inject text into the Nth visible EDIT control (sorted top-to-bottom)
function Set-NthFieldText([IntPtr]$parent, [int]$n, [string]$text) {
    $h = Get-NthEditHwnd $parent $n
    if ($h.ToInt64() -ne 0) {
        [UI]::SendMessageStr($h, [UI]::WM_SETTEXT, [IntPtr]::Zero, $text) | Out-Null
        Write-Host "  Set-NthFieldText: n=$n HWND=$h OK"
    }
}

function Open-Dropdown([IntPtr]$hwnd, [int]$cx, [int]$cy) {
    Click-ClientPt $hwnd $cx $cy
    Start-Sleep -Milliseconds 450
}

function Dismiss-Dropdown([IntPtr]$hwnd) {
    # Post VK_ESCAPE directly to the window (no SendKeys / no focus required)
    [UI]::PostMessage($hwnd, [UI]::WM_KEYDOWN, [IntPtr][UI]::VK_ESCAPE, [IntPtr]0x00010001) | Out-Null
    Start-Sleep -Milliseconds 50
    [UI]::PostMessage($hwnd, [UI]::WM_KEYUP,   [IntPtr][UI]::VK_ESCAPE, [IntPtr]0xC0010001) | Out-Null
    Start-Sleep -Milliseconds 200
}

# ============================================================================
#  Main
# ============================================================================
Write-Host "=== Person Assistant -- UI Screenshot Capture (sample data) ==="
Write-Host "Output: $OutDir"
$null = Get-DpiScale

# ── Inject sample profile ────────────────────────────────────────────────────
$ProfilePath   = Join-Path $ScriptDir 'profile.json'
$ProfileBackup = Join-Path $ScriptDir 'profile.json.bak'
$SampleProfile = Join-Path $ScriptDir 'tests\fixtures\sample_profile.json'
if (Test-Path $ProfilePath) { Copy-Item $ProfilePath $ProfileBackup -Force; Write-Host "  Backed up profile.json" }
Copy-Item $SampleProfile $ProfilePath -Force; Write-Host "  Injected sample profile"

$proc = Start-Process powershell `
    -ArgumentList "-ExecutionPolicy Bypass -File `"$ScriptDir\IntragenAssistant.ps1`"" `
    -PassThru -WindowStyle Normal
Write-Host "Launched PID $($proc.Id)"

try {
    # Wait for the form window — validated by PID to avoid catching stale windows
    $formHwnd = Find-ProcessWindow $proc.Id 9000
    if ($formHwnd.ToInt64() -eq 0) { throw "Person Assistant window not found for PID $($proc.Id)" }
    Write-Host "Form HWND: $formHwnd"
    [UI]::ShowWindow($formHwnd, [UI]::SW_RESTORE) | Out-Null
    [UI]::SetForegroundWindow($formHwnd) | Out-Null

    # Poll for main TabControl
    $mainTabCtrl = [IntPtr]::Zero
    $deadline2   = [DateTime]::Now.AddSeconds(10)
    while ([DateTime]::Now -lt $deadline2) {
        $mainTabCtrl = Find-TabControl $formHwnd
        if ($mainTabCtrl.ToInt64() -ne 0) { break }
        Start-Sleep -Milliseconds 200
    }
    if ($mainTabCtrl.ToInt64() -eq 0) { throw 'Main TabControl not found after 10s' }
    Write-Host "Main TabControl: $mainTabCtrl"
    Start-Sleep -Milliseconds 1500   # let WinForms finish painting

    # ── 00: initial state ──────────────────────────────────────────────────
    Capture-Hwnd $formHwnd '00_main_initial.png'

    # =========================================================================
    # GOALS (main tab index 0)
    # =========================================================================
    Click-TabItem $mainTabCtrl 0 $proc.Id
    Start-Sleep -Milliseconds 1200

    $nestedTabCtrl = [IntPtr]::Zero
    $nd = [DateTime]::Now.AddSeconds(8)
    while ([DateTime]::Now -lt $nd) {
        $allT = Get-AllTabControls $formHwnd
        $cand = $allT | Where-Object { $_.ToInt64() -ne $mainTabCtrl.ToInt64() } | Select-Object -First 1
        if ($cand -and $cand.ToInt64() -ne 0) { $nestedTabCtrl = $cand; break }
        Start-Sleep -Milliseconds 200
    }
    Write-Host "  Nested TabCtrl: $nestedTabCtrl"

    # Sub-tab 0: Setup
    if ($nestedTabCtrl.ToInt64() -ne 0) { Click-TabItem $nestedTabCtrl 0 $proc.Id; Start-Sleep -Milliseconds 600 }
    Capture-Hwnd $formHwnd '01_goals_setup.png'

    # Skill level dropdown [APPROX — grpSkills → pnlSkillAdd → cboSkillLevel]
    Open-Dropdown $formHwnd 310 237; Capture-Hwnd $formHwnd '03_goals_setup_skill_dd.png'; Dismiss-Dropdown $formHwnd

    # Domain quick-add dropdown [APPROX]
    Open-Dropdown $formHwnd 400 460; Capture-Hwnd $formHwnd '02_goals_setup_domain_dd.png'; Dismiss-Dropdown $formHwnd

    # Sub-tab 1: Questions
    if ($nestedTabCtrl.ToInt64() -ne 0) { Click-TabItem $nestedTabCtrl 1 $proc.Id; Start-Sleep -Milliseconds 600 }
    Capture-Hwnd $formHwnd '04_goals_questions.png'

    # Sub-tab 2: Goals
    if ($nestedTabCtrl.ToInt64() -ne 0) { Click-TabItem $nestedTabCtrl 2 $proc.Id; Start-Sleep -Milliseconds 600 }
    Capture-Hwnd $formHwnd '05_goals_goals.png'

    # Sub-tab 3: 1-1 Meeting
    if ($nestedTabCtrl.ToInt64() -ne 0) { Click-TabItem $nestedTabCtrl 3 $proc.Id; Start-Sleep -Milliseconds 600 }
    Capture-Hwnd $formHwnd '06_goals_meeting.png'

    # Sub-tab 4: Progress
    if ($nestedTabCtrl.ToInt64() -ne 0) { Click-TabItem $nestedTabCtrl 4 $proc.Id; Start-Sleep -Milliseconds 600 }
    Capture-Hwnd $formHwnd '07_goals_progress.png'

    # =========================================================================
    # QUERY EVALUATOR (main tab index 1)
    # pnlQE: Dock=Fill, tab content at y=125
    # $txtIntent: Location(0,22) W=900 → center form-client (450,147)
    # $txtSQL:    Location(0,76) H=100 → center form-client (455,226 = 125+76+50-25)
    # $cboModel:  Location(148,186) → form-client center (213, 311)
    # $btnHistory:Location(364,184) → form-client center (404, 309)
    # =========================================================================
    Click-TabItem $mainTabCtrl 1 $proc.Id
    Start-Sleep -Milliseconds 900

    Set-NthFieldText $formHwnd 0 $SampleIntent
    Set-NthFieldText $formHwnd 1 $SampleSQL
    [UI]::SetForegroundWindow($formHwnd) | Out-Null; Start-Sleep -Milliseconds 300
    Capture-Hwnd $formHwnd '08_queryeval.png'

    Open-Dropdown $formHwnd 213 311; Capture-Hwnd $formHwnd '09_queryeval_model_dd.png'; Dismiss-Dropdown $formHwnd

    # History button [APPROX]
    [UI]::SetForegroundWindow($formHwnd) | Out-Null
    Click-ClientPt $formHwnd 404 309
    Start-Sleep -Milliseconds 800
    $histHwnd = Find-ExactWindow 'Evaluation History' 2000
    if ($histHwnd.ToInt64() -ne 0) {
        Capture-Hwnd $histHwnd '23_history_dialog.png'
        [UI]::SendMessage($histHwnd, [UI]::WM_CLOSE, [IntPtr]::Zero, [IntPtr]::Zero) | Out-Null
        Start-Sleep -Milliseconds 400
    } else {
        Write-Warning "  [!] No Evaluation History dialog (empty history ok) -- skipped"
    }

    # =========================================================================
    # PRESENTATIONS (main tab index 2)
    # grpCreate at (0,80) in pnlPres: txtPresName at (10,46) inside → form-client center (210,125+80+46+11=262)
    # =========================================================================
    Click-TabItem $mainTabCtrl 2 $proc.Id
    Start-Sleep -Milliseconds 900
    Set-NthFieldText $formHwnd 0 $SamplePresName
    [UI]::SetForegroundWindow($formHwnd) | Out-Null; Start-Sleep -Milliseconds 200
    Capture-Hwnd $formHwnd '10_presentations.png'

    # =========================================================================
    # DOC BUILDER (main tab index 3)
    # $cboDocType Location(80,0) → form-client center (170, 138)
    # $cboFormat  Location(330,0)→ form-client center (400, 138)
    # $txtRawNotes Location(0,58) H=140 → form-client center (455, 253)
    # =========================================================================
    Click-TabItem $mainTabCtrl 3 $proc.Id
    Start-Sleep -Milliseconds 900
    Capture-Hwnd $formHwnd '11_docbuilder.png'

    Open-Dropdown $formHwnd 170 138; Capture-Hwnd $formHwnd '12_docbuilder_doctype_dd.png'; Dismiss-Dropdown $formHwnd
    Open-Dropdown $formHwnd 400 138; Capture-Hwnd $formHwnd '13_docbuilder_format_dd.png'; Dismiss-Dropdown $formHwnd

    Set-NthFieldText $formHwnd 0 $SampleDocNotes
    [UI]::SetForegroundWindow($formHwnd) | Out-Null; Start-Sleep -Milliseconds 200
    Capture-Hwnd $formHwnd '11b_docbuilder_filled.png'

    # =========================================================================
    # SETTINGS DIALOG — open via direct click on File > Settings menu items
    # MenuStrip at form-client y=0 H=24; "&File" item at x≈8..36 center=(20,12)
    # After File menu opens: "&Settings..." is first item, y≈24+12=36 from form top in screen
    # =========================================================================
    [UI]::SetForegroundWindow($formHwnd) | Out-Null; Start-Sleep -Milliseconds 200
    # Open Settings: try SendKeys Alt+F → S, fall back to popup-find, then fixed coords
    [UI]::SetForegroundWindow($formHwnd) | Out-Null; Start-Sleep -Milliseconds 600
    $settOpened = $false
    try {
        # Attempt 1: keyboard Alt+F then S (most reliable when form has focus)
        [System.Windows.Forms.SendKeys]::SendWait('%f')
        Start-Sleep -Milliseconds 500
        [System.Windows.Forms.SendKeys]::SendWait('s')
        Start-Sleep -Milliseconds 1200
        $settOpened = $true
        Write-Host "  SendKeys Alt+F,S sent"
    } catch {
        Write-Warning "  SendKeys failed ($($_.Exception.Message)) — trying mouse"
        # Attempt 2: mouse click on File menu; find popup by class
        [UI]::SetCursorPos(500, 500) | Out-Null; Start-Sleep -Milliseconds 200
        Click-ClientPt $formHwnd 20 12; Start-Sleep -Milliseconds 700
        $script:_ddHwnd = [IntPtr]::Zero
        $cbDd = [UI+EnumWinCB]{
            param($h, $l)
            if ([UI]::IsWindowVisible($h)) {
                $sb = New-Object Text.StringBuilder 256
                [UI]::GetClassName($h, $sb, 256) | Out-Null
                $cls = $sb.ToString()
                if ($cls -match '32768' -or $cls -match 'ToolStrip') {
                    $sb2 = New-Object Text.StringBuilder 256; [UI]::GetWindowText($h,$sb2,256)|Out-Null
                    Write-Host "  Popup candidate: HWND=$h cls=$cls title=$($sb2.ToString())"
                    if ($script:_ddHwnd.ToInt64() -eq 0) { $script:_ddHwnd = $h }
                }
            }
            return $true
        }
        [UI]::EnumWindows($cbDd, [IntPtr]::Zero) | Out-Null
        if ($script:_ddHwnd.ToInt64() -ne 0) {
            $ddR = New-Object UI+RECT; [UI]::GetWindowRect($script:_ddHwnd, [ref]$ddR) | Out-Null
            Click-ScreenPt ($ddR.Left + 30) ($ddR.Top + 11)
        } else {
            $fCO = New-Object UI+POINT; $fCO.X = 0; $fCO.Y = 0
            [UI]::ClientToScreen($formHwnd, [ref]$fCO) | Out-Null
            Click-ScreenPt ($fCO.X + 30) ($fCO.Y + 35)
        }
        Start-Sleep -Milliseconds 1200
    }

    $settHwnd = Find-ExactWindow 'Settings' 3000
    if ($settHwnd.ToInt64() -eq 0) {
        Write-Warning "  [!] Settings dialog not found -- skipping settings tabs"
    } else {
        Write-Host "  Settings HWND: $settHwnd"
        $sTabCtrl = Find-TabControl $settHwnd

        if ($sTabCtrl.ToInt64() -ne 0) { Click-TabItem $sTabCtrl 0 $proc.Id; Start-Sleep -Milliseconds 400 }
        Capture-Hwnd $settHwnd '14_settings_api.png'

        if ($sTabCtrl.ToInt64() -ne 0) { Click-TabItem $sTabCtrl 1 $proc.Id; Start-Sleep -Milliseconds 400 }
        Capture-Hwnd $settHwnd '15_settings_presstyle.png'
        Open-Dropdown $settHwnd 100 93; Capture-Hwnd $settHwnd '16_settings_presstyle_tone_dd.png'; Dismiss-Dropdown $settHwnd

        if ($sTabCtrl.ToInt64() -ne 0) { Click-TabItem $sTabCtrl 2 $proc.Id; Start-Sleep -Milliseconds 400 }
        Capture-Hwnd $settHwnd '17_settings_docstyle.png'
        Open-Dropdown $settHwnd 100 93; Capture-Hwnd $settHwnd '18_settings_docstyle_tone_dd.png'; Dismiss-Dropdown $settHwnd

        if ($sTabCtrl.ToInt64() -ne 0) { Click-TabItem $sTabCtrl 3 $proc.Id; Start-Sleep -Milliseconds 400 }
        Capture-Hwnd $settHwnd '19_settings_profile.png'

        if ($sTabCtrl.ToInt64() -ne 0) { Click-TabItem $sTabCtrl 4 $proc.Id; Start-Sleep -Milliseconds 400 }
        Capture-Hwnd $settHwnd '20_settings_models.png'
        Open-Dropdown $settHwnd 180 200; Capture-Hwnd $settHwnd '21_settings_models_prov_dd.png'; Dismiss-Dropdown $settHwnd

        # Close Settings via WM_CLOSE
        [UI]::SendMessage($settHwnd, [UI]::WM_CLOSE, [IntPtr]::Zero, [IntPtr]::Zero) | Out-Null
        Start-Sleep -Milliseconds 600
    }

    [UI]::SetForegroundWindow($formHwnd) | Out-Null; Start-Sleep -Milliseconds 300
    Capture-Hwnd $formHwnd '22_settings_closed.png'

    # ── manifest ──────────────────────────────────────────────────────────────
    $manifest = [ordered]@{
        '00'='00_main_initial.png'; '01'='01_goals_setup.png'; '02'='02_goals_setup_domain_dd.png'
        '03'='03_goals_setup_skill_dd.png'; '04'='04_goals_questions.png'; '05'='05_goals_goals.png'
        '06'='06_goals_meeting.png'; '07'='07_goals_progress.png'; '08'='08_queryeval.png'
        '09'='09_queryeval_model_dd.png'; '10'='10_presentations.png'; '11'='11_docbuilder.png'
        '11b'='11b_docbuilder_filled.png'; '12'='12_docbuilder_doctype_dd.png'; '13'='13_docbuilder_format_dd.png'
        '14'='14_settings_api.png'; '15'='15_settings_presstyle.png'; '16'='16_settings_presstyle_tone_dd.png'
        '17'='17_settings_docstyle.png'; '18'='18_settings_docstyle_tone_dd.png'; '19'='19_settings_profile.png'
        '20'='20_settings_models.png'; '21'='21_settings_models_prov_dd.png'; '22'='22_settings_closed.png'
        '23'='23_history_dialog.png'
    }
    $enc = New-Object System.Text.UTF8Encoding($true)
    [System.IO.File]::WriteAllText((Join-Path $OutDir 'manifest.json'), ($manifest | ConvertTo-Json), $enc)

    $n = (Get-ChildItem $OutDir -Filter '*.png').Count
    Write-Host ""; Write-Host "=== Done: $n PNGs in $OutDir ==="
    Write-Output $OutDir

} finally {
    if ($proc -and -not $proc.HasExited) { Write-Host "Killing PID $($proc.Id)..."; $proc.Kill() }
    if (Test-Path $ProfileBackup) { Copy-Item $ProfileBackup $ProfilePath -Force; Remove-Item $ProfileBackup; Write-Host "  Restored profile.json" }
}
