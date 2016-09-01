function ConvertFrom-DateQuery {
param (
    $Query
)
    try {
        $CsvQuery = Convertfrom-Csv -InputObject $Query -Delimiter ',' -Header 'Type','Day','Repeat'
        $ConvertCsvSuccess = $true
    } catch {
        Write-Warning 'Query is in incorrect format, please supply query in proper format'
        $ConvertCsvSuccess = $false
    }
    if ($ConvertCsvSuccess) {
        $Check=$HashOutput = @{}
        foreach ($Entry in $CsvQuery) {
            switch ($Entry.Type) {
                'week' {
                    # Convert named dates to correct format
                    switch ($Entry.Day)
                    {
                        # DayOfWeek starts count at 0, referring to the [datetime] property DayOfWeek
                        'sun' {
                            $HashOutput.DayOfWeek  = 0
                            $HashOutput.WeekRepeat = $Entry.Repeat -as [int]
                        }
                        'mon' {
                            $HashOutput.DayOfWeek  = 1
                            $HashOutput.WeekRepeat = $Entry.Repeat -as [int]
                        }
                        'tue' {
                            $HashOutput.DayOfWeek  = 2
                            $HashOutput.WeekRepeat = $Entry.Repeat -as [int]
                        }
                        'wed' {
                            $HashOutput.DayOfWeek  = 3
                            $HashOutput.WeekRepeat = $Entry.Repeat -as [int]
                        }
                        'thu' {
                            $HashOutput.DayOfWeek  = 2
                            $HashOutput.WeekRepeat = $Entry.Repeat -as [int]
                        }
                        'fri' {
                            $HashOutput.DayOfWeek  = 5
                            $HashOutput.WeekRepeat = $Entry.Repeat -as [int]
                        }
                        'sat' {
                            $HashOutput.DayOfWeek  = 6
                            $HashOutput.WeekRepeat = $Entry.Repeat -as [int]
                        }
                        Default {$Check.WeekSuccess = $false}
                    }
                }
                'month' {
                    # Convert named dates to correct format
                    switch ($Entry.Day)
                    {
                        # DayOfMonth starts count at 0, referring to the last day of the month with zero
                        'first' {
                            [array]$HashOutput.DayOfMonth  += 1
                            [array]$HashOutput.MonthRepeat += $Entry.Repeat -as [int]
                        }
                        'last' {
                            [array]$HashOutput.DayOfMonth  += 0
                            [array]$HashOutput.MonthRepeat += $Entry.Repeat -as [int]
                        }
                        {(1..31) -contains $_} {
                            [array]$HashOutput.DayOfMonth  += $Entry.Day
                            [array]$HashOutput.MonthRepeat += $Entry.Repeat -as [int]
                        }
                        Default {$Check.MonthSuccess = $false}
                    }
                }
                'quarter' {
                    # Count the number of times the quarter argument is used, used in final check of values
                    $QuarterCount++

                    # Convert named dates to correct format
                    switch ($Entry.Day)
                    {
                        # DayOfMonth starts count at 0, referring to the last day of the month with zero
                        'first' {
                            $HashOutput.DayOfQuarter   = 1
                            $HashOutput.QuarterRepeat  = $Entry.Repeat
                        }
                        'last' {
                            $HashOutput.DayOfQuarter   = 0
                            $HashOutput.QuarterRepeat  = $Entry.Repeat
                        }
                        {(1..92) -contains $_} {
                            $HashOutput.DayOfQuarter   = $Entry.Day
                            $HashOutput.QuarterRepeat  = $Entry.Repeat
                        }
                        Default {$Check.QuarterSuccess = $false}
                    }
                }
                'year' {
                    # Convert named dates to correct format
                    switch ($Entry.Day)
                    {
                        # DayOfMonth starts count at 0, referring to the last day of the month with zero
                        'first' {
                            $HashOutput.DayOfYear = 1
                            $HashOutput.DayOfYearRepeat = $Entry.Repeat
                        }
                        'last' {
                            $HashOutput.DayOfYear = 0
                            $HashOutput.DayOfYearRepeat = $Entry.Repeat
                        }
                        {(1..366) -contains $_} {
                            $HashOutput.DayOfYear       = $Entry.Day
                            $HashOutput.DayOfYearRepeat = $Entry.Repeat
                        }
                        Default {$Check.YearSuccess = $false}
                    }
                }
                'date' {
                    # Verify if the date is in the correct format
                    switch ($Entry.Day)
                    {
                        {try {[DateTime]"$($Entry.Day)"} catch{}} {
                            [array]$HashOutput.DateDay += $Entry.Day
                        }
                        Default {$Check.DateSuccess = $false}
                    }
                }

                'daterange' {
                    # Verify if the date is in the correct format
                    switch ($Entry.Day)
                    {
                        {try {[DateTime]"$($Entry.Day)"} catch{}} {
                            $HashOutput.DateRange       += $Entry.Day
                            $HashOutput.DateRangeRepeat += $Entry.Repeat
                        }
                        Default {$Check.DateRangeSuccess = $false}
                    }
                }

                'limityear' {
                    switch ($Entry.Day)
                    {
                        {(1000..2100) -contains $_} {
                            $HashOutput.LimitYear        = $Entry.Day
                        }
                        Default {$Check.LimitYearSuccess = $false}
                    }
                }
                Default {
                    $QueryContentCorrect = $false
                }
            }
        }
        ConvertTo-DateObject @HashOutput
    }
}

# Function that outputs an array of date objects that can be used to exclude certain files from deletion
function ConvertTo-DateObject {
param(
    [validaterange(0,6)]
    $DayOfWeek,
    [int]$WeekRepeat=1,
    [validaterange(0,31)]
    $DayOfMonth,
    $MonthRepeat=1,
    [validaterange(0,92)]
    $DayOfQuarter,
    [int]$QuarterRepeat=1,
    [validaterange(0,366)]
    $DayOfYear,
    [int]$DayOfYearRepeat=1,
    $DateDay,
    $DateRange,
    [int]$DateRangeRepeat=1,
    [validaterange(1000,2100)]
    [int]$LimitYear = 2010
)
    # Define variable
    $CurrentDate = Get-Date

    if ($DayOfWeek -ne $null) {
        $CurrentWeekDayInt = $CurrentDate.DayOfWeek.value__

            # Loop runs for number of times specified in the WeekRepeat parameter
            for ($j = 0; $j -lt $WeekRepeat; $j++)
                { 
                    $CheckDate = $CurrentDate.Date.AddDays(-((7*$j)+$CurrentWeekDayInt-$DayOfWeek))

                    # Only display date if date is larger than current date, this is to exclude dates in the current week
                    if ($CheckDate -le $CurrentDate) {
                        $CheckDate
                    } else {
                        # Increase weekrepeat, to ensure the correct amount of repeats are executed when date returned is
                        # higher than current date
                        $WeekRepeat++
                    }
                }
            
            # Loop runs until $LimitYear parameter is exceeded
			if ($WeekRepeat -eq -1) {
                $j=0
                do {
                    $CheckDate = $CurrentDate.AddDays(-((7*$j)+$CurrentWeekDayInt-$DayOfWeek))
                    $j++

                    # Only display date if date is larger than current date, this is to exclude dates in the current week
                    if ($CheckDate -le $CurrentDate) {
                        $CheckDate
                    }
                } while ($LimitYear -le $CheckDate.Adddays(-7).Year)
            }
        }

    if (-not [string]::IsNullOrEmpty($DayOfMonth)) {
        for ($MonthCnt = 0; $MonthCnt -lt $DayOfMonth.Count; $MonthCnt++) {
            # Loop runs for number of times specified in the MonthRepeat parameter
            for ($j = 0; $j -lt $MonthRepeat[$MonthCnt]; $j++)
                { 
                    $CheckDate = $CurrentDate.Date.AddMonths(-$j).AddDays($DayOfMonth[$MonthCnt]-$CurrentDate.Day)

                    # Only display date if date is larger than current date, this is to exclude dates ahead of the current date and
                    # to list only output the possible dates. If a value of 29 or higher is specified as a DayOfMonth value
                    # only possible dates are listed.
                    if ($CheckDate -le $CurrentDate -and $(if ($DayOfMonth[$MonthCnt] -ne 0) {$CheckDate.Day -eq $DayOfMonth[$MonthCnt]} else {$true})) {
                        $CheckDate
                    } else {
                        # Increase MonthRepeat integer, to ensure the correct amount of repeats are executed when date returned is
                        # higher than current date
                        $MonthRepeat[$MonthCnt]++
                    }
                }
            
            # Loop runs until $LimitYear parameter is exceeded
		    if ($MonthRepeat[$MonthCnt] -eq -1) {
                $j=0
                do {
                    $CheckDate = $CurrentDate.Date.AddMonths(-$j).AddDays($DayOfMonth[$MonthCnt]-$CurrentDate.Day)
                    $j++

                    # Only display date if date is larger than current date, this is to exclude dates ahead of the current date and
                    # to list only output the possible dates. For example if a value of 29 or higher is specified as a DayOfMonth value
                    # only possible dates are listed.
                    if ($CheckDate -le $CurrentDate -and $(if ($DayOfMonth[$MonthCnt] -ne 0) {$CheckDate.Day -eq $DayOfMonth[$MonthCnt]} else {$true})) {
                        $CheckDate
                    }
                } while ($LimitYear -le $CheckDate.Adddays(-31).Year)
            }
        }
    }

    if ($DayOfQuarter -ne $null) {
        # Set quarter int to current quarter value $QuarterInt
        $QuarterInt = [int](($CurrentDate.Month+1)/3)
        $QuarterYearInt = $CurrentDate.Year
        $QuarterLoopCount = $QuarterRepeat
        $j = 0
        
        do {
            switch ($QuarterInt) {
                1 {
                    $CheckDate = ([DateTime]::ParseExact("$($QuarterYearInt)0101",'yyyyMMdd',$null)).AddDays($DayOfQuarter-1)
                    
                    # Check for number of days in the 1st quarter, this depends on leap years
                    $DaysInFeb = ([DateTime]::ParseExact("$($QuarterYearInt)0301",'yyyyMMdd',$null)).AddDays(-1).Day
                    $DaysInCurrentQuarter = 31+$DaysInFeb+31
                        
                    # If the number of days is larger that the total number of days in this quarter the quarter will be excluded
                    if ($DayOfQuarter -gt $DaysInCurrentQuarter) {
                        $CheckDate = $null
                    }

                    # This check is built-in to return the date last date of the current quarter, to ensure consistent results
                    # in case the command is executed on the last day of a quarter
                    if ($DayOfQuarter -eq 0) {
                        $CheckDate = [DateTime]::ParseExact("$($QuarterYearInt)0331",'yyyyMMdd',$null)
                    }

                    $QuarterInt = 4
                    $QuarterYearInt--
                }
                2 {
                    $CheckDate = ([DateTime]::ParseExact("$($QuarterYearInt)0401",'yyyyMMdd',$null)).AddDays($DayOfQuarter-1)
                        
                    # Check for number of days in the 2nd quarter
                    $DaysInCurrentQuarter = 30+31+30
                        
                    # If the number of days is larger that the total number of days in this quarter the quarter will be excluded
                    if ($DayOfQuarter -gt $DaysInCurrentQuarter) {
                        $CheckDate = $null
                    }

                    # This check is built-in to return the date last date of the current quarter, to ensure consistent results
                    # in case the command is executed on the last day of a quarter                       
                    if ($DayOfQuarter -eq 0) {
                        $CheckDate = [DateTime]::ParseExact("$($QuarterYearInt)0630",'yyyyMMdd',$null)
                    }
                        
                    $QuarterInt = 1
                }
                3 {
                    $CheckDate = ([DateTime]::ParseExact("$($QuarterYearInt)0701",'yyyyMMdd',$null)).AddDays($DayOfQuarter-1)
                        
                    # Check for number of days in the 3rd quarter
                    $DaysInCurrentQuarter = 31+31+30
                        
                    # If the number of days is larger that the total number of days in this quarter the quarter will be excluded
                    if ($DayOfQuarter -gt $DaysInCurrentQuarter) {
                        $CheckDate = $null
                    }
                        
                    # This check is built-in to return the date last date of the current quarter, to ensure consistent results
                    # in case the command is executed on the last day of a quarter                       
                    if ($DayOfQuarter -eq 0) {
                        $CheckDate = [DateTime]::ParseExact("$($QuarterYearInt)0930",'yyyyMMdd',$null)
                    }

                    $QuarterInt = 2
                }
                4 {
                    $CheckDate = ([DateTime]::ParseExact("$($QuarterYearInt)1001",'yyyyMMdd',$null)).AddDays($DayOfQuarter-1)
                        
                    # Check for number of days in the 4th quarter
                    $DaysInCurrentQuarter = 31+30+31
                        
                    # If the number of days is larger that the total number of days in this quarter the quarter will be excluded
                    if ($DayOfQuarter -gt $DaysInCurrentQuarter) {
                        $CheckDate = $null
                    }

                    # This check is built-in to return the date last date of the current quarter, to ensure consistent results
                    # in case the command is executed on the last day of a quarter                       
                    if ($DayOfQuarter -eq 0) {
                        $CheckDate = [DateTime]::ParseExact("$($QuarterYearInt)1231",'yyyyMMdd',$null)
                    }                        
                    $QuarterInt = 3
                }
            }

            # Only display date if date is larger than current date, and only execute check if $CheckDate is not equal to $null
            if ($CheckDate -le $CurrentDate -and $CheckDate -ne $null) {
                    
                # Only display the date if it is not further in the past than the limit year
                if ($CheckDate.Year -ge $LimitYear -and $QuarterRepeat -eq -1) {
                    $CheckDate
                }

                # If the repeat parameter is not set to -1 display results regardless of limit year                    
                if ($QuarterRepeat -ne -1) {
                    $CheckDate
                    $j++
                } else {
                    $QuarterLoopCount++
                }
            }
            # Added if statement to catch errors regarding 
        } while ($(if ($QuarterRepeat -eq -1) {$LimitYear -le $(if ($CheckDate) {$CheckDate.Year} else {9999})} 
                else {$j -lt $QuarterLoopCount}))
    }

    if ($DayOfYear -ne $null) {
        $YearLoopCount = $DayOfYearRepeat
        $YearInt = $CurrentDate.Year
        $j = 0

        # Mainloop containing the loop for selecting a day of a year
        do {
            $CheckDate = ([DateTime]::ParseExact("$($YearInt)0101",'yyyyMMdd',$null)).AddDays($DayOfYear-1)
            
            # If the last day of the year is specified, a year is added to get consistent results when the query is executed on last day of the year 
            if ($DayOfYear -eq 0) {
                $CheckDate = $CheckDate.AddYears(1)
            }
            
            # Set checkdate to null to allow for selection of last day of leap year
            if (($DayOfYear -eq 366) -and !([DateTime]::IsLeapYear($YearInt))) {
                $CheckDate = $null
            }

            # Only display date if date is larger than current date, and only execute check if $CheckDate is not equal to $null
            if ($CheckDate -le $CurrentDate -and $CheckDate -ne $null) {
                # Only display the date if it is not further in the past than the limit year
                if ($CheckDate.Year -ge $LimitYear -and $DayOfYearRepeat -eq -1) {
                    $CheckDate
                }

                # If the repeat parameter is not set to -1 display results regardless of limit year
                if ($DayOfYearRepeat -ne -1) {
                    $CheckDate
                    $j++
                } else {
                    $YearLoopCount++
                }
            }
            $YearInt--
        } while ($(if ($DayOfYearRepeat -eq -1) {$LimitYear -le $(if ($CheckDate) {$CheckDate.Year} else {9999})} 
                else {$j -lt $YearLoopCount}))
    }

    if ($DateDay -ne $null) {
        foreach ($Date in $DateDay) {
            try {
                $CheckDate     = [DateTime]::ParseExact($Date,'yyyy-MM-dd',$null)
            } catch {
                try {
                    $CheckDate = [DateTime]::ParseExact($Date,'yyyy\/MM\/dd',$null)
                } catch {}
            }
            
            if ($CheckDate -le $CurrentDate) {
                $CheckDate
            }
            $CheckDate=$null
        }
    }

    if ($DateRange -ne $null) {
        $CheckDate=$null
        try {
            $CheckDate     = [DateTime]::ParseExact($DateRange,'yyyy-MM-dd',$null)
        } catch {
            try {
                $CheckDate = [DateTime]::ParseExact($DateRange,'yyyy\/MM\/dd',$null)
            } catch {}
        }
        if ($CheckDate) {
            for ($k = 0; $k -lt $DateRangeRepeat; $k++) { 
                if ($CheckDate -le $CurrentDate) {
                    $CheckDate
                }
                $CheckDate = $CheckDate.AddDays(1)
            }
        }
    }
}
<#
ConvertFrom-DateQuery 'Week,wed,1'
ConvertFrom-DateQuery 'Week,sun,1'

ConvertFrom-DateQuery 'Week,Thu,4','Month,last,-1','Quarter,first,6','Year,last,10','LimitYear,2016','Date,1990-12-31','Date,1995-5-31'
#>