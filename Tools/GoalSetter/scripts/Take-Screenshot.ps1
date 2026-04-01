# Take-Screenshot.ps1
# Captures one or all tabs of the GoalSetter app window using PrintWindow (no foreground needed).
# Usage:
#   .\Take-Screenshot.ps1                          # capture current state
#   .\Take-Screenshot.ps1 -TabIndex 2              # switch to tab 2 then capture
#   .\Take-Screenshot.ps1 -AllTabs                 # capture all 5 tabs
param(
    [string]$OutputPath = "",
    [int]$TabIndex = -1,
    [switch]$AllTabs
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Add-Type @"
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Drawing;
using System.Text;

public class Win32Helper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

    [DllImport("user32.dll")]
    public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

    [DllImport("user32.dll")]
    public static extern bool IsIconic(IntPtr hWnd);

    [DllImport("user32.dll")]
    public static extern bool PrintWindow(IntPtr hWnd, IntPtr hDC, uint nFlags);

    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);

    [DllImport("user32.dll")]
    public static extern bool BringWindowToTop(IntPtr hWnd);

    [DllImport("user32.dll")]
    public static extern bool ClientToScreen(IntPtr hWnd, ref POINT lpPoint);

    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int x, int y);

    [DllImport("user32.dll")]
    public static extern void mouse_event(uint dwFlags, int dx, int dy, int cButtons, int dwExtraInfo);

    [StructLayout(LayoutKind.Sequential)]
    public struct POINT { public int X, Y; }

    public const uint MOUSEEVENTF_LEFTDOWN = 0x0002;
    public const uint MOUSEEVENTF_LEFTUP   = 0x0004;

    [DllImport("user32.dll")]
    public static extern bool EnumChildWindows(IntPtr hwnd, EnumChildProc cb, IntPtr lp);

    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int GetClassName(IntPtr hwnd, StringBuilder s, int n);

    [DllImport("user32.dll")]
    public static extern IntPtr SendMessage(IntPtr hwnd, uint msg, IntPtr wParam, IntPtr lParam);

    public delegate bool EnumChildProc(IntPtr hwnd, IntPtr lp);

    [StructLayout(LayoutKind.Sequential)]
    public struct RECT {
        public int Left, Top, Right, Bottom;
    }

}
"@

$windowTitle = 'Goal Setting Helper'

# --- Locate running process window ----------------------------------------
function Find-AppWindow {
    $proc = Get-Process -Name powershell -ErrorAction SilentlyContinue |
            Where-Object { $_.MainWindowTitle -eq $windowTitle } |
            Select-Object -First 1
    if ($proc -and $proc.MainWindowHandle -ne [IntPtr]::Zero) { return $proc.MainWindowHandle }
    return [Win32Helper]::FindWindow($null, $windowTitle)
}

$hwnd = Find-AppWindow

if (-not $hwnd -or $hwnd -eq [IntPtr]::Zero) {
    Write-Host "App not running - launching GoalSetter..."
    $appPath = (Resolve-Path (Join-Path $PSScriptRoot "..\GoalSetter.ps1")).Path
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -WindowStyle Normal -File `"$appPath`""
    for ($i = 0; $i -lt 30; $i++) {
        Start-Sleep -Seconds 1
        $hwnd = Find-AppWindow
        if ($hwnd -and $hwnd -ne [IntPtr]::Zero) { break }
    }
    if (-not $hwnd -or $hwnd -eq [IntPtr]::Zero) {
        Write-Error "Could not find '$windowTitle' after 30 seconds."; exit 1
    }
    Start-Sleep -Milliseconds 1500
}

if ([Win32Helper]::IsIconic($hwnd)) { [Win32Helper]::ShowWindow($hwnd, 9) | Out-Null }
[Win32Helper]::BringWindowToTop($hwnd) | Out-Null
[Win32Helper]::SetForegroundWindow($hwnd) | Out-Null
Start-Sleep -Milliseconds 400

# --- Tab click helper: physically click the tab header at the right index -
# Tab control client-area x offsets measured from the app at default size.
# The tab control is at client y=97; headers are ~24px tall → click at y=109.
# X centres (client coords): Setup≈30, Questions≈91, Goals≈144, Meeting≈276, Progress≈342
$tabClickX = @(30, 91, 144, 276, 342)   # client x centres for tabs 0-4
$tabClickY = 109                          # client y centre of tab header row

function Select-Tab([IntPtr]$windowHandle, [int]$index) {
    if ($index -lt 0 -or $index -gt 4) { return }
    # Convert client coords to screen coords
    $pt = New-Object Win32Helper+POINT
    $pt.X = $tabClickX[$index]
    $pt.Y = $tabClickY
    [Win32Helper]::ClientToScreen($windowHandle, [ref]$pt) | Out-Null
    # Move cursor and click
    [Win32Helper]::SetCursorPos($pt.X, $pt.Y) | Out-Null
    Start-Sleep -Milliseconds 80
    [Win32Helper]::mouse_event([Win32Helper]::MOUSEEVENTF_LEFTDOWN, $pt.X, $pt.Y, 0, 0)
    Start-Sleep -Milliseconds 50
    [Win32Helper]::mouse_event([Win32Helper]::MOUSEEVENTF_LEFTUP,   $pt.X, $pt.Y, 0, 0)
}

# --- Helper: capture current window state to a file ----------------------
function Save-WindowImage([string]$path) {
    $rect = New-Object Win32Helper+RECT
    [Win32Helper]::GetWindowRect($hwnd, [ref]$rect) | Out-Null
    $w = $rect.Right - $rect.Left
    $h = $rect.Bottom - $rect.Top
    $bmp = New-Object System.Drawing.Bitmap($w, $h)
    $g   = [System.Drawing.Graphics]::FromImage($bmp)
    # CopyFromScreen captures the live foreground content correctly after tab switch
    $g.CopyFromScreen($rect.Left, $rect.Top, 0, 0, [System.Drawing.Size]::new($w, $h))
    $g.Dispose()
    $dir = Split-Path $path -Parent
    if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Saved: $path"
    $path
}

# --- Capture all tabs -----------------------------------------------------
$screenshotsDir = Join-Path $PSScriptRoot "..\screenshots"
$ts = Get-Date -Format 'yyyyMMdd_HHmmss'

if ($AllTabs) {
    $tabNames = @('setup','questions','goals','meeting','progress')
    for ($i = 0; $i -lt 5; $i++) {
        Select-Tab $hwnd $i | Out-Null
        Start-Sleep -Milliseconds 700
        $p = Join-Path $screenshotsDir "tab${i}_$($tabNames[$i])_${ts}.png"
        Save-WindowImage $p
    }
    return
}

# --- Capture single tab ---------------------------------------------------
if ($TabIndex -ge 0) {
    Select-Tab $hwnd $TabIndex | Out-Null
    Start-Sleep -Milliseconds 500
}

if (-not $OutputPath) {
    $sfx = if ($TabIndex -ge 0) { "_tab${TabIndex}" } else { "" }
    $OutputPath = Join-Path $screenshotsDir "screenshot${sfx}_${ts}.png"
}
Save-WindowImage $OutputPath
