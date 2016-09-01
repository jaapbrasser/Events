break

function Get-VeryRandom {
    Get-Random -Minimum 0 -Maximum 100
}

Get-VeryRandom

# Correct way of mocking
Describe 'Pester tests where Mock is used' {
    #Mock Get-Random {return 42}
    It 'Verify output of function' {
        Get-VeryRandom | Should Be 42
    }
    It 'Verify outputtype of function' {
        Get-VeryRandom | Should BeOfType System.Int32
    }
    It 'Verify number of times Mock is Called' {
        Assert-MockCalled Get-Random -Exactly -Times 2 -Scope Describe
    }
}

# Wrong way of mocking
Describe 'Pester tests where Mock is used' {
    Mock Get-VeryRandom {return 42}
    It 'Verify output of function' {
        Get-VeryRandom | Should Be 42
    }
    It 'Verify outputtype of function' {
        Get-VeryRandom | Should BeOfType System.Int32
    }
    It 'Verify number of times Mock is Called' {
        Assert-MockCalled Get-VeryRandom -Exactly -Times 2 -Scope Describe
    }
}

Get-ChildItem function:\Get-VeryRandom | Remove-Item -Verbose

Remove-Module .\Demo_1_PesterBasics_3_Module.psm1 -ErrorAction Ignore
Import-Module .\Demo_1_PesterBasics_3_Module.psm1 -Force -DisableNameChecking

InModuleScope Demo_1_PesterBasics_3_Module {
    Describe 'Pester tests where Mock is used' {
        Mock Get-Random {return 42}
        It 'Verify output of function' {
        
            Get-VeryRandom | Should Be 42
        }
        It 'Verify outputtype of function' {
            Get-VeryRandom | Should BeOfType System.Int32
        }
        It 'Verify number of times Mock is Called' {
            Assert-MockCalled Get-Random -Exactly -Times 2 -Scope Describe
        }
    }
}