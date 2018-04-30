Function Get-FlowAgentStatus {
    $null = New-Item C:\Sheep\Monitor.txt -ItemType File -Force -ErrorAction SilentlyContinue

    Start-Sleep -Seconds 10

    if (Test-Path C:\Local\Monitor.txt) {
        $false
    } else {
        $true
    }
}