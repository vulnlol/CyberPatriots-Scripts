# Check if the script is running with administrator privileges
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as an administrator."
    Exit
}

# List of program names to remove
$programsToRemove = @(
    "nc.exe",         # Netcat
    "plink.exe",      # PuTTY Link
    "john.exe",       # John the Ripper
    "hydra.exe",      # THC-Hydra
    "cain.exe",       # Cain & Abel
    "wireshark.exe",  # Wireshark
    "nmap.exe"        # Nmap
)

foreach ($program in $programsToRemove) {
    # Uninstall the program using PowerShellGet
    try {
        Uninstall-Program -Name $program -Force
        Write-Host "Removed program: $program"
    } catch {
        Write-Host "Failed to remove program: $program"
        Write-Host "Error: $_"
    }
}

Write-Host "Script execution complete."