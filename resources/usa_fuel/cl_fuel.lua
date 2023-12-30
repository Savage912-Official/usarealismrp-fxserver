local playerPed
local playerVeh
local interactionKey = 38

local fuelStations = {
	['Aircraft'] = {
		price = 25,
		locations = {
			{-1007.71, -3015.91, 14.94},
			{-1229.56, -2877.206, 15.94},
			{2103.68, 4787.89, 42.21},
			{1699.52, 3271.27, 42.13},
			{1769.85, 3239.59, 43.12},
			{-475.08, 5988.36, 31.34}, -- Paleto Sheriff Department
			{1834.73, 2501.94, 47.61}, -- Prison
			{449.48, -981.07, 44.69}, -- MISSION ROW
			{351.42, -588.21, 75.16}, -- PILLBOX MEDICAL
			{-791.0382, -1191.6010, 53.0270}, -- VICEROY MEDICAL
			{-1513.0, -67.61, 56.57}, -- Reapers House
			{-33.22, 768.99, 223.42}, -- Scott Johnson
			{-1023.3225097656, 173.47639465332, 63.475910186768}, -- Josef
			{4436.0966796875, -4494.8461914062, 3.6910808086395},
			{-252.3193, 6319.0859, 39.6596}, -- paleto clinic
			{-705.84326171875, -1464.5919189453, 5.0427398681641}, -- Shank St & Greenwhich Prkwy Pump 1
			{-764.34759521484, -1434.9971923828, 5.0576033592224}, -- Shank St & Greenwhich Prkwy Pump 2
			{-1095.5939, -835.6335, 37.6946, 335.3011} -- vespucci PD
		}
	},
	['Watercraft'] = {
		price = 10,
		locations = {
			{7.10, -2775.74, 1.85},
			{1327.06, 4217.90, 33.60},
			{-487.81, 6491.39, 1.40},
			{-802.50, -1504.67, 2.35}
		}
	},
	['Gasoline'] = {
		price = 5,
		locations = {
			{-94.136, 6419.508, 32.48}, -- Paleto Blvd.
			{179.96, 6602.94, 32.86}, -- Paleto Bay, LSC.
			{1702.92, 6415.82, 33.76}, -- Paleto Bay, 24/7 Store
			{1687.17, 4929.64, 43.07}, -- Grapeseed, LTD Store
			{2005.161, 3774.207, 33.40}, -- Sandy Shores, 24/7 Store
			{2680.207, 3264.007, 56.24}, -- Senora Fwy, 24/7 Store
			{1039.08, 2671.26, 40.55}, -- Route 68, Motel
			{49.71, 2779.207, 59.04}, -- Harmony, Route 68
			{-2554.91, 2334.65, 34.07}, -- Zancudo, Route 68
			{2581.49, 361.78, 109.46}, -- Los Santos Fwy
			{620.88, 268.87, 104.08}, -- Downtown Vinewood
			{-1798.91, 802.53, 139.65}, -- Richman Glen
			{-2096.703, -321.65, 14.16}, -- Del Perro Fwy
			{-1437.31, -276.24, 47.20}, -- Morningwood
			{1181.87, -330.27, 70.31}, -- Mirror Park, LTD Store
			{-724.74, -934.66, 20.21}, -- Lindsay Circus, Ginger St.
			{-526.28, -1210.95, 19.18}, -- Calais Ave, Innocence Blvd.
			{264.93, -1262.58, 30.29}, -- Stawberry Ave, Olympic Fwy
			{-70.44, -1760.49, 30.53}, -- Grove St., LTD Store
			{1208.34, -1402.18, 36.22}, -- Capital Blvd, El Rancho Blvd.
			{819.09, -1029.48, 27.404}, -- Popular St, Olympic Fwy
			{172.5049, -1558.8756, 29.2453}, --McDonald Street, Davies Pump 1
			{178.2956, -1565.0645, 29.2806}, --McDonald Street, Davies Pump 2
			{-66.431640625, -2532.1586914063, 6.1358127593994}, -- Chupacabra Street (LS Docks)
			{1785.6441650391, 3330.4682617188, 41.384426116943}, -- Panorama
			{264.04702758789, 2606.9008789063, 45.130905151367}, -- Route 68 Corner Gas
			{1207.8255615234, 2660.1887207031, 37.899787902832}, -- Route 68 LS Customs
			{2539.2724609375, 2594.6376953125, 37.944869995117}, -- Senora Way (Purple Dinosaur)
			--{809.95086669922, -790.09808349609, 26.202123641968}, -- Otto's Repair Gas Thingy
			{-319.73480224609, -1471.4656982422, 30.548534393311} -- Alta St / Innocence Blvd
		}
	}
}

local fuelData = {
	fuelAmount = 50,
	fuelUsage = 0.0,
	lastVeh = nil,
	isRefuelling = false,
	displayFuel = false
}

exports("getFuelLevel", function()
	return fuelData.fuelAmount
end)

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Fuel Station", "~b~Welcome!", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(mainMenu)

function createGasolineMenu(vehicleType)
	mainMenu:Clear()
	local jerryCanBtn = NativeUI.CreateItem('Purchase Jerry Can', 'Portable fuel that fills up the tank!')
	mainMenu:AddItem(jerryCanBtn)
	jerryCanBtn.Activated = function(parentmenu, selected)
		TriggerServerEvent('fuel:purchaseJerryCan')
	end
	if vehicleType then
		local amountToRefuel
		local litersToRefuel = {}
		for i = 1, 100 - (math.floor(fuelData.fuelAmount)) do
			table.insert(litersToRefuel, i)
		end
		local amountItem = UIMenuListItem.New('Gallons', litersToRefuel, 'Amount of fuel to purchase')
		mainMenu:AddItem(amountItem)
		mainMenu.OnListChange = function(sender, item, index)
			if item == amountItem then
				amountToRefuel = item:IndexToItem(index)
			end
		end
		local purchaseItem = NativeUI.CreateItem('Purchase Fuel', '')
		mainMenu:AddItem(purchaseItem)
		purchaseItem.Activated = function(parentmenu, selected)
			if not GetIsVehicleEngineRunning(playerVeh) then
				TriggerServerEvent('fuel:purchaseFuel', amountToRefuel, vehicleType)
				mainMenu:Visible(false)
			else
				TriggerEvent('usa:notify', '~y~Vehicle engine must be off!')
			end
		end
	end
end

local nearbyFuelStations = {
	Aircraft = {},
	Watercraft = {},
	Gasoline = {}
}

-- thread to record nearby stations as an otimization
Citizen.CreateThread(function()
	while true do
		for type, v in pairs(fuelStations) do
			for i = 1, #fuelStations[type].locations do
				local x, y, z = table.unpack(fuelStations[type].locations[i])
				if Vdist(GetEntityCoords(playerPed), x, y, z) < 5.5 then
					nearbyFuelStations[type][i] = true
				else
					nearbyFuelStations[type][i] = nil
				end
			end
		end
		Wait(1000)
	end
end)

-- Main thread for displaying fuel, managing menu and updating global variables
Citizen.CreateThread(function()
	local wasInVeh = false
	while true do
		Wait(1)
		playerPed = PlayerPedId()
		playerVeh = GetVehiclePedIsIn(playerPed, true)
		if _menuPool:IsAnyMenuOpen() then
			_menuPool:MouseControlsEnabled(false)
			_menuPool:ControlDisablingEnabled(false)
			_menuPool:ProcessMenus()
		end
		for k, v in pairs(nearbyFuelStations) do
			for i, isNearby in pairs(nearbyFuelStations[k]) do
				local x, y, z = table.unpack(fuelStations[k].locations[i])
				DrawText3D(x, y, z, '[E] - Fuel Station')
			end
		end
		if mainMenu:Visible() and not IsNearFuelStation(GetVehicleType(playerVeh)) then
			mainMenu:Visible(false)
		end
		if IsControlJustPressed(0, interactionKey) then
			if IsNearFuelStation(GetVehicleType(playerVeh)) then
				if GetPedInVehicleSeat(playerVeh, -1) == playerPed then -- in veh
					if fuelData.fuelAmount < 100 and GetVehicleType(playerVeh) ~= 'Blacklisted' and not fuelData.isRefuelling then
						createGasolineMenu(GetVehicleType(playerVeh))
						mainMenu:Visible(not mainMenu:Visible())
					else
						TriggerEvent('usa:notify', '~y~This vehicle cannot be refuelled!')
					end
				else -- on foot
					createGasolineMenu()
					mainMenu:Visible(not mainMenu:Visible())
				end
			end
		end
		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(playerVeh, -1) == playerPed and GetVehicleClass(playerVeh) ~= 13 and GetVehicleClass(playerVeh) ~= 21 then
			if not wasInVeh then
				TriggerServerEvent('fuel:returnFuelAmount', exports.globals:trim(GetVehicleNumberPlateText(playerVeh)))
				wasInVeh = true
			end
			if fuelData.displayFuel then
				if math.floor(fuelData.fuelAmount) <= 10 then
					DrawTxt(0.708, 1.418, 1.0, 1.0, 0.55, math.floor(fuelData.fuelAmount) .. '', 255, 0, 0, 255)
					DrawTxt(0.729, 1.425, 1.0, 1.0, 0.35, 'Fuel', 255, 0, 0, 255)
				else
					DrawTxt(0.708, 1.418, 1.0, 1.0, 0.55, math.floor(fuelData.fuelAmount) .. '', 255, 255, 255, 255)
					DrawTxt(0.729, 1.425, 1.0, 1.0, 0.35, 'Fuel', 255, 255, 255, 255)
				end
			end
		else
			if wasInVeh then
				wasInVeh = false
			end
		end
	end
end)

-- Fuel amount decreases over time, set vehicle is undrivable is no fuel left
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if IsPedInAnyVehicle(playerPed, -1) and GetPedInVehicleSeat(playerVeh, -1) == playerPed and GetVehicleType(playerVeh) ~= 'Blacklisted' then
			local vehicleSpeed = math.ceil(GetEntitySpeed(playerVeh) * 2.236936)
			if vehicleSpeed > 1 and vehicleSpeed < 20 then
				fuelData.fuelUsage = 0.0025
			elseif vehicleSpeed >= 20 and vehicleSpeed < 50 then
				fuelData.fuelUsage = 0.0050
			elseif vehicleSpeed >= 50 and vehicleSpeed < 80 then
				fuelData.fuelUsage = 0.0075
			elseif vehicleSpeed >= 80 and vehicleSpeed < 100 then
				fuelData.fuelUsage = 0.0500
			elseif vehicleSpeed >= 100 and vehicleSpeed < 130 then
				fuelData.fuelUsage = 0.1000
			elseif vehicleSpeed >= 130 then
				fuelData.fuelUsage = 0.2500
			elseif vehicleSpeed >= 150 then
				fuelData.fuelUsage = 0.5000
			elseif vehicleSpeed >= 180 then
				fuelData.fuelUsage = 1.0000
			else
				fuelData.fuelUsage = 0
			end

			if fuelData.fuelAmount - fuelData.fuelUsage > 0 then
				fuelData.fuelAmount = fuelData.fuelAmount - fuelData.fuelUsage
			else
				fuelData.fuelAmount = 0
				SetVehicleUndriveable(playerVeh, true)
			end
		end
	end
end)

-- Update fuel amount of vehicle in server script every 15 seconds
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if IsPedInAnyVehicle(playerPed, -1) and GetPedInVehicleSeat(playerVeh, -1) == playerPed then
			TriggerServerEvent('fuel:setFuelAmount', exports.globals:trim(GetVehicleNumberPlateText(playerVeh)), fuelData.fuelAmount)
			Citizen.Wait(5000)
		end
	end
end)

AddEventHandler('usa:toggleImmersion', function(toggleOn)
	fuelData.displayFuel = toggleOn
end)

RegisterNetEvent('fuel:updateFuelAmount')
AddEventHandler('fuel:updateFuelAmount', function(_fuelAmount)
	fuelData.fuelAmount = _fuelAmount
end)

RegisterNetEvent('fuel:refuelAmount')
AddEventHandler('fuel:refuelAmount', function(_fuelAmount)
	local startTime = GetGameTimer()
	local timeWaiting = 500 * _fuelAmount
	fuelData.isRefuelling = true
	Citizen.CreateThread(function()
		while _fuelAmount > 0 do
			Citizen.Wait(0)
			DisableControlAction(0, 75, true)
			SetVehicleEngineOn(playerVeh, false, true, false)
			DrawTimer(startTime, timeWaiting, 1.42, 1.475, 'REFUELING')
		end
	end)
	while _fuelAmount > 0 do
		Citizen.Wait(500)
		if fuelData.fuelAmount >= 100 then
			break
		else
			_fuelAmount = _fuelAmount - 1
			fuelData.fuelAmount = fuelData.fuelAmount + 1
		end
	end
	fuelData.isRefuelling = false
end)

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

function DrawText3D(x, y, z, text)
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

function GetVehicleType(vehicle)
	local vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

	for _, k in pairs(blacklisted_models) do
		if k == vehicleName then
			return 'Blacklisted'
		end
	end

	if GetVehicleClass(vehicle) == 16 or GetVehicleClass(vehicle) == 15 then
		return 'Aircraft'
	elseif GetVehicleClass(vehicle) == 14 then
		return 'Watercraft'
	end

	--[[for _, k in pairs(electric_models) do
		if k == vehicleName then
			return 'Electric'
		end
	end]]

	return 'Gasoline'
end


function IsNearFuelStation(stationType)
	for k, v in pairs(fuelStations) do
		if k == stationType then
			for i = 1, #fuelStations[k].locations do
				local x, y, z = table.unpack(fuelStations[k].locations[i])
				if Vdist(GetEntityCoords(playerPed), x, y, z) < 5.5 then
					return true
				end
			end
		end
	end
	return false
end

function CreateMapBlips(type)
	if type == 'Gasoline' then
		for i = 1, #fuelStations['Gasoline'].locations do
			TriggerEvent("usa_map_blips:addMapBlip", fuelStations['Gasoline'].locations[i], 361, 2, 0.5, 0, true, 'Fuel Station', 'gas_stations') --coords, sprite, display, scale, color, shortRange, name, groupName)
	    end
	elseif type == 'Watercraft' then
	    for i = 1, #fuelStations['Watercraft'].locations do
	    TriggerEvent("usa_map_blips:addMapBlip", fuelStations['Watercraft'].locations[i], 361, 2, 0.5, 21, true, 'Watercraft Fuel', 'boat_fuel') --coords, sprite, display, scale, color, shortRange, name, groupName)
	    end
	elseif type == 'Aircraft' then
	    for i = 1, #fuelStations['Aircraft'].locations do
	    	TriggerEvent("usa_map_blips:addMapBlip", fuelStations['Aircraft'].locations[i], 361, 2, 0.5, 21, true, 'Aircraft Fuel', 'aircraft_fuel') --coords, sprite, display, scale, color, shortRange, name, groupName)
	    end
	end
end

Citizen.CreateThread(function()
	CreateMapBlips('Gasoline')
	CreateMapBlips('Watercraft')
	CreateMapBlips('Aircraft')
end)

--[[
local JERRY_CAN_LOCATIONS = {
	{x = 173.0, y = 6601.7, z = 31.8 }, -- paleto ron station
	{x = 1695.5, y = 6419.4, z = 32.6 }, -- paleto 24/7
	{x = 459.7, y = -990.9, z = 30.6}, -- mission row locker room
	{x = -359.7, y = 6109.2, z = 31.4}, -- paleto FD
	{x = -2554.6, y = 2327.1, z = 33.1}, -- route 1 / route 68 gas station
	{x = 1691.6, y = 4930.3, z = 42.1}, -- grapeseed gas tation
	{x = 2005.9, y = 3781.4, z = 32.2}, -- sandy shores gas station
	{x = 180.1, y = 6602.9, z = 31.8}, -- paleto ron station 2
	{x = 187.0, y = 6604.3, z = 31.8}, -- paleto ron station 3
	{x = 1204.6, y = 2663.4, z = 37.8}, -- route 68
	{x = 1039.3, y = 2668.0, z = 39.5}, -- route 68
	{x = 2681.6, y = 3267.5, z = 55.4}, -- senora fwy 1
	{x = 261.8, y = 2598.4, z = 44.7}, -- route 68
	{x = 45.7, y = 2781.7, z = 57.8}, -- route 68
	{x = 1182.9, y = -329.7, z = 69.2}, -- LS 1
	{x = 620.8, y = 269.2, z = 103.1} -- LS 2
}

local JERRY_CAN_HASH = -962731009

local JERRY_CAN_KEY = 38 -- "E"

Citizen.CreateThread(function()
	while true do
		local me = GetPlayerPed(-1)
		local mycoords = GetEntityCoords(me)
		-- picking up jerry can --
		for i = 1, #JERRY_CAN_LOCATIONS do
			if Vdist(mycoords.x, mycoords.y, mycoords.z, JERRY_CAN_LOCATIONS[i].x, JERRY_CAN_LOCATIONS[i].y, JERRY_CAN_LOCATIONS[i].z) < 4.0 then
				if IsControlJustPressed(1, JERRY_CAN_KEY) then
					if IsPickupWithinRadius(JERRY_CAN_HASH, JERRY_CAN_LOCATIONS[i].x, JERRY_CAN_LOCATIONS[i].y, JERRY_CAN_LOCATIONS[i].z, 4.0) and not IsPedInAnyVehicle(me, true) then
						-- give jerry can item in inventory for use --
						--print("giving jerry can to id: " .. GetPlayerServerId(PlayerId()))
						local jerry_can = {
							name = "Jerry Can",
							quantity = 1,
							legality = "legal",
							type = "weapon",
							hash = 883325847,
							weight = 10.0,
							image = "https://i.dlpng.com/static/png/85649_thumb.png"
						}
						TriggerServerEvent("usa:insertItem", jerry_can, jerry_can.quantity, GetPlayerServerId(PlayerId()))
						SetPedAmmo(me, 883325847, 1000)
					end
				end
			end
		end
		Wait(0)
	end
end)

function CreateJerryCanPickups()
	for i = 1, #JERRY_CAN_LOCATIONS do
		local can = JERRY_CAN_LOCATIONS[i]
		local pickup = CreatePickupRotate(JERRY_CAN_HASH, can.x, can.y, can.z - 0.5, 0, 0, 0, 512, 1, 1, 1, JERRY_CAN_HASH)
    SetPickupRegenerationTime(pickup, 180)
	end
end

Citizen.CreateThread(function()
	CreateJerryCanPickups()
end)
--]]
