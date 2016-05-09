#region Exercise 1
foreach ($Number in 1..10) {
    "The number is: $Number"
}

$Files = Get-ChildItem -Path $Env:USERPROFILE\Documents -File
for ($i = 0; $i -lt $Files.Count; $i++) { 
    "File($i): {0}" -f $Files[$i].Name
}

Get-Content -Path $env:windir\win.ini | ForEach-Object {
    "The win.ini contains: '$PSItem'"
}
#endregion

#region Exercise 2
$Count = 1
do {
    "The counter is $Count"
    $Count++
} while ($Count -le 10)

$Count = 1
while ($Count -le 10) {
    "The counter is $Count"
    $Count++
}

Stop-Service -Name wuauserv
do {
    Start-Sleep -Seconds 5
    Start-Service wuauserv
} until ((Get-Service wuauserv).Status -eq 'Running')
'Windows Update service is {0}' -f (Get-Service wuauserv).Status

Get-Help about_Operators -ShowWindow
#endregion

#region Exercise 3
$RandomValue = 1..5 | Get-Random
if ($RandomValue -eq 1) {
    'The value is one'
} elseif ($RandomValue -eq 2) {
    'The value is two'
} elseif ($RandomValue -eq 3) {
    'The value is three'
} elseif ($RandomValue -eq 4) {
    'The value is four'
} else {
    'The value is not 1 through 4'
}

switch ($RandomValue) {
    1          {'The value is one'}
    {$_ -eq 2} {'The value is two'}
    {$_ -gt 2} {'The value is greater than two'}
    Default    {'The value is not as expected'}
}
#endregion

#region Exercise 4
Get-ChildItem -Path $Env:USERPROFILE -File |
Where-Object {$_.Name[0] -eq 'a'} | ForEach-Object {
    Rename-Item -Path $_.FullName -NewName ('{0}.ThisFileIsRenamed' -f $_.FullName) -WhatIf
}
#endregion