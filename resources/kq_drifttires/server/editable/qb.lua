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
    local carjack = { name = "Car Jack", type = "misc",  quantity = 1,  legality = "legal", price = 500,  weight = 15,  objectModel = "imp_prop_axel_stand_01a" }
    local drifttire = { name = "Drift Tire", type = "misc",  quantity = 1,  legality = "legal",  price = 1500, weight = 15,  objectModel = "v_ind_cm_tyre08" }
    local regulartire = { name = "Regular Tire", type = "misc",  quantity = 1,  legality = "legal", price = 750, weight = 15,  objectModel = "v_ind_cm_tyre06" }

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
        if item == "Car Jack" then
            return char.hasItem(carjack)
        elseif item == "Drift Tire" then
            return char.hasItem(drifttire)
        elseif item == "Regular Tire" then
            return char.hasItem(regulartire)
        end
        --return char.hasItem(item, amount)
    end
    
    function RemovePlayerItem(player, item, amount)
        if DoesPlayerHaveItem(player, item) then
            local char = exports["usa-characters"]:GetCharacter(player)
            if item == "Car Jack" then
                return char.removeItem(carjack)
            elseif item == "Drift Tire" then
                return char.removeItem(drifttire)
            elseif item == "Regular Tire" then
                return char.removeItem(regulartire)
            end
--            char.removeItem(item, amount)            
            return true
        end
        return true
    end
    
    function AddPlayerItem(player, item, amount)
        local char = exports["usa-characters"]:GetCharacter(player)
        if item == "Car Jack" then
            return char.giveItem(carjack)
        elseif item == "Drift Tire" then
            return char.giveItem(drifttire)
        elseif item == "Regular Tire" then
            return char.giveItem(regulartire)
        end
        --return char.giveItem(item)
    end
    
    function _GetPlayerIdentifier(player)
        local char = exports["usa-characters"]:GetCharacter(source)

        return char.get("_id")
    end
    ----------------------------------------------------------------
end