function Display-Message {
    $null = Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show((cat c:\flow\mytrigger.txt))
}