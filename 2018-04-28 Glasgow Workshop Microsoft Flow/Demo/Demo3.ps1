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

# Splat Glasgow
$Splat = @{
    Uri = 'https://prod-24.westeurope.logic.azure.com:443/workflows/5abcf6d9c0ce4b398ba6a72499e86c3b/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=1I-SCXvUowoBzYafB8yIM-NCKv984HHxC-255IpGCCk'
    Method = 'post'
    ContentType = 'application/json'
    Body = [pscustomobject]@{Trigger='Glasgow'} | ConvertTo-Json
}
Invoke-RestMethod @Splat

Set-Location 'C:\Users\Jaap Brasser\OneDrive - Brasser Advisory Services\1FlowDemo'

# List all json files
dir *json

# Read content of all json files
cat *json

# Read and convert binary file to base64
$ReadBytes = [system.io.file]::ReadAllBytes('C:\Users\Jaap Brasser\OneDrive\Documents\Events\2018-04 WinOps\Demo\Helper\dodgybinary')
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
(ls | sort LastWriteTime)[-1]

cat (ls | sort LastWriteTime)[-1] | ConvertFrom-Json

(cat (ls | sort LastWriteTime)[-1] | ConvertFrom-Json).Trigger

# Convert to binary
$ReceivedBase64 = cat (ls | sort LastWriteTime)[-1]
$ReceivedBase64 = cat (ls)[3]

$ConvertBytes = [convert]::FromBase64String($ReceivedBase64)

$ReceivedFile = 'C:\Users\Jaap Brasser\OneDrive\Documents\Events\2018-04 WinOps\Demo\Helper\ReceivedFile'

# Write binary to disk
[System.IO.File]::WriteAllBytes($ReceivedFile, $ConvertBytes)

# Establish file type
cat $ReceivedFile -Encoding Byte -TotalCount 30
-join [char[]](cat $ReceivedFile -Encoding Byte -TotalCount 30)























# Rename to correct file type
Rename-Item $ReceivedFile "$ReceivedFile.jpg"
ii "$ReceivedFile.jpg"