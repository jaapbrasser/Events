#region Convert word document to pdf
$Word = New-Object -ComObject "Word.Application"
($Word.Documents.Open('c:\users\jaapbrasser\desktop\file.docx')).SaveAs([ref]'c:\users\jaapbrasser\desktop\file.pdf',[ref]17)
$Word.Application.ActiveDocument.Close()
#endregion

#region Check compression of zip file
Add-Type -Assembly 'System.IO.Compression.FileSystem'
[System.IO.Compression.ZipFile]::Open("c:\users\jaapbrasser\desktop\file.zip",'Read') | ForEach-Object {
     $_.Entries | ForEach-Object -Begin {
        [long]$TotalCompressed = $null
        [long]$TotalSize = $null
    } -Process {
        $TotalCompressed += $_.CompressedLength
        $TotalSize += $_.Length
    } -End {
        [pscustomobject]@{
            FileSize = $TotalSize
            CompressedSize = $TotalCompressed
            Ratio = "{0:P2}" -f ($TotalCompressed / $TotalSize)
        }
    }
}
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
[System.Windows.Forms.MessageBox]::Show(
    'HelloPSConfAsia','Caption','YesNoCancel','Question'
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