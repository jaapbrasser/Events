Get-ADGroupMemberDate -Group 'Domain Admins'

Add-ADGroupMember  -Identity 'Domain Admins' -Members MaliciousUser

Get-ADGroupMemberDate -Group 'Domain Admins'
Get-ADGroupMember  -Identity 'Domain Admins'

Remove-ADGroupMember -Identity 'Domain Admins' -Members MaliciousUser

Get-ADGroupMemberDate -Group 'Domain Admins'
Get-ADGroupMember  -Identity 'Domain Admins'

$DomainAdmins = (Get-ADGroup -Identity 'Domain Admins').DistinguishedName
repadmin /showobjmeta server $DomainAdmins