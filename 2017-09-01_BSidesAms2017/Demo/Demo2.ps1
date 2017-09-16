ls C:\ScriptsAll | Measure-Object | Select-Object -Property Count
ls C:\Scripts | Measure-Object | Select-Object -Property Count

$GlobalChars = ls C:\ScriptsAll\ | Measure-CharacterFrequency.ps1
$GlobalChars | Select-Object -First 10

# Compare normal scripts with Invoke-Mimikatz
ls C:\Scripts | ForEach-Object {
    $HashVector = @{
        Set1          = $GlobalChars
        Set2          = $_ | Measure-CharacterFrequency.ps1
        KeyProperty   = 'Name'
        ValueProperty = 'Percent'
    }
    [PSCustomObject]@{
        Name       = $_.Name
        Similarity = Measure-VectorSimilarity.ps1 @HashVector
                        
    }
} | Sort-Object Similarity

# Compress & Encode a script
Get-Item C:\Scripts\deleteold.ps1
Get-Item C:\CompressedBase64Deleteold.ps1
cat C:\CompressedBase64Deleteold.ps1

# Compare Base64 encoded command
Get-Item C:\CompressedBase64Deleteold.ps1 | ForEach-Object {
    $HashVector = @{
        Set1          = $GlobalChars
        Set2          = $_ | Measure-CharacterFrequency.ps1
        KeyProperty   = 'Name'
        ValueProperty = 'Percent'
    }
    [PSCustomObject]@{
        Name       = $_.Name
        Similarity = Measure-VectorSimilarity.ps1 @HashVector
                        
    }
}

# Show ISE Obfuscation
psedit C:\Scripts\deleteold.ps1
cat C:\ISEDeleteold.ps1
Get-Item C:\ISEDeleteold.ps1 | ForEach-Object {
    $HashVector = @{
        Set1          = $GlobalChars
        Set2          = $_ | Measure-CharacterFrequency.ps1
        KeyProperty   = 'Name'
        ValueProperty = 'Percent'
    }
    [PSCustomObject]@{
        Name       = $_.Name
        Similarity = Measure-VectorSimilarity.ps1 @HashVector
    }
}