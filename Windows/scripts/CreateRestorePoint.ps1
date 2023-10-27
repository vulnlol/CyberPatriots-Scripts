# Check if the script is running with administrative privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Warning "This script requires administrative privileges. Please run it as an administrator."
    exit
}

# Generate a random string for the restore point name
$characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
$restorePointName = -join ((Get-Random -Count 8 -InputObject $characters.ToCharArray()))

try {
    # Create a system restore point
    Checkpoint-Computer -Description $restorePointName -RestorePointType "APPLICATION_INSTALL"
    Write-Output "System restore point '$restorePointName' created successfully."
} catch {
    Write-Error "Failed to create a system restore point: $_"
}
