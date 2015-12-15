# Break if accidentally executed fully
break

# Setup ISE
$psISE.Options.Zoom = 160

# Unzip Mimikatz
$ExpandArchive = @{
    Path = 'C:\Users\JaapBrasser\Desktop\Demo1\mimikatz_trunk.zip'
    DestinationPath = 'C:\Users\JaapBrasser\Desktop\Demo1\mimikatz_trunk'
    Force = $true
}
Expand-Archive @ExpandArchive

# Check number of files in mimikatz folder and Run Scan on Mimikatz path
$MimikatzPath = 'C:\Users\JaapBrasser\Desktop\Demo1\mimikatz_trunk'
Get-ChildItem -Path $MimikatzPath -File -Recurse | Measure-Object
Set-Location 'C:\Program Files\Windows Defender\'
.\MpCmdRun.exe -Scan -ScanType 3 -File $MimikatzPath

# Open path mimikatz
explorer $MimikatzPath

# Show the computer status
Get-MpComputerStatus

# Detect Mimikatz
Get-MpThreat

# Show which files are affected
Get-MpThreat | Select-Object -ExpandProperty Resources

# Get additional information from the catalog
Get-MpThreat | ForEach-Object {
    Get-MpThreatCatalog -ThreatID $_.ThreatID
}

# Open online catalog with additional information
Get-MpThreat | ForEach-Object {
    $Url = 'http://www.microsoft.com/security/portal/threat/encyclopedia/Entry.aspx?Name=',
    ($_.ThreatName -replace ':','%3a' -replace '/','%2f') -join ''
    Start-Process $Url
}

# Offline screenshot of the website
mspaint.exe 'C:\Users\JaapBrasser\Desktop\Demo1\CatalogScreenShot.png'

# Remove mimikatz
Remove-MpThreat

# Check that executables have been removed
Get-ChildItem -Path $MimikatzPath -File -Recurse | Measure-Object
explorer $MimikatzPath