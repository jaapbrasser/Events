# Set Default ISE options
break
$PSISE.Options.Zoom = 160

#region foreach
Invoke-Item .\Computers.txt
$Servers = Get-Content -Path .\Computers.txt
$Servers
foreach ($Computer in $Servers) {
    echo "The current server is: $Computer"
}

Get-Alias echo

foreach ($Computer in $Servers) {
    "The current server is: $Computer"
} | Set-Content -Path ThisFile.txt
#endregion

#region fori
$Number = 5
$Number
$Number = $Number + 1
$Number += 1
$Number++

for ($i = 1; $i -le 10; $i++) { 
    Write-Output $i
}

$Process = Get-Process
$Process.Count
for ($i = 0; $i -lt $Process.Count; $i+=5) { 
    $Name = $Process[$i].ProcessName
    Write-Output "Process ($i): $Name"
}

$Process = Get-Process
for ($i = 1; $i -lt $Process.Count; $i = $i + 5) { 
    $Name = $Process[$i].ProcessName
    Write-Output "Process ($i): $Name"
}
#endregion

#region ForEach-Object
Get-Service | ForEach-Object {
    $_.Name
} | clip.exe

Get-ChildItem C:\Users\jbrasser\Downloads | Set-Clipboard

$Servers | ForEach-Object {
    "Server: $_"
} | Set-Content D:\test.txt

notepad D:\test.txt

$Servers|%{"Server: $_"}

$FilePath = 'D:\test.txt'
$Servers|% -Begin {
    'Listing processes...'
} -Process {
    "Server: $_"
} -End {
    'Completed listing process, output is in {0}' -f $FilePath
}

$Jaap = 12

function Show-Jaap {
    $global:Jaap = 42
    "Jaap is $Jaap"
}

Show-Jaap

$Jaap

Get-Help about_scopes
#endregion

#region do-while-until
do {
    'Oh no! Notepad is not running!'
    Start-Sleep -Seconds 2
    [console]::Beep()
} while (-not (Get-Process notepad -ErrorAction SilentlyContinue))

while (-not (Get-Process notepad -ErrorAction SilentlyContinue)) {
    'Oh no! Notepad is not running!'
    Start-Sleep -Seconds 2
    [console]::Beep()
}

do {
    'Oh no! Notepad is not running!'
    Start-Sleep -Seconds 2
} until ((Get-Process notepad -EA 0))

while (-not (Get-Process notepad -ErrorAction SilentlyContinue)) {
    'Oh no! Notepad is not running!'
    Start-Sleep -Seconds 2
}
#endregion

$x = 'value3'
switch ($x) {
    'value3' {Get-Date;break}
    'value1' {'1'}
    {$_ -eq 'value3'} {Get-Date}
    Default  {'default'}
}