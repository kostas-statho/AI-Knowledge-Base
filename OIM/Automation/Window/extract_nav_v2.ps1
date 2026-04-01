param([string]$TitleContains = "Designer")
Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class WF2 {
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWinCB cb, IntPtr lp);
    [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int m);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int cmd);
    public delegate bool EnumWinCB(IntPtr h, IntPtr l);
}
"@
$target = [IntPtr]::Zero
$cb = [WF2+EnumWinCB]{ param($h,$l)
    if ([WF2]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [WF2]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match [regex]::Escape($TitleContains)){ $script:target=$h; return $false }
    }; return $true
}
[WF2]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[WF2]::ShowWindow($target,3)|Out-Null
[WF2]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 600

Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName UIAutomationTypes

$root = [System.Windows.Automation.AutomationElement]::FromHandle($target)

# Try all control types to find what the nav tree uses
$allCond = [System.Windows.Automation.Condition]::TrueCondition
$all = $root.FindAll([System.Windows.Automation.TreeScope]::Descendants, $allCond)

$types = @{}
foreach ($el in $all) {
    $ct = $el.Current.ControlType.ProgrammaticName
    if (-not $types[$ct]) { $types[$ct] = 0 }
    $types[$ct]++
}
Write-Host "=== CONTROL TYPES IN DESIGNER ==="
$types.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object { Write-Host "$($_.Value)`t$($_.Key)" }

Write-Host ""
Write-Host "=== LIST/TREE ITEMS (first 60) ==="
$cnt = 0
foreach ($el in $all) {
    $ct = $el.Current.ControlType.ProgrammaticName
    if ($ct -match 'ListItem|TreeItem|MenuItem') {
        $name = $el.Current.Name
        if ($name.Length -gt 0) {
            Write-Host "[$ct] $name"
            $cnt++
            if ($cnt -ge 60) { break }
        }
    }
}
