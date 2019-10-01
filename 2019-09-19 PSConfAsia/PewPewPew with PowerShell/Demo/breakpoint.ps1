param (
    $Name
)

$process = Get-Process -Name $Name
if ($process) {
    Write-Host 'Found process!' -ForegroundColor Green
} else {
    Write-Host 'No process by that name' -ForegroundColor Red
}