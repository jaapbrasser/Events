#region Have your Users Greeted



# Login Script

Function Out-Voice
{
[cmdletBinding()]
Param
(
    [parameter(ValueFromPipeline=$True,
               ValueFromPipelineByPropertyName=$True)]
               [String]$VoiceMessage,
    [parameter(ValueFromPipelineByPropertyName=$True)]
    [ValidateSet("US_Male","UK_Female","US_Female")]          
               [String]$VoiceType,
               [Switch]$PassThru,
    [parameter(ValueFromPipeline=$True)]
               [PSObject]$InputObject         
)
    BEGIN
    {
        # When the cmdlet starts, create a new
        # SAPI voice object.
        $voice = New-Object -com SAPI.SpVoice
    }
   
    PROCESS
    {
        # If an array of messages is passed, this will allow
        # for each message to be read.
        ForEach ($M in $VoiceMessage)
        {
            # If the client is Windows 8, then allow for different voices.
            If ((Get-CimInstance -ClassName Win32_Operatingsystem).Name -Like "*Windows 8*")
            {             
                # Get a list of all voices.
                $Voice.GetVoices() | Out-Null
                $voices = $Voice.GetVoices();
                $V = @()
                ForEach ($Item in $Voices)
                {
                    $V += $Item
                }                  
                   
                # Set the voice to use using the $VoiceType parameter.
                # The defualt voice will be used otherwise.
                Switch ($VoiceType)
                {
                    "US_Male" {$Voice.Voice = $V[0]}
                    "UK_Female" {$Voice.Voice = $V[1]}
                    "US_Female" {$Voice.Voice = $V[2]}
                }
            } # End: IF Statment.
            # Speak the message.
            $voice.Speak($M) | Out-Null
        }
    } # End: ForEach ($M in $VoiceMessage)
   
    END
    {
        If ($PassThru)
        {
            Write-Output $InputObject
        }
    } #End: PROCESS

<#
.SYNOPSIS
Reads a message to the user.

.DESCRIPTION
Uses the default voice of the client to read a message
to the user.

.PARAMETER Message
The string of text to read.

.PARAMETER VoiceType
Allows for the default choice to be changed using the
default voices installed on Windows 8. Acceptable values are:
US_Male
UK_Female
US_Female

.PARAMETER PassThru
Passes the piped in object to the pipeline.

.EXAMPLE
Out-Voice "Script Complete"

Reads back to the user "Script Complete"

.EXAMPLE
$CustomObject | Out-Voice -PassThru

If the object has a property called "VoiceMessage" and is of
data type [STRING], then the string is read.  If the object
contains a "VoiceType" parameter that is valid, that
voice will be used. The original object is then passed
into the pipeline.

.EXAMPLE
Get-WmiObject Win32_Product |
ForEach -process {Write-Output $_} -end{Out-Voice -VoiceMessage "Script Completed"}

Recovers the product information from WMI and the notifies the
user with the voice message "Script Completed" while also
passing the results to the pipeline.

.EXAMPLE
Start-Job -ScriptBlock {Get-WmiObject WIn32_Product} -Name GetProducts
While ((Get-job -Name GetProducts).State -ne "Completed")
{
    Start-sleep -Milliseconds 500
}
Out-Voice -VoiceMessage "Done"

Notifies the user when a background job has completed.

.NOTES
Tested on Windows 8
+-------------------------------------------------------------+
| Copyright 2013 MCTExpert, Inc. All Rights Reserved          |
| User takes full responsibility for the execution of this    |
| and all other code.                                         |
+-------------------------------------------------------------+
#>
} # End: Out-Voice



$dom = $env:userdomain
$usr = $env:username
$Name = ([adsi]"WinNT://$dom/$usr,user").NAME

$Hour = (Get-Date).Hour
If ($Hour -lt 12) {"Good Morning $($Name)" | Out-Voice}
ElseIf ($Hour -gt 16) {"Good Eventing $($Name)" | Out-Voice}
Else {"Good Afternoon $($Name)" | Out-Voice}


#endregion Have your Users Greeted

#region Test your script speed - Methods

    # Note: Requires Windows PowerShell V4 or higher.

    # Look for all processes that have a CPU value greater than 10.
    
    # Where-Object Basic Syntax
    Get-Process |
        Where-Object CPU -GT 10

    # Where-Object Advanced Syntax
    Get-Process |
        Where-Object -FilterScript {$_.CPU -gt 10}

    # Where method
    @(Get-Process).Where({$_.CPU -gt 10})
    (Get-Process).Where({$_.CPU -gt 10})

    $Data = Get-Process
    @($Data).Where({$_.CPU -gt 10})

    $Data2 = @(Get-Process)
    $Data2.Where({$_.CPU -gt 10})

    # Syntax
    @().Where()   # The error message will show you what it is looking for.
    @().Where({}) # It is looking for a script block.
    @().Where{}   # You do not need the parenthesis.

    # Expression
    @(Get-Process).Where({$_.CPU -gt 10})
    @(Get-Process).Where{$_.CPU -gt 10}

    # NumberToReturn - The number of matches to return.
    @(Get-Process).Where({$_.CPU -gt 10},'Default',4)
  
    # Mode
    <#
    Name     |   Description
    ---------+------------------------------------------------------------------
    Default  |   Return all matches.
    First    |   Stop processing after the first match.
    Last     |   Return the last matching element.
    SkipUntil|   Skip until the condition is true, then return the rest.
    Split    |   Return an array of two elements, first index is matched 
             |   elements, second index is the remaining elements.
    Until    |   Return elements until the condition is true then skip the rest.
    #>
    @(Get-Process).Where({$_.CPU -gt 10},'First')
    @(Get-Process).Where({$_.CPU -gt 10},'First',2)
    
    @(Get-Process).Where({$_.CPU -gt 10},'Last')
    @(Get-Process).Where({$_.CPU -gt 10},'Last', 3)
    
    # Change the filter value.  You will notice that the first
    # object returned will match that filter and then all all
    # objects will be returned.
    @(Get-Process).Where({$_.CPU -gt 50},'SkipUntil')

    $Matches, $Remaining = @(Get-Process).Where({$_.CPU -gt 200},'Split')
    $Matches # This will contain the objects that meet the criteria.
    $Remaining  # This will contain the objects that do not.

    @(Get-Process).Where({$_.CPU -gt 200},'Until')
    
    # Test the average execution times over 50 iterations.

    Write-Host "Basic Syntax:    " -ForegroundColor Green -NoNewline
    1..50| ForEach -Begin{$Sum = 0} `
          -Process {$Sum += Measure-Command -Expression {Get-Process | Where-Object -Property CPU -GT 10}} `
          -End {$Sum | Measure-Object -Property Ticks -Average | Select-Object -ExpandProperty Average}

    Write-Host "Advanced Syntax: " -ForegroundColor Yellow -NoNewline
    1..50| ForEach -Begin{$Sum = 0} `
          -Process {$Sum += Measure-Command -Expression {Get-Process | Where-Object -FilterScript {$_.CPU -gt 10}}} `
          -End {$Sum | Measure-Object -Property Ticks -Average | Select-Object -ExpandProperty Average}

    Write-Host "Method:          " -ForegroundColor Cyan -NoNewline
    1..50| ForEach -Begin{$Sum = 0} `
        -Process {$Sum += Measure-Command -Expression {@(Get-Process).Where({$_.CPU -gt 10})}} `
        -End {$Sum | Measure-Object -Property Ticks -Average | Select-Object -ExpandProperty Average}



#endregion Test your script speed - Methods

#region Test your script speed - PowerShell Streams

    # PowerShell streams
    Write-Host "Stream |  Definition             | Cmdlet"
    Write-Host "1      |  Success output         | Write-Output       " -ForegroundColor White -BackgroundColor Darkgreen
    Write-Host "2      |  Errors                 | Write-Error        " -ForegroundColor White -BackgroundColor DarkRed
    Write-Host "3      |  Warning messages       | Write-Warning      " -ForegroundColor Red -BackgroundColor DarkYellow
    Write-Host "4      |  Verbose output         | Write-Verbose      " -ForegroundColor Cyan -BackgroundColor DarkCyan
    Write-Host "5      |  Debug messages         | Write-Debug        " -ForegroundColor Yellow -BackgroundColor DarkYellow
    Write-Host "6      |  Informational messages | Write-Information  " -ForegroundColor White -BackgroundColor DarkGray
    Write-Host "NA     |  User Experience        | Write-Host         " -ForegroundColor white -BackgroundColor blue

#end region Test your script speed -  PowerShell Streams

#region Display Time Demo
    # Avoid display excessive information on the screen.
    Function Test-DisplayHost
    {
        For($X = 0 ; $X -lt 100 ;$X++)
        {
            Write-Host "Write-Host $X" -ForegroundColor green
        }
    }

    Function Test-DisplayVerbose
    {
        For($X = 0 ; $X -lt 100 ;$X++)
        {
            Write-Verbose "Write-Verbose $X" -Verbose
        }
    }

    Function Test-DisplayInformation
    {
        For($X = 0 ; $X -lt 100 ;$X++)
        {
            Write-Information "Write-Information $X" -InformationAction Continue
        }
    }

    Function Test-DisplayOutput
    {
        For($X = 0 ; $X -lt 100 ;$X++)
        {
            Write-Output "Write-Output $X" 
        }
    }

    Function Test-NoDisplay
    {
        For($X = 0 ; $X -lt 100 ;$X++)
        {
   
        }
    }



    Write-Host "Testing Write-Host" -ForegroundColor Cyan
    $WriteHost = Measure-Command -Expression {
        Test-DisplayHost

    }

    Write-Host "Testing Write-Information" -ForegroundColor Cyan
    $WriteVerbose = Measure-Command -Expression {
        Test-DisplayVerbose

    }

    Write-Host "Testing Write-Information" -ForegroundColor Cyan
    $WriteInformation = Measure-Command -Expression {
        Test-DisplayInformation

    }

    Write-Host "Testing Write-Output" -ForegroundColor Cyan
    $WriteOutput = Measure-Command -Expression {
        Test-DisplayOutput

    }

    Write-Host "Testing Nothing" -ForegroundColor Cyan
    $WriteNoting = Measure-Command -Expression {
        Test-NoDisplay

    }

    Write-Host 
    Write-Host "--- Results - Ticks --------------------------" -ForegroundColor Yellow
    Write-Host "Write-Host        | $($WriteHost.Ticks)"
    Write-Host "Write-Verbose     | $($WriteVerbose.Ticks)"
    Write-Host "Write-Information | $($WriteInformation.Ticks)"
    Write-Host "Write-Output      | $($WriteOutput.Ticks)"
    Write-Host "Write nothing     | $($WriteNoting.Ticks)"

    Write-Host 
    Write-Host "--- Results - Milliseconds -------------------" -ForegroundColor Yellow
    Write-Host "Write-Host        | $($WriteHost.Milliseconds)"
    Write-Host "Write-Verbose     | $($WriteVerbose.Milliseconds)"
    Write-Host "Write-Information | $($WriteInformation.Milliseconds)"
    Write-Host "Write-Output      | $($WriteOutput.Milliseconds)"
    Write-Host "Write nothing     | $($WriteNoting.Milliseconds)"


  
#endregion Test your script speed - Excessive output





#region - Additional Information

    # Avoid Displaying Information
    Start-Process "http://mctexpert.blogspot.com/2016/10/avoid-displaying-information.html"

    # How to get PowerShell to Greet You
    Start-Process "http://mctexpert.blogspot.com/2014/06/how-to-get-powershell-to-greet-you.html"

    # Advanced WIndows PowerShell Scripting
    Start-Process "http://shop.oreilly.com/product/0636920045823.do" 

#endregion - Additional Information
