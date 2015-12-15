function Get-SysInfo {
    [cmdletbinding(SupportsShouldProcess,ConfirmImpact='High')]
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
 'doesnotexist','DESKTOP-39N2M0T' | Get-SysInfo -Verbose -Confirm:$false