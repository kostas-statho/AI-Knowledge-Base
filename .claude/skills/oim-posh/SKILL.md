---
name: oim-posh
description: Generate a PowerShell script using the IdentityManager.PoSh module for OIM administration, connector management, or bulk operations.
argument-hint: "\"<description>\" [admin|connector|export]"
user-invocable: true
allowed-tools: "Read, Write, Glob"
---

Generate a PowerShell script that uses the One Identity Manager IdentityManager.PoSh module.

## Target types

| Target | Use |
|---|---|
| `admin` | OIM administration: user management, config, schema, system tasks |
| `connector` | Connector configuration, sync project setup, target system provisioning |
| `export` | Data extraction, reporting, CSV/JSON output |

## Standard script skeleton

```powershell
#Requires -Version 5.1

# Purpose: <description>
# Target:  <admin|connector|export>
# OIM-Ver: 9.3
# Added:   <YYYY-MM-DD>

# --- Connection ---
$OimServer   = "https://your-oim-server/AppServer"
$OimUser     = "viadmin"
$OimPassword = ConvertTo-SecureString "password" -AsPlainText -Force
$Credential  = New-Object System.Management.Automation.PSCredential($OimUser, $OimPassword)

Import-Module IdentityManager

Connect-IdentityManager -BaseAddress $OimServer -Credential $Credential -ErrorAction Stop
Write-Host "Connected to OIM: $OimServer"

try {
    # --- Main logic ---
    <# ... #>
}
finally {
    Disconnect-IdentityManager
    Write-Host "Disconnected."
}
```

## Key IdentityManager.PoSh commands

```powershell
# Connect / Disconnect
Connect-IdentityManager -BaseAddress <url> -Credential <cred>
Disconnect-IdentityManager

# Read entities
Get-IMObject -Type Person -Filter "IsExternal=1"
Get-IMObject -Type Person -UID "abc123"

# Create / modify
New-IMObject -Type Person -Properties @{ FirstName="John"; LastName="Doe" }
Set-IMObject -Type Person -UID "abc123" -Properties @{ Enabled=1 }

# Delete
Remove-IMObject -Type Person -UID "abc123"

# Execute a process
Invoke-IMMethod -Type Person -UID "abc123" -MethodName "StartProcess" -Parameters @{}

# Raw SQL query (read-only)
Invoke-IMQuery -QueryText "SELECT UID_Person, DisplayName FROM Person WHERE IsExternal=1"

# Configuration parameters
Get-IMConfigurationParameter -Path "Custom\MyPlugin\Setting"
Set-IMConfigurationParameter -Path "Custom\MyPlugin\Setting" -Value "NewValue"
```

## Rules

1. Always use `try/finally` with `Disconnect-IdentityManager` in `finally` block
2. Use `ConvertTo-SecureString` — never plain-text passwords in production scripts
3. Add `-ErrorAction Stop` on `Connect-IdentityManager` so failures are caught
4. Use `$OimServer` / `$OimUser` variables at top — never hardcode mid-script
5. For bulk operations, batch in chunks of 500 with `Write-Progress`
6. Output results to console AND pipe to `Export-Csv` if `export` target

## Output

Write the file to `OIM/PowerShell/Admin/` (admin), `OIM/PowerShell/Connector/` (connector), or `OIM/PowerShell/OIM_ExportTool/` (export).

State the full file path and the minimum PowerShell version required (always 5.1).
