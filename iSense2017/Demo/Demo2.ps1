# Create the user
'net user testing p@ssw0rd#123 /ADD' | Set-Clipboard

# Add to the builtin administrators user group
'net localgroup administrators testing /ADD' | Set-Clipboard

'Get-Content -Path (Get-PSReadlineOption).HistorySavePath -Tail 10' | Set-Clipboard

Invoke-Item (Split-Path (Get-PSReadlineOption).HistorySavePath)

Get-PSReadlineOption | Select-Object MaximumHistoryCount

Get-Acl (Split-Path (Get-PSReadlineOption).HistorySavePath) |
Select-Object -ExpandProperty Access | Select FileSystemRights,@{
    n = 'Identity'
    e = {($_.IdentityReference -Split '\\')[1]}
}

"New-LocalUser -Name testing2 -Password (ConvertTo-SecureString 'Supersecret01' -Force -AsPlainText)" | Set-Clipboard

'Get-Content -Path (Get-PSReadlineOption).HistorySavePath -Tail 10' | Set-Clipboard

New-LocalUser -Name testing3
Add-LocalGroupMember -Group Administrators -Member testing2

'Get-Content -Path (Get-PSReadlineOption).HistorySavePath -Tail 10' | Set-Clipboard

# Setup logging
'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging' | ForEach-Object {
    if(-not (Test-Path $_)) {  
        $null = New-Item $_ -Force  
    }  
    Set-ItemProperty $_ -Name EnableScriptBlockInvocationLogging -Value 1
}

'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging' | ForEach-Object {
    if(-not (Test-Path $_)) {  
        $null = New-Item $_ -Force  
    }  
    Set-ItemProperty $_ -Name EnableScriptBlockLogging -Value 1
}


# Stop service using cmdlets
Stop-Service -Name wuauserv -WhatIf

Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-PowerShell/Operational'
    Id = 4104
} -MaxEvents 20 | ForEach-Object {
    $_.Where{$_.message -match 'Stop-Service|wuauserv'} |
    Select-Object -Property UserId, TimeCreated
}

function Get-MostRecentStopService {
    Get-WinEvent -FilterHashtable @{
        LogName = 'Microsoft-Windows-PowerShell/Operational'
        Id = 4104
    } -MaxEvents 20 | ForEach-Object {
        $_.Where{$_.message -match 'Stop-Service|wuauserv'} |
        Select-Object -Property @{
            name       = 'UserName'
            expression = {
                ([System.Security.Principal.SecurityIdentifier]$_.UserId).Translate([System.Security.Principal.NTAccount]).Value -split '\\' | Select -Last 1
            }
        }, TimeCreated
    } | Select -First 1
}

Show-EventLog

Get-Service -Name wuauserv | Stop-Service -Whatif
Get-MostRecentStopService

(Get-Service -Name wuauserv).Stop
Get-MostRecentStopService

# Stop service using WMI
(gwmi -q "select * from win32_service where name='wuauserv'").StopService
Get-MostRecentStopService

# Stop service using WMI and Invoke-Expressions
iex ('(xyzgwxyzmixyz -xyzq xyz"sxyzelxyzecxyzt xyz* xyzfrxyzomxyz wxyzinxyz32xyz_sxyzerxyzvixyzcexyz wxyzhexyzrexyz nxyzamxyze=xyz''wxyzuaxyzusxyzerxyzv''xyz")xyz.SxyztoxyzpSxyzerxyzvixyzce' -replace 'xyz')
Get-MostRecentStopService

# Stop service using WMI obfuscated service name
$Obfuscated = 'abcdserv' -replace 'a','w' -replace 'b|d',[char]117 -replace 'c','a'
(gwmi -q "select * from win32_service where name='$Obfuscated'").StopService
Get-MostRecentStopService

# Obfuscate service name with ServiceController class
[System.ServiceProcess.ServiceController]::GetServices().where{$_.name -eq $Obfuscated}.Stop
Get-MostRecentStopService

# Obfuscate type name and use obfuscated type and servicename
$TypeObfuscated = -join [string[]][char[]](83,121,115,116,101,109,46,83,101,114,118,105,99,101,80,114,111,99,101,115,115,46,83,101,114,118,105,99,101,67,111,110,116,114,111,108,108,101,114)
$TypeObfuscated

$Type = [type]$TypeObfuscated
$Type

$Type::GetServices().where{$_.name -eq $Obfuscated}
Get-MostRecentStopService




























<#
${;}=+$();${=}=${;};${+}=++${;};${@}=++${;};${.}=++${;};${[}=++${;};
${]}=++${;};${(}=++${;};${)}=++${;};${&}=++${;};${|}=++${;};
${"}="["+"$(@{})"[${)}]+"$(@{})"["${+}${|}"]+"$(@{})"["${@}${=}"]+"$?"[${+}]+"]";
${;}="".("$(@{})"["${+}${[}"]+"$(@{})"["${+}${(}"]+"$(@{})"[${=}]+"$(@{})"[${[}]+"$?"[${+}]+"$(@{})"[${.}]);
${;}="$(@{})"["${+}${[}"]+"$(@{})"[${[}]+"${;}"["${@}${)}"];
"${"}${.}${[}+${"}${)}${@}+${"}${+}${=}${+}+${"}${+}${=}${&}+${"}${+}${=}${&}+${"}${+}${+}${+}+${"}${[}${[}+${"}${.}${@}+${"}${+}${+}${|}+${"}${+}${+}${+}+${"}${+}${+}${[}+${"}${+}${=}${&}+${"}${+}${=}${=}+${"}${.}${.}+${"}${.}${[}|${;}"|&${;}; 
#>