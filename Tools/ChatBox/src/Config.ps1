# $ScriptDir, $ConfigPath are set by the entry point (ChatBox.ps1).

# ----------------------------------------------
# Key management (DPAPI) — same pattern as GoalSetter
# ----------------------------------------------
function Save-ApiKey($key, $path = $ConfigPath) {
    $enc = [Convert]::ToBase64String(
        [Security.Cryptography.ProtectedData]::Protect(
            [Text.Encoding]::UTF8.GetBytes($key), $null, 'CurrentUser'))
    $cfg = if (Test-Path $path) {
        Get-Content $path -Raw | ConvertFrom-Json
    } else {
        [PSCustomObject]@{}
    }
    $cfg | Add-Member -Force NotePropertyName 'key'   -NotePropertyValue $enc
    $cfg | ConvertTo-Json | Set-Content $path -Encoding UTF8
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

# ----------------------------------------------
# Model preference — stored alongside key
# ----------------------------------------------
function Save-Model($model, $path = $ConfigPath) {
    $cfg = if (Test-Path $path) {
        Get-Content $path -Raw | ConvertFrom-Json
    } else {
        [PSCustomObject]@{}
    }
    $cfg | Add-Member -Force NotePropertyName 'model' -NotePropertyValue $model
    $cfg | ConvertTo-Json | Set-Content $path -Encoding UTF8
}

function Write-ErrorLog($msg) {
    $dir = Join-Path $ScriptDir 'logs'
    if (-not (Test-Path $dir)) { New-Item $dir -ItemType Directory | Out-Null }
    $ts = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Add-Content (Join-Path $dir 'error.log') "[$ts] $msg" -Encoding UTF8
}

function Load-Model($path = $ConfigPath) {
    if (-not (Test-Path $path)) { return 'gpt-4.1' }
    try {
        $m = (Get-Content $path -Raw | ConvertFrom-Json).model
        if ($m) { $m } else { 'gpt-4.1' }
    } catch { 'gpt-4.1' }
}
