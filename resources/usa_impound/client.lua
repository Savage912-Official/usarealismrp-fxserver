local impound_locations = {
	vector3(463.7510, -1019.8464, 28.1034),
	vector3(870.4995, -1350.3667, 26.3069),
	vector3(1882.1548, 3691.9702, 33.5374),
	vector3(-481.6664, 6023.6255, 31.3405),
	vector3(530.0640, -29.7744, 70.6295),
	-- vector3(381.0558, -1625.2599, 29.2921), -- Gabz DavisPD
	vector3(376.62640380859, -1613.2768554688, 29.291954040527),
	vector3(-1070.6948, -853.9318, 4.8671)
}

local nearbyLocations = {}

local display = false

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("main", function(data)
    SetDisplay(false)
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, false)
	local plate = GetVehicleNumberPlateText(vehicle)
	plate = exports.globals:trim(plate)
    local impounded = TriggerServerCallback {
		eventName = "usa_impound:impoundVeh",
		args = {plate, data.days}
	}
	if impounded then
		NetworkRequestControlOfEntity(vehicle)
		while not NetworkHasControlOfEntity(vehicle) do
			Wait(100)
		end
		SetEntityAsMissionEntity(vehicle, true, true)
		while not IsEntityAMissionEntity(vehicle) do
			Wait(100)
		end
		Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( vehicle ) ) -- DeleteVehicle Native
		if (DoesEntityExist(vehicle)) then 
			DeleteEntity(vehicle) -- Fallback in case DeleteVehicle does not work, DeleteEntity might
		end
	end
end)

RegisterNUICallback("error", function(data)
    TriggerEvent("usa:notify", data.error)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 470
	DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()
	while true do
		local mycoords = GetEntityCoords(PlayerPedId())
		for i = 1, #impound_locations do
			if Vdist(mycoords, impound_locations[i].x, impound_locations[i].y, impound_locations[i].z) < 70 then
				nearbyLocations[i] = true
			else
				nearbyLocations[i] = nil
			end
		end
		Wait(1000)
	end
end)


Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		for i, isNearby in pairs(nearbyLocations) do
			local info = impound_locations[i]
			local dist = #(GetEntityCoords(ped) - vector3(info.x, info.y, info.z))
			DrawMarker(27, vector3(info['x'], info['y'], info['z'] - 0.98), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, vector3(4.0, 4.0, 3.0),  255, 0, 0, 150, false, true, 2, false, nil, nil, false)
			if dist < 10 then
				DrawText3D(info['x'], info['y'], info['z'], '[E] - Police Impound')
			end
			if IsControlJustPressed(0, 86) and dist < 2 then

				local isCop = TriggerServerCallback {
					eventName = "usa_impound:checkCop",
					args = {}
				}

				if isCop then
					if IsPedInAnyVehicle(ped, true) then
						SetDisplay(not display)
					else
						TriggerServerEvent("usa_impound:showImpoundedVehicles")
					end
				else
					TriggerEvent("usa:notify", "Police Impound Prohibited!")
				end

			end
		end
		Wait(1)
	end
end)

RegisterNetEvent("usa_impound:checkCopReturn")
AddEventHandler("usa_impound:checkCopReturn", function(isCop)
	local ped = PlayerPedId()
	if (isCop) then

		if IsPedInAnyVehicle(ped, true) then
			SetDisplay(not display)
		else
			TriggerServerEvent("usa_impound:showImpoundedVehicles")
		end

	else

		TriggerEvent("usa:notify", "Police Impound Prohibited!")

	end
end)