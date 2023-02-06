return function(resource)
    RegisterNetEvent('high_phone:pickupCall', function(number)
        local callee = source
        local caller = getSourceByNumber(number)

        if (callee and caller) then
            TriggerClientEvent('cs-video-call:custom:setCallee', caller, callee)
            TriggerClientEvent('cs-video-call:custom:setCallee', callee, caller)
        end
    end)

    RegisterNetEvent('high_phone:endCall', function()
        local source = source        
        TriggerClientEvent('cs-video-call:custom:clearCallee', source)
    end)
end
