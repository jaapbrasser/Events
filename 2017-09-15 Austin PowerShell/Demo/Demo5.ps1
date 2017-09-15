# Get timezone information and current offset
Get-TimeZone

(Get-TimeZone).DisplayName
Get-TimeZone | Select-Object -ExpandProperty DisplayName

[datetime]::UtcNow

[datetime]::Now - [datetime]::UtcNow

# Combine output of both commands into a string
"{0} (Current offset: {1} hours)" -f (Get-TimeZone).DisplayName,
                                     ((Get-Date)-(Get-Date).ToUniversalTime()).TotalHours