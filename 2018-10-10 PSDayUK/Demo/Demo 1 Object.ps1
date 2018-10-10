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
New-Object -TypeName PSCustomObject -Property @{
    Property1 = 'Hello'
}

$PSVersiontable

$OrderedHash = [ordered]@{
    Property1 = 'Hello'
}
$Object = New-Object -TypeName PSCustomObject -Property $OrderedHash
$Object

$Object | Add-Member -MemberType NoteProperty -Name 'Property2' -Value 'World'
$Object

$var = [pscustomobject]@{
    Property1 = 'Hello'
    Date      = Get-Date
    Ticks     = (Get-Date).Ticks    
} | Export-Csv -Path C:\Temp\TestObject.csv -Delimiter ';'

ii C:\temp\TestObject.csv

1..42 | ForEach-Object {
    [pscustomobject]@{
        Property1 = 'Hello'
        Date      = Get-Date
        Ticks     = (Get-Date).Ticks
        'Object#' = $_    
    }
} | ConvertTo-Csv -Delimiter ';'