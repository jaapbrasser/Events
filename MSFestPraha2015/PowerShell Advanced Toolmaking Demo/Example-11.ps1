'doesnotexist','DESKTOP-39N2M0T' | ForEach-Object {
    try {
        if (Test-Connection -ComputerName $_ -Count 1 -Quiet) {
            $Bios = Get-WmiObject -ComputerName $_ -Class Win32_Bios -ErrorAction Stop
            $OS = Get-WmiObject -ComputerName $_ -Class Win32_OperatingSystem  -ErrorAction Stop
            [pscustomobject]@{
                BiosSerial   = $Bios.SerialNumber
                OSName       = $OS.Caption
                ComputerName = $_
            }
        }
    } catch {
        Write-Warning $_
    }
}