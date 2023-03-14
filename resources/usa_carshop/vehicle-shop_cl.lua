--# by: minipunch
--# for: USA REALISM RP
--# simple vehicle shop script to preview and purchase a vehicle

local DISPLAY_VEHICLE_CHECK_WAIT = 3000
local DISPLAY_VEH_SPAWN_DISTANCE = 250

local DEFAULT_BLIP_NAME = "PDM"

local MENU_KEY = 38

local SHOPS = {
	--{name = "Paleto Bay", store_x = 120.9, store_y = 6624.605, store_z = 32.0, vehspawn_x = 131.04, vehspawn_y = 6625.39, vehspawn_z = 31.71, vehspawn_heading = 315.0},
	{name = "Los Santos", store_x = -33.40, store_y = -1102.03, store_z = 26.4523, vehspawn_x = -48.884, vehspawn_y = -1113.75, vehspawn_z = 26.4358, vehspawn_heading = 315.0,TDreturn = vector3(-28.11048, -1081.39, 26.63753), blipName = "PDM - Downtown LS"},
	{name = "Sandy Shores", store_x = 1224.7, store_y = 2727.3, store_z = 37.0, vehspawn_x = 1228.5, vehspawn_y = 2718.0, vehspawn_z = 38.0, vehspawn_heading = 260.0,TDreturn = vector3(1228.9268, 2723.4272, 37.0046), blipName = "PDM - Sandy Shores"},
	{
		name = "Benefactor",
		store_x = -56.239898681641, 
		store_y = 67.927253723145,
		store_z = 71.944839477539,
		vehspawn_x = -62.409317016602,
		vehspawn_y = 69.345016479492,
		vehspawn_z = 71.842216491699,
		vehspawn_heading = 291.0,
		TDreturn = vector3(-59.7604, 78.8104, 70.5),
		onlySellsCustom = true,
		blipName = "Benefactor Dealership",
		displayVehicles = {
			{
				HASHES = {"300srt8", "MachE", "lwhuracan", "s15yoshio", "rmodgtr50"},
				COORDS = vector3(-76.197906494141, 75.080581665039, 70.911987304688),
				HEADING = 204.0
			}
		}
	},
}

local locationsData = {}
for i = 1, #SHOPS do
  table.insert(locationsData, {
	coords = vector3(SHOPS[i].store_x, SHOPS[i].store_y, SHOPS[i].store_z),
	text = "[E] - Car Dealership"
  })
end
exports.globals:register3dTextLocations(locationsData)

local vehicleShopItems = nil

local menu_data = {
	closest = nil,
	preview = {
		start_coords = nil,
		handle = nil
	},
	vehicles_to_sell = nil
}

TriggerServerEvent("vehicle-shop:loadItems")

local sell_submenu = nil
local buy_submenu = nil

local isTestDriving = false
local returnLocation = nil
local returnBlip = nil

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Car Dealership", "Welcome!", 0 --[[X COORD]], 320 --[[Y COORD]])
customsMenu = NativeUI.CreateMenu("Premium Car Dealership", "Welcome!", 0 --[[X COORD]], 320 --[[Y COORD]])
previewMenu = NativeUI.CreateMenu("Vehicle Preview", "~b~Welcome!", 0, 320)

mainMenu.OnItemSelect = function(menu, item, index)
	local selected = item.Text._Text
	if selected == "Sell" then
		menu_data.vehicles_to_sell = nil
		sell_submenu.SubMenu:Clear()
		TriggerServerEvent("vehShop:loadVehiclesToSell")
		while not menu_data.vehicles_to_sell do
			Wait(50)
			--print("waiting for vehicles to sell")
		end
		if #menu_data.vehicles_to_sell > 0 then
			for i = 1, #menu_data.vehicles_to_sell do
				local veh = menu_data.vehicles_to_sell[i]
				veh.price = (veh.price or 0)
				local item = NativeUI.CreateItem(veh.make .. " " .. veh.model, "Sell this vehicle for $" .. comma_value(.30 * veh.price))
				item.Activated = function(parentmenu, selected)
					TriggerServerEvent("vehShop:sellVehicle", veh)
					_menuPool:CloseAllMenus()
				end
				sell_submenu.SubMenu:AddItem(item)
			end
		else
			local item = NativeUI.CreateItem("No vehicles to sell!", "You don't own any vehicles!")
			sell_submenu.SubMenu:AddItem(item)
		end
	end
end

_menuPool:Add(mainMenu)
_menuPool:Add(customsMenu)
_menuPool:Add(previewMenu)

function CreateCustomCarMenu(menu)
	Citizen.CreateThread(function()
		local me = GetPlayerPed(-1)
		while not vehicleShopItems do
			Wait(100)
		end
		local items = vehicleShopItems["vehicles"]["Custom"]
		for i = 1, #items do
			local item = NativeUI.CreateItem("($" .. comma_value(items[i].price) .. ") " .. items[i].make .. " " .. items[i].model, "Buy or preview the " .. items[i].make .. " " .. items[i].model .. " (Storage Capacity: " .. items[i].storage_capacity .. ")")
			item.Activated = function(parentmenu, selected)
			parentmenu:Visible(false)
			previewMenu:Visible(true)
			menu_data.preview.vehicle = items[i]
			menu_data.preview.prev_menu = parentmenu
			UpdatePreviewMenu()
			end
			menu:AddItem(item)
		  end
	end)
end

function CreateMenu(menu)
	Citizen.CreateThread(function()
		local me = GetPlayerPed(-1)
		while not vehicleShopItems do
			Wait(100)
		end
		----------
		-- buy --
		----------
		buy_submenu = _menuPool:AddSubMenu(menu, "Buy", "Shop for a vehicle!", true)

		for category, items in pairs(vehicleShopItems["vehicles"]) do
			if category ~= "Custom" then
				local category_submenu = _menuPool:AddSubMenu(buy_submenu.SubMenu, category, "See our selection of " .. category, true)
				for i = 1, #items do
					local item = NativeUI.CreateItem("($" .. comma_value(items[i].price) .. ") " .. items[i].make .. " " .. items[i].model, "Browse options for the " .. items[i].make .. " " .. items[i].model .. " (Storage Capacity: " .. items[i].storage_capacity .. ")")
					item.Activated = function(parentmenu, selected)
						parentmenu:Visible(false)
						previewMenu:Visible(true)
						menu_data.preview.vehicle = items[i]
						menu_data.preview.prev_menu = parentmenu
						UpdatePreviewMenu()
					end
					category_submenu.SubMenu:AddItem(item)
				end
			end
		end
		----------
		-- sell --
		----------
		sell_submenu = _menuPool:AddSubMenu(menu, "Sell", "Sell a vehicle!", true)
	end)
end

function UpdatePreviewMenu()
	local me = GetPlayerPed(-1)
	-- clear --
	previewMenu:Clear()
	---------------
	-- preview --
	---------------
	local item = NativeUI.CreateItem("Preview", "Preview the " .. menu_data.preview.vehicle.make .. " " .. menu_data.preview.vehicle.model)
	item.Activated = function(parentmenu, selected)
		if not menu_data.preview.handle then
			menu_data.preview.start_coords = GetEntityCoords(me)
			PreviewVehicle(menu_data.preview.vehicle)
		else
			EndPreview()
			PreviewVehicle(menu_data.preview.vehicle)
		end
	end
	previewMenu:AddItem(item)
	-----------------
	-- purchase  --
	-----------------
	local c = false
	local item = NativeUI.CreateItem("Purchase", "Purchase this vehicle for $" .. comma_value(menu_data.preview.vehicle.price))
	item.Activated = function(parentmenu, selected)
		if c then
			EndPreview()
			local business = exports["usa-businesses"]:GetClosestStore(30)
			TriggerServerEvent("mini:checkVehicleMoney", menu_data.preview.vehicle, business)
			previewMenu:Visible(false)
			c = false
		else
			TriggerEvent("usa:notify", "Please confirm your purchase.")
		end
	end
	previewMenu:AddItem(item)
	-----------------
	-- confirmation  --
	-----------------
	local checkbox = NativeUI.CreateCheckboxItem("Confirm Purchase", c, "Confirm your vehicle purchase")
	previewMenu:AddItem(checkbox)
	previewMenu.OnCheckboxChange = function (sender, item, checked_)
		if item == checkbox then
			c = checked_
		end
	end
	-----------------
	-- test drive  --
	-----------------
	local item = NativeUI.CreateItem("Test Drive", "Test drive vehicle for 10 minutes")
	item.Activated = function(parentmenu, selected)
		EndPreview()
		local business = exports["usa-businesses"]:GetClosestStore(30)
		TriggerServerEvent("mini:checkPlayerTestDrive", menu_data.preview.vehicle, business)
		previewMenu:Visible(false)
	end
	previewMenu:AddItem(item)
end

function spawnDisplayVehicle(veh)
	local randomHash = veh.HASHES[math.random(#veh.HASHES)]
    if type(randomHash) ~= "number" then
        randomHash = GetHashKey(randomHash)
    end
    RequestModel(randomHash)
    while not HasModelLoaded(randomHash) do
        Wait(100)
    end
	local handle = CreateVehicle(randomHash, veh.COORDS.x, veh.COORDS.y, veh.COORDS.z, (veh.HEADING or 0.0) --[[Heading]], false --[[Networked, set to false if you just want to be visible by the one that spawned it]], false --[[Dynamic]])
	FreezeEntityPosition(handle, true)
	SetVehicleDoorsLocked(handle, 10)
	SetVehicleExplodesOnHighExplosionDamage(handle, false)
    SetVehicleOnGroundProperly(handle)
    SetEntityAsMissionEntity(handle, true, true)
    if veh.plate then
        SetVehicleNumberPlateText(handle, veh.plate)
    end
    return handle
end

CreateMenu(mainMenu)
CreateCustomCarMenu(customsMenu)
_menuPool:RefreshIndex()

RegisterNetEvent("vehicle-shop:loadItems")
AddEventHandler("vehicle-shop:loadItems", function(items)
	vehicleShopItems = items
	for category, vehs in pairs(vehicleShopItems["vehicles"]) do
		for i = 1, #vehs do
			if type(vehs[i].hash) ~= "number" then
				vehs[i].hash = GetHashKey(vehs[i].hash)
			end
		end
	end
end)

RegisterNetEvent("vehShop:spawnPlayersVehicle")
AddEventHandler("vehShop:spawnPlayersVehicle", function(hash, plate, testDrive)
	local numberHash = tonumber(hash)
	-- thread code stuff below was taken from an example on the wiki
	-- Create a thread so that we don't 'wait' the entire game
	Citizen.CreateThread(function()
		-- Request the model so that it can be spawned
		RequestModel(numberHash)
		-- Check if it's loaded, if not then wait and re-request it.
		while not HasModelLoaded(numberHash) do
			Wait(100)
		end
		-- Model loaded, continue
		-- Spawn the vehicle at the gas station car dealership in paleto and assign the vehicle handle to 'vehicle'
		local vehicle = CreateVehicle(numberHash, menu_data.closest.vehspawn_x, menu_data.closest.vehspawn_y, menu_data.closest.vehspawn_z, menu_data.closest.vehspawn_heading, true, false)
		TriggerEvent('persistent-vehicles/register-vehicle', vehicle)
		SetVehicleNumberPlateText(vehicle, plate)
		SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
		--SetVehicleAsNoLongerNeeded(vehicle)
		SetEntityAsMissionEntity(vehicle, true, true)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		if testDrive then
			TriggerServerEvent("vehShop:spawnTestDriveCallback", plate, NetworkGetNetworkIdFromEntity(vehicle))
			returnLocation = menu_data.closest.TDreturn
			isTestDriving = true
			returnBlip = AddBlipForCoord(returnLocation)
			SetBlipSprite(returnBlip, 225)
			SetBlipColour(returnBlip, 26)
			SetBlipScale(returnBlip, 0.5)
			SetBlipRoute(returnBlip,  true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Return Test Drive Vehicle")
			EndTextCommandSetBlipName(returnBlip)
		end
	end)

end)

RegisterNetEvent("vehShop:displayVehiclesToSell")
AddEventHandler("vehShop:displayVehiclesToSell", function(vehicles)
	if vehicles then
		if #vehicles > 0 then
			--print("#vehicles " .. #vehicles)
			menu_data.vehicles_to_sell = vehicles
		else
			menu_data.vehicles_to_sell = {}
		end
	end
end)

Citizen.CreateThread(function()
	----------------
	-- draw blips --
	----------------
	addBlips()
	while true do
		local playerPed = PlayerPedId()
		------------------
		-- draw markers --
		------------------
		for k = 1, #SHOPS do
			-----------------------------------------------------------
			-- watch for entering store and menu open keypress event --
			-----------------------------------------------------------
			--DrawText3D(SHOPS[k].store_x, SHOPS[k].store_y, SHOPS[k].store_z, 10, '[E] - Car Dealership')
			if IsControlJustPressed(1, MENU_KEY) then
				if getPlayerDistanceFromShop(playerPed, SHOPS[k].store_x, SHOPS[k].store_y, SHOPS[k].store_z) < 3 then
					if not mainMenu:Visible() then
						menu_data.closest = SHOPS[k]
						if menu_data.closest.onlySellsCustom then
							customsMenu:Visible(not customsMenu:Visible())
						else
							mainMenu:Visible(not mainMenu:Visible())
						end
					end
				end
			end
		end
		----------------------
		-- process menu --
		----------------------
		if _menuPool:IsAnyMenuOpen() then
			_menuPool:MouseControlsEnabled(false)
			_menuPool:ControlDisablingEnabled(false)
			_menuPool:ProcessMenus()
		end
		-- closing menus --
		if not menu_data.preview.handle and menu_data.closest and getPlayerDistanceFromShop(playerPed, menu_data.closest.store_x, menu_data.closest.store_y, menu_data.closest.store_z) > 3 then
			mainMenu:Visible(false)
		end
		-- ending preview --
		if menu_data.preview.handle and not _menuPool:IsAnyMenuOpen() then
			EndPreview()
		end
		--print("menu_data.closest: " .. type(menu_data.closest))
		Wait(0)
	end
end)

-- thread to manage shop display vehicles --
Citizen.CreateThread(function()
    while true do
		local myped = PlayerPedId()
		local mycoords = GetEntityCoords(myped)
        for i = 1, #SHOPS do
			local dist = Vdist(mycoords, SHOPS[i].store_x, SHOPS[i].store_y, SHOPS[i].store_z)
			if SHOPS[i].displayVehicles then
				for j = 1, #SHOPS[i].displayVehicles do
					if dist < DISPLAY_VEH_SPAWN_DISTANCE then
						if not SHOPS[i].displayVehicles[j].handle then
							SHOPS[i].displayVehicles[j].handle = spawnDisplayVehicle(SHOPS[i].displayVehicles[j])
						end
					else
						if SHOPS[i].displayVehicles[j].handle then
							DeleteVehicle(SHOPS[i].displayVehicles[j].handle)
							SHOPS[i].displayVehicles[j].handle = nil
						end
					end
				end
			end
		end
        Wait(DISPLAY_VEHICLE_CHECK_WAIT)
    end
end)

function getPlayerDistanceFromShop(ped, shopX,shopY,shopZ)
	local playerCoords = GetEntityCoords(ped, false)
	return GetDistanceBetweenCoords(playerCoords.x,playerCoords.y,playerCoords.z,shopX,shopY,shopZ,true)
end

function PreviewVehicle(item)
	local numberHash = tonumber(item.hash)
	Citizen.CreateThread(function()
		TriggerEvent("hotwire:enableKeyEngineCheck", false)
		-- Request the model so that it can be spawned
		RequestModel(numberHash)
		-- Check if it's loaded, if not then wait and re-request it.
		while not HasModelLoaded(numberHash) do
			Wait(100)
		end
		-- Model loaded, continue
		if menu_data.preview and menu_data.preview.handle and DoesEntityExist(menu_data.preview.handle) then
			DeleteVehicle(menu_data.preview.handle)
		end
		menu_data.preview.handle = CreateVehicle(numberHash, menu_data.closest.vehspawn_x, menu_data.closest.vehspawn_y, menu_data.closest.vehspawn_z, menu_data.closest.vehspawn_heading --[[Heading]], false --[[Networked, set to false if you just want to be visible by the one that spawned it]], false --[[Dynamic]])
		SetVehicleExplodesOnHighExplosionDamage(menu_data.preview.handle, false)
		SetVehicleOnGroundProperly(menu_data.preview.handle)
		SetVehRadioStation(menu_data.preview.handle, "OFF")
		SetPedIntoVehicle(GetPlayerPed(-1), menu_data.preview.handle, -1)
		SetVehicleEngineOn(menu_data.preview.handle, true, false, false)
		FreezeEntityPosition(menu_data.preview.handle, true)
		SetVehicleDoorsLocked(menu_data.preview.handle, 4)
	end)
end

function addBlips()
	for i = 1, #SHOPS do
		local blip = AddBlipForCoord(SHOPS[i].store_x, SHOPS[i].store_y, SHOPS[i].store_z)
		SetBlipSprite(blip, 225)
		SetBlipAsShortRange(blip, true)
		SetBlipScale(blip, 0.85)
		SetBlipDisplay(blip, 4)
		SetBlipColour(blip, 1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString((SHOPS[i].blipName or DEFAULT_BLIP_NAME))
		EndTextCommandSetBlipName(blip)
	end
end

function EndPreview()
	if menu_data.preview.handle then
		TriggerEvent('persistent-vehicles/forget-vehicle', menu_data.preview.handle)
	    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( menu_data.preview.handle ) )
		menu_data.preview.handle = nil
		SetEntityCoords(GetPlayerPed(-1), table.unpack(menu_data.preview.start_coords))
		menu_data.preview.prev_menu:Visible(true)
	end
	TriggerEvent("hotwire:enableKeyEngineCheck", true)
end

function comma_value(amount)
	if not amount then return end
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function DrawText3D(x, y, z, distance, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), x, y, z, true) < distance then
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

function alert(msg)
	SetTextComponentFormat("STRING")
	AddTextComponentString(msg)
	DisplayHelpTextFromStringLabel(0,0,1,-1)
end

local trackedVehBlip = nil

RegisterNetEvent("vehShop:trackStolenVeh")
AddEventHandler("vehShop:trackStolenVeh", function(coords)
	if trackedVehBlip ~= nil then
		SetBlipCoords(trackedVehBlip, coords)
		SetBlipRoute(trackedVehBlip,  false)
		SetBlipRoute(trackedVehBlip,  true)
	else
		trackedVehBlip = AddBlipForCoord(coords)
		SetBlipSprite(trackedVehBlip, 225)
		SetBlipColour(trackedVehBlip, 1)
		SetBlipScale(trackedVehBlip, 0.5)
		SetBlipRoute(trackedVehBlip,  true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Tracked Stolen Vehicle")
		EndTextCommandSetBlipName(trackedVehBlip)
	end
end)

RegisterNetEvent("vehShop:stopTrackStolenVeh")
AddEventHandler("vehShop:stopTrackStolenVeh", function()
	if trackedVehBlip ~= nil then
		RemoveBlip(trackedVehBlip)
		trackedVehBlip = nil
	end
end)

RegisterNetEvent("vehShop:endTestDrive")
AddEventHandler("vehShop:endTestDrive", function()
	isTestDriving = false
	returnLocation = nil
	RemoveBlip(returnBlip)
	returnBlip = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isTestDriving then
			DrawMarker(1, returnLocation.x, returnLocation.y, returnLocation.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.5, 3.5, 0.5, 0, 255, 255, 155, false, true, 2, nil, nil, false)
			if #(GetEntityCoords(PlayerPedId()) - returnLocation) < 2.5 then
				alert("Return Car ~INPUT_CONTEXT~")
				if IsControlJustPressed(1, 51) then
					local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
					TriggerServerEvent("vehShop:returnVehicle", GetVehicleNumberPlateText(vehicle), GetEntityModel(vehicle))
				end
			end
		end
	end
end)