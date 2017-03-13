function Update-XpathFilter {
<#
.SYNOPSIS
Function to update XpathFilter to exclude certain EventIds

.DESCRIPTION
This function is used to update XpathFilter to exclude certain EventIds, this can be used to exclude expected EventId that are customer specific or part of design decisions when the Active Directory was designed.
#>


    [CmdletBinding()]
    param(
        [Parameter( Mandatory=$true,
                    ValueFromPipeline=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0
        )]
        [string] $Xpath,
        [Parameter( Mandatory=$true,
                    ValueFromPipeline=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=1
        )]
        [int[]]  $EventId
    )

    $EventId | ForEach-Object -Begin {
        $Xpath  = $Xpath -replace '\]\]$',' and ('
    } -Process {
        $Xpath += 'EventID!={0} and ' -f $_
    } -End {
        $Xpath  = '{0})]]' -f ($Xpath -replace '\sand\s$')
    }

    return $Xpath
}

function Test-AdSystemLog {
<#
.SYNOPSIS


.DESCRIPTION


.PARAMETER Id


.NOTES
Name:        Test-AdApplicationLog
Author:      Jaap Brasser
DateCreated: 2017-02-20
DateUpdated: 2017-02-24
Version:     1.0.0.0

.EXAMPLE
Test-AdSystemLog -Id 1337

Description
-----------
This will run the check with the specified ID and return the requested data

.EXAMPLE
Test-AdSystemLog -Id 1337 -ExcludeEventId 1202,1203

Description
-----------
This will run the check with the specified ID and return the requested data, excluding event ids 1202 and 1203
#>


    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [String] $Id,
        [Parameter(Mandatory = $false)]
        [int[]]  $ExcludeEventId
    )

    $EventLogParameter = @{
        LogName = 'System'
        Xpath   = "*[System[Provider[@Name='Microsoft-Windows-Kerberos-Key-Distribution-Center'] and EventID=11 or (EventID=10 or EventID=11150 or EventID=11150 or EventID=11151 or EventID=11152 or EventID=11153 or EventID=11154 or EventID=11155 or EventID=11162 or EventID=11162 or EventID=11163 or EventID=11164 or EventID=11165 or EventID=11166 or EventID=11167 or EventID=12299 or EventID=12302 or EventID=12303 or EventID=12304 or EventID=13 or EventID=15 or EventID=16392)]]"
        Id      = $Id
    }
    
    if ($ExcludeEventId) {
        $UpdateXpathSplat = @{
            Xpath   = $EventLogParameter.Xpath
            EventId = $ExcludeEventId
        }
        $EventLogParameter.Xpath = Update-XpathFilter @UpdateXpathSplat
    }

    Get-WinEvent @EventLogParameter
}