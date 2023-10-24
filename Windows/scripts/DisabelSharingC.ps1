# Get all shares from the WMI class Win32_Share
$shares = Get-WmiObject -Class Win32_Share

# Loop through each share to find shares on the C: drive
foreach ($share in $shares) {
    if ($share.Path -eq "C:\") {
        # Asking user confirmation to delete the share
        $userInput = Read-Host ("Do you want to remove the share '" + $share.Name + "' on the C: drive? (Y/N)")
        
        if ($userInput -eq "Y" -or $userInput -eq "y") {
            # Try to delete the share, and output the result
            try {
                $share.Delete()
                Write-Output ("Successfully removed the share: " + $share.Name)
            } catch {
                Write-Output ("Failed to remove the share: " + $share.Name)
            }
        }
        else {
            Write-Output ("Skipped the share: " + $share.Name)
        }
    }
}

# Verification: Get and display remaining shares to ensure the C: drive is not shared anymore
$remainingShares = Get-WmiObject -Class Win32_Share
Write-Output "Remaining Shares:"
$remainingShares | Format-Table -Property Name, Path, Description -AutoSize
