$Collection = Get-Process
$result = @()
$CurrentDate = Get-Date
foreach ($Item in $Collection) {
    $Object = New-Object -TypeName PSCustomObject
    $Object | Add-Member -MemberType NoteProperty `
                         -Name 'FirstProperty'    `
                         -Value $Item.Name
    $Object | Add-Member -MemberType NoteProperty `
                         -Name 'SecondProperty'   `
                         -Value $Item.StartTime
    $Object | Add-Member -MemberType NoteProperty `
                         -Name 'ThirdProperty'    `
                         -Value $Item.Company
    $Object | Add-Member -MemberType NoteProperty `
                         -Name 'FourthProperty'   `
                         -Value $Item.Id
    $Object | Add-Member -MemberType NoteProperty `
                         -Name 'CurrentDate'      `
                         -Value $CurrentDate
    $result += $Object
}
$result

$Collection = Get-Process
$result = @()
$CurrentDate = Get-Date
foreach ($Item in $Collection) {
    $Object = New-Object -TypeName PSCustomObject -Property @{
        'FirstProperty'  = $Item.Name
        'SecondProperty' = $Item.StartTime
        'ThirdProperty'  = $Item.Company
        'FourthProperty' = $Item.Id
        'CurrentDate'    = $CurrentDate
    }
    $result += $Object
}
$result

$Collection = Get-Process
$CurrentDate = Get-Date
foreach ($Item in $Collection) {
    New-Object -TypeName PSCustomObject -Property @{
        'FirstProperty'  = $Item.Name
        'SecondProperty' = $Item.StartTime
        'ThirdProperty'  = $Item.Company
        'FourthProperty' = $Item.Id
        'CurrentDate'    = $CurrentDate
    }
}

$Collection = Get-Process
foreach ($Item in $Collection) {
    New-Object -TypeName PSCustomObject -Property @{
        'FirstProperty'  = $Item.Name
        'SecondProperty' = $Item.StartTime
        'ThirdProperty'  = $Item.Company
        'FourthProperty' = $Item.Id
        'CurrentDate'    = Get-Date
    }
}

Get-Process | ForEach-Object {
    [pscustomobject]@{
        'FirstProperty'  = $PSItem.Name
        'SecondProperty' = $PSItem.StartTime
        'ThirdProperty'  = $PSItem.Company
        'FourthProperty' = $PSItem.Id
        'CurrentDate'    = Get-Date
    }
}

Get-Process | Select-Object @{name = 'FirstProperty'  ; expression = {$PSItem.Name }},
                            @{name = 'SecondProperty' ; expression = {$PSItem.StartTime}},
                            @{name = 'ThirdProperty'  ; expression = {$PSItem.Company}},
                            @{name = 'FourthProperty' ; expression = {$PSItem.Id}},
                            @{name = 'CurrentDate'    ; expression = {Get-Date}}