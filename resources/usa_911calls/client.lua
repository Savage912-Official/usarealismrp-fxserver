local mute911 = false
local ReportAssault = false
local ReportShotsFired = true
local ReportCarjacking = true
local ReportPersonWithAGun = false
local ReportPersonWithAKnife = false
local ReportRecklessDriving = false
local ReportVehicleTheft = false
local ReportExplosion = true
local ReportMVA = false
local oldBodyDamage = 0
local oldSpeed = 0
local onDuty = false

local MAX_REPORT_DISTANCE = 250

local exempt_locations = {
	vector3(151.39, -1007.74, -99.0),
	vector3(266.14, -1007.61, -101.00),
	vector3(346.47, -1013.05, -99.19),
	vector3(-781.77, 322.00, 211.99),
	vector3(-1270.729, -3396.421, 13.94016)
}

local prohibitedWeapons = {}
prohibitedWeapons["shotsFired"] = {}
prohibitedWeapons["shotsFired"][`WEAPON_SNOWBALL`] = true
prohibitedWeapons["shotsFired"][`WEAPON_STUNGUN`] = true
prohibitedWeapons["shotsFired"][101631238] = true
prohibitedWeapons["shotsFired"][911657153] = true
prohibitedWeapons["shotsFired"][883325847] = true
prohibitedWeapons["shotsFired"][883325847] = true
prohibitedWeapons["shotsFired"][`WEAPON_PLASMAP`] = true
prohibitedWeapons["shotsFired"][`WEAPON_FLASHBANG`] = true
prohibitedWeapons["shotsFired"][`WEAPON_ROCK`] = true
prohibitedWeapons["shotsFired"][`WEAPON_BRICK`] = true
prohibitedWeapons["shotsFired"][`WEAPON_THROWINGKNIFE`] = true
prohibitedWeapons["shotsFired"][`WEAPON_NINJASTAR`] = true
prohibitedWeapons["shotsFired"][`WEAPON_NINJASTAR2`] = true
prohibitedWeapons["shotsFired"][`WEAPON_THROWINGSHOEBLACK`] = true
prohibitedWeapons["shotsFired"][`WEAPON_THROWINGSHOEBLUE`] = true
prohibitedWeapons["shotsFired"][`WEAPON_THROWINGSHOERED`] = true
prohibitedWeapons["shotsFired"][`WEAPON_NOELLAUNCHER`] = true
prohibitedWeapons["shotsFired"][`WEAPON_OLAFMINIGUN`] = true

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, false)
		local currentDamage = GetVehicleBodyHealth(vehicle)
		local isPopulatedArea = IsAreaPopulated()
		local vehClass = GetVehicleClass(vehicle)
		if not onDuty then
			if ReportCarjacking and IsPedJacking(ped) and isPopulatedArea and GetPedInVehicleSeat(veh, -1) == playerPed then
				local x, y, z = table.unpack(GetEntityCoords(ped))
				local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
				local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
				local primary, secondary = GetVehicleColours(vehicle)
                local isMale = isPlayerModelMale()
				TriggerServerEvent('911:Carjacking', x, y, z, lastStreetNAME, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))), exports.globals:trim(GetVehicleNumberPlateText(vehicle)), isMale, primary, secondary)
				Citizen.Wait(500)
			elseif ReportPersonWithAGun and IsPedArmed(ped, 6) and isPopulatedArea and not IsPedInAnyVehicle(ped) then
				local x, y, z = table.unpack(GetEntityCoords(ped))
				local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
				local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
				local area = GetNameOfZone(x, y, z)
				if math.random() < 0.05 then
					local report = true
					for i = 1, #exempt_locations do
						if Vdist(x, y, z, exempt_locations[i]) < 40.0 then
							report = false
						end
					end
					if report and isNearAnyPeds() then
							local isMale = isPlayerModelMale()
							TriggerServerEvent('911:PersonWithAGun', x, y, z, lastStreetNAME, area, isMale)
					end
				end
				Citizen.Wait(500)
			elseif ReportPersonWithAKnife and IsPedArmed(ped, 1) and isPopulatedArea then
				local x, y, z = table.unpack(GetEntityCoords(ped))
				local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
				local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
				local area = GetNameOfZone(x, y, z)
				local selectedPedWep = GetSelectedPedWeapon(ped)
				if (selectedPedWep == -1716189206 or selectedPedWep == -1834847097 or selectedPedWep == -581044007 or selectedPedWep == -538741184) and math.random() < 0.08 then
					local report = true
					for i = 1, #exempt_locations do
						if Vdist(x, y, z, exempt_locations[i]) < 40.0 then
							report = false
						end
					end
					if report and isNearAnyPeds() then
						local isMale = isPlayerModelMale()
						TriggerServerEvent('911:PersonWithAKnife', x, y, z, lastStreetNAME, area, isMale)
					end
				end
				Citizen.Wait(500)
			elseif ReportAssault and IsPedInMeleeCombat(ped) and isPopulatedArea then
				local x, y, z = table.unpack(GetEntityCoords(ped))
				local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
				local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
				local area = GetNameOfZone(x, y, z)
				if math.random() < 0.2 then
					local isMale = isPlayerModelMale()
					TriggerServerEvent('911:AssaultInProgress', x, y, z, lastStreetNAME, area, isMale)
				end
				Citizen.Wait(500)
			elseif ReportRecklessDriving and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped and GetEntitySpeed(vehicle)*2.236936 > 120 and isPopulatedArea and vehClass ~= 14 and vehClass ~= 15 and vehClass ~= 16 and vehClass ~= 19 then
				local x, y, z = table.unpack(GetEntityCoords(ped))
				local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
				local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
				local primary, secondary = GetVehicleColours(GetVehiclePedIsUsing(ped))
				local area = GetNameOfZone(x, y, z)
				local plate = string.sub(GetVehicleNumberPlateText(vehicle), 1, 4)
				plate = exports.globals:trim(plate)
				if math.random() < 0.2 then
					local isMale = isPlayerModelMale()
					TriggerServerEvent('911:RecklessDriving', x, y, z, lastStreetNAME, area, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(ped)))), plate, isMale, primary, secondary)
				end
				Citizen.Wait(5000)
			elseif ReportVehicleTheft and IsPedInAnyVehicle(ped, false) and IsVehicleNeedsToBeHotwired(vehicle) and isPopulatedArea and GetPedInVehicleSeat(veh, -1) == playerPed then
				local x, y, z = table.unpack(GetEntityCoords(ped))
				local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
				local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
				local primary, secondary = GetVehicleColours(vehicle)
				local isMale = isPlayerModelMale()
				TriggerServerEvent('911:VehicleTheft', x, y, z, lastStreetNAME, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))), exports.globals:trim(GetVehicleNumberPlateText(vehicle)), isMale, primary, secondary)
				Citizen.Wait(500)
			elseif ReportMVA and DoesEntityExist(vehicle) and isPopulatedArea and vehClass ~= 14 and vehClass ~= 15 and vehClass ~= 16 and vehClass ~= 19 then
				local currentDamage = GetVehicleBodyHealth(vehicle)
				if currentDamage ~= oldBodyDamage then
					if (currentDamage < oldBodyDamage) and (oldBodyDamage - currentDamage) >= 5 then
						local x, y, z = table.unpack(GetEntityCoords(ped))
						local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
						local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
						local primary, secondary = GetVehicleColours(vehicle)
						local area = GetNameOfZone(x, y, z)
						local isMale = isPlayerModelMale()
						TriggerServerEvent('911:MVA', x, y, z, lastStreetNAME, area, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))), exports.globals:trim(GetVehicleNumberPlateText(vehicle)), isMale, primary, secondary)
						Citizen.Wait(500)
					end
					oldBodyDamage = currentDamage
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if not onDuty then
			local selectedPedWeapon = GetSelectedPedWeapon(ped)
			if ReportShotsFired and IsPedShooting(ped) and not prohibitedWeapons["shotsFired"][selectedPedWeapon] then
				local x, y, z = table.unpack(GetEntityCoords(ped))
				local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
				local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
				local area = GetNameOfZone(x, y, z)
				local report = true

				for i = 1, #exempt_locations do
				if Vdist(x, y, z, exempt_locations[i]) < 40.0 then
					report = false
				end
			end
			if report and isNearAnyPeds() then
				local isMale = isPlayerModelMale()
				TriggerServerEvent('911:ShotsFired', x, y, z, lastStreetNAME, area, isMale)
			end
			Citizen.Wait(500)
			end
		end
	end
end)

RegisterNetEvent('911:mute911') -- pauses receiving local 911 calls
AddEventHandler('911:mute911', function()
	mute911 = not mute911
	if mute911 then
		ShowNotification('Emergency calls have been ~r~muted~s~.')
		Citizen.Wait(10000)
		while mute911 do
			Citizen.Wait(1000)
			ShowNotification('Emergency calls are ~r~muted~s~!')
		end
	else
		ShowNotification('Emergency calls have been ~g~unmuted~s~.')
	end
end)

RegisterNetEvent('911:clear911') -- clears all blips for player
AddEventHandler('911:clear911', function()
	for i = #blips, 1, -1 do
		RemoveBlip(blips[i].handle)
        table.remove(blips, i)
	end
	ShowNotification('Call blips have been cleared.')
end)

RegisterNetEvent('911:mark911') -- marks latest 911 call's blip
AddEventHandler('911:mark911', function()
	blipCoords = GetBlipCoords(blips[#blips].handle)
	SetNewWaypoint(blipCoords)
	ShowNotification('Latest call has been marked as waypoint.')
end)

-- automatically remove all call blips you are closest too --
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		pedCoords = GetEntityCoords(PlayerPedId())
		for i = #blips, 1, -1 do
			blipCoords = GetBlipCoords(blips[i].handle)
			if GetDistanceBetweenCoords(pedCoords, blipCoords, false) < 20.0 then
				--print('removing closest call blip')
				Citizen.Wait(3000)
				RemoveBlip(blips[i].handle)
                table.remove(blips, i)
			end
		end
	end
end)

-- check for blip time expire --
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for i = #blips, 1, -1 do
            if GetGameTimer() - blips[i].created_at > 120000 then
                RemoveBlip(blips[i].handle)
                table.remove(blips, i)
            end
        end
    end
end)


blips = {}

RegisterNetEvent('911:Notification')
AddEventHandler('911:Notification', function(string, x, y, z, blipText)
	if not mute911 then
        local newBlip = {
            handle = nil,
            created_at = nil
        }
		TriggerEvent("chatMessage", "", { 0, 0, 0 }, "^1^*[911] ^r^7"..string)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'demo', 0.1)
		newBlip.handle = AddBlipForCoord(x, y, z)
		SetBlipSprite(newBlip.handle, 304)
		SetBlipDisplay(newBlip.handle, 2)
		SetBlipScale(newBlip.handle, 1.2)
		SetBlipColour(newBlip.handle, 29)
		SetBlipAsShortRange(newBlip.handle, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(blipText)
		EndTextCommandSetBlipName(newBlip.handle)
        newBlip.created_at = GetGameTimer()
        table.insert(blips, newBlip)
	end
end)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function IsAreaPopulated()
	local AREAS = {
		{x = 1491.839, y = 3112.53, z = 40.656, range = 330}, -- sandy shores airport area // 75 - 150 probably range
		{x = 151.62, y = 1038.808, z = 32.735, range = 1200}, -- los santos // 600 - 900 ish?
		{x = -3161.96, y = 790.088, z = 6.824, range = 650}, -- west coast, NW of los santos // 300 - 400 ish?
		{x = 2356.744, y = 4776.75, z = 34.613, range = 600}, -- grape seed // 350 - 450 ish?
		{x = 145.209, y = 6304.922, z = 40.277, range = 650}, -- paleto bay // 500 - 600
		{x = -1070.5, y = 5323.5, z = 46.339, range = 700}, -- S of Paleto Bay // 350 - 500 ish
		{x = -2550.21, y = 2321.747, z = 33.059, range = 350}, -- west of map, gas station // 100 - 200
		{x = 1927.374, y = 3765.77, z = 32.309, range = 350}, -- sandy shores
		{x = 895.649, y = 2697.049, z = 41.985, range = 200}, -- harmony
		{x = -1093.773, y = -2970.00, z = 13.944, range = 300}, -- LS airport
		{x = 1070.506, y = -3111.021, z = 5.9, range = 450} -- LS ship cargo area
	}
	local my_coords = GetEntityCoords(me, true)
	for k = 1, #AREAS do
		if Vdist(my_coords.x, my_coords.y, my_coords.z, AREAS[k].x, AREAS[k].y, AREAS[k].z) <= AREAS[k].range then
			--print("within range of populated area!")
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
    local dict = "missminuteman_1ig_2"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    local handsup = false
    while true do
        Citizen.Wait(0)
        local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId())
        if aiming then

            local playerPed = PlayerPedId()
            local pCoords = GetEntityCoords(playerPed, true)
            local tCoords = GetEntityCoords(targetPed, true)
            local veh = GetVehiclePedIsIn(targetPed, false)

            -- Citizen.Trace('Aiming')
            if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) and not IsEntityDead(targetPed) and not IsPedInAnyVehicle(playerPed, false) then
            -- Citizen.Trace('Exists')
                if IsPedInAnyVehicle(targetPed, false) and not IsPedAPlayer(targetPed) and IsPedArmed(playerPed, 4) then
                    if Vdist(pCoords, tCoords) < 6 then
                        ShowHelp('Hold ~INPUT_PICKUP~ to intimidate the driver', 1)
                        if IsControlJustPressed(0, 38) then

                        	local primary, secondary = GetVehicleColours(veh)
                            lastStreetHASH = GetStreetNameAtCoord(pCoords.x, pCoords.y, pCoords.z)
                            lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
		                    local isMale = true
		                    if GetEntityModel(playerPed) == GetHashKey("mp_f_freemode_01") then
		                      isMale = false
		                    elseif GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01") then 
		                      isMale = true
		                    else
		                      isMale = IsPedMale(playerPed)
		                    end
                            TriggerServerEvent('911:ArmedCarjacking', pCoords.x, pCoords.y, pCoords.z, lastStreetNAME, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))), exports.globals:trim(GetVehicleNumberPlateText(veh)), isMale, primary, secondary)

                        	local intimidated = true
                        	local beginTime = GetGameTimer()
                        	while GetGameTimer() - beginTime < 10000 do
                        		Citizen.Wait(0)
                        		pCoords = GetEntityCoords(playerPed, true)
            					tCoords = GetEntityCoords(targetPed, true)
                        		if IsControlPressed(0, 38) and Vdist(pCoords, tCoords) < 6 and IsPlayerFreeAiming(PlayerId()) then
                        			DrawTimer(beginTime, 10000, 1.42, 1.475, 'INTIMIDATING')
                        		else
                        			intimidated = false
                        			break
                        		end
                        	end
                        	if intimidated then
	                            TriggerEvent('usa:notify', 'The driver has handed over the keys.')
	                            local vehicle_key = {
									name = "Key -- " .. GetVehicleNumberPlateText(veh),
									quantity = 1,
									type = "key",
									owner = "Unknown",
									make = "Unknown",
									model = "Unknown",
									plate = GetVehicleNumberPlateText(veh)
								}

								TriggerServerEvent("garage:giveKey", vehicle_key)
								TriggerServerEvent('mdt:addTempVehicle', GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))), 'Unknown', GetVehicleNumberPlateText(veh), true)
	                            TaskLeaveVehicle(targetPed, veh, 256)
	                            SetVehicleEngineOn(veh, false, true, false)
	                            SetVehicleDoorsLocked(veh, 1)
	                            Citizen.Wait(1500)
	                            ClearPedTasksImmediately(targetPed)
	                            TriggerServerEvent('carjack:playHandsUpOnAll', PedToNet(targetPed))
	                            TaskPlayAnim(targetPed, dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
	                            TaskTurnPedToFaceEntity(targetPed, playerPed, 1)
	                            Citizen.Wait(100)
	                            TaskStandStill(targetPed, 15000)
	                            Citizen.Wait(15000)
	                            ClearPedTasks(targetPed)
	                        end
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('carjack:playAnimOnPed')
AddEventHandler('carjack:playAnimOnPed', function(ped)
	local ped = NetToPed(ped)
	local dict = "missminuteman_1ig_2"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
	TaskPlayAnim(ped, dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
end)

RegisterNetEvent('interaction:setPlayersJob')
AddEventHandler('interaction:setPlayersJob', function(job)
	if job == 'sheriff' or job == 'ems' or job == 'fire' or job == 'police' or job == 'corrections' then
		onDuty = true
		RespectPedRelations(true)
	else
		onDuty = false
		RespectPedRelations(false)
	end
end)

function ShowHelp(text, bleep)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, bleep, -1)
end

-- checks if the provided ped handle is the ped for an actual player
function isPedAPlayerPed(ped)
	local i = NetworkGetPlayerIndexFromPed(ped)
	if index ~= -1 then
		return NetworkIsPlayerActive(i)
	else
		return false
	end
end

function isNearAnyPeds()
	local myPed = PlayerPedId()
	local playerCoords = GetEntityCoords(myPed)

	for otherPed in exports.globals:EnumeratePeds() do
		local pedCoords = GetEntityCoords(otherPed)
		local distanceBetweenNpcAndPed = Vdist(pedCoords, playerCoords)

		if DoesEntityExist(otherPed) then
			if distanceBetweenNpcAndPed < MAX_REPORT_DISTANCE and otherPed ~= myPed and IsPedHuman(otherPed) and not isPedAPlayerPed(otherPed) then
				return true
			end
		end
	end
end

function RespectPedRelations(boolean)
	if boolean then -- AI will respect the emergency worker when on-duty
		SetRelationshipBetweenGroups(1, GetHashKey("PRISONER"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("GUARD_DOG"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("ARMY"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("SECURITY_GUARD"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("CIVMALE"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("CIVFEMALE"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))
	else -- AI will be neutral once emergency worker is off-duty
		SetRelationshipBetweenGroups(3, GetHashKey("PRISONER"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("GUARD_DOG"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("ARMY"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("SECURITY_GUARD"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("CIVMALE"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("CIVFEMALE"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
		SetRelationshipBetweenGroups(3, GetHashKey("COP"), GetHashKey('PLAYER'))
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

function isPlayerModelMale()
	local isMale = true
	local playerPedModel = GetEntityModel(PlayerPedId())
	if playerPedModel == GetHashKey("mp_f_freemode_01") then
		isMale = false
	elseif playerPedModel == GetHashKey("mp_m_freemode_01") then 
		isMale = true
	else
		isMale = IsPedMale(ped)
	end
	return isMale
end