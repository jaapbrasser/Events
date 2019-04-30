$WebSplat = @{
    uri = 'https://powershellsummit.azurewebsites.net/api/HttpTrigger1?code='
    method = 'post'
    body = [pscustomobject]@{name='PowerShell + DevOps Summit'}
}

Invoke-RestMethod @WebSplat

