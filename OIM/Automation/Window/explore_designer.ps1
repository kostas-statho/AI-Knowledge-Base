Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class ED {
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
$cb = [ED+EnumCB]{ param($h,$l)
    if ([ED]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [ED]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match 'Designer'){ $script:target=$h; return $false }
    }; return $true
}
[ED]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[ED]::ShowWindow($target,3)|Out-Null
[ED]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 800

$rect = New-Object ED+RECT

function Click-At($x,$y) {
    [ED]::SetCursorPos($x,$y)|Out-Null
    [ED]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
    [ED]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 300
}

function Capture-Label($label) {
    [ED]::GetWindowRect($target,[ref]$rect)|Out-Null
    $w=$rect.Right-$rect.Left; $h=$rect.Bottom-$rect.Top
    $bmp=New-Object System.Drawing.Bitmap($w,$h)
    $g=[System.Drawing.Graphics]::FromImage($bmp)
    $g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
    $path=$env:TEMP+"\oim_exp_"+$label+".png"
    $bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose()
    Write-Output $path
}

[ED]::GetWindowRect($target,[ref]$rect)|Out-Null
$winLeft = $rect.Left
$winTop  = $rect.Top
$winW    = $rect.Right - $rect.Left
$winH    = $rect.Bottom - $rect.Top

Write-Host "Window: ${winW}x${winH} at ($winLeft,$winTop)"

# Click "Process Automation" shortcut button in the top toolbar area
# It appears to be at roughly 50% width, near the top
$btnX = $winLeft + [int]($winW * 0.42)
$btnY = $winTop + 55
Click-At $btnX $btnY
Start-Sleep -Milliseconds 600
Capture-Label "proc_auto_btn"

# Now try clicking in the nav tree - expand nodes below Permissions
# Nav tree is ~160px wide, items are ~18px tall each
# Root nodes visible at approximately these y offsets from window top:
# Base Data: ~130, Getting Started: ~470, One Identity Manager Schema: ~490, Permissions: ~510
# Try clicking at y positions below Permissions to find more items

# First go back to nav - click at left edge nav tree area
$navX = $winLeft + 85
# Try clicking at Permissions position and then use Down arrow many times
Click-At $navX ($winTop + 510)
Start-Sleep -Milliseconds 300
Capture-Label "before_down"

# Press Down arrow 15 times to walk through items
for ($i = 1; $i -le 20; $i++) {
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}")
    Start-Sleep -Milliseconds 80
}
Start-Sleep -Milliseconds 400
Capture-Label "after_down_20"

for ($i = 1; $i -le 20; $i++) {
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}")
    Start-Sleep -Milliseconds 80
}
Start-Sleep -Milliseconds 400
Capture-Label "after_down_40"

for ($i = 1; $i -le 20; $i++) {
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}")
    Start-Sleep -Milliseconds 80
}
Start-Sleep -Milliseconds 400
Capture-Label "after_down_60"
