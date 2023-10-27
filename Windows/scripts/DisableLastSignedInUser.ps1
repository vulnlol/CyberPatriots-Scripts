# Disable showing the last signed-in user on the Windows login screen
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DontDisplayLastUserName" -Value 1 -Type DWord

# Force a Group Policy update to apply the changes immediately
gpupdate /force

# Display a message
Write-Output "The last signed-in user is now disabled on the Windows login screen."
