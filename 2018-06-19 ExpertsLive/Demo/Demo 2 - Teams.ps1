# Show setting up the webhook connector

# First message
$WebHookSplat = @{
    Method = 'post'
    ContentType = 'Application/Json'
    Body = '{"text":"Hello Experts Live!"}'
    Uri = 'https://outlook.office.com/webhook/a6f68889-3971-4771-a7e8-f51fbb186580@bb29a6d6-986c-4338-a50e-717e6b1c4a15/IncomingWebhook/73887b572b1b41f5a707dcbd1b3e780f/3b479b36-19a3-4159-af22-973aa1df77d9'
}
Invoke-WebRequest @WebHookSplat

$WebHookSplat.Body = @'
{
    "@type": "MessageCard",
    "@context": "http://schema.org/extensions",
    "summary": "Using Chat Automation",
    "title": "ExpertsLive",
    "sections": [
        {
            "activityTitle": "Jaap is presenting",
            "activitySubtitle": "On Chat Automation",
            "activityText": "\"Incoming webhook\"",
            "activityImage": "https://upload.wikimedia.org/wikipedia/commons/2/2f/PowerShell_5.0_icon.png"
        }
    ]
}
'@
Invoke-WebRequest @WebHookSplat

$WebHookSplat.Body = @'
{
    "@type": "MessageCard",
    "@context": "http://schema.org/extensions",
    "summary": "Using Chat Automation",
    "title": "ExpertsLive",
    "sections": [
        {
            "activityTitle": "Jaap is presenting",
            "activitySubtitle": "On Chat Automation",
            "activityText": "\"Incoming webhook\"",
            "activityImage": "https://upload.wikimedia.org/wikipedia/commons/2/2f/PowerShell_5.0_icon.png"
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
    "@type": "MessageCard",
    "@context": "http://schema.org/extensions",
    "summary": "Using Chat Automation",
    "title": "ExpertsLive",
    "sections": [
        {
            "activityTitle": "System Log Errors",
            "activitySubtitle": "Number of errors:",
            "activityText": "$($SysErrors)",
            "activityImage": "https://upload.wikimedia.org/wikipedia/commons/2/2f/PowerShell_5.0_icon.png"
        },
        {
            "activityTitle": "System Log Warnings",
            "activitySubtitle": "Number of warnings:",
            "activityText": "$($SysWarnings)",
            "activityImage": "https://upload.wikimedia.org/wikipedia/commons/2/2f/PowerShell_5.0_icon.png"
        }
    ]
}
"@
Invoke-WebRequest @WebHookSplat

# Microsoft <3 Linux

curl -H "Content-Type: application/json" -d "{\"text\": \"Hello Experts Live! Microsoft <3 Linux\"}" https://outlook.office.com/webhook/a6f68889-3971-4771-a7e8-f51fbb186580@bb29a6d6-986c-4338-a50e-717e6b1c4a15/IncomingWebhook/73887b572b1b41f5a707dcbd1b3e780f/3b479b36-19a3-4159-af22-973aa1df77d9
