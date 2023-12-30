local _menuPool = NativeUI.CreatePool()
local evidenceMenu = NativeUI.CreateMenu("Evidence", "~b~Review collected evidence", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(evidenceMenu)

local evidenceMenus = {
	{x = -65.72, y = -814.59, z = 243.31},
	{x = 472.60009765625, y = -991.30712890625, z = 26.273273468018}, -- MRPD GABZ MLO
	--{x = 458.66220092773, y = -974.59912109375, z = 24.914691925049}, -- MRPD 
	{x = 1852.6262207031, y = 3685.35546875, z = 38.220504760742}, -- Sandy Shores SO
	{x = 849.55462646484, y = -1311.9383544922, z = 28.244930267334}, -- La Mesa PD
	{x = -434.02798461914, y = 6007.234375, z = 31.716238021851} -- Paleto Bay SO
}

local playerData = {
	['bodySweat'] = false,
	['wetClothing'] = false,
	['weedScent'] = false,
	['odorAlcohol'] = false,
	['bloodshotEyes'] = false,
	['levelBAC'] = 0.00,
	['dilatedPupils'] = false,
	['gunshotResidue'] = false,
	['impaired'] = false,
	['seatBelt'] = false
}

local GSR_DURATION = 50 * 60000

local droppedEvidence = {}
local collectedEvidence = {}
local onDuty = false
local observing = false
local discardingEvidence = false

local KEYS = {
	ALT = 19,
	Y = 246
}

local EVIDENCE_DESTROY_TIME = 15000

local POLL_INTERVAL_SECONDS = 5

local PICK_UP_ANIMATION = {
	DICT = "amb@prop_human_bum_bin@idle_b",
	NAME = "idle_d"
}

local NO_EVIDENCE_WEAPONS = {
	[101631238] = true,
	[911657153] = true,
	[883325847] = true,
	[GetHashKey("WEAPON_SNOWBALL")] = true,
	[-1600701090] = true,
	[GetHashKey("WEAPON_ROCK")] = true,
	[GetHashKey("WEAPON_BRICK")] = true,
	[GetHashKey("WEAPON_THROWINGKNIFE")] = true,
	[GetHashKey("WEAPON_THROWINGSHOEBLACK")] = true,
	[GetHashKey("WEAPON_THROWINGSHOEBLUE")] = true,
	[GetHashKey("WEAPON_THROWINGSHOERED")] = true,
	[GetHashKey("WEAPON_NINJASTAR")] = true,
	[GetHashKey("WEAPON_NINJASTAR2")] = true,
}

RegisterNetEvent('evidence:updateData')
AddEventHandler('evidence:updateData', function(key, value)
	playerData[key] = value
end)

RegisterNetEvent('hud:setBelt')
AddEventHandler('hud:setBelt', function(beltOn)

	playerData['seatBelt'] = beltOn
end)

RegisterNetEvent('evidence:returnData')
AddEventHandler('evidence:returnData', function(callback)
	callback(playerData)
end)

Citizen.CreateThread(function()
	local timer = 120000 -- 2 mins
	while true do
		if playerData['levelBAC'] > 0.00 then
			playerData['levelBAC'] = playerData['levelBAC'] - 0.02
		end
		Wait(timer) -- every x seconds, decrement playerBAC
	end
end)

Citizen.CreateThread(function()
	local timeRunning = 0
	while true do
		Wait(1000)
		local playerPed = PlayerPedId()
		local playerBAC = playerData['levelBAC']
		if playerBAC > 0.04 and not playerData['odorAlcohol'] then
			playerData['odorAlcohol'] = true
		elseif playerBAC <= 0.03 and playerData['odorAlcohol'] then
			playerData['odorAlcohol'] = false
		end
		if playerBAC >= 0.10 and not playerData['impaired'] then
			if math.random() > 0.8 then
				playerData['bloodshotEyes'] = true
			end
		elseif playerBAC < 0.10 and playerData['impaired'] then
			StopEffects()
			playerData['bloodshotEyes'] = false
		end
		if playerBAC >= 0.20 and playerBAC < 0.30 then
			Intoxicate(false, 'move_m@drunk@moderatedrunk', 0.5)
		elseif playerBAC >= 0.30 and playerBAC < 0.40 then
			Intoxicate(false, 'move_m@drunk@verydrunk', 0.5)
			if math.random() < 0.2 then
				DoScreenFadeOut(2000)
				Citizen.Wait(1000)
				DoScreenFadeIn(2000)
			end
		elseif playerBAC >= 0.40 and not IsEntityDead(playerPed) then
			Intoxicate(false, 'move_m@drunk@verydrunk', 0.5)
			DoScreenFadeOut(4000)
			Citizen.Wait(4000)
			SetEntityHealth(playerPed, 0)
			DoScreenFadeIn(4000)
			exports.globals:notify("You have passed out!")
		end
		if GetEntitySpeed(playerPed) > 3.0 and (IsPedSprinting(playerPed) or IsPedRunning(playerPed)) then
			timeRunning = timeRunning + 1
		else
			if timeRunning - 1 >= 0 then
				timeRunning = timeRunning - 1
			end
		end
		if timeRunning > 20 and not playerData['bodySweat'] then
			playerData['bodySweat'] = true
			TriggerEvent('usa:notify', 'Laboured breathing, body sweat.')
			Citizen.CreateThread(function()
				Citizen.Wait(300000)
				playerData['bodySweat'] = false
			end)
		end
		if IsEntityInWater(playerPed) and not playerData['wetClothing'] then
			playerData['wetClothing'] = true
			TriggerEvent('usa:notify', 'Clothes are soaked and wet.')
			Citizen.CreateThread(function()
				Citizen.Wait(300000)
				playerData['wetClothing'] = false
			end)
		end
	end
end)

Citizen.CreateThread(function()
	local lastShotTime = 0
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		if IsPedShooting(playerPed) and not NO_EVIDENCE_WEAPONS[GetSelectedPedWeapon(playerPed)] then
			local playerCoords = GetEntityCoords(playerPed)
			local playerWeapon = GetSelectedPedWeapon(playerPed)
			TriggerServerEvent('evidence:newCasing', playerCoords, playerWeapon)
			playerData['gunshotResidue'] = true
			lastShotTime = GetGameTimer()
			Citizen.Wait(3000)
		end
		if GetGameTimer() - lastShotTime > GSR_DURATION or lastShotTime == 0 then
			playerData['gunshotResidue'] = false
		end
		if IsControlPressed(0, KEYS.ALT) and IsControlJustPressed(0, KEYS.Y) and not observing then
			TriggerEvent("usa:getClosestPlayer", 1.65, function(player)
	    		if player then
		        	local closestPed = GetPlayerPed(GetPlayerFromServerId(player.id))
					if player.id ~= 0 and not IsPedInAnyVehicle(PlayerPedId()) and IsEntityVisible(closestPed) then
						TriggerServerEvent('evidence:makeObservations', player.id)
					end
				end
	        end)
	    end
	end
end)

RegisterNetEvent('evidence:breathalyzeNearest')
AddEventHandler('evidence:breathalyzeNearest', function()
	TriggerEvent("usa:getClosestPlayer", 1.6, function(player)
		if player.id ~= 0  and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
			-- play animation:
			local anim = {
				name = "base",
				dict = "amb@world_human_security_shine_torch@male@base"
			}
			TriggerEvent("usa:playAnimation", anim.dict, anim.name, -8, 1, -1, 53, 0, 0, 0, 0, 3)
			TriggerServerEvent('display:shareDisplay', 'breathalyzes person', 2, 370, 10, 3000)
			local beginTime = GetGameTimer()
			while GetGameTimer() - beginTime < 3000 do
				DrawTimer(beginTime, 3000, 1.42, 1.475, 'BREATHALYZING')
				Citizen.Wait(0)
			end
			TriggerServerEvent("evidence:breathalyzePlayer", player.id)
		else
			TriggerEvent("usa:notify", "No person found to breathalyze!")
		end
	end)
end)

RegisterNetEvent('evidence:dnaNearest')
AddEventHandler('evidence:dnaNearest', function()
	TriggerEvent("usa:getClosestPlayer", 1.6, function(player)
		if player.id ~= 0 and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
			-- play animation:
			local anim = {
				name = "base",
				dict = "amb@world_human_security_shine_torch@male@base"
			}
			TriggerEvent("usa:playAnimation", anim.dict, anim.name, -8, 1, -1, 53, 0, 0, 0, 0, 3)
			TriggerServerEvent('display:shareDisplay', 'takes DNA sample', 2, 370, 10, 3000)
			local beginTime = GetGameTimer()
			while GetGameTimer() - beginTime < 3000 do
				DrawTimer(beginTime, 3000, 1.42, 1.475, 'SAMPLING')
				Citizen.Wait(0)
			end
			TriggerServerEvent("evidence:returnDNA", player.id)
		else
			TriggerEvent("usa:notify", "No person found to sample from!")
		end
	end)
end)

RegisterNetEvent('evidence:dnaClipboard')
AddEventHandler('evidence:dnaClipboard', function(dna)
	local message = dna
	-- print(message)
	SendNUIMessage({
    	message = message
  	})
end)

RegisterNetEvent('evidence:getBreathalyzeResult')
AddEventHandler('evidence:getBreathalyzeResult', function(sourceReturnedTo)
	TriggerServerEvent('evidence:returnBreathalyzeResult', playerData['levelBAC'], sourceReturnedTo)
end)

RegisterNetEvent('evidence:weedScent')
AddEventHandler('evidence:weedScent', function()
	if not playerData['weedScent'] then
		playerData['weedScent'] = true
		local timeToWait = math.random((15 * 60000), (45 * 60000))
		Citizen.Wait(timeToWait)
		playerData['weedScent'] = false
	end
end)

RegisterNetEvent('evidence:gsrNearest')
AddEventHandler('evidence:gsrNearest', function()
	TriggerEvent("usa:getClosestPlayer", 1.6, function(player)
		if player.id ~= 0 and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
			-- play animation:
			local anim = {
				name = "base",
				dict = "amb@world_human_security_shine_torch@male@base"
			}
			TriggerEvent("usa:playAnimation", anim.dict, anim.name, -8, 1, -1, 53, 0, 0, 0, 0, 3)
			TriggerServerEvent('display:shareDisplay', 'tests gunshot residue', 2, 470, 10, 3000)
			local beginTime = GetGameTimer()
			while GetGameTimer() - beginTime < 3000 do
				DrawTimer(beginTime, 3000, 1.42, 1.475, 'TESTING')
				Citizen.Wait(0)
			end
			TriggerServerEvent("evidence:gsrPerson", player.id)
		else
			TriggerEvent("usa:notify", "No person found to test!")
		end
	end)
end)

RegisterNetEvent('evidence:getGSRResult')
AddEventHandler('evidence:getGSRResult', function(sourceReturnedTo)
	TriggerServerEvent('evidence:returnGSRResult', playerData['gunshotResidue'], sourceReturnedTo)
end)

RegisterNetEvent('evidence:getObservations')
AddEventHandler('evidence:getObservations', function(sourceReturnedTo)
	TriggerServerEvent('evidence:returnObservations', playerData, sourceReturnedTo)
end)

RegisterNetEvent('evidence:displayObservations')
AddEventHandler('evidence:displayObservations', function(observations, targetSource)
	observing = true
	local hasSomethingToObserve = false
	local beginTime = GetGameTimer()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSource))
	--TriggerServerEvent('display:shareDisplay', 'observes person', 2, 370, 10, 3000)
	while GetGameTimer() - beginTime < 5000 do
		DrawTimer(beginTime, 5000, 1.42, 1.475, 'OBSERVING')
		Citizen.Wait(0)
	end
	beginTime = GetGameTimer()
	while GetGameTimer() - beginTime < 10000 do
		Citizen.Wait(0)
		for key, value in pairs(observations) do
			if key == 'bodySweat' and value then
	      		local x, y, z = table.unpack(GetPedBoneCoords(targetPed, 24818, 0.0, 0.0, 0.0))
				DrawText3D(x, y, z, 3, 'Body Sweat')
				hasSomethingToObserve = true
			elseif key == 'wetClothing' and value then
				local x, y, z = table.unpack(GetPedBoneCoords(targetPed, 0, 0.0, 0.0, 0.0))
				DrawText3D(x, y, z, 3, 'Wet Clothing')
				hasSomethingToObserve = true
			elseif key == 'weedScent' and value then
				local x, y, z = table.unpack(GetPedBoneCoords(targetPed, 57005, 0.0, 0.0, 0.0))
				DrawText3D(x, y, z, 3, 'Marijuana Odor')
				hasSomethingToObserve = true
			elseif key == 'bloodshotEyes' and value then
				local x, y, z = table.unpack(GetPedBoneCoords(targetPed, 20178, 0.0, 0.0, 0.0))
				DrawText3D(x, y, z, 3, 'Bloodshot Eyes')
				hasSomethingToObserve = true
			elseif key == 'dilatedPupils' and value then
				local x, y, z = table.unpack(GetPedBoneCoords(targetPed, 31086, 0.0, 0.0, 0.0))
				DrawText3D(x, y, z, 3, 'Dilated Pupils')
				hasSomethingToObserve = true
			elseif key == 'odorAlcohol' and value then
				local x, y, z = table.unpack(GetPedBoneCoords(targetPed, 39317, 0.0, 0.0, 0.0))
				DrawText3D(x, y, z, 3, 'Alcohol Odor')
				hasSomethingToObserve = true
			elseif key == 'seatBelt' and IsPedInAnyVehicle(targetPed, false) then
				local x, y, z = table.unpack(GetPedBoneCoords(targetPed, 11816, 0.0, 0.0, 0.0))
				if value then
					DrawText3D(x, y, z, 3, 'Seatbelt On')
				else
					DrawText3D(x, y, z, 3, 'Seatbelt Off')
				end
				hasSomethingToObserve = true
			end
		end
		if not hasSomethingToObserve then
			local x, y, z = table.unpack(GetPedBoneCoords(targetPed, 24818, 0.0, 0.0, 0.0))
			DrawText3D(x, y, z, 3, 'Looks normal')
		end
	end
	observing = false
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		_menuPool:MouseControlsEnabled(false)
		_menuPool:ControlDisablingEnabled(false)
		_menuPool:ProcessMenus()
		local player = PlayerId()
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		if IsControlJustPressed(0, 303) and not discardingEvidence and not IsPedCuffed(playerPed) and not IsEntityDead(playerPed) and not IsPedInAnyVehicle(playerPed) and IsPlayerFreeAiming(player) and GetSelectedPedWeapon(playerPed) == GetHashKey("WEAPON_FLASHLIGHT") then
			for i = 1, #droppedEvidence do
				local item = droppedEvidence[i]
				if Vdist(playerCoords, item.coords) < 1.0 then
					exports.globals:loadAnimDict(PICK_UP_ANIMATION.DICT)
					if onDuty then
						local beginTime = GetGameTimer()
						while GetGameTimer() - beginTime < 3000 do
							DrawTimer(beginTime, 3000, 1.42, 1.475, 'COLLECTING')
							if not IsEntityPlayingAnim(playerPed, PICK_UP_ANIMATION.DICT, PICK_UP_ANIMATION.NAME, 3) and not IsPedInAnyVehicle(playerPed, true) then
								TaskPlayAnim(playerPed,PICK_UP_ANIMATION.DICT, PICK_UP_ANIMATION.NAME, 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
							end
							Wait(0)
						end
						ClearPedTasks(playerPed)
						local street = string.upper(string.sub(GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(item.coords))), 1, 3))
						item.name = KeyboardInput('Evidence tag: ', '['..street..'] '..item.string..' No. ', 32)
						if HasEvidenceNamed(item.name) then
							TriggerEvent('usa:notify', 'Evidence with this tag already exists!')
							break
						else
							if item.name == '' or not item.name then
								TriggerServerEvent('evidence:discardEvidence', item.coords)
								TriggerEvent('usa:notify', 'Evidence has been ~y~discarded~s~.')
								break
							else
								TriggerEvent('chatMessage', '^3^*[EVIDENCE]^r ^7You have picked up ^3'..item.string..'^7, tagged as ^3'..item.name..'^7!')
								item.processed = false
								table.insert(collectedEvidence, item)
								TriggerServerEvent('evidence:discardEvidence', item.coords)
								break
							end
						end
					else
						local beginTime = GetGameTimer()
						discardingEvidence = true
						while GetGameTimer() - beginTime < EVIDENCE_DESTROY_TIME do
							DrawTimer(beginTime, EVIDENCE_DESTROY_TIME, 1.42, 1.475, 'DESTROYING')
							if not IsEntityPlayingAnim(playerPed, PICK_UP_ANIMATION.DICT, PICK_UP_ANIMATION.NAME, 3) and not IsPedInAnyVehicle(playerPed, true) then
								TaskPlayAnim(playerPed, PICK_UP_ANIMATION.DICT, PICK_UP_ANIMATION.NAME, 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
							end
							Wait(0)
						end
						ClearPedTasks(playerPed)
						TriggerEvent('usa:notify', 'Evidence has been destroyed.')
						TriggerServerEvent('evidence:discardEvidence', item.coords)
						discardingEvidence = false
						break
					end
				end
			end
		end
		if IsControlJustPressed(0, 38) and not discardingEvidence then
			for i = 1, #evidenceMenus do
				local location = evidenceMenus[i]
				if Vdist(playerCoords, location.x, location.y, location.z) < 2.0 then
					if #collectedEvidence ~= 0 then
						TriggerServerEvent('evidence:checkJobForMenu')
					else
						TriggerEvent('usa:notify', 'You have no evidence collected!')
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local player = PlayerId()
		local playerPed = PlayerPedId()
		if IsPlayerFreeAiming(player) and GetSelectedPedWeapon(playerPed) == GetHashKey("WEAPON_FLASHLIGHT") then
			for i = 1, #droppedEvidence do
				local item = droppedEvidence[i]
				local text = '[U] - Discard Evidence'
				if onDuty then
					text = '[U] - Pickup '..item.string
				end
				local x, y, z = table.unpack(item.coords)
				DrawText3D(x, y, z - 1.0, 5, text)
			end
		end
		
		for i = 1, #evidenceMenus do
			local location = evidenceMenus[i]
			DrawText3D(location.x, location.y, location.z, 2, '[E] - Evidence')
		end

		Wait(1)
	end
end)

-- poll the server for nearest evidence every POLL_INTERVAL_SECONDS seconds --
Citizen.CreateThread(function()
    local lastCheck = 0
    while true do
        if GetGameTimer() - lastCheck > POLL_INTERVAL_SECONDS * 1000 then
			local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            TriggerServerEvent("evidence:loadNearbyEvidence", playerCoords)
            lastCheck = GetGameTimer()
        end
        Wait(1)
    end
end)

RegisterNetEvent("evidence:loadNearbyEvidence")
AddEventHandler("evidence:loadNearbyEvidence", function(nearbyEvidence)
	droppedEvidence = nearbyEvidence
end)

RegisterNetEvent('evidence:openEvidenceMenu')
AddEventHandler('evidence:openEvidenceMenu', function()
	RefreshEvidenceMenu()
	evidenceMenu:Visible(true)
end)

RegisterNetEvent('interaction:setPlayersJob')
AddEventHandler('interaction:setPlayersJob', function(job)
	if job == 'sheriff' or job == 'corrections' then
		onDuty = true
	else
		onDuty = false
	end
end)

RegisterNetEvent('character:setCharacter')
AddEventHandler('character:setCharacter', function()
	if playerData['impaired'] then
		StopEffects()
	end
	playerData = {
		['bodySweat'] = false,
		['wetClothing'] = false,
		['weedScent'] = false,
		['odorAlcohol'] = false,
		['bloodshotEyes'] = false,
		['levelBAC'] = 0.00,
		['dilatedPupils'] = false,
		['gunshotResidue'] = false,
		['impaired'] = false,
		['seatBelt'] = false
	}
	onDuty = false
end)

function RefreshEvidenceMenu(evidence)
	evidenceMenu:Clear()
	_menuPool:TotalItemsPerPage(11)
	for i = 1, #collectedEvidence do
		local item = collectedEvidence[i]
		local evidenceItem = NativeUI.CreateItem(item.name, 'Type: '..item.string)
		if item.processed then
			if item.type == 'casing' then
				evidenceItem = NativeUI.CreateItem(item.name, 'Type: '..item.string .. ' | Weapon: '..tostring(item.weapon))
			elseif item.type == 'dna2' then
				evidenceItem = NativeUI.CreateItem(item.name, 'Type: '..item.string .. ' | DNA1: '..item.DNA1..' | DNA2: '..item.DNA2)
			elseif item.type == 'dna' then
				evidenceItem = NativeUI.CreateItem(item.name, 'Type: '..item.string .. ' | DNA: '..item.DNA)
			end
			evidenceItem:SetRightBadge(BadgeStyle.Tick)
		else
			evidenceItem:SetRightBadge(BadgeStyle.Alert)
		end
		evidenceMenu:AddItem(evidenceItem)
		evidenceItem.Activated = function(parentmenu, selected)
			if not item.processed then
				evidenceMenu:Visible(false)
				discardingEvidence = true
				RequestAnimDict('anim@amb@prop_human_seat_computer@male@base')
				while not HasAnimDictLoaded('anim@amb@prop_human_seat_computer@male@base') do Citizen.Wait(100) end
				TaskPlayAnim(PlayerPedId(), 'anim@amb@prop_human_seat_computer@male@base', 'base', 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
				local beginTime = GetGameTimer()
				while GetGameTimer() - beginTime < 5000 do
					DrawTimer(beginTime, 5000, 1.42, 1.475, 'PROCESSING')
					Citizen.Wait(0)
				end
				item.processed = true
				ClearPedTasks(PlayerPedId())
				TriggerEvent('usa:notify', 'Evidence has been ~g~processed~s~.')
				discardingEvidence = false
			end
		end
	end
end

-- getting drunk / high effect
function Intoxicate(playScenario, clipset, shakeCam)
	Citizen.CreateThread(function()
		if not playerData["impaired"] then
			local playerPed = PlayerPedId()
			if playScenario then
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRUG_DEALER", 0, 1)
			end
			Citizen.Wait(5000)
			DoScreenFadeOut(500)
			Citizen.Wait(500)
			SetTimecycleModifier("spectator5")
			SetPedMotionBlur(playerPed, true)
			if clipset then
				TriggerEvent('civ:forceWalkStyle', clipset)
			end
			SetPedIsDrunk(playerPed, true)
			DoScreenFadeIn(500)
			if shakeCam then
				ShakeGameplayCam("DRUNK_SHAKE", shakeCam)
			end
			playerData["impaired"] = true
		end
	end)
 end

 function StopEffects()
 	Citizen.CreateThread(function()
 		DoScreenFadeOut(500)
		Citizen.Wait(500)
		DoScreenFadeIn(500)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		TriggerEvent('civ:resetWalkStyle')
		SetPedIsDrunk(PlayerPedId(), false)
		SetPedMotionBlur(PlayerPedId(), false)
		StopGameplayCamShaking(true)
		playerData["impaired"] = false
 	end)
 end

 function DrawTimer(beginTime, duration, x, y, text)
    if not HasStreamedTextureDictLoaded('timerbars') then
        RequestStreamedTextureDict('timerbars')
        while not HasStreamedTextureDictLoaded('timerbars') do
            Citizen.Wait(0)
        end
    end

    if GetTimeDifference(GetGameTimer(), beginTime) < duration then
        w = (GetTimeDifference(GetGameTimer(), beginTime) * (0.085 / duration))
    end

    local correction = ((1.0 - math.floor(GetSafeZoneSize(), 2)) * 100) * 0.005
    x, y = x - correction, y - correction

    Set_2dLayer(0)
    DrawSprite('timerbars', 'all_black_bg', x, y, 0.15, 0.0325, 0.0, 255, 255, 255, 180)

    Set_2dLayer(1)
    DrawRect(x + 0.0275, y, 0.085, 0.0125, 100, 0, 0, 180)

    Set_2dLayer(2)
    DrawRect(x - 0.015 + (w / 2), y, w, 0.0125, 150, 0, 0, 180)

    SetTextColour(255, 255, 255, 180)
    SetTextFont(0)
    SetTextScale(0.3, 0.3)
    SetTextCentre(true)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    Set_2dLayer(3)
    DrawText(x - 0.06, y - 0.012)
end

function DrawText3D(x, y, z, distance, text)
    if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) < distance and not IsPlayerSwitchInProgress() then
    	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	    SetTextScale(0.35, 0.35)
	    SetTextFont(4)
	    SetTextProportional(1)
	    SetTextColour(255, 255, 255, 215)
	    SetTextEntry("STRING")
	    SetTextCentre(1)
	    AddTextComponentString(text)
	    DrawText(_x,_y)
	    local factor = (string.len(text)) / 370
	    DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
	end
end

function KeyboardInput(textEntry, inputText, maxLength) -- Thanks to Flatracer for the function.
	TriggerEvent("hotkeys:enable", false)
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		TriggerEvent("hotkeys:enable", true)
        return result
    else
		Citizen.Wait(500)
		TriggerEvent("hotkeys:enable", true)
        return nil
    end
end

function HasEvidenceNamed(name)
	for i = 1, #collectedEvidence do
		local evidence = collectedEvidence[i]
		if evidence.name == name then
			return true
		end
	end
	return false
end
