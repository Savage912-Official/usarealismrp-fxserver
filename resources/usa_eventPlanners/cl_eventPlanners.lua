local JOB_TOGGLE_TEXT = "[E] - Toggle Duty (Event Planner)"
local JOB_TOGGLE_KEY = 38
local client_blips = {}
local scriptStart = GetGameTimer()

Citizen.CreateThread(function()
    TriggerServerEvent('usa_eventPlanners:server:syncBlips')
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

RegisterNetEvent('usa_eventPlanners:client:blipDialog')
AddEventHandler('usa_eventPlanners:client:blipDialog', function()

    local input = lib.inputDialog('Temporary Blip Information', {
        {type = 'input', label = 'Name', description = 'Blip Name Shown On Map'},
        {type = 'number', label = 'Duration (In Minutes)', description = 'How long the blip should be on the map'},
        {type = 'input', label = 'Icon', description = 'Icon of the blip (Reference list you were given.)'},
        {type = 'input', label = 'Color', description = 'Color of the blip (Reference list you were given.)'}
    })

    local playerPed = PlayerPedId()
    local x, y, z = GetEntityCoords(playerPed)
    local name = input[1]
    local duration = input[2] * 60000
    local sprite = tonumber(input[3])
    local color = tonumber(input[4])

    TriggerServerEvent('usa_eventPlanners:server:addBlip', {x = x, y = y, z = z, name = name, duration = duration, sprite = sprite, color = color})

end)

RegisterNetEvent('usa_eventPlanners:client:removeBlip')
AddEventHandler('usa_eventPlanners:client:removeBlip', function(blipName)

    for k, v in pairs(client_blips) do
        if v.name == blipName then
            RemoveBlip(v.blip)
            table.remove(client_blips, k)
        end
    end

end)

RegisterNetEvent('usa_eventPlanners:client:addBlip')
AddEventHandler('usa_eventPlanners:client:addBlip', function(blipData)

    for k, v in pairs(blipData) do

        name = "Event: " .. v.name

        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, v.sprite)
        SetBlipColour(blip, v.color)
        SetBlipScale(blip, 1.0)
        SetBlipDisplay(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(name)
        EndTextCommandSetBlipName(blip)


        table.insert(client_blips, {blip = blip, name = v.name})

        if GetGameTimer() - scriptStart > 30000 then
            TriggerEvent('usa:notify', "Event: " .. v.name .. " created! Check your map!", "Event: " .. v.name .. " created! Check your map!")
        end
    end

    

end)