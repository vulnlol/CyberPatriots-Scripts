# PowerShell Script

# Ensure the script is run as administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Output "This script must be run as Administrator."
    Exit
}

function List-UserFiles {
    $users = Get-ChildItem C:\Users

    foreach ($user in $users) {
        $userPath = $user.FullName
        try {
            $files = Get-ChildItem -Path $userPath -Recurse -File -Exclude ".*" | Where-Object { $_.FullName -notmatch '\\\.' }
        
            Write-Output "---------------------------------------"
            Write-Output "Files in $userPath:"
            Write-Output "---------------------------------------"
        
            $fileList = @()
            $counter = 0
            foreach ($file in $files) {
                $counter++
                $fileList += $file.FullName
                Write-Output "$counter. $($file.FullName)"
            }

            Write-Output "---------------------------------------"
            $filesToDelete = Read-Host "Enter the numbers of the files you want to delete (separated by space), or press Enter to skip"

            if ($filesToDelete) {
                $filesToDelete.Split(' ') | ForEach-Object {
                    $index = [int]$_ - 1
                    if ($fileList[$index]) {
                        Remove-Item -Path $fileList[$index] -Force
                        Write-Output "Deleted: $($fileList[$index])"
                    }
                    else {
                        Write-Output "Invalid selection: $_. No such file number exists."
                    }
                }
            }
            else {
                Write-Output "No files were deleted."
            }
        } catch {
            Write-Output "An error occurred while processing $userPath: $_"
        }
    }
}

# Execute the function to list files and prompt for deletion
List-UserFiles
