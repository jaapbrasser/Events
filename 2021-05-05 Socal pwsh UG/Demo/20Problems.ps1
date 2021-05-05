@'
     __ __     ____                   ____     __   ___        ______           ______           __          ____  __      _           __ 
  __/ // /_   / __ \____ __________ _/ / /__  / /  ( _ )      / ____/___  _____/ ____/___ ______/ /_        / __ \/ /_    (_)__  _____/ /_
 /_  _  __/  / /_/ / __ `/ ___/ __ `/ / / _ \/ /  / __ \/|   / /_  / __ \/ ___/ __/ / __ `/ ___/ __ \______/ / / / __ \  / / _ \/ ___/ __/
/_  _  __/  / ____/ /_/ / /  / /_/ / / /  __/ /  / /_/  <   / __/ / /_/ / /  / /___/ /_/ / /__/ / / /_____/ /_/ / /_/ / / /  __/ /__/ /_  
 /_//_/    /_/    \__,_/_/   \__,_/_/_/\___/_/   \____/\/  /_/    \____/_/  /_____/\__,_/\___/_/ /_/      \____/_.___/_/ /\___/\___/\__/  
                                                                                                                    /___/                 
'@

1..5 | ForEach-Object { "Hello run '$_'" ; Start-Sleep -Seconds 1} 

1..5 | ForEach-Object -Parallel { "Hello run '$_'" ; Start-Sleep -Seconds 1} 

1..5 | ForEach-Object -Parallel { "Hello run '$_'"; Start-Sleep -Mill ($x = 500..2000|get-random) } 

'microsoft.com','google.com','amazon.com' | ForEach-Object {
    ping $_ -n 2
}

'microsoft.com','google.com','amazon.com' | ForEach-Object -Parallel {
    ping $_ -n 2
} -AsJob # Optionally pipe into: | Wait-Job | Receive-Job

@'
____  _                        
| __ )(_)_ __   __ _ _ __ _   _ 
|  _ \| | '_ \ / _` | '__| | | |
| |_) | | | | | (_| | |  | |_| |
|____/|_|_| |_|\__,_|_|   \__, |
                          |___/ 
'@

$BinaryString = '72 101 108 108 111 32 67 97 108 105 102 111 114 110 105 97 44 32 108 101 116 39 115 32 100 111 32 115 111 109 101 32 98 105 110 97 114 121'

[char]65

$BinaryString -split ' ' | % {[char][int]$_}

-join ($BinaryString -split ' ' | % {[char][int]$_})

[byte][char]'A'

("Hello California, let's do some binary".ToCharArray() -as [byte[]]) -join ' '


@'
 __   _  _        __  _________    _     _ _  ___ 
/ /_ | || |      / / |___ /___ \  | |__ (_) ||__ \
|'_ \| || |_    / /    |_ \ __) | | '_ \| | __|/ /
|(_) |__   _|  / /    ___) / __/  | |_) | | |_|_| 
\___/   |_|   /_/    |____/_____| |_.__/|_|\__(_) 
'@

c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe -noprofile -command "[Environment]::Is64BitProcess"
c:\windows\syswow64\WindowsPowerShell\v1.0\powershell.exe -noprofile -command "[Environment]::Is64BitProcess"
&('C:\Program Files\PowerShell\7\pwsh.exe') -noprofile -command "[Environment]::Is64BitProcess"

# Available cross-platform and in Windows PowerShell
[Environment]::Is64BitProcess

# Can also check OS
[Environment]::Is64BitOperatingSystem

# 8 = 64 bit process
# 4 = 32 bit process
[IntPtr]::Size

@'
____       _             _         _   _                
|  _ \ _ __(_)_   _____  | |    ___| |_| |_ ___ _ __ ___ 
| | | | '__| \ \ / / _ \ | |   / _ \ __| __/ _ \ '__/ __|
| |_| | |  | |\ V /  __/ | |__|  __/ |_| ||  __/ |  \__ \
|____/|_|  |_| \_/ \___| |_____\___|\__|\__\___|_|  |___/
'@

# Get a Drive with the driveletter G
Get-CimInstance -Query "SELECT * FROM Win32_Volume WHERE driveletter='G:'"

# Get a Drive with the driveletter G and change it to V, needs administrative session
Get-CimInstance -Query "SELECT * FROM Win32_Volume WHERE driveletter='G:'" | 
Set-CimInstance -Arguments @{DriveLetter="V:"}

@'
_                           _       ___ _   _ 
| |    __ _ _   _ _ __   ___| |__   |_ _| |_| |
| |   / _` | | | | '_ \ / __| '_ \   | || __| |
| |__| (_| | |_| | | | | (__| | | |  | || |_|_|
|_____\__,_|\__,_|_| |_|\___|_| |_| |___|\__(_)
'@

# Open with default app
Invoke-Item .\PowerShellHero.png

# Short hand for Invoke-Item
ii .\file.pdf

# Open uri with standard browser
Start-Process 'https://powershellgallery.com'

# Open explorer in current folder
explorer .

# Open VS Code in current folder
code .

# Open this file, assuming you're in the correct path
code '.\20problems.ps1'

@'
    _       _                               _   _   _      _       
   / \   __| |_   ____ _ _ __   ___ ___  __| | | | | | ___| |_ __  
  / _ \ / _` \ \ / / _` | '_ \ / __/ _ \/ _` | | |_| |/ _ \ | '_ \ 
 / ___ \ (_| |\ V / (_| | | | | (_|  __/ (_| | |  _  |  __/ | |_) |
/_/   \_\__,_| \_/ \__,_|_| |_|\___\___|\__,_| |_| |_|\___|_| .__/ 
                                                            |_|
'@

Function Search-MsDocs {
    param(
        [Parameter(Mandatory=$true)]
            [string[]]$SearchQuery,
        [System.Globalization.Cultureinfo]$Culture = 'en-US'
    )
 
    foreach ($Query in $SearchQuery) {
        Start-Process -FilePath "https://docs.microsoft.com/$Culture/search/?terms=$Query"
    }
}

# Search for and open results in default browser
Search-MsDocs System.Windows.Forms

@'
 ____ _    _ ___   _         ____                        ____  _          _ _ 
/ __| | | |_ _ |  (_)_ __   |  _ \ _____      _____ _ __/ ___|| |__   ___| | |
| |  _| | | || |  | | '_ \  | |_) / _ \ \ /\ / / _ \ '__\___ \| '_ \ / _ \ | |
| |_| | |_| || |  | | | | | |  __/ (_) \ V  V /  __/ |   ___) | | | |  __/ | |
\____|\___/|___|  |_|_| |_| |_|   \___/ \_/\_/ \___|_|  |____/|_| |_|\___|_|_|
'@

Add-Type -AssemblyName System.Windows.Forms | Out-Null
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    InitialDirectory = [Environment]::GetFolderPath('MyDocuments')
    Filter = 'Documents (*.docx)|*.docx|SpreadSheet (*.xlsx)|*.xlsx'
}
$null = $FileBrowser.ShowDialog()
$FileBrowser.FileNames

[System.Windows.Forms.MessageBox]::Show(
    'Hello California','California Window Title','YesNoCancel','Question'
)

# To view the overloads and get an idea of how to call the Show method:
[System.Windows.Forms.MessageBox]::Show

@'
___         _         ____      _     _       _               
/ _ \  _   _| |_     / ___|_ __(_) __| |_   _(_) _____      __
| | | | | | | _|_ ___| | _| '__| |/ _` \ \ / / |/ _ \ \ /\ / /
| |_| | |_| | ||_____| |_|| |  | | (_| |\ V /| |  __/\ V  V / 
\___/ \__,_|\__|     \____|_|  |_|\__,_| \_/ |_|\___| \_/\_/  
'@

Get-Module Microsoft.PowerShell.GraphicalTools -ListAvailable

Get-Process | Out-Gridview

if (('Yes','No' | % {[pscustomobject]@{Choice=$_}} | Out-Gridview -Title -PassThru).Choice -eq 'Yes') {
    "Let's do it!"
} else {
    'Ok, another time then'
}

@'
 ____                    ___  _     _           _       
/ ___|___   _ __ ___    / _ \| |__ (_) ___  ___| |_ ___ 
| |   / _ \| '_ ` _ \  | | | | '_ \| |/ _ \/ __| __/ __|
| |__| (_) | | | | | | | |_| | |_) | |  __/ (__| |_\__ \
\____\____/|_| |_| |_|  \___/|_.__// |\___|\___|\__|___/
'@

# Get the Com Objects 
Get-ChildItem HKLM:\Software\Classes -ErrorAction SilentlyContinue | Where-Object {
    $_.PSChildName -match '^\w+\.\w+$' -and (Test-Path -Path "$($_.PSPath)\CLSID")
 } | Select-Object -ExpandProperty PSChildName | Measure-Object

@'
____  ____  _____    ____                              _             
|  _ \|  _ \|  ___|  / ___|___  _ ____   _____ _ __ ___(_) ___  _ __  
| |_) | | | | |_    | |   / _ \| '_ \ \ / / _ \ '__/ __| |/ _ \| '_ \ 
|  __/| |_| |  _|   | |__| (_) | | | \ V /  __/ |  \__ \ | (_) | | | |
|_|   |____/|_|      \____\___/|_| |_|\_/ \___|_|  |___/_|\___/|_| |_|
'@

dir '.\Demo'

$Word = New-Object -ComObject "Word.Application"
($Word.Documents.Open('.\file.docx')).SaveAs(
    [ref]'.\Demo\file123.pdf',[ref]17
)
$Word.Application.ActiveDocument.Close()

Invoke-Item '.\Demo\file123.pdf'

@'
____                  __   _  _   
| __ )  __ _ ___  ___ / /_ | || |  
|  _ \ / _` / __|/ _ \ '_ \| || |_ 
| |_) | (_| \__ \  __/ (_) |__   _|
|____/ \__,_|___/\___|\___/   |_|  
'@

[convert]::ToBase64String("Hello California, let's do some base64".ToCharArray())

$Base64String = 'SGVsbG8gQ2FsaWZvcm5pYSwgbGV0J3MgZG8gc29tZSBiYXNlNjQ='

[convert]::FromBase64String($Base64String)

[char[]][convert]::FromBase64String($Base64String)

[char[]][convert]::FromBase64String($Base64String) -join ''

-join ([convert]::ToBase64String(
    ([System.Text.Encoding]::UTF8.GetBytes((Get-Content .\PowerShellHero.png -Raw))))
)[0..25]

@'
 _   _ _     _                   
| | | (_)___| |_ ___  _ __ _   _ 
| |_| | / __| __/ _ \| '__| | | |
|  _  | \__ \ || (_) | |  | |_| |
|_| |_|_|___/\__\___/|_|   \__, |
                           |___/ 
'@

# History is saved in multiple locations by default by PSReadline
(Get-PSReadlineOption).HistorySavePath

# Get cross-session history with CTRL R to search through history
<CTRL> + R

# Current session history
Get-History

# Alias
h

(h)[-6..-1].commandline

(h)[-6..-1].commandline | clip.exe

# Expands the history 
#1 <tab>


@'
__     ___                  ____                  
\ \   / (_)_ __ _   _ ___  / ___|  ___ __ _ _ __  
 \ \ / /| | '__| | | / __| \___ \ / __/ _` | '_ \ 
  \ V / | | |  | |_| \__ \  ___) | (_| (_| | | | |
   \_/  |_|_|   \__,_|___/ |____/ \___\__,_|_| |_|
'@

# Execute scan in specified path
& "$($env:programfiles)\Windows Defender\mpcmdrun.exe" -Scan -ScanType 3 -File '.'

# Get latest scan results from Event log
Get-WinEvent -LogName 'Microsoft-Windows-Windows Defender/Operational' |
Select-Object -First 2 -ExpandProperty Message

@'
__     __    _ _     _       _         _                    _    ____              _     
\ \   / /_ _| (_) __| | __ _| |_ ___  | |    ___   ___ __ _| |  / ___|_ __ ___  __| |___ 
 \ \ / / _` | | |/ _` |/ _` | __/ _ \ | |   / _ \ / __/ _` | | | |   | '__/ _ \/ _` / __|
  \ V / (_| | | | (_| | (_| | ||  __/ | |__| (_) | (_| (_| | | | |___| | |  __/ (_| \__ \
   \_/ \__,_|_|_|\__,_|\__,_|\__\___| |_____\___/ \___\__,_|_|  \____|_|  \___|\__,_|___/
'@


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

Test-LocalCredential -UserName jaapbrasser -Password Secret01

Test-LocalCredential -UserName California -Password PowerShell

@'
___ _   _             _                            ____  _   _ ____  
|_ _| |_( )___    __ _| |_      ____ _ _   _ ___  |  _ \| \ | / ___| 
 | || __|// __|  / _` | \ \ /\ / / _` | | | / __| | | | |  \| \___ \ 
 | || |_  \__ \ | (_| | |\ V  V / (_| | |_| \__ \ | |_| | |\  |___) |
|___|\__| |___/  \__,_|_| \_/\_/ \__,_|\__, |___/ |____/|_| \_|____/ 
                                       |___/                         
'@

[System.Net.Dns]::GetHostEntry('www.microsoft.com')

# List all methods
([System.Net.Dns] | Get-Member -MemberType method -Static | 
Select -Exp Name) -join ', '

@'
__        __   _       _____                     _ _             
\ \      / /__| |__   | ____|_ __   ___ ___   __| (_)_ __   __ _ 
 \ \ /\ / / _ \ '_ \  |  _| | '_ \ / __/ _ \ / _` | | '_ \ / _` |
  \ V  V /  __/ |_) | | |___| | | | (_| (_) | (_| | | | | | (_| |
   \_/\_/ \___|_.__/  |_____|_| |_|\___\___/ \__,_|_|_| |_|\__, |
                                                            |___/ 
'@

function ConvertFrom-EncodedUrl {
    param(
        [Parameter(Mandatory = $true,    
                ValueFromPipeline = $true
        )]
        [string[]] $Uri
    )
    process {
        $Uri | ForEach-Object {
            New-Object -TypeName PSCustomObject -Property @{
                Uri     = $_
                Decoded = -join ($(if ($a=($_ -split '.*?q=(\w+)%3A.*$')[1]) {$a}),(-join [char[]](
                    ($_ -replace '.*?((%\w{2})+).*$','$1') -split '%' |
                    Where-Object {$_} | ForEach-Object {
                        [Convert]::ToInt32($_,16)
                    }
                )))
            }
        }
    }
}

# Get the percent encoded translate to uri
'https://www.google.com/url?q=https%3A%2F%2F%77%77%77%2E%6A%61%61%70%62%72%61%73%73%65%72%2E%63%6F%6D' |
ConvertFrom-EncodedUrl
