@"
\ \     /  ___|    ___|             |       
 \ \   / \___ \   |       _ \    _` |   _ \ 
  \ \ /        |  |      (   |  (   |   __/ 
   \_/   _____/  \____| \___/  \__,_| \___| 
"@
#region VSCode
<#
    * Package Management
      - PowerShell Extension
    * F1
      - Settings management
      - Enable Power Mode
      - Disable Power Mode
    * Themes
      - Switch to ISE
    * Editing scripts
      - Multiline selections
      - Select all instances
      - Highlighting problems
      - Switch language
#>

#endregion

@"
 _ \  _)               | _)              
|   |  |  __ \    _ \  |  |  __ \    _ \ 
___/   |  |   |   __/  |  |  |   |   __/ 
_|    _|  .__/  \___| _| _| _|  _| \___| 
         _|                              
"@
#region Pipeline

# Grouping and sorting
Get-Verb

Get-Verb | Select Verb

Get-Verb | Sort-Object Verb

Get-Command

Get-Command | Group-Object Verb

Get-Command | Group-Object Verb | Sort-Object Count -Bottom 5

# Formatting

Get-Process

Get-VpnConnection

Get-VpnConnection | Format-Table -AutoSize

# Filtering and line-breaks

Get-Process -Name onenoteim

Get-Process | Where-Object {$_.Name -eq 'onenoteim'}

Get-Process | Where-Object name -eq 'onenoteim' | Select-Object -Property Name,Id

Get-Process |
Where-Object name -eq 'onenoteim' |
Select-Object -Property Name,Id

# Highlight filtering and multi select
Get-Process | Out-GridView

# Passtru
Get-Process | Out-GridView -PassTru | Stop-Process -WhatIf

# What and Confirm
Dir $home

Dir $home .gitconfig | Remove-Item -WhatIf

Dir $home .gitconfig | Remove-Item -Confirm

# Show-Command

Get-Command Get-Process -Syntax

Show-Command Get-Process

#endregion

@"
    \                                      |         
   _ \     __|   __|   _ \   |   |  __ \   __|   __| 
  ___ \   (     (     (   |  |   |  |   |  |   \__ \ 
_/    _\ \___| \___| \___/  \__,_| _|  _| \__| ____/ 
"@
#region Accounts
Get-Command -Module Microsoft.PowerShell.LocalAccounts

Get-LocalUser

Get-Help Get-LocalGroupMember

Get-Command Get-LocalGroupMember -Syntax
gcm Get-LocalGroupMember -Sy

Get-LocalGroupMember Administrators

Get-Help New-LocalUser -Examples
New-LocalUser -Name "NewAdmin" -NoPassword | Add-LocalGroupMember Administrators

Remove-LocalUser NewAdmin

Invoke-Command -ComputerName littlesurface -ScriptBlock {Get-LocalUser}

#endregion

@"
 _ \               _)        |                
|   |   _ \   _` |  |   __|  __|   __|  |   | 
__ <    __/  (   |  | \__ \  |    |     |   | 
_|\_\ \___| \__, | _| ____/ \__| _|    \__, | 
            |___/                      ____/ 
"@
#region Registry
Get-PSDrive

Get-ChildItem Cert:
Get-ChildItem Cert:\CurrentUser
Get-ChildItem Variable:

Get-PSDrive HK*

Get-ChildItem HKCU:

# Start typing for auto-completion
dir HKCU:\

# List installed programs
dir HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ | Select-Object Name

# How to apply this
code C:\temp\sharedscripts\Get-RemoteProgram/Get-RemoteProgram.ps1

. C:\temp\sharedscripts\Get-RemoteProgram/Get-RemoteProgram.ps1
#endregion

@"
    \                           
   _ \   _  /  |   |   __|  _ \ 
  ___ \    /   |   |  |     __/ 
_/    _\ ___| \__,_| _|   \___| 
"@
#region Azure
Get-AzVm
#endregion