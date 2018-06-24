# Is the server online?
!ping localhost

# Return disk information
!get-diskspace

# Return event log errors
!get-systemerrorevents
!get-systemerrorevents 1

# Get-Service
!get-webservice

# Restart iis
!restart-webservice

# Restart System
!invoke-codeexecution "[math]::power(2,10)"