# ----------------------------------------------
# OpenAI API call scriptblock
# Runs inside an isolated runspace (via Invoke-Async).
# Params: ApiKey, Messages (object[]), Model (string)
# ----------------------------------------------
$Script:ApiCallScript = {
    param(
        [string]   $ApiKey,
        [object[]] $Messages,
        [string]   $Model
    )

    $body = @{
        model      = $Model
        messages   = $Messages
        max_tokens = 2000
    } | ConvertTo-Json -Depth 10 -Compress

    $maxRetry = 3; $delay = 2; $raw = $null
    for ($attempt = 0; $attempt -lt $maxRetry; $attempt++) {
        $wc          = New-Object System.Net.WebClient
        $wc.Encoding = [System.Text.Encoding]::UTF8
        $wc.Headers.Add('Authorization', "Bearer $ApiKey")
        $wc.Headers.Add('Content-Type',  'application/json')
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
