Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class SM {
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
$cb = [SM+EnumCB]{ param($h,$l)
    if ([SM]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [SM]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match 'Designer'){ $script:target=$h; return $false }
    }; return $true
}
[SM]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[SM]::ShowWindow($target,3)|Out-Null
[SM]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 600

$rect = New-Object SM+RECT

function Capture-Label($label) {
    [SM]::GetWindowRect($target,[ref]$rect)|Out-Null
    $w=$rect.Right-$rect.Left; $h=$rect.Bottom-$rect.Top
    $bmp=New-Object System.Drawing.Bitmap($w,$h)
    $g=[System.Drawing.Graphics]::FromImage($bmp)
    $g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
    $path=$env:TEMP+"\oim_s2_"+$label+".png"
    $bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose()
    Write-Output $path
}

# Click in nav tree to ensure focus
[SM]::GetWindowRect($target,[ref]$rect)|Out-Null
$navX = $rect.Left + 85
$navY = $rect.Top + 300
[SM]::SetCursorPos($navX,$navY)|Out-Null
[SM]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
[SM]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 300

# Go to END of tree
[System.Windows.Forms.SendKeys]::SendWait("{END}")
Start-Sleep -Milliseconds 600
Capture-Label "tree_end"

# Now collapse current section and navigate up to see the full top-level structure
[System.Windows.Forms.SendKeys]::SendWait("{HOME}")
Start-Sleep -Milliseconds 400

# Expand the "Process Orchestration" node by pressing Right on it
# First navigate down until we see it highlighted
for ($i=1;$i -le 60;$i++) {
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}")
    Start-Sleep -Milliseconds 50
}
Capture-Label "after_down_walk"

# Keep going to find Notifications
for ($i=1;$i -le 40;$i++) {
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}")
    Start-Sleep -Milliseconds 50
}
Capture-Label "notifications_area"

# Keep going to find the bottom
for ($i=1;$i -le 40;$i++) {
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}")
    Start-Sleep -Milliseconds 50
}
Capture-Label "bottom_area"
