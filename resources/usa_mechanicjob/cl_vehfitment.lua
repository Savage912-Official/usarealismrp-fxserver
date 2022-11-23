local playerPed, playerVeh, fitmentZones, Key, isMechanic

veh_fitmentZones = {
	{501.79281616211, -1337.6356201172, 29.3177318573} -- Little Bighorn Ave Hayes Autos
}

local locationsData = {}
for i = 1, #veh_fitmentZones do
	table.insert(locationsData, {
		coords = vector3(veh_fitmentZones[i][1], veh_fitmentZones[i][2], veh_fitmentZones[i][3] + 1.0),
		text = "[E] - Vehicle Fitment"
	})
end
exports.globals:register3dTextLocations(locationsData)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		playerPed = PlayerPedId()
		playerVeh = GetVehiclePedIsIn(playerPed, false)
        Key = 38
		if IsControlJustPressed(0, Key) and IsPedSittingInAnyVehicle(playerPed) then
			for i = 1, #veh_fitmentZones do
				fitmentZones = veh_fitmentZones[i]
				if Vdist(GetEntityCoords(playerPed), fitmentZones[1], fitmentZones[2], fitmentZones[3]) < 3 and GetPedInVehicleSeat(playerVeh, -1) == playerPed and not IsEntityDead(playerPed) then
                    isMechanic = TriggerServerCallback {
                        eventName = "usa_mechanicjob:isMechanic",
                        args = {}
                    }
					if isMechanic then
						exports['ae-fitment']:OpenMenu()
                    else
                        exports.globals:notify("Not a Mechanic!")
                    end
				end
			end
		end
	end
end)