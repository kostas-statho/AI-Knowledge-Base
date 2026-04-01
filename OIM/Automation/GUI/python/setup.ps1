# OIM Automation — Python Setup
# Run once as Administrator to install Python and required packages
# Usage: powershell -ExecutionPolicy Bypass -File setup.ps1

$ErrorActionPreference = "Stop"

Write-Host "=== OIM Automation Setup ===" -ForegroundColor Cyan

# ── 1. Check for Python ──────────────────────────────────────────────────────
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
    Write-Host "Python not found. Downloading Python 3.12 installer..." -ForegroundColor Yellow

    $installer = "$env:TEMP\python-3.12-installer.exe"
    Invoke-WebRequest "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe" -OutFile $installer

    Write-Host "Installing Python 3.12 (all users, add to PATH)..." -ForegroundColor Yellow
    Start-Process $installer -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_pip=1" -Wait

    # Refresh PATH in current session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path","User")

    $python = Get-Command python -ErrorAction SilentlyContinue
    if (-not $python) {
        Write-Host "ERROR: Python install failed or PATH not updated. Restart this terminal and re-run." -ForegroundColor Red
        exit 1
    }
}

$ver = & python --version
Write-Host "Python found: $ver" -ForegroundColor Green

# ── 2. Install required packages ─────────────────────────────────────────────
Write-Host "Installing pywinauto and pywin32..." -ForegroundColor Cyan
& python -m pip install --upgrade pip --quiet
& python -m pip install pywinauto pywin32 --quiet

# Verify
& python -c "import pywinauto; print('pywinauto OK:', pywinauto.__version__)"
& python -c "import win32gui; print('pywin32 OK')"

Write-Host ""
Write-Host "=== Setup complete ===" -ForegroundColor Green
Write-Host "Run scripts with:" -ForegroundColor White
Write-Host "  python oim_find.py" -ForegroundColor Yellow
Write-Host "  python oim_inspect.py Designer" -ForegroundColor Yellow
