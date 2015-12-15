Get-WmiObject -ComputerName DESKTOP-39N2M0T -Class Win32_Bios |
Select-Obj5ect -Property SerialNumber
Get-WmiObject -ComputerName DESKTOP-39N2M0T -Class Win32_OperatingSystem |
Select-Object -Property Caption