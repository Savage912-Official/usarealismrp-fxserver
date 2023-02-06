return function(resource)
    exports[resource]:GetStoryPlayerName(function(source)
        -- You can replace a story's author name parser here, this will be stored in a story's metadata and you cannot change it on-demand.

        local QS = nil
        local qbCoreFramework = nil

        TriggerEvent('qs-base:getSharedObject', function(obj)
            QS = obj
        end)

        if ((not QS) or (not QS.GetPlayerFromId)) then
            if (QBCore) then
                qbCoreFramework = QBCore
            else
                TriggerEvent('QBCore:GetObject', function(obj)
                    qbCoreFramework = obj
                end)

                if (not qbCoreFramework) then
                    qbCoreFramework = exports['qb-core']:GetCoreObject()
                end
            end
        end

        local info = (QS and QS.GetPlayerFromId and QS.GetPlayerFromId(tonumber(source))) or qbCoreFramework.Functions.GetPlayer(tonumber(source))

        if (info) then
            info = info.PlayerData.charinfo

            if (info) then
                if (info.firstname and info.lastname) then
                    return info.firstname .. ' ' .. info.lastname
                elseif (info.firstname) then
                    return info.firstname
                elseif (info.lastname) then
                    return info.lastname
                end
            end
        end

        return GetPlayerName(source)
    end)

    RegisterCommand('delete-phone-story', function(source, args, raw) -- The default way of deleting a story, an Ace-restricted command.
        if ((not args[1]) or (not tonumber(args[1]))) then
            TriggerClientEvent('cs-stories:notify', source, '~h~Phone Stories~n~~h~~r~Missing or invalid story hashtag ID!')
        elseif (exports[resource]:DeleteStory(tonumber(args[1]))) then -- You can call this export manually, if it returns true the story has been deleted successfully otherwise the story does not exist.
            TriggerClientEvent('cs-stories:notify', source, '~h~Phone Stories~n~~h~~g~You deleted story #' .. args[1] .. '!')
        else
            TriggerClientEvent('cs-stories:notify', source, '~h~Phone Stories~n~~h~~r~Story #' .. args[1] .. ' could not be found!')
        end
    end, true)

    AddEventHandler('cs-stories:onStoryAdded', function(data)
        -- A story was added by a player, could be us or could be someone else.
        -- You can use this event to perform a notification for example if you want players to see a story was uploaded.
    end)

    AddEventHandler('cs-stories:onStoryDeleted', function(data)
        -- A story was deleted (using the internal delete method).
        -- You can use this event to perform a notification for example if you want players to see a story was deleted.
    end)
end
