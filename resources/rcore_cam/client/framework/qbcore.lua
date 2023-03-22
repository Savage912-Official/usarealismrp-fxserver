if Config.Framework.QBCORE then
    TriggerEvent('rcore:GetMainObject', 'qbcore', 'qb-core', function(QBCore)
        function IsPlayerCop()
            local playerJob = QBCore.Functions.GetPlayerData().job
            
            return playerJob and playerJob.name and Config.CamAccessWhitelist[playerJob.name]
        end
    end)
end