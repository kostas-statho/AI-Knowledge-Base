Get-Process powershell -ErrorAction SilentlyContinue |
    Where-Object { $_.MainWindowTitle -eq 'Goal Setting Helper' } |
    Stop-Process -Force
Start-Sleep -Milliseconds 800
Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -WindowStyle Normal -File `"$PSScriptRoot\..\GoalSetter.ps1`""
Write-Host "App restarted."
