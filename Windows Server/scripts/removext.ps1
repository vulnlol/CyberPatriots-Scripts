# Specify the directory where you want to search for unauthorized scripts
$targetDirectory = "C:\Path\To\Directory"

# Specify the list of file extensions to search for
# $fileExtensions = @(".ps1", ".bat", ".vbs") Remove certain file extensions

# Iterate through each file extension and remove files
foreach ($extension in $fileExtensions) {
    $files = Get-ChildItem -Path $targetDirectory -Filter "*$extension" -File -Recurse
    foreach ($file in $files) {
        # Check if the file is unauthorized (you can add more criteria here)
        # For example, you can check for specific content or metadata to identify unauthorized scripts
        # If unauthorized, delete the file
        Remove-Item -Path $file.FullName -Force
        Write-Host "Removed unauthorized script: $($file.FullName)"
    }
}

Write-Host "Script execution complete."