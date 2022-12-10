local WEBHOOK_URL = GetConvar("gunrange-logs-webhook", "")

RegisterNetEvent(triggerName('leaveLine'))
AddEventHandler(triggerName('leaveLine'), function(bullets, gunrangeIndex, boxIndex, targetIndex)
    local _source = source
    local points = 0;
    local char = exports["usa-characters"]:GetCharacter(_source)
    for i, v in pairs(bullets) do
        points = points + tonumber(v.hitPoints)
    end

    if Config.DiscordLogs then
        local msg = '```\nGun Range Exit:\n\nServer ID: ' .. source .. '\nSteam Name: ' .. GetPlayerName(source) .. '\nSteam ID: ' .. GetPlayerIdentifiers(source)[1] .. '\nCharacter: ' .. char.getFullName() .. '\nGun Range Location #: ' .. gunrangeIndex .. '\nRange Box #: ' .. boxIndex .. '\nTotal Points: ' .. points .. '\nTarget Distance: ' .. targetIndex .. '```'
        exports.globals:SendDiscordLog(WEBHOOK_URL, msg)
    end
end)

AddEventHandler(triggerName('joinLine'), function(source, gunrangeIndex, boxIndex, distanceIndex, rentPrice, gunHash, gunAmmo)
    local char = exports["usa-characters"]:GetCharacter(source)

    if Config.DiscordLogs then
        local msg = '```\nGun Range Entry:\n\nServer ID: ' .. source .. '\nSteam Name: ' .. GetPlayerName(source) .. '\nSteam ID: ' .. GetPlayerIdentifiers(source)[1] .. '\nCharacter: ' .. char.getFullName() .. '\nGun Range Location #: ' .. gunrangeIndex .. '\nGun: ' .. gunHash .. '\nRange Box #: ' .. boxIndex .. '\nTarget Distance: ' .. distanceIndex .. '```'
        exports.globals:SendDiscordLog(WEBHOOK_URL, msg)
    end
end)


RegisterNetEvent(triggerName("ClearPedWeapons"), function()
    if Config.FrameWork == "3" then -- qbcore

    end

    if Config.FrameWork == "2" then -- esx

    end

    if Config.FrameWork == "1" then -- standalone

    end
end)

RegisterNetEvent(triggerName("GiveWeaponToPed"), function(weaponName, ammo, components)
    if Config.FrameWork == "3" then -- qbcore

    end

    if Config.FrameWork == "2" then -- esx

    end

    if Config.FrameWork == "1" then -- standalone

    end
end)