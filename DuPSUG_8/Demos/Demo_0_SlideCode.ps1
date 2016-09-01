Describe 'This is my Pester test' {
    Context 'Certainly nothing will fail' {
        It 'This almost never fails' {
            42.0001 | Should Be 42
        }
        It 'Simple text comparison' {
            'Hello' | Should Match 'World'
        }
        It 'Compare two arrays' {
            @(1,2) | Should BeExactly @(1,2,3)
        }
    }
}