function Test-WebServerStatus {
    param (
        [switch] $Detail
    )

    if ($Detail) {
        # Gather Details:
        Invoke-Command -vmname demoiis2016 -ScriptBlock {
            Get-Service -Name w3svc
            Get-Volume C | Select-Object -Property SizeRemaining
            "Uptime: $([math]::round(((Get-Date)-((gcim Win32_OperatingSystem).LastBootUptime)).TotalHours,2)) hours"
        } | Out-String
    } else {
        'The Webserver Is Down'
    }
}

function Invoke-EscalationMatrix {
    param (
        [string] $ComputerName
    )

    if ($ComputerName -eq 'WebServer') {
        'We identified Daniel as the responsible engineer, we are robocalling him until he wakes up'
    } else {
        'We could not find a responsible engineer, you are on your own here'
    }
}

function Start-WebService {
    param (
        [string] $ComputerName
    )
        Invoke-Command -vmname demoiis2016 -ScriptBlock {
            Start-Service -Name w3svc -Verbose
        } | Out-String
}

New-Alias -Name StartWeb -Value Start-WebService
New-Alias -Name Escalate -Value Invoke-EscalationMatrix
New-Alias -Name Check -Value Test-WebServerStatus