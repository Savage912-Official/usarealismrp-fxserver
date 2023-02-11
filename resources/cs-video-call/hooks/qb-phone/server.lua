return function(resource)
    local qbCoreFramework = nil
    
    if (QBCore) then
        qbCoreFramework = QBCore
    else
        TriggerEvent('QBCore:GetObject', function(obj)
            qbCoreFramework = obj
        end)
    
        if (not qbCoreFramework) then
            qbCoreFramework = exports['qb-core']:GetCoreObject()
        end
    end

    function ParseCallContact(TargetData, CallId, AnonymousCall)
        local player = source
        local target = qbCoreFramework.Functions.GetPlayerByPhone(TargetData.number) or qbCoreFramework.Functions.GetPlayerByPhone(tonumber(TargetData.number))

        if (target ~= nil and (target.PlayerData and target.PlayerData.source or target.source)) then
            TriggerClientEvent('cs-video-call:custom:setCallee', player, target.PlayerData and target.PlayerData.source or target.source)
            TriggerClientEvent('cs-video-call:custom:setCallee', target.PlayerData and target.PlayerData.source or target.source, player)
        end
    end

    function ParseSetCallState(bool)
        local src = source

        if (not bool) then
            TriggerClientEvent('cs-video-call:custom:clearCallee', src)
        end
    end

    RegisterNetEvent('qb-phone:server:CallContact', ParseCallContact)
    RegisterNetEvent('qb-phone_new:server:CallContact', ParseCallContact)
    RegisterNetEvent('qb-phone:server:SetCallState', ParseSetCallState)
    RegisterNetEvent('qb-phone_new:server:SetCallState', ParseSetCallState)
end
