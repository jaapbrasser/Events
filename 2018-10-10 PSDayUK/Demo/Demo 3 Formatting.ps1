Get-Process code | ForEach-Object
{
    Write-Output 'This is a process'
}

# Backtick to escape 
Get-Process code | ForEach-Object `
{
    Write-Output 'Best line continuation character'
}

# Pipe for natural line breaks
Get-Process code | 
ForEach-Object {
    'This is a code process'
}

# Escape anything!
Wr`it`e-`O`ut`p`ut 'T`est'

# Using backticks for line continuation
Get-Process code | `
| ForEach-Object `
{
    $_.Name
}
#endregion

#region breaking it right
Get-Process code | 
    ForEach-Object {
    $_.
    Name
}

# other examples:
$array = 'a',
    0xa,
    13

$Array

$putanythinghere = (
    ping www.powershellgallery.com
    Get-Date
)

[int]::
MaxValue

$Allmydata = 1..10 | 
    ForEach-Object {
        ps
    }

$Allmydata


# How to work with long commands
New-ADUser -SamAccountName jbrasser -UserPrincipalName jbrasser.rubrik.com -Name JBrasser -DisplayName 'Jaap Brasser' -GivenName Jaap -SurName Brasser -Department IT -Path "CN=Users,DC=rubrik,DC=com" -AccountPassword (ConvertTo-SecureString "PSDayIsAwesome!" -AsPlainText -force) -Enabled $True -PasswordNeverExpires $True

New-AdUser -SamAccountName jbrasser `
           -UserPrincipalName jbrasser.rubrik.com `
           -Name JBrasser `
           -DisplayName 'Jaap Brasser' `
           -GivenName Jaap `
           -SurName Brasser `
           -Department IT `
           -Path "CN=Users,DC=rubrik,DC=com" `
           -AccountPassword (ConvertTo-SecureString "PSDayIsAwesome!" -AsPlainText -force) `
           -Enabled $True `
           -PasswordNeverExpires $True

$Splat = @{
    SamAccountName = 'jbrasser'
    UserPrincipalName = 'jbrasser.rubrik.com'
    Name = 'JBrasser'
    DisplayName = 'Jaap Brasser'
    GivenName = 'Jaap'
    SurName = 'Brasser'
    Department = 'IT'
    Path = 'CN=Users,DC=rubrik,DC=com'
    AccountPassword = (ConvertTo-SecureString "PSDayIsAwesome!" -AsPlainText -force)
    Enabled = $True
    PasswordNeverExpires = $True
}

$Splat

New-ADUser @Splat

$Splat.SamAccountName = 'NotJaap'

$Splat

# Types

# So how many types do we have
[System.AppDomain]::CurrentDomain.GetAssemblies()
[System.AppDomain]::CurrentDomain.GetAssemblies() | Measure-Object

[System.AppDomain]::CurrentDomain.GetAssemblies().GetTypes() | Measure-Object

# Type conversion
5 + '5'
'5' + 5

(5 + '5').GetType()
('5' + 5).GetType()

7.0 + 5
(7.0 + 5).GetType()

5 + '7.0' + 4
5 + ’7.0‘ + 4

'true' -eq 'true'
'true' -eq $true
$true -eq 'true'
$false -eq 'false'
'false' -eq $false

# Additional
$x = 'Something'

# Now display something
$x = 'Something'
$x

'Something' | Tee-Object -Variable X 

'Something' | Tee-Object -FilePath C:\Temp\tee.log
cat C:\temp\tee.log

$($x = 'Something')
($x = 'Something')