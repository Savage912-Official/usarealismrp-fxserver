local vein = exports.vein -- Store it in local variable for performance reasons
local globals = exports.globals

local windowX, windowY
local isWindowOpened = false
local lastStoredLocation = nil
local lastSelectedVehPlate = nil
local lastAutomaticTowCost = nil
local lastGarageCoords = nil

RegisterNetEvent("garage:toggleModal")
AddEventHandler("garage:toggleModal", function(selectedVehPlate, storedLocation, automaticTowCost, garageCoords)
    isWindowOpened = not isWindowOpened
    if isWindowOpened then
        lastSelectedVehPlate = selectedVehPlate
        lastStoredLocation = storedLocation
        lastAutomaticTowCost = automaticTowCost
        lastGarageCoords = garageCoords
    else
        lastSelectedVehPlate = nil
        lastStoredLocation = nil
        lastAutomaticTowCost = nil
        lastGarageCoords = nil
    end
end)

local function drawLabel(text)
	vein:setNextWidgetWidth(labelWidth)
	vein:label(text)
end

Citizen.CreateThread(function()
    while true do
        if isWindowOpened then

            vein:beginWindow(windowX, windowY) -- Mandatory

            vein:beginRow()
                drawLabel('That car is not at this garage.')
            vein:endRow()

            vein:beginRow()
                drawLabel('You can set a waypoint to where it is located or pay a fee of $' .. globals:comma_value(lastAutomaticTowCost) .. ' to have it towed here.')
            vein:endRow()

            vein:beginRow()
                if vein:button('Set Waypoint') then
                    SetNewWaypoint(lastStoredLocation.x, lastStoredLocation.y)
                    exports.globals:notify("Waypoint set! Check map")
                    isWindowOpened = false
                end
                if vein:button('Tow Here') then
                    TriggerServerEvent("garage:automaticTow", lastSelectedVehPlate, lastGarageCoords)
                    isWindowOpened = false
                end
                if vein:button('Close') then
                    isWindowOpened = false
                end
            vein:endRow()

            windowX, windowY = vein:endWindow() -- Mandatory
        end
        Wait(0)
    end
end)