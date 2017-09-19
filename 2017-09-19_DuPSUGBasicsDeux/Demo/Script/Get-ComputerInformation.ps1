function Get-ComputerInformation {
    # Create Hashtable
    $HashTable = @{}

    # Get hostname of the system
    $HashTable.HostName = $env:computername

    # Get the domain of the system
    $HashTable.SystemDomain = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties().DomainName
    
    # Get current build and OS version information
    $OSInfo = (Get-CimInstance -Query 'select caption,buildnumber from win32_operatingsystem')

    $HashTable.OSVersion = $OSInfo.Caption
    $HashTable.BuildNumber = $OSInfo.buildnumber

    # Get memory information
    $HashTable.Memory = '{0} GB' -f ((Get-CimInstance -Query 'Select TotalPhysicalMemory from win32_computersystem').TotalPhysicalMemory/1GB -as [int])

    # Get timezone information and current offset
    $HashTable.TimeZone = "{0} (Current offset: {1} hours)" -f (Get-TimeZone).DisplayName,
                                                               ((Get-Date)-(Get-Date).ToUniversalTime()).TotalHours

    # Get System drive size
    $DiskInfo = Get-CimInstance -Query 'Select SystemDrive from win32_operatingsystem' | ForEach-Object {
        $Query = 'Select Size from Win32_LogicalDisk where DeviceID="{0}"' -f $_.SystemDrive
        Get-CimInstance -Query $Query
    }

    $HashTable.SystemDisk = '{0} ({1} GB)' -f $DiskInfo.DeviceID, [math]::round(($DiskInfo.Size/1GB),2)

    # Find pagefile path
    $HashTable.PageFile = -join (Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\' ExistingPageFiles).ExistingPageFiles

    # Output the object
    return [pscustomobject]$HashTable
}