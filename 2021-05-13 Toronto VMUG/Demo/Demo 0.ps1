# terminating / non-terminating

$Error.Clear()

try {
    Get-Item -Path c:\Windows
}
catch {
    'no biggie!'
}

# be aware of error that are terminating and which are not, do not assume!

try {
    Get-Item -Path c:\Windows -ErrorAction Stop
}
catch {
    'no biggie!'
}

# investigate error
$error[0]
$error[0] | Select-Object *


# catch specific errors to handle other code paths

try {
    Get-Item -Path c:\Windows -ErrorAction Stop
}
catch [System.Management.Automation.DriveNotFoundException] {
    'Are you running on Mac?'
}
catch {
    'no biggie!'
}

function Invoke-SoManyErrors {
    throw 1
    throw 2
    throw 3
}

Invoke-SoManyErrors

function Invoke-SoManyErrors {
    trap {
        'Oh no!'
    }
    
    throw 1
    throw 2
    throw 3
}

Invoke-SoManyErrors

Get-Item -Name 'pewpewpew'

$?
$?

1/0

$OldErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'SilentlyContinue'

1/0

$ErrorActionPreference = $OldErrorActionPreference

0..6 | % {
    '{0} : {1}' -f $_, [System.Management.Automation.ActionPreference]$_
}

[System.Management.Automation.ActionPreference].GetEnumNames()
