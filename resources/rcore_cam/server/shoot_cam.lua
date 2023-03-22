DestroyedCameras = {}

RegisterNetEvent('rcore_cam:destroySecurityCamera', function(groupId, camId, relativeDestroyedAt)
    if not GlobalState.activeCams[tostring(groupId)] then
        SetTimeout(15 * 60 * 1000, function()
            if not GlobalState.activeCams[tostring(groupId)] then
                UndestroyCamera(groupId, camId)
            end
        end)
    end

    DestroyedCameras[groupId .. '_' .. camId] = {groupId, camId, relativeDestroyedAt}
    TriggerClientEvent('rcore_cam:setCameraDestroyed', -1, {groupId, camId})
end)

AddEventHandler('playerJoining', function(source)
    TriggerClientEvent('rcore_cam:setCamerasDestroyed', source, DestroyedCameras)
end)

function UndestroyCameraGroup(groupId)
    if not AllCameras[groupId] then
        print("ERROR: Given groupId isnt in AllCameras", groupId)
    end

    for camId, _ in pairs(AllCameras[groupId]) do
        UndestroyCamera(groupId, camId)
        Wait(0)
    end
end

function UndestroyCamera(groupId, camId)
    local key = groupId .. '_' .. camId
    if DestroyedCameras[key] then
        DestroyedCameras[key] = nil
        TriggerClientEvent('rcore_cam:undestroyCamera', -1, groupId, camId)
    end
end