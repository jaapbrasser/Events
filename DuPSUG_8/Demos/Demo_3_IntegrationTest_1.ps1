Describe 'Integration test of Get-MappedDrive function' {
    . 'C:\DuPSUG 8\Testing in PowerShell\Demos\HelperFunctions\Get-MappedDrive.ps1'

    Context 'Test if function runs without errors' {
        It 'Should provide output' {
            Get-MappedDrive | Should Not BeNullOrEmpty
        }
        It 'Should output PowerShell Customobject' {
            Get-MappedDrive | Should BeOfType System.Management.Automation.PSCustomObject
        }
    }

    Get-MappedDrive | ForEach-Object {
        Context "Checking $($_.LocalPath)" {
            It "Should exist in PSDrive" {
                (Get-PSDrive -Name $_.Localpath[0]).Name | Should BeExactly $_.LocalPath[0]
            }
            It "Network Path should match" {
                (Get-PSDrive -Name $_.Localpath[0]).NetworkPath | Should BeExactly $_.LocalPath[0].NetworkPath
            }
        }
    }
}

Get-MappedDrive