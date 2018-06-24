
$WebHookSplat = @{
    Method = 'post'
    ContentType = 'Application/Json'
    Body = '{"text":"Hello Experts Live!"}'
    Uri = 'https://hooks.slack.com/services/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'
}

Invoke-WebRequest @WebHookSplat

$WebHookSplat.Body = @'
{
    "attachments": [
        {
            "color": "00ff00",
            "pretext": "Optional text that appears above the attachment block",
            "title": "Slack attachment example",
            "text": "Optional text that appears within the attachment",
            "fields": [
                {
                    "title": "Priority",
                    "value": "High",
                    "short": false
                }
            ]
        }
    ]
}
'@

Invoke-WebRequest @WebHookSplat

$SysErrors = (Get-WinEvent -FilterHashtable @{
    Logname="System"
    Level=2
    StartTime=(Get-Date).AddMonths(-1)
} | Measure-Object).Count
$SysWarnings = (Get-WinEvent -FilterHashtable @{
    Logname="System"
    Level=3
    StartTime=(Get-Date).AddMonths(-1)
} | Measure-Object).Count
$WebHookSplat.Body = @"
{
    "attachments": [
        {
            "color": "ff0000",
            "title": "Slack attachment example",
            "text": "Optional text that appears within the attachment",
            "fields": [
                {
                    "title": "Security log errors",
                    "value": "$SysErrors",
                    "short": false
                }
            ]
        },
        {
            "color": "ffff00",
            "title": "Slack attachment example",
            "text": "Optional text that appears within the attachment",
            "fields": [
                {
                    "title": "Security log warnings",
                    "value": "$SysWarnings",
                    "short": false
                }
            ]
        },
    ]
}
"@
Invoke-WebRequest @WebHookSplat

$SlackMessage = @{
    Uri = 'https://hooks.slack.com/services/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'
    Text = 'Hello Experts Live! This message is sent using the PSSlack Module'
}
Send-SlackMessage @SlackMessage

Get-Command -Module PSSlack