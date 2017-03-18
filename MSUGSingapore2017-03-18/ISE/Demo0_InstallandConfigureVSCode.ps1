$DownloadSplat = @{
    Uri     = "https://go.microsoft.com/fwlink/?LinkID=623230"
    OutFile = "$env:temp\vscode.exe"
}
Invoke-WebRequest @DownloadSplat
$env:temp\vscode.exe /verysilent

@'
// Place your key bindings in this file to overwrite the defaults
[
   { "key": "f8",        "command": "workbench.action.terminal.runSelectedText",
                             "when": "editorTextFocus" }
]
'@ | Set-Content -LiteralPath $home\AppData\Roaming\Code\User\keybindings.json -Force


@'
{
    "editor.minimap.enabled": true
}
'@ | Set-Content -LiteralPath $home\AppData\Roaming\Code\User\settings.json -Force