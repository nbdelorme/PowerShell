
function Get-ExternalIpAddress 
{
	$html = (Invoke-WebRequest 'http://checkip.dyndns.com/' -TimeoutSec 10).Content
	
	$IPv4Regex = '\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b'
	return ([regex]::Matches($html, $IPv4Regex)).Value
}