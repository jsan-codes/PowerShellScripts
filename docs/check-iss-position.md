Script: *check-iss-position.ps1*
========================

This PowerShell script queries the position of the International Space Station (ISS) and replies by text-to-speech (TTS).

Parameters
----------
```powershell
PS> ./check-iss-position.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./check-iss-position

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
	Checks the ISS position
.DESCRIPTION
	This PowerShell script queries the position of the International Space Station (ISS) and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-iss-position
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$ISS = (Invoke-WebRequest "http://api.open-notify.org/iss-now.json" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json

	& "$PSScriptRoot/speak-english.ps1" "The International Space Station is currently at $($ISS.iss_position.longitude)° longitude and $($ISS.iss_position.latitude)° latitude."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of check-iss-position.ps1 as of 01/25/2024 13:36:49)*