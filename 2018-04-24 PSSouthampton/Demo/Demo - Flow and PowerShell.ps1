# Blog post: https://sergeluca.wordpress.com/2017/12/01/upload-and-run-a-remote-powershell-script-from-microsoft-flow/
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Sheep"
$watcher.Filter = "Sheep.txt"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true 

$action = {
    Set-Sheep
    Remove-Item C:\Sheep\Sheep.txt
    Write-Verbose 'Executed Set-Sheep and cleaned up Sheep.txt'
}   

### DECIDE WHICH EVENTS SHOULD BE WATCHED
Register-ObjectEvent $watcher "Created" -Action $action

# Second watcher for monitoring purposes
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Sheep"
$watcher.Filter = "Monitor.txt"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true 

$action = {
    Remove-Item C:\Sheep\Monitor.txt
    Write-Verbose 'Executed monitoring checked successfully'
}

### DECIDE WHICH EVENTS SHOULD BE WATCHED
Register-ObjectEvent $watcher "Created" -Action $action
