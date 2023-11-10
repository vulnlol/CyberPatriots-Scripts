# Define the registry key path and value
$regPath = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "DisableCAD"

# Check if the registry value exists; if not, create it
if (-not (Test-Path -Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value to 0 (enabling Ctrl+Alt+Delete requirement)
Set-ItemProperty -Path $regPath -Name $regName -Value 0

# Display a message indicating the change has been made
Write-Host "Ctrl+Alt+Delete requirement for secure logins enabled."