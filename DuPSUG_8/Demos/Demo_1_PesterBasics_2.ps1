break

# Example with context blocks and failing statements

Describe 'A pester test example' {
    Context 'These tests will succeed' {
        It 'Text match' {
            'Hello' | Should Be 'hello'
        }
        It 'Integer match' {
            5 | Should BeGreaterThan 4
        }
    }
    Context 'These tests will fail' {
        It 'Text match' {
            'Hello' | Should BeExactly 'Hello'
        }
        It 'Is zero a string?' {
            [string]0 | Should BeOfType System.String
        }
    }
}

Describe 'This block will fail' {
    It 'Text match' {
        'Hello' | Should Be 'hello'
    }
}