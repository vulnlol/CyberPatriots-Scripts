# PowerShell script to enable all audit policies
$auditCategories = @(
    "Account Logon",
    "Account Management",
    "Detailed Tracking",
    "DS Access",
    "Logon/Logoff",
    "Object Access",
    "Policy Change",
    "Privilege Use",
    "System",
    "Global Object Access Auditing",
    "Application Generated"
)

# Enabling all auditing options
foreach ($category in $auditCategories) {
    # Set to log success and failure events
    auditpol /set /category:"$category" /success:enable /failure:enable
}

# Verify the settings
auditpol /get /category:*
