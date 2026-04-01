Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class NK {
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
$cb = [NK+EnumCB]{ param($h,$l)
    if ([NK]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [NK]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match 'Designer'){ $script:target=$h; return $false }
    }; return $true
}
[NK]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[NK]::ShowWindow($target,3)|Out-Null
[NK]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 1000

$rect = New-Object NK+RECT
[NK]::GetWindowRect($target,[ref]$rect)|Out-Null

# Click in the nav tree (far left, mid-height)
$navX = $rect.Left + 100
$navY = $rect.Top + 200
[NK]::SetCursorPos($navX,$navY)|Out-Null
[NK]::mouse_event(2,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 80
[NK]::mouse_event(4,0,0,0,[IntPtr]::Zero); Start-Sleep -Milliseconds 300

# Press End to jump to last node
[System.Windows.Forms.SendKeys]::SendWait("{END}"); Start-Sleep -Milliseconds 600

function Capture-Now($suffix) {
    [NK]::GetWindowRect($target,[ref]$rect)|Out-Null
    $w=$rect.Right-$rect.Left; $h=$rect.Bottom-$rect.Top
    $bmp=New-Object System.Drawing.Bitmap($w,$h)
    $g=[System.Drawing.Graphics]::FromImage($bmp)
    $g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
    $path=$env:TEMP+"\oim_nav_"+$suffix+".png"
    $bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose()
    Write-Output $path
}

# Capture bottom of tree
Capture-Now "end"

# Press Home to go back to top
[System.Windows.Forms.SendKeys]::SendWait("{HOME}"); Start-Sleep -Milliseconds 400
Capture-Now "top"

# Navigate: expand Base Data (click it, press Right to expand)
# Try pressing Down arrow many times to walk through all items
for($i=0;$i -lt 5;$i++){
    [System.Windows.Forms.SendKeys]::SendWait("{RIGHT}"); Start-Sleep -Milliseconds 100
    [System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 100
}
Start-Sleep -Milliseconds 400
Capture-Now "mid"
