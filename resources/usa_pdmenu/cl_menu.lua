local menuPool = NativeUI.CreatePool()
local garageMenu = NativeUI.CreateMenu('ER Garage', 'VEHICLE MANAGEMENT', 0, 320)
local customizationMenu = NativeUI.CreateMenu('ER Workshop', 'PIMP MY RIDE', 0, 320)

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
	['Brushed Steel'] = 117,
	['Matte Black'] = 12,
	['Matte Gray'] = 13,
	['Matte Red'] = 39,
	['Matte Orange'] = 41,
	['Matte Yellow'] = 42,
	['Matte Blue'] = 83,
	['Matte Green'] = 128,
	['Matte White'] = 131,
	['Matte Purple'] = 148,
	['Matte Desert Tan'] = 154,
	['Metallic Champagne'] = 93,
	['Pure Gold'] = 158,
	['Brushed Gold'] = 159
}

--------------- LOCATIONS ----------------------

local policeGarages = {
	{x = 459.37, y = -986.36, z = 25.69, _x = 458.52, _y = -980.78, _z = 25.69, _heading = 89.102}, -- Mission Row
	{x = 1864.02, y = 3681.70, z = 33.69, _x = 1864.08, _y = 3701.667, _z = 33.52, _heading = 211.45}, -- Sandy Shores
	{x = -462.19, y = 6001.45, z = 31.34, _x = -468.93, _y = 6039.11, _z = 31.34, _heading = 220.43}, -- Paleto Bay
	{x = 818.147, y = -1334.51, z =  26.1, _x = 828.69, _y = -1351.26, _z = 26.09, _heading = 64.9}, -- La Mesa
	{x = -1077.8362, y = -815.5814, z = 4.8650, _x = -1072.4160, _y = -803.8643, _z = 4.8650, _heading = 129.8831}, -- Vespucci 
	-- {x = 378.16, y = -1613.96, z = 29.29, _x = 394.39, _y = -1625.57, _z = 29.29, _heading = 51.66}, -- Davis (OLD)
	{x = 397.1947, y = -1624.0338, z = 29.2921, _x = 390.5051, _y = -1629.9517, _z = 29.2921, _heading = 317.4876}, -- DavisPD (NEW)
	{x = 560.04, y = -60.305, z = 71.186, _x = 534.24, _y = -26.13, _z = 70.62, _heading = 210.88}, -- Vinewood
	{x = -85.21, y = -807.60, z = 36.49, _x = -73.97, _y = -818.25, _z = 36.05, _heading = 295.0}, -- DA Office
	--hospitals
	{x = 1696.53, y = 3603.31, z = 35.52, _x = 1696.53, _y = 3603.31, _z = 35.52, _heading = 210.95}, -- Sandy Fire Station
	{x = -449.06, y = -340.25, z = 33.60, _x = -454.24, _y = -339.42, _z = 34.36, _heading = 173.34}, -- Mnt Zonah
	{x = 1196.9298095703, y = -1469.3293457031, z = 34.857048034668, _x = 1204.98, _y = -1468.67, _z = 34.85, _heading = 359.99}, -- LS fire station 9 / CapitalBlvd
	{x = 206.9017791748, y = -1643.3134765625, z = 29.800746917725, _x = 212.35, _y = -1649.66, _z = 29.80, _heading = 319.52}, -- davis station
	{x = 295.40, y = -1447.32, z = 29.96, _x = 317.64, _y = -1450.60, _z = 29.80, _heading = 229.44}, -- los santos central hospital
	{x = -369.29, y = 6123.67, z = 31.44, _x = -353.00, _y = 6127.91, _z = 31.44, _heading = 41.22}, -- paleto fire station
	{x = -851.29, y = -1226.97, z = 6.69, _x = -858.50, _y = -1216.24, _z = 6.03, _heading = 307.99}, -- viceroy
	{x = 338.85, y = -575.15, z = 27.79, _x = 328.30, _y = -578.12, _z = 28.79, _heading = 337.49}, -- pillbox
	{x = 1821.19, y = 3685.34, z = 34.27, _x = 1813.15, _y = 3685.52, _z = 34.22, _heading = 296.15}, -- sandy hospital
	{x = -252.5996, y = 6341.0737, z = 32.4262, _x = -261.1586, _y = 6336.5386, _z = 32.4211, _heading = 312.5269}, -- paleto clinic
	{x = 1668.9875, y = 2611.7202, z = 45.5649, _x = 1673.9246, _y = 2605.4407, _z = 45.5649, _heading = 266.2758}, -- prison rear
	{x = -1822.7368164063, y = 3000.8508300781, z = 32.810050964355, _x = -1833.6276855469, _y = 2996.2858886719, _z = 32.810028076172, _heading = 337.49}, -- Fort Zancudo
}

local locationsData = {}
for i = 1, #policeGarages do
  table.insert(locationsData, {
    coords = vector3(policeGarages[i].x, policeGarages[i].y, policeGarages[i].z + 0.5),
    text = '[E] - Garage | [U] - Customization'
  })
end
exports.globals:register3dTextLocations(locationsData)

----------------- VEHICLE MENU -----------------
menuPool:Add(customizationMenu)
menuPool:Add(garageMenu)

function AddGarageMenuItems(menu, vehs, job)
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
	        		if Vdist(px,py,pz,policeGarages[i].x,policeGarages[i].y,policeGarages[i].z)  <  7 and waiting < 5000 then
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
						
						if selectedVeh == "polbike3" then
							ModifyVehicleTopSpeed(spawnedVeh, 0.0) -- reset first to avoid doubling up issue
        					ModifyVehicleTopSpeed(spawnedVeh, 30.0)
						end

						local plate = GetVehicleNumberPlateText(spawnedVeh)
						plate = exports.globals:trim(plate)
						TriggerServerEvent("fuel:setFuelAmount", plate, 100)

						local vehicle_key = {
							name = "Key -- " .. plate,
							quantity = 1,
							type = "key",
							owner = "GOVT",
							make = "GOVT",
							model = "GOVT",
							plate = plate
						}

						-- give key to owner
						TriggerServerEvent("garage:giveKey", vehicle_key)
						local mdtjob
						if job == "sheriff" then
							mdtjob = 'San Andreas State Police'
						elseif job == "corrections" then
							mdtjob = 'Correctional Department'
						elseif job == "ems" then 
							mdtjob = 'Los Santos Fire Department'
						elseif job == "doctor" then 
							mdtjob = 'Pillbox Medical Center'
						end
						print(mdtjob)
						TriggerServerEvent("mdt:addTempVehicle", 'Emergency Vehicle', mdtjob, plate)
						
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
	local settint = UIMenuSliderItem.New('Window Tint', tint, tintindex)
	menu:AddItem(settint)
	menu:AddItem(color)
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
end

AddGarageMenuItems(garageMenu)
garageMenu:RefreshIndex()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		menuPool:MouseControlsEnabled(false)
        menuPool:ControlDisablingEnabled(false)
        menuPool:ProcessMenus()
       	local px,py,pz=table.unpack(GetEntityCoords(GetPlayerPed(-1)))
        if IsControlJustPressed(0, 38) then
        	for i = 1, #policeGarages do
        		if Vdist(px,py,pz,policeGarages[i].x,policeGarages[i].y,policeGarages[i].z)  <  4 then
					TriggerServerEvent('pdmenu:checkWhitelistForGarage')
				end
			end
		end
       	if IsControlJustPressed(0, 303) then
       		for i = 1, #policeGarages do
        		if Vdist(px,py,pz,policeGarages[i].x,policeGarages[i].y,policeGarages[i].z)  <  4 then
					TriggerServerEvent('pdmenu:checkWhitelistForCustomization')
				end
			end
       	end
	end
end)

RegisterNetEvent('pdmenu:openGarageMenu')
AddEventHandler('pdmenu:openGarageMenu', function(vehs, job)
	garageMenu:Clear()
	AddGarageMenuItems(garageMenu, vehs, job)
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
