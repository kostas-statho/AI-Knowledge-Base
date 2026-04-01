Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class FSM {
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
$cb = [FSM+EnumCB]{ param($h,$l)
    if ([FSM]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [FSM]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match 'Designer'){ $script:target=$h; return $false }
    }; return $true
}
[FSM]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[FSM]::ShowWindow($target,3)|Out-Null
[FSM]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 700

$rect = New-Object FSM+RECT
[FSM]::GetWindowRect($target,[ref]$rect)|Out-Null
$L=$rect.Left; $T=$rect.Top; $W=$rect.Right-$rect.Left

function Click-At($x,$y,[int]$wait=400) {
    [FSM]::SetCursorPos($x,$y)|Out-Null
    [FSM]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
    [FSM]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds $wait
}
function Capture-Label($label) {
    [FSM]::GetWindowRect($target,[ref]$rect)|Out-Null
    $w2=$rect.Right-$rect.Left; $h2=$rect.Bottom-$rect.Top
    $bmp=New-Object System.Drawing.Bitmap($w2,$h2)
    $g=[System.Drawing.Graphics]::FromImage($bmp)
    $g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
    $path=$env:TEMP+"\oim_fsm_"+$label+".png"
    $bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose()
    Write-Output $path
}

# The toolbar shortcut tabs are at top of content area
# From screenshots: "Process automation" ~42%, "Configuration parameters" ~52%, "List-Editor" ~62%, "Sche..." ~72%
# Click "Sche..." tab (rightmost visible shortcut)
Click-At ($L + [int]($W*0.72)) ($T + 55) 800
Capture-Label "01_sche_tab"

# Click "List-Editor" tab
Click-At ($L + [int]($W*0.62)) ($T + 55) 800
Capture-Label "02_listeditor_tab"

# Now click "New mail template" button (leftmost tab - roughly 28-32%)
# Try a range of x positions to hit it
Click-At ($L + [int]($W*0.28)) ($T + 55) 800
Capture-Label "03_newmail_btn"

# Try the Schema menu in the menu bar
Click-At ($L + [int]($W*0.09)) ($T + 28) 800
Capture-Label "04_schema_menu"

# Press Escape to close menu
[System.Windows.Forms.SendKeys]::SendWait("{ESC}")
Start-Sleep -Milliseconds 300

# Click in nav area and scroll to very top to see Base Data root
$navX = $L + 60
Click-At $navX ($T + 150) 300
# Use Ctrl+Home to go to absolute top of nav tree
[System.Windows.Forms.SendKeys]::SendWait("^{HOME}")
Start-Sleep -Milliseconds 500
Capture-Label "05_nav_absolute_top"

# Expand node at top (Base Data or first node)
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Milliseconds 400
Capture-Label "06_first_node_expanded"

# Walk down through sub-items slowly
for($i=1;$i -le 15;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 80
}
Capture-Label "07_basedata_items"

# Keep walking
for($i=1;$i -le 15;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 80
}
Capture-Label "08_more_items"
