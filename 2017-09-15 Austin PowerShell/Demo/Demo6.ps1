# Get System drive size
gwmi win32_operatingsystem | Select systemdrive

gwmi Win32_LogicalDisk | ? deviceid -eq 'c:' | select size

Get-CimInstance -Query 'Select Size from Win32_LogicalDisk where DeviceID="C:"'

# Final code
$DiskInfo = Get-CimInstance -Query 'Select SystemDrive from win32_operatingsystem' | ForEach-Object {
    $Query = 'Select Size from Win32_LogicalDisk where DeviceID="{0}"' -f $_.SystemDrive
    Get-CimInstance -Query $Query
}

'{0} ({1} GB)' -f $DiskInfo.DeviceID, $DiskInfo.Size

'{0} ({1} GB)' -f $DiskInfo.DeviceID, ($DiskInfo.Size/1GB)

'{0} ({1} GB)' -f $DiskInfo.DeviceID, [math]::round(($DiskInfo.Size/1GB),2)