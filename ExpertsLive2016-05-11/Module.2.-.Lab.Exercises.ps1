#region Exercise 1
New-Variable -Name Text -Value 'Hello World!'
Write-Output -InputObject $Text 
Write-Output $Text 
Echo $Text
$Text


$Text | Get-Member

$Text.Length

$Text.Substring(4)

$Text.Substring

$Text.Substring(6,5)
#endregion

#region Exercise 2
$true
$false 

[boolean]0
[boolean]16 

[boolean]''
[boolean]'true' 

[boolean]'false' 

[boolean]$false 

$value = 16
if (($value -eq $value) -eq 'false') {
    "The value '$value' is not equal to '$value'"
} 
#endregion

#region Exercise 3
$Array = 1..10

$Array[5]

$Array[5] = 'Six'

$Array = $Array + 11
$Array += 12

$Array

$Array | Get-Member | Select-Object -Property TypeName -Unique

$Date  = Get-Date
$Array = $Array + $Date
$Array
#endregion

#region Exercise 4
$HashTable = @{
    Key1 = 'value'
    'N2' = '2nd value'
}

$HashTable

$HashTable.Third = 3
$HashTable

$PSObject = New-Object -TypeName PSCustomObject -Property @{
    'Property1' = 1
    '123'       = 'onetwothree'
    'Date'      = Get-Date
}
$PSObject

$PSObject.NewProperty = 1

$String = '12345678'
$String[6..($String.Length)]
$String[6..999]

[pscustomobject]@{
    1 = 'one'
    2 = 'two'
}

New-Object -TypeName PSCustomObject -Property $HashTable
[pscustomobject]$HashTable
#endregion

#region Exercise 5
$String = 'The quick brown fox jumps over the lazy dog'

$String += 123
$String

$String -replace 'brown fox','polarbear'

"The string is: $String"
'The string is: $String'

'The string is: {0}' -f $String

'{0:X2}' -f 64
'{0:P2}' -f 0.66666
'{0:N2}' -f 3.99999
#endregion