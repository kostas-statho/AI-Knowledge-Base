# Shared runspace scriptblock — used by all tabs via Invoke-Async.
# Params: ApiKey, Model, SystemMsg, UserMsg, MaxTokens, JsonMode, Messages, Temperature, TopP, Provider
$Script:ApiCallScript = {
    param(
        [string]   $ApiKey,
        [string]   $Model,
        [string]   $SystemMsg,
        [string]   $UserMsg,
        [int]      $MaxTokens,
        [bool]     $JsonMode    = $false,
        [object[]] $Messages    = $null,    # full message array for multi-turn; if set, overrides SystemMsg+UserMsg
        [double]   $Temperature = 0.1,
        [double]   $TopP        = 1.0,
        [string]   $Provider    = 'openai'  # 'openai' | 'claude' | 'grok'
    )

    if ($Messages -and $Messages.Count -gt 0) {
        $msgArray = $Messages
    } else {
        $msgArray = @(
            @{ role = 'system'; content = $SystemMsg },
            @{ role = 'user';   content = $UserMsg   }
        )
    }

    # Claude: extract system as top-level field; strip it from messages array
    $claudeSysContent = ''
    $chatMessages     = $msgArray
    if ($Provider -eq 'claude' -and $msgArray.Count -gt 0 -and $msgArray[0].role -eq 'system') {
        $claudeSysContent = $msgArray[0].content
        $chatMessages     = if ($msgArray.Count -gt 1) { @($msgArray[1..($msgArray.Count - 1)]) } else { @() }
    }

    $maxRetry = 3; $delay = 2; $raw = $null
    for ($attempt = 0; $attempt -lt $maxRetry; $attempt++) {
        $wc = New-Object System.Net.WebClient
        $wc.Encoding = [System.Text.Encoding]::UTF8
        $wc.Headers.Add('Content-Type', 'application/json')

        switch ($Provider) {
            'claude' {
                $bodyHash = @{
                    model       = $Model
                    max_tokens  = $MaxTokens
                    temperature = [Math]::Min($Temperature, 1.0)
                    messages    = $chatMessages
                }
                if ($claudeSysContent) { $bodyHash['system'] = $claudeSysContent }
                $wc.Headers.Add('x-api-key', $ApiKey)
                $wc.Headers.Add('anthropic-version', '2023-06-01')
                $endpoint = 'https://api.anthropic.com/v1/messages'
            }
            'grok' {
                $bodyHash = @{
                    model                 = $Model
                    messages              = $msgArray
                    max_completion_tokens = $MaxTokens
                    temperature           = $Temperature
                    top_p                 = $TopP
                }
                if ($JsonMode) { $bodyHash['response_format'] = @{ type = 'json_object' } }
                $wc.Headers.Add('Authorization', "Bearer $ApiKey")
                $endpoint = 'https://api.x.ai/v1/chat/completions'
            }
            default {  # 'openai'
                $bodyHash = @{
                    model       = $Model
                    messages    = $msgArray
                    max_tokens  = $MaxTokens
                    temperature = $Temperature
                    top_p       = $TopP
                }
                if ($JsonMode) { $bodyHash['response_format'] = @{ type = 'json_object' } }
                $wc.Headers.Add('Authorization', "Bearer $ApiKey")
                $endpoint = 'https://api.openai.com/v1/chat/completions'
            }
        }

        $body = $bodyHash | ConvertTo-Json -Depth 8
        try {
            $raw = $wc.UploadString($endpoint, $body)
            break
        } catch [System.Net.WebException] {
            $sc = [int]$_.Exception.Response.StatusCode
            if ($sc -eq 429 -and $attempt -lt ($maxRetry - 1)) {
                Start-Sleep -Seconds $delay
                $delay = [Math]::Min($delay * 2, 30)
            } else { throw }
        }
    }

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

function Parse-Json($raw) {
    $clean = ($raw -replace '(?s)```json', '' -replace '(?s)```', '').Trim()
    return $clean | ConvertFrom-Json
}
