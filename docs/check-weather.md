Script: *check-weather.ps1*
========================

This PowerShell script checks the current weather report.

Parameters
----------
```powershell
PS> ./check-weather.ps1 [[-location] <String>] [<CommonParameters>]

-location <String>
    Specifies the location to use (determined automatically per default)
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./check-weather.ps1

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
	Checks the weather 
.DESCRIPTION
	This PowerShell script checks the current weather report.
.PARAMETER location
	Specifies the location to use (determined automatically per default)
.EXAMPLE
	PS> ./check-weather.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$location = "") # empty means determine automatically

try {
	$Weather = (Invoke-WebRequest http://wttr.in/${location}?format=j1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json

	$Temp = $Weather.current_condition.temp_C
	$Precip = $Weather.current_condition.precipMM
	$Humidity = $Weather.current_condition.humidity
	$Pressure = $Weather.current_condition.pressure
	$WindSpeed = $Weather.current_condition.windspeedKmph
	$WindDir = $Weather.current_condition.winddir16Point
	$UV = $Weather.current_condition.uvIndex
	$Visib = $Weather.current_condition.visibility
	$Clouds = $Weather.current_condition.cloudcover
	$Desc = $Weather.current_condition.weatherDesc.value
	$Area = $Weather.nearest_area.areaName.value
	$Region = $Weather.nearest_area.region.value

	& "$PSScriptRoot/speak-english.ps1" "$($Temp)°C, $($Precip)mm rain, $($Humidity)% humidity, $($WindSpeed)km/h wind from $WindDir with $($Clouds)% clouds and $($Visib)km visibility at $Area ($Region)."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of check-weather.ps1 as of 01/25/2024 13:36:50)*