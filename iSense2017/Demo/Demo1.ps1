# Break if accidentally executed fully
#break

# Test Administrative elevation
function Test-Admin {    
    ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")
}
Test-Admin

# Setup ISE
$psISE.Options.Zoom = 160

# Transcription by Profile
New-Item -ItemType Directory -Path C:\Transcription -Force
'$null = Start-Transcript -Path C:\Transcription\Profile.log -Append' |
Out-File -FilePath (Join-Path $PSHOME 'Microsoft.PowerShell_profile.ps1') -Force

# Start PowerShell console
'Hello'
5+5

# Show how to work around this
Stop-Transcript
[system.datetime]::Now
#Exit

# View Transcription log
Invoke-Item -Path 'C:\Transcription\Profile.log'

# Remove PowerShell Profile logging
Remove-Item -Path (Join-Path $PSHOME 'Microsoft.PowerShell_profile.ps1') -Force

# Module Transcription
# MMC -> Local Computer Policy
# Computer Configuration\Administrative Templates\Windows Components\Windows PowerShell

# Open PowerShell
Clear-EventLog -LogName 'Windows PowerShell'
Get-WinEvent -LogName 'Windows PowerShell' |
Select-Object -ExpandProperty Message |
Where-Object {$_ -match '"Get-WinEvent"'} |
Select-Object -First 1

# Count the number of lines in output
(Get-WinEvent -LogName 'Windows PowerShell' |
Select-Object -ExpandProperty Message |
Where-Object {$_ -match '"Get-WinEvent"'} |
Select-Object -First 1) -split "`r`n" |
Measure-Object

Import-Module WindowsSearch -Verbose

Get-WindowsSearchSetting

Get-WinEvent -LogName 'Windows PowerShell' |
Select-Object -ExpandProperty Message |
Where-Object {$_ -match 'CommandLine=Get-WindowsSearchSetting'} 

# Check LogPipelineExecutionDetails (3.0 feature)
(Get-Module -Name WindowsSearch).LogPipelineExecutionDetails

# Disable LogPipelineExecutionDetails 
(Get-Module WindowsSearch).LogPipelineExecutionDetails = $false

# Clear EventLog and rerun cmdlet
Clear-EventLog -LogName 'Windows PowerShell'

Get-WindowsSearchSetting

Get-WinEvent -LogName 'Windows PowerShell' |
Select-Object -ExpandProperty Message |
Where-Object {$_ -match 'CommandLine=Get-WindowsSearchSetting'} 

# MMC -> Local Computer Policy
# Computer Configuration\Administrative Templates\Windows Components\Windows PowerShell
# Disable Module logging and Enable Transcription to C:\Transcription

# Open the log
Get-ChildItem C:\Transcription\20170216 -File | Invoke-Item

# Import Module
Import-Module -Name PS-MotD
Get-MOTD

# Open the log
Get-ChildItem C:\Transcription\20170216 -File | Invoke-Item

# PInvoke C# code and execute it
$Source = @"
using System;

namespace CS
{
    public class Program
    {
        public static void Payload()
        {
            Console.WriteLine("Awesome!");
        }
    }
}
"@
Add-Type -TypeDefinition $Source -Language CSharp
[CS.Program]::Payload()

# Open the log
Get-ChildItem C:\Transcription\20170216 -File |
Sort-Object -Property LastWriteTime | Select-Object -Last 1 |
Invoke-Item

# Another example
$Code = Get-Content -Path C:\Scripts\Demo2\Demo2Malicious.txt -Raw
Add-Type -TypeDefinition $Code -Language CSharp
[CS.Malicious]::Payload()

# Open the log
Get-ChildItem C:\Transcription\20170216 -File | Invoke-Item
