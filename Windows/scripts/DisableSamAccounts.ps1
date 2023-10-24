# Set the key to restrict anonymous access to the SAM
function Set-RestrictAnonymousSAM {
    $keyPath = "HKLM:\System\CurrentControlSet\Control\Lsa"
    $keyName = "RestrictAnonymousSAM"
    $value = 1

    try {
        # Check if the key exists
        if (-Not (Test-Path $keyPath)) {
            New-Item -Path $keyPath -Force
        }

        # Set the value
        Set-ItemProperty -Path $keyPath -Name $keyName -Value $value
        Write-Host "Successfully set the RestrictAnonymousSAM key."
    } catch {
        Write-Host "An error occurred while setting the RestrictAnonymousSAM key: $_"
    }
}

# Prompt the user to confirm the change
$userInput = Read-Host "Do you want to restrict anonymous enumeration of SAM accounts? (Y/N)"
if ($userInput -eq "Y" -or $userInput -eq "y") {
    Set-RestrictAnonymousSAM
} else {
    Write-Host "Operation cancelled by the user."
}
