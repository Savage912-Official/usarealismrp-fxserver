if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

function DoesPlayerHaveSwitch(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local switch = Player.Functions.GetItemByName('switch')
    if (switch ~= nil) then 
        return switch.amount
    else
        return nil
    end
end

RegisterNetEvent("pswitches:toggleSwitch", function(weapon)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Inventory = Player.PlayerData.items
    if Inventory[weapon.slot] then
        if (Inventory[weapon.slot].info.switch) then 
            Player.Functions.AddItem("switch", 1, false)
            Player = QBCore.Functions.GetPlayer(src)
            Inventory = Player.PlayerData.items
            Inventory[weapon.slot].info.switch = nil
            TriggerClientEvent("pswitches:applySwitch", src, Inventory[weapon.slot], true)
        elseif (DoesPlayerHaveSwitch(src)) then
            Player.Functions.RemoveItem("switch", 1, false)
            Player = QBCore.Functions.GetPlayer(src)
            Inventory = Player.PlayerData.items
            Inventory[weapon.slot].info.switch = true
            TriggerClientEvent("pswitches:applySwitch", src, Inventory[weapon.slot], false)
        end
        Player.Functions.SetInventory(Player.PlayerData.items, true)
    end
end)