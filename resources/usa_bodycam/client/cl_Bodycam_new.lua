local bodycam = false

AddEventHandler('onResourceStop', function()
    SendNUIMessage({ action = "closeui" })
end)

RegisterNetEvent("usa_bodycam:show")
AddEventHandler("usa_bodycam:show", function(name_server, job_server)
    Animation()
    name = name_server
    job = job_server
end)

RegisterNetEvent("interaction:setPlayersJob", function(job)
    SendNUIMessage({ action = "closeui" })
end)

CreateThread(function()
    while true do
        local sleep = 2500
        if bodycam then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            local isInVeh = false
            local plate = ""
            if veh ~= 0 then 
                plate = GetVehicleNumberPlateText(veh)
                isInVeh = true
            end
            sleep = 500
            local year, month, day, hour, minute, second = GetUtcTime()
            hour = hour - 5
            if hour < 0 then
                local offset = 0 - hour
                day = day - 1
                hour = 24 - offset
            end
            if string.len(tostring(minute)) < 2 then
                minute = '0' .. minute
            end
            if string.len(tostring(second)) < 2 then
                second = '0' .. second
            end
            if string.len(tostring(month)) < 2 then
                month = '0' .. month
            end
            if string.len(tostring(day)) < 2 then
                day = '0' .. day
            end
            if not isInVeh then
                SendNUIMessage({
                    action = "update",
                    name = name,
                    job = job,
                    date = year .. '-' .. month .. '-' .. day .. ' T' .. hour .. ':' .. minute .. ':' .. second .. "EST" .. " | On Foot",
                })
            else
                SendNUIMessage({
                    action = "update",
                    name = name,
                    job = job,
                    date = year .. '-' .. month .. '-' .. day .. ' T' .. hour .. ':' .. minute .. ':' .. second .. "EST" .. " | " .. plate,
                })
            end
        end
        Wait(sleep)
    end
end)

local animation = false
--Animation
function Animation()
    local ped = PlayerPedId()
    if not animation then
        animation = true
        RequestAnimDict("clothingtie")
        while (not HasAnimDictLoaded("clothingtie")) do Wait(0) end
        TaskPlayAnim(ped, 'clothingtie', 'try_tie_negative_a', 8.0, -8, -1, 49, 0, 0, 0, 0)
        Wait(2000)
        animation = false
        ClearPedTasks(ped)
        if not bodycam then
            bodycam = true
            SendNUIMessage({ action = "loadui" })
        else
            bodycam = false
            SendNUIMessage({ action = "closeui" })
        end
    end
end