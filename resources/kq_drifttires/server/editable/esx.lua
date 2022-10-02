if Config.esxSettings.enabled then
    ESX = nil
    
    if Config.esxSettings.useNewESXExport then
        ESX = exports['es_extended']:getSharedObject()
    else
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
    
    ESX.RegisterUsableItem(Config.items.carjackItem, function(source)
        TriggerClientEvent('kq_drifttires:client:useJackstand', source)
    end)
    
    
    if not Config.advancedMode or Config.debug then
        ESX.RegisterUsableItem(Config.items.driftTireItem, function(source)
            TriggerClientEvent('kq_drifttires:client:takeOutTire', source, 1)
        end)
    
        ESX.RegisterUsableItem(Config.items.regularTireItem, function(source)
            TriggerClientEvent('kq_drifttires:client:takeOutTire', source, 0)
        end)
    end
    
    
    ----------------------------------------------------------------
    
    function CanAfford(player, amount)
        local xPlayer = ESX.GetPlayerFromId(player)
    
        if xPlayer.getAccount(Config.esxSettings.moneyAccount).money < amount then
            return false
        end
        
        return true
    end
    
    function RemoveMoney(player, amount)
        local xPlayer = ESX.GetPlayerFromId(player)
        if not xPlayer then
            return false
        end
    
        if not CanAfford(player, amount) then
            return false
        end
        
        xPlayer.removeAccountMoney(Config.esxSettings.moneyAccount, amount)
        return true
    end
    
    function AddMoney(player, amount)
        local xPlayer = ESX.GetPlayerFromId(player)
        if not xPlayer then
            return false
        end
        
        xPlayer.addAccountMoney(Config.esxSettings.moneyAccount, amount)
    end
    
    
    function DoesPlayerHaveItem(player, item, amount)
        local xPlayer = ESX.GetPlayerFromId(player)
        
        return xPlayer.getInventoryItem(item).count >= (amount or 1)
    end
    
    function RemovePlayerItem(player, item, amount)
        if DoesPlayerHaveItem(player, item, amount or 1) then
            local xPlayer = ESX.GetPlayerFromId(tonumber(player))
            xPlayer.removeInventoryItem(item, amount or 1)
            return true
        end
        return false
    end
    
    function AddPlayerItem(player, item, amount)
        local xPlayer = ESX.GetPlayerFromId(tonumber(player))
        
        -- Support for old esx which didn't use weight for inventory size but rather item limit per item type
        if Config.esxSettings.oldEsx then
            local esxItem = xPlayer.getInventoryItem(item)
            
            if esxItem.limit == -1 or (esxItem.count + amount) <= esxItem.limit then
                xPlayer.addInventoryItem(item, amount or 1)
                return true
            else
                return false
            end
        else
            if xPlayer.canCarryItem(item, amount or 1) then
                xPlayer.addInventoryItem(item, amount or 1)
                return true
            else
                return false
            end
        end
    end
    
    function _GetPlayerIdentifier(player)
        local xPlayer = ESX.GetPlayerFromId(player)
        
        return xPlayer.identifier
    end
    ----------------------------------------------------------------
end
