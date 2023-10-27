# PowerShell Script to Disable UPnP Service

Function Disable-UPnPService {
    $serviceName = "upnphost"
    $displayName = "UPnP Device Host"

    # Check if the service exists
    if (Get-Service $serviceName -ErrorAction SilentlyContinue) {
        $userInput = Read-Host "Do you want to disable the $displayName service (Y/N)?"

        if ($userInput -eq "Y") {
            # Disabling the service
            Set-Service -Name $serviceName -StartupType Disabled
            Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
            Write-Host "$displayName service has been disabled."
        }
        else {
            Write-Host "$displayName service was not modified."
        }
    }
    else {
        Write-Host "$displayName service does not exist on this system."
    }
}

# Call the function to disable the UPnP service
Disable-UPnPService
