$FlowModulePath = 'C:\users\Jaap Brasser\OneDrive\Documents\Events\2018-04 WinOps\Demo\Helper\PowerShellFlow.psm1'
Import-Module $FlowModulePath

Get-Command -Module PowerShellFlow

# Check Data Gateway service
Get-Service PBIEgwService

# Switch to Admin PowerShell console
$FlowModulePath = 'C:\users\Jaap Brasser\OneDrive\Documents\Events\2018-04 WinOps\Demo\Helper\PowerShellFlow.psm1'
Import-Module $FlowModulePath
Start-FlowAgent

# Switch to Phone
