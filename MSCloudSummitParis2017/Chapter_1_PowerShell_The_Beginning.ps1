# Set Default ISE options
# break
$PSISE.Options.Zoom = 250

Set-ExecutionPolicy Unrestricted
Update-Help -Force

#region Demo Get-Verb
Get-Verb

Get-Command | Group-Object Verb |
Sort-Object -Property Count -Descending | Select-Object -First 5
#endregion

#region Demo Get-ChildItem
Get-ChildItem -Path C:\ -Filter *sys -Force

Dir C:\ *sys -Force
ls -Filter *sys -force c:\ 

ls / *sys -Fo 

Get-Help -Name Get-ChildItem -Parameter Path
Get-Help -Name Get-ChildItem -Parameter Filter
#endregion

#region PowerShell Help
Get-Help -Name Get-Command

Get-Alias

Get-Alias | Measure-Object

gal

Get-Help gal

Get-Command -Noun Alias
gcm *alias
Get-Command -Name *Alias

Get-Help -Name about_Aliases
Get-Help about_remote_troubleshooting
Get-Help about_Reserved_Words
#endregion

#region PowerShell pipeline
notepad

Get-Process -Name notepad

Get-Process -Name notepad | Select-Object -Property *

Get-Process notepad | Get-Member

Get-Help Get-Process -Full
Get-Help Get-Process -Examples

help Get-Process -Full

Get-Process -Name notepad

ps note*|select processname,starttime
ps *|select processname,starttime

Get-Process -name notepad | Stop-Process
#endregion