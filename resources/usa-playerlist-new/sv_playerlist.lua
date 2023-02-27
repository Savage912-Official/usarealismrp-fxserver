RegisterServerCallback {
    eventName = "playerlist:getData",
    eventCallback = function(source)
        local user = exports.essentialmode:getPlayerFromId(source)
        -- gather list of all player server IDs + steam IDs
        local ret = {}
        local players = GetPlayers()
        for i = 1, #players do
            local playerInfo = { serverId = players[i], identifier = GetPlayerIdentifiers(players[i])[1]}
            if user.getGroup() ~= "user" then
                local targetChar = exports["usa-characters"]:GetCharacter(tonumber(playerInfo.serverId))
                if targetChar then
                    playerInfo.currentCharacter = {
                        name = targetChar.getFullName(),
                        job = targetChar.get("job")
                    }
                end
            end 
            table.insert(ret, playerInfo)
        end
        table.sort(ret, function(a, b)
            return tonumber(a.serverId) < tonumber(b.serverId)
        end)
        return ret
    end
}

AddEventHandler('es:playerLoaded', function(src, user)
    local isStaff = user.getGroup() ~= "user"
    if isStaff then
        TriggerClientEvent("playerlist:setViewDistance", src, 40)
    else
        TriggerClientEvent("playerlist:setViewDistance", src, 10)
    end
end)