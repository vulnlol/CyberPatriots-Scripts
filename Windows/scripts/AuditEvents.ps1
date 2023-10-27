# Enable auditing for all categories and subcategories

# Enable all subcategories for all categories
Auditpol /set /subcategory:"*" /success:enable /failure:enable

# Display a message to inform the user about the changes
Write-Host "Audit policies have been configured to audit all events."

# Force a Group Policy update to apply the changes immediately
gpupdate /force

# Verify that auditing settings are applied
Auditpol /get /category:*

# Configure audit policies for specific files or folders (optional)
# Example: Audit access to a specific folder
# $FolderPath = "C:\Path\To\Folder"
# $AuditRule = New-Object System.Security.AccessControl.FileSystemAuditRule("Everyone", "Modify", "Success,Failure")
# $Acl = Get-Acl -Path $FolderPath
# $Acl.AddAuditRule($AuditRule)
# Set-Acl -Path $FolderPath -AclObject $Acl

# Additional comments and instructions can be added here
