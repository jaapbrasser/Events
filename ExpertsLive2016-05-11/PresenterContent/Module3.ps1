# Set Default ISE options
break
$PSISE.Options.Zoom = 160

#region foreach
Invoke-Item .\Computers.txt
$Servers = Get-Content -Path .\Computers.txt
$Servers
foreach ($Computer in $Servers) {
    "The current server is: $Computer"
}

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

$Servers | ForEach-Object {
    "Server: $_"
} | Set-Content D:\test.txt

$Servers|%{"Server: $_"}
#endregion

#region do-while-until
do {
    'Oh no! Notepad is not running!'
    Start-Sleep -Seconds 2
} while (-not (Get-Process notepad -EA 0))


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
    'value1' {'1'}
    'value3' {Get-Date}
    Default  {'default'}
}