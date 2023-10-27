# Run this script as an Administrator

# Ensuring Windows Defender is enabled
Set-MpPreference -DisableRealtimeMonitoring $false

# Enable network protection to prevent employees from using potentially harmful sites
Set-MpPreference -EnableNetworkProtection Enabled

# Turn on behavior monitoring
Set-MpPreference -DisableBehaviorMonitoring $false

# Enable scanning of archive files
Set-MpPreference -DisableArchiveScanning $false

# Enable scanning of removable drives during full scans
Set-MpPreference -DisableRemovableDriveScanning $false

# Setting the action to take on detected malware
Set-MpPreference -ThreatDefaultAction DefaultActions_Quarantine

# Display a message indicating the configurations have been applied
Write-Output "Windows Defender configurations have been updated and secured."

