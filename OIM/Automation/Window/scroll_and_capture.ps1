param([string]$TitleContains = "Designer", [int]$ScrollClicks = 0)
Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class SC {
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumCB cb, IntPtr lp);
    [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int m);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int cmd);
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
    [DllImport("user32.dll")] public static extern void mouse_event(uint f, int x, int y, int d, IntPtr i);
    [DllImport("user32.dll")] public static extern bool SetCursorPos(int x, int y);
    [StructLayout(LayoutKind.Sequential)] public struct RECT { public int Left,Top,Right,Bottom; }
    public delegate bool EnumCB(IntPtr h, IntPtr l);
}
"@
Add-Type -AssemblyName System.Drawing, System.Windows.Forms

$target = [IntPtr]::Zero
$cb = [SC+EnumCB]{ param($h,$l)
    if ([SC]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [SC]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match [regex]::Escape($TitleContains)){ $script:target=$h; return $false }
    }; return $true
}
[SC]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[SC]::ShowWindow($target,3)|Out-Null
[SC]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 1000

$rect = New-Object SC+RECT
[SC]::GetWindowRect($target,[ref]$rect)|Out-Null

# Nav tree is roughly the left 20% of the window
$navX = $rect.Left + 100
$navY = $rect.Top + 300

# Click in nav area to focus it
[SC]::SetCursorPos($navX, $navY)|Out-Null
[SC]::mouse_event(2,0,0,0,[IntPtr]::Zero)   # MOUSEEVENTF_LEFTDOWN
Start-Sleep -Milliseconds 80
[SC]::mouse_event(4,0,0,0,[IntPtr]::Zero)   # MOUSEEVENTF_LEFTUP
Start-Sleep -Milliseconds 200

# Scroll down
if ($ScrollClicks -gt 0) {
    [SC]::SetCursorPos($navX, $navY)|Out-Null
    for ($i = 0; $i -lt $ScrollClicks; $i++) {
        [SC]::mouse_event(0x0800,0,0,-120,[IntPtr]::Zero)  # MOUSEEVENTF_WHEEL scroll down
        Start-Sleep -Milliseconds 40
    }
    Start-Sleep -Milliseconds 400
} elseif ($ScrollClicks -lt 0) {
    [SC]::SetCursorPos($navX, $navY)|Out-Null
    for ($i = 0; $i -lt ([Math]::Abs($ScrollClicks)); $i++) {
        [SC]::mouse_event(0x0800,0,0,120,[IntPtr]::Zero)   # scroll up
        Start-Sleep -Milliseconds 40
    }
    Start-Sleep -Milliseconds 400
}

# Capture
[SC]::GetWindowRect($target,[ref]$rect)|Out-Null
$w = $rect.Right - $rect.Left
$h = $rect.Bottom - $rect.Top
$bmp = New-Object System.Drawing.Bitmap($w,$h)
$g   = [System.Drawing.Graphics]::FromImage($bmp)
$g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
$ts  = (Get-Date).ToString('yyyyMMdd_HHmmss')
$path = $env:TEMP + "\oim_scroll_" + $ts + ".png"
$bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()
Write-Output $path
