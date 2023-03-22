AddEventHandler('rcore_cam:do', function(serverId, text)
    TriggerClientEvent('rcore_cam:do', serverId, text)
end)

AddEventHandler('rcore_me:me', function(serverId, text)
    TriggerClientEvent('rcore_cam:me', serverId, text)
end)

AddEventHandler('rcore_cam:me', function(serverId, text)
    TriggerClientEvent('rcore_cam:me', serverId, text)
end)
