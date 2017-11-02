# Wmi Section
gwmi Win32_Bios

$WmiAccelerator = [wmisearcher]'select * from Win32_Bios'
$WmiAccelerator.Get()

# Why does this matter
$Timer = [System.Diagnostics.Stopwatch]::StartNew()
(1..100).ForEach{
    $null = Get-WmiObject -ClassName Win32_Bios
}
$Timer.Elapsed.TotalSeconds; $Timer.Restart()

$Timer = [System.Diagnostics.Stopwatch]::StartNew()
(1..100).ForEach{
    $null = Get-CimInstance -ClassName Win32_Bios
}
$Timer.Elapsed.TotalSeconds; $Timer.Restart()

$Timer = [System.Diagnostics.Stopwatch]::StartNew()
(1..100).ForEach{
    $WmiAccelerator = [wmisearcher]'select * from Win32_Bios'
    $null = $WmiAccelerator.Get()
}
$Timer.Elapsed.TotalSeconds; $Timer.Restart()


# Wmi Class to spawn a process
$WmiProc = [wmiclass]'win32_process'
$Results = $WmiProc.Create(
    'powershell.exe -noexit -nop -ex bypass -c "& {
        Get-Service wuauserv
    }"'
)
$Results

$WmiProc = [wmiclass]'win32_process'
$Results = $WmiProc.Create(
    'powershell.exe -nop -ex bypass -c "& {
        Get-Service wuauserv > c:\temp\output.log
    }"'
)

Get-Content -LiteralPath C:\temp\output.log

# Well that's great but it is not remote
$WmiProc = [wmiclass]'win32_process'
$WmiProc.Scope.Path = "\\PSConfAsia2017\root\cimv2"
$Results = $WmiProc.Create(
    'powershell.exe -nop -ex bypass -c "& {
        Get-Service wuauserv > c:\temp\output.log
    }"'
)

Get-Content -LiteralPath C:\temp\output.log

$WmiProc = [wmiclass]'win32_process'
$WmiProc.Scope.Path = "\\PSConfAsia2017\root\cimv2"
$Results = $WmiProc.Create(
    'powershell.exe -nop -ex bypass -c "& {
        Get-Service wuauserv | Export-CliXml /temp/Object.Xml
    }"'
)

Import-CliXml -Path /temp/Object.Xml
Import-CliXml -Path /temp/Object.Xml | Get-Member
Import-CliXml -Path /temp/Object.Xml | Select *

# Other ways to extract data, not using disk?
$WmiProc = [wmiclass]'win32_process'
$WmiProc.Scope.Path = "\\PSConfAsia2017\root\cimv2"
$Results = $WmiProc.Create(
    'powershell.exe -nop -ex bypass -c "& {
        Get-Service wuauserv | Export-CliXml /temp/Object.Xml
        $ByteArr = Get-Content /temp/object.xml -Encoding Byte -Readcount 0
        New-ItemProperty -Path HKLM:\SOFTWARE\2017PSConfAsia -Name Object -Value $ByteArr -PropertyType Binary -Force
    }"'
)


# MSDN GetBinaryValue: https://msdn.microsoft.com/en-us/library/aa390440(v=vs.85).aspx
$H = @{
    hklm  = 2147483650
    key   = "SOFTWARE\2017PSConfAsia"
    value = "Object"
}

$wmi = [wmiclass]"\\PSConfAsia2017\root\default:stdRegProv"
$LocalBytes = ($wmi.GetBinaryValue($H.hklm,$H.key,$H.value)).uvalue

$LocalBytes.GetType()

[io.file]::WriteAllBytes("C:\Local\RemoteObject.xml",$LocalBytes)

Import-CliXml -Path C:\Local\RemoteObject.xml

Import-CliXml -Path C:\Local\RemoteObject.xml | Select *