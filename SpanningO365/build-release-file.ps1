# Zip module build script
# Run from SB365-Powershell\SpanningO365
#Get the version of the module
$moduleData = Import-PowerShellDataFile -Path ".\SpanningO365.psd1" -ErrorAction Stop
$moduleVersion = $moduleData.ModuleVersion

# Create a release folder
$releaseDir = "..\release"
$ModuleName = "SpanningO365"

$releaseFolder = New-Item -Path $releaseDir -Name "SpanningO365-v$($moduleData.ModuleVersion)-full" -ItemType "directory" -ErrorAction Stop

# Create the Module Folder
$moduleFolder = New-Item -Path $releaseFolder.FullName -Name "SpanningO365" -ItemType "directory"
$versionFolder = New-Item -Path $moduleFolder.FullName -Name "$($moduleData.ModuleVersion)" -ItemType "directory"
# Copy the project
Copy-Item "*" -Destination $versionFolder.FullName -Recurse  -ErrorAction Stop
# Zip the archive
Compress-Archive -Path $($moduleFolder.FullName) -DestinationPath "$($releaseFolder.Parent.FullName)\$($releaseFolder.Name).zip"
#Open Explorer
Explorer $releaseFolder.Parent.FullName




