param (
    [string[]] $Array,
    [int]      $Integer
)
'Array contains  : {0}' -f ($Array -join ';')
'Array type is   : {0}' -f $Array.GetType().ToString()
'Array count     : {0}' -f $Array.Count
'Integer contains: {0}' -f $Integer
'Integer type is : {0}' -f $Integer.GetType().ToString()


powershell -noprofile -file c:\temp\Test-Script.ps1 stuff 123

powershell -noprofile -file c:\temp\Test-Script.ps1 stuff morestuff evenmore 123

powershell -noprofile -file c:\temp\Test-Script.ps1 'stuff','morestuff','evenmore' 123

powershell -noprofile -file c:\temp\Test-Script.ps1 @('stuff','morestuff','evenmore') 123

powershell -noprofile -command "C:\Temp\Test-Script.ps1 -Array stuff, morestuff, evenmore -Integer 123"

# Bonus 64bit
c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe -noprofile -command "[Environment]::Is64BitProcess"
c:\windows\syswow64\WindowsPowerShell\v1.0\powershell.exe -noprofile -command "[Environment]::Is64BitProcess"

powershell.exe -Sta
powershell.exe -Mta