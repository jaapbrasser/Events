./Demo/breakpoint.ps1 -Name bla

Set-PSBreakpoint -Script ./Demo/breakpoint.ps1 -Line 4

./Demo/breakpoint.ps1 -Name bla

Get-PSBreakpoint | Remove-PSBreakpoint