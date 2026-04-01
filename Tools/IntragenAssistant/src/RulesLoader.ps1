# ----------------------------------------------
# Rules and schema context loader
# ----------------------------------------------
function Get-RulesContext($settings) {
    $path = Join-Path $ScriptDir 'rules\SQL_Optimization_Rules.md'
    if (-not (Test-Path $path)) { return '(SQL_Optimization_Rules.md not found)' }
    $raw = Get-Content $path -Raw -Encoding UTF8
    $limit = if ($settings -and $settings.maxRulesChars) { [int]$settings.maxRulesChars } else { 12000 }
    if ($raw.Length -gt $limit) { $raw = $raw.Substring(0, $limit) + "`n...(truncated)" }
    return $raw
}

function Get-SchemaContext($settings) {
    $path = Join-Path $ScriptDir 'schema\Tables.md'
    if (-not (Test-Path $path)) { return '(Tables.md not found)' }
    $raw = Get-Content $path -Raw -Encoding UTF8
    $limit = if ($settings -and $settings.maxSchemaChars) { [int]$settings.maxSchemaChars } else { 4000 }
    if ($raw.Length -gt $limit) { $raw = $raw.Substring(0, $limit) + "`n...(truncated)" }
    return $raw
}

function Get-FileContent($path) {
    if (-not (Test-Path $path)) { return $null }
    return Get-Content $path -Raw -Encoding UTF8
}
