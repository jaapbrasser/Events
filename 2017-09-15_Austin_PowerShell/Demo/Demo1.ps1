# Demo 1 - Get hostname of system
$env:computername

Get-PSDrive

Get-ChildItem -Path env
Get-ChildItem -Path env:

# Final result
[pscustomobject]@{
    Hostname = $env:computername
}

# why?
[pscustomobject]@{
    Hostname = $env:computername
} | Export-Csv -Path MyFirst.csv -NoTypeInformation

Invoke-Item .\MyFirst.csv