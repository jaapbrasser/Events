# Break if accidentally executed fully
break

# Test Administrative elevation
([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")

# Setup ISE
$psISE.Options.Zoom = 160

# Show the computer status
Get-MpComputerStatus

# Unzip Mimikatz
$ExpandArchive = @{
    Path = 'C:\Scripts\Demo1\mimikatz_trunk.zip'
    DestinationPath = 'C:\Scripts\Demo1\mimikatz_trunk'
    Force = $true
}
Expand-Archive @ExpandArchive

# Check number of files in mimikatz folder
$MimikatzPath = 'C:\Scripts\Demo1\mimikatz_trunk'
(Get-ChildItem -Path $MimikatzPath -File -Recurse | Measure-Object).Count

# Run Scan on Mimikatz path
Set-Location 'C:\Program Files\Windows Defender\'
.\MpCmdRun.exe -Scan -ScanType 3 -File $MimikatzPath

# Open path mimikatz
explorer $MimikatzPath

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
mspaint.exe 'C:\Scripts\Demo1\Demo1CatalogScreenShot.png'

# Remove mimikatz
Remove-MpThreat -Verbose

# Check that executables have been removed
(Get-ChildItem -Path $MimikatzPath -File -Recurse | Measure-Object).Count
explorer $MimikatzPath