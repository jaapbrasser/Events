# Get memory information
gwmi win32_computersystem

Get-CimInstance Win32_ComputerSystem |
Select-Object -Property TotalPhysicalMemory

# Use WQL for efficiency
Get-CimInstance -Query 'Select TotalPhysicalMemory from win32_computersystem'

(Get-CimInstance -Query 'Select TotalPhysicalMemory from win32_computersystem').TotalPhysicalMemory

(Get-CimInstance -Query 'Select TotalPhysicalMemory from win32_computersystem').TotalPhysicalMemory / 1GB -as [int]

# Final code
'{0} GB' -f ((Get-CimInstance -Query 'Select TotalPhysicalMemory from win32_computersystem').TotalPhysicalMemory/1GB -as [int])