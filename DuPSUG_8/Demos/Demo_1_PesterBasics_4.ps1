break

Describe 'Show $TestDrive information' {
    It 'Display the output of Get-PSDrive' {
        Get-PSDrive -Name TestDrive | Format-List * | Out-Host
    }
}

Describe 'Verify disk space usage' {
    It 'Verify free space of TestDrive matches C:' {
        (Get-PSDrive -Name TestDrive).Free | Should Be (Get-PSDrive -Name C).Free
    }
}

Describe 'Test TestDrive functionality' {
    Get-Service | Export-Clixml -Path TestDrive:\Service.xml -Depth 1
    
    It 'Test if file exists' {
        Get-Item TestDrive:\Service.xml | Should Not BeNullOrEmpty
    }
    It 'Test if type is FileInfo' {
        Get-Item TestDrive:\Service.xml | Should BeOfType 'System.IO.FileInfo'
    }
    It 'Check if file content matches expectation' {
        (Get-Content -Path TestDrive:\Service.xml)[0] | Should Be '<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">'
    }
    It 'Verify if vmms service is running' {
        Import-Clixml -Path TestDrive:\Service.xml | Where {$_.Name -eq 'vmms' -and $_.Status -eq 'Running'} | Should Not BeNullOrEmpty
    }
}

Describe 'Test TestDrive functionality' {
    Get-Service | Export-Clixml -Path TestDrive:\Service.xml -Depth 1
    
    It 'View output of Get-ChildItem TestDrive:' {
        Get-ChildItem -Path TestDrive: | Out-Host
    }
    It 'View PSDrive information' {
        Get-PSDrive -Name TestDrive | Format-List * | Out-Host
    }
    Start-Sleep -Seconds 30
}