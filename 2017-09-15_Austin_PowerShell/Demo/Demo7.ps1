# Find pagefile path
Get-PSDrive

dir HKLM:

Get-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\'

# Final code
(Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\' ExistingPageFiles).ExistingPageFiles

((Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\' ExistingPageFiles).ExistingPageFiles).gettype()
'String'.GetType()

-join (Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\' ExistingPageFiles).ExistingPageFiles