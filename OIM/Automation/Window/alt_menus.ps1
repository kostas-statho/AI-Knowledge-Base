Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class AM {
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumCB cb, IntPtr lp);
    [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int m);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int cmd);
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
    [StructLayout(LayoutKind.Sequential)] public struct RECT { public int Left,Top,Right,Bottom; }
    public delegate bool EnumCB(IntPtr h, IntPtr l);
}
"@
Add-Type -AssemblyName System.Drawing, System.Windows.Forms

$target = [IntPtr]::Zero
$cb = [AM+EnumCB]{ param($h,$l)
    if ([AM]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [AM]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match 'Designer'){ $script:target=$h; return $false }
    }; return $true
}
[AM]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[AM]::ShowWindow($target,3)|Out-Null
[AM]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 800

$rect = New-Object AM+RECT
function Capture-Label($label) {
    [AM]::GetWindowRect($target,[ref]$rect)|Out-Null
    $w2=$rect.Right-$rect.Left; $h2=$rect.Bottom-$rect.Top
    $bmp=New-Object System.Drawing.Bitmap($w2,$h2)
    $g=[System.Drawing.Graphics]::FromImage($bmp)
    $g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
    $path=$env:TEMP+"\oim_am_"+$label+".png"
    $bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose()
    Write-Output $path
}

# Open each menu using F10 + arrow keys
# F10 activates menu bar
[System.Windows.Forms.SendKeys]::SendWait("{F10}"); Start-Sleep -Milliseconds 400
Capture-Label "01_menubar_active"

# First menu (Database) - press Down to open
[System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 500
Capture-Label "02_database_menu_open"
[System.Windows.Forms.SendKeys]::SendWait("{ESC}"); Start-Sleep -Milliseconds 200

# Second menu (Schema) - F10 then Right
[System.Windows.Forms.SendKeys]::SendWait("{F10}"); Start-Sleep -Milliseconds 300
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}"); Start-Sleep -Milliseconds 200
[System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 500
Capture-Label "03_schema_menu_open"
[System.Windows.Forms.SendKeys]::SendWait("{ESC}{ESC}"); Start-Sleep -Milliseconds 300

# Third menu (Options) - F10, Right, Right
[System.Windows.Forms.SendKeys]::SendWait("{F10}"); Start-Sleep -Milliseconds 300
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}{RIGHT}"); Start-Sleep -Milliseconds 200
[System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 500
Capture-Label "04_options_menu_open"
[System.Windows.Forms.SendKeys]::SendWait("{ESC}{ESC}"); Start-Sleep -Milliseconds 300

# Fourth menu (View) - F10, Right x3
[System.Windows.Forms.SendKeys]::SendWait("{F10}"); Start-Sleep -Milliseconds 300
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}{RIGHT}{RIGHT}"); Start-Sleep -Milliseconds 200
[System.Windows.Forms.SendKeys]::SendWait("{DOWN}"); Start-Sleep -Milliseconds 500
Capture-Label "05_view_menu_open"
[System.Windows.Forms.SendKeys]::SendWait("{ESC}{ESC}"); Start-Sleep -Milliseconds 300
