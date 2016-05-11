# Set Default ISE options
break
$PSISE.Options.Zoom = 160

#region Demo Get-Verb
Get-Verb

Get-Command | Group-Object Verb |
Sort-Object -Property Count -Descending | Select-Object -First 5
#endregion

#region Demo Get-ChildItem
Get-ChildItem -Path C:\ -Filter *sys -Force

Dir C:\ *sys -Force
ls c:\ *sys -fo
#endregion

#region PowerShell Help
Get-Help Get-Command

Get-Alias

Get-Help -Name about_Aliases
#endregion

#region PowerShell pipeline
notepad.exe

Get-Process -name notepad

Get-Process -name notepad | Select-Object -Property *

GEt-Process notepad | get-member

Get-Process -name notepad |
Stop-Process
#endregion