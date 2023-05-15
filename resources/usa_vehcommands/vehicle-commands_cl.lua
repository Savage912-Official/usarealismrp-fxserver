RegisterNetEvent("vehicleCommands:spawnVehicle")
AddEventHandler("vehicleCommands:spawnVehicle", function(modelName, userJob)
	local vehicleHash = GetHashKey(modelName)
	
	RequestModel(vehicleHash)
	while not HasModelLoaded(vehicleHash) do
		Citizen.Wait(100)
	end
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local playerHeading = GetEntityHeading(playerPed)
	local vehicle = CreateVehicle(vehicleHash, playerCoords.x, playerCoords.y + 4.5, playerCoords.z, playerHeading, true, false)

	SetEntityAsMissionEntity(vehicle, true, true)
	SetVehicleHasBeenOwnedByPlayer(vehicle, true)
	SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
	SetVehicleEngineOn(vehicle, true, true, false)

	if modelName == "polbike3" then
		ModifyVehicleTopSpeed(vehicle, 0.0) -- reset first to avoid doubling up issue
        ModifyVehicleTopSpeed(vehicle, 30.0)
	end

	if userJob == "ems" then
		if modelName == "maverick2" then
			SetVehicleLivery(vehicle, 1)
		end
	elseif userJob == "sheriff" then
		if modelName == "maverick2" then
			SetVehicleLivery(vehicle, 3)
		end
	end

	local vehicle_key = {
		name = "Key -- " .. GetVehicleNumberPlateText(vehicle),
		quantity = 1,
		type = "key",
		owner = "GOVT",
		make = "GOVT",
		model = "GOVT",
		plate = GetVehicleNumberPlateText(vehicle)
	}

	TriggerServerEvent("garage:giveKey", vehicle_key)

	local plate = GetVehicleNumberPlateText(vehicle)
	TriggerServerEvent('mdt:addTempVehicle', 'Govt. Vehicle [' .. userJob .. ']', "", plate)
        TriggerServerEvent("fuel:setFuelAmount", plate, 100)
end)

RegisterNetEvent("vehicleCommands:setLivery")
AddEventHandler("vehicleCommands:setLivery", function(livery)
	if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
		vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		liveries = GetVehicleLiveryCount(vehicle)
		livery = tonumber(livery)
		if liveries >= livery and livery > 0 then
			SetVehicleLivery(vehicle, livery)
			TriggerEvent('usa:notify', 'Livery '..livery..' selected on vehicle.')
		else
			TriggerEvent("usa:notify", livery..' is not a valid livery, maximum: '..liveries)
		end
	else
		TriggerEvent('usa:notify', 'You must be in a vehicle!')
	end
end)

RegisterNetEvent("vehCommands:getVehModel")
AddEventHandler("vehCommands:getVehModel", function(requestedSelection)
	local me = PlayerPedId()
	local model = nil
	if IsPedInAnyVehicle(me, true) then
		local veh = GetVehiclePedIsIn(me, false)
		if veh then 
			model = GetEntityModel(veh)
			print("model: " .. model)
		end
	end
	TriggerServerEvent("vehCommands:gotVehModel", model, "livery", requestedSelection)
end)

RegisterNetEvent("vehicleCommands:setExtra")
AddEventHandler("vehicleCommands:setExtra", function(extra, toggle)
	if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
		vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		extra = tonumber(extra)
		if DoesExtraExist(vehicle, extra) then
			local prevEngineDamage = GetVehicleEngineHealth(vehicle)
			local prevBodyDamage = GetVehicleBodyHealth(vehicle)
			if IsVehicleExtraTurnedOn(vehicle, extra) then
				SetVehicleExtra(vehicle, extra, true)
			else
				SetVehicleExtra(vehicle, extra, false)
			end
			SetVehicleEngineHealth(vehicle, prevEngineDamage)
			SetVehicleBodyHealth(vehicle, prevBodyDamage)
		else
			TriggerEvent('usa:notify', extra..' is not a valid extra!')
		end
	else
		TriggerEvent('usa:notify', 'You must be in a vehicle!')
	end
end)

--print("hash: " .. GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)))
