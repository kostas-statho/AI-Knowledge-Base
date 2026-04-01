Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class MS2 {
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
$cb = [MS2+EnumCB]{ param($h,$l)
    if ([MS2]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [MS2]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match 'Designer'){ $script:target=$h; return $false }
    }; return $true
}
[MS2]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[MS2]::ShowWindow($target,3)|Out-Null
[MS2]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 700

$rect = New-Object MS2+RECT
[MS2]::GetWindowRect($target,[ref]$rect)|Out-Null
$L=$rect.Left; $T=$rect.Top

function Click-At($x,$y,[int]$wait=500) {
    [MS2]::SetCursorPos($x,$y)|Out-Null
    [MS2]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
    [MS2]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds $wait
}
function Capture-Label($label) {
    [MS2]::GetWindowRect($target,[ref]$rect)|Out-Null
    $w2=$rect.Right-$rect.Left; $h2=$rect.Bottom-$rect.Top
    $bmp=New-Object System.Drawing.Bitmap($w2,$h2)
    $g=[System.Drawing.Graphics]::FromImage($bmp)
    $g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
    $path=$env:TEMP+"\oim_ms2_"+$label+".png"
    $bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose()
    Write-Output $path
}

# First click on Base Data root item in nav to get back to standard view
# Base Data is at roughly x=85 (nav center), y=T+145
[MS2]::SetCursorPos($L+85, $T+145)|Out-Null
[MS2]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
[MS2]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 600
Capture-Label "00_base_data_click"

# Now try to open the "Database" menu (first menu item) to see all menu options
[MS2]::SetCursorPos($L+52, $T+20)|Out-Null
[MS2]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
[MS2]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 600
Capture-Label "01_database_menu"
[System.Windows.Forms.SendKeys]::SendWait("{ESC}"); Start-Sleep -Milliseconds 200

# Schema menu (second item ~x=110)
[MS2]::SetCursorPos($L+110, $T+20)|Out-Null
[MS2]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
[MS2]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 600
Capture-Label "02_schema_menu"
[System.Windows.Forms.SendKeys]::SendWait("{ESC}"); Start-Sleep -Milliseconds 200

# Options menu (~x=165)
[MS2]::SetCursorPos($L+165, $T+20)|Out-Null
[MS2]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
[MS2]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 600
Capture-Label "03_options_menu"
[System.Windows.Forms.SendKeys]::SendWait("{ESC}"); Start-Sleep -Milliseconds 200

# View menu (~x=210)
[MS2]::SetCursorPos($L+210, $T+20)|Out-Null
[MS2]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
[MS2]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 600
Capture-Label "04_view_menu"
[System.Windows.Forms.SendKeys]::SendWait("{ESC}"); Start-Sleep -Milliseconds 200
