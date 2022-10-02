if Config.qbSettings.enabled then
    --[[if Config.qbSettings.useNewQBExport then
        QBCore = exports['qb-core']:GetCoreObject()
    end
    
    QBCore.Functions.CreateUseableItem(Config.items.carjackItem, function(source)
        TriggerClientEvent('kq_drifttires:client:useJackstand', source)
    end)
    
    
    if not Config.advancedMode or Config.debug then
        QBCore.Functions.CreateUseableItem(Config.items.driftTireItem, function(source)
            TriggerClientEvent('kq_drifttires:client:takeOutTire', source, 1)
        end)
        
        QBCore.Functions.CreateUseableItem(Config.items.regularTireItem, function(source)
            TriggerClientEvent('kq_drifttires:client:takeOutTire', source, 0)
        end)
    end--]]
    
    
    ----------------------------------------------------------------
    
    function CanAfford(player, amount)
        local char = exports["usa-characters"]:GetCharacter(player)
        
        if char.get("money") == nil then
            print('^6Invalid money account set!')
        end
        
        if char.get("money") < amount then
            return false
        end
        
        return true
    end
    
    function RemoveMoney(player, amount)
        local char = exports["usa-characters"]:GetCharacter(player)
        
        if not char then
            return false
        end
        
        return char.removeMoney(amount)
    end
    
    function AddMoney(player, amount)
        local char = exports["usa-characters"]:GetCharacter(player)
        
        if not char then
            return false
        end
        
        char.giveMoney(amount)
    end
    
    function DoesPlayerHaveItem(player, item, amount)
        local char = exports["usa-characters"]:GetCharacter(player)
        
        return char.hasItem(item, amount)
    end
    
    function RemovePlayerItem(player, item, amount)
        if DoesPlayerHaveItem(player, item) then
            local char = exports["usa-characters"]:GetCharacter(player)
            char.removeItem(item, amount)
            
            return true
        end
        return true
    end
    
    function AddPlayerItem(player, item, amount)
        local char = exports["usa-characters"]:GetCharacter(player)
        return char.giveItem(item)
    end
    
    function _GetPlayerIdentifier(player)
        local char = exports["usa-characters"]:GetCharacter(source)

        return char.get("_id")
    end
    ----------------------------------------------------------------
end