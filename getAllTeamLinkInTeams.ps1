#Team link template
$teamLinkTemplate = "https://teams.microsoft.com/l/team/<ThreadId>/conversations?groupId=<GroupId>&tenantId=<TenantId>"
	
#Connect to Microsoft Teams	
$connectTeams = Connect-MicrosoftTeams

#Retrieve the team
$tiims = Get-Team

$exportText = @()

foreach($tiim in $tiims)
{
	#Retrieve team channel General
	$channel = Get-TeamChannel -GroupId $tiim.GroupId | Where-Object {$_.DisplayName -eq "General"} | Select-Object -First 1
	
	#Construct the team link
	$teamLink = $teamLinkTemplate.Replace("<ThreadId>",$channel.Id).Replace("<GroupId>",$tiim.GroupId).Replace("<TenantId>",$connectTeams.TenantId)

	Write-Host $tiim.DisplayName  -ForegroundColor Yellow
	Write-Host $teamLink  -ForegroundColor Green
	
	#Construct the csv	
	$exportText += $tiim.DisplayName + "," + $teamLink
} 
$exportText | Out-File -FilePath C:\temp\exportTeamsData.csv -Encoding utf8


