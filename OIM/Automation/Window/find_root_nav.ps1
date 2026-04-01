Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class FRN {
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
$cb = [FRN+EnumCB]{ param($h,$l)
    if ([FRN]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [FRN]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match 'Designer'){ $script:target=$h; return $false }
    }; return $true
}
[FRN]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[FRN]::ShowWindow($target,3)|Out-Null
[FRN]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 700

$rect = New-Object FRN+RECT
[FRN]::GetWindowRect($target,[ref]$rect)|Out-Null
$L=$rect.Left; $T=$rect.Top; $W=$rect.Right-$rect.Left

function Click-At($x,$y,[int]$wait=500) {
    [FRN]::SetCursorPos($x,$y)|Out-Null
    [FRN]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
    [FRN]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds $wait
}
function Capture-Label($label) {
    [FRN]::GetWindowRect($target,[ref]$rect)|Out-Null
    $w2=$rect.Right-$rect.Left; $h2=$rect.Bottom-$rect.Top
    $bmp=New-Object System.Drawing.Bitmap($w2,$h2)
    $g=[System.Drawing.Graphics]::FromImage($bmp)
    $g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
    $path=$env:TEMP+"\oim_frn_"+$label+".png"
    $bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose()
    Write-Output $path
}

# Click the small nav "home" icon at top-left of nav panel (the # or hamburger icon ~x=12, y=95)
Click-At ($L + 12) ($T + 95) 600
Capture-Label "01_nav_home_icon"

# Try the small icon next to "Navigation" header (x~170, y~95)
Click-At ($L + 170) ($T + 95) 600
Capture-Label "02_nav_header_right"

# Click "Getting Started" which is always visible at the bottom - this is a root nav item
Click-At ($L + 85) ($T + 680) 600
Capture-Label "03_getting_started"

# Try View menu to find a "Navigation" or "All sections" option
Click-At ($L + 210) ($T + 28) 600
Capture-Label "04_view_menu"
[System.Windows.Forms.SendKeys]::SendWait("{ESC}")
Start-Sleep -Milliseconds 300

# Click "One Identity Manager Schema" root node (visible at bottom)
Click-At ($L + 85) ($T + 700) 600
Capture-Label "05_oim_schema"

# Expand with RIGHT
[System.Windows.Forms.SendKeys]::SendWait("{HOME}")
Start-Sleep -Milliseconds 300
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Milliseconds 400
Capture-Label "06_schema_expanded"

# Walk through schema sub-items
for($i=1;$i -le 10;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 80
}
Capture-Label "07_schema_children"

# Now try clicking "Permissions" root node
Click-At ($L + 85) ($T + 720) 600
Capture-Label "08_permissions"

# Expand
[System.Windows.Forms.SendKeys]::SendWait("{HOME}")
Start-Sleep -Milliseconds 300
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Milliseconds 400
Capture-Label "09_permissions_expanded"
