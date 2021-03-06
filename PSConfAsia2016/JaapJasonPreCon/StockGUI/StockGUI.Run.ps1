﻿#------------------------------------------------------------------------
# Source File Information (DO NOT MODIFY)
# Source ID: 8c85d859-f1d0-4dd9-bf39-822c344cddb5
# Source File: E:\One Drive\OneDrive\MCTExpert\Classes\Class Share\PowerShell Tips\StockGUI\StockGUI.psproj
#------------------------------------------------------------------------
<#
    .NOTES
    --------------------------------------------------------------------------------
     Code generated by:  SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.128
     Generated on:       10/14/2016 3:57 PM
     Generated by:        
     Organization:        
    --------------------------------------------------------------------------------
    .DESCRIPTION
        Script generated by PowerShell Studio 2016
#>


#region Source: Startup.pss
#----------------------------------------------
#region Import Assemblies
#----------------------------------------------
[void][Reflection.Assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][Reflection.Assembly]::Load('System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][Reflection.Assembly]::Load('System.ServiceProcess, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
#endregion Import Assemblies

#Define a Param block to use custom parameters in the project
#Param ($CustomParameter)

function Main {
<#
    .SYNOPSIS
        The Main function starts the project application.
    
    .PARAMETER Commandline
        $Commandline contains the complete argument string passed to the script packager executable.
    
    .NOTES
        Use this function to initialize your script and to call GUI forms.
		
    .NOTES
        To get the console output in the Packager (Forms Engine) use: 
		$ConsoleOutput (Type: System.Collections.ArrayList)
#>
	Param ([String]$Commandline)
		
	#--------------------------------------------------------------------------
	#TODO: Add initialization script here (Load modules and check requirements)
	
	
	#--------------------------------------------------------------------------
	
	if((Call-MainForm_psf) -eq 'OK')
	{
		
	}
	
	$global:ExitCode = 0 #Set the exit code for the Packager
}







#endregion Source: Startup.pss

#region Source: MainForm.psf
function Call-MainForm_psf
{
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.ServiceProcess, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$MainForm = New-Object 'System.Windows.Forms.Form'
	$Name = New-Object 'System.Windows.Forms.Label'
	$Action = New-Object 'System.Windows.Forms.Button'
	$Symbol = New-Object 'System.Windows.Forms.TextBox'
	$Price = New-Object 'System.Windows.Forms.Label'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	$Script:Count = 0
	
	$MainForm_Load={
	#TODO: Initialize Form Controls here
	
	}
	
	
	$Action_Click={
		#TODO: Place custom script here
		$Data = Call-Get-StockInfo_ps1 -Sym $Symbol.Text
		
		$Price.Text = $Data.Ask
		$Name.Text = $Data.Name
		
		$script:Count++
		Write-Output $script:Count
	}#end Action_Click
		# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$MainForm.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:MainForm_Symbol = $Symbol.Text
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$Action.remove_Click($Action_Click)
			$MainForm.remove_Load($MainForm_Load)
			$MainForm.remove_Load($Form_StateCorrection_Load)
			$MainForm.remove_Closing($Form_StoreValues_Closing)
			$MainForm.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch [Exception]
		{ }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$MainForm.SuspendLayout()
	#
	# MainForm
	#
	$MainForm.Controls.Add($Name)
	$MainForm.Controls.Add($Action)
	$MainForm.Controls.Add($Symbol)
	$MainForm.Controls.Add($Price)
	$MainForm.AutoScaleDimensions = '6, 13'
	$MainForm.AutoScaleMode = 'Font'
	$MainForm.ClientSize = '518, 266'
	$MainForm.Name = 'MainForm'
	$MainForm.StartPosition = 'CenterScreen'
	$MainForm.Text = 'Main Form'
	$MainForm.add_Load($MainForm_Load)
	#
	# Name
	#
	$Name.AutoSize = $True
	$Name.Font = 'Microsoft Sans Serif, 20.25pt'
	$Name.Location = '67, 134'
	$Name.Name = 'Name'
	$Name.Size = '86, 31'
	$Name.TabIndex = 3
	$Name.Text = 'label1'
	#
	# Action
	#
	$Action.Font = 'Microsoft Sans Serif, 20.25pt'
	$Action.Location = '221, 18'
	$Action.Name = 'Action'
	$Action.Size = '158, 42'
	$Action.TabIndex = 2
	$Action.Text = 'Get Stock'
	$Action.UseVisualStyleBackColor = $True
	$Action.add_Click($Action_Click)
	#
	# Symbol
	#
	$Symbol.Font = 'Microsoft Sans Serif, 20.25pt'
	$Symbol.Location = '67, 22'
	$Symbol.Name = 'Symbol'
	$Symbol.Size = '100, 38'
	$Symbol.TabIndex = 1
	#
	# Price
	#
	$Price.AutoSize = $True
	$Price.Font = 'Microsoft Sans Serif, 20.25pt'
	$Price.Location = '67, 87'
	$Price.Name = 'Price'
	$Price.Size = '86, 31'
	$Price.TabIndex = 0
	$Price.Text = 'label1'
	$MainForm.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $MainForm.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$MainForm.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$MainForm.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$MainForm.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $MainForm.ShowDialog()

}
#endregion Source: MainForm.psf

#region Source: Globals.ps1
	#--------------------------------------------
	# Declare Global Variables and Functions here
	#--------------------------------------------
	
	
	#Sample function that provides the location of the script
	function Get-ScriptDirectory
	{
	<#
		.SYNOPSIS
			Get-ScriptDirectory returns the proper location of the script.
	
		.OUTPUTS
			System.String
		
		.NOTES
			Returns the correct path within a packaged executable.
	#>
		[OutputType([string])]
		param ()
		if ($hostinvocation -ne $null)
		{
			Split-Path $hostinvocation.MyCommand.path
		}
		else
		{
			Split-Path $script:MyInvocation.MyCommand.Path
		}
	}
	
	#Sample variable that provides the location of the script
	[string]$ScriptDirectory = Get-ScriptDirectory
	
	
	
#endregion Source: Globals.ps1

#region Source: Get-StockInfo.ps1
function Call-Get-StockInfo_ps1
{
	[cmdletbinding()]
		param ($Sym)
		
		$Data = @()
		$Data += "Symbol,Name,Ask,Low,High,Low52,High52,Volume,DayChange,ChangePercent"
		$URL = "http://finance.yahoo.com/d/quotes.csv?s=$Sym&f=snl1ghjkvw4P2"
		$Data += Invoke-RestMethod -Uri $URL
		$Data += "`n"
		$Data = $Data | ConvertFrom-csv
		Write-Output $Data
		
	
	
	
}
#endregion Source: Get-StockInfo.ps1

#Start the application
Main ($CommandLine)
