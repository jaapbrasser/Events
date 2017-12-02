# Install the module from PSGallery
Install-Module -Name PoshBot -Repository PSGallery -Verbose -Force

# Import the module
Import-Module -Name PoshBot

# View available commands
Get-Command -Module PoshBot
Get-Command -Module PSSlack

### Switch to Slack
<#

Show channel list
Show how to add team members
Show how to get to bot configuration

#>

# Create a bot configuration
$botParams = @{
    Name = 'ButterBot'
    BotAdmins = @('jaapbrasser')
    CommandPrefix = '!'
    LogLevel = 'Info'
    BackendConfiguration = @{
        Name = 'SlackBackend'
        Token = 'xoxb-213789208869-BmO29hDAepDMxauLSqtrf33j'
    }
    AlternateCommandPrefixes = 'bot'
}

# Store configure in a variable
$myBotConfig = New-PoshBotConfiguration @botParams

# Store bot configuration to file
$ConfigPath = 'C:\users\JaapBrasser\.poshbot\PoshBot.psd1'
Save-PoshBotConfiguration -InputObject $myBotConfig -Force -Path C:\users\JaapBrasser\.poshbot\PoshBot.psd1

# View configuration file
Get-Content $ConfigPath
psedit $ConfigPath

# Start a PoshBot as interactive session
Start-PoshBot -Path $ConfigPath -Verbose -ErrorVariable ButterError

## Switch to Slack show the bot online
! help
bot status

bot giphy cat
bot giphy dog
bot giphy oktoberfest

bot find-plugin poshbot*
bot install-plugin poshbot.xkcd

! help xkcd

bot xkcd --random

bot find-plugin poshbot*
bot install-plugin PoshBot.Networking
## Switch back to VSCode

# View some PoshBot configuration files
psedit C:\Users\JaapBrasser\.poshbot\plugins.psd1
psedit C:\Users\JaapBrasser\.poshbot\groups.psd1
psedit C:\Users\JaapBrasser\.poshbot\permissions.psd1