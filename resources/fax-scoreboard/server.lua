RegisterServerCallback {
    eventName = "playerlist:getData",
    eventCallback = function(source)
        -- gather list of all player server IDs + steam IDs
        local ret = {}
        local players = GetPlayers()
        for i = 1, #players do
            table.insert(ret, { serverId = players[i], identifier = GetPlayerIdentifiers(source)[1]})
        end
        return ret
    end
}