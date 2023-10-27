# Ensure the script is run as an administrator
$currentUser = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
if (-Not ($currentUser.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))) {
    Write-Host "This script must be run as an administrator." -ForegroundColor Red
    exit
}

# Function to display available scripts
function Show-Scripts {
    $scripts = Get-ChildItem "scripts\*.ps1"
    Write-Host "Available scripts:"
    for ($i = 0; $i -lt $scripts.Count; $i++) {
        Write-Host "$($i+1). $($scripts[$i].BaseName)"
    }
    Write-Host "A. Execute all scripts"
    Write-Host
}

# Function to execute selected scripts and log the output
function Execute-Scripts {
    $choice = Read-Host "Enter the number or letter of the script you want to run"
    $scripts = Get-ChildItem "scripts\*.ps1"
    $logFile = "script_log.txt"

    if ($choice -ieq "A") {
        foreach ($script in $scripts) {
            try {
                & "scripts\$($script.Name)" 4>&1 | Out-File -Append $logFile
            } catch {
                $_ | Out-File -Append $logFile
            }
        }
    }
    elseif ($choice -match "^\d+$" -and $choice -le $scripts.Count) {
        try {
            & "scripts\$($scripts[$choice - 1].Name)" 4>&1 | Out-File -Append $logFile
        } catch {
            $_ | Out-File -Append $logFile
        }
    }
    else {
        Write-Host "Invalid choice. Please enter a valid number or 'A'." -ForegroundColor Red
    }
}

# Main loop to display the menu and get user selection
while ($true) {
    Show-Scripts
    Execute-Scripts
    $continue = Read-Host "Do you want to execute another script? (y/n)"
    if ($continue -ine "y") {
        exit
    }
}
