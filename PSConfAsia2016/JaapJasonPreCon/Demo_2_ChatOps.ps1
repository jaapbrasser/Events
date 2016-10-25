# Show the configuration options for Slack
start chrome https://jaapbrasser.slack.com/services/B2REE3LKC

# Simple Slack message
$Payload = @"
payload={
    "username": "LoggingBot",
    "icon_emoji": ":grinning:",
    "channel": "#psconfasia",
    "text": "Here is a simple message to a slack channel"
}
"@

$WebHookSplat = @{
    Method = 'Post'
    Uri    = 'https://hooks.slack.com/services/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'
    Body   = $Payload
}

# Post Message to Slack
Invoke-RestMethod @WebHookSplat

# JSON Payload
$Payload = @"
payload={
	"username": "LoggingBot",
    "icon_emoji": ":ipsofticon:",
    "channel": "#psconfasia",
	"attachments": [
        {
            "fallback": "Bad client",
            "author_name": "Jaap Brasser",
            "author_icon": "http://www.ipsoft.com/wp-content/themes/ipsoft_v2/favicons/favicon-32x32.png",
            "title": "This is the title",
            "title_link": "http://www.jaapbrasser.com",
            "text": "Here is some text, I could write anything here so I wrote this",
			"ts": $([int]((Get-Date)-(Get-Date -Year 1970 -Day 1 -Month 1).Date).TotalSeconds-7200),
            "actions": [
                {
                    "name": "accept",
                    "text": "Accept",
                    "type": "button",
                    "value": "Accept"
                },
                {
                    "name": "decline",
                    "text": "Decline",
                    "type": "button",
                    "value": "decline"
                }
            ]
        }
    ]
}
"@

# Prepare the splat for Invoke-RestMethod
$WebHookSplat = @{
    Method = 'Post'
    Uri    = 'https://hooks.slack.com/services/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'
    Body   = $Payload
}

# Post Message to Slack
Invoke-RestMethod @WebHookSplat

# Use Modules to post messages to Slack
Find-Module -Name PSSlack
Get-Module  -Name PSSlack -ListAvailable

# Get a token
start chrome 'https://api.slack.com/docs/oauth-test-tokens'

$Encrypted = [pscredential]::new('test',(ConvertTo-SecureString '01000000d08c9ddf0115d1118c7a00c04fc297eb01000000872e8c25996113458b461cb5e6555c3100000000020000000000106600000001000020000000630f354c8c73141da95834ffac26a401141479ee7735dc6f5512036b5872b573000000000e80000000020000200000005472767a2499d2f10ad56a1e4032b1988ab013c2e37590356e47317c36e21770900000009383880dbf9b32e562368ef0fee77ac6a263e5f64be99324ce8694fb3070beead17a19744ee6a1be0673b22509ed288ef1c281ef57deb538ef71e1ab5f85ef88166150239dd74f155a59d7ce8dfbbb47fadedd8278ff76f0f8836cce310ef15c3ef63c3e8f6ba66a5cfcec29ebafd6246a3de85af7a1daa27eab820558ba07068811899fd406bbb2f30cf0731d161181400000005b750c7c52ca1fd8aad57e056bac0b131a027c4417900bb1b71c58df1804882339ff163157f87eb14ade006a0bc7e3a777a7d15dc0d328d5174f9d29fbf4706e'))
$Token     = $Encrypted.GetNetworkCredential().Password

$Splatting = @{
    Color      = $([System.Drawing.Color]::red) 
    Title      = 'The System Is Down' 
    TitleLink  = 'https://www.youtube.com/watch?v=TmpRs7xN06Q'
    Text       = 'Please Do The Needful' 
    Pretext    = 'Everything is broken' 
    AuthorName = 'SCOM Bot' 
    AuthorIcon = 'http://ramblingcookiemonster.github.io/images/tools/wrench.png' 
    Fallback   = 'Your client is bad' 
}

New-SlackMessageAttachment @Splatting |
New-SlackMessage -Channel 'psconfasia' -IconEmoji :bomb: |
Send-SlackMessage -Token $Token