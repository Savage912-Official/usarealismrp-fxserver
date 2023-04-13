
local currentPaintBallSession = {}

RegisterServerEvent('PaintBall:NewCTFSession')
AddEventHandler('PaintBall:NewCTFSession', function(data,player)
	-- local player = source
	local ctf = false
	
	print("---CTF creatorname : "..tostring(data.creatorname))
	for k,v in pairs(data) do
		print(tostring(k).." : "..tostring(v))
	end
	print("---")
	
	currentPaintBallSession[player] = {}
	currentPaintBallSession[player].creator = data.creatorname
	currentPaintBallSession[player].sessionname = data.sessionname
	currentPaintBallSession[player].CurStat = "WaitingPeople"
	currentPaintBallSession[player].manche = 1
	currentPaintBallSession[player].nbmanche = data.nbmanche
	-- currentPaintBallSession[player].nbimpact = data.nbimpact
	currentPaintBallSession[player].nbpersequip = data.nbpersequip
	currentPaintBallSession[player].EquipA = {}
	currentPaintBallSession[player].EquipB = {}
	currentPaintBallSession[player].dateCreate = os.time()
	currentPaintBallSession[player].ScoreA = {}
	currentPaintBallSession[player].ScoreB = {}
	currentPaintBallSession[player].modes = data.gamemode
	currentPaintBallSession[player].maps = data.maps
	currentPaintBallSession[player].shop = data.curshop
	currentPaintBallSession[player].idx = player
	
	currentPaintBallSession[player].bballs = 0
	currentPaintBallSession[player].rballs = 0
	currentPaintBallSession[player].bbase = 0
	currentPaintBallSession[player].rbase = 0
end)


RegisterServerEvent('PaintBall:StartTheGame')
AddEventHandler('PaintBall:StartTheGame', function(idx)
	local player = source
	if currentPaintBallSession then
		if currentPaintBallSession[idx] then
			currentPaintBallSession[idx].CurStat = "GameStarting"
		end
	end
	-- sendToPlayerTheStart(idx)
end)

RegisterServerEvent('PaintBall:JoinBlue')
AddEventHandler('PaintBall:JoinBlue', function(idx)
	local player = source
	print("player : "..tostring(player).." ask to join: "..tostring(idx))
	if currentPaintBallSession then
		if currentPaintBallSession[idx] then
			local nbPlayer = currentPaintBallSession[idx].EquipA
			local alreadyIn = false
			for k,v in pairs(currentPaintBallSession[idx].EquipA) do
				if v == player then
					alreadyIn = true
				end
			end
			
			
			for k,v in pairs(currentPaintBallSession[idx].EquipB) do
				print("k : "..tostring(k).." v : "..tostring(v))
				if v == player then
					table.remove(currentPaintBallSession[idx].EquipB,k)
					print("remove player from another team")
				end
			end
			
			
			if not alreadyIn then
				if #nbPlayer == nil then
					currentPaintBallSession[idx].EquipA[1] = player
				else
					if #nbPlayer < tonumber(currentPaintBallSession[idx].nbpersequip) then
						currentPaintBallSession[idx].EquipA[#nbPlayer+1] = player
						TriggerClientEvent("PaintBall:Notif",player,"You've joined blue team","info")
					else
						TriggerClientEvent("PaintBall:Notif",player,"Team is full","error")
					end
				end
			else
				TriggerClientEvent("PaintBall:Notif",player,"You're already in this team","error")
			end
		end
	end
end)

RegisterServerEvent('PaintBall:JoinRed')
AddEventHandler('PaintBall:JoinRed', function(idx)
	local player = source
	print("player : "..tostring(player).." ask to join: "..tostring(idx))
	if currentPaintBallSession then
		if currentPaintBallSession[idx] then
			local nbPlayer = currentPaintBallSession[idx].EquipB
			local alreadyIn = false
			for k,v in pairs(currentPaintBallSession[idx].EquipB) do
				print("k : "..tostring(k).." v : "..tostring(v))
				if v == player then
					alreadyIn = true
				end
			end
			
			for k,v in pairs(currentPaintBallSession[idx].EquipA) do
				print("k : "..tostring(k).." v : "..tostring(v))
				if v == player then
				table.remove(currentPaintBallSession[idx].EquipA,k)
				print("remove player from another team")
				end
			end
			
			if not alreadyIn then
				if #nbPlayer == nil then
					currentPaintBallSession[idx].EquipB[1] = player
				else
					if #nbPlayer < tonumber(currentPaintBallSession[idx].nbpersequip) then
						currentPaintBallSession[idx].EquipB[#nbPlayer+1] = player
						TriggerClientEvent("PaintBall:Notif",player,"You've joined red team","info")
					else
						TriggerClientEvent("PaintBall:Notif",player,"Team is full","error")
					end
				end
			else
				TriggerClientEvent("PaintBall:Notif",player,"You're already in this team","error")
			end
		end
	end
end)

-- print(trad["EN"]["CreateLob"])
RegisterServerEvent('PaintBallCTF:EmissiveSync')
AddEventHandler('PaintBallCTF:EmissiveSync', function()
	local player = source
	Citizen.CreateThread(function()
		local curplayer = player
		local blink = 1.0
		for i=0,41 do
			if blink == 1.0 then 
				blink = 0.0 
			else
				blink = 1.0 
			end
			TriggerClientEvent("PaintBallCTF:SendEmissive",curplayer,blink)
			TriggerClientEvent("PaintBallCTF:SendEmissiveSync",-1,curplayer,blink)
			Wait(333)
		end
	end)
end)

function sendToPlayerTheStart(idx)
	Citizen.CreateThread(function()
		local allPlayer = {}
		local cptPlayer = 0
		local currentManche = currentPaintBallSession[idx].manche
		
		
		local bx = Maps[currentPaintBallSession[idx].maps].blueFlagCoords.x
		local by = Maps[currentPaintBallSession[idx].maps].blueFlagCoords.y
		local bz = Maps[currentPaintBallSession[idx].maps].blueFlagCoords.z
		
		local rx = Maps[currentPaintBallSession[idx].maps].redFlagCoords.x
		local ry = Maps[currentPaintBallSession[idx].maps].redFlagCoords.y
		local rz = Maps[currentPaintBallSession[idx].maps].redFlagCoords.z
		
		local blueBalls = CreateObject("plasma_ball2",bx,by,bz,true,true,false) --blue
		local redBalls = CreateObject("plasma_ball",rx,ry,rz,true,true,false)
		local blueBase = CreateObject("patoche_plasmamap_socle1",bx,by,bz-1.5,true,true,false) --blue
		local redBase = CreateObject("patoche_plasmamap_socle2",rx,ry,rz-1.5,true,true,false)
		Wait(450)
		currentPaintBallSession[idx].bballs = NetworkGetNetworkIdFromEntity(blueBalls)
		currentPaintBallSession[idx].rballs = NetworkGetNetworkIdFromEntity(redBalls)
		currentPaintBallSession[idx].bbase = NetworkGetNetworkIdFromEntity(blueBase)
		currentPaintBallSession[idx].rbase = NetworkGetNetworkIdFromEntity(redBase)
		Wait(150)
		FreezeEntityPosition(blueBalls,true)
		FreezeEntityPosition(redBalls,true)
		FreezeEntityPosition(blueBase,true)
		FreezeEntityPosition(redBase,true)
		print("blueBalls : "..tostring(blueBalls).." exist:"..tostring(DoesEntityExist(blueBalls)).." coords : "..tostring(bx).." "..tostring(by).." "..tostring(bz))
		print("redBalls : "..tostring(redBalls).." exist:"..tostring(DoesEntityExist(redBalls)).." coords : "..tostring(rx).." "..tostring(ry).." "..tostring(rz))
		
		
		
		for k,v in pairs(currentPaintBallSession[idx].EquipA) do
			TriggerClientEvent("PaintBallCTF:GoForStartTheGame",v,"blue",idx,currentManche,currentPaintBallSession[idx])
			TriggerClientEvent("PaintBallCTF:SendtheBalls",v,NetworkGetNetworkIdFromEntity(blueBalls),NetworkGetNetworkIdFromEntity(redBalls),currentPaintBallSession[idx])
			print("Set bucket : "..tostring(v).." to: "..tostring(idx).." type of idx : "..type(idx))
			SetPlayerRoutingBucket(v,tonumber(idx))
			TriggerEvent("ammo:clearSelectedIndexes", v)
		end
		
		for k,v in pairs(currentPaintBallSession[idx].EquipB) do
			TriggerClientEvent("PaintBallCTF:GoForStartTheGame",v,"red",idx,currentManche,currentPaintBallSession[idx])
			TriggerClientEvent("PaintBallCTF:SendtheBalls",v,NetworkGetNetworkIdFromEntity(blueBalls),NetworkGetNetworkIdFromEntity(redBalls),currentPaintBallSession[idx])
			print("Set bucket : "..tostring(v).." to: "..tostring(idx).." type of idx : "..type(idx))
			SetPlayerRoutingBucket(v,tonumber(idx))
			TriggerEvent("ammo:clearSelectedIndexes", v)
		end
		
		SetEntityRoutingBucket(blueBalls,tonumber(idx))
		SetEntityRoutingBucket(redBalls,tonumber(idx))
		SetEntityRoutingBucket(blueBase,tonumber(idx))
		SetEntityRoutingBucket(redBase,tonumber(idx))

		print("balls created and bucket")
		-- cptManche = tonumber(currentPaintBallSession[idx].nbmanche)
		
		-- while cptManche > 0 do
			-- print("init score of manche : "..tostring(cptManche))
			-- currentPaintBallSession[idx].ScoreA[cptManche] = 0
			-- currentPaintBallSession[idx].ScoreB[cptManche] = 0
			
			-- cptManche = cptManche - 1
		-- end
		
		SetTimeout(10000, function() -- change to +1000, if necessary.
			if currentPaintBallSession[idx] then
				for k,v in pairs(currentPaintBallSession[idx].EquipA) do
					TriggerClientEvent("PaintBall:GoForUnFreeze",v,"blue")
				end
			
				for k,v in pairs(currentPaintBallSession[idx].EquipB) do
					TriggerClientEvent("PaintBall:GoForUnFreeze",v,"red")
				end
			end
		end)
	end)
	
	
	
	
end

function FinManche(idx)
	Citizen.CreateThread(function()
		local TotScoreA = 0
		local TotScoreB = 0
		
		for k,v in pairs(currentPaintBallSession[idx].ScoreA) do
			print("Score A : "..tostring(v))
			TotScoreA = TotScoreA + v
		end
		
		for k,v in pairs(currentPaintBallSession[idx].ScoreB) do
			print("Score B : "..tostring(v))
			TotScoreB = TotScoreB + v
		end
		
		if TotScoreA > TotScoreB then
			winner = "blue"
		elseif TotScoreA < TotScoreB then
			winner = "red"
		elseif TotScoreA == TotScoreB then
			winner = "tie"
		end
		
		
		for k,v in pairs(currentPaintBallSession[idx].EquipA) do
			TriggerClientEvent("PaintBallCTF:GoToFinMatchMSG",v,winner,currentPaintBallSession[idx])
			SetPlayerRoutingBucket(v,0)
		end
		
		for k,v in pairs(currentPaintBallSession[idx].EquipB) do
			TriggerClientEvent("PaintBallCTF:GoToFinMatchMSG",v,winner,currentPaintBallSession[idx])
			SetPlayerRoutingBucket(v,0)
		end
		
		print("Delete orbs : blue "..tostring(DoesEntityExist(currentPaintBallSession[idx].bballs)).." red "..tostring(DoesEntityExist(currentPaintBallSession[idx].rballs)))
		-- if DoesEntityExist()
		DeleteEntity(NetworkGetEntityFromNetworkId(currentPaintBallSession[idx].bballs))
		DeleteEntity(NetworkGetEntityFromNetworkId(currentPaintBallSession[idx].rballs))
		DeleteEntity(NetworkGetEntityFromNetworkId(currentPaintBallSession[idx].bbase))
		DeleteEntity(NetworkGetEntityFromNetworkId(currentPaintBallSession[idx].rbase))
		
		Wait(200)
		print("Delete orbs : blue "..tostring(DoesEntityExist(currentPaintBallSession[idx].bballs)).." red "..tostring(DoesEntityExist(currentPaintBallSession[idx].rballs)))
		currentPaintBallSession[idx] = nil
		TriggerEvent("PaintBall:FinManche",idx)
	end)
end

local timeOutDeleteGame = 3 * 60 -- 5 * 1 minute

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		local curTime = os.time()
		
		for k,v in pairs(currentPaintBallSession) do
			
			if v.modes == "CTF" then
				-- print("CTF LOOP: "..tostring(k))
				if (curTime - v.dateCreate) > timeOutDeleteGame and (v.CurStat == "WaitingPeople") then
					print("Must delete Game")
					currentPaintBallSession[k] = nil
				end
				
				local nbPlayerA = #v.EquipA
				local nbPlayerB = #v.EquipB
				local nbPlayerMax = tonumber(v.nbpersequip)
				
				if nbPlayerA == nbPlayerMax and nbPlayerB == nbPlayerMax and (v.CurStat == "WaitingPeople") then
					currentPaintBallSession[k].CurStat = "GameStarting"
					print("send the start")
					sendToPlayerTheStart(k)
					
				end
				
				
				
				if v.CurStat == "GameStarting" then
					local nbPlayerA = #v.EquipA
					local nbPlayerB = #v.EquipB
					local nbPlayerMax = tonumber(v.nbpersequip)
				    -- print("GameStarting player A:"..tostring(nbPlayerA).." player B:"..tostring(nbPlayerB))
					if nbPlayerA == 0 or nbPlayerB == 0 then
						currentPaintBallSession[k].CurStat = "GameEnding"
						FinManche(k)
					end
				
					if v.manche < tonumber(v.nbmanche) then
						
						
						for k2,v2 in pairs(v.EquipA) do
							if GetPlayerRoutingBucket(v2) ~= k then
								print("^1Player "..tostring(v2).." is not in good bucket^7")
								SetPlayerRoutingBucket(v2,k)
							end
							if GetPlayerPing(v2) == 0 then
								print("GetPlayerPing("..tostring(v2)..") : "..tostring(GetPlayerPing(v2)))
								
								if playerDecoTab[v2] == nil then
									playerDecoTab[v2] = true
									Citizen.CreateThread(function()
										
										local currentDecoSession = k
										local currentDecoPlayer = v2
										print("CreateThread for deco : "..tostring(currentDecoPlayer))
										local cptTimeoutDeco = 0
										local mustRemove = true
										while cptTimeoutDeco < 100 do
											cptTimeoutDeco = cptTimeoutDeco + 1
											if GetPlayerPing(v2) ~= 0 then
												mustRemove = false
											end
											Wait(1)
										end
										if mustRemove then
											print("mustRemove for deco : "..tostring(currentDecoPlayer))
											for k12,v12 in pairs(currentPaintBallSession[currentDecoSession].EquipA) do
												print("k12: "..tostring(k12).." v12: "..tostring(v12))
												if v12 == currentDecoPlayer then
													table.remove(currentPaintBallSession[currentDecoSession].EquipA,k12)
													print("founded and deleted")
												end
											end
											currentPaintBallSession[currentDecoSession].EquipB[currentDecoPlayer] = nil
											playerDecoTab[v2] = nil
										else
											print("not remove for deco : "..tostring(currentDecoPlayer))
											playerDecoTab[v2] = nil
										end
									end)
								end
							end
							
						end
						
						for k2,v2 in pairs(v.EquipB) do
							if GetPlayerRoutingBucket(v2) ~= k then
								print("^1Player "..tostring(v2).." is not in good bucket^7")
								SetPlayerRoutingBucket(v2,k)
							end
							if GetPlayerPing(v2) == 0 then
								print("GetPlayerPing("..tostring(v2)..") : "..tostring(GetPlayerPing(v2)))
								
								if playerDecoTab[v2] == nil then
									playerDecoTab[v2] = true
									Citizen.CreateThread(function()
										
										local currentDecoSession = k
										local currentDecoPlayer = v2
										print("CreateThread for deco : "..tostring(currentDecoPlayer))
										local cptTimeoutDeco = 0
										local mustRemove = true
										while cptTimeoutDeco < 100 do
											cptTimeoutDeco = cptTimeoutDeco + 1
											if GetPlayerPing(v2) ~= 0 then
												mustRemove = false
											end
											Wait(1)
										end
										if mustRemove then
											print("mustRemove for deco : "..tostring(currentDecoPlayer))
											for k12,v12 in pairs(currentPaintBallSession[currentDecoSession].EquipB) do
												print("k12: "..tostring(k12).." v12: "..tostring(v12))
												if v12 == currentDecoPlayer then
													table.remove(currentPaintBallSession[currentDecoSession].EquipB,k12)
													print("founded and deleted")
												end
											end
											currentPaintBallSession[currentDecoSession].EquipB[currentDecoPlayer] = nil
											playerDecoTab[v2] = nil
										else
											print("not remove for deco : "..tostring(currentDecoPlayer))
											playerDecoTab[v2] = nil
										end
									end)
								end
							end
							-- print("GetPlayerPing(v2) : "..tostring(GetPlayerPing(v2)))
						end
					else
						print("game fini")
						currentPaintBallSession[k].CurStat = "GameEnding"
						FinManche(k)
					end
				end
			end
		end
	end
end)

RegisterServerEvent('PaintBallCTF:OrbTaken')
AddEventHandler('PaintBallCTF:OrbTaken', function(idx,team)
	local player = source
	print("PaintBallCTF:OrbTaken : "..tostring(idx).." "..tostring(team))
	for k,v in pairs(currentPaintBallSession[idx].EquipA) do
		-- if v~= player then
			TriggerClientEvent("PaintBallCTF:SyncOrbTaken",v,team,true,currentPaintBallSession[idx])
		-- end
	end
	
	for k,v in pairs(currentPaintBallSession[idx].EquipB) do
		-- if v~= player then
			TriggerClientEvent("PaintBallCTF:SyncOrbTaken",v,team,true,currentPaintBallSession[idx])
		-- end
	end

end)

RegisterServerEvent('PaintBallCTF:OrbStolen')
AddEventHandler('PaintBallCTF:OrbStolen', function(idx,team)
	local player = source
	print("PaintBallCTF:OrbTaken : "..tostring(idx).." "..tostring(team))
	
	
	
	local amanche = #currentPaintBallSession[idx].ScoreA
	local bmanche = #currentPaintBallSession[idx].ScoreB
	print("----")
	
	print("amanche : "..tostring(amanche))
	print("bmanche : "..tostring(bmanche))
	
	if team == "blue" then
		currentPaintBallSession[idx].ScoreA[amanche+1] = 1
	elseif team == "red" then
		currentPaintBallSession[idx].ScoreB[bmanche+1] = 1
	end
	
	local amanche = #currentPaintBallSession[idx].ScoreA
	local bmanche = #currentPaintBallSession[idx].ScoreB
	
	if amanche > bmanche then
		currentPaintBallSession[idx].manche = amanche
	elseif amanche < bmanche then
		currentPaintBallSession[idx].manche = bmanche
	else
		currentPaintBallSession[idx].manche = amanche
	end
	
	print("cur manche  : "..tostring(currentPaintBallSession[idx].manche))
	print("----")
	for k,v in pairs(currentPaintBallSession[idx].EquipA) do
		-- if v~= player then
			TriggerClientEvent("PaintBallCTF:SyncOrbTaken",v,team,false,currentPaintBallSession[idx])
		-- end
	end
	
	for k,v in pairs(currentPaintBallSession[idx].EquipB) do
		-- if v~= player then
			TriggerClientEvent("PaintBallCTF:SyncOrbTaken",v,team,false,currentPaintBallSession[idx])
		-- end
	end
end)


RegisterServerEvent('PaintBallCTF:OrbDropped')
AddEventHandler('PaintBallCTF:OrbDropped', function(idx,team)
	local player = source
	print("PaintBallCTF:OrbDropped : "..tostring(idx).." "..tostring(team))
	
	
	for k,v in pairs(currentPaintBallSession[idx].EquipA) do
		
		TriggerClientEvent("PaintBallCTF:SyncOrbDrop",v,team,false)
		
	end
	
	for k,v in pairs(currentPaintBallSession[idx].EquipB) do
		
		TriggerClientEvent("PaintBallCTF:SyncOrbDrop",v,team,false)
		
	end

end)

RegisterServerEvent('PaintBallCTF:OrbReset')
AddEventHandler('PaintBallCTF:OrbReset', function(idx,team)
	local player = source
	print("PaintBallCTF:OrbReset : "..tostring(idx).." "..tostring(team))
	
	
	for k,v in pairs(currentPaintBallSession[idx].EquipA) do
		
		TriggerClientEvent("PaintBallCTF:SyncOrbDrop",v,team,false)
		
	end
	
	for k,v in pairs(currentPaintBallSession[idx].EquipB) do
		
		TriggerClientEvent("PaintBallCTF:SyncOrbDrop",v,team,false)
		
	end

end)
--------------CTF WRAPPER

RegisterServerEvent('PaintBallCTF:sendToPlayerTheStart')
AddEventHandler('PaintBallCTF:sendToPlayerTheStart', function(idx)
	local player = source
	currentPaintBallSession[idx].CurStat = "GameStarting"
	sendToPlayerTheStart(idx)

end)

RegisterServerEvent('PaintBallCTF:LeaveTheGame')
AddEventHandler('PaintBallCTF:LeaveTheGame', function(idx)
	print("LeaveTheGame CTF idx : "..tostring(idx))
	local player = source
	local gameFounded = false
	local playerFounded = false
	if idx ~= 0 then
		for k,v in pairs(currentPaintBallSession) do
			print("k : "..tostring(k).." v: "..tostring(v))
			if k == idx then
				if currentPaintBallSession[k].modes == "CTF" then
					gameFounded = true
					print("gameFounded")
					for k1,v1 in pairs(currentPaintBallSession[k].EquipA) do
						if v1 == player then
							table.remove(currentPaintBallSession[k].EquipA,k1)
							-- TriggerClientEvent("PaintBall:GoToLeaveMatchMSG",player,"tie",maps)
							Wait(50)
							SetPlayerRoutingBucket(player,0)
						end
					end
					
					for k1,v1 in pairs(currentPaintBallSession[k].EquipB) do
						if v1 == player then
							table.remove(currentPaintBallSession[k].EquipB,k1)
							-- TriggerClientEvent("PaintBall:GoToLeaveMatchMSG",player,"tie",maps)
							Wait(50)
							SetPlayerRoutingBucket(player,0)
						end
					end
				end
			end
		
		end
	-- else
		-- TriggerClientEvent("PaintBall:GoToLeaveMatchMSG",player,"tie",maps)
		-- SetPlayerRoutingBucket(player,0)
	end
end)