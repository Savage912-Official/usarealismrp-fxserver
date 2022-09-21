local searchedDumpsters = {}
local nearbyDumpster = nil

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

-- nearby dumpster finder
Citizen.CreateThread(function()
    while true do
        local mycoords = GetEntityCoords(PlayerPedId())
        for i = 1, #Config.dumpsterObjects do
            local dumpsterHandle = GetClosestObjectOfType(mycoords.x, mycoords.y, mycoords.z, 1.0, Config.dumpsterObjects[i], false, false, false)
            if dumpsterHandle ~= 0 then
                nearbyDumpster = {
                    handle = dumpsterHandle,
                    coords = GetEntityCoords(dumpsterHandle)
                }
                break
            else
                nearbyDumpster = nil
            end
        end
        Wait(300)
    end
end)

-- 3d text
Citizen.CreateThread(function()
    while true do
        if nearbyDumpster then
            DrawText3D(nearbyDumpster.coords.x, nearbyDumpster.coords.y, nearbyDumpster.coords.z + 1.0, '[E] - Search Dumpster') 
        end
        Wait(1)
    end
end)

-- keypress listener 
Citizen.CreateThread(function()
    while true do
        if nearbyDumpster and IsControlJustReleased(0, Config.SearchKey) then
            if not hasBeenSearched(nearbyDumpster) then
                FreezeEntityPosition(PlayerPedId(), true)
                markAsSearched(nearbyDumpster)
                exports.globals:notify("Searching Dumpster")
                exports.globals:playAnimation("amb@prop_human_bum_bin@base", "base", 10000, 49, "Searching!")
                Wait(10000)
                while securityToken == nil do
                    Wait(1)
                end
                TriggerServerEvent("usa_dumpsters:server:giveDumpsterReward", securityToken)
                FreezeEntityPosition(PlayerPedId(), false)
            else
                exports.globals:notify("Already searched")
            end
        end
        Wait(1)
    end
end)

-- dumpster search cooldowns
Citizen.CreateThread(function()
    while true do
        for i = #searchedDumpsters, 1, -1 do
            if GetGameTimer() - searchedDumpsters[i].searchTime >= Config.WaitTime * 60 * 1000 then
                table.remove(searchedDumpsters, i)
            end
        end
        Wait(1)
    end
end)

function hasBeenSearched(dumpster)
    for i = 1, #searchedDumpsters do
        -- object handle the same ?
        if searchedDumpsters[i].handle == dumpster.handle then
            return true
        end
        -- coords the same? for the case where the handle is changed (like despawning/respawning bins)
        local distBetween = #(dumpster.coords - searchedDumpsters[i].coords)
        if distBetween <= 1.0 then
            return true
        end
    end 
    return false
end

function markAsSearched(dumpster)
    table.insert(searchedDumpsters, {
        coords = dumpster.coords,
        handle = dumpster.handle,
        searchTime = GetGameTimer()
    })
end