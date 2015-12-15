Get-WmiObject -Class Win32_Bios



gwmi win32_bios



function Get-SysInfo {
    [cmdletbinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName,
                   ValueFromPipeline)]
        [string] $ComputerName = $env:computername
    )
    process {
        try {
            $ErrorActionPreference = 'Stop'
            Write-Verbose -Message "Creating CimSession to computer: $ComputerName"
            $cimsession = New-CimSession -ComputerName $ComputerName
       
            $bios = Get-CimInstance -ClassName Win32_BIOS -CimSession $cimsession
            $os = Get-CimInstance -ClassName Win32_OperatingSystem -CimSession $cimsession
            $comp = Get-CimInstance -ClassName Win32_ComputerSystem -CimSession $cimsession
       
            $cimsession | Remove-CimSession
       
            [pscustomobject]@{
                SerialNumber = $bios.SerialNumber
                OSVersion    = $OS.Version
                Domain       = $comp.Domain
                ComputerName = $ComputerName
                Error        = $null
            }
        }
        
        catch {
            [pscustomobject]@{
                ComputerName = $ComputerName
                Error        = $_.Exception.Message
            }
        }
    }
}



Get-WmiObject -ComputerName DESKTOP-39N2M0T -Class Win32_Bios



Get-WmiObject -ComputerName DESKTOP-39N2M0T -Class Win32_Bios |
Select-Object -Property SerialNumber



Get-WmiObject -ComputerName DESKTOP-39N2M0T -Class Win32_Bios |
Select-Object -Property SerialNumber
Get-WmiObject -ComputerName DESKTOP-39N2M0T -Class Win32_OperatingSystem |
Select-Object -Property Caption



Get-WmiObject -ComputerName DESKTOP-39N2M0T -Class Win32_Bios |
Select-Object -Property SerialNumber,Caption
Get-WmiObject -ComputerName DESKTOP-39N2M0T -Class Win32_OperatingSystem |
Select-Object -Property Caption



'doesnotexist','DESKTOP-39N2M0T' | ForEach-Object {
    Get-WmiObject -ComputerName $_ -Class Win32_Bios |
    Select-Object -Property SerialNumber,Caption 
    Get-WmiObject -ComputerName $_ -Class Win32_OperatingSystem |
    Select-Object -Property Caption
}



'doesnotexist','DESKTOP-39N2M0T' | ForEach-Object {
    try {
        Get-WmiObject -ComputerName $_ -Class Win32_Bios |
        Select-Object -Property SerialNumber,Caption 
        Get-WmiObject -ComputerName $_ -Class Win32_OperatingSystem |
        Select-Object -Property Caption
    } catch {
        Write-Warning $_
    }
}



'doesnotexist','DESKTOP-39N2M0T' | ForEach-Object {
    try {
        Get-WmiObject -ComputerName $_ -Class Win32_Bios -ErrorAction Stop |
        Select-Object -Property SerialNumber,Caption 
        Get-WmiObject -ComputerName $_ -Class Win32_OperatingSystem  -ErrorAction Stop |
        Select-Object -Property Caption
    } catch {
        Write-Warning $_
    }
}



'doesnotexist','DESKTOP-39N2M0T' | ForEach-Object {
    try {
        if (Test-Connection -ComputerName $_ -Count 1 -Quiet) {
            Get-WmiObject -ComputerName $_ -Class Win32_Bios -ErrorAction Stop |
            Select-Object -Property SerialNumber,Caption 
            Get-WmiObject -ComputerName $_ -Class Win32_OperatingSystem  -ErrorAction Stop |
            Select-Object -Property Caption
        }
    } catch {
        Write-Warning $_
    }
}



'doesnotexist','DESKTOP-39N2M0T' | ForEach-Object {
    try {
        if (Test-Connection -ComputerName $_ -Count 1 -Quiet) {
            $Bios = Get-WmiObject -ComputerName $_ -Class Win32_Bios -ErrorAction Stop
            $OS = Get-WmiObject -ComputerName $_ -Class Win32_OperatingSystem  -ErrorAction Stop
            [pscustomobject]@{
                BiosSerial   = $Bios.SerialNumber
                OSName       = $OS.Caption
                ComputerName = $_
            }
        }
    } catch {
        Write-Warning $_
    }
}



function Get-SysInfo {
    param(
        [string]$ComputerName 
    )

    try {
        if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
            $Bios = Get-WmiObject -ComputerName $ComputerName -Class Win32_Bios -ErrorAction Stop
            $OS = Get-WmiObject -ComputerName $ComputerName -Class Win32_OperatingSystem  -ErrorAction Stop
            [pscustomobject]@{
                BiosSerial   = $Bios.SerialNumber
                OSName       = $OS.Caption
                ComputerName = $ComputerName
                Message      = $null
            }
        } else {
            [pscustomobject]@{
                BiosSerial   = $null
                OSName       = $null
                ComputerName = $ComputerName
                Message = 'Could not be pinged'
            }
        }
    } catch {
        Write-Warning $_
    }
}



function Get-SysInfo {
    param(
        [string]$ComputerName 
    )

    try {
        if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
            $Bios = Get-WmiObject -ComputerName $ComputerName -Class Win32_Bios -ErrorAction Stop
            $OS = Get-WmiObject -ComputerName $ComputerName -Class Win32_OperatingSystem  -ErrorAction Stop
            [pscustomobject]@{
                BiosSerial   = $Bios.SerialNumber
                OSName       = $OS.Caption
                ComputerName = $ComputerName
                Message      = $null
            }
        } else {
            [pscustomobject]@{
                BiosSerial   = $null
                OSName       = $null
                ComputerName = $ComputerName
                Message = 'Could not be pinged'
            }
        }
    } catch {
        Write-Warning $_
    }
}
Get-SysInfo -ComputerName doesnotexist,DESKTOP-39N2M0T



function Get-SysInfo {
    param(
        [string[]]$ComputerName 
    )

    try {
        if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
            $Bios = Get-WmiObject -ComputerName $ComputerName -Class Win32_Bios -ErrorAction Stop
            $OS = Get-WmiObject -ComputerName $ComputerName -Class Win32_OperatingSystem  -ErrorAction Stop
            [pscustomobject]@{
                BiosSerial   = $Bios.SerialNumber
                OSName       = $OS.Caption
                ComputerName = $ComputerName
                Message      = $null
            }
        } else {
            [pscustomobject]@{
                BiosSerial   = $null
                OSName       = $null
                ComputerName = $ComputerName
                Message = 'Could not be pinged'
            }
        }
    } catch {
        Write-Warning $_
    }
}
Get-SysInfo -ComputerName doesnotexist,DESKTOP-39N2M0T



function Get-SysInfo {
    param(
        [string[]]$ComputerName 
    )

    Write-Verbose -Message "Attempting to gather SysInfo from $ComputerName"
    try {
        if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
            $Bios = Get-WmiObject -ComputerName $ComputerName -Class Win32_Bios -ErrorAction Stop
            $OS = Get-WmiObject -ComputerName $ComputerName -Class Win32_OperatingSystem  -ErrorAction Stop
            [pscustomobject]@{
                BiosSerial   = $Bios.SerialNumber
                OSName       = $OS.Caption
                ComputerName = $ComputerName
                Message      = $null
            }
        } else {
            [pscustomobject]@{
                BiosSerial   = $null
                OSName       = $null
                ComputerName = $ComputerName
                Message = 'Could not be pinged'
            }
        }
    } catch {
        Write-Warning $_
    }
}
Get-SysInfo -ComputerName doesnotexist,DESKTOP-39N2M0T



function Get-SysInfo {
    [cmdletbinding()]
    param(
        [string[]]$ComputerName 
    )

    Write-Verbose -Message "Attempting to gather SysInfo from $ComputerName"
    try {
        if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
            $Bios = Get-WmiObject -ComputerName $ComputerName -Class Win32_Bios -ErrorAction Stop
            $OS = Get-WmiObject -ComputerName $ComputerName -Class Win32_OperatingSystem  -ErrorAction Stop
            [pscustomobject]@{
                BiosSerial   = $Bios.SerialNumber
                OSName       = $OS.Caption
                ComputerName = $ComputerName
                Message      = $null
            }
        } else {
            [pscustomobject]@{
                BiosSerial   = $null
                OSName       = $null
                ComputerName = $ComputerName
                Message = 'Could not be pinged'
            }
        }
    } catch {
        Write-Warning $_
    }
}
Get-SysInfo -ComputerName doesnotexist,DESKTOP-39N2M0T -Verbose



function Get-SysInfo {
    [cmdletbinding()]
    param(
        [string[]]$ComputerName 
    )

    process {
        Write-Verbose -Message "Attempting to gather SysInfo from $ComputerName"
        try {
            if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
                $Bios = Get-WmiObject -ComputerName $ComputerName -Class Win32_Bios -ErrorAction Stop
                $OS = Get-WmiObject -ComputerName $ComputerName -Class Win32_OperatingSystem  -ErrorAction Stop
                [pscustomobject]@{
                    BiosSerial   = $Bios.SerialNumber
                    OSName       = $OS.Caption
                    ComputerName = $ComputerName
                    Message      = $null
                }
            } else {
                [pscustomobject]@{
                    BiosSerial   = $null
                    OSName       = $null
                    ComputerName = $ComputerName
                    Message = 'Could not be pinged'
                }
            }
        } catch {
            Write-Warning $_
        }
    }
}
Get-SysInfo -ComputerName doesnotexist,DESKTOP-39N2M0T -Verbose



function Get-SysInfo {
    [cmdletbinding()]
    param(
        [string[]]$ComputerName 
    )

    process {
        foreach ($Computer in $ComputerName) {
            Write-Verbose -Message "Attempting to gather SysInfo from $Computer"
            try {
                if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
                    $Bios = Get-WmiObject -ComputerName $Computer -Class Win32_Bios -ErrorAction Stop
                    $OS = Get-WmiObject -ComputerName $Computer -Class Win32_OperatingSystem  -ErrorAction Stop
                    [pscustomobject]@{
                        BiosSerial   = $Bios.SerialNumber
                        OSName       = $OS.Caption
                        ComputerName = $Computer
                        Message      = $null
                    }
                } else {
                    [pscustomobject]@{
                        BiosSerial   = $null
                        OSName       = $null
                        ComputerName = $Computer
                        Message = 'Could not be pinged'
                    }
                }
            } catch {
                Write-Warning $_
            }
        }
    }
}
Get-SysInfo -ComputerName doesnotexist,DESKTOP-39N2M0T -Verbose



function Get-SysInfo {
    [cmdletbinding()]
    param(
        [string[]]$ComputerName 
    )

    process {
        foreach ($Computer in $ComputerName) {
            Write-Verbose -Message "Attempting to gather SysInfo from $Computer"
            try {
                if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
                    $Bios = Get-WmiObject -ComputerName $Computer -Class Win32_Bios -ErrorAction Stop
                    $OS = Get-WmiObject -ComputerName $Computer -Class Win32_OperatingSystem  -ErrorAction Stop
                    [pscustomobject]@{
                        BiosSerial   = $Bios.SerialNumber
                        OSName       = $OS.Caption
                        ComputerName = $Computer
                        Message      = $null
                    }
                } else {
                    [pscustomobject]@{
                        BiosSerial   = $null
                        OSName       = $null
                        ComputerName = $Computer
                        Message = 'Could not be pinged'
                    }
                }
            } catch {
                Write-Warning $_
            }
        }
    }
}
 'doesnotexist','DESKTOP-39N2M0T' | Get-SysInfo -Verbose



function Get-SysInfo {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory                       =$true, 
            ValueFromPipeline               =$true,
            ValueFromPipelineByPropertyName =$true
        )]
        [string[]]$ComputerName 
    )

    process {
        foreach ($Computer in $ComputerName) {
            Write-Verbose -Message "Attempting to gather SysInfo from $Computer"
            try {
                if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
                    $Bios = Get-WmiObject -ComputerName $Computer -Class Win32_Bios -ErrorAction Stop
                    $OS = Get-WmiObject -ComputerName $Computer -Class Win32_OperatingSystem  -ErrorAction Stop
                    [pscustomobject]@{
                        BiosSerial   = $Bios.SerialNumber
                        OSName       = $OS.Caption
                        ComputerName = $Computer
                        Message      = $null
                    }
                } else {
                    [pscustomobject]@{
                        BiosSerial   = $null
                        OSName       = $null
                        ComputerName = $Computer
                        Message = 'Could not be pinged'
                    }
                }
            } catch {
                Write-Warning $_
            }
        }
    }
}
 'doesnotexist','DESKTOP-39N2M0T' | Get-SysInfo -Verbose



function Get-SysInfo {
    [cmdletbinding(SupportsShouldProcess)]
    param(
        [Parameter(
            Mandatory                       =$true, 
            ValueFromPipeline               =$true,
            ValueFromPipelineByPropertyName =$true
        )]
        [string[]]$ComputerName 
    )

    process {
        foreach ($Computer in $ComputerName) {
            $Bios = $OS = $null
            Write-Verbose -Message "Attempting to gather SysInfo from $Computer"
            try {
                if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
                    $Bios = Get-WmiObject -ComputerName $Computer -Class Win32_Bios -ErrorAction Stop
                    $OS = Get-WmiObject -ComputerName $Computer -Class Win32_OperatingSystem  -ErrorAction Stop
                    [pscustomobject]@{
                        BiosSerial   = $Bios.SerialNumber
                        OSName       = $OS.Caption
                        ComputerName = $Computer
                        Message      = $null
                    }
                } else {
                    [pscustomobject]@{
                        BiosSerial   = $null
                        OSName       = $null
                        ComputerName = $Computer
                        Message = 'Could not be pinged'
                    }
                }
            } catch {
                Write-Warning $_
            }
        }
    }
}
 'doesnotexist','DESKTOP-39N2M0T' | Get-SysInfo -Verbose -WhatIf



function Get-SysInfo {
    [cmdletbinding(SupportsShouldProcess)]
    param(
        [Parameter(
            Mandatory                       =$true, 
            ValueFromPipeline               =$true,
            ValueFromPipelineByPropertyName =$true
        )]
        [string[]]$ComputerName 
    )

    process {
        foreach ($Computer in $ComputerName) {
            $Bios = $OS = $null
            Write-Verbose -Message "Attempting to gather SysInfo from $Computer"
            try {
                if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
                    if ($PSCmdlet.ShouldProcess($Computer,'Query WMI')) {
                        $Bios = Get-WmiObject -ComputerName $Computer -Class Win32_Bios -ErrorAction Stop
                        $OS = Get-WmiObject -ComputerName $Computer -Class Win32_OperatingSystem  -ErrorAction Stop
                    }
                    [pscustomobject]@{
                        BiosSerial   = $Bios.SerialNumber
                        OSName       = $OS.Caption
                        ComputerName = $Computer
                        Message      = $null
                    }
                } else {
                    [pscustomobject]@{
                        BiosSerial   = $null
                        OSName       = $null
                        ComputerName = $Computer
                        Message = 'Could not be pinged'
                    }
                }
            } catch {
                Write-Warning $_
            }
        }
    }
}
 'doesnotexist','DESKTOP-39N2M0T' | Get-SysInfo -Verbose -WhatIf



function Get-SysInfo {
    [cmdletbinding(SupportsShouldProcess,ConfirmImpact='Medium')]
    param(
        [Parameter(
            Mandatory                       =$true, 
            ValueFromPipeline               =$true,
            ValueFromPipelineByPropertyName =$true
        )]
        [string[]]$ComputerName 
    )

    process {
        foreach ($Computer in $ComputerName) {
            $Bios = $OS = $null
            Write-Verbose -Message "Attempting to gather SysInfo from $Computer"
            try {
                if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
                    if ($PSCmdlet.ShouldProcess($Computer,'Query WMI')) {
                        $Bios = Get-WmiObject -ComputerName $Computer -Class Win32_Bios -ErrorAction Stop
                        $OS = Get-WmiObject -ComputerName $Computer -Class Win32_OperatingSystem  -ErrorAction Stop
                    }
                    [pscustomobject]@{
                        BiosSerial   = $Bios.SerialNumber
                        OSName       = $OS.Caption
                        ComputerName = $Computer
                        Message      = $null
                    }
                } else {
                    [pscustomobject]@{
                        BiosSerial   = $null
                        OSName       = $null
                        ComputerName = $Computer
                        Message = 'Could not be pinged'
                    }
                }
            } catch {
                Write-Warning $_
            }
        }
    }
}
 'doesnotexist','DESKTOP-39N2M0T' | Get-SysInfo -Verbose -Confirm



function Get-SysInfo {
    [cmdletbinding(SupportsShouldProcess,ConfirmImpact='Medium')]
    param(
        [Parameter(
            Mandatory                       =$true, 
            ValueFromPipeline               =$true,
            ValueFromPipelineByPropertyName =$true
        )]
        [string[]]$ComputerName 
    )

    process {
        foreach ($Computer in $ComputerName) {
            $Bios = $OS = $null
            Write-Verbose -Message "Attempting to gather SysInfo from $Computer"
            try {
                if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
                    if ($PSCmdlet.ShouldProcess($Computer,'Query with Get-CimInstance')) {
                        $CimSession = New-CimSession -ComputerName $Computer
                        $Bios = Get-CimInstance -ClassName Win32_BIOS -CimSession $CimSession -ErrorAction Stop
                        $OS = Get-CimInstance -ClassName Win32_OperatingSystem -CimSession $CimSession -ErrorAction Stop
                    }
                    [pscustomobject]@{
                        BiosSerial   = $Bios.SerialNumber
                        OSName       = $OS.Caption
                        ComputerName = $Computer
                        Message      = $null
                    }
                } else {
                    [pscustomobject]@{
                        BiosSerial   = $null
                        OSName       = $null
                        ComputerName = $Computer
                        Message = 'Could not be pinged'
                    }
                }
            } catch {
                Write-Warning $_
            }
        }
    }
}
 'doesnotexist','DESKTOP-39N2M0T' | Get-SysInfo -Verbose





