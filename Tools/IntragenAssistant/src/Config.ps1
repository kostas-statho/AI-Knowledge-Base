# $ScriptDir, $ConfigPath, $ProfilePath are set by the entry point (GoalSetter.ps1).

# ----------------------------------------------
# Key management (DPAPI)
# ----------------------------------------------
function Write-ErrorLog($msg) {
    $dir = Join-Path $ScriptDir 'logs'
    if (-not (Test-Path $dir)) { New-Item $dir -ItemType Directory | Out-Null }
    $ts = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Add-Content (Join-Path $dir 'error.log') "[$ts] $msg" -Encoding UTF8
}

function Save-ApiKey($key, $path = $ConfigPath) {
    $enc = [Convert]::ToBase64String(
        [Security.Cryptography.ProtectedData]::Protect(
            [Text.Encoding]::UTF8.GetBytes($key), $null, 'CurrentUser'))
    @{ key = $enc } | ConvertTo-Json | Set-Content $path -Encoding UTF8
}

function Load-ApiKey($path = $ConfigPath) {
    if (-not (Test-Path $path)) { return $null }
    try {
        $enc = (Get-Content $path -Raw | ConvertFrom-Json).key
        if (-not $enc) { return $null }
        return [Text.Encoding]::UTF8.GetString(
            [Security.Cryptography.ProtectedData]::Unprotect(
                [Convert]::FromBase64String($enc), $null, 'CurrentUser'))
    } catch { return $null }
}
