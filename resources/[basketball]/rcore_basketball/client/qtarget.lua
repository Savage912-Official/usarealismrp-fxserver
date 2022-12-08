TargetingData = {}

function GetTargetFunction()
    return Config.TargetResourceName;
end

function SetTargetingStatusFree(hoopData)
    local key = 'basketball_free_' .. hoopData.index
    
    if not TargetingData[key] then
        TargetingData[key] = {
            removeAt = GetGameTimer() + 100,
        }
        CreateTargetFreeZone(key, hoopData.groundPos, hoopData.hoopHeading, hoopData.index)
    else
        TargetingData[key].removeAt = GetGameTimer() + 100
    end
end

function SetTargetingStatusJoin(hoopData)
    local key = 'basketball_join_' .. hoopData.index
    
    if not TargetingData[key] then
        TargetingData[key] = {
            removeAt = GetGameTimer() + 100,
        }
        CreateTargetJoinZone(key, hoopData.groundPos, hoopData.hoopHeading, hoopData.index)
    else
        TargetingData[key].removeAt = GetGameTimer() + 100
    end
end


function SetTargetingTakeHoop(hoopData)
    local key = 'basketball_takehoop_' .. hoopData.index
    
    if not TargetingData[key] then
        TargetingData[key] = {
            removeAt = GetGameTimer() + 100,
        }
        CreateTakeHoop(key, hoopData.hoopEntity, hoopData.index)
    else
        TargetingData[key].removeAt = GetGameTimer() + 100
    end
end



function SetTargetingPickupBall(hoopData, pickupPos, idx)
    local key = 'basketball_pickup_' .. hoopData.index .. '_' .. idx
    
    if not TargetingData[key] then
        TargetingData[key] = {
            removeAt = GetGameTimer() + 100,
        }
        CreateTargetPickupZone(key, hoopData.ballEntity, hoopData.index)
    else
        TargetingData[key].removeAt = GetGameTimer() + 100
    end
end

function SetTargetingFinishSetup(hoopData)
    local key = 'basketball_setup_' .. hoopData.index
    
    if not TargetingData[key] then
        TargetingData[key] = {
            removeAt = GetGameTimer() + 100,
        }
        CreateTargetSetupZone(key, hoopData.groundPos, hoopData.hoopHeading, hoopData.index)
    else
        TargetingData[key].removeAt = GetGameTimer() + 100
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(250)

        local time = GetGameTimer()

        for key, data in pairs(TargetingData) do
            if data.removeAt < time then
                RemoveTargetBoxZone(key)
                TargetingData[key] = nil
            end
        end
    end
end)

function CreateTargetFreeZone(name, pos, heading, hoopId)
    exports[GetTargetFunction()]:AddBoxZone(name, pos, 1.5, 1.5, {
        name=name,
        heading=heading,
        debugPoly=false,
        minZ=pos.z-0.5,
        maxZ=pos.z+0.5,
    }, {
        options = {
            {
                event = "rcore_basketball:freeOpenNui",
                icon = "fas fa-folder-open",
                label = Config.Text.T_OPEN,
                hoopId = hoopId,
            },
        },
        distance = 3.5
    })
end

function CreateTargetJoinZone(name, pos, heading, hoopId)
    exports[GetTargetFunction()]:AddBoxZone(name, pos, 1.5, 1.5, {
        name=name,
        heading=heading,
        debugPoly=false,
        minZ=pos.z-0.5,
        maxZ=pos.z+0.5,
    }, {
        options = {
            {
                event = "rcore_basketball:openNui",
                icon = "fas fa-folder-open",
                label = Config.Text.T_OPEN,
                hoopId = hoopId,
            },
        },
        distance = 3.5
    })
end

function CreateTakeHoop(name, entity, hoopId)
    exports[GetTargetFunction()]:AddEntityZone(name, entity, {
        name=name,
        debugPoly=false,
        useZ = true,
    }, {
        options = {
            {
                event = "rcore_basketball:removeHoop",
                icon = "fas fa-trash",
                label = Config.Text.REMOVE_HOOP,
                hoopId = hoopId,
            },
        },
        distance = 8.0
    })
end

function CreateTargetSetupZone(name, pos, heading, hoopId)
    exports[GetTargetFunction()]:AddBoxZone(name, pos, 1.5, 1.5, {
        name=name,
        heading=heading,
        debugPoly=false,
        minZ=pos.z-0.5,
        maxZ=pos.z+0.5,
    }, {
        options = {
            {
                event = "rcore_basketball:finishHoopSetup",
                icon = "fas fa-flag-checkered",
                label = Config.Text.T_FINISH_SETUP,
                hoopId = hoopId,
            },
        },
        distance = 3.5
    })
end

function CreateTargetPickupZone(name, entity, hoopId)
    exports[GetTargetFunction()]:AddEntityZone(name, entity, {
        name=name,
        debugPoly=false,
        useZ = true,
    }, {

        options = {
            {
                event = "rcore_basketball:pickup",
                icon = "fas fa-up-long",
                label = Config.Text.T_PICKUP,
                hoopId = hoopId,
            },
        },
        distance = 3.5
    })
end

function RemoveTargetBoxZone(name)
    exports[GetTargetFunction()].RemoveZone(name, name)
end

AddEventHandler('rcore_basketball:pickup', function(data)
    SetPedLookAtBall(PlayerPedId(), BasketballHoops[data.hoopId].ballEntity)
    PlayPickupAnim(PlayerPedId())
    TriggerServerEvent('rcore_basketball:pickupBall')
end)


AddEventHandler('rcore_basketball:freeOpenNui', function(data)
    if Config.RequireBasketball then
        TriggerServerEvent('rcore_basketball:requestOpenSetup', data.hoopId)
    else
        OpenNUI(data.hoopId)
    end
end)

RegisterNetEvent('rcore_basketball:openNui', function(data)
    OpenNUI(data.hoopId)
end)

AddEventHandler('rcore_basketball:finishHoopSetup', function(data)
    TriggerServerEvent('rcore_basketball:finishHoopSetup')
end)

AddEventHandler('onResourceStop', function(name)
    if GetCurrentResourceName() == name then
        for key, data in pairs(TargetingData) do
			RemoveTargetBoxZone(key)
		end
    end
end)

AddEventHandler('rcore_basketball:removeHoop', function(data)
    TriggerServerEvent('rcore_basketball:takeHoop', data.hoopId)
end)