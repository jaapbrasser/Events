# PsExec and error codes
C:\SysinternalsSuite\PsExec.exe -s whoami

C:\SysinternalsSuite\PsExec.exe -s whoami 2> $null

# Retrieve Windows Update Service
C:\SysinternalsSuite\PsExec.exe `
    -s powershell.exe -nop -ex bypass `
    -c "& {Get-Service wuauserv`
}" 2> $null

# Retrieve output and store in variable
$Output = C:\SysinternalsSuite\PsExec.exe `
    -s powershell.exe -nop -ex bypass `
    -c "& {Get-Service wuauserv`
}" 2> $null
$Output

# Output
$Output | Select-Object -Skip 5

$Output = C:\SysinternalsSuite\PsExec.exe `
    -nobanner -s powershell.exe -nop -ex bypass `
    -c "& {Get-Service wuauserv`
}" 2> $null
$Output

# Export to CSV
$Output |
Export-Csv -LiteralPath C:\Local\Export.Csv -NoTypeInformation
Invoke-Item C:\Local\Export.Csv

# Can we get PowerShell objects from PSExec?
C:\SysinternalsSuite\PsExec.exe `
    -nobanner -s powershell.exe -nop -ex bypass `
    -c "& {`
        Get-Service wuauserv | Export-CliXml C:\Temp\PSExec.xml`
}" 2> $null

# Retrieve from fileshare
Import-Clixml -LiteralPath '\\PSConfAsia2017\C$\Temp\PSExec.xml'

Import-Clixml -LiteralPath '\\PSConfAsia2017\C$\Temp\PSExec.xml' |
Select-Object -Property *

# Without file shares?
$Output = C:\SysinternalsSuite\PsExec.exe `
    -nobanner -s powershell.exe -nop -ex bypass `
    -c "& {`
        Get-Service wuauserv | Export-CliXml C:\Temp\PSExec.xml `
        `$RemoteBytes = [io.file]::ReadAllBytes('C:\Temp\PSExec.xml')`
        [convert]::ToBase64String(`$RemoteBytes)`
}" 2> $null

$Output

$LocalBytes = [convert]::FromBase64String($Output)
$LocalBytes.GetType()

[io.file]::WriteAllBytes("C:\Local\PSExecObject.xml", $LocalBytes)

# Import the Xml get the objects
Import-Clixml -LiteralPath C:\Local\PSExecObject.xml

Import-Clixml -LiteralPath C:\Local\PSExecObject.xml |
Select-Object -Property *

# Import and convert to csv locally
Import-Clixml -LiteralPath C:\Local\PSExecObject.xml |
Export-Csv -LiteralPath C:\Local\CorrectOutput.csv -NoTypeInformation

Invoke-Item C:\Local\CorrectOutput.csv