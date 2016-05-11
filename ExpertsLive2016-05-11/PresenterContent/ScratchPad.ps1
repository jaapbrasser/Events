Invoke-Item -Path (Get-PSReadlineOption).HistorySavePath

Get-Help ABout_automatic_variables

$true -eq $true
$true -eq $false
$true -eq 'true'
$true -eq 'false'

Get-Process | Select-Object -ExpandProperty PRocessName | Measure-Object

# Use Pipe symbol as text
Get-Process | Select-Object -ExpandProperty PRocessName -Unique |
Measure-Object

# Examples of advanced formatting
'{0:X2}' -f 255
'{0:P2}' -f 0.66666
'{0:N2}' -f 3.99999

# Notation for properties of a string $()
Get-Process | Select-Object -First 5 | ForEach-Object {
    "This is the: '$($_.ProcessName)' and this is the PID: '$($_.ID)'"
}


Get-Process | Get-Random | Stop-Process -WhatIf


$profile