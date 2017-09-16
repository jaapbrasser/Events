# Get current build and OS version information
Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property *

Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property Caption, BuildNumber

# How can we make this better?
Get-CimInstance -Class Win32_OperatingSystem | Select-Object -Property Caption, BuildNumber

# Are we done now?
Get-Help Get-CimInstance -Examples

(Get-Help Get-CimInstance -Examples).examples.example[2]

# Why would we use this?
Measure-Command { Get-CimInstance -Class Win32_OperatingSystem }
Measure-Command { Get-CimInstance -Query 'select caption,buildnumber from win32_operatingsystem' }

# Final command 
Get-CimInstance -Query 'select caption,buildnumber from win32_operatingsystem'

# Yes is there
Get-WmiObject -Query 'select caption,buildnumber from win32_operatingsystem'
Get-CimInstance -Query 'select caption,buildnumber from win32_operatingsystem'

Get-CimInstance -Query 'select caption,buildnumber from win32_operatingsystem' |
Select caption,BuildNumber