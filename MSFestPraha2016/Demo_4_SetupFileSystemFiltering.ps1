New-FsrmFileGroup -Name CustomCryptoLockerFilter -IncludePattern @('*.crypto')
New-FsrmFileScreen -Path "C:\home" -Template "CryptoPolicy"