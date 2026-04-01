Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class WE3 {
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWinCB cb, IntPtr lp);
    [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int m);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
    public delegate bool EnumWinCB(IntPtr h, IntPtr l);
}
"@
$list = [System.Collections.Generic.List[string]]::new()
$cb = [WE3+EnumWinCB]{
    param($h,$l)
    if ([WE3]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [WE3]::GetWindowText($h,$sb,256)|Out-Null
        $t=$sb.ToString().Trim()
        if($t.Length -gt 3){$list.Add($t)}
    }
    return $true
}
[WE3]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
$list | Sort-Object | Get-Unique
