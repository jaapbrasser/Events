<# </> Get function URL
    https://myfirstfunction43321.azurewebsites.net/api/Functions_Demo_3?code=cgoVoJI1bXfIJqWqwK0aHovlOWwv5oXAKDbnpl/w6jtxcKCXJoiIog==
#>

$FirstFunctionSplat = @{
    Uri = 'https://myfirstfunction43321.azurewebsites.net/api/Functions_Demo_3?code=cgoVoJI1bXfIJqWqwK0aHovlOWwv5oXAKDbnpl/w6jtxcKCXJoiIog=='
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