--# Public vehicle parking garages to store player vehicles
--# For: USA Realism RP
--# By: minipunch

local MENU_OPEN_KEY = 38
---------------------------
-- Set up main menu --
---------------------------
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Garage", "~b~Public Parking", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(mainMenu)

-- custom events --
RegisterNetEvent("garage:openMenuWithVehiclesLoaded")
AddEventHandler("garage:openMenuWithVehiclesLoaded", function(userVehicles, _closest_shop)
	if _closest_shop then closest_shop = _closest_shop end
	CreateGarageMenu(mainMenu, userVehicles, closest_shop)
	local playerPed = PlayerPedId()
	while mainMenu:Visible() do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(playerPed)
		if Vdist(closest_shop['x'], closest_shop['y'], closest_shop['z'], playerCoords) > 5.0 then
			mainMenu:Visible(false)
			break
		end
	end
end)
-- end custom events --

function CreateGarageMenu(menu, vehicles, garageCoords)
	local mycoords = GetEntityCoords(PlayerPedId())
	-- remove any previous versions --
	mainMenu:Clear()
	-- Add vehicles to menu --
	for i = 1, #vehicles do
		-- button text --
		local vehicle = vehicles[i]
		local buttonText = "" --.. vehicle.make .. " " .. vehicle.model .. " (" .. vehicle.plate .. ")"
		if vehicle.make:len() > 0 then
			buttonText = buttonText .. vehicle.make .. " "
		end
		buttonText = buttonText .. vehicle.model .. " [" .. vehicle.plate .. "]"
		if vehicle.stored_location then
			local varType = type(vehicle.stored_location)
			if varType == "string" then
				buttonText = buttonText .. " (stored at " .. vehicle.stored_location .. ")"
			elseif varType == "table" then
				if #(mycoords - vector3(vehicle.stored_location.x, vehicle.stored_location.y, vehicle.stored_location.z)) > 15 then
					buttonText = buttonText .. " (stored at other)"
				else
					buttonText = buttonText .. " (~g~Stored~s~)"
				end
			end
		elseif vehicle.impounded == true then
			buttonText = buttonText .. " (~y~Impounded~s~)"
		elseif vehicle.stored == false then
			buttonText = buttonText .. " (~r~Not Stored~s~)"
		else
			buttonText = buttonText .. " (~g~Stored~s~)"
		end
		-- make button --
		local item = NativeUI.CreateItem(buttonText, "")
		item.Activated = function(parentmenu, selected)
			local business = (exports["usa-businesses"]:GetClosestStore(15) or "")
			if GetVehiclePedIsIn(GetPlayerPed(-1), false) ~= 0 then
				if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) then
					TriggerServerEvent("garage:vehicleSelected", vehicle, business, GetEntityCoords(PlayerPedId()), garageCoords)
				else
					TriggerEvent("usa:notify", "You must be in the driver's seat!")
				end
			else
				TriggerServerEvent("garage:vehicleSelected", vehicle, business, mycoords, garageCoords)
			end
			-- close menu --
			mainMenu:Visible(not mainMenu:Visible())
		end
		menu:AddItem(item)
	end
	-- exit button --
	local item = NativeUI.CreateItem("Close", "")
	item.Activated = function(parentmenu, selected)
		-- close menu --
		mainMenu:Visible(not mainMenu:Visible())
	end
	menu:AddItem(item)
	-- Open Menu --
	mainMenu:Visible(not mainMenu:Visible())
end

Citizen.CreateThread(function()
	while true do

		-- Process Menu --
		_menuPool:MouseControlsEnabled(false)
		_menuPool:ControlDisablingEnabled(false)
		_menuPool:ProcessMenus()
		-----------------------

		Wait(0)
	end
end)
