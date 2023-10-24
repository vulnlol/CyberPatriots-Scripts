# PowerShell Script to Modify the Windows Registry for Security Hardening

# Ensure the script is run as an administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Output "This script must be run as an Administrator."
    Exit
}

function Set-RegistryValue {
    param (
        [string]$Path,
        [string]$Name,
        $Value
    )
    
    if (Test-Path $Path) {
        Set-ItemProperty -Path $Path -Name $Name -Value $Value
        Write-Output "Registry Modified: $Path -> $Name = $Value"
    } else {
        Write-Output "Registry Path does not exist: $Path"
    }
}

# Example of setting registry values. Repeat the line below with your specific paths, names, and values.
# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AutoInstallMinorUpdates" -Value 1

# You can convert each 'reg add' command to the 'Set-RegistryValue' format as demonstrated above.

# Here are a few examples based on your provided 'reg add' commands:

Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AutoInstallMinorUpdates" -Value 1
Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "AllocateCDRoms" -Value 1
Set-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown" -Value 1
Set-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "LimitBlankPasswordUse" -Value 1
Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 1


# Continue adding Set-RegistryValue lines for each 'reg add' command, converting the paths, names, and values accordingly.

Write-Output "Registry modifications completed."
