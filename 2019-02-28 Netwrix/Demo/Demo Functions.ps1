function Get-ExternalMailRules {
    param (
        [pscredential] $Credential,
        [string[]] $TrustedDomain
    )

    $Splat = @{
        ConfigurationName = 'Microsoft.Exchange'
        ConnectionUri = 'https://outlook.office365.com/powershell-liveid/'
        Credential = $Credential
        Authentication = 'Basic'
        AllowRedirection = $true
    }

    $Session = New-PSSession @Splat

    Invoke-Command -Session $Session {Get-MailBox | Get-InboxRule -ErrorAction SilentlyContinue} |
    Where-Object {
        # Regex extracts only the domainname from the ForwardTo / Forward
        if ($_.ForwardTo) {
            if (($_.ForwardTo -replace '.*?".*?@(.*?)".*','$1') -notin $TrustedDomain) {
                $true
            }
        } elseif ($_.ForwardAsAttachmentTo) {
            if (($_.ForwardAsAttachmentTo -replace '.*?".*?@(.*?)".*','$1') -notin $TrustedDomain) {
                $true
            }
        }
    } | Select-Object -Property MailBoxOwnerId, Name, ForwardTo, ForwardAsAttachmentTo
}