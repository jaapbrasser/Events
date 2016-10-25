# Use a basic filter for LDAP Queries 
([adsisearcher]'(samaccountname=JaapBrasser)').FindAll()

# Use the ANR filter for LDAP Queries 
([adsisearcher]'(anr=Jaap Brasser)').FindAll()

# Disable a user account
$User = [adsi]([adsisearcher]"samaccountname=jbrasser").findone().path
$User.psbase.invokeset('AccountDisabled','True')
$User.SetInfo()

# Get All User accounts in an OU
$Searcher            = [adsisearcher]''
$Searcher.Filter     = '(&(objectclass=user)(objectcategory=person))'
$Searcher.PageSize   = 500
$Searcher.SearchRoot = 'LDAP://OU=BestUsers,DC=psconfasia,DC=com'
$Searcher.FindAll()

# Get All User accounts in an OU
$Searcher             = [adsisearcher]''
$Searcher.Filter      = '(&(objectclass=user)(objectcategory=person))'
$Searcher.PageSize    = 500
$Searcher.SearchRoot  = 'LDAP://DC=psconfasia,DC=com'
$Searcher.SearchScope = 'Subtree'
$Searcher.FindAll()

# List possible values of SearchScope
[system.enum]::GetNames([System.DirectoryServices.SearchScope])

# Change password for user
$User = [adsi]([adsisearcher]'samaccountname=jbrasser').findone().path
$User.SetPassword("SuperSecret01")
$User.psbase.InvokeSet("AccountDisabled",$false)
$User.SetInfo()

# Find users with password never expires 
$Searcher = New-Object DirectoryServices.DirectorySearcher -Property @{
    Filter =` '(&(sAMAccountType=805306368)(userAccountControl:1.2.840.113556.1.4.803:=65536))'
    PageSize = 100
}
$Searcher.FindAll()

# sAMAccountType=805306368 -eq '(&(objectclass=user)(objectcategory=person))'
# Useraccountcontrol is a collection of flags, 65536 corresponds with the password does not expire flag 