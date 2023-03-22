if Config.Framework.CUSTOM then
    function GetPlayerIdentifier(serverId)
        -- implement a function that returns player or character identifier
        -- used to recording transfer
        local char = exports["usa-characters"]:GetCharacter(serverId)
        local ident = char.get("_id")
        return ident
    end

    function SendNotification(serverId, text)
        -- implement sending notification to player
        TriggerClientEvent("usa:notify", serverId, text)
    end

    RegisterServerCallback {
        eventName = 'rcore_cam:getJob',
        eventCallback = function(source)
            local char = exports["usa-characters"]:GetCharacter(source)
            if char ~= nil then
                local job = char.get("job")
                return job
            else
                return "civ"
            end
        end
    }
end