RegisterServerCallback {
    eventName = "playerlist:getData",
    eventCallback = function(source)
        -- gather list of all player server IDs + steam IDs
        local ret = {}
        local players = GetPlayers()
        for i = 1, #players do
            table.insert(ret, { serverId = players[i], identifier = GetPlayerIdentifiers(players[i])[1]})
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