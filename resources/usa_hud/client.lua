SetFollowPedCamViewMode(0)
SetFollowVehicleCamViewMode(0)
RegisterNetEvent('usa:toggleImmersion')

local hud = {
		direction = 'N/A',
		time = 'N/A',
		street1 = 'N/A',
		zone = 'N/A',
		engineColor = '~r~',
		belt = 'BELT',
		beltColor = '~r~',
		maxSpeed = false,
		maxSpeedVehicle = nil,
		enabled = true,
		radar = {
			foot = Config.Defaults.Radar.foot,
			veh = Config.Defaults.Radar.veh
		}
	}

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local directions = { [0] = 'N', [45] = 'NE', [90] = 'E', [135] = 'SE', [180] = 'S', [225] = 'SW', [270] = 'W', [315] = 'NW', [360] = 'N', }

RegisterNetEvent('hud:setBelt')
AddEventHandler('hud:setBelt', function(bool)
	if bool then
		hud.beltColor = '~g~'
	else
		hud.beltColor = '~r~'
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local playerPed = PlayerPedId()
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		-- direction --
		for k,v in pairs(directions) do
			--direction = GetEntityHeading(playerPed)
			local camRot = GetGameplayCamRot(0)
			direction = 360.0 - ((camRot.z + 360.0) % 360.0) -- not sure where how this equation is derived exactly or where it's from but I found it here: https://gitlab.com/MsQuerade/Compass-and-street-name-HUD/-/blob/master/compass.lua
			if math.abs(direction - k) < 22.5 then
				hud.direction = v
				break;
			end
		end
		-- engine/belt status --
		if playerVeh and (GetPedInVehicleSeat(playerVeh, -1) == playerPed or GetPedInVehicleSeat(playerVeh, 0) == playerPed) then
			-- DrawRect(0.179, 0.970, 0.035, 0.030, 0, 0, 0, 70) no need (more lag)
			current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
			var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
			if GetIsVehicleEngineRunning(playerVeh) then
				if GetVehicleEngineHealth(playerVeh) < 600 then
					hud.engineColor = '~o~'
				else
					hud.engineColor = '~g~'
				end
			else
				hud.engineColor = '~r~'
			end
			if IsPedInAnyVehicle(playerPed) and IsBeltVehicle(playerVeh) then
				hud.belt = 'BELT'
			else
				hud.belt = ''
			end
		else
			hud.beltColor = '~r~'
		end
		hud.time = CalculateTimeToDisplay()
		hud.street1 = GetStreetNameFromHashKey(var1)
		hud.street2 = GetStreetNameFromHashKey(var2)
		current_zone = GetNameOfZone(pos.x, pos.y, pos.z)
		hud.zone = zones[current_zone]
		if hud.zone == nil then
			hud.zone = 'San Andreas'
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
		if hud.enabled then
			if playerVeh ~= 0 and GetVehicleClass(playerVeh) ~= 13 and GetVehicleClass(playerVeh) ~= 21 then
				local streets = hud.street1
				if hud.street2 and hud.street2 ~= "" then
					streets = streets .. " & " .. hud.street2
				end
				if GetPedInVehicleSeat(playerVeh, -1) == playerPed then
					DrawTxt(0.663, 1.450, 1.0, 1.0, 0.40, hud.direction .. " | " .. streets .. " | " .. hud.zone , 255, 255, 255, 255)
					DrawTxt(0.663, 1.395, 1.0, 1.0, 0.40, hud.time, 255, 255, 255, 255)
					DrawTxt(0.663, 1.418, 1.0, 1.0, 0.55, math.floor(GetEntitySpeed(playerVeh)*2.236936, 0) .. '', 255, 255, 255, 255)
					DrawTxt(0.684, 1.425, 1.0, 1.0, 0.35, 'mph', 255, 255, 255, 255)
					DrawTxt(0.750, 1.424, 1.0, 1.0, 0.38, hud.engineColor..'ENGINE', 255, 255, 255, 255)
					DrawTxt(0.780, 1.424, 1.0, 1.0, 0.38, hud.beltColor..hud.belt, 255, 255, 255, 255)
				elseif GetPedInVehicleSeat(playerVeh, 0) == playerPed then
					DrawTxt(0.663, 1.450, 1.0, 1.0, 0.40, hud.direction .. " | " .. streets .. " | " .. hud.zone , 255, 255, 255, 255)
					DrawTxt(0.663, 1.395, 1.0, 1.0, 0.40, hud.time, 255, 255, 255, 255)
					DrawTxt(0.663, 1.418, 1.0, 1.0, 0.55, math.floor(GetEntitySpeed(playerVeh)*2.236936, 0) .. '', 255, 255, 255, 255)
					DrawTxt(0.684, 1.425, 1.0, 1.0, 0.35, 'mph', 255, 255, 255, 255)
					DrawTxt(0.708, 1.424, 1.0, 1.0, 0.38, hud.engineColor..'ENGINE', 255, 255, 255, 255)
					DrawTxt(0.738, 1.424, 1.0, 1.0, 0.38, hud.beltColor..hud.belt, 255, 255, 255, 255)
				else
					DrawTxt(0.663, 1.455, 1.0, 1.0, 0.40, hud.time, 255, 255, 255, 255)
				end
				DisplayRadar(hud.radar.veh)
			else -- on foot
				DisplayRadar(hud.radar.foot)
				DrawRect(0.08555, 0.976, 0.14, 0.0149999999999998, 0, 0, 0, 140)
				DrawTxt(0.664, 1.455, 1.0, 1.0, 0.40, hud.time, 255, 255, 255, 255)
				DrawTxt(0.737, 1.455, 1.0, 1.0, 0.37, hud.direction , 255, 255, 255, 255)
			end
			-- HEALTH
			local Health = GetEntityHealth(playerPed)

			Health = ((Health-100) / 100) * 0.070

			if Health <= 0.0007 then
				r, b, g = table.unpack({ 165, 34, 34 })
				Health = 0.0;
			elseif Health >= 0.0175 then
				r, b, g = table.unpack({ 80, 146, 78 })
			else
				r, b, g = table.unpack({ 165, 34, 34 })
			end

			DrawRect(0.0155 + (Health / 2), 0.9755, Health, 0.00833, r, b, g, 230)
			DrawRect(0.0504, 0.9755, 0.07, 0.00833, r, b, g, 130)

			-- ARMOR
			local Armour = GetPedArmour(playerPed)

			Armour = (Armour / 100) * 0.069

			DrawRect(0.0866+(Armour/2), 0.9755, Armour, 0.00833, 80, 150, 191, 230)
			DrawRect(0.1214, 0.9755, 0.07, 0.00833, 80, 150, 191, 130)
		else
			if hud.immersion then
				DisplayRadar(false)
				DrawRect(0.5, 1.0, 1.0, 0.2, 0, 0, 0, 255)
				DrawRect(0.5, 0.0, 1.0, 0.2, 0, 0, 0, 255)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if vehicle and GetPedInVehicleSeat(vehicle, -1) == playerPed and GetVehicleClass(vehicle) ~= 13 and GetVehicleClass(vehicle) ~= 21 then
			if hud.maxSpeed and hud.maxSpeedVehicle == vehicle and hud.enabled then
				DrawTxt(0.663, 1.370, 1.0, 1.0, 0.40, "Cruise: "..hud.maxSpeed.. ' mph', 255, 255, 255, 255)
			end

			if IsControlJustPressed(0, 20) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
				if not hud.maxSpeed then
					if (GetEntitySpeed(vehicle) * 2.236936) >= 5 then
						PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						local maxSpeed = GetEntitySpeed(vehicle)
						SetEntityMaxSpeed(vehicle, maxSpeed)
						hud.maxSpeed = math.floor(maxSpeed * 2.236936)
						hud.maxSpeedVehicle = vehicle
					else
						TriggerEvent('usa:notify', 'Must be over ~y~0 mph~s~!')
					end
				else
					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
					local maxSpeed = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
					SetEntityMaxSpeed(vehicle, maxSpeed)
					hud.maxSpeedVehicle = nil
					hud.maxSpeed = false
				end
			end
		end
		if IsDisabledControlJustPressed(1, 166) then
			SetFlash(0, 0, 100, 100, 100)
			Citizen.Wait(100)
			hud.enabled = not hud.enabled
			hud.immersion = not hud.immersion
			TriggerEvent('usa:toggleImmersion', hud.enabled)
			PlaySoundFrontend(-1, 'FocusIn', 'HintCamSounds', 1)
		end
	end
end)

RegisterNetEvent('usa:toggleHUD')
AddEventHandler('usa:toggleHUD', function(enabled)
	hud.enabled = enabled
	TriggerEvent('usa:toggleImmersion', hud.enabled)
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

function CalculateTimeToDisplay()
	local hours = GetClockHours()
	local minutes = GetClockMinutes()
	local suffix = "AM"
	if hours == 12 then
		suffix = "PM"
	elseif hours > 12 then
		hours = hours - 12
		suffix = "PM"
	elseif hours == 0 then
		hours = 12
	end
	local display_time = string.format("%d:%02d %s", hours, minutes, suffix)
	return display_time
end

function IsBeltVehicle(vehicle)
	if GetVehicleClass(vehicle) ~= 8
	and GetVehicleClass(vehicle) ~= 13
	and GetVehicleClass(vehicle) ~= 14
	and GetVehicleClass(vehicle) ~= 16
	and GetVehicleClass(vehicle) ~= 19 then
		return true
	else
		return false
	end
end

RegisterNetEvent("usa_hud:ToggleMinimap") 
AddEventHandler("usa_hud:ToggleMinimap", function(mapType, status)
	hud.radar[mapType] = status
	exports.globals:notify(mapType .. " map: " .. tostring(status))
end)

Citizen.CreateThread(function()
	local hudSettings = TriggerServerCallback { 
		eventName = "usa_hud:GetMapSettings",
		args = {}
	}
	if hudSettings then
		if hudSettings.foot ~= nil then
			hud.radar.foot = hudSettings.foot
		end
		if hudSettings.veh ~= nil then
			hud.radar.veh = hudSettings.veh
		end
	end
end)