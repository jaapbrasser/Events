<#

Json trigger

{
    "type": "object",
    "properties": {
        "Trigger": {
            "type": "string"
        }
    }
}

#>

# Splat New York
$Splat = @{
    Uri = 'https://prod-24.westeurope.logic.azure.com:443/workflows/5abcf6d9c0ce4b398ba6a72499e86c3b/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=1I-SCXvUowoBzYafB8yIM-NCKv984HHxC-255IpGCCk'
    Method = 'post'
    ContentType = 'application/json'
    Body = [pscustomobject]@{Trigger='New York'} | ConvertTo-Json
}
Invoke-RestMethod @Splat



Set-Location '/Users/jaapbrasser/OneDrive - Brasser Advisory Services'

# List all json files
dir *json

# Read content of all json files
cat *json

# Read and convert binary file to base64
$ReadBytes = [system.io.file]::ReadAllBytes('/Users/jaapbrasser/OneDrive/Documents/Events/2018-05 PSNYUG/Prep/Demo/Helper/dodgybinary')
$ReadBytes.Count

$Base64String = [convert]::ToBase64String($ReadBytes)

# Invoke-WebRequest
$Splat = @{
    Uri = 'https://prod-24.westeurope.logic.azure.com:443/workflows/5abcf6d9c0ce4b398ba6a72499e86c3b/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=1I-SCXvUowoBzYafB8yIM-NCKv984HHxC-255IpGCCk'
    Method = 'post'
    ContentType = 'application/json'
    Body = [pscustomobject]@{Trigger=$Base64String} | ConvertTo-Json
}
Invoke-RestMethod @Splat

# Look at the files
Set-Location '/Users/jaapbrasser/Downloads/'

(Get-ChildItem | Sort-Object LastWriteTime)[-1]

Get-Content (Get-ChildItem | Sort-Object LastWriteTime)[-1] | ConvertFrom-Json

# Convert to binary
$ReceivedBase64 = Get-Content (Get-ChildItem | Sort-Object LastWriteTime)[-1]

$ConvertBytes = [convert]::FromBase64String($ReceivedBase64)

$ReceivedFile = '/Users/jaapbrasser/Downloads/ReceivedFile'

# Write binary to disk
[System.IO.File]::WriteAllBytes($ReceivedFile, $ConvertBytes)

# Establish file type
Get-Content $ReceivedFile | Select-Object -First 1
























# Rename to correct file type
Rename-Item $ReceivedFile "$ReceivedFile.jpg"
Invoke-Item "$ReceivedFile.jpg"