# Different methods of creating PowerShell custom objects


# Demo different method of foreach .ForEach for |ForEach
# For loop
Measure-Command {
    for ($i = 0; $i -lt 100KB; $i++) {
        $null = [math]::pow(2,10)
    }
} | Select-Object @{
    Name = 'Name'
    Expression = {'For loop'}
}, TotalMilliseconds

# ForEach-Object
Measure-Command {
    1..100KB | ForEach-Object {
        $null = [math]::pow(2,10)
    }
} | Select-Object @{
    Name = 'Name'
    Expression = {'Pipeline ForEach-Object'}
}, TotalMilliseconds

# ForEach keyword
Measure-Command {
    foreach ($item in 1..100KB) {
        $null = [math]::pow(2,10)
    }
} | Select-Object @{
    Name = 'Name'
    Expression = {'ForEach keyword'}
}, TotalMilliseconds

# ForEach keyword
Measure-Command {
    @(1..100KB).ForEach{
        $null = [math]::pow(2,10)
    }
} | Select-Object @{
    Name = 'Name'
    Expression = {'.ForEach array method'}
}, TotalMilliseconds

###
# Working with files
###

# Get-ChildItem
(Get-ChildItem C:\Temp -Recurse -force -erroraction SilentlyContinue | Measure-Object length -Sum).sum 
 
#Good old Dir, recursively
((cmd /c dir C:\Temp /-C /S /A:-D-L)[-2] -split '\s+')[3]
 
#RoboCopy in list only mode: 
(robocopy.exe C:\Temp c:\thisdoesnotexist /L /XJ /R:0 /W:1 /NP /E /BYTES /NFL /NDL /NJH /MT:64)[-4] -replace '\D+(\d+).*','$1'

# Measure performance of different methods
Measure-Command {
    (Get-ChildItem C:\Temp -Recurse -force -erroraction SilentlyContinue | Measure-Object length -Sum).sum 
} | Select-Object @{
    Name = 'Name'
    Expression = {'Only PowerShell'}
}, TotalMilliseconds

Measure-Command {
    ((cmd /c dir C:\Temp /-C /S /A:-D-L)[-2] -split '\s+')[3]
} | Select-Object @{
    Name = 'Name'
    Expression = {'dir command'}
}, TotalMilliseconds

Measure-Command {
    (robocopy.exe C:\Temp c:\thisdoesnotexist /L /XJ /R:0 /W:1 /NP /E /BYTES /NFL /NDL /NJH /MT:64)[-4] -replace '\D+(\d+).*','$1'
} | Select-Object @{
    Name = 'Name'
    Expression = {'robocopy'}
}, TotalMilliseconds


# Have some fun with operators
Get-ChildItem -Path 'C:\Users\Jaap Brasser'

Get-ChildItem -Path 'C:\Users\Jaap Brasser' | ? FullName -match 'C:\\Users\\Jaap Brasser\\Documents'
Get-ChildItem -Path 'C:\Users\Jaap Brasser' | ? FullName -match "$([regex]::Escape('C:\Users\Jaap Brasser\Documents'))"

# Using regular expressions to match around 
@'
???
###
!!!
We want this 1
We want this 2
Pattern
We want this 3
We want this 4
???
###
!!!
'@ -match '(?<c1>.*)\n(?<c2>.*)\n(?<p>Pattern).*?\n(?<c3>.*)\n(?<c4>.*)\n'
$null = $Matches.Remove(0)
[PSCustomObject]$Matches

# Create PSObjects with [pscustomobject] / ::New
Measure-Command {1..50000 | ForEach-Object {
    [pscustomobject]@{
        Property1 = 'Hello'
        Date      = Get-Date
        Ticks     = (Get-Date).Ticks
        'Object#' = $_    
    }
}} | Select-Object @{
    Name = 'Name'
    Expression = {'without new'}
}, TotalMilliseconds

Measure-Command {1..50000 | ForEach-Object {
    [pscustomobject]::new([ordered]@{
        Property1 = 'Hello'
        Date      = Get-Date
        Ticks     = (Get-Date).Ticks
        'Object#' = $_    
    })
}} | Select-Object @{
    Name = 'Name'
    Expression = {'with new'}
}, TotalMilliseconds