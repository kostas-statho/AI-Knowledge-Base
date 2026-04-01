param([string]$TitleContains)
Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class WinCtrl2 {
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWinCB cb, IntPtr lp);
    [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int m);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int cmd);
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
    [StructLayout(LayoutKind.Sequential)]
    public struct RECT { public int Left, Top, Right, Bottom; }
    public delegate bool EnumWinCB(IntPtr h, IntPtr l);
}
"@
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$target = [IntPtr]::Zero
$cb = [WinCtrl2+EnumWinCB]{
    param($h,$l)
    if ([WinCtrl2]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [WinCtrl2]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match [regex]::Escape($TitleContains)){
            $script:target = $h; return $false
        }
    }
    return $true
}
[WinCtrl2]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
if($target -eq [IntPtr]::Zero){ Write-Error "Not found"; exit 1 }

[WinCtrl2]::ShowWindow($target, 3)|Out-Null   # SW_MAXIMIZE
[WinCtrl2]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 1800

$rect = New-Object WinCtrl2+RECT
[WinCtrl2]::GetWindowRect($target,[ref]$rect)|Out-Null
$w = $rect.Right - $rect.Left
$h2 = $rect.Bottom - $rect.Top

$bmp = New-Object System.Drawing.Bitmap($w,$h2)
$g   = [System.Drawing.Graphics]::FromImage($bmp)
$g.CopyFromScreen($rect.Left,$rect.Top,0,0,$bmp.Size)
$ts   = (Get-Date).ToString('yyyyMMdd_HHmmss')
$path = $env:TEMP + "\oim_max_" + $ts + ".png"
$bmp.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()
Write-Output $path
