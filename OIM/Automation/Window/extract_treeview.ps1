Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
using System.Collections.Generic;

public class TVExtract {
    // Window enumeration
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWinCB cb, IntPtr lp);
    [DllImport("user32.dll")] public static extern bool EnumChildWindows(IntPtr parent, EnumWinCB cb, IntPtr lp);
    [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int m);
    [DllImport("user32.dll")] public static extern int GetClassName(IntPtr h, StringBuilder s, int m);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int cmd);
    // TreeView messages
    [DllImport("user32.dll")] public static extern IntPtr SendMessage(IntPtr h, uint msg, IntPtr wp, IntPtr lp);
    [DllImport("user32.dll")] public static extern IntPtr SendMessage(IntPtr h, uint msg, IntPtr wp, ref TVITEM lp);
    // Memory for cross-process reading
    [DllImport("kernel32.dll")] public static extern IntPtr OpenProcess(uint access, bool inh, int pid);
    [DllImport("kernel32.dll")] public static extern bool ReadProcessMemory(IntPtr proc, IntPtr addr, byte[] buf, int size, out int read);
    [DllImport("kernel32.dll")] public static extern IntPtr VirtualAllocEx(IntPtr proc, IntPtr addr, int size, uint atype, uint protect);
    [DllImport("kernel32.dll")] public static extern bool VirtualFreeEx(IntPtr proc, IntPtr addr, int size, uint ftype);
    [DllImport("kernel32.dll")] public static extern bool WriteProcessMemory(IntPtr proc, IntPtr addr, byte[] buf, int size, out int written);
    [DllImport("kernel32.dll")] public static extern bool CloseHandle(IntPtr h);
    [DllImport("user32.dll")] public static extern int GetWindowThreadProcessId(IntPtr h, out int pid);

    public delegate bool EnumWinCB(IntPtr h, IntPtr l);

    [StructLayout(LayoutKind.Sequential, CharSet=CharSet.Unicode)]
    public struct TVITEM {
        public uint mask;
        public IntPtr hItem;
        public uint state, stateMask;
        public IntPtr pszText;
        public int cchTextMax;
        public int iImage, iSelectedImage, cChildren;
        public IntPtr lParam;
    }

    public const uint TVM_GETNEXTITEM    = 0x110A;
    public const uint TVM_GETITEM        = 0x113E; // TVM_GETITEMW
    public const uint TVGN_ROOT          = 0x0000;
    public const uint TVGN_NEXT          = 0x0001;
    public const uint TVGN_CHILD         = 0x0004;
    public const uint TVIF_TEXT          = 0x0001;
    public const uint TVIF_CHILDREN      = 0x0040;
    public const uint PROCESS_ALL        = 0x1F0FFF;
    public const uint MEM_COMMIT         = 0x1000;
    public const uint MEM_RELEASE        = 0x8000;
    public const uint PAGE_READWRITE     = 0x04;
}
"@

# Find Designer window
Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class WF3 {
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWinCB2 cb, IntPtr lp);
    [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int m);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int cmd);
    public delegate bool EnumWinCB2(IntPtr h, IntPtr l);
}
"@

$designerHwnd = [IntPtr]::Zero
$cb = [WF3+EnumWinCB2]{ param($h,$l)
    if ([WF3]::IsWindowVisible($h)) {
        $sb = New-Object Text.StringBuilder 256
        [WF3]::GetWindowText($h,$sb,256)|Out-Null
        if($sb.ToString() -match 'Designer'){ $script:designerHwnd=$h; return $false }
    }; return $true
}
[WF3]::EnumWindows($cb,[IntPtr]::Zero)|Out-Null
[WF3]::ShowWindow($designerHwnd,3)|Out-Null
[WF3]::SetForegroundWindow($designerHwnd)|Out-Null
Start-Sleep -Milliseconds 600

# Find all TreeView child windows
$treeviews = [System.Collections.Generic.List[IntPtr]]::new()
$childCb = [TVExtract+EnumWinCB]{ param($h,$l)
    $sb = New-Object Text.StringBuilder 64
    [TVExtract]::GetClassName($h,$sb,64)|Out-Null
    if($sb.ToString() -eq 'SysTreeView32'){ $script:treeviews.Add($h) }
    return $true
}
[TVExtract]::EnumChildWindows($designerHwnd,$childCb,[IntPtr]::Zero)|Out-Null

Write-Host "Found $($treeviews.Count) TreeView control(s)"

if($treeviews.Count -eq 0){ Write-Host "No SysTreeView32 found — Designer may use custom renderer"; exit 0 }

# Get process ID for cross-process memory
$pid2 = 0
[TVExtract]::GetWindowThreadProcessId($treeviews[0],[ref]$pid2)|Out-Null
$proc = [TVExtract]::OpenProcess([TVExtract]::PROCESS_ALL, $false, $pid2)

# Allocate remote buffer for TVITEM + text
$bufSize = 1024
$remoteBuf = [TVExtract]::VirtualAllocEx($proc,[IntPtr]::Zero,$bufSize,[TVExtract]::MEM_COMMIT,[TVExtract]::PAGE_READWRITE)
$remoteText = [IntPtr]($remoteBuf.ToInt64() + [System.Runtime.InteropServices.Marshal]::SizeOf([TVExtract+TVITEM]::new().GetType()))

function Get-TVItemText($tvHwnd, $hItem) {
    $tvi = New-Object TVExtract+TVITEM
    $tvi.mask       = [TVExtract]::TVIF_TEXT -bor [TVExtract]::TVIF_CHILDREN
    $tvi.hItem      = $hItem
    $tvi.pszText    = $remoteText
    $tvi.cchTextMax = 256
    $tviSize = [System.Runtime.InteropServices.Marshal]::SizeOf($tvi)
    $tviBytes = New-Object byte[] $tviSize
    [System.Runtime.InteropServices.Marshal]::StructureToPtr($tvi,[System.Runtime.InteropServices.Marshal]::UnsafeAddrOfPinnedArrayElement($tviBytes,0),$false)
    $written = 0
    [TVExtract]::WriteProcessMemory($proc,$remoteBuf,$tviBytes,$tviSize,[ref]$written)|Out-Null
    [TVExtract]::SendMessage($tvHwnd,[TVExtract]::TVM_GETITEM,[IntPtr]::Zero,$remoteBuf)|Out-Null
    $textBytes = New-Object byte[] 512
    $read = 0
    [TVExtract]::ReadProcessMemory($proc,$remoteText,$textBytes,512,[ref]$read)|Out-Null
    # Read back TVITEM to get cChildren
    $tviReadBytes = New-Object byte[] $tviSize
    [TVExtract]::ReadProcessMemory($proc,$remoteBuf,$tviReadBytes,$tviSize,[ref]$read)|Out-Null
    $tviRead = [System.Runtime.InteropServices.Marshal]::PtrToStructure([System.Runtime.InteropServices.Marshal]::UnsafeAddrOfPinnedArrayElement($tviReadBytes,0),[TVExtract+TVITEM])
    $text = [System.Text.Encoding]::Unicode.GetString($textBytes).TrimEnd([char]0)
    return @{ Text=$text; HasChildren=($tviRead.cChildren -gt 0) }
}

function Walk-Tree($tvHwnd, $hItem, $depth) {
    while ($hItem -ne [IntPtr]::Zero) {
        $info = Get-TVItemText $tvHwnd $hItem
        $indent = "  " * $depth
        $marker = if($info.HasChildren){"[+]"}else{"   "}
        Write-Host "$indent$marker $($info.Text)"
        # Recurse into children
        $child = [TVExtract]::SendMessage($tvHwnd,[TVExtract]::TVM_GETNEXTITEM,[IntPtr][TVExtract]::TVGN_CHILD,$hItem)
        if($child -ne [IntPtr]::Zero){ Walk-Tree $tvHwnd $child ($depth+1) }
        $hItem = [TVExtract]::SendMessage($tvHwnd,[TVExtract]::TVM_GETNEXTITEM,[IntPtr][TVExtract]::TVGN_NEXT,$hItem)
    }
}

foreach($tv in $treeviews) {
    Write-Host "`n=== TreeView @ $tv ==="
    $root = [TVExtract]::SendMessage($tv,[TVExtract]::TVM_GETNEXTITEM,[IntPtr][TVExtract]::TVGN_ROOT,[IntPtr]::Zero)
    Walk-Tree $tv $root 0
}

[TVExtract]::VirtualFreeEx($proc,$remoteBuf,0,[TVExtract]::MEM_RELEASE)|Out-Null
[TVExtract]::CloseHandle($proc)|Out-Null
