Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class FN {
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
$cb = [FN+EnumCB]{ param($h,$l)
    if ([FN]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [FN]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match 'Designer'){ $script:target=$h; return $false }
    }; return $true
}
[FN]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[FN]::ShowWindow($target,3)|Out-Null
[FN]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 600

$rect = New-Object FN+RECT
[FN]::GetWindowRect($target,[ref]$rect)|Out-Null
$L=$rect.Left; $T=$rect.Top; $W=$rect.Right-$rect.Left; $H=$rect.Bottom-$rect.Top

function Click-At($x,$y) {
    [FN]::SetCursorPos($x,$y)|Out-Null
    [FN]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 100
    [FN]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 400
}
function Capture-Label($label) {
    [FN]::GetWindowRect($target,[ref]$rect)|Out-Null
    $w2=$rect.Right-$rect.Left; $h2=$rect.Bottom-$rect.Top
    $bmp=New-Object System.Drawing.Bitmap($w2,$h2)
    $g=[System.Drawing.Graphics]::FromImage($bmp)
    $g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
    $path=$env:TEMP+"\oim_fn_"+$label+".png"
    $bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose()
    Write-Output $path
}

# Click "New mail template" shortcut (leftmost top button ~x=30% of width)
Click-At ($L + [int]($W*0.29)) ($T + 55)
Start-Sleep -Milliseconds 600
Capture-Label "mailtemplate_nav"

# Click "Configuration parameters" shortcut (rightmost ~x=70%)
Click-At ($L + [int]($W*0.67)) ($T + 55)
Start-Sleep -Milliseconds 600
Capture-Label "configparam_nav"

# Now click "Process Automation" shortcut (~45%)
Click-At ($L + [int]($W*0.45)) ($T + 55)
Start-Sleep -Milliseconds 600
Capture-Label "processauto_nav"

# Go back to nav, expand Base Data section fully
Click-At ($L + 85) ($T + 200)
Start-Sleep -Milliseconds 300
[System.Windows.Forms.SendKeys]::SendWait("{HOME}")
Start-Sleep -Milliseconds 300
# Expand first node with RIGHT key
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Milliseconds 300
Capture-Label "basedata_expanded"
