# PowerShell Remoting
Enter-Pssession -ComputerName .
Get-ComputerInfo
Exit-PSSession

$Session = New-PSSession -ComputerName .
Invoke-Command -Session $Session {
    Get-ComputerInfo
}

$CmdOutput = Invoke-Command -Session $Session {
    Get-ComputerInfo
}

$CmdOutput

Invoke-Command -Session $Session {
    Get-HotFix | Format-Table -AutoSize
}