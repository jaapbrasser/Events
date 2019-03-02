$Splat = @{
    ConfigurationName = 'Microsoft.Exchange'
    ConnectionUri = 'https://outlook.office365.com/powershell-liveid/'
    Credential = 'jaap@everythingisawesome.onmicrosoft.com'
    Authentication = 'Basic'
    AllowRedirection = $true
}

Enter-PSSession @Splat

Get-Command | Select-Object -Property Name

Get-Command | Select-Object -Property Name | Measure-Object

Get-Mailbox jaap*

Get-Mailbox jaap* | Select-Object *

Get-Mailbox jaap* | Select *
Get-Mailbox jaap* | fl *

Get-Mailbox jaap* | Get-InboxRule

Get-InboxRule -Mailbox jaap@everythingisawesome.onmicrosoft.com

Get-InboxRule -Mailbox jaap@everythingisawesome.onmicrosoft.com | Select-Object *

Get-InboxRule -Mailbox jaap@everythingisawesome.onmicrosoft.com | Select-Object -Property ForwardTo

Get-Mailbox | Get-InboxRule | Select-Object -Property ForwardTo,MailBoxOwnerID