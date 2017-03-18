# Demo 0 Install vscode

# Install ISESteroids
Install-Module ISESteroids

# Open profile button

# Demo create Exe

# Demo compatibility checking

# Demo add custom function
$null = $psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add(
    '#PSConfAsia', {
        function A {
            Get-Random -Minimum 0 -Maximum 16
        }
        "PowerShell Conference Asia is coming to a city near you in October!".ToCharArray().ForEach{
            Write-Host -ForegroundColor $(a) -NoNewline -Object $_
        }
    }, $null
)

# Demo Create compressed oneliners

# Demo F8 behaviour
get-childitem | % {
    $_ | Select-object name |
    Where-Object {
        $_
    } |
    Sort-Object |
    Select-Object -Unique
}

# Demo 3 Fix ugly scripts

# Obfuscate scripts

# Automatic error handling
Get-Item Singapore -ea stop

# Create function from code
$ComputerName = 'Test01'
$ComputerName | ForEach-Object {
    Get-WmiObject -ComputerName $_ -Class Win32_Bios
}