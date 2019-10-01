# erroraction break

#region function
# copy to console
function Invoke-PewPew {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [validateset('Luke','Han')]
        $Character
    )

    $HashChar = @{
        'Luke' = 1
        'Han' = 'todo'
    }

    $id = $HashChar.$Character

    $person = Invoke-RestMethod -Uri http://swapi.co/api/people/$Id
    $films = foreach ($f in $person.films) {
        Invoke-RestMethod -Uri $f
    }

    [PSCustomObject]@{
        Name = $person.name
        Films = $films.Title -join ', '
    }
}
#endregion