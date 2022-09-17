local searched = {3423423424}
local canSearch = true
local dumpsters = {218085040, 666561306, -58485588, -206690185, 1511880420, 682791951}
local idle = 0
local dumpPos
local nearDumpster = false
local maxDistance = 2.5
local listening = false
--local dumpster
local currentCoords = nil

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    local dist = 0
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local playerCoords, awayFromGarbage = GetEntityCoords(PlayerPedId()), true
        if not nearDumpster then
            for i = 1, #dumpsters do
                local distance
                dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters[i], false, false, false)
                if dumpster ~= 0 then
                    dumpster = dumpster 
                end
                dumpPos = GetEntityCoords(dumpster)
                local distance = #(pos - dumpPos)
                if distance < maxDistance then
                    currentCoords = dumpPos
                end
                if distance < maxDistance then
                    awayFromGarbage = false
                    nearDumpster = true
                    if not listening then
                        dumpsterKeyPressed()
                    end
                end
            end
        end
        if currentCoords ~= nil and #(currentCoords - playerCoords) > maxDistance then
            nearDumpster = false
            listening = false
        end
        if awayFromGarbage then
            Citizen.Wait(1000)
        end
    end
end)

function dumpsterKeyPressed()
    listening = true
    Citizen.CreateThread(function()
        while listening do
            local dumpsterFound = false
            Citizen.Wait(0)
            DrawText3D(currentCoords.x, currentCoords.y, currentCoords.z + 1.0, '[E] - Search Dumpster')
            if IsControlJustReleased(0, Config.SearchKey) then
                for i = 1, #searched do
                    if searched[i] == dumpster then
                        dumpsterFound = true
                    end
                    if i == #searched and dumpsterFound then
                        exports.globals:notify("Dumpster already searched!")
                    elseif i == #searched and not dumpsterFound then
                        exports.globals:notify("Searching Dumpster")
                        exports.globals:playAnimation("amb@prop_human_bum_bin@base", "base", 1500, 49, "Searching!")
                        Wait(1500)
                        while securityToken == nil do
                            Wait(1)
                        end
                        TriggerServerEvent("usa_dumpsters:server:giveDumpsterReward", securityToken)
                        TriggerServerEvent('usa_dumpsters:server:startDumpsterTimer', dumpster)
                        table.insert(searched, dumpster)
                    end
                end
            end
        end
    end)
end

RegisterNetEvent('usa_dumpsters:client:removeDumpster')
AddEventHandler('usa_dumpsters:client:removeDumpster', function(object)
    for i = #searched, 1, -1 do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)