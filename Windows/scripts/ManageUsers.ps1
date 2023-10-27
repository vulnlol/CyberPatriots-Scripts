# PowerShell Script to Manage Users and Groups

function List-Users {
    Get-LocalUser | ForEach-Object {
        $username = $_.Name
        $groups = (Get-LocalGroup | Where-Object { $_.Members -like "*$username*" }).Name -join ', '
        if ($_.Enabled -eq $true) {
            if ($groups -match "Administrators") {
                Write-Host "* $username is an ADMIN user. Groups: $groups"
            } else {
                Write-Host "  $username. Groups: $groups"
            }
        }
    }
    Write-Host
}

function Modify-User {
    $username = Read-Host "Enter the username to promote/demote"
    $action = Read-Host "Promote or demote? (p/d)"
    if ($action -eq "p") {
        Add-LocalGroupMember -Group "Administrators" -Member $username
        Write-Host "$username has been promoted to admin."
    } elseif ($action -eq "d") {
        Remove-LocalGroupMember -Group "Administrators" -Member $username
        Write-Host "$username has been demoted from admin."
    } else {
        Write-Host "Invalid choice. Please enter 'p' to promote or 'd' to demote."
    }
    Write-Host
}

function Manage-Group {
    $username = Read-Host "Enter the username"
    $groupName = Read-Host "Enter the group name"
    $action = Read-Host "Add or remove from group? (a/r)"

    # Check if the group exists, create if it doesn't
    if (-Not (Get-LocalGroup -Name $groupName -ErrorAction SilentlyContinue)) {
        New-LocalGroup -Name $groupName
        Write-Host "Group '$groupName' has been created."
    }

    if ($action -eq "a") {
        Add-LocalGroupMember -Group $groupName -Member $username
        Write-Host "$username has been added to $groupName."
    } elseif ($action -eq "r") {
        Remove-LocalGroupMember -Group $groupName -Member $username
        Write-Host "$username has been removed from $groupName."
    } else {
        Write-Host "Invalid choice. Please enter 'a' to add or 'r' to remove."
    }
    Write-Host
}

# Main Menu Loop
do {
    Write-Host "1. List users"
    Write-Host "2. Promote/Demote user"
    Write-Host "3. Manage user group membership"
    Write-Host "4. Exit"
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        1 { List-Users }
        2 { Modify-User }
        3 { Manage-Group }
        4 { exit }
        default { Write-Host "Invalid choice, please enter a number between 1 and 4." }
    }
} while ($true)
