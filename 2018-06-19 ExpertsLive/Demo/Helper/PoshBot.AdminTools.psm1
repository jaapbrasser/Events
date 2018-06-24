function Get-DiskSpace {
    New-PoshBotFileUpload -Path C:\Temp\Diskspace.png -Title 'Diskspace overview'
}
}

function Get-SystemErrorEvents {
    param(
        $MaxEvents = 10
    )

    $Message = Get-WinEvent -FilterHashtable @{
        Logname="System"
        Level=2
        StartTime=(Get-Date).AddMonths(-1)
    } -MaxEvents $MaxEvents

    New-PoshBotCardResponse -Type Normal -Text (
        $Message | Select-Object TimeCreated,LevelDisplayName,Message |
        Format-List | Out-String
    )
}

function Get-WebService {
    $Message = Get-Service -Name w3svc

    New-PoshBotCardResponse -Type Normal -Text (
        $Message | Format-Table -AutoSize | Out-String
    )
}

function Restart-WebService {
    $Message = iisreset.exe /restart 

    New-PoshBotCardResponse -Type Normal -Text (
        $Message | Out-String
    )
}

function Open-PodBayDoors {
    New-PoshBotCardResponse -Type Normal -Text "I'm sorry, Dave. I'm afraid I can't do that." -ThumbnailUrl C:\Temp\Hal9000.png
}

function Invoke-CodeExecution {
    param(
        $Code
    )

    $Message = Invoke-Expression $Code

    New-PoshBotCardResponse -Type Normal -Text ($Message | Out-String)
}
