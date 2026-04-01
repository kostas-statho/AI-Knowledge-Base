<#
.SYNOPSIS
    Pre-flight test suite for IntragenAssistant — 15 automated tests.
.DESCRIPTION
    Tests 5 groups without launching the GUI or requiring user interaction:
      Group 1 — File Integrity     (tests 01-05)
      Group 2 — Configuration      (tests 06-09)
      Group 3 — Context Files      (tests 10-11)
      Group 4 — Profile            (tests 12-13)
      Group 5 — API Connectivity   (tests 14-15, skippable)
.PARAMETER SkipApi
    Skip the 2 OpenAI API connectivity tests (no network call made).
.EXAMPLE
    .\Test-IntragenAssistant.ps1
    .\Test-IntragenAssistant.ps1 -SkipApi
#>
param([switch]$SkipApi)

Add-Type -AssemblyName System.Security

$ScriptDir  = $PSScriptRoot
$script:P   = 0   # PASS count
$script:F   = 0   # FAIL count
$script:S   = 0   # SKIP count
$t          = [System.Diagnostics.Stopwatch]::new()
$decrypted  = $null   # API key plaintext, shared between tests 07/08/14/15

function Write-Result {
    param([int]$n, [string]$label, $ok, [long]$ms, [string]$extra = '')
    $status = if ($null -eq $ok) { 'SKIP' } elseif ($ok) { 'PASS' } else { 'FAIL' }
    $color  = switch ($status) { 'PASS' { 'Green' } 'FAIL' { 'Red' } 'SKIP' { 'DarkYellow' } }
    if ($ok -eq $true)  { $script:P++ }
    if ($ok -eq $false) { $script:F++ }
    if ($null -eq $ok)  { $script:S++ }
    Write-Host ("[TEST {0:D2}] {1,-52} ({2}) {3,5}ms  {4}" -f $n, $label, $status, $ms, $extra) -ForegroundColor $color
}

Write-Host ""
Write-Host "=== IntragenAssistant Pre-Flight Tests ===" -ForegroundColor Cyan
Write-Host "Root: $ScriptDir" -ForegroundColor DarkGray
if ($SkipApi) { Write-Host "Mode: -SkipApi (Group 5 will be skipped)" -ForegroundColor DarkYellow }
Write-Host ""

# ────────────────────────────────────────────────────────────────────────────
# GROUP 1 — FILE INTEGRITY
# ────────────────────────────────────────────────────────────────────────────
Write-Host "--- Group 1: File Integrity ---" -ForegroundColor DarkCyan

# TEST 01 — Required source .ps1 files
$t.Restart()
$sourceFiles = @(
    'IntragenAssistant.ps1',
    'src\Config.ps1', 'src\OpenAI.ps1', 'src\GlobalState.ps1',
    'src\Async.ps1', 'src\Profile.ps1', 'src\RulesLoader.ps1',
    'src\ui\MainForm.ps1', 'src\ui\Launch.ps1', 'src\ui\StyleTokens.ps1',
    'src\ui\SettingsDialog.ps1',
    'src\ui\Tab1-Goals.ps1', 'src\ui\Tab2-QueryEval.ps1',
    'src\ui\Tab3-Presentations.ps1', 'src\ui\Tab4-DocBuilder.ps1',
    'src\ui\Goals\Tab1-Setup.ps1', 'src\ui\Goals\Tab2-Questions.ps1',
    'src\ui\Goals\Tab3-Goals.ps1', 'src\ui\Goals\Tab4-Meeting.ps1',
    'src\ui\Goals\Tab5-Progress.ps1'
)
$missing1 = $sourceFiles | Where-Object { -not (Test-Path (Join-Path $ScriptDir $_)) }
$ok = $missing1.Count -eq 0
$extra = if ($missing1.Count) { "Missing: $($missing1 -join ', ')" } else { "$($sourceFiles.Count) files found" }
Write-Result 1 'Required source .ps1 files exist' $ok $t.ElapsedMilliseconds $extra

# TEST 02 — Required data and config files
$t.Restart()
$dataFiles = @(
    'rules\SQL_Optimization_Rules.md', 'schema\Tables.md',
    'openai-settings.json', 'profile.json',
    'presentation_style.json', 'documentation_style.json', 'presentation_config.json'
)
$missing2 = $dataFiles | Where-Object { -not (Test-Path (Join-Path $ScriptDir $_)) }
$ok = $missing2.Count -eq 0
$extra = if ($missing2.Count) { "Missing: $($missing2 -join ', ')" } else { "$($dataFiles.Count) data files found" }
Write-Result 2 'Required data and config files exist' $ok $t.ElapsedMilliseconds $extra

# TEST 03 — PowerShell syntax check (all .ps1 files)
$t.Restart()
$psFiles      = Get-ChildItem -Path $ScriptDir -Filter '*.ps1' -Recurse |
                Where-Object { $_.FullName -notlike '*\screenshots\*' }
$syntaxErrors = @()
foreach ($f in $psFiles) {
    $parseErrors = $null
    $null = [System.Management.Automation.Language.Parser]::ParseFile(
        $f.FullName, [ref]$null, [ref]$parseErrors)
    if ($parseErrors.Count) {
        $syntaxErrors += "$($f.Name): $($parseErrors[0].Message)"
    }
}
$ok = $syntaxErrors.Count -eq 0
$extra = if ($syntaxErrors.Count) { $syntaxErrors[0] } else { "$($psFiles.Count) .ps1 files OK" }
Write-Result 3 'PowerShell syntax — all .ps1 files' $ok $t.ElapsedMilliseconds $extra

# TEST 04 — JSON config files parse without error
$t.Restart()
$jsonFiles = $dataFiles | Where-Object { $_ -like '*.json' }
$badJson  = @()
foreach ($jf in $jsonFiles) {
    $path = Join-Path $ScriptDir $jf
    if (Test-Path $path) {
        try   { $null = Get-Content $path -Raw | ConvertFrom-Json }
        catch { $badJson += $jf }
    }
}
$ok = $badJson.Count -eq 0
$extra = if ($badJson.Count) { "Invalid JSON: $($badJson -join ', ')" } else { "$($jsonFiles.Count) JSON files valid" }
Write-Result 4 'JSON config files parse without error' $ok $t.ElapsedMilliseconds $extra

# TEST 05 — No deprecated WinForms API usage
$t.Restart()
$hits = @()
foreach ($f in (Get-ChildItem $ScriptDir -Filter '*.ps1' -Recurse)) {
    $content = Get-Content $f.FullName -Raw -ErrorAction SilentlyContinue
    if ($content -match '\.PlaceholderText') { $hits += $f.Name }
}
$ok = $hits.Count -eq 0
$extra = if ($hits.Count) { "Found .PlaceholderText in: $($hits -join ', ')" } else { 'No deprecated API usage detected' }
Write-Result 5 'No deprecated WinForms API usage (.PlaceholderText)' $ok $t.ElapsedMilliseconds $extra

# ────────────────────────────────────────────────────────────────────────────
# GROUP 2 — CONFIGURATION
# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "--- Group 2: Configuration ---" -ForegroundColor DarkCyan

# TEST 06 — config.json exists with apiKey field
$t.Restart()
$configPath = Join-Path $ScriptDir 'config.json'
$hasKey = $false
$cfg    = $null
try {
    if (Test-Path $configPath) {
        $cfg    = Get-Content $configPath -Raw | ConvertFrom-Json
        $hasKey = ($null -ne $cfg.apiKey) -and ($cfg.apiKey -ne '')
    }
} catch {}
$extra = if (-not $hasKey) { 'Run app → Settings → enter API key → Save All' } else { 'apiKey field present' }
Write-Result 6 'config.json exists with apiKey field' $hasKey $t.ElapsedMilliseconds $extra

# TEST 07 — API key decrypts (DPAPI)
$t.Restart()
$decryptOk = $false
try {
    if ($hasKey) {
        $bytes     = [System.Convert]::FromBase64String($cfg.apiKey)
        $plain     = [System.Security.Cryptography.ProtectedData]::Unprotect(
                         $bytes, $null,
                         [System.Security.Cryptography.DataProtectionScope]::CurrentUser)
        $decrypted = [System.Text.Encoding]::UTF8.GetString($plain)
        $decryptOk = ($decrypted.Length -gt 0)
    }
} catch { $decrypted = $null }
$extra = if (-not $decryptOk) { 'Key may have been encrypted on a different user/machine' } else { 'Decryption successful' }
Write-Result 7 'API key decrypts successfully (DPAPI)' $decryptOk $t.ElapsedMilliseconds $extra

# TEST 08 — API key format (sk-*)
$t.Restart()
$formatOk = $decryptOk -and ($decrypted -match '^sk-')
$extra = if (-not $decryptOk) { 'Skipped — decryption failed in test 07' } `
         elseif (-not $formatOk) { "Unexpected prefix: $($decrypted.Substring(0,[Math]::Min(6,$decrypted.Length)))..." } `
         else { "Format OK  length=$($decrypted.Length)" }
Write-Result 8 'API key format valid (starts with sk-)' $formatOk $t.ElapsedMilliseconds $extra

# TEST 09 — openai-settings.json values in valid ranges
$t.Restart()
$settingsOk    = $false
$settingsExtra = ''
try {
    $s = Get-Content (Join-Path $ScriptDir 'openai-settings.json') -Raw | ConvertFrom-Json
    $tempOk  = ($s.temperature -ge 0.0) -and ($s.temperature -le 1.0)
    $tokOk   = ($s.maxTokens -ge 256)   -and ($s.maxTokens -le 16384)
    $modelOk = ($null -ne $s.model) -and ($s.model -ne '')
    $settingsOk    = $tempOk -and $tokOk -and $modelOk
    $settingsExtra = "model=$($s.model)  temp=$($s.temperature)  maxTokens=$($s.maxTokens)"
    if (-not $modelOk)  { $settingsExtra = 'model field is empty' }
    if (-not $tempOk)   { $settingsExtra = "temperature out of range: $($s.temperature)" }
    if (-not $tokOk)    { $settingsExtra = "maxTokens out of range: $($s.maxTokens)" }
} catch { $settingsExtra = $_.Exception.Message }
Write-Result 9 'openai-settings.json values in valid ranges' $settingsOk $t.ElapsedMilliseconds $settingsExtra

# ────────────────────────────────────────────────────────────────────────────
# GROUP 3 — CONTEXT FILES
# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "--- Group 3: Context Files ---" -ForegroundColor DarkCyan

# TEST 10 — SQL rules file size (>=5000 chars)
$t.Restart()
$rulesPath = Join-Path $ScriptDir 'rules\SQL_Optimization_Rules.md'
$rulesLen  = 0
if (Test-Path $rulesPath) { $rulesLen = (Get-Content $rulesPath -Raw).Length }
$ok = $rulesLen -ge 5000
Write-Result 10 'SQL optimization rules file (>=5000 chars)' $ok $t.ElapsedMilliseconds "$rulesLen chars  (app loads up to 12,000)"

# TEST 11 — Schema file size (>=500 chars)
$t.Restart()
$schemaPath = Join-Path $ScriptDir 'schema\Tables.md'
$schemaLen  = 0
if (Test-Path $schemaPath) { $schemaLen = (Get-Content $schemaPath -Raw).Length }
$ok = $schemaLen -ge 500
Write-Result 11 'OIM schema file (>=500 chars)' $ok $t.ElapsedMilliseconds "$schemaLen chars  (app loads up to 4,000)"

# ────────────────────────────────────────────────────────────────────────────
# GROUP 4 — PROFILE
# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "--- Group 4: Profile ---" -ForegroundColor DarkCyan

# TEST 12 — profile.json loads and parses
$t.Restart()
$profilePath = Join-Path $ScriptDir 'profile.json'
$profile     = $null
$profileOk   = $false
try {
    if (Test-Path $profilePath) {
        $profile   = Get-Content $profilePath -Raw | ConvertFrom-Json
        $profileOk = $true
    }
} catch {}
$extra = if (-not $profileOk) { 'File missing or invalid JSON — delete and re-launch to reset' } else { 'Profile loaded OK' }
Write-Result 12 'profile.json loads and parses' $profileOk $t.ElapsedMilliseconds $extra

# TEST 13 — Required profile fields present
$t.Restart()
$required   = @('name', 'role', 'organisation', 'skills', 'interests', 'domains')
$missing13  = if ($profile) { $required | Where-Object { $null -eq $profile.$_ } } else { $required }
$fieldsOk   = $profileOk -and ($missing13.Count -eq 0)
$extra = if (-not $profileOk) { 'Skipped — profile load failed in test 12' } `
         elseif ($missing13.Count) { "Missing fields: $($missing13 -join ', ')" } `
         else { "$($required.Count)/$($required.Count) required fields present" }
Write-Result 13 'Profile has all required fields' $fieldsOk $t.ElapsedMilliseconds $extra

# ────────────────────────────────────────────────────────────────────────────
# GROUP 5 — API CONNECTIVITY  (skippable with -SkipApi)
# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
$groupHeader = if ($SkipApi) { "--- Group 5: API Connectivity (SKIPPED — omit -SkipApi to run) ---" } `
               else          { "--- Group 5: API Connectivity ---" }
Write-Host $groupHeader -ForegroundColor DarkCyan

# TEST 14 — OpenAI API reachable (gpt-4o-mini)
$t.Restart()
if ($SkipApi -or -not $decryptOk) {
    $skipReason = if ($SkipApi) { '-SkipApi set' } else { 'No decrypted key (tests 06-07 failed)' }
    Write-Result 14 'OpenAI API reachable (gpt-4o-mini)' $null $t.ElapsedMilliseconds $skipReason
} else {
    try {
        $body14 = @{
            model      = 'gpt-4o-mini'
            messages   = @(@{ role = 'user'; content = 'Say OK' })
            max_tokens = 10
        } | ConvertTo-Json -Depth 5
        $headers14 = @{ Authorization = "Bearer $decrypted"; 'Content-Type' = 'application/json' }
        $resp14    = Invoke-RestMethod -Uri 'https://api.openai.com/v1/chat/completions' `
                        -Method Post -Headers $headers14 -Body $body14 -TimeoutSec 30
        $ok = ($null -ne $resp14.choices) -and ($resp14.choices.Count -gt 0)
        $extra = if ($ok) { "Response: $($resp14.choices[0].message.content)" } else { 'No choices in response' }
        Write-Result 14 'OpenAI API reachable (gpt-4o-mini)' $ok $t.ElapsedMilliseconds $extra
    } catch {
        $msg = $_.Exception.Message
        Write-Result 14 'OpenAI API reachable (gpt-4o-mini)' $false $t.ElapsedMilliseconds "Error: $($msg.Substring(0,[Math]::Min(70,$msg.Length)))"
    }
}

# TEST 15 — JSON mode response parseable (gpt-4o)
$t.Restart()
if ($SkipApi -or -not $decryptOk) {
    $skipReason = if ($SkipApi) { '-SkipApi set' } else { 'No decrypted key' }
    Write-Result 15 'OpenAI JSON mode response parseable' $null $t.ElapsedMilliseconds $skipReason
} else {
    try {
        $body15 = @{
            model           = 'gpt-4o'
            messages        = @(
                @{ role = 'system'; content = 'Respond with valid JSON only. No markdown fences.' }
                @{ role = 'user';   content = 'Return exactly: {"status":"ok","test":15}' }
            )
            max_tokens      = 30
            response_format = @{ type = 'json_object' }
        } | ConvertTo-Json -Depth 5
        $headers15 = @{ Authorization = "Bearer $decrypted"; 'Content-Type' = 'application/json' }
        $resp15    = Invoke-RestMethod -Uri 'https://api.openai.com/v1/chat/completions' `
                        -Method Post -Headers $headers15 -Body $body15 -TimeoutSec 30
        $raw15     = $resp15.choices[0].message.content
        # Strip markdown fences if present
        $raw15     = $raw15 -replace '(?s)```json\s*', '' -replace '(?s)```\s*', ''
        $parsed15  = $raw15 | ConvertFrom-Json
        $ok = ($null -ne $parsed15)
        $extra = if ($ok) { "Keys: $($parsed15.PSObject.Properties.Name -join ', ')" } else { 'Could not parse response as JSON' }
        Write-Result 15 'OpenAI JSON mode response parseable (gpt-4o)' $ok $t.ElapsedMilliseconds $extra
    } catch {
        $msg = $_.Exception.Message
        Write-Result 15 'OpenAI JSON mode response parseable (gpt-4o)' $false $t.ElapsedMilliseconds "Error: $($msg.Substring(0,[Math]::Min(70,$msg.Length)))"
    }
}

# ────────────────────────────────────────────────────────────────────────────
# SUMMARY
# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "=== SUMMARY ===" -ForegroundColor Cyan
Write-Host ("  PASS : {0}" -f $script:P) -ForegroundColor Green
Write-Host ("  FAIL : {0}" -f $script:F) -ForegroundColor $(if ($script:F -gt 0) { 'Red' } else { 'Green' })
Write-Host ("  SKIP : {0}" -f $script:S) -ForegroundColor DarkYellow
Write-Host ""

if     ($script:F -eq 0) { Write-Host "IntragenAssistant is READY TO LAUNCH." -ForegroundColor Green }
elseif ($script:F -le 2) { Write-Host "MINOR ISSUES ($($script:F) failing). Review and fix before use." -ForegroundColor Yellow }
else                      { Write-Host "BLOCKED ($($script:F) failing tests). Fix issues before launching." -ForegroundColor Red }
Write-Host ""
