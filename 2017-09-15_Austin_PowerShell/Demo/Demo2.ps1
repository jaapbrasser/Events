# Get the domain of the system
dir env:

$env:USERDOMAIN

# But we want the domain of the system
[System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties().DomainName

# Combine output with previous command
[pscustomobject]@{
    Hostname     = $env:computername
    SystemDomain = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties().DomainName
}