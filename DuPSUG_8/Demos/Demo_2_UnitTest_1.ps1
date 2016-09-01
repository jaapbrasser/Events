break

# Load function
. .\Demo_2_UnitTest_0.ps1

Describe 'Testing Date time functions' {
    function Get-DayOfWeek {
        param (
            [System.DayOfWeek]$DayOfWeek
        )
        if (($Result = $DayOfWeek-$CurrentDay) -gt 0) {$Result - 7} else {$Result}
    }

    Context 'Testing week days' {
        It 'Should not produce output without wrong input' {
            ConvertFrom-DateQuery -Query 'Week,Wek,1' | Should BeNullOrEmpty
        }        
        It 'Testing Monday'    {
            $Monday    = Get-DayOfWeek -DayOfWeek Monday
            ConvertFrom-DateQuery -Query 'Week,mon,1' | Should Be (Get-Date).AddDays($Monday).Date
        }
        It 'Testing Tuesday'   {
            $Tuesday   = Get-DayOfWeek -DayOfWeek Tuesday
            ConvertFrom-DateQuery -Query 'Week,tue,1' | Should Be (Get-Date).AddDays($Tuesday).Date
        }
        It 'Testing Wednesday' {
            $Wednesday = Get-DayOfWeek -DayOfWeek Wednesday
            ConvertFrom-DateQuery -Query 'Week,wed,1' | Should Be (Get-Date).AddDays($Wednesday).Date
        }
        It 'Testing Thursday'  {
            $Thursday  = Get-DayOfWeek -DayOfWeek Thursday
            ConvertFrom-DateQuery -Query 'Week,thu,1' | Should Be (Get-Date).AddDays($Thursday).Date
        }
        It 'Testing Friday'    {
            $Friday    = Get-DayOfWeek -DayOfWeek Friday
            ConvertFrom-DateQuery -Query 'Week,fri,1' | Should Be (Get-Date).AddDays($Friday).Date
        }
        It 'Testing Saturday'  {
            $Saturday  = Get-DayOfWeek -DayOfWeek Saturday
            ConvertFrom-DateQuery -Query 'Week,sat,1' | Should Be (Get-Date).AddDays($Saturday).Date
        }
        It 'Testing Sunday'    {
            $Sunday    = Get-DayOfWeek -DayOfWeek Sunday
            ConvertFrom-DateQuery -Query 'Week,sun,1' | Should Be (Get-Date).AddDays($Sunday).Date
        }
        BeforeEach {
            $CurrentDay = (Get-Date).DayOfWeek.value__
        }
    }
}