#Requires -Version 5.1
Add-Type -AssemblyName System.Security

$ScriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigPath = Join-Path $ScriptDir 'config.json'
$EP = 'https://api.openai.com/v1/chat/completions'

function Write-Result($n, $label, $ok, $ms, $extra = '') {
    $status = if ($ok) { 'PASS' } else { 'FAIL' }
    $color  = if ($ok) { 'Green' } else { 'Red' }
    Write-Host ("[TEST $n] {0,-42} " -f $label) -NoNewline
    Write-Host $status -ForegroundColor $color -NoNewline
    Write-Host "  (${ms}ms)  $extra"
}

Write-Host "`nGoalSetter E2E Diagnostic`n$('─' * 60)" -ForegroundColor Cyan

# ── TEST 1: Load & decrypt API key ───────────────────────────────────────────
$t = [Diagnostics.Stopwatch]::StartNew()
$apiKey = $null
try {
    $enc    = (Get-Content $ConfigPath -Raw | ConvertFrom-Json).key
    $apiKey = [Text.Encoding]::UTF8.GetString(
        [Security.Cryptography.ProtectedData]::Unprotect(
            [Convert]::FromBase64String($enc), $null, 'CurrentUser'))
    $ok = $apiKey -and $apiKey.StartsWith('sk-')
    Write-Result 1 'Load & decrypt API key' $ok $t.ElapsedMilliseconds
    if (-not $ok) { Write-Host "  key value looks wrong (not starting with sk-)" -ForegroundColor Yellow }
} catch {
    Write-Result 1 'Load & decrypt API key' $false $t.ElapsedMilliseconds
    Write-Host "  ERROR: $_" -ForegroundColor Red
    exit 1
}

# ── TEST 2: Connectivity + key validity (gpt-4o-mini) ────────────────────────
$t = [Diagnostics.Stopwatch]::StartNew()
try {
    $b = @{
        model    = 'gpt-4o-mini'
        messages = @(@{ role = 'user'; content = 'Say OK' })
        max_tokens = 10
    } | ConvertTo-Json -Depth 5
    $r = Invoke-RestMethod $EP -Method Post -TimeoutSec 30 `
         -Headers @{ Authorization = "Bearer $apiKey"; 'Content-Type' = 'application/json' } `
         -Body $b
    $reply = $r.choices[0].message.content
    Write-Result 2 'OpenAI connectivity (gpt-4o-mini)' $true $t.ElapsedMilliseconds "reply: $reply"
} catch {
    Write-Result 2 'OpenAI connectivity (gpt-4o-mini)' $false $t.ElapsedMilliseconds
    Write-Host "  ERROR: $_" -ForegroundColor Red
    exit 1
}

# ── TEST 3: o4-mini SWOT call ─────────────────────────────────────────────────
$t = [Diagnostics.Stopwatch]::StartNew()
$raw = $null
try {
    $sys = 'Return JSON exactly: {"thinking":"<your detailed step-by-step analysis reasoning>","swot":{"Strengths":[],"Weaknesses":[],"Opportunities":[],"Threats":[]}}. Each swot array contains strings. No markdown fences.'
    $usr = 'Domain: Coding. User skills: PowerShell. Interests: AI agents.'
    $b = @{
        model                 = 'o4-mini'
        messages              = @(@{ role = 'system'; content = $sys }, @{ role = 'user'; content = $usr })
        max_completion_tokens = 4000
    } | ConvertTo-Json -Depth 5
    $r   = Invoke-RestMethod $EP -Method Post -TimeoutSec 120 `
           -Headers @{ Authorization = "Bearer $apiKey"; 'Content-Type' = 'application/json' } `
           -Body $b
    $raw = $r.choices[0].message.content
    $preview = if ($raw.Length -gt 300) { $raw.Substring(0, 300) + '...' } else { $raw }
    Write-Result 3 'o4-mini SWOT call' $true $t.ElapsedMilliseconds
    Write-Host "  raw: $preview" -ForegroundColor Gray
} catch {
    Write-Result 3 'o4-mini SWOT call' $false $t.ElapsedMilliseconds
    Write-Host "  ERROR: $_" -ForegroundColor Red
    exit 1
}

# ── TEST 4: JSON parse ────────────────────────────────────────────────────────
$t = [Diagnostics.Stopwatch]::StartNew()
try {
    $clean  = ($raw -replace '(?s)```json', '' -replace '(?s)```', '').Trim()
    $parsed = $clean | ConvertFrom-Json
    $hasThinking = $null -ne $parsed.thinking -and $parsed.thinking -ne ''
    $swotKeys    = @($parsed.swot.PSObject.Properties.Name).Count
    $ok = $hasThinking -and $swotKeys -eq 4
    Write-Result 4 'JSON parse' $ok $t.ElapsedMilliseconds "thinking:$hasThinking  swot_keys:$swotKeys"
    if (-not $ok) {
        Write-Host "  parsed top-level keys: $($parsed.PSObject.Properties.Name -join ', ')" -ForegroundColor Yellow
    }
} catch {
    Write-Result 4 'JSON parse' $false $t.ElapsedMilliseconds
    Write-Host "  ERROR: $_" -ForegroundColor Red
}

Write-Host "$('─' * 60)`n" -ForegroundColor Cyan
