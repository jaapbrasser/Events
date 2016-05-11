# Set Default ISE options
break
$PSISE.Options.Zoom = 160

#region Define variable in PowerShell
New-Variable -Name Text -Value 'Hello World!'
$Text | Write-Output
$Text

Set-Variable -Name Variable -Value 'Awesome!'

$Variable

$Variable = 'This also works'
$Variable

Get-Command -Noun Variable

'Hello world!' | Tee-Object -Variable Tee
$Tee

Get-Service |
Where-Object {
    $_.Status -eq 'Running'
} |
Tee-Object -Variable Srv

$Srv

$Services = Get-Service | Where-Object {$_.Status -eq 'Running'} 
$Services
$Tee

Get-Service | Where-Object {$_.Status -eq 'Running'} -OutVariable Jaap
$Jaap

Get-Command -ParameterName Outvariable

Get-Command -ParameterName Outvariable | Measure-Object

Measure-Command {ping.exe 127.0.0.1}

Get-Date
ping.exe 127.0.0.1
Get-Date | Select-Object -Property *
#endregion

#region How PowerShell determines what type an object is
$Object = 1
$Object | Get-Member
$Object.GetType()
$Object.GetType
$Object = '1'
$Object | Get-Member

$Object = ping.exe localhost
$Object | Get-Member
$Object.GetType()

$Object

$Object = 1 -as [string]
$Object.GetType()

$Object = Get-Process
$Object | Get-Member

$NotePad = $Object | Where-Object ProcessName -eq 'notepad'

$Object | Where-Object ProcessName -like 'powershell*'

$Notepad

$Notepad | Get-Member

$Notepad.Kill()
#endregion

#region Access different methods and properties on an object
Set-Location -Path D:\
cd d:\

Get-Item -Path .\Module.0.-.Introduction.pptx |
Select-Object -ExpandProperty VersionInfo

Get-Item C:\Windows\system32\cmd.exe | select -exp vers*

Get-Date
$Date = Get-Date
$Date.GetType()
$Date | Select-Object -Property *

$Date.Date
$Date

Get-PSDrive

$Date | Get-Member

$Date.AddHours(3.5)
$DAte.AddDays(28)
$EndDate = Get-Date

$EndDate - $Date

$nu    = Get-Date 
$Lunch = Get-Date 12:30

$Lunch - $Nu

5 * 5

10GB

notepad.exe
$NotepadProc = Get-Process -Name notepad
$NotepadProc | Get-Member
$NotepadProc.Kill

$NotepadProc.Kill()
#endregion

#region Set an object as a specific object type
$Variable = 1
$Variable = ‘1’
$Variable = 1 –as [string]
$Variable = [int64]1
[string]$Variable = 1

$Variable.GetType().FullName
#endregion

#region Working with strings in PowerShell
$Text = 'Jaap'

"hello " + $Text

"hello $Text !!"

'hello $text'

'hello {0}' –f $Text
'hello $text = {0}' -f $Text 
"hello `$test = $text"

"hello {0} {1} {2}" -f 'a','b','c'

'hello ''' + $Text + ''''
"hello '$Text'"
'hello "Jaap"'

"Hallo `"Jaap`" !"
#endregion

#region Create an array and a hash table in PowerShell
$Array = @('Hello','Hi')

$Array
$Array | Get-Member

$Array = $Array + '123'
$Array += 'World'
$Array

$String = 'Hello'
$String

$String += 'World'
$String

$NewArray = Get-Process
$NewArray.GetType().FullName
$NewArray.GetType().BaseType

$HashTable = @{
    key  = 'value'
    123  = 'onetwothree'
    Jaap = 'PowerShell'
    Answ = 42
}
$HashTable

$HashTable.Answ
$HashTable

$HashTable = [ordered]@{
    key  = 'value'
    123  = 'onetwothree'
    Jaap = 'PowerShell'
    Answ = 42
}
$HashTable

$Array = @('Hello','World')
$array += ,,@('Hello','World')
$Array
#endregion

#region Creating PowerShell custom objects
New-Object –TypeName PSCustomObject –Property @{
    Property1 = ‘Hello’
}

$OrderedHash = [ordered]@{
    Property1 = ‘Hello’
}
New-Object –TypeName PSCustomObject –Property $OrderedHash

[pscustomobject]@{
    Property1 = ‘Hello’
    Date      = Get-Date
    Ticks     = (Get-Date).Ticks    
} | Export-Csv -PAth TestObject.csv -Delimiter ';'

Invoke-Item .\TestObject.csv

Get-Command *export*
Get-Command *convert*

1..10
-5..-25

1..42 | ForEach-Object {
    [pscustomobject]@{
        Property1 = ‘Hello’
        Date      = Get-Date
        Ticks     = (Get-Date).Ticks
        'Object#' = $_    
    }
} | Export-Csv -Path 42ObjectNoType.csv -Delimiter ';' -NoTypeInformation
ii .\42Object.csv

1..42 | ForEach-Object {
    [pscustomobject]@{
        Property1 = ‘Hello’
        Date      = Get-Date
        Ticks     = (Get-Date).Ticks
        'Object#' = $_    
    }
} | ConvertTo-Csv -Delimiter ';'

ii .\42ObjectNoType.csv

Import-Csv .\42ObjectNoType.csv | Export-Clixml -Path CLI.xml
notepad cli.xml
#endregion