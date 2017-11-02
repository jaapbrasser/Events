function Invoke-PSRemoting {
    $Session = New-PSSession -ComputerName .
    Invoke-Command -Session $Session {
        Get-Service wuauserv
    } | Select Status,Name,DisplayName
}

function Invoke-PsExec {
    $Output = C:\SysinternalsSuite\PsExec.exe `
        -nobanner -s powershell.exe -nop -ex bypass `
        -c "& {`
            Get-Service wuauserv | Select Status,Name,DisplayName | Export-CliXml C:\Temp\PSExec.xml `
            `$RemoteBytes = [io.file]::ReadAllBytes('C:\Temp\PSExec.xml')`
            [convert]::ToBase64String(`$RemoteBytes)`
    }" 2> $null
    $LocalBytes = [convert]::FromBase64String($Output)

    $FileName = [io.path]::GetRandomFileName()

    [io.file]::WriteAllBytes($FileName, $LocalBytes)

    Import-Clixml -LiteralPath $FileName
}


function Invoke-WmiExecution {
    $WmiProc = [wmiclass]'win32_process'
    $WmiProc.Scope.Path = "\\PSConfAsia2017\root\cimv2"
    $Results = $WmiProc.Create(
        'powershell.exe -nop -ex bypass -c "& {
            Get-Service wuauserv | Export-CliXml /temp/Object.Xml
            $ByteArr = Get-Content /temp/object.xml -Encoding Byte -Readcount 0
            New-ItemProperty -Path HKLM:\SOFTWARE\2017PSConfAsia -Name Object -Value $ByteArr -PropertyType Binary -Force
        }"'
    )

    Start-Sleep -Seconds 1

    # MSDN GetBinaryValue: https://msdn.microsoft.com/en-us/library/aa390440(v=vs.85).aspx
    $H = @{
        hklm  = 2147483650
        key   = "SOFTWARE\2017PSConfAsia"
        value = "Object"
    }

    $wmi = [wmiclass]"\\PSConfAsia2017\root\default:stdRegProv"
    $LocalBytes = ($wmi.GetBinaryValue($H.hklm,$H.key,$H.value)).uvalue

    $FileName = [io.path]::GetRandomFileName()
    [io.file]::WriteAllBytes($FileName, $LocalBytes)

    Import-CliXml -Path $FileName | Select Status,Name,DisplayName
}


Write-Verbose -Message 'PSRemoting' -Verbose
Invoke-PSRemoting | gm

Write-Verbose -Message 'PSExec' -Verbose
Invoke-PSExec | gm

Write-Verbose -Message 'Wmi' -Verbose
Invoke-WmiExecution| gm