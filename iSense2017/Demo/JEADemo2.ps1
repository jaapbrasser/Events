$psISE.Options.Zoom = 160
break

#####

Enter-PSSession -ComputerName . -ConfigurationName Demo1

Get-Command

1+1

whoami
whoami /priv

Get-Command whoami | Format-List ScriptBlock

Get-Process

Get-Process | fl *

Get-Process | Format-List
Get-Process | Get-Member

Get-Command -Module Demo1-Toolkit
(Get-Process PowerShell_ise).kill()
$PISE = get-process powershell_ise

Get-Command -Name Get-CimInstance
Get-CimInstance -ClassName win32_bios
Get-CimInstance -ClassName win32_operatingsystem
Get-CimInstance -ClassName win32_computersystem

$Variable = Get-CimInstance -ClassName win32_bios
Exit-PSSession

$Variable = Invoke-Command -ComputerName . -ConfigurationName Demo1 -ScriptBlock {Get-CimInstance -ClassName win32_bios}

$Variable

$Variable.GetType()