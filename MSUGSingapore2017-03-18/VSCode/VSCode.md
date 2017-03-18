# Split view
CTRL \
CTRL SHIFT V

# Zen mode
CTRL K Z

# Compare Files
F1
Compare Active File With

# Update keybindings
CTRL K CTRL S
   { "key": "f8",        "command": "workbench.action.terminal.runSelectedText",
                            "when": "editorTextFocus" }

# Display processes
Get-Process code
'We will all attend PSConfAsia this October!!!'

# Multiline select
# Set Windows Intel graphics hotkeys
CTRL ALT UP
CTRL ALT DOWN

# Exit multiline with Escape
ESCAPE

# Comment selected lines
CTRL K CTRL C

# Select all words in file
CTRL SHIFT L

# Preview markdown
CTRL SHIFT V

# Git Demo

<!--# MSUG Singapore: Writing PowerShell – The right tool for the job
This is the repository that contains all presentation materials that I used during my presentation for the Microsoft User Group based in Singapore on the 18th of March 2017. This includes my PowerPoint slides as well as all code used. If you feel anything is missing feel free to reach out to me directly or raise an issue on GitHub and I will make sure all materials are included.

During the presentation I discussed topics:
* Differences in tools
* Configure VS Code
* Working with VS code
* Working with the ISE and ISESteroids
* Questions-->

Save - Commit - Push

# Enable minimap
Settings:
"editor.minimap.enabled": true

# Extensions
Show top ten extensions

# Customizations VSCode specific JSON
'C:\Program Files (x86)\Microsoft VS Code' | % {
    ls -rec -path $_ -file -filter '*json'
} | Measure-Object

# Customizations User specific JSON
'C:\Users\JaapBrasser\AppData\Roaming\Code\User' | % {
    ls -rec -path $_ -file -filter '*json'
} | Measure-Object

# Themes
F1
Color Theme
CTRL K CTRL T 

# Jump to file
CTRL P 