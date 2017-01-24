#region Define credentials
$Credential = Get-Credential

$Credential

$Credential | Export-Clixml C:\MSCloudSummitParis\Credentials.Jaap 

Get-Content -Path C:\MSCloudSummitParis\Credentials.Jaap

Install-Module dbatools -Verbose
#endregion

#region SharePoint Online
$HashStore = @{
    SharePointPath = 'C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.Online.SharePoint.PowerShell.dll'
    SharePointUrl  = 'https://contoso-admin.sharepoint.com'
}

Import-Module -Name $HashStore.SharePointPath 

Connect-SPOService -Url $HashStore.SharePointUrl -Credential $Credential

Get-SPOSite | Select-Object -Property LastContentModifiedDate,Status,Url

Get-SpoUser -Site 'https://contoso-my.sharepoint.com/' | Format-Table -AutoSize

Get-Command -Module Microsoft.Online.SharePoint.PowerShell
Get-Command -Module Microsoft.Online.SharePoint.PowerShell | Measure-Object
#endregion

#region Exchange Online
$PSSplat = @{
    ConfigurationName = 'Microsoft.Exchange'
    ConnectionUri     = 'https://outlook.office365.com/powershell-liveid/'
    Credential        = $Credential
    Authentication    = 'Basic'
    AllowRedirection  = $true
}

Enter-PSSession @PSSplat
Get-Command | Measure-Object

Get-User | fl * 
Get-User me | Format-Table -AutoSize

Exit-PSSession

Invoke-Command @PSSplat -ScriptBlock {Get-User me | Format-Table -AutoSize}
Invoke-Command @PSSplat -ScriptBlock {Get-User me} | Format-Table -Property Name,PhoneNumber -AutoSize

Invoke-Command @PSSplat -ScriptBlock {Get-Mailbox} | Format-Table -AutoSize
#endregion

#region Skype Online
$HashStore = @{
    SkypeOnlinePath = 'C:\Program Files\Common Files\Skype for Business Online\Modules\SkypeOnlineConnector\SkypeOnlineConnector.psd1'
    SkypeOnlineUrl  = 'https://contoso.onmicrosoft.com'
}

Import-Module $HashStore.SkypeOnlinePath -Force

$SkypeOnline = New-CsOnlineSession -Credential $Credential

Enter-PSSession -Session $SkypeOnline

Get-Command | Measure-Object

Get-CsMeetingConfiguration | Select-Object -Property AllowConferenceRecording

Set-CsMeetingConfiguration -AllowConferenceRecording $true

Get-CsMeetingConfiguration | Select-Object -Property AllowConferenceRecording
#endregion 