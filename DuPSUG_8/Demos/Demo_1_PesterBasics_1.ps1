break

# Example of a simple Pester test

Describe 'A pester test example' {
    It 'Text match' {
        'Hello' | Should Be 'hello'
    }
    It 'Integer match' {
        5 | Should BeGreaterThan 4
    }
}

'Hello' -eq 'hello'

5 -gt 4