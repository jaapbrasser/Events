Get-ChildItem -Path $home -Recurse -Force -ErrorAction SilentlyContinue |
Measure-Object -Property Length -Sum 

cmd /c dir $home /-C /S /A:-D-L

(cmd /c dir $home /-C /S /A:-D-L)[-2]

(robocopy.exe $home c:\doesnotexist /L /XJ /R:0 /W:1 /NP /E /BYTES /nfl /ndl /njh /MT:64)[-4]

Measure-Command -Expression {
    (1..5).foreach{(Get-ChildItem -Path $home -Recurse -force -ea 0 | Measure-Object length -Sum).sum}
} | Select-Object -Property TotalMilliseconds 
 
Measure-Command -Expression {
    (1..5).foreach{((cmd /c dir $home /-C /S /A:-D-L)[-2] -split '\s+')[3]}
} | Select-Object -Property TotalMilliseconds 
 
Measure-Command -Expression {
    (1..5).foreach{((robocopy.exe $home c:\doesnotexist /L /XJ /R:0 /W:1 /NP /E /BYTES /nfl /ndl /njh /MT:64)[-4] -replace '\D+(\d+).*','$1')}
} | Select-Object -Property TotalMilliseconds