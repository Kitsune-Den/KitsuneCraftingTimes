# Zips each tier folder into dist/KitsuneCraftingTimes_<Tier>-v<version>.zip.
# Builds the zip by hand instead of Compress-Archive: Windows PowerShell 5.1 writes
# backslash entry names, which Linux dedicated servers unzip as literal filenames.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem

$root = $PSScriptRoot
$version = ([xml](Get-Content (Join-Path $root 'KitsuneCraftingTimes_Little\ModInfo.xml'))).xml.Version.value
$dist = Join-Path $root 'dist'
New-Item -ItemType Directory -Force $dist | Out-Null

foreach ($tier in 'Little', 'Medium', 'Fast', 'Faster') {
    $name = "KitsuneCraftingTimes_$tier"
    $src = Join-Path $root $name
    $zipPath = Join-Path $dist "$name-v$version.zip"
    if (Test-Path $zipPath) { Remove-Item $zipPath }

    $zip = [IO.Compression.ZipFile]::Open($zipPath, 'Create')
    try {
        foreach ($file in Get-ChildItem $src -Recurse -File) {
            $entry = $name + '/' + $file.FullName.Substring($src.Length + 1).Replace('\', '/')
            [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $file.FullName, $entry) | Out-Null
        }
    } finally {
        $zip.Dispose()
    }
    Write-Host "Built dist\$name-v$version.zip"
}
