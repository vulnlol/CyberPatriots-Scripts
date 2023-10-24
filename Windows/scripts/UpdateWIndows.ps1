# Load Update Session COM object
$updateSession = New-Object -ComObject Microsoft.Update.Session

function Search-Updates {
    $searcher = $updateSession.CreateUpdateSearcher()
    $searchResult = $searcher.Search("IsInstalled=0")
    $searchResult.Updates
}

function Download-Updates {
    param($updates)
    $downloader = $updateSession.CreateUpdateDownloader()
    $downloader.Updates = $updates
    $downloader.Download()
}

function Install-Updates {
    param($updates)
    $installer = $updateSession.CreateUpdateInstaller()
    $installer.Updates = $updates
    $installer.Install()
}

# Search for updates
$updates = Search-Updates

if ($updates.Count -eq 0) {
    Write-Host "No updates available."
} else {
    # Display available updates
    Write-Host "Available updates:"
    $updates | ForEach-Object { Write-Host $_.Title }

    # Prompt user for download
    $downloadChoice = Read-Host "Do you want to download these updates? (Y/N)"
    if ($downloadChoice -eq 'Y' -or $downloadChoice -eq 'y') {
        $downloadResult = Download-Updates -updates $updates
        Write-Host "Updates downloaded successfully."

        # Prompt user for installation
        $installChoice = Read-Host "Do you want to install these updates? (Y/N)"
        if ($installChoice -eq 'Y' -or $installChoice -eq 'y') {
            $installResult = Install-Updates -updates $updates
            Write-Host "Updates installed successfully."

            # Check if reboot is required
            if ($installResult.RebootRequired) {
                $rebootChoice = Read-Host "A reboot is required to complete the installation. Do you want to reboot now? (Y/N)"
                if ($rebootChoice -eq 'Y' -or $rebootChoice -eq 'y') {
                    Restart-Computer
                } else {
                    Write-Host "Please remember to reboot your system later to complete the update installation."
                }
            }
        }
    }
}
