#region Exercise 1
Get-Command –Noun Object 

Get-Command –Verb Format

Get-Command –Name Ping.exe
Get-Command –Name Ping.exe | Format-Table -AutoSize
Get-Command –Name Ping.exe | Select-Object -Property Version
Get-Command –Name Ping.exe | Select-Object -ExpandProperty Version

Get-Command -Name *Computer*

gcm
#endregion

#region Exercise 2
Get-Command –Name Get-Help –Syntax
gcm help -sy

Get-Alias

Get-Help –Name Select-Object

Get-Help –Name Where-Object –Examples

Get-Help –Name ForEach-Object –ShowWindow

Get-Help –Name Measure-Object –Online

Get-Help about_Quoting_Rules
#endregion

#region Exercise 3
Get-Service | Measure-Object

Get-Service | Where-Object Status -eq 'Running'

Get-Service | Where-Object Status -eq 'Running' | Measure-Object

Get-Service |
Where-Object -FilterScript {$PSItem.Status -eq 'Running'} |
Measure-Object

Get-Service|?{PSItem.Status -eq 'Running'}|Measure

Get-Service|?{($_.Status -eq 'Running') -and ($_.Name -like 'a*') -or }

Get-Alias -Definition Where-Object

Get-Service | Where-Object Status -eq 'Running' |
 Measure-Object | Select-Object -Property Count

Get-Service | Group-Object -Property Status
Get-Service | Group-Object -Property StartType

$PSVersionTable
#endregion