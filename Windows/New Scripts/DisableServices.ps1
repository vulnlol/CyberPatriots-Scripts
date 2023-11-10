# Define services to be disabled
$services = @(
    @{
        Name = "SSH"
        ServiceName = "sshd"
    },
    @{
        Name = "Remote Desktop"
        ServiceName = "TermService"
    }
)

# Define Remote Assistance setting
$remoteAssistanceSettingPath = "HKLM:\System\CurrentControlSet\Control\Remote Assistance"
$remoteAssistanceSettingName = "fAllowToGetHelp"

# Function to disable service
function Disable-Service {
    param (
        [string]$serviceName
    )

    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

    if ($service) {
        Set-Service -Name $serviceName -StartupType Disabled -Status Stopped
        Write-Host "$serviceName is now disabled and stopped."
    } else {
        Write-Host "$serviceName not found."
    }
}

# Prompt to disable services
foreach ($service in $services) {
    $userInput = Read-Host "Do you want to disable $($service.Name)? (Y/N)"
    if ($userInput -eq "Y" -or $userInput -eq "y") {
        Disable-Service -serviceName $service.ServiceName
    }
}

# Prompt to disable Remote Assistance
$userInput = Read-Host "Do you want to disable Remote Assistance? (Y/N)"
if ($userInput -eq "Y" -or $userInput -eq "y") {
    Set-ItemProperty -Path $remoteAssistanceSettingPath -Name $remoteAssistanceSettingName -Value 0
    Write-Host "Remote Assistance is now disabled."
}
