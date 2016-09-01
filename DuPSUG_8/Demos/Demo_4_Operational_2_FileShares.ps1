. 'C:\DuPSUG 8\Testing in PowerShell\Demos\HelperFunctions\ConvertFrom-SDDL.ps1'
$XMLPath = '.\Demo_4_Operational_2_FileShares_PesterShares.xml'

# Show the stored values
Get-Content $XMLPath
Import-CliXml $XMLPath | Select Name,LocalPath,Description

Get-SmbShare

Import-CliXml .\PesterShares.xml | ForEach-Object {
    $Share = Get-SmbShare -Name $_.Name -ErrorAction SilentlyContinue
    Describe "SMBShare Operation validation share $($_.Name) on $($env:computername)" -Tags 'DFSnShares' {
        It "Share Name $($_.Name)  matches stored value" {
            $_.Name | Should be $Share.Name
        }
        It "Description '$($_.Description)' matches stored value" {
            $_.Description | Should Be $Share.Description
        }
        It "Share Path $($_.Path) matches stored value" {
            $_.Path | Should Be $Share.Path
        }
        It "Security permissions matches stored values"   {
            $_.SecurityDescriptor | Should be $Share.SecurityDescriptor
        }
    }
}

Import-Clixml $XMLPath |
Where-Object {$_.Name -eq 'Git'} |
ForEach-Object {
    (ConvertFrom-SDDL $_.SecurityDescriptor).Access
} | Format-Table -AutoSize -Property IdentityReference, Rights

Get-SmbShareAccess -Name Git

Revoke-SmbShareAccess -Name Git -AccountName JaapBrasser -Force

Grant-SmbShareAccess -Name Git -AccountName JaapBrasser -AccessRight Read -Force