function SearchAndNotify-HackingTool {
    param(
        [string]$toolName
    )

    $locations = Get-ChildItem -Path C:\ -Recurse -ErrorAction SilentlyContinue -Filter $toolName | Where-Object { $_.Name -match $toolName }
    
    if ($locations.Count -gt 0) {
        Write-Host "Suspected hacking tool named $toolName detected at the following locations:"
        foreach ($location in $locations) {
            Write-Host $location.FullName
        }
    } else {
        Write-Host "No instances of $toolName found on the system."
    }
}

# Predefined list of suspected hacking tools
$hackingTools += @(
    # Add the list of suspected hacking tools here
)

# Attempt to search and notify for each hacking tool
foreach ($tool in $hackingTools) {
    SearchAndNotify-HackingTool -toolName $tool
}
