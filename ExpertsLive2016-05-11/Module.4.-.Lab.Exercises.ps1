#region Exercise 1
Get-Module

Get-Module -ListAvailable

Import-Module -Name BitLocker

Get-Command -Module BitLocker
Get-BitLockerVolume

Find-Module -Name CustomizeWindows10

Find-Module -Name CustomizeWindows10 | Select-Object -ExpandProperty AdditionalMetadata
(Find-Module -Name CustomizeWindows10).AdditionalMetadata

Find-Module CustomizeWindows10 | Install-Module -Verbose -Scope AllUsers
#endregion

#region Exercise 2
function Write-HelloWorld {
    'Hello'
}

Write-Hello

'function Write-HelloWorld{"Hello World!"}' | Set-Content -Path HelloWorld.psm1
Import-Module .\HelloWorld.psm1 -Force

Write-HelloWorld

Get-Command -Name Write-HelloWorld

Get-Module -Name HelloWorld | Format-List *

#endregion

#region Exercise 3
function Get-SystemInformation {
    [CmdletBinding()]
    param(
        $ComputerName = $env:COMPUTERNAME
    )
    $Bios   = Get-CimInstance -ComputerName $ComputerName -ClassName CIM_BIOSElement
    $OSInfo = Get-CimInstance -ComputerName $ComputerName -ClassName CIM_OperatingSystem
    $Disk   = Get-CimInstance -ComputerName $ComputerName -ClassName CIM_StorageVolume -Filter "Name LIKE 'C:%'"
    
    return [pscustomobject]@{
        BiosName         = $Bios.Caption
        BiosManufacturer = $Bios.Manufacturer
        WindowsVersion   = $OSInfo.Caption
        WindowsBuild     = $OSInfo.BuildNumber
        WindowsFolder    = $OSInfo.SystemDirectory
        CDriveSizeGB     = $Disk.Capacity / 1GB -as [int]
        CDriveFreeGB     = $Disk.FreeSpace / 1GB -as [int]
    }
}
Get-SystemInformation
#endregion
