$psISE.Options.Zoom = 160
break

#####
Find-Module xJea
Install-Module -Name xJea -Verbose -Force

#psedit c:\temp\Demo1-Prep.ps1
#psedit c:\temp\Demo2-Prep.ps1

psedit '/temp/Demo1-Prep.ps1'

ConvertFrom-SDDL 'O:NSG:BAD:P(A;;GX;;;WD)' | Select-Object -ExpandProperty Access

Get-PSSessionConfiguration | Select Name

Get-PSSessionConfiguration Demo*

Get-PSSessionConfiguration Demo1 | Select-Object *

$StartupScript = (Get-PSSessionConfiguration Demo1).StartupScript

psedit $StartupScript

psedit 'C:\Program Files\Jea\Toolkit\Demo1-ToolKit.psm1'

ConvertFrom-SDDL 'O:NSG:BAD:P(A;;GA;;;S-1-5-21-3817790416-2066694576-4058203337-1002)' |
Select-Object -ExpandProperty Access