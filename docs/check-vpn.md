Script: *check-vpn.ps1*
========================

This PowerShell script queries the status of the VPN connection(s) and prints it.

Parameters
----------
```powershell
PS> ./check-vpn.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./check-vpn.ps1
✅ VPN to NASA L2TP is connected

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
	Checks the VPN status
.DESCRIPTION
	This PowerShell script queries the status of the VPN connection(s) and prints it.
.EXAMPLE
	PS> ./check-vpn.ps1
	✅ VPN to NASA L2TP is connected
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$noVPN = $true
	if ($IsLinux) {
		# TODO
	} else {
		$Connections = Get-VPNConnection
		foreach($Connection in $Connections) {
			Write-Host "✅ VPN to $($Connection.Name) is $($Connection.ConnectionStatus.ToLower())"
			$noVPN = $false
		}
	}
	if ($noVPN) { Write-Host "⚠️ No VPN configured" }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of check-vpn.ps1 as of 01/25/2024 13:36:50)*