veh_fitmentZones = {
	{486.74206542969, -1308.3701171875, 28.778160095215}, -- Hayes Autos Little Bighorn Ave
	{1139.0323486328, -781.77801513672, 57.118770599365}, -- Untamed Autos Mirror Park
	{536.11303710938, -188.32655334473, 53.665603637695}, -- Auto Exotic Elgin Ave
	{-1423.9577636719, -449.70217895508, 35.02954864502}, -- Hayes Autos Blvd Del Perro
	{-222.36390686035, -1329.4844970703, 30.406702041626}, -- Southside Bennys Alta St
	{1182.6217041016, 2639.2448730469, 37.311477661133} -- Harmony Repairs Route 68
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
		local playerPed = PlayerPedId()
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
        local Key = 38
		if IsControlJustPressed(0, Key) and IsPedSittingInAnyVehicle(playerPed) then
			for i = 1, #veh_fitmentZones do
				local fitmentZones = veh_fitmentZones[i]
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