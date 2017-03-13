robocopy $args
function A {
    Get-Random -Minimum 0 -Maximum 16
}
"This copy operation is proudly brought to you by Jaap".ToCharArray().ForEach{
    Write-Host -ForegroundColor $(a) -NoNewline -Object $_
}