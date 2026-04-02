<#
.SYNOPSIS
    Headless backend test suite for Person Assistant — 34 automated tests.
.DESCRIPTION
    Tests 7 groups without launching the GUI or making real API calls.
    Uses mock JSON responses from tests/mock_responses/ and fixtures from tests/fixtures/.
      Group 1 — Provider Routing    (tests 01-06)
      Group 2 — Message Building     (tests 07-11)
      Group 3 — Response Parsing     (tests 12-16)
      Group 4 — Config DPAPI         (tests 17-20)
      Group 5 — Eval History         (tests 21-25)
      Group 6 — SQL Library          (tests 26-29)
      Group 7 — Parse-Json           (tests 30-34)
.EXAMPLE
    .\Test-Backend.ps1
#>

Add-Type -AssemblyName System.Security
Set-StrictMode -Off
$ErrorActionPreference = 'Stop'

$ScriptDir   = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }
$MockDir     = Join-Path $ScriptDir 'tests\mock_responses'
$FixtureDir  = Join-Path $ScriptDir 'tests\fixtures'
$TempDir     = Join-Path $env:TEMP "PA_Test_$([System.IO.Path]::GetRandomFileName())"
New-Item $TempDir -ItemType Directory | Out-Null

$script:P = 0; $script:F = 0; $script:S = 0
$sw = [System.Diagnostics.Stopwatch]::new()

function Write-Result {
    param([int]$n, [string]$label, [bool]$ok, [long]$ms, [string]$extra = '')
    if ($ok) { $script:P++; $status = 'PASS'; $col = 'Green' }
    else      { $script:F++; $status = 'FAIL'; $col = 'Red'   }
    Write-Host ("[TEST {0:D2}] {1,-54} {2}  {3,4}ms  {4}" -f $n, $label, $status, $ms, $extra) -ForegroundColor $col
}

function Invoke-Test {
    param([int]$n, [string]$label, [scriptblock]$body)
    $sw.Restart()
    try {
        $result = & $body
        Write-Result $n $label ($result -ne $false) $sw.ElapsedMilliseconds
    } catch {
        Write-Result $n $label $false $sw.ElapsedMilliseconds "ERR: $($_.Exception.Message.Split([Environment]::NewLine)[0])"
    }
}

# ── Helper: mock ApiCallScript (no network) ───────────────────────────────
$MockApiCallScript = {
    param(
        [string]   $ApiKey,
        [string]   $Model,
        [string]   $SystemMsg,
        [string]   $UserMsg,
        [int]      $MaxTokens,
        [bool]     $JsonMode    = $false,
        [object[]] $Messages    = $null,
        [double]   $Temperature = 0.1,
        [double]   $TopP        = 1.0,
        [string]   $Provider    = 'openai',
        [string]   $MockRawResponse = '',   # injected — raw JSON string
        $CaptureEndpoint = $null,
        $CaptureBody     = $null
    )

    if ($Messages -and $Messages.Count -gt 0) { $msgArray = $Messages }
    else { $msgArray = @(@{ role = 'system'; content = $SystemMsg }, @{ role = 'user'; content = $UserMsg }) }

    $claudeSysContent = ''; $chatMessages = $msgArray
    if ($Provider -eq 'claude' -and $msgArray.Count -gt 0 -and $msgArray[0].role -eq 'system') {
        $claudeSysContent = $msgArray[0].content
        $chatMessages = if ($msgArray.Count -gt 1) { @($msgArray[1..($msgArray.Count - 1)]) } else { @() }
    }

    switch ($Provider) {
        'claude' {
            $bodyHash = @{ model = $Model; max_tokens = $MaxTokens; temperature = [Math]::Min($Temperature, 1.0); messages = $chatMessages }
            if ($claudeSysContent) { $bodyHash['system'] = $claudeSysContent }
            $endpoint = 'https://api.anthropic.com/v1/messages'
        }
        'grok' {
            $bodyHash = @{ model = $Model; messages = $msgArray; max_completion_tokens = $MaxTokens; temperature = $Temperature; top_p = $TopP }
            if ($JsonMode) { $bodyHash['response_format'] = @{ type = 'json_object' } }
            $endpoint = 'https://api.x.ai/v1/chat/completions'
        }
        default {
            $bodyHash = @{ model = $Model; messages = $msgArray; max_tokens = $MaxTokens; temperature = $Temperature; top_p = $TopP }
            if ($JsonMode) { $bodyHash['response_format'] = @{ type = 'json_object' } }
            $endpoint = 'https://api.openai.com/v1/chat/completions'
        }
    }

    $body = $bodyHash | ConvertTo-Json -Depth 8
    if ($CaptureEndpoint) { $CaptureEndpoint.Value = $endpoint }
    if ($CaptureBody)     { $CaptureBody.Value     = $body }

    $raw = $MockRawResponse
    if (-not $raw) { return @('', 0) }

    $parsed = $raw | ConvertFrom-Json
    if ($Provider -eq 'claude') {
        $content = $parsed.content[0].text
        $tokens  = $parsed.usage.input_tokens + $parsed.usage.output_tokens
    } else {
        if ($JsonMode -and $parsed.choices[0].finish_reason -ne 'stop') {
            throw "API returned truncated JSON (finish_reason=$($parsed.choices[0].finish_reason)). Try reducing maxTokens or simplifying the query."
        }
        $content = $parsed.choices[0].message.content
        $tokens  = $parsed.usage.total_tokens
    }
    return @($content, $tokens)
}

# ── Load source modules ───────────────────────────────────────────────────
$ConfigPath          = Join-Path $ScriptDir 'config.json'
$AnthropicConfigPath = Join-Path $ScriptDir 'config_anthropic.json'
$GrokConfigPath      = Join-Path $ScriptDir 'config_grok.json'
$ProfilePath         = Join-Path $ScriptDir 'profile.json'
$OAISettingsPath     = Join-Path $ScriptDir 'openai-settings.json'
$PresentConfigPath   = Join-Path $ScriptDir 'presentation_config.json'
$PresentStylePath    = Join-Path $ScriptDir 'presentation_style.json'
$DocStylePath        = Join-Path $ScriptDir 'documentation_style.json'

. "$ScriptDir\src\Config.ps1"
. "$ScriptDir\src\OpenAI.ps1"
. "$ScriptDir\src\ProviderHelper.ps1"

# Load GlobalState (reads openai-settings.json)
$Global:Profile = [PSCustomObject]@{ name = 'Test User'; role = 'OIM Developer'; organisation = 'Test Org' }
. "$ScriptDir\src\GlobalState.ps1"

# Override with test credentials
$Global:ApiKey       = 'sk-test-openai-key'
$Global:AnthropicKey = 'sk-ant-test-key'
$Global:GrokKey      = 'xai-test-grok-key'

# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "=== Person Assistant — Backend Tests ===" -ForegroundColor Cyan
Write-Host "Root:    $ScriptDir" -ForegroundColor DarkGray
Write-Host "Mocks:   $MockDir"  -ForegroundColor DarkGray
Write-Host "Temp:    $TempDir"  -ForegroundColor DarkGray
Write-Host ""

# ────────────────────────────────────────────────────────────────────────────
Write-Host "--- G1: Provider Routing ---" -ForegroundColor DarkCyan
# ────────────────────────────────────────────────────────────────────────────

Invoke-Test 1 "providerQueryEval → openai / gpt-4o" {
    $pp = Get-ProviderParams 'providerQueryEval'
    $pp.Provider -eq 'openai' -and $pp.Model -eq 'gpt-4o' -and $pp.ApiKey -eq 'sk-test-openai-key'
}

Invoke-Test 2 "providerGoals → claude / claude-sonnet-4-6" {
    $pp = Get-ProviderParams 'providerGoals'
    $pp.Provider -eq 'claude' -and $pp.Model -eq 'claude-sonnet-4-6' -and $pp.ApiKey -eq 'sk-ant-test-key'
}

Invoke-Test 3 "providerMeeting → grok / grok-4.1-fast" {
    $pp = Get-ProviderParams 'providerMeeting'
    $pp.Provider -eq 'grok' -and $pp.Model -eq 'grok-4.1-fast' -and $pp.ApiKey -eq 'xai-test-grok-key'
}

Invoke-Test 4 "providerPresent → claude" {
    $pp = Get-ProviderParams 'providerPresent'
    $pp.Provider -eq 'claude'
}

Invoke-Test 5 "providerDocBuild → claude" {
    $pp = Get-ProviderParams 'providerDocBuild'
    $pp.Provider -eq 'claude'
}

Invoke-Test 6 "literal 'openai' override → openai / gpt-4o" {
    $pp = Get-ProviderParams 'openai'
    $pp.Provider -eq 'openai' -and $pp.Model -eq 'gpt-4o' -and $pp.ApiKey -eq 'sk-test-openai-key'
}

# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "--- G2: Message Array Building ---" -ForegroundColor DarkCyan
# ────────────────────────────────────────────────────────────────────────────

$msgs = @(@{ role = 'system'; content = 'You are a test.'; }, @{ role = 'user'; content = 'Hello.' })

Invoke-Test 7 "openai -> endpoint + max_tokens in body" {
    $ep = [ref]''; $bd = [ref]''
    $null = & $MockApiCallScript -ApiKey 'k' -Model 'gpt-4o' -SystemMsg '' -UserMsg '' -MaxTokens 100 `
        -Provider 'openai' -Messages $msgs -CaptureEndpoint $ep -CaptureBody $bd
    $body = $bd.Value | ConvertFrom-Json
    $ep.Value -like '*api.openai.com*' -and $body.max_tokens -eq 100
}

Invoke-Test 8 "claude -> anthropic endpoint + system top-level + no system in messages" {
    $ep = [ref]''; $bd = [ref]''
    $null = & $MockApiCallScript -ApiKey 'k' -Model 'claude-sonnet-4-6' -SystemMsg '' -UserMsg '' -MaxTokens 100 `
        -Provider 'claude' -Messages $msgs -CaptureEndpoint $ep -CaptureBody $bd
    $body = $bd.Value | ConvertFrom-Json
    $noSysInMessages = ($body.messages | Where-Object { $_.role -eq 'system' }).Count -eq 0
    $ep.Value -like '*anthropic.com*' -and $body.system -eq 'You are a test.' -and $noSysInMessages
}

Invoke-Test 9 "grok -> x.ai endpoint + max_completion_tokens (not max_tokens)" {
    $ep = [ref]''; $bd = [ref]''
    $null = & $MockApiCallScript -ApiKey 'k' -Model 'grok-4.1-fast' -SystemMsg '' -UserMsg '' -MaxTokens 200 `
        -Provider 'grok' -Messages $msgs -CaptureEndpoint $ep -CaptureBody $bd
    $body = $bd.Value | ConvertFrom-Json
    $ep.Value -like '*api.x.ai*' -and $body.max_completion_tokens -eq 200 -and ($null -eq $body.max_tokens)
}

Invoke-Test 10 "claude temperature 1.5 -> capped to 1.0" {
    $ep = [ref]''; $bd = [ref]''
    $null = & $MockApiCallScript -ApiKey 'k' -Model 'claude-sonnet-4-6' -SystemMsg '' -UserMsg '' -MaxTokens 100 `
        -Provider 'claude' -Messages $msgs -Temperature 1.5 -CaptureEndpoint $ep -CaptureBody $bd
    $body = $bd.Value | ConvertFrom-Json
    $body.temperature -eq 1.0
}

Invoke-Test 11 "openai JsonMode=true -> response_format.type = json_object" {
    $ep = [ref]''; $bd = [ref]''
    $null = & $MockApiCallScript -ApiKey 'k' -Model 'gpt-4o' -SystemMsg '' -UserMsg '' -MaxTokens 100 `
        -Provider 'openai' -Messages $msgs -JsonMode $true -CaptureEndpoint $ep -CaptureBody $bd
    $body = $bd.Value | ConvertFrom-Json
    $body.response_format.type -eq 'json_object'
}

# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "--- G3: Response Parsing ---" -ForegroundColor DarkCyan
# ────────────────────────────────────────────────────────────────────────────

Invoke-Test 12 "openai_chat.json → content + tokens=42" {
    $raw = Get-Content (Join-Path $MockDir 'openai_chat.json') -Raw
    $result = & $MockApiCallScript -ApiKey 'k' -Model 'gpt-4o' -SystemMsg '' -UserMsg '' -MaxTokens 100 `
        -Provider 'openai' -Messages $msgs -MockRawResponse $raw
    $result[0] -eq 'Test OpenAI response.' -and $result[1] -eq 42
}

Invoke-Test 13 "claude_chat.json → content + tokens=55 (30+25)" {
    $raw = Get-Content (Join-Path $MockDir 'claude_chat.json') -Raw
    $result = & $MockApiCallScript -ApiKey 'k' -Model 'claude-sonnet-4-6' -SystemMsg '' -UserMsg '' -MaxTokens 100 `
        -Provider 'claude' -Messages $msgs -MockRawResponse $raw
    $result[0] -eq 'Test Claude response.' -and $result[1] -eq 55
}

Invoke-Test 14 "grok_chat.json → content + tokens=38" {
    $raw = Get-Content (Join-Path $MockDir 'grok_chat.json') -Raw
    $result = & $MockApiCallScript -ApiKey 'k' -Model 'grok-4.1-fast' -SystemMsg '' -UserMsg '' -MaxTokens 100 `
        -Provider 'grok' -Messages $msgs -MockRawResponse $raw
    $result[0] -eq 'Test Grok response.' -and $result[1] -eq 38
}

Invoke-Test 15 "openai_truncated.json + JsonMode → throws truncated JSON error" {
    $raw = Get-Content (Join-Path $MockDir 'openai_truncated.json') -Raw
    try {
        & $MockApiCallScript -ApiKey 'k' -Model 'gpt-4o' -SystemMsg '' -UserMsg '' -MaxTokens 8192 `
            -Provider 'openai' -Messages $msgs -JsonMode $true -MockRawResponse $raw
        $false  # should have thrown
    } catch {
        $_.Exception.Message -like '*truncated JSON*'
    }
}

Invoke-Test 16 "openai_eval.json → Parse-Json gives .overall=78 + .dimensions.safety.score=90" {
    $raw   = Get-Content (Join-Path $MockDir 'openai_eval.json') -Raw
    $parsed = $raw | ConvertFrom-Json
    $evalJson = Parse-Json $parsed.choices[0].message.content
    $evalJson.overall -eq 78 -and $evalJson.dimensions.safety.score -eq 90
}

# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "--- G4: Config DPAPI Round-trip ---" -ForegroundColor DarkCyan
# ────────────────────────────────────────────────────────────────────────────

$tmpConfig           = Join-Path $TempDir 'config_test.json'
$tmpAnthropicConfig  = Join-Path $TempDir 'config_ant_test.json'
$tmpGrokConfig       = Join-Path $TempDir 'config_grok_test.json'
$AnthropicConfigPath = $tmpAnthropicConfig
$GrokConfigPath      = $tmpGrokConfig

Invoke-Test 17 "Save-ApiKey + Load-ApiKey round-trip" {
    Save-ApiKey 'sk-real-key-abc123' $tmpConfig
    $loaded = Load-ApiKey $tmpConfig
    $loaded -eq 'sk-real-key-abc123'
}

Invoke-Test 18 "Load-ApiKey returns null when file missing" {
    $r = Load-ApiKey (Join-Path $TempDir 'nonexistent.json')
    $null -eq $r
}

Invoke-Test 19 "Save-AnthropicKey + Load-AnthropicKey round-trip" {
    Save-AnthropicKey 'sk-ant-real-key-xyz'
    $loaded = Load-AnthropicKey $tmpAnthropicConfig
    $loaded -eq 'sk-ant-real-key-xyz'
}

Invoke-Test 20 "Load-GrokKey returns null on corrupt base64 content" {
    @{ key = 'NOT_VALID_BASE64!!!' } | ConvertTo-Json | Set-Content $tmpGrokConfig -Encoding UTF8
    $r = Load-GrokKey $tmpGrokConfig
    $null -eq $r
}

# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "--- G5: Eval History ---" -ForegroundColor DarkCyan
# ────────────────────────────────────────────────────────────────────────────

$EvalHistoryPath = Join-Path $TempDir 'eval_history.json'

function Load-EvalHistory {
    if (Test-Path $EvalHistoryPath) {
        try { return @(Get-Content $EvalHistoryPath -Raw -Encoding UTF8 | ConvertFrom-Json) }
        catch { return @() }
    }
    return @()
}
function Save-EvalHistoryEntry($sql, $overallPct, $verdict) {
    $dir = Split-Path $EvalHistoryPath
    if (-not (Test-Path $dir)) { New-Item $dir -ItemType Directory | Out-Null }
    $history = Load-EvalHistory
    $entry = [PSCustomObject]@{
        timestamp   = (Get-Date -Format 'yyyy-MM-dd HH:mm')
        sql_preview = $sql.Substring(0, [Math]::Min(100, $sql.Length)).Trim() -replace "`r`n",' ' -replace "`n",' '
        overall_pct = $overallPct
        verdict     = $verdict
        sql         = $sql
    }
    $history = @($entry) + $history | Select-Object -First 50
    $history | ConvertTo-Json -Depth 4 | Set-Content $EvalHistoryPath -Encoding UTF8
}

Invoke-Test 21 "Load-EvalHistory → empty array when file missing" {
    $h = Load-EvalHistory
    @($h).Count -eq 0
}

Invoke-Test 22 "Save-EvalHistoryEntry → creates file, one entry" {
    $sql = Get-Content (Join-Path $FixtureDir 'sample.sql') -Raw
    Save-EvalHistoryEntry $sql '78%' 'REVIEW RECOMMENDED'
    Test-Path $EvalHistoryPath
}

Invoke-Test 23 "Entry has correct fields: timestamp, sql_preview, overall_pct, verdict, sql" {
    $h = Load-EvalHistory
    $e = $h[0]
    $e.timestamp -and $e.sql_preview -and $e.overall_pct -eq '78%' -and $e.verdict -eq 'REVIEW RECOMMENDED' -and $e.sql
}

Invoke-Test 24 "sql_preview truncated to 100 chars from long SQL" {
    $longSql = 'SELECT ' + ('A' * 200)
    Save-EvalHistoryEntry $longSql '90%' 'GOOD'
    $h = Load-EvalHistory
    $h[0].sql_preview.Length -le 100
}

Invoke-Test 25 "After 51 saves → only 50 entries kept" {
    Remove-Item $EvalHistoryPath -Force -EA SilentlyContinue
    for ($i = 1; $i -le 51; $i++) {
        Save-EvalHistoryEntry "SELECT $i FROM Person" "$i%" 'TEST'
    }
    $h = Load-EvalHistory
    @($h).Count -eq 50
}

# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "--- G6: SQL Library ---" -ForegroundColor DarkCyan
# ────────────────────────────────────────────────────────────────────────────

$tmpSqlLib = Join-Path $TempDir 'sql_lib'
New-Item $tmpSqlLib -ItemType Directory | Out-Null
'SELECT 1' | Set-Content (Join-Path $tmpSqlLib 'query1.sql') -Encoding UTF8
'SELECT 2' | Set-Content (Join-Path $tmpSqlLib 'query2.sql') -Encoding UTF8
New-Item (Join-Path $tmpSqlLib 'sub') -ItemType Directory | Out-Null
'SELECT 3' | Set-Content (Join-Path $tmpSqlLib 'sub\query3.sql') -Encoding UTF8

# Inline Refresh-SqlLibrary with a fake list (simulates the WinForms ListBox)
$Script:LibItems = [System.Collections.ArrayList]::new()
function Refresh-SqlLibrary-Test($root) {
    $Script:LibItems.Clear()
    if (-not $root -or -not (Test-Path $root)) { return }
    Get-ChildItem -Path $root -Filter '*.sql' -Recurse -ErrorAction SilentlyContinue |
        Sort-Object FullName |
        ForEach-Object {
            $rel = $_.FullName.Substring($root.Length).TrimStart('\','/')
            [void]$Script:LibItems.Add($rel)
        }
}

Invoke-Test 26 "Refresh-SqlLibrary → 3 .sql files found" {
    $Global:OAISettings.sqlLibraryPath = $tmpSqlLib
    Refresh-SqlLibrary-Test $tmpSqlLib
    $Script:LibItems.Count -eq 3
}

Invoke-Test 27 "Items use relative paths (not absolute)" {
    Refresh-SqlLibrary-Test $tmpSqlLib
    $allRelative = ($Script:LibItems | Where-Object { $_ -notmatch '^[A-Za-z]:\\' }).Count -eq $Script:LibItems.Count
    $allRelative -and ($Script:LibItems | Where-Object { $_ -like '*query*' }).Count -eq 3
}

Invoke-Test 28 "Empty sqlLibraryPath → list stays empty" {
    Refresh-SqlLibrary-Test ''
    $Script:LibItems.Count -eq 0
}

Invoke-Test 29 "Non-existent path → silently returns, list stays empty" {
    Refresh-SqlLibrary-Test 'C:\DoesNotExist\AtAll'
    $Script:LibItems.Count -eq 0
}

# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "--- G7: Parse-Json ---" -ForegroundColor DarkCyan
# ────────────────────────────────────────────────────────────────────────────

Invoke-Test 30 "Parse-Json strips ```json fence" {
    $raw = "``````json`n{`"a`":1}`n``````"
    $r = Parse-Json $raw
    $r.a -eq 1
}

Invoke-Test 31 "Parse-Json strips plain ``` fence" {
    $raw = "``````{`"b`":2}``````"
    $r = Parse-Json $raw
    $r.b -eq 2
}

Invoke-Test 32 "Parse-Json handles clean JSON (no fences)" {
    $r = Parse-Json '{"c":3}'
    $r.c -eq 3
}

Invoke-Test 33 "Parse-Json on real eval fixture → .overall=78, .dimensions.safety.score=90" {
    $rawResponse = Get-Content (Join-Path $MockDir 'openai_eval.json') -Raw
    $content = ($rawResponse | ConvertFrom-Json).choices[0].message.content
    $eval = Parse-Json $content
    $eval.overall -eq 78 -and $eval.dimensions.safety.score -eq 90
}

Invoke-Test 34 "Parse-Json on malformed JSON → throws" {
    try { Parse-Json '{not valid json {{'; $false }
    catch { $true }
}

# ────────────────────────────────────────────────────────────────────────────
# Cleanup temp dir
# ────────────────────────────────────────────────────────────────────────────
try { Remove-Item $TempDir -Recurse -Force -EA SilentlyContinue } catch {}

# ────────────────────────────────────────────────────────────────────────────
# Summary
# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
$col = if ($script:F -eq 0) { 'Green' } else { 'Red' }
Write-Host (" PASSED: {0,-4} FAILED: {1,-4} SKIPPED: {2}" -f $script:P, $script:F, $script:S) -ForegroundColor $col
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

if ($script:F -gt 0) { exit 1 }
