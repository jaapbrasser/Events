'Write-Output "Hello"
Write-Error "Error"' | Out-File C:\DuPSUG\Error.ps1

C:\DuPSUG\Error.ps1

C:\DuPSUG\Error.ps1 > C:\DuPSUG\Logfile.txt

Get-Content C:\DuPSUG\Logfile.txt

<#
2>&1
*>&1
1>&2
#>

$Error[0]

C:\DuPSUG\Error.ps1 2>&1 > C:\DuPSUG\Logfile.txt

Get-Content C:\DuPSUG\Logfile.txt

# Example of streams in PowerShell
Write-Output 'Output message'

Write-Verbose 'Verbose message'

Write-Verbose 'Verbose message' -Verbose

Get-Childitem variable:\*Preference

Write-Warning 'Warning message'
Write-Error 'Error message'

Write-Debug 'Debug message'
Write-Debug 'Debug message' -Debug
$DebugPreference = 'Continue'
Write-Debug 'Debug message'

$DebugPreference.GetType()
$DebugPreference.GetType().BaseType
[System.Enum]::GetNames([System.Management.Automation.ActionPreference])
$DebugPreference = 0
$DebugPreference 

Write-Host 'Host message'
Write-Information 'Information message'

Write-Information 'Information message' -InformationAction Continue

Write-Information 'Information message' -InformationAction Continue -Tags 'Message'

Write-Information 'Information message' -InformationAction Continue -Tags 'Message' 6>&1 |
Select-Object *

'
Write-Output      "Hello"
Write-Error       "Error"
Write-Verbose     "Verbose message" -Verbose
Write-Warning     "Warning message"
Write-Debug       "Debug message"   -Debug 
Write-Host        "Host message"
Write-Information "Information message" -InformationAction Continue
' | Out-File C:\DuPSUG\AllStreams.ps1

C:\DuPSUG\AllStreams.ps1

C:\DuPSUG\AllStreams.ps1 > C:\DuPSUG\WithoutRedirection.txt
Get-Content C:\DuPSUG\WithoutRedirection.txt

(C:\DuPSUG\AllStreams.ps1) *>&1 > C:\DuPSUG\WithRedirection.txt
Get-Content C:\DuPSUG\WithRedirection.txt