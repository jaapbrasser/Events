get-childitem 'C:\Temp\' -File | ForEach-Object {
    [pscustomobject]@{
        Name          = $_.Name
        LastWriteTime = $_.LastWriteTime
        SizeKB        = '{0:N2}' -f ($_.Length/1KB)
        DateReport    = Get-Date
    }
} | Export-Csv -Path Excel.csv -NoTypeInformation

1..10 | ForEach-Object {
    $Number = $_
    1..3 | ForEach-Object {
        "The number is: $Number, the subnumber is $_"
        $Number * $_
    }
}

'Hello world!' | Tee-Object -Variable Tee
$Tee

Get-Command -ParameterName ComputerName | Measure-Object

Add-Type -AssemblyName System.Windows.Forms | Out-Null
[System.Windows.Forms.MessageBox]::Show('Hello World')

[System.Windows.Forms.MessageBox]::Show

Get-Process | Out-GridView -PassThru | Stop-Process -WhatIf

Get-Process chr* | Stop-Process -WhatIf

Get-Command -Verb Write
Write-Verbose 'This is verbose' -Verbose

Get-CimInstance -ClassName CIM_OperatingSystem

