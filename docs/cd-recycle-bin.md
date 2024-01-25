Script: *cd-recycle-bin.ps1*
========================

cd-recycle-bin.ps1 


Parameters
----------
```powershell


[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Sets the working directory to the user's recycle bin folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's recycle bin folder.
.EXAMPLE
	PS> ./cd-recycle-bin
	📂C:\$Recycle.Bin\S-1-5-21-123404-23309-294260-1001
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetCurrentUserSID { [CmdletBinding()] param()
	Add-Type -AssemblyName System.DirectoryServices.AccountManagement
	return ([System.DirectoryServices.AccountManagement.UserPrincipal]::Current).SID.Value
}


try {
	if ($IsLinux) {
		$Path = "$HOME/.local/share/Trash/"
	} else {
		$Path = "C:\$Recycle.Bin\" + "$(GetCurrentUserSID)"
	}
	if (-not(Test-Path "$Path" -pathType container)) { throw "Recycle bin folder at 📂$Path doesn't exist (yet)" }
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of cd-recycle-bin.ps1 as of 01/25/2024 13:36:49)*