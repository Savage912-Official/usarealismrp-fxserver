local JOB_TOGGLE_TEXT = "[E] - Toggle Duty (Event Planner)"
local JOB_TOGGLE_KEY = 38

Citizen.CreateThread(function()
    while true do
        local me = PlayerPedId()
        local mycoords = GetEntityCoords(me)
        for i = 1, #JOB_TOGGLE_LOCATIONS do
            local location = JOB_TOGGLE_LOCATIONS[i]
            local dist = Vdist2(location, mycoords)
            if dist < TEXT_3D_DRAW_DIST then
                DrawText3D(location.x, location.y, location.z, JOB_TOGGLE_TEXT)
                if dist < 1.2 then
                    if IsControlJustPressed(0, JOB_TOGGLE_KEY) then
                        TriggerServerEvent("eventPlanner:toggleDuty")
                    end
                end
            end
        end
        Wait(1)
    end
end)

local temporaryBlips = {}
RegisterNetEvent('usa_eventPlanners:client:blipDialog')
AddEventHandler('usa_eventPlanners:client:blipDialog', function()
    local input = lib.inputDialog('Temporary Blip Information', {
        {type = 'input', label = 'Coordinates', description = 'Format: x, y, z'},
        {type = 'input', label = 'Name', description = 'Blip Name Shown On Map'},
        {type = 'number', label = 'Duration (In Minutes)', description = 'How long the blip should be on the map'},
        {type = 'input', label = 'Icon', description = 'Icon of the blip (Reference list you were given.)'},
        {type = 'input', label = 'Color', description = 'Color of the blip (Reference list you were given.)'}
    })

    local coordinates = input[1]
    local x, y, z = string.match(coordinates, "([^,]+),([^,]+),([^,]+)")
    x, y, z = tonumber(x), tonumber(y), tonumber(z)
    local name = input[2]
    local duration = input[3] * 60000
    local sprite = tonumber(input[4])
    local color = tonumber(input[5])

    print(string.format("A new blip has been created with sprite %s and color %s at coordinates (%.2f, %.2f, %.2f). Name: %s, Duration: %s Minutes", sprite, color, x, y, z, name, duration / 60000))

    TriggerServerEvent('usa_eventPlanners:server:addBlip', {x, y, z, name, duration, sprite, color})
end)

RegisterNetEvent('usa_eventPlanners:client:addBlip')
AddEventHandler('usa_eventPlanners:client:addBlip', function(blipData)
    local x, y, z, name, duration, sprite, color = table.unpack(blipData)
    
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, 1.0)
    SetBlipDisplay(blip, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(name)
    EndTextCommandSetBlipName(blip)

    local blipData = {blip = blip, endTime = GetGameTimer() + duration}
    table.insert(temporaryBlips, blipData)

    TriggerEvent('usa:notify', "Blip has been added!")
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for i, blipData in ipairs(temporaryBlips) do
            RemoveBlip(blipData.blip)
        end
        temporaryBlips = {}
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local currentTime = GetGameTimer()
        for i, blipData in ipairs(temporaryBlips) do
            if currentTime >= blipData.endTime then
                RemoveBlip(blipData.blip)
                table.remove(temporaryBlips, i)
            end
        end
    end
end)
