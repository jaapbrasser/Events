# Set Default ISE options
#break
$PSISE.Options.Zoom = 160

#region First function

# Building a function
function Invoke-DemoFunction {
    $UserInput = Read-Host 'Please enter something...'

    Write-Output "You have entered: $UserInput"
}

Invoke-DemoFunction

Get-Help Invoke-DemoFunction

# Use parameter block
function Invoke-DemoFunction {
    param (
        $UserInput = (Read-Host 'Please enter something...')
    )
    Write-Output "You have entered: $UserInput"
}

Invoke-DemoFunction

Invoke-DemoFunction -UserInput 'hello'

Get-Help Invoke-DemoFunction -Full

# Use comments to describe what the function is doing
function Invoke-DemoFunction {
    param (
        $UserInput = (Read-Host 'Please enter something...')
    )
    # This will output the data you have entered
    Write-Output "You have entered: $UserInput"
}
Invoke-DemoFunction
#endregion

#region Comment based help
function Invoke-DemoFunction {
<#
.SYNOPSIS
This function will output the data you have entered
#>
    param (
        $UserInput = (Read-Host 'Please enter something...')
    )
    Write-Output "You have entered: $UserInput"
}

Get-Help Invoke-DemoFunction

function Invoke-DemoFunction {
<#
.SYNOPSIS
This function will output the data you have entered
.DESCRIPTION
Takes UserInput and will display this with a string prepended to it
.PARAMETER UserInput
This parameter accepts a string of data
.EXAMPLE
Invoke-DemoFunction -UserInput 'Hello, this is my input'
#>
    param (
        $UserInput = (Read-Host 'Please enter something...')
    )
    Write-Output "You have entered: $UserInput"
}

Get-Help Invoke-DemoFunction

Get-Help Invoke-DemoFunction -Examples

Get-Command Invoke-DemoFunction -Syntax

Invoke-DemoFunction
#endregion

#region Advanced functionality
function Invoke-DemoFunction {
<#
.SYNOPSIS
This function will output the data you have entered
.DESCRIPTION
Takes UserInput and will display this with a string prepended to it
.PARAMETER UserInput
This parameter accepts a string of data
.EXAMPLE
Invoke-DemoFunction -UserInput 'Hello, this is my input'
#>
    param (
        [Parameter(Mandatory = $true)]
        $UserInput
    )
    Write-Output "You have entered: $UserInput"
}
Get-Command Invoke-DemoFunction -Syntax

Invoke-DemoFunction

Get-Help Invoke-DemoFunction

function Invoke-DemoFunction {
<#
.SYNOPSIS
This function will output the data you have entered
.DESCRIPTION
Takes UserInput and will display this with a string prepended to it
.PARAMETER UserInput
This parameter accepts a string of data
.EXAMPLE
Invoke-DemoFunction -UserInput 'Hello, this is my input'
#>
    param (
        [Parameter(Mandatory = $true)]
        [string] $UserInput
    )
    Write-Output "You have entered: $UserInput"
}

Invoke-DemoFunction

function Invoke-DemoFunction {
<#
.SYNOPSIS
This function will output the data you have entered
.DESCRIPTION
Takes UserInput and will display this with a string prepended to it
.PARAMETER UserInput
This parameter accepts a string of data
.EXAMPLE
Invoke-DemoFunction -UserInput 'Hello, this is my input'
#>
    param (
        [Parameter(Mandatory = $true)]
        [string[]] $UserInput
    )
    Write-Output "You have entered: $UserInput"
}

Invoke-DemoFunction $null

function Invoke-DemoFunction {
<#
.SYNOPSIS
This function will output the data you have entered
.DESCRIPTION
Takes UserInput and will display this with a string prepended to it
.PARAMETER UserInput
This parameter accepts a string of data
.EXAMPLE
Invoke-DemoFunction -UserInput 'Hello, this is my input'
#>
    param (
        [Parameter(Mandatory         = $true,
                   ValueFromPipeline = $true)]
        [string] $UserInput
    )
    Write-Output "You have entered: $UserInput"
}

'This is my text' | Invoke-DemoFunction

Get-Command Invoke-DemoFunction -Syntax
#endregion


<#
    Break demo
#>


#region Continued....
function Invoke-DemoFunction {
<#
.SYNOPSIS
This function will output the data you have entered
.DESCRIPTION
Takes UserInput and will display this with a string prepended to it
.PARAMETER UserInput
This parameter accepts a string of data
.EXAMPLE
Invoke-DemoFunction -UserInput 'Hello, this is my input'
#>
    param (
        [Parameter(Mandatory         = $true,
                   ValueFromPipeline = $true)]
        [string[]] $UserInput
    )
    Write-Output "You have entered: $UserInput"
}

'This is my text' | Invoke-DemoFunction

Get-Command Invoke-DemoFunction -Syntax
#endregion

#region Position and valuefrompipeline
function Invoke-DemoFunction {
<#
.SYNOPSIS
This function will output the data you have entered
.DESCRIPTION
Takes UserInput and will display this with a string prepended to it
.PARAMETER UserInput
This parameter accepts a string of data
.PARAMETER ComputerName
This parameter accepts a string of data
.EXAMPLE
Invoke-DemoFunction -UserInput 'Hello, this is my input'
#>
    param (
        [Parameter(Mandatory         = $true,
                   ValueFromPipeline = $true,
                   Position          = 0)]
        [string[]] $UserInput,
        [Parameter(Mandatory         = $false,
                   ValueFromPipeline = $true,
                   ValueFromPipelineByPropertyName = $true,
                   Position          = 1)]
        [string[]] $ComputerName
    )
    Write-Output "You have entered: $UserInput"
}

'Hello' | Invoke-DemoFunction

function Invoke-DemoFunction {
<#
.SYNOPSIS
This function will output the data you have entered
.DESCRIPTION
Takes UserInput and will display this with a string prepended to it
.PARAMETER UserInput
This parameter accepts a string of data
.PARAMETER ComputerName
This parameter accepts a string of data
.EXAMPLE
Invoke-DemoFunction -UserInput 'Hello, this is my input'
#>
    param (
        [Parameter(Mandatory         = $true,
                   ValueFromPipeline = $true,
                   Position          = 0)]
        [ValidateSet('sun', 'moon', 'earth')]
        [string[]] $UserInput,
        [Parameter(Mandatory         = $false,
                   ValueFromPipeline = $true,
                   Position          = 1)]
        [Alias('ProcessName')]
        [string[]] $ComputerName
    )
    Write-Output "You have entered: $UserInput"
}

'What is the output' | Invoke-DemoFunction
Invoke-DemoFunction -UserInput 'Output'
Invoke-DemoFunction -ComputerName 'server01'

function Invoke-DemoFunction {
<#
.SYNOPSIS
This function will output the data you have entered
.DESCRIPTION
Takes UserInput and will display this with a string prepended to it
.PARAMETER UserInput
This parameter accepts a string of data
.PARAMETER ComputerName
This parameter accepts a string of data
.EXAMPLE
Invoke-DemoFunction -UserInput 'Hello, this is my input'
#>
    param (
        [Parameter(Mandatory         = $true,
                   ValueFromPipeline = $true,
                   Position          = 0)]
        [ValidatePattern("[a-z]*")]
        [string[]] $UserInput,
        [Parameter(Mandatory         = $false,
                   ValueFromPipeline = $true,
                   Position          = 1)]
        [Alias('ProcessName')]
        [string[]] $ComputerName
    )
    Write-Output "You have entered: $UserInput"
}

'What is the output' | Invoke-DemoFunction
Invoke-DemoFunction -UserInput 'a'

function Invoke-DemoFunction {
<#
.SYNOPSIS
This function will output the data you have entered
.DESCRIPTION
Takes UserInput and will display this with a string prepended to it
.PARAMETER UserInput
This parameter accepts a string of data
.PARAMETER ComputerName
This parameter accepts a string of data
.EXAMPLE
Invoke-DemoFunction -UserInput 'Hello, this is my input'
#>
    [cmdletbinding(SupportsShouldProcess=$true)]
    param (
        [Parameter(Mandatory         = $true,
                   ValueFromPipeline = $true,
                   Position          = 0)]
        [ValidatePattern("[a-z]*")]
        [string[]] $UserInput,
        [Parameter(Mandatory         = $false,
                   ValueFromPipeline = $true,
                   Position          = 1)]
        [Alias('ProcessName')]
        [string[]] $ComputerName
    )
    Write-Verbose 'Data output:'
    return 'You have entered: {0}' -f $UserInput
}

Get-Help -Name Invoke-DemoFunction

Invoke-DemoFunction -UserInput 'a' -Verbose

#endregion