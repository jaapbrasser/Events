# POST method: $req
$requestBody = Get-Content $req -Raw | ConvertFrom-Json
$name = $requestBody.name

# GET method: each querystring parameter is its own variable
if ($req_query_name) 
{
    $name = $req_query_name 
}

switch ($name) {
    'PSVersion' {$outvar = $psversiontable.PSVersion}
    'Env'       {$outvar = Get-ChildItem -Path Env:\ | Out-String}
    'Variable'  {$outvar = Get-ChildItem -Path Variable:\ | Out-String}
    'ResReq'    {$outvar = $res, $req | Out-String}
    'London'    {$outvar = 'Hello London, welcome to an evening of Azure Functions'}
    'WhereAmI'  {$outvar = $env:Function_Address}
}

Out-File -NoNewLine -Encoding Ascii -FilePath $res -inputObject $OutVar