local isCuffed = false
local isHardcuffed = false
local cuffanimplaying = false
local awaitingHandsDown = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local count = 0

local uncuff_locations = {
	{x = -533.3, y = 5291.5, z = 74.2},
	{x = 605.73565673828, y = -3091.7116699219, z = 6.069260597229}
}

-- falling when running
Citizen.CreateThread(function()
	while true do
		Wait(4000)
		local playerPed = PlayerPedId()
		if GetEntitySpeed(playerPed) > 3.0 and isCuffed then
			local fallProbability = math.random()
			if fallProbability < 0.6 then
				SetPedToRagdoll(playerPed, 2000, 2000, 0, true, true, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerPed = PlayerPedId()
		if isCuffed then
			--DisableControlAction(1, 245, true) 245 = 5 FOR TEXT CHAT
			DisableControlAction(1, 117, true)
			DisableControlAction(1, 73, true)
			DisableControlAction(1, 29, true)
			DisableControlAction(1, 322, true)

			DisableControlAction(1, 18, true)
			DisableControlAction(1, 24, true)
			DisableControlAction(1, 69, true)
			DisableControlAction(1, 92, true)
			DisableControlAction(1, 106, true)
			DisableControlAction(1, 122, true)
			DisableControlAction(1, 135, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 144, true)
			DisableControlAction(1, 176, true)
			DisableControlAction(1, 223, true)
			DisableControlAction(1, 229, true)
			DisableControlAction(1, 237, true)
			DisableControlAction(1, 257, true)
			DisableControlAction(1, 329, true)
			DisableControlAction(1, 80, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 250, true)
			DisableControlAction(1, 263, true)
			DisableControlAction(1, 310, true)
			--DisableControlAction(0, 288, true) -- interaction menu (F1)

			DisableControlAction(1, 22, true)
			DisableControlAction(1, 55, true)
			DisableControlAction(1, 76, true)
			DisableControlAction(1, 102, true)
			DisableControlAction(1, 114, true)
			DisableControlAction(1, 143, true)
			DisableControlAction(1, 179, true)
			DisableControlAction(1, 193, true)
			DisableControlAction(1, 203, true)
			DisableControlAction(1, 216, true)
			DisableControlAction(1, 255, true)
			DisableControlAction(1, 298, true)
			DisableControlAction(1, 321, true)
			DisableControlAction(1, 328, true)
			DisableControlAction(1, 331, true)
			DisableControlAction(0, 63, false)
			DisableControlAction(0, 64, false)
			DisableControlAction(0, 59, false)
			DisableControlAction(0, 278, false)
			DisableControlAction(0, 279, false)
			DisableControlAction(0, 68, false)
			DisableControlAction(0, 69, false)
			if IsPedInAnyVehicle(playerPed) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed), 0) ~= playerPed then
				DisableControlAction(0, 75, false)
			end
			DisableControlAction(0, 76, false)
			DisableControlAction(0, 102, false)
			DisableControlAction(0, 81, false)
			DisableControlAction(0, 82, false)
			DisableControlAction(0, 83, false)
			DisableControlAction(0, 84, false)
			DisableControlAction(0, 85, false)
			DisableControlAction(0, 86, false)
			DisableControlAction(0, 106, false)
			DisableControlAction(0, 25, false)
			DisableControlAction(0, 19, true)

			-- slow down while cuffed
			--SetEntityVelocity(GetPlayerPed(-1), 0.3, 0.3, 0.0)
			--DisableControlAction(0, 21, true)

			if isHardcuffed then
				DisableControlAction(0, 30, true)
				DisableControlAction(0, 31, true)
				DisableControlAction(0, 44, true)
			end

			if not IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) or IsPedRagdoll(playerPed) then
				RequestAnimDict("mp_arresting")
				while not HasAnimDictLoaded("mp_arresting") do
					Citizen.Wait(100)
				end
				TaskPlayAnim(playerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if not isCuffed and IsControlPressed(0, 19) and IsControlJustPressed(0, 38) and not IsPedRagdoll(ped) and not IsEntityDead(ped) and DoesEntityExist(ped) and not IsPedSittingInAnyVehicle(ped) and not IsPedInMeleeCombat(ped) then
        	TriggerServerEvent('cuff:checkWhitelistForCuff')
        end

        ----------------------
		-- uncuffing circle --
		----------------------
		for i = 1, #uncuff_locations do
			DrawText3D(uncuff_locations[i].x, uncuff_locations[i].y, uncuff_locations[i].z, 10, 'Cuff Saw')
			local playerCoords = GetEntityCoords(ped)
			if Vdist(uncuff_locations[i].x, uncuff_locations[i].y, uncuff_locations[i].z, playerCoords) < 1.0 and isCuffed then
				TriggerEvent("usa:notify", "Cutting off your cuffs! Stay nearby!")
				if math.random() < 0.25 then
					local x, y, z = table.unpack(GetEntityCoords(ped))
					local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
					local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
                    local isMale = true
                    if GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
                      isMale = false
                    elseif GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then 
                      isMale = true
                    else
                      isMale = IsPedMale(ped)
                    end
					TriggerServerEvent('911:CuffCutting', x, y, z, lastStreetNAME, isMale)
				end
				local start = GetGameTimer()
				local uncuff = true
				while GetGameTimer() - start < 180000 do
					DrawTimer(start, 180000, 1.42, 1.475, 'CUTTING')
					playerCoords = GetEntityCoords(ped)
					if Vdist(uncuff_locations[i].x, uncuff_locations[i].y, uncuff_locations[i].z, playerCoords) > 1.0 then
						TriggerEvent("usa:notify", "You went out of range!")
						uncuff = false
						break
					end
					Wait(0)
				end
				if uncuff then
					TriggerEvent("cuff:unCuff")
				end
			end
		end
    end
end)

RegisterNetEvent('cuff:toggleHardcuff')
AddEventHandler('cuff:toggleHardcuff', function(value)
	if isCuffed then
		isHardcuffed = value
	end
end)

RegisterNetEvent("cuff:attemptToCuffNearest")
AddEventHandler("cuff:attemptToCuffNearest", function()
	TriggerEvent("usa:getClosestPlayer", 1.65, function(player)
		if player then
			if tonumber(player.id) ~= 0 then
				local playerPed = PlayerPedId()
				if IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
					local playerCoords = GetEntityCoords(playerPed)
					local playerHeading = GetEntityHeading(playerPed)
					local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.65, -1.0))
					TriggerServerEvent("cuff:Handcuff", player.id, x, y, z, playerHeading)
				end
			else
				TriggerEvent('usa:notify', "No target found to cuff!")
			end
		end
	end)
end)

RegisterNetEvent('cuff:playPoliceAnim')
AddEventHandler('cuff:playPoliceAnim', function(animType)
	if animType == 1 then
		local playerPed = PlayerPedId()
	    RequestAnimDict('mp_arrest_paired')
	    RequestAnimDict('missprologueig_2')
	    while not HasAnimDictLoaded('mp_arrest_paired') do
	        Citizen.Wait(0)
	    end
	    while not HasAnimDictLoaded('missprologueig_2') do
	        Citizen.Wait(0)
	    end
	    FreezeEntityPosition(playerPed, true)
	    ClearPedTasksImmediately(playerPed)
	    TaskPlayAnim(playerPed, "mp_arrest_paired", "cop_p2_back_right", 8.0, 1.0, -1, 6, 0, 0, 0, 0)
	    Citizen.Wait(2000)
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1, 'cuffing', 1.0)
        Citizen.Wait(1600)
	    ClearPedTasks(playerPed)
	    FreezeEntityPosition(playerPed, false)
	elseif animType == 2 then
		local anim = {
			dict = "anim@move_m@trash",
			name = "pickup"
		}
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1, 'cuffing', 1.0)
		TriggerEvent("usa:playAnimation", anim.dict, anim.name, -8, 1, -1, 53, 0, 0, 0, 0, 1.5)
	elseif animType == 3 then
		TriggerEvent("usa:playAnimation", "mp_arresting", "a_uncuff", -8, 1, -1, 53, 0, 0, 0, 0, 1.5)
	end
end)

RegisterNetEvent('cuff:playSuspectAnim')
AddEventHandler('cuff:playSuspectAnim', function(x, y, z, heading)
    local playerPed = PlayerPedId()
    RequestAnimDict('mp_arrest_paired')
    while not HasAnimDictLoaded('mp_arrest_paired') do
        Citizen.Wait(0)
    end
    cuffanimplaying = true
    DisablePlayerFiring(playerPed, true)
    SetEntityCoords(playerPed, x, y, z)
    SetEntityHeading(playerPed, heading)
    Citizen.Wait(100)
    ClearPedTasksImmediately(playerPed)
    FreezeEntityPosition(playerPed, true)
    TaskPlayAnim(playerPed, "mp_arrest_paired", "crook_p2_back_right", 8.0, 1.0, -1, 6, 0, 0, 0, 0)
    Citizen.Wait(3200)
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false)
    DisablePlayerFiring(playerPed, false)
    cuffanimplaying = false
end)

RegisterNetEvent("cuff:unCuff")
AddEventHandler("cuff:unCuff", function(silent)
	local ped = GetPlayerPed(-1)
	ClearPedSecondaryTask(ped)
	SetEnableHandcuffs(ped, false)
	--FreezeEntityPosition(lPed, false)
	if not silent then
		TriggerEvent('usa:showHelp', false, 'You have been ~g~released~s~.')
	end
	isCuffed = false
	if IsPedModel(ped,"mp_m_freemode_01") or IsPedModel(ped,"mp_f_freemode_01") then
		SetPedComponentVariation(ped, 7, 0, 0, 2)
	end
end)

RegisterNetEvent("cuff:Handcuff")
AddEventHandler("cuff:Handcuff", function(arrestingPlayerId, x, y, z, playerHeading)
	TriggerEvent('cuff:forceHandsDown', function()
		local lPed = GetPlayerPed(-1)
		if DoesEntityExist(lPed) then
			Citizen.CreateThread(function()
				
				RequestAnimDict("mp_arresting")
				
				while not HasAnimDictLoaded("mp_arresting") do
					Citizen.Wait(100)
				end

				if isCuffed then
					if arrestingPlayerId then
						TriggerServerEvent("cuff:triggerAnimType", arrestingPlayerId, 3) -- police uncuffing
					end
					Wait(2600)
					ClearPedSecondaryTask(lPed)
					SetEnableHandcuffs(lPed, false)
					TriggerEvent('usa:showHelp', false, 'You have been ~g~released~s~.')
					isCuffed = false
					isHardcuffed = false
					if IsPedModel(lPed,"mp_f_freemode_01") then
		            	SetPedComponentVariation(lPed, 7, prevFemaleVariation, 0, 0)
		        	elseif IsPedModel(lPed, "mp_m_freemode_01") then
		            	SetPedComponentVariation(lPed, 7, prevMaleVariation, 0, 0)
		        	end
				else
					if count >= 3 then						
						while IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arrest_paired", "crook_p2_back_right", 3) or cuffanimplaying or IsPedRagdoll(GetPlayerPed(-1)) do
							Citizen.Wait(5)
						end

						if arrestingPlayerId then
							TriggerServerEvent("cuff:triggerAnimType", arrestingPlayerId, 1) -- police scuffing
						end

						TriggerEvent("cuff:playSuspectAnim", x, y, z, playerHeading)
						CuffPlayer()
					else
						while IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arrest_paired", "crook_p2_back_right", 3) or cuffanimplaying or IsPedRagdoll(GetPlayerPed(-1)) do
							Citizen.Wait(500)
						end
						
						if arrestingPlayerId then
							TriggerServerEvent("cuff:triggerAnimType", arrestingPlayerId, 1) -- police scuffing
						end

						TriggerEvent("cuff:playSuspectAnim", x, y, z, playerHeading)

						if not IsEntityDead(GetPlayerPed(-1)) then
							local success = lib.skillCheck({ {areaSize = 50, speedMultiplier = 1.8}, {areaSize = 40, speedMultiplier = 1.9}, {areaSize = 30, speedMultiplier = 2.0} }, {'w', 'a', 's', 'd', '1', '2', '3'} )
							if success then
								count = count + 1
								isCuffed = false
								isHardcuffed = false
								TriggerEvent('usa:showHelp', false, 'You have ~g~Escaped!')

								local beginTime = GetGameTimer()
								while GetGameTimer() - beginTime < 1800000 do
									Citizen.Wait(0)
								end
								count = 0
							else
								CuffPlayer()
							end
						else
							CuffPlayer()
						end
					end
				end
			end)
		end
	end)
end)

RegisterNetEvent('character:setCharacter')
AddEventHandler('character:setCharacter', function()
	local lPed = PlayerPedId()
    ClearPedSecondaryTask(lPed)
	SetEnableHandcuffs(lPed, false)
	isCuffed = false
	if IsPedModel(lPed,"mp_m_freemode_01") or IsPedModel(lPed,"mp_f_freemode_01") then
		SetPedComponentVariation(lPed, 7, 0, 0, 2)
	end
end)

function CuffPlayer()
	count = 0
	isCuffed = true
	isHardcuffed = false

	TaskPlayAnim(lPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
	SetEnableHandcuffs(lPed, true)
	SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
	TriggerEvent('usa:showHelp', false, 'You have been ~r~detained~s~.')
	
	if IsPedModel(lPed,"mp_f_freemode_01") then
		prevFemaleVariation = GetPedDrawableVariation(lPed, 7)
		SetPedComponentVariation(lPed, 7, 23, 0, 0)
	elseif IsPedModel(lPed,"mp_m_freemode_01") then
		prevMaleVariation = GetPedDrawableVariation(lPed, 7)
		SetPedComponentVariation(lPed, 7, 34, 0, 0)
	end
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
    if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) < distance then
        local onScreen,_x,_y=World3dToScreen2d(x,y,z)
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 470
        DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
    end
end
