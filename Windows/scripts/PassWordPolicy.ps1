# Set Password Policies
$minPasswordAge = New-Timespan -Days 1
$maxPasswordAge = New-Timespan -Days 60
Set-LocalUser -Name "Administrator" -AccountNeverExpires $true -PasswordNeverExpires $true
Set-LocalUser -Name "Guest" -AccountNeverExpires $true -PasswordNeverExpires $true
Set-ADDefaultDomainPasswordPolicy -Identity "DC=your_domain,DC=com" -MinPasswordLength 14 -MinPasswordAge $minPasswordAge -MaxPasswordAge $maxPasswordAge -PasswordHistoryCount 24

# Set Account Lockout Policy
Set-ADDefaultDomainPasswordPolicy -Identity "DC=your_domain,DC=com" -LockoutThreshold 5 -LockoutDuration "00:30:00"

# Enable Password Complexity
Set-ADDefaultDomainPasswordPolicy -Identity "DC=your_domain,DC=com" -ComplexityEnabled $true

# Disable Admin Account
Disable-LocalUser -Name "Administrator"

# Disable Guest Account
Disable-LocalUser -Name "Guest"

# Force Logoff When Hours Expire
# Note: You may have to manually configure this from Group Policy

# Display a message
Write-Output "Password and Account Policies have been updated successfully."
