#Requires -Version 5.1
# Run this ONCE to encrypt your OpenAI API key and write config.json.
# After running, config.json is safe to leave on disk (key is DPAPI-encrypted,
# only decryptable by the same Windows user account on the same machine).

Add-Type -AssemblyName System.Security

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigPath = Join-Path $ScriptDir 'config.json'

if (Test-Path $ConfigPath) {
    $overwrite = Read-Host "config.json already exists. Overwrite? (y/N)"
    if ($overwrite -ne 'y' -and $overwrite -ne 'Y') {
        Write-Host "Cancelled." -ForegroundColor Yellow
        exit
    }
}

$secure = Read-Host "Enter your OpenAI API key" -AsSecureString
$plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure))

if (-not $plain -or -not $plain.StartsWith('sk-')) {
    Write-Host "Error: key does not look like an OpenAI API key (expected sk-...)." -ForegroundColor Red
    exit 1
}

$encrypted = [Convert]::ToBase64String(
    [Security.Cryptography.ProtectedData]::Protect(
        [Text.Encoding]::UTF8.GetBytes($plain), $null, 'CurrentUser'))

@{ key = $encrypted } | ConvertTo-Json | Set-Content -Path $ConfigPath -Encoding UTF8

Write-Host "Done. Key saved to $ConfigPath" -ForegroundColor Green
Write-Host "Run OIM_Chat.ps1 to start the assistant."
