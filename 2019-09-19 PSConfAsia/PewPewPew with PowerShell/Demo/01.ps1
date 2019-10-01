<# Pew Pew with #PowerShell
We'll show you how to zap bugs out of existence!
#>

#region 01
function Convert-EuroInRupee {
    param (
        [int] $Amount = 1
    )

    $rates = (Invoke-RestMethod -Uri 'https://api.exchangeratesapi.io/latest?symbols=ILS').rate
    $Amount * $rates.INR
}

Convert-EuroInRupee -Amount 1
#endregion

#region 02
function Convert-EuroInRupee {
    param (
        [int] $Amount = 1
    )

    $rates = (Invoke-RestMethod -Uri 'https://api.exchangeratesapi.io/latest?symbols=ILS').rate
    Write-Verbose -Message ($rates | Out-String)
    $Amount * $rates.INR
}

Convert-EuroInRupee -Amount 1 -Verbose
#endregion

#region 03
function Convert-EuroInRupee {
    [CmdletBinding()]
    param (
        [int] $Amount = 1
    )

    $rates = (Invoke-RestMethod -Uri 'https://api.exchangeratesapi.io/latest?symbols=ILS').rate
    Write-Verbose -Message ($rates | Out-String)
    $Amount * $rates.INR
}

Convert-EuroInRupee -Amount 1 -Verbose
#endregion

#region 04
function Convert-EuroInRupee {
    [CmdletBinding()]
    param (
        [int] $Amount = 1
    )

    $rates = (Invoke-RestMethod -Uri 'https://api.exchangeratesapi.io/latest?symbols=ILS').rate
    Write-Verbose -Message ($rates | Out-String)
    $Amount * $rates.INR
}

Set-PSDebug -Trace 1

Convert-EuroInRupee -Amount 1 -Verbose

Set-PSDebug -Off


#endregion

#region wait debug
# execute in other console!
function Convert-EuroInRupee {
    [CmdletBinding()]
    param (
        [int] $Amount = 1
    )
    Wait-Debugger
    $rates = (Invoke-RestMethod -Uri 'https://api.exchangeratesapi.io/latest?symbols=ILS').rate
    Write-Verbose -Message ($rates | Out-String)
    $Amount * $rates.INR
}

Convert-EuroInRupee -Amount 1
#endregion

#region waitdebugger, better code!
function Convert-EuroInRupee {
    [CmdletBinding()]
    param (
        [int] $Amount = 1
    )
    Wait-Debugger
    $result = (Invoke-RestMethod -Uri 'https://api.exchangeratesapi.io/latest?symbols=ILS')
    Write-Verbose -Message ($result.rate | Out-String)
    $rate = $result.rate.INR
    $Amount * $rate
}

Convert-EuroInRupee -Amount 1
#endregion

#region correct function
function Convert-EuroInRupee {
    [CmdletBinding()]
    param (
        [int] $Amount = 1
    )
    $result = (Invoke-RestMethod -Uri 'https://api.exchangeratesapi.io/latest?symbols=INR')
    Write-Verbose -Message ($result.rate | Out-String)
    $rate = $result.rates.INR
    $Amount * $rate
}

Convert-EuroInRupee -Amount 1
#endregion
