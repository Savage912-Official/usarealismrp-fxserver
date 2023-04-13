local locationsData = {}
for i = 1, #Config.Fitment_Locations do
	table.insert(locationsData, {
		coords = vector3(Config.Fitment_Locations[i][1], Config.Fitment_Locations[i][2], Config.Fitment_Locations[i][3] + 1.0),
		text = "[E] - Vehicle Fitment"
	})
end
exports.globals:register3dTextLocations(locationsData)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
        local Key = 38
		if IsControlJustPressed(0, Key) and IsPedSittingInAnyVehicle(playerPed) then
			for i = 1, #Config.Fitment_Locations do
				local fitmentZones = Config.Fitment_Locations[i]
				if Vdist(GetEntityCoords(playerPed), fitmentZones[1], fitmentZones[2], fitmentZones[3]) < 3 and GetPedInVehicleSeat(playerVeh, -1) == playerPed and not IsEntityDead(playerPed) then
                    local isMechanic = TriggerServerCallback {
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
