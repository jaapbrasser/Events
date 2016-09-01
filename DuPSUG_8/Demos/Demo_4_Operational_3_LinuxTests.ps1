# Linux demo!

yum list installed powershell -C

powershell

cd /dupsug

Invoke-Pester -Script linux.tests.ps1

Invoke-Pester -Script linuxbroken.tests.ps1

cat -N linuxbroken.tests.ps1



'Name;Version;Package',((yum list installed powershell -C) -replace '\s+',';') | ConvertFrom-Csv -Delimiter ';'


Describe 'Linux integration tests' {
    Context 'Check for PowerShell installation using Linux tools' {
        It 'Check Yum for PowerShell installation' {
            yum list installed powershell | Should Not BeNullOrEmpty
        }
        It 'Check if PowerShell folder exists' {
            ls /opt/microsoft/powershell | Should Not BeNullOrEmpty
        }
    }
    Context 'Check PowerShell installation using PowerShell variables' {
        It 'Check PowerShell version in $PSVersiontable' {
            $PSVersionTable.GitCommitID -replace '.*(\d+$)','$1' | Should BeGreaterThan 8
        }
        It 'Check PSHome variable for version number' {
            $PSHome.Split('.')[-1] | Should BeGreaterThan 8
        }
    }
    Context 'Check CoreCLR and Linux' {
        It 'Check if current version of PowerShell is CoreCLR' {
            $IsCoreCLR | Should Be $true
        }
        It 'Check if current version of PowerShell is Linux' {
            $IsLinux | Should Be $true
        }
    }
}



# broken
Describe 'Linux integration tests' {
    Context 'Check for PowerShell installation using Linux tools' {
        It 'Check Yum for PowerShell installation' {
            yum list installed powershell | Should Not BeNullOrEmpty
        }
        It 'Check if PowerShell folder exists' {
            ls /opt/microsoft/windowspowershell | Should Not BeNullOrEmpty
        }
    }
    Context 'Check PowerShell installation using PowerShell variables' {
        It 'Check PowerShell version in $PSVersiontable' {
            $PSVersionTable.GitCommitID -replace '.*(\d+$)','$1' | Should BeGreaterThan 9
        }
        It 'Check PSHome variable for version number' {
            $PSHome.Split('.')[-1] | Should BeGreaterThan 9
        }
    }
    Context 'Check CoreCLR and Linux' {
        It 'Check if current version of PowerShell is CoreCLR' {
            $IsCoreCLR | Should Be $true
        }
        It 'Check if current version of PowerShell is Linux' {
            $IsLinux | Should Be $true
        }
    }
}