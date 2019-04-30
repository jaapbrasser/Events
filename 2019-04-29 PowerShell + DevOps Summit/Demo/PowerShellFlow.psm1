function Start-FlowAgent {
    # Blog post: https://sergeluca.wordpress.com/2017/12/01/upload-and-run-a-remote-powershell-script-from-microsoft-flow/
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = "C:\Flow"
    $watcher.Filter = "MyTrigger.txt"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true 

    $action = {
        Display-Message
        Remove-Item C:\Flow\MyTrigger.txt
        Write-Verbose 'Executed Display-Message and cleaned up MyTrigger.txt'
    }   

    ### DECIDE WHICH EVENTS SHOULD BE WATCHED
    Register-ObjectEvent $watcher "Created" -Action $action

    # Second watcher for monitoring purposes
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = "C:\Flow"
    $watcher.Filter = "Monitor.txt"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true 

    $action = {
        Remove-Item C:\Flow\Monitor.txt
        Write-Verbose 'Executed monitoring checked successfully'
    }

    ### DECIDE WHICH EVENTS SHOULD BE WATCHED
    Register-ObjectEvent $watcher "Created" -Action $action
}

Function Get-FlowAgentStatus {
    $null = New-Item C:\Flow\Monitor.txt -ItemType File -Force -ErrorAction SilentlyContinue

    Start-Sleep -Seconds 10

    if (Test-Path C:\Flow\Monitor.txt) {
        $false
    } else {
        $true
    }
}

function Display-Message {
    $null = Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show((cat c:\flow\mytrigger.txt))
}