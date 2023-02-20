if GetResourceState('es_extended') ~= 'started' then return end

Inventory = exports.ox_inventory

RegisterCommand("pswitch", function(source)
    local weapon = Inventory:GetCurrentWeapon(source)
    if (weapon and Config.Weapons[weapon.name]) then 
        if (weapon.metadata.switch == nil) then 
            local switches = Inventory:Search(source, "count", "switch")
            if (switches > 0) then 
                weapon.metadata.switch = true
                Inventory:SetMetadata(source, weapon.slot, weapon.metadata)
                Inventory:RemoveItem(source, "switch", 1)
                TriggerClientEvent("pswitches:applySwitch", source, weapon)
            else
                TriggerClientEvent("pswitches:showNotification", source, "You don't have a switch!")
            end
        else
            weapon.metadata.switch = nil
            Inventory:SetMetadata(source, weapon.slot, weapon.metadata)
            Inventory:AddItem(source, "switch", 1)
            TriggerClientEvent("pswitches:applySwitch", source, weapon, true)
        end
    else
        TriggerClientEvent("pswitches:showNotification", source, "You don't have a weapon out!")
    end
end)