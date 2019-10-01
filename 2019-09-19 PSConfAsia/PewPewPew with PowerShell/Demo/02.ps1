# attaching debugger to remote process

#region setup
New-Item -ItemType Directory -Path AzFunc | Set-Location
func init
func new
# adjust managedDependency
# add wait-debugger
#endregion

#region debug azure function with console
func start
<#
    Get-PSHostProcessInfo
    Enter-PSHostProcess
    Get-Runspace
    Debug-Runspace
#>
#endregion

#region debug azure function with vs code
func start &
Get-Job | Remove-Job -Force
Set-Location ..
Remove-Item ./AzFunc -Recurse -Force
#endregion