if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

local WeaponData

function ShowNotification(text)
	AddTextEntry('qbNotify', text)
	BeginTextCommandThefeedPost('qbNotify')
	EndTextCommandThefeedPostTicker()
end

RegisterCommand("pswitch", function(source)
    if (WeaponData and Config.Weapons[WeaponData.name]) then 
        TriggerServerEvent('pswitches:toggleSwitch', WeaponData)
    else
        ShowNotification("You need to have a weapon out that has switch compatibility.")
    end
end)

RegisterNetEvent('inventory:client:UseWeapon', function(weaponData, shootbool)
    WeaponData = weaponData
    if (Config.Weapons[weaponData.name] and WeaponData.info.switch) then 
        SetSwitchData({name = WeaponData.name, slot = WeaponData.slot, switch = WeaponData.info.switch})
    else
        SetSwitchData(nil)
    end
end)

RegisterNetEvent("pswitches:applySwitch", function(weapon, removed)
    if (weapon) then 
        WeaponData = weapon
        if (not removed) then 
            ShowNotification("Applying Switch...")
            Citizen.Wait(5000)
            ShowNotification("Applied Switch!")
            SetSwitchData({name = WeaponData.name, slot = WeaponData.slot, switch = WeaponData.info.switch})
        else
            ShowNotification("Removing Switch...")
            Citizen.Wait(5000)
            ShowNotification("Removed Switch!")
            SetSwitchData(nil)
        end 
    else
        ShowNotification("Failed to apply / remove the switch.")
    end
end)

RegisterNetEvent("pswitches:showNotification", function(text)
    ShowNotification(text)
end)