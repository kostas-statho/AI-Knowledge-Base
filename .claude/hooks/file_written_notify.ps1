# PostToolUse hook: notifies when C# or PowerShell files are written
$json = [Console]::In.ReadToEnd()
try {
    $d = $json | ConvertFrom-Json -ErrorAction Stop
    $f = $d.tool_input.file_path
    if ($f -match '\.cs$') {
        Write-Host "`n💡 C# file written — run dotnet build to verify."
    }
    elseif ($f -match '\.(ps1|psm1)$') {
        Write-Host "`n💡 PS file written — test with: .\MainPsModule.ps1 -ZipPath ..."
    }
} catch {}
