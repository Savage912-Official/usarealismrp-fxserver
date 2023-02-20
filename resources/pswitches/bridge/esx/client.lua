if GetResourceState('es_extended') ~= 'started' then return end

Inventory = exports.ox_inventory

RegisterNetEvent("ox_inventory:currentWeapon", function(item)
    if (item ~= nil and item.metadata.switch) then 
        SetSwitchData({name = item.name, serial = item.metadata.serial})
    else
        SetSwitchData(nil)
    end
end)

RegisterNetEvent("pswitches:applySwitch", function(item, removed)
    local item <const> = item
    if (not removed and item.metadata.switch) then 
        ESX.ShowNotification("Applying Switch...")
        lib.progressBar({
            duration = 5000,
            label = 'Applying Switch...',
        })
        ESX.ShowNotification("Applied Switch!")
        SetSwitchData({name = item.name, serial = item.metadata.serial})
    else
        ESX.ShowNotification("Removing Switch...")
        lib.progressBar({
            duration = 5000,
            label = 'Removing Switch...',
        })
        ESX.ShowNotification("Removed Switch!")
        SetSwitchData(nil)
    end
end)

RegisterNetEvent("pswitches:showNotification", function(text)
    lib.notify({
        title = text
    })
end)