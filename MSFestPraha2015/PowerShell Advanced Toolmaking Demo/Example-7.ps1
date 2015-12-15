'doesnotexist','DESKTOP-39N2M0T' | ForEach-Object {
    Get-WmiObject -ComputerName $_ -Class Win32_Bios |
    Select-Object -Property SerialNumber,Caption 
    Get-WmiObject -ComputerName $_ -Class Win32_OperatingSystem |
    Select-Object -Property Caption
}