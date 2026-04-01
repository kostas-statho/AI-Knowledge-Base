# ----------------------------------------------
# OpenAI helper
# ----------------------------------------------
function Invoke-OpenAI($apiKey, $systemMsg, $userMsg) {
    $body = @{
        model      = 'gpt-4.1'
        messages   = @(
            @{ role = 'system'; content = $systemMsg },
            @{ role = 'user';   content = $userMsg   }
        )
        max_tokens = 1500
    } | ConvertTo-Json -Depth 5

    $wc = New-Object System.Net.WebClient
    $wc.Encoding = [System.Text.Encoding]::UTF8
    $wc.Headers.Add('Authorization', "Bearer $apiKey")
    $wc.Headers.Add('Content-Type', 'application/json')
    return ($wc.UploadString('https://api.openai.com/v1/chat/completions', $body) | ConvertFrom-Json).choices[0].message.content
}

# Shared runspace scriptblock — used by all tabs via Invoke-Async.
# Params: ApiKey, Model, SystemMsg, UserMsg, MaxTokens
$Script:ApiCallScript = {
    param([string]$ApiKey, [string]$Model, [string]$SystemMsg, [string]$UserMsg, [int]$MaxTokens)

    $body = @{
        model     = $Model
        messages  = @(
            @{ role = 'system'; content = $SystemMsg },
            @{ role = 'user';   content = $UserMsg   }
        )
        max_tokens = $MaxTokens
    } | ConvertTo-Json -Depth 5

    $maxRetry = 3; $delay = 2; $raw = $null
    for ($attempt = 0; $attempt -lt $maxRetry; $attempt++) {
        $wc = New-Object System.Net.WebClient
        $wc.Encoding = [System.Text.Encoding]::UTF8
        $wc.Headers.Add('Authorization', "Bearer $ApiKey")
        $wc.Headers.Add('Content-Type', 'application/json')
        try {
            $raw = $wc.UploadString('https://api.openai.com/v1/chat/completions', $body)
            break
        } catch [System.Net.WebException] {
            $sc = [int]$_.Exception.Response.StatusCode
            if ($sc -eq 429 -and $attempt -lt ($maxRetry - 1)) {
                Start-Sleep -Seconds $delay
                $delay = [Math]::Min($delay * 2, 30)
            } else { throw }
        }
    }
    return ($raw | ConvertFrom-Json).choices[0].message.content
}

function Parse-Json($raw) {
    $clean = ($raw -replace '(?s)```json', '' -replace '(?s)```', '').Trim()
    return $clean | ConvertFrom-Json
}
