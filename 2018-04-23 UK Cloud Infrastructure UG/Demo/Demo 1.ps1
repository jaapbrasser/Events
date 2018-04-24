<# </> Get function URL
    https://myfirstfunction43321.azurewebsites.net/api/HttpTriggerPowerShell1?code=FKTa1kmL8z3fZm93q3obfmSVtZgUlgIFm3n2/caqrZNpsEzqhQXQ/A==
#>

$FirstFunctionSplat = @{
    Uri = 'https://myfirstfunction43321.azurewebsites.net/api/HttpTriggerPowerShell1?code=FKTa1kmL8z3fZm93q3obfmSVtZgUlgIFm3n2/caqrZNpsEzqhQXQ/A=='
    Method = 'post'
    ContentType = 'application/json'
    Body = [pscustomobject]@{Name='ResReq'} | ConvertTo-Json
}
Invoke-RestMethod @FirstFunctionSplat

$FirstFunctionSplat.Body = [pscustomobject]@{Name='London'} | ConvertTo-Json
Invoke-RestMethod @FirstFunctionSplat

# Show function.json configuration
# Show Function App variable configuration

$FirstFunctionSplat.Body = [pscustomobject]@{Name='WhereAmI'} | ConvertTo-Json
Invoke-RestMethod @FirstFunctionSplat

Start-Process 'https://www.google.com/maps/place/WeWork+Waterhouse+Square/@51.5187955,-0.1122909,17z/data=!3m1!4b1!4m5!3m4!1s0x48761b4c5a5da723:0x68846fbdc3686cec!8m2!3d51.5187955!4d-0.1100969'