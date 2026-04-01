# =====================================================================
# Helpers
# =====================================================================

function global:New-Logger {
    param(
        [string]$FunctionName
    )
    $logDir = "C:\Logs\PowerShell"
    if (-not (Test-Path $logDir)) { New-Item -Path $logDir -ItemType Directory | Out-Null }
    $path = Join-Path $logDir ("{0}_{1}.log" -f $FunctionName,(Get-Date -Format "yyyyMMdd_HHmmss"))
    return {
        param([ValidateSet("INFO","DEBUG","TRACE","ERROR")][string]$Level,[string]$Message)
        $line = "{0} [{1}] {2}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"),$Level,$Message
        Add-Content -Path $path -Value $line
    }
}

function global:Get-ConnectionString {
    param(
        [string]$SqlServer,
        [string]$SqlDatabase,
        [string]$username,
        [string]$password
    )
    return "Server=$SqlServer;Database=$SqlDatabase;User Id=$username;Password=$password;"
}

# =====================================================================
# Get functions (already using $query)
# =====================================================================

function global:Get-Users {
    param(
        [string]$SqlServer,
        [string]$SqlDatabase,
        [string]$username,
        [string]$password,
        [string]$UserID
    )

    $ObjectClass = "[dbo].[User]"
    if (($UserID -ne $null) -and ($UserID.Length -ge 1)) { 
        $query = "SELECT * FROM $($ObjectClass) WHERE UserID = '$($UserID)'"
    } else {
        $query = "SELECT * FROM $($ObjectClass) ORDER BY UserID DESC"
    }

    $cn = New-Object System.Data.SqlClient.SqlConnection (Get-ConnectionString $SqlServer $SqlDatabase $username $password)
    $cn.Open()
    $cmd = $cn.CreateCommand()
    $cmd.CommandText = $query
    $r = $cmd.ExecuteReader()
    $rows = @()
    while ($r.Read()) {
        $rows += [PSCustomObject]@{
            UserID        = $r["UserID"]
            FirstName     = $r["FirstName"]
            LastName      = $r["LastName"]
            EmailAddress  = $r["EmailAddress"]
            JobDescription= $r["JobDescription"]
        }
    }
    $cn.Close()
    return $rows
}

function global:Get-Roles {
    param(
        [string]$SqlServer,
        [string]$SqlDatabase,
        [string]$username,
        [string]$password,
        [string]$RoleID
    )

    $ObjectClass = "[dbo].[Role]"
    if (($RoleID -ne $null) -and ($RoleID.Length -ge 1)) { 
        $query = "SELECT * FROM $($ObjectClass) WHERE RoleID = '$($RoleID)'"
    } else {
        $query = "SELECT * FROM $($ObjectClass) ORDER BY RoleID DESC"
    }

    $cn = New-Object System.Data.SqlClient.SqlConnection (Get-ConnectionString $SqlServer $SqlDatabase $username $password)
    $cn.Open()
    $cmd = $cn.CreateCommand()
    $cmd.CommandText = $query
    $r = $cmd.ExecuteReader()
    $rows = @()
    while ($r.Read()) {
        $rows += [PSCustomObject]@{
            RoleID   = $r["RoleID"]
            RoleName = $r["RoleName"]
        }
    }
    $cn.Close()
    return $rows
}

function global:Get-UserInRole {
    param(
        [string]$SqlServer,
        [string]$SqlDatabase,
        [string]$username,
        [string]$password,
        [string]$UserID,
        [string]$RoleID
    )

    $ObjectClass = "[dbo].[UserInRole]"
    if (($UserID -ne $null) -and ($UserID.Length -ge 1) -and ($RoleID -ne $null) -and ($RoleID.Length -ge 1)) {
        $query = "SELECT * FROM $($ObjectClass) WHERE UserID = '$($UserID)' AND RoleID = '$($RoleID)'"
    } elseif (($UserID -ne $null) -and ($UserID.Length -ge 1)) {
        $query = "SELECT * FROM $($ObjectClass) WHERE UserID = '$($UserID)' ORDER BY RoleID DESC"
    } elseif (($RoleID -ne $null) -and ($RoleID.Length -ge 1)) {
        $query = "SELECT * FROM $($ObjectClass) WHERE RoleID = '$($RoleID)' ORDER BY UserID DESC"
    } else {
        $query = "SELECT * FROM $($ObjectClass) ORDER BY UserID DESC, RoleID DESC"
    }

    $cn = New-Object System.Data.SqlClient.SqlConnection (Get-ConnectionString $SqlServer $SqlDatabase $username $password)
    $cn.Open()
    $cmd = $cn.CreateCommand()
    $cmd.CommandText = $query
    $r = $cmd.ExecuteReader()
    $rows = @()
    while ($r.Read()) {
        $rows += [PSCustomObject]@{
            UserID = $r["UserID"]
            RoleID = $r["RoleID"]
        }
    }
    $cn.Close()
    if ($rows -ne $null)  { 
        return $rows
    } else {
        return ""
    }
    
}

function global:Create-User {
    param(
        [string]$SqlServer,
        [string]$SqlDatabase,
        [string]$username,
        [string]$password,
        [int]$UserID = 0,
        [string]$FirstName,
        [string]$LastName,
        [string]$EmailAddress,
        [string]$JobDescription
    )

    $cn = New-Object System.Data.SqlClient.SqlConnection (Get-ConnectionString $SqlServer $SqlDatabase $username $password)
    $cn.Open()
    $cmd = $cn.CreateCommand()

    if ($UserID -eq 0) {
        # Find first available positive UserID
        $cmd.CommandText = @"
            SELECT ISNULL(
                (SELECT MIN(t.UserID + 1)
                 FROM [dbo].[User] t
                 LEFT JOIN [dbo].[User] t2 ON t2.UserID = t.UserID + 1
                 WHERE t2.UserID IS NULL),1)
"@
        $UserID = $cmd.ExecuteScalar()
    }

    $query = "INSERT INTO [dbo].[User](UserID,FirstName,LastName,EmailAddress,JobDescription) 
              VALUES ('$($UserID)','$($FirstName)','$($LastName)','$($EmailAddress)','$($JobDescription)')"

    $cmd.CommandText = $query
    $rows = $cmd.ExecuteNonQuery()
    $cn.Close()
    return ($rows -gt 0)
}

function global:Create-Role {
    param(
        [string]$SqlServer,
        [string]$SqlDatabase,
        [string]$username,
        [string]$password,
        [int]$RoleID = 0,
        [string]$RoleName
    )

    $cn = New-Object System.Data.SqlClient.SqlConnection (Get-ConnectionString $SqlServer $SqlDatabase $username $password)
    $cn.Open()
    $cmd = $cn.CreateCommand()

    if ($RoleID -eq 0) {
        # Find first available positive UserID
        $cmd.CommandText = @"
            SELECT ISNULL(
                (SELECT MIN(t.RoleID + 1)
                 FROM [dbo].[Role] t
                 LEFT JOIN [dbo].[Role] t2 ON t2.RoleID = t.RoleID + 1
                 WHERE t2.RoleID IS NULL),1)
"@
        $RoleID = $cmd.ExecuteScalar()
    }

    $query = "INSERT INTO [dbo].[Role](RoleID,RoleName) 
              VALUES ('$($RoleID)','$($RoleName)')"

    $cmd.CommandText = $query
    $rows = $cmd.ExecuteNonQuery()
    $cn.Close()
    return ($rows -gt 0)
}


function global:Create-UserInRole {
    param(
        [string]$SqlServer,
        [string]$SqlDatabase,
        [string]$username,
        [string]$password,
        [int]$UserID,
        [int]$RoleID
    )
    $query = "INSERT INTO [dbo].[UserInRole](UserID,RoleID) VALUES ('$($UserID)','$($RoleID)')"
    $cn = New-Object System.Data.SqlClient.SqlConnection (Get-ConnectionString $SqlServer $SqlDatabase $username $password)
    $cn.Open()
    $cmd = $cn.CreateCommand()
    $cmd.CommandText = $query
    $rows = $cmd.ExecuteNonQuery()
    $cn.Close()
    return ($rows -gt 0)
}

function global:Modify-User {
    param(
        [string]$SqlServer,
        [string]$SqlDatabase,
        [string]$username,
        [string]$password,
        [int]$UserID,
        [string]$FirstName,
        [string]$LastName,
        [string]$EmailAddress,
        [string]$JobDescription
    )
    $setParts = @()
    if ($FirstName)     { $setParts += "FirstName = '$($FirstName)'" }
    if ($LastName)      { $setParts += "LastName = '$($LastName)'" }
    if ($EmailAddress)  { $setParts += "EmailAddress = '$($EmailAddress)'" }
    if ($JobDescription){ $setParts += "JobDescription = '$($JobDescription)'" }

    if ($setParts.Count -eq 0) {
        return $false   # nothing to update
    }

    $query = "UPDATE [dbo].[User] SET " + ($setParts -join ", ") + " WHERE UserID = '$($UserID)'"
    $cn = New-Object System.Data.SqlClient.SqlConnection (Get-ConnectionString $SqlServer $SqlDatabase $username $password)
    $cn.Open()
    $cmd = $cn.CreateCommand()
    $cmd.CommandText = $query
    $rows = $cmd.ExecuteNonQuery()
    $cn.Close()
    return ($rows -gt 0)
}

function global:Delete-User {
    param(
        [string]$SqlServer,
        [string]$SqlDatabase,
        [string]$username,
        [string]$password,
        [int]$UserID
    )
    $query = "DELETE FROM [dbo].[User] WHERE UserID='$($UserID)'"
    $cn = New-Object System.Data.SqlClient.SqlConnection (Get-ConnectionString $SqlServer $SqlDatabase $username $password)
    $cn.Open()
    $cmd = $cn.CreateCommand()
    $cmd.CommandText = $query
    $rows = $cmd.ExecuteNonQuery()
    $cn.Close()
    return ($rows -gt 0)
}

function global:Delete-UserInRole {
    param([string]$SqlServer,[string]$SqlDatabase,[string]$username,[string]$password,[int]$UserID,[int]$RoleID)
    $query = "DELETE FROM [dbo].[UserInRole] WHERE UserID='$($UserID)' AND RoleID='$($RoleID)'"
    $cn = New-Object System.Data.SqlClient.SqlConnection (Get-ConnectionString $SqlServer $SqlDatabase $username $password)
    $cn.Open()
    $cmd = $cn.CreateCommand()
    $cmd.CommandText = $query
    $rows = $cmd.ExecuteNonQuery()
    $cn.Close()
    return ($rows -gt 0)
}

function global:Delete-Role {
    param (
        [string]$SqlServer,
        [string]$SqlDatabase,
        [string]$username,
        [string]$password,
        [string]$RoleID
    )

    Write-Output "Deleting role [$RoleID]..."

    $connectionString = "Server=$SqlServer;Database=$SqlDatabase;User ID=$username;Password=$password;"
    $query = @"
DELETE FROM Role WHERE RoleID = '$RoleID'
"@

    $connection = New-Object System.Data.SqlClient.SqlConnection $connectionString
    $command = New-Object System.Data.SqlClient.SqlCommand $query, $connection

    try {
        $connection.Open()
        $rowsAffected = $command.ExecuteNonQuery()
        Write-Output "Role [$RoleID] deleted successfully ($rowsAffected row(s) affected)."
    }
    catch {
        Write-Error "Error deleting role [$RoleID]: $($_.Exception.Message)"
        throw
    }
    finally {
        $connection.Close()
    }
}


