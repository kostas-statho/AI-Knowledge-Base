param([string]$TitleContains = "Designer")
Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class WF {
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWinCB cb, IntPtr lp);
    [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int m);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int cmd);
    public delegate bool EnumWinCB(IntPtr h, IntPtr l);
}
"@

# Find Designer window
$target = [IntPtr]::Zero
$cb = [WF+EnumWinCB]{ param($h,$l)
    if ([WF]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [WF]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match [regex]::Escape($TitleContains)){ $script:target=$h; return $false }
    }
    return $true
}
[WF]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
if($target -eq [IntPtr]::Zero){ Write-Error "Window not found"; exit 1 }
[WF]::ShowWindow($target,3)|Out-Null
[WF]::SetForegroundWindow($target)|Out-Null
Start-Sleep -Milliseconds 800

# Use UI Automation to walk the tree
Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName UIAutomationTypes

$ae = [System.Windows.Automation.AutomationElement]::FromHandle($target)

# Find all TreeItem elements (nav tree nodes)
$cond = New-Object System.Windows.Automation.PropertyCondition(
    [System.Windows.Automation.AutomationElement]::ControlTypeProperty,
    [System.Windows.Automation.ControlType]::TreeItem
)
$items = $ae.FindAll([System.Windows.Automation.TreeScope]::Descendants, $cond)
Write-Host "=== DESIGNER NAVIGATION TREE NODES ==="
foreach ($item in $items) {
    $name = $item.Current.Name
    $depth = 0
    $parent = $item.TreeWalker::RawViewWalker.GetParent($item)
    while ($parent -ne $null -and $parent.Current.ControlType -eq [System.Windows.Automation.ControlType]::TreeItem) {
        $depth++
        $parent = [System.Windows.Automation.TreeWalker]::RawViewWalker.GetParent($parent)
    }
    $indent = "  " * $depth
    Write-Host "$indent$name"
}
