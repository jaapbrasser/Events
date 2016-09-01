Describe 'Get-Item' {
   Context 'C:\Users Path' {
      It 'Get-Item should not throw' {
         { Get-Item C:\Users} | Should Not Throw
      }
      It 'returns the correct item' {
         ( Get-Item -Path C:\Users).FullName | Should Be 'C:\Users'
      }
   }
}