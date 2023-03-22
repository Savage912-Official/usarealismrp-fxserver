if Config.Framework.ESX then
    TriggerEvent('rcore:GetMainObject', 'esx', 'es_extended', function(ESX)
        SendNotification = function(source, text)
            TriggerClientEvent('esx:showNotification', source, text)
        end

        function GetPlayerIdentifier(serverId)
            local xPlayer = ESX.GetPlayerFromId(serverId)

            return xPlayer.identifier
        end
    end)
end