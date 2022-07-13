$GamesLogPath = "C:\UrbanTerror\q3ut4\games.log"


################################################################
Clear-Host
$time = (Get-Date).ToString("yyyy_MM_dd_mm_ss")

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
						#Write-Host $col2
						}
					'Assist' {}
					'Callvote' {}
					'ClientBegin' {}
					'ClientConnect' {}
					'ClientDisconnect' {}
					'ClientSpawn' {}
					'ClientUserinfo' {}
					'ClientUserinfoChanged' {}
					'Exit' {}
					'Flag' {}
					'Flag Return' {}
					'FlagCaptureTime' {}
					'Hotpotato' {}
					'InitAuth' {}
					'InitGame' {
	                    #Game Start
	                    #\sv_allowdownload\0\g_matchmode\0\g_gametype\0\sv_maxclients\30\sv_floodprotect\0\capturelimit\0\sv_hostname\Rynos Server\g_followstrict\0\fraglimit\0\timelimit\0\g_swaproles\0\g_roundtime\2\g_hotpotato\1\g_waverespawns\1\g_redwave\15\g_bluewave\15\g_respawndelay\8\g_suddendeath\1\g_maxrounds\0\g_friendlyfire\1\g_allowvote\0\g_armbands\1\g_funstuff\1\g_instagib\0\g_stratTime\0\g_skins\1\g_stamina\0\g_walljumps\3\g_deadchat\2\g_maxGameClients\0\sv_clientsPerIp\3\sv_maxPing\0\sv_minPing\0\sv_maxRate\0\sv_minRate\0\version\ioQ3 1.35 urt 4.3.4 win-x86 Jun  6 2018\protocol\68\mapname\ut4_abbey\sv_privateClients\0\gamename\q3urt43\g_needpass\0\g_enableDust\0\g_enableBreath\0\g_antilagvis\0\g_survivor\0\g_enablePrecip\0\auth\0\auth_status\init\g_modversion\4.3.4
	                    #Log Game Start to DB
						
						$parameters = $col3.split(" ")
						#Write-Host $parameters
	                }
					'InitRound' {}
					'Item' {}
					'Kill' {
						#1 0 20: BigRyno1 killed Chuckles6576 by UT_MOD_G36
						$killsplit = $col3.split("\")
						Write-Host $killsplit
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
    "Unable to download MyDoc.doc from http://www.contoso.com."
	}
	catch {
	Write-Host "An error occurred: " $col2
	Write-Host $line.IndexOf(":",8)
	Write-Host $line.length
	Write-Host $col2
  	Write-Host $_.ScriptStackTrace
  	}
	
}


