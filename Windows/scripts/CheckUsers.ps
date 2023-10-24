# PowerShell Script to Compare Users and their Roles from Files with System and Take Actions

# Read usernames from files
$regularUsersFromFile = Get-Content -Path "./Users/regular_users.txt"
$adminUsersFromFile = Get-Content -Path "./Users/admin_users.txt"

# Function to determine the role of a user
function GetUserRole {
    param ($username)
    # Check if the user is part of the 'Administrators' group
    $isAdministrator = (Get-LocalGroupMember -Group "Administrators" | Where-Object { $_.Name -like "*\$username" }) -ne $null
    return $isAdministrator ? "Administrator" : "Regular"
}

# Function to prompt for action and execute it
function TakeAction {
    param ($username, $actualRole)
    $action = Read-Host "$username is a(n) $actualRole. (P)romote, (D)emote, (Delete), (S)kip?"
    switch ($action) {
        "P" {
            Add-LocalGroupMember -Group "Administrators" -Member $username
            Write-Host "$username has been promoted to Administrator."
        }
        "D" {
            Remove-LocalGroupMember -Group "Administrators" -Member $username
            Write-Host "$username has been demoted to Regular user."
        }
        "Delete" {
            Remove-LocalUser -Name $username
            Write-Host "$username has been deleted."
        }
        "S" {
            Write-Host "Skipped $username."
        }
    }
}

# Compare and take action
foreach ($user in $regularUsersFromFile) {
    $actualRole = GetUserRole -username $user
    if ($actualRole -eq "Regular") {
        Write-Host "$user matches as a Regular user."
    } else {
        TakeAction -username $user -actualRole $actualRole
    }
}

foreach ($user in $adminUsersFromFile) {
    $actualRole = GetUserRole -username $user
    if ($actualRole -eq "Administrator") {
        Write-Host "$user matches as an Administrator."
    } else {
        TakeAction -username $user -actualRole $actualRole
    }
}
