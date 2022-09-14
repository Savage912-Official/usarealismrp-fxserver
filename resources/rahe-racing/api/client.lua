
-- RegisterCommand("racing", function()
--     openTablet()
-- end)

-- CLIENT export - This function is exported, so it can be opened from any other client-side script by using 'exports['rahe-racing']:openRacingTablet()'
function openRacingTablet()
    openTablet()
end

local isVisible = false
local tabletObject = nil
-- If you wish to open the tablet via. an event not the export.
RegisterNetEvent("rahe-racing:client:openTablet")
AddEventHandler("rahe-racing:client:openTablet", function()
    local hasItem = TriggerServerCallback {
        eventName = "rahe-racing:hasItem",
        args = {}
    }
    if hasItem then
        local playerPed = PlayerPedId()
        if not isVisible then
            local dict = "amb@world_human_seat_wall_tablet@female@base"
            RequestAnimDict(dict)
            if tabletObject == nil then
                tabletObject = CreateObject(GetHashKey('prop_cs_tablet'), GetEntityCoords(playerPed), 1, 1, 1)
                AttachEntityToEntity(tabletObject, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
            end
            while not HasAnimDictLoaded(dict) do Citizen.Wait(100) end
            if not IsEntityPlayingAnim(playerPed, dict, 'base', 3) then
                TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
            end
        else
            DeleteEntity(tabletObject)
            ClearPedTasks(playerPed)
            tabletObject = nil
        end
        openTablet()
    else
        TriggerEvent("usa:notify", "You need a ~r~Tablet~w~ to use this dongle!")
    end
end)

function notifyPlayer(message)
    TriggerEvent('chatMessage', "SERVER", "normal", message)
end

-- You can do some logic when the tablet is closed. For example if you started an animation when opened, you can end the animation here.
RegisterNetEvent('rahe-racing:client:tabletClosed', function()
    local playerPed = PlayerPedId()
    DeleteEntity(tabletObject)
    ClearPedTasks(playerPed)
    tabletObject = nil
end)