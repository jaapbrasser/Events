Describe "Example Pester Tests" {
    Context 'Local Machine Check' {
        It "Should be 64-bit OS" {
            [System.Environment]::Is64BitOperatingSystem |
                Should -Be $true
        }
        It "Should be 64-bit Process" {
            [System.Environment]::Is64BitProcess |
                Should -Be $true
        }
        It "Should have sparkles ✨ and unicorns 🦄" {
            [System.Environment]::MachineName |
                Should -Be '🦁'
        }
    }
}