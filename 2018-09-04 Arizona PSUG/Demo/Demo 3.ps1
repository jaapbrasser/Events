<# </> Get function URL
    https://arizonapsug.azurewebsites.net/api/Demo3?code=HCyYhvoaZmImmOOPPGH0U2zjl1c2UeNFN4X5E1LnO/5gbxlzwYjWXA==
#>

$FirstFunctionSplat = @{
    Uri = 'https://arizonapsug.azurewebsites.net/api/Demo3?code=HCyYhvoaZmImmOOPPGH0U2zjl1c2UeNFN4X5E1LnO/5gbxlzwYjWXA=='
    Method = 'post'
    ContentType = 'application/json'
    Body = [pscustomobject]@{Name='Variable'} | ConvertTo-Json
}
Invoke-RestMethod @FirstFunctionSplat

$FirstFunctionSplat.Body = [pscustomobject]@{Name='ResReq'} | ConvertTo-Json
Invoke-RestMethod @FirstFunctionSplat

# Show function.json configuration
# Show Function App variable configuration

$FirstFunctionSplat.Body = [pscustomobject]@{Name='WhereAmI'} | ConvertTo-Json
Invoke-RestMethod @FirstFunctionSplat

$FirstFunctionSplat.Body = [pscustomobject]@{Name='AzureVersion'} | ConvertTo-Json
Invoke-RestMethod @FirstFunctionSplat | Set-Clipboard

$x = Invoke-RestMethod @FirstFunctionSplat
$x -split ','