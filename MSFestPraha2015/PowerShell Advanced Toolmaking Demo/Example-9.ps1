'doesnotexist','DESKTOP-39N2M0T' | ForEach-Object {
    try {
        Get-WmiObject -ComputerName $_ -Class Win32_Bios -ErrorAction Stop |
        Select-Object -Property SerialNumber,Caption 
        Get-WmiObject -ComputerName $_ -Class Win32_OperatingSystem  -ErrorAction Stop |
        Select-Object -Property Caption
    } catch {
        Write-Warning $_
    }
}