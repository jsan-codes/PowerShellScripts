﻿<#
.SYNOPSIS
	Lists all scheduled tasks
.DESCRIPTION
	This script lists all scheduled tasks.
.EXAMPLE
	PS> ./list-tasks

	TaskName                            State  TaskPath                                       
	--------                            -----  --------
	.NET Framework NGEN v4.0.30319      Ready  \Microsoft\Windows\.NET Framework\             
	.NET Framework NGEN v4.0.30319 64   Ready  \Microsoft\Windows\.NET Framework\             
	...
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-ScheduledTask | Format-Table -property TaskName,State,TaskPath
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
