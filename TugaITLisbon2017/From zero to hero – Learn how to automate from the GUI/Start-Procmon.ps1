<#
.SYNOPSIS
	Start-ProcMon uses Powershell to call Process Monitor, a tool from the Sysinternals Suite.  
	This script adds the functionality of dynamically specifying filters, which allows automation
	with a minimal performance impact.
.DESCRIPTION
	Written by Nick Atkins @Nik_41tkins
	http://nomanualrequired.blogspot.com/
	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
.PARAMATER Filter
	A process monitor filter specified by a comma seperated string, seperate multiple filters with ;
	<Column>,<Relation>,<Value>,<Action>
.PARAMATER Duration
	The number of seconds to monitor the system. Defaults to 60 seconds.
.PARAMATER KeepAll
	If this switch is specified, no events will be dropped unless specified in a filter.
.PARAMATER ProcMonFolder
	Specifies folder that contains procmon.exe.  Local directory is assumed if not supplied.
.EXAMPLE
	Start-ProcMon -Filter "ProcessName,is,cmd.exe,Exclude;ProcessName,is,explorer.exe,Exclude" `
		-Duration 120 
#>
	param(
			[Parameter(Position=0)]
			[string]$Filter,
			[int]$Duration,
			[switch]$KeepAll,
			[string]$ProcMonFolder
		)
		
	function convert-FilterToObj
	{	   
	   $FilterObj = @()  #Init blank array
	   #Filters must be seperated by ;
	   $Filter = $filter.split(';')
	   $Filter | % {
		  #Use builtin split method to convert comma seperated string into array
		  $_ = $_.split(',')
		  #Checking our array for exactly four objects
		  if(($_ | measure).count -ne 4)
		  	{return "Error: Filter is not in correct format."}
		  else
		  {
		    #Convert filter into an object, remove spaces from Column/Relation
		    $CurrentFilter = New-Object system.Object
		    $CurrentFilter | Add-Member noteproperty -Name "Column" -Value $_[0].replace(' ','')
			$CurrentFilter | Add-Member noteproperty -Name "Relation" -Value $_[1].replace(' ','')
			$CurrentFilter | Add-Member noteproperty -Name "Value" -Value $_[2]
			$CurrentFilter | Add-Member noteproperty -Name "Action" -Value $_[3]
			#Add current filter to output object
			$FilterObj += $CurrentFilter
	      }
	   }
	return $FilterObj
	}
	function convert-LargeValues
	{
		param($Value)
		if($Value.Length -gt 2)
		{
			$FirstByte =  [string]::Join("",$Value[1..2])
			$SecondByte = $Value[0]
		}
		else
		{
			$FirstByte = $Value
			$SecondByte = 0
		}
		return "0x$FirstByte","0x$SecondByte"
	}
	function get-ProcmonRunningStatus
	{
		#Check if process monitor is currently running
		sleep -Seconds 1
		if((Get-Process procmon -ea silentlycontinue) -eq $null)
			{return "False"}
		else
			{return "True"}		
	}
	function write-ProcmonFilterValue
	{
	    #Start of filter is 1 declare type as an array of bytes
	    [Byte[]]$FilterRegkey = "0x1"
	    #Followed by number of filters
	    $NumFilters = [convert]::tostring((($FilterObj | measure).count),"16")
	    #Multiple registry keys can overflow when using largeValues
		#A function was created to split these large values into two bytes
		$FilterRegKey += (convert-LargeValues -value $NumFilters)
		#Two padding bytes
		$FilterRegkey += "0x0","0x0"
	    #Header is written, build filters from friendly strings
	    $FilterObj | %	{
		  #Check for syntax errors
		  if($FilterRegkey -match "Error")
		   	  {return} 
		  #First write column code, and 9c divider
	      switch($_.Column)
	      {
	        "ProcessName"      {$FilterRegKey += "0x75","0x9c"}
	        "PID"              {$FilterRegKey += "0x76","0x9c"}
	        "Result"           {$FilterRegKey += "0x78","0x9c"}
	        "Detail"           {$FilterRegkey += "0x79","0x9c"}
	        "Duration"         {$FilterRegKey += "0x8d","0x9c"}
	        "ImagePath"        {$FilterRegKey += "0x84","0x9c"}
	   	    "RelativeTime"     {$FilterRegKey += "0x8c","0x9c"}
	        "CommandLine"      {$FilterRegKey += "0x82","0x9c"}
			"User"             {$FilterRegKey += "0x83","0x9c"}
			"Operation"        {$FilterRegKey += "0x77","0x9c"}
			"ImagePath"        {$FilterRegKey += "0x84","0x9c"}
			"Session"          {$FilterRegKey += "0x85","0x9c"}
			"Path"             {$FilterRegKey += "0x87","0x9c"}
			"TID"              {$FilterRegKey += "0x88","0x9c"}
			"Duration"         {$FilterRegKey += "0x8D","0x9c"}
			"TimeOfDay"        {$FilterRegKey += "0x8E","0x9c"}
			"Version"          {$FilterRegKey += "0x91","0x9c"}
			"EventClass"       {$FilterRegKey += "0x92","0x9c"}
			"AuthenticationID" {$FilterRegKey += "0x93","0x9c"}
			"Virtualized"      {$FilterRegKey += "0x94","0x9c"}
			"Integrity"        {$FilterRegKey += "0x95","0x9c"}
			"Category"         {$FilterRegKey += "0x96","0x9c"}
			"Parent PID"       {$FilterRegKey += "0x97","0x9c"}
			"Architecture"     {$FilterRegKey += "0x98","0x9c"}
	        "Sequence"         {$FilterRegKey += "0x7A","0x9c"}	
			"Company"          {$FilterRegKey += "0x80","0x9c"}
			"Description"      {$FilterRegkey += "0x81","0x9c"}
			default            {
								[string]$FilterRegKey = "Error: Check Column values."
							    return
							   }
		   }
		   
		   #Add two zero bytes padding before comparison
		   $FilterRegkey += "0x0","0x0"
	       #Now add Relation byte
		   switch($_.Relation)
	       {
	        "is"         {$FilterRegKey += "0x0"}
	        "isNot"      {$FilterRegkey += "0x1"}
	        "lessThan"   {$filterregkey += "0x2"}
	        "moreThan"   {$FilterRegkey += "0x3"}
	        "endsWith"   {$FilterRegkey += "0x5"}
	        "BeginsWith" {$FilterRegkey += "0x4"}
		    "Contains"   {$FilterRegKEy += "0x6"}
	        "excludes"   {$FilterRegkey += "0x7"}
			default      {
							[string]$FilterRegKey = "Error: Check Relation values."
							return}
	       }
		    
		   #Add three zero bytes before Action (Include/Exclude)
		   $FilterRegKey += "0x0","0x0","0x0"
		   #Now Include/Exclude
	       if  ($_.Action -match "incl"){$FilterRegkey += "0x1"}
	       elseif($_.Action -match "excl"){$FilterRegKey += "0x0"}
		   else{[string]$FilterRegkey = "Error: Check Action Values.";return}
	       #Add length of <Value> string.
		   #Length is hex value of (characters * 2(account for nulls) + 2)(account for spacer bytes)
		   $NumPathChars = [Convert]::tostring(((($_.value.toCharArray() | measure).count *  2) + 2),"16")
		   $FilterRegKey += (convert-LargeValues -value $NumPathChars)
		   #Two zero bytes padding
		   $FilterRegkey += "0x0","0x0"
		   #Convert string "Value" to binary Ascii array (ie. A = 0x41)
		   $_.Value.toCharArray() | % {
	       	 $FilterRegkey += (convert-largeValues -value ([Convert]::ToString(([char]$_ -as [int]),"16")))
		   	}
	       #Current Filter calculated, pad with 10 zero bytes
		   $FilterRegkey += "0x0","0x0","0x0","0x0","0x0","0x0","0x0","0x0","0x0","0x0"
	     }                      
	     #Check for syntax errors
		 if($FilterRegkey -match "Error")
		 	{return ($FilterRegkey | sort | get-unique)}
			
		 #Set filter
		 New-ItemProperty "HKCU:\Software\Sysinternals\Process Monitor" "FilterRules" -Value $FilterRegKey `
		   -PropertyType Binary -Force -ErrorVariable SetRegKeyErr | Out-Null
		 if(($setRegKeyErr | measure).count -ne 0)
			 {Return "Error: Writing registry failed."}
		 else{return 0}
	 }
##Main
#Function used for cleaning up temp files
function cleanup
{
	#CSV file only exists on the last step
	$ExistCSV = "False"
	if((test-path $tempCSV) -eq $true)
	{
		$ExistCSV = "True"
		del $tempCSV -Force
	}
	del $tempPml -Force
	if((Test-Path $TempPML) -eq $true)
		{return "Failed to delete temp files." }
	elseif($ExistCSV -eq "True" -and ((Test-Path $ExistCSV) -eq $true))
		{return "Failed to delete temp files."}
	else
		{return 0}
}
#First check if process monitor is currently running.
if((get-ProcmonRunningStatus) -eq "True")
	{return "Error: Process Monitor already running."}

#Check if running as admin
if( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator"))
		{return "Error: Script must run with Admin rights."}	

##Setup running enviroment based on specified paramaters
#Default duration to 60 seconds if not set.
if($Duration -eq 0)
	{$Duration = 60}

#If ProcMonFolder ends with a "\", remove
if(($ProcMonFolder[$ProcMonFolder.Length - 1]) -eq '\')
	{$ProcMonFolder.Remove((($ProcMonFolder.Length) - 1),1)}

#Include profiling events only if paramater switch set
if($KeepAll.tostring() -ne "True" -and ($Filter.length) -ne 0)
{
  $Filter += ";EventClass,is,profiling,exclude"
  #Set "Drop Filtered Events"
  New-ItemProperty "HKCU:\Software\Sysinternals\Process Monitor" "DestructiveFilter" `
  -Value ("0x1","0x0","0x0","0x0") -PropertyType Binary -Force | out-null
}

#Convert user input into proper object
if(($Filter.length) -ne 0)
{
	Write-Verbose "Converting user supplied filter into object format."
	$FilterObj = convert-FiltertoObj
	if($FilterObj -match "Error:")
		{return $FilterObj}
}
else
{
	Write-Verbose "No filter specified, writing one that will never trigger."
	$Filter = "pid,is,AAAAAAA,exclude"
	$FilterObj = convert-FiltertoObj 
	if($FilterObj -match "Error:")
		{return $FilterObj}
}

#Attempt to write filter
Write-Verbose "Attemping to write filter registry value."
$FilterWriteResult = write-ProcmonFilterValue
if($FilterWriteResult -match "Error:")
	{return $FilterWriteResult}
				
#If no directory specified try current folder
if(($ProcMonFolder.Length) -eq 0)
	{$ProcMonFolder = "."}
Set-Location $ProcMonFolder

#Cheap way to get a pseudorandom tempfile name with benifit of timestamp
$FileDate=((get-date).TimeOfDay.ToString().Replace('.','_')).replace(':','_')
$TempPML = ".\Temp_$FileDate.pml"
$TempCSV = ".\Temp_$FileDate.csv"

#Test for executable
Write-Verbose "Testing for Procmon.exe."
if((Test-Path "$ProcMonfolder\procmon.exe") -eq $false)
	{return "Error: Procmon.exe not found.`n"}

#Run procmon backed to file, supress prompts
Write-Verbose "Attempting to start Process Monitor."
start-process -filepath ".\Procmon" -argument "/backingfile $TempPML /quiet /accepteula" `
	-WindowStyle Hidden

#Sleep for a number of seconds procmon should run
Write-Verbose "Process Monitor running for $Duration seconds."
Sleep -seconds $Duration

#Gracefully terminate procmon, wait for completion
Start-Process -FilePath ".\procmon" -argument "/terminate /accepteula" -Wait -WindowStyle Hidden

#Verify procmon is stopped
if((get-ProcmonRunningStatus) -eq "True")
{   
	$retErr = "Error: Process Monitor already running. Graceful Terminate failed.`n"
	if((cleanup) -ne 0)
		{$retErr += "Error: Cleanup of temp files failed."}
	return $retErr
}

#Convert PML to CSV
Write-Verbose "Converting native PML to CSV. "
Start-Process -FilePath ".\procmon" -argument "/openlog $TempPml /saveAs $TempCSV /accepteula" `
  -Wait -WindowStyle Hidden

#Verify procmon stopped
if((get-ProcmonRunningStatus) -eq "True")
	{return "Error: Process Monitor still running. Graceful PML -> CSV conversion failed."}

#Attempt to import the newly converted CSV
$OutputObj = import-csv $TempCSV -ErrorVariable ImportCSVErr
if(($ImportCSVErr | measure).count -ne 0)
	{return "Error: Loading converted CSV file failed.`n"}

#Cleanup	
if((cleanup) -ne 0)
	{Write-Warning "Final cleanup of temp files failed."}

#Go back from whence we came and return fruits of our labor
Pop-Location
return $OutputObj

