# $ScriptDir, $ConfigPath, $ProfilePath are set by the entry point (GoalSetter.ps1).

# ----------------------------------------------
# Profile persistence
# ----------------------------------------------
function Load-Profile($path = $ProfilePath) {
    if (Test-Path $path) {
        $prof = Get-Content $path -Raw -Encoding UTF8 | ConvertFrom-Json
        # Migrate legacy flat string arrays to {name, level} objects
        if (@($prof.skills).Count -gt 0 -and $prof.skills[0] -is [string]) {
            $prof.skills = @($prof.skills | ForEach-Object { [PSCustomObject]@{ name = $_; level = 'Beginner' } })
        }
        if (@($prof.interests).Count -gt 0 -and $prof.interests[0] -is [string]) {
            $prof.interests = @($prof.interests | ForEach-Object { [PSCustomObject]@{ name = $_; level = 'Beginner' } })
        }
        if (-not $prof.PSObject.Properties['domains']) {
            $prof | Add-Member -NotePropertyName 'domains' -NotePropertyValue @()
        }
        return $prof
    }
    return [PSCustomObject]@{
        name        = ''
        skills      = @()
        interests   = @()
        domains     = @()
        goals       = @()
        lastUpdated = ''
    }
}

function Save-Profile($prof, $path = $ProfilePath) {
    $prof.lastUpdated = (Get-Date -Format 'yyyy-MM-dd')
    $prof | ConvertTo-Json -Depth 10 | Set-Content $path -Encoding UTF8
}
