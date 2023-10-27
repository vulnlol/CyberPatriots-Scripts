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
$updates = @(Search-Updates)

if ($updates.Count -eq 0) {
    Write-Host "No updates available."
} else {
    # Display available updates
    Write-Host "Available updates:"
    $updates | ForEach-Object { Write-Host $_.Title }

    # Prompt user for download
    $downloadChoice = Read-Host "Do you want to download these updates? (Y/N)"
    if ($downloadChoice -ieq 'Y
