set-executionpolicy unrestricted
$PSVersionTable
Update-HElp -Force
Get-Command -Verb Format
Get-Help Get-Command
Get-Command -Name Get-Help
Get-Command -Noun help
Get-Command -Name *Help -Noun Help
notepad.exe
Get-Process notepad
Get-Process -Name notepad
Get-Process -Id 4960
Get-Process -Id 4960 -Name notepad
Get-Help Get-Process
Get-Command -Name *service*
Get-Service
Get-Help Measure-Object
Get-Service | Measure-Object
Get-Command *Object
help group-object
GEt-Service 
Get-Service | Group-Object -Property Status
Get-Service | Group-Object
Get-Service | Group-Object count
(Get-Service).count
powershell.exe -version 2
(ping.exe 127.0.0.1).count
ping.exe 127.0.0.1
Get-History
powershell.exe -version 2
Get-PSDrive
Get-ChildItem Variable:
Get-Help about_automatic_Variables
get-psdrive
ls env:
get-psdrive
Get-ChildItem -Path HKLM:
Get-ChildItem -Path HKCU:
Get-ChildItem -Path HKCU:\System\
Get-ChildItem -Path HKCU:\System\CurrentControlSet\
Get-Command *order
Get-Command *sort
Get-Help Sort-Object
Get-Process
Get-Process | Sort-Object -Property ProcessName
Get-Process | Sort-Object -Property ProcessName -Descending
Get-Command -Noun Object
GEt-Process
(GEt-Process)[0..10]
GEt-Process | Select-Object -First 10
cd C:\users\Administrator
ls
Get-Service | Export-Csv -Path Services.csv -NoTypeInformation
Invoke-Item .\Services.csv
Get-Service | Export-Csv -Delimiter ';' -Path Services2.csv -NoTypeInformation
Invoke-Item .\Services2.csv
$profile|select *
$profile
"'C:\Users\Administrator\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profil
e.ps1
'"
$Profile | Select *
$profile.AllUsersAllHosts
explorer.exe C:\windows\system32\WindowsPowerShell\v1.0\
notepad.exe $PROFILE.AllUsersAllHosts
