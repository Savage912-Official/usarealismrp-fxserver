RegisterNetEvent('death:allowRespawn')
RegisterNetEvent('death:allowRevive')
-- Turn off automatic respawn here instead of updating FiveM file.
AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:spawnPlayer() -- Ensure player spawns into server.
	Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
end)

local RESPAWN_WAIT_TIME = 600 * 1000

local diedTime = nil

local isCarried = false

local lastKillerID = nil

local emscalled = false

AddEventHandler('death:allowRespawn', function()
	allowRespawn = true
end)

RegisterNetEvent("usa:toggleJailedStatus")
AddEventHandler("usa:toggleJailedStatus", function (toggle)
	if jailed and not toggle then
		if IsEntityDead(GetPlayerPed(-1)) then
			allowRevive = true
		end
	end
	jailed = toggle
end)

AddEventHandler('death:allowRevive', function()
	if(not IsEntityDead(GetPlayerPed(-1)))then
		-- You are alive, do nothing.
		return
	end
	-- Revive the player.
	allowRevive = true
end)

RegisterNetEvent('character:setCharacter')
AddEventHandler('character:setCharacter', function()
	allowRevive = true
end)

function revivePed(ped, anim)
	local playerPos = GetEntityCoords(ped, true)
	FreezeEntityPosition(ped, false)
	NetworkResurrectLocalPlayer(playerPos, true, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
	if anim then
		RequestAnimDict('combat@damage@injured_pistol@to_writhe')
		while not HasAnimDictLoaded('combat@damage@injured_pistol@to_writhe') do
	        Citizen.Wait(0)
	    end
	    TaskPlayAnim(ped, "combat@damage@injured_pistol@to_writhe", "variation_d", 8.0, 1, -1, 49, 0, 0, 0, 0)
	    Citizen.Wait(1500)
	    ClearPedTasksImmediately(ped)
	end
end

local CAYO_PERICO_MANSION_COORDS = vector3(5006.8388671875, -5755.7104492188, 21.358211517334)

function respawnPed(ped,coords)
	local currentCoords = GetEntityCoords(ped)
	if #(currentCoords - CAYO_PERICO_MANSION_COORDS) < 500 then
		TriggerServerEvent("av_cayoheist:removeGoods")
	end
	FreezeEntityPosition(ped, false)
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	RequestCollisionAtCoord(coords.x, coords.y, coords.z)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	while not HasCollisionLoadedAroundEntity(ped) do
        Citizen.Wait(100)
        SetEntityCoords(ped, coords.x, coords.y, coords.z, 1, 0, 0, 1)
    end
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
	RemoveAllPedWeapons(GetPlayerPed(-1), true) -- strip weapons
	-- remove player weapons from db
	TriggerServerEvent("death:respawn")
	TriggerEvent('death:injuryPayment')
	TriggerEvent("crim:blindfold", false, false, true)
	TriggerEvent("cuff:unCuff", true)
	ClearPedBloodDamage(ped)
	SetPlayerInvincible(ped, false)
	Citizen.Wait(3000)
	DoScreenFadeIn(500)
	TriggerEvent("chatMessage", "", { 0, 0, 0 }, "^1^*[RESPAWN] ^r^7You wake up at the local hospital, and can't seem to remember events leading up to now...")
end

RegisterNetEvent("usa_death:epi")
AddEventHandler("usa_death:epi", function(bool)
	if IsEntityDead(PlayerPedId()) then
		TriggerEvent("mumble:setDead", not bool)
	end 
end)

Citizen.CreateThread(function()
	local playsound = false
	local freeze = true
	local triggerDeadEvents = false
	local wasDead = false
	local injuryScript = exports.usa_injury

	local respawnCount = 0
	local spawnPoints = {
		{x = 360.3, y = -548.9, z = 28.8},
		{x = -240.10, y = 6324.22, z = 32.43},
		{x = 1814.914, y = 3685.767, z = 34.224}
	}
	local playerIndex = NetworkGetPlayerIndex(-1)

	math.randomseed(playerIndex)

	while true do
		Wait(0)
		local ped = PlayerPedId()

		if (IsEntityDead(ped)) then
            if not wasDead then
				wasDead = true
				if not injuryScript:isConscious(PlayerPedId()) then
					TriggerEvent("mumble:setDead", true)
				end
            end
			if triggerDeadEvents then
				triggerDeadEvents = false
				TriggerEvent('death:createLog', ped)
				if jailed then
					TriggerEvent('chatMessage', "", {0,0,0}, "^0You've passed out. Wait until you are released or a correctional officer helps you.")
				end
			end
			if(diedTime == nil)then
				diedTime = GetGameTimer()
			end -- the player is down
			if playsound then
				TriggerServerEvent('InteractSound_SV:PlayOnSource', 'demo', 0.5)
				playsound = false
			end

			if not emscalled then
				local emswaitPeriod = diedTime + (60*1000)
				if (GetGameTimer() < emswaitPeriod) then
					local seconds = math.ceil((emswaitPeriod - GetGameTimer()) / 1000)
					local minutes = math.floor((seconds / 60))
					DrawTxt(0.932, 1.35, 1.0, 1.0, 0.50, 'Local will call 911 in ~g~'.. SecondsToMinuteClock(seconds) .. ' ~s~minutes', 255, 255, 255, 255)
				else
					DrawTxt(0.948, 1.35, 1.0, 1.0, 0.50, 'Press ~g~R ~s~ for a local to call 911', 255, 255, 255, 255)
					local isInPoliceCustody = IsPedCuffed(ped) and not exports.usa_rp2:areHandsTied()
					if IsControlPressed(0, 140) and not isInPoliceCustody then -- R
						emscalled = true
						local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			            local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
			            local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
			            TriggerServerEvent('911:PlayerCall', x, y, z, lastStreetNAME, "Local 911 Call about an unconscious person! Dispatch medical ASAP!")
					end
				end
			end

			DrawTxt(0.817, 1.25, 1.0, 1.0, 0.50, 'Incapacitated, wait for medical attention or respawn (After 1 minute a local will call 911 for you)!', 255, 255, 255, 255)
			if GetEntitySpeed(ped) < 0.05 and not IsEntityInAir(ped) and not IsEntityInWater(ped) and not IsPedInAnyVehicle(ped) then
				if freeze then
					heading = GetEntityHeading(ped)
					coords = GetEntityCoords(ped)
					FreezeEntityPosition(ped, true)
					SetEntityCoords(ped, coords.x, coords.y, coords.z - 1.0, 0, 0, 0)
					revivePed(ped, false)
					SetEntityHealth(GetPlayerPed(-1), 0)
					freeze = false
					--print('Should be static now...')
				end
				FreezeEntityPosition(ped, true)
			end
			--DisableControlAction(1, 1, true) -- LOOK UP, DOWN, LEFT, RIGHT
			DisableControlAction(1, 2, true)
			DisableControlAction(1, 4, true)
			DisableControlAction(1, 6, true)
			DisableControlAction(0, 26, true) -- LOOK BEHIND
			--DisableControlAction(0, 0, true) -- CHANGE CAMERA VIEW
			--SetPlayerInvincible(ped, true) causes tens of anticheese flags lol
			SetEntityHealth(ped, 1)
			if not jailed then
				local waitPeriod = diedTime + (RESPAWN_WAIT_TIME) -- how long you must wait (5 mins)
				if(GetGameTimer() < waitPeriod)then
					local seconds = math.ceil((waitPeriod - GetGameTimer()) / 1000)
					local minutes = math.floor((seconds / 60))
					DrawTxt(0.93, 1.3, 1.0, 1.0, 0.50, 'You may respawn in ~g~'.. SecondsToMinuteClock(seconds) .. ' ~s~minutes', 255, 255, 255, 255)
				else
					DrawTxt(0.948, 1.3, 1.0, 1.0, 0.50, 'Press ~g~E ~s~+ ~g~ENTER~s~ to respawn', 255, 255, 255, 255)
					local isInPoliceCustody = IsPedCuffed(ped) and not exports.usa_rp2:areHandsTied()
					if IsControlPressed(0, 191)  and IsControlPressed(0, 38) and not isInPoliceCustody then -- ENTER + E
						TriggerEvent('death:allowRespawn')
					end
				end
			end

			if (allowRespawn) then
				local closest = spawnPoints[1]
				local pedcoords = GetEntityCoords(ped)
				for i = 1, #spawnPoints do
					if Vdist(pedcoords.x, pedcoords.y, pedcoords.z, spawnPoints[i].x, spawnPoints[i].y, spawnPoints[i].z) < Vdist(pedcoords.x, pedcoords.y, pedcoords.z, closest.x, closest.y, closest.z) then
						closest = spawnPoints[i]
					end
				end

				respawnPed(ped, closest)

		  		allowRespawn = false
		  		diedTime = nil
		  		respawnCount = respawnCount + 1
				math.randomseed( playerIndex * respawnCount )

			elseif (allowRevive) then
				--print('Reviving...')
				revivePed(ped, true)

				allowRevive = false
	  			diedTime = nil
			end
		else
			if wasDead then 
				wasDead = false
				TriggerEvent("mumble:setDead", false)
				TriggerEvent("usa_injury:epi", false)
			end
			emscalled = false
	  		allowRespawn = false
	  		allowRevive = false
	  		diedTime = nil
	  		--playsound = true
	  		freeze = true
	  		triggerDeadEvents = true
		end

	end
end)

RegisterNetEvent('death:createLog')
AddEventHandler('death:createLog', function(ped)
	lastKillerID = nil -- reset

	-- send death log
	local deathLog = {
		deadPlayerId = GetPlayerServerId(PlayerId()),
		deadPlayerName = GetPlayerName(PlayerId()),
		cause = GetPedCauseOfDeath(ped),
		killer = GetPedKiller(ped),
		--killer_source = GetPedSourceOfDeath(ped),
		tod = GetPedTimeOfDeath(ped),
		lastDeath = GetTimeSinceLastDeath(),
		killerName = "",
		killerId = 0
	}

	for id = 0, 255 do
		if NetworkIsPlayerActive(id) then
			if GetPlayerPed(id) == deathLog.killer then -- save killer details
				deathLog.killerId = GetPlayerServerId(id)
				deathLog.killerName = GetPlayerName(id)
				lastKillerID = deathLog.killerId
			end
		end
	end

	if deathLog.killerId == 0 then
		--print("killer ID was 0!")
		--print("killer: " .. deathLog.killer)
		--print("cause: " .. deathLog.cause)
		local killer_entity_type = 0
		local cause_entity_type = 0
		if deathLog.killer and deathLog.cause then
			if DoesEntityExist(deathLog.killer) then
				killer_entity_type = GetEntityType(deathLog.killer)
			end
			if DoesEntityExist(deathLog.cause) then
				cause_entity_type = GetEntityType(deathLog.cause)
			end
			local ped_in_veh_seat = GetPedInVehicleSeat(deathLog.killer, -1)
			for id = 0, 255 do
				if NetworkIsPlayerActive(id) then
					if GetPlayerPed(id) == ped_in_veh_seat then -- save vdm'r details
						deathLog.killerId = GetPlayerServerId(id)
						deathLog.killerName = GetPlayerName(id)
					end
				end
			end
		else
			--print("deathLog.killer or deathLog.cause or both were nil")
		end
		--print("ped in veh seat: " .. ped_in_veh_seat)
		--print("killer entity type = " .. killer_entity_type)
		--print("cause entity type = " .. cause_entity_type)
	else
		--print("killer ID was NOT 0!")
	end

	TriggerServerEvent("death:newDeathLog", deathLog)
end)

RegisterNetEvent("death:reviveNearest")
AddEventHandler("death:reviveNearest", function()
	TriggerEvent("usa:getClosestPlayer", 1.65, function(player)
		if player then
        	local closestPed = GetPlayerPed(GetPlayerFromServerId(player.id))
			if player.id ~= 0 and not IsPedInAnyVehicle(PlayerPedId()) and IsEntityVisible(closestPed) then
				TriggerServerEvent('death:revivePerson', player.id)
				return
			end
		end
		ReviveNearestDeadPed()
    end)
end)

RegisterNetEvent('death:reviveMeWhileCarried')
AddEventHandler('death:reviveMeWhileCarried', function(_isCarried)
	local playerPed = PlayerPedId()
	local x, y, z = table.unpack(GetEntityCoords(playerPed))
	if _isCarried and IsEntityDead(playerPed) then
		revivePed(playerPed, false)
		isCarried = true
	elseif not _isCarried and isCarried then
		SetEntityCoords(playerPed, x, y + 1.0, z)
		SetEntityHealth(playerPed, 1)
		isCarried = false
	end
end)

function DrawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function SecondsToMinuteClock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
    return "00:00";
  else
    mins = string.format("%02.f", math.floor(seconds/60));
    secs = string.format("%02.f", math.floor(seconds - mins *60));
    return mins..":"..secs
  end
end

function GetPlayerFromPed(ped)
    for a = 0, 255 do
        if GetPlayerPed(a) == ped then
            return a
        end
    end
    return -1
end

function ReviveNearestDeadPed()
	local mycoords = GetEntityCoords(GetPlayerPed(-1))
	for ped in exports.globals:EnumeratePeds() do
		if ped ~= PlayerPedId() then
			local pedcoords = GetEntityCoords(ped)
			if IsPedDeadOrDying(ped) then
				if Vdist(pedcoords.x, pedcoords.y, pedcoords.z, mycoords.x, mycoords.y, mycoords.z) < 5.0 then
					local model = GetEntityModel(ped)
					DeleteEntity(ped)
					local clone = CreatePed(4, model, pedcoords.x, pedcoords.y, pedcoords.z, 0.0 --[[Heading]], true --[[Networked, set to false if you just want to be visible by the one that spawned it]], false --[[Dynamic]])
					Wait(500)
					ClearPedTasks(clone)
					SetEntityAsNoLongerNeeded(clone)
					Citizen.Wait(100)
					TaskWanderInArea(clone, pedcoords, 500.0, 100.0, 10.0)
					SetPedKeepTask(clone, true)
					return
				end
			end
		end
	end
end

RegisterClientCallback {
	eventName = "death:getKillerID",
	eventCallback = function()
		return lastKillerID
	end
}
