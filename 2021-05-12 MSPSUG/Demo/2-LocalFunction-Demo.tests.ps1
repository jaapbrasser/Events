Describe "Example Pester Tests" {
    Context 'Example Function - Test Output' {
        It 'Test output' {
            Mock -CommandName Get-CimInstance {
                [pscustomobject]@{
                    TotalPhysicalMemory = 64GB
                }
            }
            (Get-Memory).MemGB | Should -BeExactly 64
        }
    }
}