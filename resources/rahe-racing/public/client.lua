-- Not used by the encrypted code. Registers the racing command (/racing) when you have commands enabled.
-- RegisterCommand("racing", function()
--     if clConfig.commandsEnabled then
--         openTablet()
--     end
-- end)

-- Not used by the encrypted code. Gives you the opportunity to open the racing tablet client-side.
-- This can be used from any other client-side file by using 'exports['rahe-racing']:openRacingTablet()'.
function openRacingTablet()
    openTablet()
end

local isVisible = false
local tabletObject = nil
-- Not used by the encrypted code. Gives you the opportunity to open the racing tablet client-side, also used by the server-side file.
-- This can be used from any other client-side file by using 'TriggerEvent('rahe-racing:client:openTablet')'.
RegisterNetEvent('rahe-racing:client:openTablet', function()
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
        lib.notify({
            title = "You need a Tablet to use this dongle!",
            position = 'center-left',
            type = 'error'
        })
    end
end)

-- Used by the encrypted code to send notifications to players.
function notifyPlayer(message)
    lib.notify({
        title = message,
        position = 'center-left',
        type = 'inform'
    })
end

-- Not used by the encrypted code. Allows you to add logic when the tablet is closed.
-- For example if you started an animation when opened, you can end the animation here.
RegisterNetEvent('rahe-racing:client:tabletClosed', function()
    local playerPed = PlayerPedId()
    DeleteEntity(tabletObject)
    ClearPedTasks(playerPed)
    tabletObject = nil
end)
