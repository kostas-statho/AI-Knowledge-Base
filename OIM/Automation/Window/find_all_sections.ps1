Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class FAS {
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
$cb = [FAS+EnumCB]{ param($h,$l)
    if ([FAS]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [FAS]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match 'Designer'){ $script:target=$h; return $false }
    }; return $true
}
[FAS]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[FAS]::ShowWindow($target,3)|Out-Null
[FAS]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 700

$rect = New-Object FAS+RECT
[FAS]::GetWindowRect($target,[ref]$rect)|Out-Null
$L=$rect.Left; $T=$rect.Top; $W=$rect.Right-$rect.Left

function Click-At($x,$y) {
    [FAS]::SetCursorPos($x,$y)|Out-Null
    [FAS]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
    [FAS]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 350
}
function Capture-Label($label) {
    [FAS]::GetWindowRect($target,[ref]$rect)|Out-Null
    $w2=$rect.Right-$rect.Left; $h2=$rect.Bottom-$rect.Top
    $bmp=New-Object System.Drawing.Bitmap($w2,$h2)
    $g=[System.Drawing.Graphics]::FromImage($bmp)
    $g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
    $path=$env:TEMP+"\oim_fas_"+$label+".png"
    $bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose()
    Write-Output $path
}

# Click in nav tree
$navX = $L + 85
Click-At $navX ($T + 300)

# HOME to get to top of tree
[System.Windows.Forms.SendKeys]::SendWait("{HOME}")
Start-Sleep -Milliseconds 400
Capture-Label "01_top"

# Expand Base Data with RIGHT
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Milliseconds 400
Capture-Label "02_basedata_open"

# Walk down through ALL Base Data children - press DOWN 30 times
for($i=1;$i -le 30;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 60
}
Capture-Label "03_basedata_walked"

# Continue down to next root section
for($i=1;$i -le 10;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 60
}
Capture-Label "04_after_basedata"

# Continue down to find Notifications / mail templates
for($i=1;$i -le 20;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 60
}
Capture-Label "05_more_sections"

# Expand current node to see children
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Milliseconds 400
Capture-Label "06_expanded_section"

# Keep going down
for($i=1;$i -le 30;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 60
}
Capture-Label "07_deep"

# Use keyboard search - type 'n' to jump to Notifications if visible
[System.Windows.Forms.SendKeys]::SendWait("n")
Start-Sleep -Milliseconds 500
Capture-Label "08_after_n_key"

# Type 'not' to narrow down
[System.Windows.Forms.SendKeys]::SendWait("ot")
Start-Sleep -Milliseconds 500
Capture-Label "09_after_not_key"
