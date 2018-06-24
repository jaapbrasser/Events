# Install the module from PSGallery
Install-Module -Name PoshBot -Repository PSGallery -Verbose

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
        Token = 'xoxb-213789208869-Atfl6j2uZsLNXEGUIh2Fh2hf'
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

# Start a PoshBot as interactive session
Start-PoshBot -Path $ConfigPath -Verbose -ErrorVariable ButterError

## Switch to Slack show the bot online
!about
bot status

### Plugins
!get-plugin
!get-plugin builtin

### Discovering commands and help
!help

### 
!giphy shipit
!giphy powershell

!find-plugin
!install-plugin poshbot.xkcd

!help xkcd

!xkcd --random

!find-plugin poshbot*
!install-plugin PoshBot.Networking
## Switch back to VSCode# Install the module from PSGallery
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


## Switch to Slack show the bot online
!about
!status

### Plugins
!get-plugin
!get-plugin builtin

### Discovering commands and help
!help

### Giphy intro
!giphy powershell

# Plugin Discovery
!find-plugin 
!install-plugin poshbot.xkcd

!gp poshbot.xkcd
!help xkcd
!xkcd --random

!find-plugin poshbot*
!install-plugin PoshBot.Networking

!gp poshbot.Networking

### Setup network permissions
!get-permission
!gp builtin

!new-role allownetwork
!add-rolepermission --role allownetwork --permission poshbot.networking:test-network
!new-group networkadmins
!add-grouprole --group networkadmins --role allownetwork
!add-groupuser --group networkadmins --user jaapbrasser

### 
!dig www.expertslive.nl
!ping expertslive.org

## Switch back to VSCode