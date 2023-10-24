# Enabling the firewall for Domain, Private and Public profiles
Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True

# Verify the status
Get-NetFirewallProfile -Profile Domain,Private,Public | Format-Table -Property Name,Enabled -AutoSize

# Display a confirmation message
Write-Output "Windows Firewall has been enabled on all profiles."
