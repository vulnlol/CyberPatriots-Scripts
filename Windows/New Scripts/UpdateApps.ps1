# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as an Administrator!"
    break
}

# Install Chocolatey
Write-Host "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Wait a moment after installation
Start-Sleep -Seconds 5

# Update PATH environment variable in case choco is not recognized after installation
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

# Upgrade all applications with Chocolatey
Write-Host "Updating all applications..."
choco upgrade all -y

Write-Host "All applications have been updated."
