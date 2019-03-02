Connect-MsolService

Get-MsolUser -SearchString 'Jaap'

Get-MsolUser -UserPrincipalName jaap@everythingisawesome.onmicrosoft.com

Get-MsolUser -UserPrincipalName jaap@everythingisawesome.onmicrosoft.com | Select-Object *

Get-MsolUser -UnlicensedUsersOnly -SearchString 'Error'

# Get-MsolUser -UnlicensedUsersOnly

Get-MsolAccountSku

Get-MsolUser -UserPrincipalName jaap@everythingisawesome.onmicrosoft.com | Select-Object Licenses