return function(resource)
    local QS = nil

    TriggerEvent('qs-base:getSharedObject', function(obj)
        QS = obj
    end)

    function ParseCallContact(TargetData, CallId, AnonymousCall)
        local player = source
        local target = (QS and QS.GetPlayerFromPhone and QS.GetPlayerFromPhone(TargetData.number)) or (GetPlayerFromPhone and GetPlayerFromPhone(TargetData.number))

        if (target ~= nil and target.PlayerData and target.PlayerData.source) then
            TriggerClientEvent('cs-video-call:custom:setCallee', player, target.PlayerData and target.PlayerData.source)
            TriggerClientEvent('cs-video-call:custom:setCallee', target.PlayerData and target.PlayerData.source, player)
        end
    end

    function ParseSetCallState(bool)
        local src = source

        if (not bool) then
            TriggerClientEvent('cs-video-call:custom:clearCallee', src)
        end
    end

    RegisterNetEvent('qs-smartphone:server:CallContact', ParseCallContact)
    RegisterNetEvent('qs-smartphone:server:SetCallState', ParseSetCallState)
end
