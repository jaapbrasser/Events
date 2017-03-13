# Split view
CTRL \
CTRL W

# Compare Files
#>F1
Compare Active File With

# Change Language
CTRL K M

# Update keybindings
CTRL K CTRL S
   { "key": "f8",        "command": "workbench.action.terminal.runSelectedText",
                            "when": "editorTextFocus" }

# Multiline select
# Set Windows Intel graphics hotkeys
CTRL ALT UP
CTRL ALT DOWN

# Select all words in file
CTRL SHIFT L

# Display processes
Get-Process code
'dupsug!!!'

# Git Demo

# 10TH DUPSUG MEETING
This is the repository that contains all presentation materials as it has been made available by the presenters. The schedule of this user group meeting was as follows:

BEGIN | END | SPEAKER | TITLE
------|-----|---------|------
09:00 | 10:00 | Jakub Jareš | Continuous deployment pipeline for PowerShell modules
10:00 | 11:00 | André Kamman | Fighting SQL Server Configuration Drift with Dynamic Pester Tests
13:00 | 14:00 | Jakub Jareš | Biggest mistakes when testing with Pester
14:00 | 16:00 | Ralph Eckhard & Sven van Rijen | Keep up with NOW! Automate (re-)building your homelab – on steroids!
16:00 | 17:00 | Jaap Brasser | The best tool for the job: Working with VScode and ISE

Save - Commit - Push

# Enable minimap
Settings:
"editor.minimap.enabled": true

# Extensions
Install docker highlighting

# Customizations
'C:\Program Files (x86)\Microsoft VS Code\' | % {
    ls -rec -path $_ -file -filter '*json' |
    Select-String 'minimap'
}

# Themes
F1
Color Theme

# Comment selected lines
CTRL K C

# Jump to file
CTRL P 