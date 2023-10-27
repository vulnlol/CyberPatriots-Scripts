function SearchAndRemove-HackingTool {
    param(
        [string]$toolName
    )

    $userChoice = Read-Host "A suspected hacking tool named $toolName has been detected. Do you want to search and remove it? (Y/N)"
    if ($userChoice -eq 'Y' -or $userChoice -eq 'y') {
        $locations = Get-ChildItem -Path C:\ -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Name -match $toolName }
        
        foreach ($location in $locations) {
            Remove-Item $location.FullName -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "Attempting to remove suspected hacking tool at: $location"
        }

        if ($locations.Count -eq 0) {
            Write-Host "No instances of $toolName found on the system."
        }
    } else {
        Write-Host "Skipped action for hacking tool named $toolName."
    }
}

# Predefined list of suspected hacking tools, would prefer to come up with a better method for doing this.
$hackingTools = @(
    "nc.exe",         # Netcat
    "plink.exe",      # PuTTY Link
    "john.exe",       # John the Ripper
    "hydra.exe",      # THC-Hydra
    "cain.exe",       # Cain & Abel
    "wireshark.exe",  # Wireshark
    "nmap.exe"        # Nmap
)

# Attempt to search and remove each hacking tool
foreach ($tool in $hackingTools) {
    SearchAndRemove-HackingTool -toolName $tool
}