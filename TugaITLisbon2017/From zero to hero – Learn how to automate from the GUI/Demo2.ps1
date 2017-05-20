#region IIS Installation using Server Manager

# First stage
$Path = 'C:\TugaIT\Transcription\20170430\PowerShell_transcript.DEMOFL2016.JxJDnFbr.20170430011140.txt'

Invoke-Item $Path

(Get-Content -LiteralPath $Path) -match 'CommandInvocation|ParameterBinding' | ForEach-Object {
    if ($_ -match 'CommandInvocation') {
        $_ -replace '.*?"(.*?)".*?','$1'
    } else {
        $_ -replace '.*?"(.*?)".*?"(.*?)".*?','    -$1 $2'
    }
}

# Get first 4, incomplete
(Get-Content -LiteralPath $Path) -match 'CommandInvocation|ParameterBinding' | ForEach-Object {
    if ($_ -match 'CommandInvocation') {
        $_ -replace '.*?"(.*?)".*?','$1'
    } else {
        $_ -replace '.*?"(.*?)".*?"(.*?)".*?','    -$1 $2'
    }
} | Select -First 4

#endregion

### Switch to DemoFL2016

#region Show eventlog entries

# Show the event log
Show-EventLog 

# Filter EventRecordID = 3309

# Setup parameters for Get-WinEvent
$WinEventSplat = @{
    LogName     = 'Microsoft-Windows-PowerShell/Operational'
    FilterXPath = '*[System[(EventRecordID=3309)]]'
}

Get-WinEvent @WinEventSplat

Get-WinEvent @WinEventSplat |
Select-Object -ExpandProperty Message

(Get-WinEvent @WinEventSplat |
Select-Object -ExpandProperty Message) -match 'ServerComponent'

(Get-WinEvent @WinEventSplat |
Select-Object -ExpandProperty Message) -split 
    "`n"                               -match
    'ServerComponent'                  -replace
    '.*?".*?".*?"ServerComponent_(.*?)".*?','$1'

#endregion

### Switch back to Desktop

#region Show ServerManagerInternal module

(Get-Content -LiteralPath $Path) -match 'CommandInvocation|ParameterBinding' | ForEach-Object {
    if ($_ -match 'CommandInvocation') {
        $_ -replace '.*?"(.*?)".*?','$1'
    }
}

$ImagePath = 'C:\TugaIT\ServerManagerInternal\ServerManagerInternal-Module.png'
Invoke-Item -Path $ImagePath

$ServerManagerModulePath = 'C:\TugaIT\ServerManagerInternal\ServerManagerShell\SMDeploymentHelpers.psm1'

Invoke-ScriptAnalyzer -Path $ServerManagerModulePath

psedit $ServerManagerModulePath
#endregion