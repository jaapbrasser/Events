Measure-Command { 1..5 | ForEach-Object { Start-Job {Get-Process} } ; Get-Job | Wait-Job }

Measure-Command { 1..5 | ForEach-Object { Start-ThreadJob {Get-Process} } ; Get-Job | Wait-Job }

Measure-Command { 1..100000 | ForEach-Object {'hello'} }

Enter-PSSession -HostName . -SSHTransport

Get-Module -ListAvailable pki*

Install-Module WindowsCompatibility -AllowPrerelease -Scope CurrentUser -Force -Verbose

Get-Module -ListAvailable pki*
Get-WinModule -ListAvailable pki*

Import-WinModule pki

Get-Command -Module pki


