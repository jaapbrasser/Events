$psISE.Options.Zoom = 160
break

#####
Enter-PSSession -ComputerName . 
whoami /priv
Exit-PSSession

Enter-PSSession -ComputerName . -Credential (Get-Credential -UserName ExchangeAdmin -Message 'Login')

$ExchangeAdminCred = Import-Clixml -Path 'C:\Temp\ExchangeAdmin.cred'

Enter-PSSession -ComputerName . -Credential $ExchangeAdminCred -ConfigurationName Demo2
whoami
Exit-PSSession

Get-PSSessionConfiguration Demo2

$VMSes = New-PSSession -ComputerName . -ConfigurationName Demo2 -Credential $ExchangeAdminCred

Enter-PSSession -Session $VMSes

Get-Command

Get-Command -Module Demo2-Toolkit
Get-Command -Module Demo2-Toolkit | Measure-Object

Get-VM 

Get-VM -Name SharePointVM01 | Start-VM -Passthru
Get-VM -Name SharePointVM01 | Stop-VM -Passthru
Get-VM -Name SharePointVM01 | Remove-VM -Passthru -Force

Get-VM 

Start-VM -Name SharePointVM02

Exit-PSSession

psedit 'C:\Program Files\Jea\Toolkit\Demo2-ToolKit.psm1'
# hyper-v\Get-VM
#        `$PSBoundParameters.Name = 'Exchange*'

Enter-PSSession -ComputerName . -ConfigurationName Demo2 -Credential $ExchangeAdminCred

Get-VM

Exit-PSSession