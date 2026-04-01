Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class SBD {
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
$cb = [SBD+EnumCB]{ param($h,$l)
    if ([SBD]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [SBD]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match 'Designer'){ $script:target=$h; return $false }
    }; return $true
}
[SBD]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[SBD]::ShowWindow($target,3)|Out-Null
[SBD]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 700

$rect = New-Object SBD+RECT
[SBD]::GetWindowRect($target,[ref]$rect)|Out-Null
$L=$rect.Left; $T=$rect.Top; $W=$rect.Right-$rect.Left

function Click-At($x,$y,[int]$wait=400) {
    [SBD]::SetCursorPos($x,$y)|Out-Null
    [SBD]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
    [SBD]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds $wait
}
function Capture-Label($label) {
    [SBD]::GetWindowRect($target,[ref]$rect)|Out-Null
    $w2=$rect.Right-$rect.Left; $h2=$rect.Bottom-$rect.Top
    $bmp=New-Object System.Drawing.Bitmap($w2,$h2)
    $g=[System.Drawing.Graphics]::FromImage($bmp)
    $g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
    $path=$env:TEMP+"\oim_sbd_"+$label+".png"
    $bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose()
    Write-Output $path
}

# Click the "My Designer" root area to ensure we are at root
# The nav panel shows "My Designer" header. Clicking below it ~y=120 should select first root node
Click-At ($L + 85) ($T + 120) 400

# Press HOME to go to top of root section
[System.Windows.Forms.SendKeys]::SendWait("{HOME}"); Start-Sleep -Milliseconds 400
Capture-Label "01_root_home"

# Press RIGHT to expand first item (should be Base Data)
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}"); Start-Sleep -Milliseconds 400
Capture-Label "02_basedata_open"

# Walk ALL Base Data children - press DOWN many times, capture every ~15 steps
for($i=1;$i -le 15;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 70
}
Capture-Label "03_bd_walk_15"

for($i=1;$i -le 15;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 70
}
Capture-Label "04_bd_walk_30"

for($i=1;$i -le 15;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 70
}
Capture-Label "05_bd_walk_45"

for($i=1;$i -le 15;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 70
}
Capture-Label "06_bd_walk_60"

# Capture the END of the tree
[System.Windows.Forms.SendKeys]::SendWait("{END}"); Start-Sleep -Milliseconds 600
Capture-Label "07_absolute_end"
