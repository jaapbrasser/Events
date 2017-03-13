# Install vscode
$DownloadSplat = @{
    Uri     = "https://go.microsoft.com/fwlink/?LinkID=623230"
    OutFile = "C:\temp\vscode.exe"
}
Invoke-WebRequest @DownloadSplat
C:\temp\vscode.exe /verysilent

# Install ISESteroids
Install-Module ISESteroids

# Open profile button

# Demo create Exe

# Demo compatibility checking

# Demo add custom function
$null = $psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add(
    'Proudly', {
        function A {
            Get-Random -Minimum 0 -Maximum 16
        }
        "This copy operation is proudly brought to you by Jaap".ToCharArray().ForEach{
            Write-Host -ForegroundColor $(a) -NoNewline -Object $_
        }
    }, $null
)

Get-Process

# Demo F8 behaviour
get-childitem | % {
$_ | Select-object name |
Where-Object {$_} |
Sort-Object |
Select-Object -Unique
}

# Demo 3 Fix ugly scripts

# Obfuscate scripts

# Demo 4 Create compressed oneliners