Describe 'Software installation' {
    . 'C:\DuPSUG 8\Testing in PowerShell\Demos\HelperFunctions\Get-Remoteprogram.ps1'
    $Programs = Get-RemoteProgram

    It 'Skype is installed' {
        $Programs.Where{$_.ProgramName -match '^Skype™'} | Should Not BeNullOrEmpty
    }
    It 'Visual Studio 2015 is installed' {
        $Programs.Where{$_.ProgramName -match '^Microsoft Visual Studio 2015'} | Should Not BeNullOrEmpty
    }
}

Describe 'Check PowerShell version' {
    It 'PowerShell version 5 or later' {
        [version]$PSVersionTable.PSVersion | Should BeGreaterThan ('5.0.0' -as [version])
    }
}

Describe 'Check registry settings' {
    It 'App theme is dark' {
        Get-ItemPropertyValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\' -Name AppsUseLightTheme |
        Should Be 0
    }
    It 'PowerShell on Win+X' {
        Get-ItemPropertyValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name DontUSePowerShellOnWinX |
        Should Be 0
    }
}

<#
Install-Module CustomizeWindows10
Add-PowerShellWinX
#>