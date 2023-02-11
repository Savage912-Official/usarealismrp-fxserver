OGIdents = GetPlayerIdentifier

CreateThread(function()
    if Config.Framework == 3 then
        PlayerHasMoney = function(serverId, amount)
            local char = exports["usa-characters"]:GetCharacter(serverId)
            if char.get("money") >= amount then
                return true
            else
                return false
            end
        end

        PlayerTakeMoney = function(serverId, amount)
            local char = exports["usa-characters"]:GetCharacter(serverId)
            char.removeMoney(amount)
        end

        PlayerGiveMoney = function(serverId, amount)
            local char = exports["usa-characters"]:GetCharacter(serverId)
            char.giveMoney(amount)
        end

        SendNotification = function(serverId, msg)
            TriggerClientEvent("usa:notify", serverId, msg)
        end

        GetPlayerIdentifier = function(serverId)
            local ids = parsePlayerIdentifiers(
                {},
                CustomGetPlayerIdentifiers(serverId)
            )

            return ids.license and ids.license or ids.steam
        end

        PlayerHasItem = function(serverId, itemName)
            local char = exports["usa-characters"]:GetCharacter(serverId)
            if char.hasItem(itemName) then
                return true
            else
                return false
            end
        end

        PlayerTakeItem = function(serverId, itemName)
            local char = exports["usa-characters"]:GetCharacter(serverId)
            char.removeItem(itemName)
        end

        PlayerGiveItem = function(serverId, itemName)
            local char = exports["usa-characters"]:GetCharacter(serverId)
            local itemName = { name = "Basketball Hoop", price = 750, type = "misc", quantity = 1, legality = "legal", weight = 10, objectModel = "prop_basketball_net2"}
            char.giveItem(itemName)
        end

        RegisterCommand('placehoop', function(serverId)
            local char = exports["usa-characters"]:GetCharacter(serverId)
            if char.hasItem then
                TriggerClientEvent('rcore_basketball:startPlacingHoop', serverId)
            end
        end, false)
    end
end)

function parsePlayerIdentifiers(ids, identifiers)
    for k,v in ipairs(identifiers)do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            ids.steam = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            ids.license = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            ids.discord = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ids.ip = v
        elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
            ids.fivem = v
        end
    end

    return ids
end


function CustomGetPlayerIdentifiers(player)
    if player then
        local numIds = GetNumPlayerIdentifiers(player)
        local t = {}

        for i = 0, numIds - 1 do
            table.insert(t, OGIdents(player, i))
        end

        return t
    else
        error("COULD NOT GET PLAYER IDENTIFIERS, NO PLAYER PROVIDED")
    end
end