# Set Default ISE options
#break
$PSISE.Options.Zoom = 250

#region Define variable in PowerShell
New-Variable -Name Text -Value 'Hello Paris!' -Force
$Text | Write-Output
$Text

Set-Variable -Name Variable -Value 'Awesome!'

$Variable

$Variable = 'This also works'
$Variable

Get-Command -Noun Variable

Clear-Variable -Name Variable

$Variable = $null

$Variable.Gettype()

'Hello Paris!' | Tee-Object -Variable Tee
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

Get-Service |
Where-Object {$_.Status -eq 'Running'} -OutVariable Jaap
$Jaap

Get-Command -ParameterName Outvariable

Get-Command -ParameterName Outvariable | Measure-Object
(Get-Command -ParameterName Outvariable).Count

Get-Command blahblah 
$PSVersiontable

Measure-Command {ping.exe 127.0.0.1}

Get-Date
ping.exe 127.0.0.1
Get-Date | Select-Object -Property *
#endregion

#region Access different methods and properties on an object
1 | Get-Member -MemberType Method
(1).ToInt16($null)
$bytes = [int32]5GB
$bytes

Get-Item -Path 'C:\Users\JaapBrasser\OneDrive - Brasser Advisory Services\Administration\Training\Dec16 - IPsoft PowerShell Scripting and Automation Training Course\IPsoft - PowerShell Fundamentals.pptx' |
Select-Object -ExpandProperty VersionInfo

Get-Item C:\Windows\system32\cmd.exe | Select-Object -ExpandProperty vers*
(Get-Item C:\Windows\system32\cmd.exe).VersionInfo.ProductVersion

Get-Date
$Date = Get-Date
$Date.GetType()
$Date | Select-Object -Property *

$Date.Date
$Date.Date.GetType()

$Date | Get-Member -MemberType Method
$Date.ToUniversalTime()

$Date.Ticks
[int](Get-Date -uformat '%s')*1000

Get-PSDrive

$Date | Get-Member

$Date.AddHours(3.5)
$Date.AddHours(5/60)
$Date = $Date.AddDays(28)
$Date.AddMonths(-12)
$EndDate = Get-Date

$EndDate - $Date.AddYears(-1)

$Now    = Get-Date 
$Lunch = Get-Date 12:30

$Lunch - $Now

5 * 5

10GB/4KB

notepad.exe
$NotepadProc = Get-Process -Name notepad
$NotepadProc | Get-Member
$NotepadProc.Kill

$NotepadProc.Kill()

$a = $b = 'Hello Paris!'

$c, $d = 'thebeard\servername' -split '\\'

$Hash = @{}
$Hash.DomainName , $Hash.ComputerName = 'thebeard\servername' -split '\\'
$Hash
#endregion


#region Working with strings in PowerShell
$Text = 'Paris!'

"hello " + $Text

"hello $Text !!"

'hello $text'

'hello {0}' -f $Text
'hello $text = {0}' -f $Text 
"hello `$text = $text"

"hello {0} {1} {2}" -f 'a','b','c'

'hello '' ' + $Text + ' '' '
"hello '$Text'"
'hello "Jaap"'

"Hallo `"Jaap`" !"

@"
            Hello hello!
                    This is cool!
    "$Text"
"@

"
            Hello hello!
                    This is cool!
    $Text
"
#endregion

#region Create an array and a hash table in PowerShell
$Array = @('Hello','Hi')

$Array
$Array.GetType()
$Array | Get-Member

Get-Process | Get-Member
Get-ChildItem -Path C:\ -Force | Get-Member

$Array = $Array + '123'
$Array += 'Paris'
$Array
$Array.Count

$Array = @()
Measure-Command {
    1..10000 | ForEach-Object {$Array += $_}
}

$Array = 1..10000

Measure-Command {
    $Array = 1..10000
}

get-Childitem | ForEach-Object {
    $Array += $PSItem
}

$Array = Get-ChildItem |
Where-Object {$PSItem.Extension -match 'exe'} |
Measure-Object |
Select-Object -Property Count


$Array.Count

[char[]](65..90)

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

[pscustomobject]$hashtable | Export-Csv C:\MSCloudSummitParis\1.csv -NoTypeInformation
Invoke-Item .\1.csv

$Array = @('Hello','World')
$array += ,,@('Hello','World')
$Array
#endregion

#region Creating PowerShell custom objects
New-Object -TypeName PSCustomObject -Property @{
    Property1 = 'Hello'
}

$PSVersiontable

$OrderedHash = [ordered]@{
    Property1 = 'Hello'
}
New-Object -TypeName PSCustomObject -Property $OrderedHash

$var = [pscustomobject]@{
    Property1 = 'Hello'
    Date      = Get-Date
    Ticks     = (Get-Date).Ticks    
} | Export-Csv -Path C:\MSCloudSummit\TestObject.csv -Delimiter ';'

ii C:\MSCloudSummit\TestObject.csv

Invoke-Item .\TestObject.csv

Get-Command *export*
Get-Command *convert*

$Var | ConvertTo-Html

1..10
-5..-25
#endregion