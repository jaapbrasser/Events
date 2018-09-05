# POST method: $req
$requestBody = Get-Content $req -Raw | ConvertFrom-Json
$name = $requestBody.name

# GET method: each querystring parameter is its own variable
if ($req_query_name) 
{
    $name = $req_query_name 
}

$Outvar = switch ($name) {
    'PSVersion'    {$psversiontable.PSVersion}
    'Env'          {Get-ChildItem -Path Env:\ | Out-String}
    'Variable'     {Get-ChildItem -Path Variable:\ | Out-String}
    'ResReq'       {$res, $req | Out-String}
    'Arizona PSUG' {"Hello Arizona PSUG, welcome and let's have fun with Azure Functions!"}
    'WhereAmI'     {$env:Function_Address}
    'Modules'      {(Get-Module -ListAvailable | Select-Object -ExpandProperty Name | Sort-Object) -join "`r`n"}
}

Out-File -NoNewLine -Encoding Ascii -FilePath $res -inputObject $OutVar