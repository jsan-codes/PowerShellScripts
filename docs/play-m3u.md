Script: *play-m3u.ps1*
========================

This PowerShell script plays the given playlist (in .M3U file format)

Parameters
----------
```powershell
PS> ./play-m3u.ps1 [[-filename] <String>] [<CommonParameters>]

-filename <String>
    Specifies the path to the playlist
    
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
PS> ./play-m3u C:\MyPlaylist.m3u

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
	Plays a playlist (.M3U format)
.DESCRIPTION
	This PowerShell script plays the given playlist (in .M3U file format)
.PARAMETER filename
	Specifies the path to the playlist
.EXAMPLE
	PS> ./play-m3u C:\MyPlaylist.m3u
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$filename = "")

try {
	if ($filename -eq "" ) { $filename = read-host "Enter the M3U playlist filename" }

	if (-not(test-path "$filename" -pathType leaf)) { throw "Can't access playlist file: $filename" }
	$Lines = get-content $filename

	add-type -assemblyName presentationCore
	$MediaPlayer = new-object system.windows.media.mediaplayer

	for ([int]$i=0; $i -lt $Lines.Count; $i++) {
		$Line = $Lines[$i]
		if ($Line[0] -eq "#") { continue }
		if (-not(test-path "$Line" -pathType leaf)) { throw "Can't access audio file: $Line" }
		$FullPath = (get-childItem "$Line").fullname
		$filename = (get-item "$FullPath").name
		do {
			$MediaPlayer.open("$FullPath")
			$Milliseconds = $MediaPlayer.NaturalDuration.TimeSpan.TotalMilliseconds
		} until ($Milliseconds)
		[int]$Minutes = $Milliseconds / 60000
		[int]$Seconds = ($Milliseconds / 1000) % 60
		"▶️Playing 🎵$filename ($($Minutes.ToString('00')):$($Seconds.ToString('00'))) ..."
		$MediaPlayer.Volume = 1
		$MediaPlayer.play()
		start-sleep -milliseconds $Milliseconds
		$MediaPlayer.stop()
		$MediaPlayer.close()
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of play-m3u.ps1 as of 01/25/2024 13:36:54)*