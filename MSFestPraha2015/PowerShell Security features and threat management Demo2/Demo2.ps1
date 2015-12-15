# Break if accidentally executed fully
break

# Setup ISE
$psISE.Options.Zoom = 160

# Transcription by Profile
'$null = Start-Transcript -Path C:\Transcription\Profile.log -Append' |
Out-File -FilePath (Join-Path $PSHOME 'Microsoft.PowerShell_profile.ps1') -Force

# Show how to work around this
Stop-Transcript

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

Import-Module CustomizeWindows10 -Verbose

Add-PowerShellWinX

Get-WinEvent -LogName 'Windows PowerShell' |
Select-Object -ExpandProperty Message |
Where-Object {$_ -match 'CommandLine=Add-PowerShellWinX'} 

# Check LogPipelineExecutionDetails (3.0 feature)
(Get-Module CustomizeWindows10).LogPipelineExecutionDetails

# Disable LogPipelineExecutionDetails 
(Get-Module CustomizeWindows10).LogPipelineExecutionDetails = $false

# Clear EventLog and rerun cmdlet
Clear-EventLog -LogName 'Windows PowerShell'

Add-PowerShellWinX

Get-WinEvent -LogName 'Windows PowerShell' |
Select-Object -ExpandProperty Message |
Where-Object {$_ -match 'CommandLine=Add-PowerShellWinX'} 

# MMC -> Local Computer Policy
# Computer Configuration\Administrative Templates\Windows Components\Windows PowerShell
# Disable Module logging and Enable Transcription to C:\Transcription

# Restart ISE

# Open the log
Get-ChildItem C:\Transcription\20151119 -File | Invoke-Item

# Import Module
Import-Module -Name PS-MotD
Get-MOTD

# Open the log
Get-ChildItem C:\Transcription\20150919 -File | Invoke-Item

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
Get-ChildItem C:\Transcription\20150919 -File |
Sort-Object -Property LastWriteTime | Select-Object -Last 1 |
Invoke-Item

# Another example
$Code = Get-Content -Path C:\Users\JaapBrasser\Desktop\Demo2\Malicious.txt -Raw
Add-Type -TypeDefinition $Code -Language CSharp
[CS.Malicious]::Payload()

# MMC -> Local Computer Policy
# Computer Configuration\Administrative Templates\Windows Components\Windows PowerShell
# Enable Deep Script block logging

# Another example
$Code = Get-Content -Path C:\Users\JaapBrasser\Desktop\Demo2\Malicious.txt -Raw
Add-Type -TypeDefinition $Code -Language CSharp
[CS.Malicious]::Payload()

# Open the log
Get-ChildItem C:\Transcription\20151119 -File |
Sort-Object -Property LastWriteTime | Select-Object -Last 1 |
Invoke-Item

# Inspect the deep script logging results
Get-WinEvent -FilterHashtable @{ 
    ProviderName="Microsoft-Windows-PowerShell"
    Id = 4104
} | Select-Object -First 3 -ExpandProperty Message

# Encoded string
iex (-join (echo 91 109 97 116 104 93 58 58 80 73 | % {[char]$_}))

# Inspect the deep script logging results
Get-WinEvent -FilterHashtable @{ 
    ProviderName="Microsoft-Windows-PowerShell"
    Id = 4104
} | Select-Object -First 3 -ExpandProperty Message