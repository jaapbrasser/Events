New-MsolUser -DisplayName "Jaap Test" -FirstName Jaap -LastName Test -UserPrincipalName jaaptest@everythingisawesome.onmicrosoft.com -UsageLocation US -LicenseAssignment contoso:ENTERPRISEPACK

$UserSplat = @{
    DisplayName = 'Jaap Test'
    FirstName = 'Jaap'
    LastName = 'Test'
    UserPrincipalName = 'jaaptest@everythingisawesome.onmicrosoft.com'
    LicenseAssignment = $null
}

New-MsolUser @UserSplat

Get-MsolUser -SearchString jaaptest | Remove-MsolUser

Import-Csv -Path C:\temp\Users.csv | ForEach-Object {
    $UserSplat = @{
        DisplayName = $_.DisplayName
        FirstName = $_.FirstName
        LastName = $_.LastName
        UserPrincipalName = $_.UserPrincipalName
        LicenseAssignment = $_.LicenseAssignment
    }

    New-MsolUser @UserSplat
}