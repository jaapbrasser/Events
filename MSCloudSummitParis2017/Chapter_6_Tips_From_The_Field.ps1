#region fast folder size
Get-ChildItem -Path $home -Recurse -Force -ErrorAction SilentlyContinue |
Measure-Object -Property Length -Sum

cmd /c dir $home /-C /S /A:-D-L

(cmd /c dir $home /-C /S /A:-D-L)[-2]

(robocopy.exe $home c:\doesnotexist /L /XJ /R:0 /W:1 /NP /E /BYTES /nfl /ndl /njh /MT:64)[-4]

Measure-Command -Expression {
    (1..1).foreach{(Get-ChildItem -Path $home -Recurse -force -ea 0 | Measure-Object length -Sum).sum}
} | Select-Object -Property TotalMilliseconds 
 
Measure-Command -Expression {
    (1..1).foreach{((cmd /c dir $home /-C /S /A:-D-L)[-2] -split '\s+')[3]}
} | Select-Object -Property TotalMilliseconds 
 
Measure-Command -Expression {
    (1..1).foreach{((robocopy.exe $home c:\doesnotexist /L /XJ /R:0 /W:1 /NP /E /BYTES /nfl /ndl /njh /MT:64)[-4] -replace '\D+(\d+).*','$1')}
} | Select-Object -Property TotalMilliseconds
#endregion

#region adsi
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
$Searcher.SearchRoot = 'LDAP://OU=BestUsers,DC=mscloudsummit,DC=com'
$Searcher.FindAll()

# Get All User accounts in an OU
$Searcher             = [adsisearcher]''
$Searcher.Filter      = '(&(objectclass=user)(objectcategory=person))'
$Searcher.PageSize    = 500
$Searcher.SearchRoot  = 'LDAP://DC=mscloudsummit,DC=com'
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
    Filter   = '(&(sAMAccountType=805306368)(userAccountControl:1.2.840.113556.1.4.803:=65536))'
    PageSize = 100
}
$Searcher.FindAll()

# sAMAccountType=805306368 -eq '(&(objectclass=user)(objectcategory=person))'
# Useraccountcontrol is a collection of flags, 65536 corresponds with the password does not expire flag 
#endregion

#region powershell -command
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
#endregion

#region Efficient looping
$Collection = Get-Process
$result = @()
$CurrentDate = Get-Date
foreach ($Item in $Collection) {
    $Object = New-Object -TypeName PSCustomObject
    $Object | Add-Member -MemberType NoteProperty `
                         -Name 'FirstProperty'    `
                         -Value $Item.Name
    $Object | Add-Member -MemberType NoteProperty `
                         -Name 'SecondProperty'   `
                         -Value $Item.StartTime
    $Object | Add-Member -MemberType NoteProperty `
                         -Name 'ThirdProperty'    `
                         -Value $Item.Company
    $Object | Add-Member -MemberType NoteProperty `
                         -Name 'FourthProperty'   `
                         -Value $Item.Id
    $Object | Add-Member -MemberType NoteProperty `
                         -Name 'CurrentDate'      `
                         -Value $CurrentDate
    $result += $Object
}
$result

$Collection = Get-Process
$result = @()
$CurrentDate = Get-Date
foreach ($Item in $Collection) {
    $Object = New-Object -TypeName PSCustomObject -Property @{
        'FirstProperty'  = $Item.Name
        'SecondProperty' = $Item.StartTime
        'ThirdProperty'  = $Item.Company
        'FourthProperty' = $Item.Id
        'CurrentDate'    = $CurrentDate
    }
    $result += $Object
}
$result

$Collection = Get-Process
$CurrentDate = Get-Date
foreach ($Item in $Collection) {
    New-Object -TypeName PSCustomObject -Property @{
        'FirstProperty'  = $Item.Name
        'SecondProperty' = $Item.StartTime
        'ThirdProperty'  = $Item.Company
        'FourthProperty' = $Item.Id
        'CurrentDate'    = $CurrentDate
    }
}

$Collection = Get-Process
foreach ($Item in $Collection) {
    New-Object -TypeName PSCustomObject -Property @{
        'FirstProperty'  = $Item.Name
        'SecondProperty' = $Item.StartTime
        'ThirdProperty'  = $Item.Company
        'FourthProperty' = $Item.Id
        'CurrentDate'    = Get-Date
    }
}

Get-Process | ForEach-Object {
    [pscustomobject]@{
        'FirstProperty'  = $PSItem.Name
        'SecondProperty' = $PSItem.StartTime
        'ThirdProperty'  = $PSItem.Company
        'FourthProperty' = $PSItem.Id
        'CurrentDate'    = Get-Date
    }
}

Get-Process | Select-Object @{name = 'FirstProperty'  ; expression = {$PSItem.Name }},
                            @{name = 'SecondProperty' ; expression = {$PSItem.StartTime}},
                            @{name = 'ThirdProperty'  ; expression = {$PSItem.Company}},
                            @{name = 'FourthProperty' ; expression = {$PSItem.Id}},
                            @{name = 'CurrentDate'    ; expression = {Get-Date}}
#endregion

#region Convert word document to pdf
$Word = New-Object -ComObject "Word.Application"
($Word.Documents.Open('c:\users\jaapbrasser\desktop\file.docx')).SaveAs([ref]'c:\users\jaapbrasser\desktop\file.pdf',[ref]17)
$Word.Application.ActiveDocument.Close()
#endregion

#region Check compression of zip file
Add-Type -Assembly 'System.IO.Compression.FileSystem'
[System.IO.Compression.ZipFile]::Open("c:\mscloudsummitparis\MSCloudSummitParis.zip",'Read') | ForEach-Object {
     $_.Entries | ForEach-Object -Begin {
        [long]$TotalCompressed = $null
        [long]$TotalSize = $null
    } -Process {
        $TotalCompressed += $_.CompressedLength
        $TotalSize += $_.Length
    } -End {
        [pscustomobject]@{
            FileSize       = $TotalSize
            CompressedSize = $TotalCompressed
            Ratio          = "{0:P2}" -f ($TotalCompressed / $TotalSize)
        }
    }
}

1..5 | % {
    'Begin'
} {
    $_
} {
    'End'
}

Get-Alias '%'
#endregion

#region Use Shell.Application to determine which folder is open in File Explorer
$ShellApp = New-Object -ComObject Shell.Application
$ShellApp.Windows() | Where-Object {$_.Name -eq 'File Explorer'} | 
Select-Object LocationName,LocationURL  
#endregion

#region Change a drive letter using Win32_Volume class
Get-CimInstance -Query "SELECT * FROM Win32_Volume WHERE driveletter='F:'" | 
Set-CimInstance -Arguments @{DriveLetter="Z:"}
#endregion

#region Send ISE untitled tabs to clipboard
Function Send-UntitledToClip {
    $psISE.PowerShellTabs.Files | Where-Object {$_.IsUntitled} | ForEach-Object {
        $_.Editor.Text
    } | Set-Clipboard
} 
#endregion

#region Use Windows Forms to generate GUI messagebox
$null = Add-Type -AssemblyName System.Windows.Forms
$userchoice = [System.Windows.Forms.MessageBox]::Show(
    'Hello Paris','Caption','YesNoCancel','Question'
)
#endregion

#region Select non-administrative shared folders using Win32_Share WMI class
Get-CimInstance -Query "select * from Win32_Share where type=0" –ComputerName localhost
#endregion

#region Rename a local or a mapped drive using Shell.Application
$ShellObject = New-Object –ComObject Shell.Application
$DriveMapping = $ShellObject.NameSpace('U:')
$DriveMapping.Self.Name = 'NewName'
(New-Object -ComObject Shell.Application).NameSpace('U:').Self.Name='NewName'
#endregion

#region PSTip Using the System.Windows.Forms.OpenFileDialog Class
Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    InitialDirectory = [Environment]::GetFolderPath('MyDocuments')
    Filter = 'Documents (*.docx)|*.docx|SpreadSheet (*.xlsx)|*.xlsx'
}
$null = $FileBrowser.ShowDialog()
$FileBrowser.FileNames
#endregion

#region Query MSDN from PowerShell
Function Search-Msdn {
    param(
        [Parameter(Mandatory=$true)]
            [string[]]$SearchQuery,
        [System.Globalization.Cultureinfo]$Culture = 'en-US'
    )
 
    foreach ($Query in $SearchQuery) {
        Start-Process -FilePath "http://social.msdn.microsoft.com/Search/$($Culture.Name)?query=$Query"
    }
}
#endregion

#region Test local credentials
function Test-LocalCredential {
     
    [CmdletBinding()]
     
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$UserName,
        [string]$ComputerName = $env:COMPUTERNAME,
        [Parameter(Mandatory=$true)]
        [string]$Password
    ) 
     
    Add-Type -AssemblyName System.DirectoryServices.AccountManagement
    $DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('machine',$ComputerName)
    $DS.ValidateCredentials($UserName, $Password)
} 
#endregion

#region List all AD attributes currently in use for AD users
$Searcher = New-Object DirectoryServices.DirectorySearcher
$Searcher.Filter = '(objectcategory=user)'
$Searcher.PageSize = 500
$Searcher.FindAll() | ForEach-Object {
    $_.Properties.Keys
} | Group-Object
#endregion

#region special variables
${Chrissy + Jaap + Rob} = 'This is a pretty cool variable'
${Chrissy + Jaap + Rob}

${中国} = 'Chinese characters'
${中国}

${한국} = 'Korean characters'
${한국}

Get-ChildItem -Path Variable:
#endregion