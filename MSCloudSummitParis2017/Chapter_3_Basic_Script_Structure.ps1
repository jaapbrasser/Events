# Set Default ISE options
# break
$PSISE.Options.Zoom = 160

#region Bad script
for($j=67;gdr($d=[char]++$j)2>0){}$d
#endregion

#region Better script
function Get-FirstAvailableDriveLetter {
    $AthroughZ       = [char[]](67..90)
    $UsedDriveLetter = Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty Name
    
    # This script will loop through C-Z and selects the first available drive letter
    $AthroughZ | Where-Object {
          $UsedDriveLetter -notcontains $_
    } | Select-Object -First 1
}
Get-FirstAvailableDriveLetter
#endregion

#region Different function
function Get-FirstAvailableDriveLetter {
<#
.SYNOPSIS
This function will output the first available drive letter
#>
    $AthroughZ = [char[]](67..90)
    try {
        $AthroughZ | ForEach-Object {
            $null = Get-PSDrive -Name $_ -ErrorAction Stop 
        }
    } catch {
        $_.CategoryInfo.TargetName
    }
}
Get-FirstAvailableDriveLetter
#endregion