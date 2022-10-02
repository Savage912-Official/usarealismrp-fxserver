if Config.standaloneSettings.enabled then
    
    RegisterCommand('jackvehicle', function(source)
        TriggerClientEvent('kq_drifttires:client:useJackstand', source)
    end)
    
    
    if not Config.advancedMode or Config.debug then
        RegisterCommand('getdrifttire', function(source)
            TriggerClientEvent('kq_drifttires:client:takeOutTire', source, 1)
        end)
    
        RegisterCommand('getregulartire', function(source)
            TriggerClientEvent('kq_drifttires:client:takeOutTire', source, 0)
        end)
    end
end
