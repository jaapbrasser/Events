[cmdletbinding()]
	param ($Sym)
	
	$Data = @()
	$Data += "Symbol,Name,Ask,Low,High,Low52,High52,Volume,DayChange,ChangePercent"
	$URL = "http://finance.yahoo.com/d/quotes.csv?s=$Sym&f=snl1ghjkvw4P2"
	$Data += Invoke-RestMethod -Uri $URL
	$Data += "`n"
	$Data = $Data | ConvertFrom-csv
	Write-Output $Data
	


