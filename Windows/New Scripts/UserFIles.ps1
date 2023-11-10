# Ensure the script is run as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script must be run as an administrator." 
    exit 1
}

# Function to list all files in user directories
function List-UserFiles {
    param (
        [string]$UserHome
    )
    
    $FilesArray = @()
    
    # Header for each user
    Write-Host "---------------------------------------"
    Write-Host "Files in $UserHome:"
    Write-Host "---------------------------------------"
    
    # Find and list files, excluding hidden directories and files, and populate array
    Get-ChildItem -Path $UserHome -File -Recurse | ForEach-Object {
        $FilesArray += $_.FullName
        Write-Host ("{0}. {1}" -f $FilesArray.Count, $_.FullName)
    }
    
    # Prompt for files to delete
    Write-Host ""
    $FilesToDelete = Read-Host "Enter the numbers of the files you want to delete (separated by space), or press Enter to skip: "
    
    if ($FilesToDelete) {
        $FilesToDelete = $FilesToDelete.Split(' ')
        foreach ($FileNumber in $FilesToDelete) {
            if ($FileNumber -ge 1 -and $FileNumber -le $FilesArray.Count) {
                $FileToDelete = $FilesArray[$FileNumber - 1]
                Remove-Item -Path $FileToDelete -Force
                Write-Host "Deleted: $FileToDelete"
            } else {
                Write-Host "Invalid selection: $FileNumber. No such file number exists."
            }
        }
    } else {
        Write-Host "No files were deleted."
    }
}

# Loop through home directories
$UserDirectories = Get-ChildItem -Path "C:\Users" -Directory
foreach ($UserDirectory in $UserDirectories) {
    $UserHome = $UserDirectory.FullName
    List-UserFiles -UserHome $UserHome
}
