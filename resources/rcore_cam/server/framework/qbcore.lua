if Config.Framework.QBCORE then
    TriggerEvent('rcore:GetMainObject', 'qbcore', 'qb-core', function(QBCore)
        SendNotification = function(source, text)
            TriggerClientEvent('QBCore:Notify', source, text)
        end

        function GetPlayerIdentifier(serverId)
            local qbPlayer = QBCore.Functions.GetPlayer(serverId)

            return qbPlayer.PlayerData.citizenid
        end
    end)
end