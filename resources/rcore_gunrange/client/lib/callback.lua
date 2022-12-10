---TAKEN FROM rcore framework
---https://githu.com/Isigar/relisoft_core
---https://docs.rcore.cz

local clientCallbacks = {}
local currentRequest = 0
local dbg = rdebug()

function callCallback(name, cb, ...)
    dbg.debug('Calling event %s', name)
    clientCallbacks[currentRequest] = cb
    TriggerServerEvent(triggerName('callCallback'), name, currentRequest, GetPlayerServerId(PlayerId()), ...)

    if currentRequest < 65535 then
        currentRequest = currentRequest + 1
    else
        currentRequest = 0
    end
end

exports('callCallback', callCallback)

RegisterNetEvent(triggerName('callback'))
AddEventHandler(triggerName('callback'), function(requestId, ...)
    if clientCallbacks[requestId] == nil then
        return
    end
    clientCallbacks[requestId](...)
end)
