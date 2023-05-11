local vein = exports.vein -- Store it in local variable for performance reasons

local windowX, windowY
local isWindowOpened = false
local trucks = nil

RegisterNetEvent("mechanic:openTruckSpawnMenuCL")
AddEventHandler("mechanic:openTruckSpawnMenuCL", function(availableTrucks)
    trucks = availableTrucks
    isWindowOpened = true
end)

local function drawLabel(text)
	vein:setNextWidgetWidth(labelWidth)
	vein:label(text)
end

local function SpawnTruck(model)
    local mycoords = GetEntityCoords(PlayerPedId(), false)
	for name, info in pairs(Config.Mechanic_Locations) do
		local dutyCoordsVector = vector3(info.duty.x, info.duty.y, info.duty.z)
		if Vdist(mycoords, dutyCoordsVector) < 10 then
            if model == "isgtow" or model == "wrecker" then
                SpawnJobVeh(info.truck_spawn, model, "HeavyHauler")
            elseif model == "flatbed" or model == "fordflatbed" then
                SpawnJobVeh(info.truck_spawn, model, "TowFlatbed")
            end
            isWindowOpened = false
            return
        end
    end
end

Citizen.CreateThread(function()
    while true do
        if isWindowOpened then

            vein:beginWindow(windowX, windowY) -- Mandatory

            vein:beginRow()
                drawLabel('Select tow truck:')
            vein:endRow()

            vein:beginRow()
                for i = 1, #trucks do
                    if vein:button(trucks[i]) then
                        SpawnTruck(trucks[i])
                    end
                end
            vein:endRow()

            if vein:button('Close') then -- Draw button and check if it were pressed
                isWindowOpened = false
            end

            windowX, windowY = vein:endWindow() -- Mandatory
        end
        Wait(0)
    end
end)
