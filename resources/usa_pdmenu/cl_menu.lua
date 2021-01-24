local menuPool = NativeUI.CreatePool()
local garageMenu = NativeUI.CreateMenu('LEO Garage', 'VEHICLE MANAGEMENT', 0, 320)
local customizationMenu = NativeUI.CreateMenu('LEO Workshop', 'PIMP MY RIDE', 0, 320)

---------- CAR CUSTOMIZATION MENU COLORS ------------

local colors = { -- https://wiki.gtanet.work/index.php?title=Vehicle_Colors
	['Black'] = 0,
	['Anthracite Black'] = 11,
	['Dark Steel'] = 3,
	['Silver'] = 4,
	['Bluish Silver'] = 5,
	['Shadow Silver'] = 7,
	['Cast Iron Silver'] = 10,
	['Garnet Red'] = 32,
	['Midnight Blue'] = 141,
	['Dark Blue'] = 62,
	['Harbor Blue'] = 66,
	['Chocolate Brown'] = 96,
	['Creek Brown'] = 95,
	['Ice White'] = 111,
	['Frost White'] = 112,
	['Brushed Steel'] = 117
}

--------------- LOCATIONS ----------------------

local policeGarages = {
	{x = 459.37362670898, y = -986.36254882813, z = 25.699831008911, _x = 458.52395629883, _y = -980.78051757813, _z = 25.699831008911, _heading = 89.102}, -- Mission Row
	{x = 1864.02, y = 3681.70, z = 33.69, _x = 1864.08, _y = 3701.667, _z = 33.52, _heading = 211.45}, -- Sandy Shores
	{x = -462.19, y = 6001.45, z = 31.34, _x = -468.93, _y = 6039.11, _z = 31.34, _heading = 220.43}, -- Paleto Bay
	{x = 818.147, y = -1334.51, z =  26.1, _x = 828.69, _y = -1351.26, _z = 26.09, _heading = 64.9}, -- La Mesa
	{x = -1123.47, y = -848.411, z = 13.45, _x = -1126.32, _y = -864.89, _z = 13.55, _heading = 34.54}, -- Vespucci 
	{x = 378.16, y = -1613.96, z = 29.29, _x = 394.39, _y = -1625.57, _z = 29.29, _heading = 51.66}, -- Davis
	{x = 560.04, y = -60.305, z = 71.186, _x = 534.24, _y = -26.13, _z = 70.62, _heading = 210.88}, -- Vinewood
	{x = -85.21, y = -807.60, z = 36.49, _x = -73.97, _y = -818.25, _z = 36.05, _heading = 295.0} -- DA Office

}

----------------- VEHICLE MENU -----------------
menuPool:Add(customizationMenu)
menuPool:Add(garageMenu)

function AddGarageMenuItems(menu, vehs)
	local ped = GetPlayerPed(-1)
	local repair = NativeUI.CreateItem('Repair Vehicle', 'Stop by the police mechanic.')
	local vehicle = UIMenuListItem.New('Vehicle', (vehs or {}), 'Select this vehicle.')
	local clean = NativeUI.CreateItem('Clean Vehicle', '"Cleanup on aisle 5..."')
	local returnveh = NativeUI.CreateItem('~r~Return Vehicle', 'Return your police vehicle')
	menu:AddItem(vehicle)
	menu:AddItem(clean)
	menu:AddItem(repair)
	menu:AddItem(returnveh)
	menu.OnItemSelect = function(sender, item, index)
		if item == repair then
			local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
			if not veh then
				ShowNotification('You must be in a vehicle!')
			else
				SetVehicleFixed(GetVehiclePedIsUsing(GetPlayerPed(-1)))
				ShowNotification('Your vehicle has been repaired!')
			end
		elseif item == clean then
			local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
			if not veh then
				ShowNotification('You must be in a vehicle!')
			else
				WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
				SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
				ShowNotification('Your vehicle has been cleaned!')
			end
		elseif item == returnveh then
			local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
			if not veh then
				ShowNotification('You must be in a vehicle!')
			else
				SetEntityAsMissionEntity(veh)
				TriggerEvent('persistent-vehicles/forget-vehicle', veh)
				DeleteVehicle(veh)
				ShowNotification('Your vehicle has been returned.')
			end
		end
	end
	vehicle.OnListSelected = function(sender, item, index)
		if item == vehicle then
			local selectedVeh = item:IndexToItem(index)
			if GetVehiclePedIsUsing(GetPlayerPed(-1)) == 0 then
	    		local vehicleHash = GetHashKey(selectedVeh)
				RequestModel(vehicleHash)
		        local waiting = 0
		        if not HasModelLoaded(vehicleHash) then
		        	ShowNotification("Loading vehicle model...")
			        while not HasModelLoaded(vehicleHash) do
			            waiting = waiting + 100
			            Citizen.Wait(100)
			            if waiting > 5000 then
			                ShowNotification("~r~Could not load the vehicle model in time, please try again.")
			                break
			            end
			        end
			    end
		        -- spawn vehicle --
		        garageMenu:Visible(false)
	        	local coords = GetEntityCoords(GetPlayerPed(-1), false)
	        	local px,py,pz=table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	        	local spawnedVeh = nil
	        	for i = 1, #policeGarages do
	        		if Vdist(px,py,pz,policeGarages[i].x,policeGarages[i].y,policeGarages[i].z)  <  9 and waiting < 5000 then
						spawnedVeh = CreateVehicle(vehicleHash, policeGarages[i]._x,policeGarages[i]._y,policeGarages[i]._z, policeGarages[i]._heading, true)
						TriggerEvent('persistent-vehicles/register-vehicle', spawnedVeh)
						SetVehicleHasBeenOwnedByPlayer(spawnedVeh, true)
						SetVehicleExplodesOnHighExplosionDamage(spawnedVeh, false)
						SetVehicleEngineOn(spawnedVeh, true, true, false)
					    SetEntityAsMissionEntity(spawnedVeh)
						TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawnedVeh, -1)
						
					    SetVehicleMod(spawnedVeh, 16, 4, false)
					    SetVehicleMod(spawnedVeh, 12, 2, false)
						SetVehicleMod(spawnedVeh, 22, 1, false)
						
						if selectedVeh == "1200RT" then
							ModifyVehicleTopSpeed(spawnedVeh, 0.0) -- reset first to avoid doubling up issue
        					ModifyVehicleTopSpeed(spawnedVeh, 30.0)
						end

						local vehicle_key = {
							name = "Key -- " .. GetVehicleNumberPlateText(spawnedVeh),
							quantity = 1,
							type = "key",
							owner = "GOVT",
							make = "GOVT",
							model = "GOVT",
							plate = GetVehicleNumberPlateText(spawnedVeh)
						}

						-- give key to owner
						TriggerServerEvent("garage:giveKey", vehicle_key)
						TriggerServerEvent("mdt:addTempVehicle", 'Police Interceptor', 'San Andreas State Police', GetVehicleNumberPlateText(spawnedVeh))
						
						return
					end
				end
			else
				ShowNotification('You must return your current vehicle first!')
			end
		end
	end
end

function AddCustomization(menu)
	menuPool:TotalItemsPerPage(10)
	local engineupgrades = {
		"None",
		"EMS Upgrade, Level 1",
		"EMS Upgrade, Level 2",
		"EMS Upgrade, Level 3",
		"EMS Upgrade, Level 4"
	}
	SetVehicleModKit(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
	-- liveries
	local liveries = {}
	if GetVehicleLiveryCount(GetVehiclePedIsUsing(GetPlayerPed(-1))) > -1 then
		for i = 1, GetVehicleLiveryCount(GetVehiclePedIsUsing(GetPlayerPed(-1))) do liveries[i] = i end
		setlivery = UIMenuSliderItem.New('Vehicle Livery', liveries, livindex)
		livindex = GetVehicleLivery(GetVehiclePedIsUsing(GetPlayerPed(-1))) + 1
		menu:AddItem(setlivery)
	end
	-- tint
	local tint = {}
	for i = 1, 4 do tint[i] = i end
	local tintindex = GetVehicleWindowTint(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	if tintindex == 0 then
		tintindex = 1
	elseif tintindex == 3 then
		tintindex = 2
	elseif tintindex == 2 then
		tintindex = 3
	elseif tintindex == 1 then
		tintindex = 4
	elseif tintindex == -1 then
		tintindex = 1
	end
	-- engine
	local engineindex = GetVehicleMod(GetVehiclePedIsUsing(GetPlayerPed(-1)), 11)
	engineindex = engineindex + 2
	-- convert color values to color names
	local nameColors = {}
	for k, v in pairs(colors) do
		table.insert(nameColors, k)
	end
	local color = UIMenuListItem.New("Color", nameColors)
	local engines = UIMenuListItem.New("Engine Multiplier", engineupgrades, engineindex)
	local settint = UIMenuSliderItem.New('Window Tint', tint, tintindex)
	menu:AddItem(settint)
	menu:AddItem(color)
	menu:AddItem(engines)
	checkExtras(menu)
	menu.OnSliderChange = function(sender, item, index)
		if item == setlivery then
			local livery = item:IndexToItem(index)
			livery = livery - 1
			SetVehicleLivery(GetVehiclePedIsUsing(GetPlayerPed(-1)), livery)
		elseif item == settint then
			tint = item:IndexToItem(index)
			if tint == 1 then
				tint = 0
			elseif tint == 2 then
				tint = 3
			elseif tint == 3 then
				tint = 2
			elseif tint == 4 then
				tint = 1
			end
			SetVehicleWindowTint((GetVehiclePedIsUsing(GetPlayerPed(-1))), tint)
		end
	end
	menu.OnCheckboxChange = function(sender, item, checked_)
		if item == extra1 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1, (not checked_))
		elseif item == extra2 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 2, (not checked_))
		elseif item == extra3 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 3, (not checked_))
		elseif item == extra4 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 4, (not checked_))
		elseif item == extra5 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 5, (not checked_))
		elseif item == extra6 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 6, (not checked_))
		elseif item == extra7 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 7, (not checked_))
		elseif item == extra8 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 8, (not checked_))
		elseif item == extra9 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 9, (not checked_))
		elseif item == extra10 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 10, (not checked_))
		elseif item == extra11 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 11, (not checked_))
		elseif item == extra12 then
			SetVehicleExtra(GetVehiclePedIsUsing(GetPlayerPed(-1)), 12, (not checked_))
		end
	end
	color.OnListSelected = function(sender, item, index)
		x = item:IndexToItem(index)
		SetVehicleColours(GetVehiclePedIsUsing(GetPlayerPed(-1)), colors[x], colors[x])	
		ShowNotification('Applied: '..x)
	end
	engines.OnListSelected = function(sender, item, index)
		local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
		local engine = item:IndexToItem(index)
		if engine == "EMS Upgrade, Level 1" then
			SetVehicleMod(vehicle, 11, 0)
		elseif engine == "EMS Upgrade, Level 2" then
			SetVehicleMod(vehicle, 11, 1)
		elseif engine == "EMS Upgrade, Level 3" then
			SetVehicleMod(vehicle, 11, 2)
		elseif engine == "EMS Upgrade, Level 4" then
			SetVehicleMod(vehicle, 11, 3)
		else
			SetVehicleMod(vehicle, 11, -1)
		end
		ShowNotification('Applied: '.. (engine or "N/A"))
	end
end

AddGarageMenuItems(garageMenu)
garageMenu:RefreshIndex()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i = 1, #policeGarages do
			DrawText3Ds(policeGarages[i].x,policeGarages[i].y,policeGarages[i].z + 0.5, 370, 16, '[E] - Garage | [U] - Customization') -- putting this in a loop gave > 0.04 ms in resmon, should be ok tho...
		end
		menuPool:MouseControlsEnabled(false)
        menuPool:ControlDisablingEnabled(false)
        menuPool:ProcessMenus()
       	local px,py,pz=table.unpack(GetEntityCoords(GetPlayerPed(-1)))
        if IsControlJustPressed(0, 38) then
        	for i = 1, #policeGarages do
        		if Vdist(px,py,pz,policeGarages[i].x,policeGarages[i].y,policeGarages[i].z)  <  5 then
					TriggerServerEvent('pdmenu:checkWhitelistForGarage')
				end
			end
		end
       	if IsControlJustPressed(0, 303) then
       		for i = 1, #policeGarages do
        		if Vdist(px,py,pz,policeGarages[i].x,policeGarages[i].y,policeGarages[i].z)  <  5 then
					TriggerServerEvent('pdmenu:checkWhitelistForCustomization')
				end
			end
       	end
	end
end)

RegisterNetEvent('pdmenu:openGarageMenu')
AddEventHandler('pdmenu:openGarageMenu', function(vehs)
	garageMenu:Clear()
	AddGarageMenuItems(garageMenu, vehs)
	garageMenu:Visible(not garageMenu:Visible())
	customizationMenu:Visible(false)
end)

RegisterNetEvent('pdmenu:openCustomizationMenu')
AddEventHandler('pdmenu:openCustomizationMenu', function()
	if GetVehiclePedIsUsing(GetPlayerPed(-1)) ~= 0 then
		print('Opening customization menu')
		customizationMenu:Clear()
		SetVehicleHalt(GetVehiclePedIsUsing(GetPlayerPed(-1)), 10, 1)
		AddCustomization(customizationMenu)
		customizationMenu:Visible(not customizationMenu:Visible())
		garageMenu:Visible(false)
	else
		ShowNotification('You must be in a vehicle!')
	end
end)

------------ FUNCTIONS USED -------------------

function checkExtras(menu)
	local ped = GetPlayerPed(-1)
	i = 1
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped), i) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra1 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra1)
	end
	i = 2
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped), i) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra2 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra2)
	end
	i = 3
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped), i) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra3 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra3)
	end
	i = 4
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped), i) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra4 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra4)
	end
	i = 5
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped), i) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra5 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra5)
	end
	i = 6
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped), i) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra6 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra6)
	end
	i = 7
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped), i) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra7 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra7)
	end
	i = 8
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped), i) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra8 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra8)
	end
	i = 9
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped), i) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra9 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra9)
	end
	i = 10
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped, i)) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra10 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra10)
	end
	i = 11
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped), i) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra11 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra11)
	end
	i = 12
	if DoesExtraExist(GetVehiclePedIsUsing(ped), i) then
		if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(ped), i) then
			isExtraOn = true
		else
			isExtraOn = false
		end
		extra12 = NativeUI.CreateCheckboxItem('Extra ' .. i, isExtraOn)
		menu:AddItem(extra12)
	end
end

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function DrawText3Ds(x,y,z,q,a, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    if dist < a then
	    SetTextScale(0.35, 0.35)
	    SetTextFont(4)
	    SetTextProportional(1)
	    SetTextColour(255, 255, 255, 215)
	    SetTextEntry("STRING")
	    SetTextCentre(1)
	    AddTextComponentString(text)
	    DrawText(_x,_y)
	    local factor = (string.len(text)) / q
	    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
	end
end
