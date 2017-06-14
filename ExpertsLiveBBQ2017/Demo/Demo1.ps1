#region BriefHelp
function Get-BriefHelp {
    param(
        $Name
    )
    (Get-Help $Name).Parameters.Parameter |
    Select-Object Name,@{n='Help';e={-join $_.Description.Text}}
}
#endregion

# Show PowerShell logging configuration
gpmc.msc
mspaint.exe 'C:\Users\Administrator\Desktop\Demo\screenshot.png'


#region JEA Role file
cd C:\Demo1JEA

New-PSRoleCapabilityFile -Path .\PSConfEUFirstJEARole.psrc

psedit .\PSConfEUFirstJEARole.psrc

Get-BriefHelp -Name New-PSRoleCapabilityFile

$RoleSplat = @{
    VisibleCmdlets = 'Get-Process', 'Get-CimInstance'
}
New-PSRoleCapabilityFile -Path C:\Demo1JEA\FirstJEA.psrc @RoleSplat

Get-Content C:\Demo1JEA\FirstJEA.psrc

'
# I
# Do not
# want to
# see this
This is important,
focus on this
# I
# Do not
# want to
# see this
' -split "`n" -replace '^#.*$' | Where-Object {$_}

(Get-Content C:\Demo1JEA\FirstJEA.psrc) -replace '^#.*$' |
Where-Object {$_}

New-PSSessionConfigurationFile -SessionType RestrictedRemoteServer -Path .\ELFirstJEAConf.pssc

(Get-Content .\ELFirstJEAConf.pssc) -replace '^#.*$' |
Where-Object {$_}

#endregion


#region Deploy role capability file
Expand-Archive -Path C:\Demo1JEA.zip -DestinationPath 'C:\Program Files\WindowsPowerShell\Modules\'

Get-ChildItem -Path 'C:\Program Files\WindowsPowerShell\Modules\Demo1JEA' -Recurse |
Select-Object -Property FullName

(Get-ChildItem -Path 'C:\Program Files\WindowsPowerShell\Modules\Demo1JEA\' -File |
Get-Content) -replace '(\s+#|^#).*$' |
Where-Object {$_}
#endregion


#region Configuration file
Get-BriefHelp New-PSSessionConfigurationFile

$ConfSplat = @{
    RunAsVirtualAccount = $true
    RoleDefinitions     = @{'JaapBrasser' = @{RoleCapabilities = 'FirstJEA'}}
    SessionType         = 'RestrictedRemoteServer'
    Path                = 'C:\Demo1JEA\JEAConfig.pssc'
}

New-PSSessionConfigurationFile @ConfSplat

Test-PSSessionConfigurationFile -Path $ConfSplat.Path
#endregion


#region Register Configuration
Get-PSSessionConfiguration | Select-Object Name

$RegisterSplat = @{
    Name  = 'MyFirstJEA'
    Path  = 'C:\Demo1JEA\JEAConfig.pssc'
    Force = $true
}
Register-PSSessionConfiguration @RegisterSplat

Get-BriefHelp Enter-PSSession

whoami

$Cred = Get-Credential
$JEASession = New-PSSession -ConfigurationName 'MyFirstJEA' -ComputerName .

Invoke-Command -Session $JEASession -ScriptBlock {Get-Process}

Enter-PSSession -Session $JEASession
Get-Command
Get-Process
$PS = Get-Process
Exit-PSSession

$PS = Invoke-Command -Session $JEASession -ScriptBlock {Get-Process}

$PS[0..5]

# Switch to DC
Get-CimInstance -ClassName Win32_Bios

Get-PSSessionConfiguration | Select Name
#endregion


#region Update JEA Configuration on the fly

# On DC
notepad

# On client
Invoke-Command -Session $JEASession -ScriptBlock {Get-Process notepad}
Invoke-Command -Session $JEASession -ScriptBlock {Get-Process notepad | Stop-Process}

# On DC
psedit 'C:\Program Files\WindowsPowerShell\Modules\Demo1JEA\RoleCapabilities\FirstJEA.psrc'

# On Client
Invoke-Command -Session $JEASession -ScriptBlock {Get-Process notepad | Stop-Process}

$JEASession = New-PSSession -ConfigurationName 'MyFirstJEA' -ComputerName 10.0.0.1 -Credential $Cred
Invoke-Command -Session $JEASession -ScriptBlock {Get-Process notepad | Stop-Process}


#endregion


#region Cleanup
Unregister-PSSessionConfiguration -Name MyFirstJEA -Force

Get-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\Demo1JEA\' |
Remove-Item -Recurse -Force
#endregion