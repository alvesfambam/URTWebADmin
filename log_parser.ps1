$GamesLogPath = "C:\UrbanTerror\q3ut4\games.log"


################################################################
Clear-Host
$SQLServer = "localhost" #use Server\Instance for named SQL instances!
$SQLDBName = "q3ut4"
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName;User ID=q3ut4; Password=q3ut4"

$time = (Get-Date).ToString("yyyy_MM_dd_mm_ss")
$Game_Number = 0

#foreach($line in [System.IO.File]::ReadLines($GamesLogPath)) {
foreach($line in Get-Content $GamesLogPath) {
    try{
		if ($line.IndexOf("-------------", 0) -ne -1 ) {
			#Ignore
		}
		elseif($line.IndexOf("Session data initialised for client ", 0) -ne -1 ) {
			#Ignore
		}
		else {
			$col1 = $line.substring(0, 6)
			$col2 = $line.substring(7, $line.IndexOf(":", 7) - 7)
			#Write-Host $line.IndexOf(":",8)
			#Write-Host $line.length
			#Write-Host $col2
			IF($line.IndexOf(":",8)+1 -ne $line.length){
				$col3 = $line.substring($line.IndexOf(":",8)+2)
				}
				
				
			switch ($col2)
				{						
					'AccountValidated' {
						#AccountValidated: 0 - bigryno1 - -1 - ""
						$AccountValidated_flds = $col3.split(" ")
						#Write-Host $AccountValidated_flds{0}
						#Write-Host $col3
						#Write-Host $AccountValidated_flds[0]":"$AccountValidated_flds[1]":"$AccountValidated_flds[2]":"$AccountValidated_flds[3]":"$AccountValidated_flds[4]":"$AccountValidated_flds[5]
						}
					'Assist' {
						# 			   0 1 2  3        4        5        6  7    8 
						# 2:35 Assist: 0 2 1: JonSmith assisted BigRyno1 to kill GayMan
						$Assist_flds = $col3.split(" ")
						#Write-Host $Assist_flds[0]":"$Assist_flds[1]":"$Assist_flds[2]":"$Assist_flds[3] `
						#			$Assist_flds[4]":"$Assist_flds[5]":"$Assist_flds[6]":"$Assist_flds[7]":"$Assist_flds[8]
						Write-Host 	"`t Game:$Game_Number "$Assist_flds[3] " Assisted " $Assist_flds[5] " to kill " $Assist_flds[8]		
						}
					'Callvote' {
						#Callvote: 0 - "g_nextmap ut4_eagle"
						}
					'ClientBegin' {
						#ClientSpawn: 0
						}
					'ClientConnect' {
						#ClientConnect: 1
						}
					'ClientDisconnect' {}
					'ClientSpawn' {}
					'ClientUserinfo' {
						$ClientUserinfo_parameters = $col3.split(" ")
						#Write-Host $ClientUserinfo_parameters
						}
					'ClientUserinfoChanged' {}
					'Exit' {}
					'Flag' {}
					'Flag Return' {}
					'FlagCaptureTime' {}
					'Hotpotato' {}
					'InitAuth' {}
					'InitGame' {
	                    #Game Start
						$Game_Number += 1 
	                    #\sv_allowdownload\0\g_matchmode\0\g_gametype\0\sv_maxclients\30\sv_floodprotect\0\capturelimit\0\sv_hostname\Rynos Server\g_followstrict\0\fraglimit\0\timelimit\0\g_swaproles\0\g_roundtime\2\g_hotpotato\1\g_waverespawns\1\g_redwave\15\g_bluewave\15\g_respawndelay\8\g_suddendeath\1\g_maxrounds\0\g_friendlyfire\1\g_allowvote\0\g_armbands\1\g_funstuff\1\g_instagib\0\g_stratTime\0\g_skins\1\g_stamina\0\g_walljumps\3\g_deadchat\2\g_maxGameClients\0\sv_clientsPerIp\3\sv_maxPing\0\sv_minPing\0\sv_maxRate\0\sv_minRate\0\version\ioQ3 1.35 urt 4.3.4 win-x86 Jun  6 2018\protocol\68\mapname\ut4_abbey\sv_privateClients\0\gamename\q3urt43\g_needpass\0\g_enableDust\0\g_enableBreath\0\g_antilagvis\0\g_survivor\0\g_enablePrecip\0\auth\0\auth_status\init\g_modversion\4.3.4
	                    #Log Game Start to DB
						Write-Host " Game Number: " $Game_Number
						#$parameters = $col3.split(" ")
						#Write-Host $parameters
	                }
					'InitRound' {}
					'Item' {}
					'Kill' {
						#1 0 20: BigRyno1 killed Chuckles6576 by UT_MOD_G36
						$col3 = $col3.replace(":","")
						$killsplit = $col3.split(" ")
						#Write-Host $killsplit
						}
					'Radio' {}
					'red' {}
					'say' {}
					'sayteam' {}
					'score' {}
					'ShutdownGame' {}
					'Vote' {}
					'VotePassed' {}
					'Warmup' {}
				}
		}
	}
	catch [System.Net.WebException],[System.IO.IOException] {
    "error"
	}
	catch {
	Write-Host "An error occurred: " $col2
	Write-Host $line.IndexOf(":",8)
	Write-Host $line.length
	Write-Host $col2
  	Write-Host $_.ScriptStackTrace
  	}
	
}


Add-Content $GamesLogPath "`n  0:00 Q3UT4: ADMIN LAST SCAN"

