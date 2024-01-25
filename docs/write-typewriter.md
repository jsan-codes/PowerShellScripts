Script: *write-typewriter.ps1*
========================

This PowerShell script writes the given text with the typewriter effect.

Parameters
----------
```powershell
PS> ./write-typewriter.ps1 [[-text] <String>] [[-speed] <Int32>] [<CommonParameters>]

-text <String>
    Specifies the text to write
    
    Required?                    false
    Position?                    1
    Default value                Hello World
    -----------
    * PowerShell is powerful - fully control your computer
    * PowerShell is cross-platform - available for Linux, Mac OS and Windows
    * PowerShell is open-source and free
    * PowerShell is easy to learn
    * PowerShell is fully documented
    
    Thanks for watching
    Markus
    Accept pipeline input?       false
    Accept wildcard characters?  false

-speed <Int32>
    Specifies the speed (250 ms by default)
    
    Required?                    false
    Position?                    2
    Default value                200
    Accept pipeline input?       false
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./write-typewriter "Hello World"

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Writes text á la typewriter
.DESCRIPTION
	This PowerShell script writes the given text with the typewriter effect.
.PARAMETER text
	Specifies the text to write
.PARAMETER speed
	Specifies the speed (250 ms by default)
.EXAMPLE
	PS> ./write-typewriter "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "`nHello World`n-----------`n* PowerShell is powerful - fully control your computer`n* PowerShell is cross-platform - available for Linux, Mac OS and Windows`n* PowerShell is open-source and free`n* PowerShell is easy to learn`n* PowerShell is fully documented`n`nThanks for watching`nMarkus`n", [int]$speed = 200) # in milliseconds

try {
	$Random = New-Object System.Random
	$text -split '' | ForEach-Object {
		Write-Host -noNewline $_
		Start-Sleep -milliseconds $(1 + $Random.Next($speed))
	}
	Write-Host ""
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of write-typewriter.ps1 as of 01/25/2024 13:36:56)*