function Get-SysInfo {
    [cmdletbinding()]
    param(
        [string[]]$ComputerName 
    )

    Write-Verbose -Message "Attempting to gather SysInfo from $ComputerName"
    try {
        if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
            $Bios = Get-WmiObject -ComputerName $ComputerName -Class Win32_Bios -ErrorAction Stop
            $OS = Get-WmiObject -ComputerName $ComputerName -Class Win32_OperatingSystem  -ErrorAction Stop
            [pscustomobject]@{
                BiosSerial   = $Bios.SerialNumber
                OSName       = $OS.Caption
                ComputerName = $ComputerName
                Message      = $null
            }
        } else {
            [pscustomobject]@{
                BiosSerial   = $null
                OSName       = $null
                ComputerName = $ComputerName
                Message = 'Could not be pinged'
            }
        }
    } catch {
        Write-Warning $_
    }
}
Get-SysInfo -ComputerName doesnotexist,DESKTOP-39N2M0T -Verbose