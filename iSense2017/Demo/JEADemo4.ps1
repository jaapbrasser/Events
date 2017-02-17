$psISE.Options.Zoom = 160
break

#####

$ExchangeAdminCred = Import-Clixml -Path 'C:\Users\JaapBrasser\lockdown your system\ExchangeVMAdmin.cred'

$VMSes = New-PSSession -ComputerName . -ConfigurationName Demo2 -Credential $ExchangeAdminCred

Get-VM -CimSession $VMSes

# Start-VM
Invoke-Command -Session $VMSes -ScriptBlock {Get-VM} |
Out-GridView -Title 'Select VM to Start' -PassThru   |
ForEach-Object {Start-VM -Name $_.Name}

# Stop-VM
Invoke-Command -Session $VMSes -ScriptBlock {Get-VM} |
Out-GridView -Title 'Select VM to Stop'  -PassThru   |
ForEach-Object {Stop-VM  -Name $_.Name -Force}