if Config.Framework.ESX then
    TriggerEvent('rcore:GetMainObject', 'esx', 'es_extended', function(ESX)
        function IsPlayerCop()
            local playerData = ESX.GetPlayerData()
            local playerJob = playerData.job

            return playerJob and playerJob.name and Config.CamAccessWhitelist[playerJob.name]
        end
    end)
end