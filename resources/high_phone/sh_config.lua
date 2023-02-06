-- Framework functions
local ESXName = "es_extended" -- Change this if you've renamed ESX.
local SharedObject = "esx:getSharedObject" -- Change this if your ESX doesn't have the shared object export and if you're using an anticheat that scrambles the event names or you just have changed this event name.

FOB = true -- Do not rename this variable! And if your framework doesn't have shared objects, keep and set this variable to true!

Config.Events = {
    playerLoaded = "high_callback:load", -- player loaded server-side event, requires a player source as the 1st argument.
    playerDropped = "high_callback:drop", -- player disconnected server-side event, requires a player source as the 1st argument.
    updateJob = "high_callback:setJob", -- player job updated server-side event, requires a player source as the 1st argument.
    -- NOTE THAT 'high_phone:addInventoryItem' AND 'high_phone:removeInventoryItem' REQUIRE DIFFERENT 2ND ARGUMENTS, THESE REQUIRE THE AMOUNT OF ITEM REMOVED/ADDED, UNLIKE ESX ALREADY GIVES THE AMOUNT OF ITEM THE PLAYER HAS AFTER REMOVING/ADDING IT.
    -- addItem = "esx:addInventoryItem", -- item added to inventory client-side event, requires the item name as the 1st argument and the count of the item in player's inventory AFTER adding as the 2nd argument.
    -- removeItem = "esx:removeInventoryItem" -- item removed from inventory client-side event, requires the item name as the 1st argument and the count of the item in player's inventory AFTER removing as the 2nd argument.
}

Config.PlayersTable = "users" -- Database players table.
Config.IdentifierColumn = "ownerIdentifier" -- In players table, the main player identifier column.
Config.Invoices = {
    enabled = false,
    table = "billing", -- Table's name that contains all the bills [invoices]
    columns = {
        id = "id", -- ID column
        owner = "identifier", -- Player's identifier that received the invoice column
        label = "label", -- Invoice label [title or reason] column
        amount = "amount", -- Price/amount of the invoice column
        -- REMOVE THE -- IN FRONT OF 'status = "paid"' IF YOUR BILLING SCRIPT (SUCH AS OKOKBILLING) INCLUDES BILL STATUSES
        --status = "status"
    }
    -- UNCOMMENT (REMOVE THE --[[ AND ]]) THE CODE BELOW IF YOUR BILLING SCRIPT (SUCH AS OKOKBILLING) INCLUDES BILL STATUSES
    --[[statuses = {
        -- Do not change the index names, only the values
        paid = "paid", -- The status that gets set after paying the invoice on the bank app
        shown = {"unpaid"},
        ignored = {"paid", "autopaid", "cancelled"}
    }]]
}

-- Its not worth to change this if you have both addItem and removeItem events, the phone will automatically use these events to count the amount of phones in player's inventory.
-- Do not change the framework functions, just modify them in the functions below Config.HasPhone function, change this function only if you know what you're doing!
Config.HasPhoneServer = true -- Execute this function below on the server-side or on the client-side? Only change to false if you've remade the function below to check for the items on the client-side (some frameworks have client-side getitem functions).
Config.HasPhone = function(source)
    local char = exports["usa-characters"]:GetCharacter(source)
    local phone = char.getItem("Cell Phone")
    if not phone then
        TriggerClientEvent("usa:notify", source, "You have no cell phone!", "INFO: You need to buy a cell phone from a GENERAL STORE!")
        return false
    else
        return {has = phone ~= "", item = phone}
    end
end

local IS_SERVER = IsDuplicityVersion()

if not IS_SERVER then 
    CServerCallbacks = {}
    CurrentRequestId = 0

    RegisterNetEvent('high_callback:serverCallback')
    AddEventHandler('high_callback:serverCallback', function(requestId, ...)
        CServerCallbacks[requestId](...)
        CServerCallbacks[requestId] = nil
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(1, Config.OpenKey) and GetLastInputMethod(0) then
                TriggerServerEvent("high_phone:checkForPhone")
            end
        end
    end)
end

if IS_SERVER then
    ServerCallbacks = {}

    RegisterServerEvent("high_phone:printServer")
    AddEventHandler("high_phone:printServer", function(arg)
        print(arg)
    end)

    TriggerServerCallback = function(name, requestId, source, cb, ...)
        if ServerCallbacks[name] ~= nil then
            ServerCallbacks[name](source, cb, ...)
        else
            print(('[^3WARNING^7] Server callback "%s" does not exist. Make sure that the server sided file really is loading, an error in that file might cause it to not load.'):format(name))
        end
    end

    RegisterServerEvent('high_callback:triggerServerCallback')
    AddEventHandler('high_callback:triggerServerCallback', function(name, requestId, ...)
        local playerId = source

        TriggerServerCallback(name, requestID, playerId, function(...)
            TriggerClientEvent('high_callback:serverCallback', playerId, requestId, ...)
        end, ...)
    end)

    -- RegisterServerEvent("high_phone:checkForPhone")
    -- AddEventHandler("high_phone:checkForPhone", function()
    --     local char = exports["usa-characters"]:GetCharacter(source)
    --     local phone = char.getItem("Cell Phone")
    --     if not phone then
    --         TriggerClientEvent("usa:notify", source, "You have no cell phone!", "INFO: You need to buy a cell phone from a GENERAL STORE!")
    --     end
    -- end)

end

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

-- DO NOT RENAME ANY OF THE TABLE INDEX NAMES, KEEP THEM AS THEY ARE, ONLY CHANGE THEIR VALUES AND FUNCTIONS (DO NOT REMOVE OR CHANGE THE ARGUMENTS IN FUNCTIONS)
Config.FrameworkFunctions = {
    -- Client-side trigger callback
    triggerCallback = function(name, cb, ...)
        CServerCallbacks[CurrentRequestId] = cb

        TriggerServerEvent('high_callback:triggerServerCallback', name, CurrentRequestId, ...)

        if CurrentRequestId < 65535 then
            CurrentRequestId = CurrentRequestId + 1
        else
            CurrentRequestId = 0
        end
    end,
    
    -- Server-side register callback
    registerCallback = function(name, cb)
        ServerCallbacks[name] = cb
    end,

    -- Server-side get player ids function
    getPlayers = function()
        -- Returns a table containing all player server ids.
        return GetPlayers()
    end,

    -- Client-side get closest player and distance to player
    getClosestPlayer = function()
        -- Returns two variables (e.g. an unpacked table containing two values in the right order), 1st is the closest PlayerId and 2nd is the distance to the closest Player.
        local players = GetActivePlayers()
        local closestDistance = -1
        local closestPlayer = -1
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
                if(closestDistance == -1 or closestDistance > distance) then
                    closestPlayer = value
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance
    end,

    -- Client-side get pool of ped entities
    getPeds = function()
        -- Returns a pool of ped entities.
        local ignoreList = ignoreList or {}
        local peds       = {}

        for ped in EnumeratePeds() do
            local found = false

            for j=1, #ignoreList, 1 do
                if ignoreList[j] == ped then
                    found = true
                end
            end

            if not found then
                table.insert(peds, ped)
            end
        end

        return peds
    end,

    -- Server-side get player data, index names should be self explanatory to what the values have to contain or do
    getPlayer = function(source) 
        local self = {}
        local cachedPlayer = Players[source]
        -- The above should not be touched.

        local player = exports['usa-characters']:GetCharacter(source)

        -- DO NOT RENAME ANY OF THE 'self' TABLE INDEX NAMES, KEEP THEM AS THEY ARE, ONLY CHANGE THEIR VALUES AND FUNCTIONS (DO NOT REMOVE OR CHANGE THE ARGUMENTS IN FUNCTIONS)
        if(player) then
            if type(source) == "string" then 
                self.source = tonumber(source)
            else 
                self.source = source
            end
            self.identifier = player.get("_id")
            self.group = exports["essentialmode"]:getPlayerFromId(source).getGroup()

            local tempjob = player.get("job")
            if tempjob == "ems" or tempjob == "sheriff" or tempjob == "corrections" then 
                tempjob = "emergency"
            end

            self.job = {
                name = tempjob,
                grade = 0,
                -- REMOVE THE -- IN FRONT OF 'onDuty' IF YOU WANT TO CHECK IF THE PLAYER IS ON DUTY/IN SERVICE BEFORE SENDING HIM JOB MESSAGES/CALLS.
                --onDuty = player.job.service == 1 or false
            }

            self.money = {
                cash = player.get("money"), -- Wallet money
                bank = player.get("bank") -- Bank money
            }
    
            self.number = cachedPlayer and cachedPlayer.number or nil -- Do not touch

            self.getIdentity = function()                
                local name = player.get("name")
                return {firstname = name.first, lastname = name.last}
            end

            self.addBankMoney = function(amount) 
                player.giveBank(amount)
            end
            self.addCash = function(amount) 
                player.giveMoney(amout)
            end
            self.removeBankMoney = function(amount) 
                player.removeBank(amount)
            end
            self.removeCash = function(amount) 
                player.removeMoney(amount)
            end

            self.getItemCount = function(item)
                -- Here you can replace the getInventoryItem function if you're using a different inventory system.
                return player.getInventoryItem(item).count
            end

            self.getItemCount = function(item)

            local inv = player.getInventoryItems()
                local c = 0

                for k,v in ipairs(inv) do
                    if v.name == item then 
                        c = c + 1
                    end
                end
                return c
            end

            return self
        end

        return nil
    end,

    -- Server-side get player data by identifier
    getPlayerByIdentifier = function(self, identifier)
        TriggerEvent("es:getPlayers", function(players)
            for i,v in pairs(players) do
                local s = v.get("source")
                local p = Config.FrameworkFunctions.getPlayer(s)
                if p.identifier == ident then 
                    -- print("it matches")
                    return p
                end
            end
        end)

        return nil
    end
}

local tokoCallId = nil
-- DO NOT RENAME ANY OF THE TABLE INDEX NAMES, KEEP THEM AS THEY ARE, ONLY CHANGE THEIR VALUES AND FUNCTIONS (DO NOT REMOVE OR CHANGE THE ARGUMENTS IN FUNCTIONS)
Config.VoipFunctions = {
    usedVoip = "mumble-voip", -- 'auto' automatically detects your used VOIP and uses it's default functions. If you're using a renamed VOIP or something similar, put an index name of one of the VOIP tables in this table.
    -- Configure your custom functions below, do not rename any of the table function names/values, modify only the functions themselves. Do not change the function arguments as well.
    ["mumble-voip"] = {
        voiceTarget = 2, -- Mumble voice target id, do not change this if you haven't changed it in mumble-voip's code.
        serverSided = false,
        addToCall = function(id)
            exports["mumble-voip"]:SetCallChannel(id)
            print("added to call")
        end,
        removeFromCall = function()
            exports['mumble-voip']:SetCallChannel(0)
            print('call finished')
        end
    },
    ["tokovoip_script"] = {
        serverSided = false,
        addToCall = function(id)
            exports["tokovoip_script"]:addPlayerToRadio(id)
        end,
        removeFromCall = function()
            if(tokoCallId ~= nil) then
                exports["tokovoip_script"]:removePlayerFromRadio(tokoCallId)
                tokoCallId = nil
            end
        end
    },
    ["pma-voice"] = {
        voiceTarget = 1, -- Mumble voice target id, do not change this if you haven't changed it in pma-voice's code.
        serverSided = false,
        addToCall = function(id)
            exports['pma-voice']:SetCallChannel(id)
        end,
        removeFromCall = function()
            exports['pma-voice']:SetCallChannel(0)
        end
    },
    ["saltychat"] = {
        serverSided = true,
        -- With serverSided true, there will be two arguments in the addToCall function, 1st will be the call ID, 2nd will be the players table (table of player id's aka sources) that's being added into a call.
        addToCall = function(id, players)
            exports['saltychat']:AddPlayersToCall("" .. id .. "", players)
        end,
        removeFromCall = function(id, players)
            exports['saltychat']:RemovePlayersFromCall("" .. id .. "", players)
        end
    },
    -- Do not remove this table, it's the default VOIP used as a fallback in case of no VOIP scripts found.
    ["default"] = {
        serverSided = false,
        addToCall = function(id)
            NetworkSetVoiceChannel(id)
            NetworkSetTalkerProximity(0.0)
        end,
        removeFromCall = function()
            InvokeNative(0xE036A705F989E049)
            NetworkSetTalkerProximity(2.5)
        end
    }
}

Config.CustomCallbacks = {
    -- Advertisments app
    ["postAd"] = function(data)
        TriggerServerEvent("high_phone:postAd", data.title, data.content, data.category, data.image, data.data)
    end,
    ["deleteAd"] = function(data)
        TriggerServerEvent("high_phone:deleteAd", data.id)
    end,
    -- Twitter app
    ["postTweet"] = function(data)
        TriggerServerEvent("high_phone:postTweet", data.title, data.content, data.image)
    end,
    ["deleteTweet"] = function(data)
        TriggerServerEvent("high_phone:deleteTweet", data.id)
    end,
    ["postReply"] = function(data)
        TriggerServerEvent("high_phone:postReply", data.id, data.content)
    end,
    -- Messages app
    ["sendMessage"] = function(data)
        TriggerServerEvent("high_phone:sendMessage", data.number, data.content, data.attachments, data.time) -- data.time is for accurate saving of time of the messages.
        
        for i, v in pairs(Config.JobContacts) do
            if(number == v.number) then
                v.messageCallback(false, data.content)
                break
            end
        end

        if data.number == "911" then
            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
            local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
            local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
            TriggerServerEvent('911:PlayerCall', x, y, z, lastStreetNAME, data.content)
        end
    end,
    -- Mail app
    ["sendMail"] = function(data)
        if(not data.reply) then
            TriggerServerEvent("high_phone:sendMail", data.recipients, data.subject, data.content, data.attachments)
        else
            TriggerServerEvent("high_phone:sendMailReply", data.reply, data.recipients, data.subject, data.content, data.attachments)
        end
    end,
    -- Darkchat app
    ["sendDarkMessage"] = function(data)
        TriggerServerEvent("high_phone:sendDarkMessage", data.id, data.content, data.attachments, data.time) -- data.time is for accurate saving of time of the messages.
    end,
    -- Phone app
    ["callNumber"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback("high_phone:callNumber", function(response)
            cb(response) -- If response is "SUCCESS", the call screen will slide out. IMPORTANT TO CALLBACK SOMETHING!
            if(response == "SUCCESS") then
                DoPhoneAnimation('cellphone_text_to_call') -- Global function, play any animation from library cellphone@
                onCall = true -- Global variable, set it to true if in a call.
            end
        end, data.number, data.privatenumber)
    end,
    -- Contacts app
    ["createContact"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback("high_phone:createContact", function(id)
            cb(id)
        end, data.number, data.name, data.photo, data.tag)
    end,
    -- Bank app
    ["transferMoney"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback("high_phone:transferMoney", function(response)
            cb(response) -- If response is "SUCCESS", a message saying that the transfer was successful will be shown. IMPORTANT TO CALLBACK SOMETHING!
        end, Config.TransferType == 1 and tonumber(data.id) or data.id, tonumber(data.amount), data.purpose)
    end,
    ["requestMoney"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback("high_phone:requestMoney", function(response)
            cb(response) -- If response is "SUCCESS", a message saying that the transfer was successful will be shown. IMPORTANT TO CALLBACK SOMETHING!
        end, tonumber(data.id), tonumber(data.amount), data.purpose)
    end,
    ["payBill"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback('esx_billing:payBill', function()
            cb() -- esx_billing is so lame..
        end, data.id)
    end,
    ["cancelBill"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback("high_phone:cancelBill", function(response)
            cb(response) -- If response is "SUCCESS", a message saying that the cancelation was successful will be shown. IMPORTANT TO CALLBACK SOMETHING!
        end, data.id)
    end,
}

Config.Commands = {
    -- Do not rename the index, only change the name field if you want to change the command name.
    ["twitter_rank"] = {
        enabled = true,
        name = "settwitterrank",
        suggestion_label = "Set rank for a twitter account",
        args = {{
            name = "Email address",
            help = "Twitter user email address"
        }, {
            name = "Rank",
            help = "Twitter rank name"
        }},
        notifications = {
            ["error_prefix"] = "^1SYSTEM",
            ["success_prefix"] = "^2SYSTEM",
            ["email_not_specified"] = "You have to specify a twitter email address!",
            ["group_not_specified"] = "You have to specify a twitter group!",
            ["no_permission"] = "No permission for this command!",
            ["account_doesnt_exist"] = "A twitter account with this email doesn't exist!",
            ["group_successfully_set"] = "You've set the group on {email} to {rank}",
            ["rank_non_existant"] = "Rank {rank} doesn't exist!"
        }
    },
    ["ban_twitter_user"] = {
        enabled = true,
        name = "bantwitteruser",
        suggestion_label = "Ban a twitter user",
        args = {{
            name = "Email address",
            help = "Twitter user email address"
        }, {
            name = "Time",
            help = "In minutes, eg. 20m"
        }},
        notifications = {
            ["error_prefix"] = "^1SYSTEM",
            ["success_prefix"] = "^2SYSTEM",
            ["email_not_specified"] = "You have to specify a twitter email address!",
            ["time_not_specified"] = "You have to specify the time!",
            ["wrong_time"] = "Wrong time specified",
            ["no_permission"] = "No permission for this command!",
            ["account_doesnt_exist"] = "A twitter account with this email doesn't exist!",
            ["account_banned_successfully"] = "You've banned Twitter account {email} for {time}"
        }
    },
    ["ban_twitter_player"] = {
        enabled = true,
        name = "bantwitterplayer",
        suggestion_label = "Ban player from using Twitter",
        args = {{
            name = "ID",
            help = "Player ID"
        }, {
            name = "Time",
            help = "In minutes, eg. 20m"
        }},
        notifications = {
            ["error_prefix"] = "^1SYSTEM",
            ["success_prefix"] = "^2SYSTEM",
            ["id_not_specified"] = "You have to specify a player ID!",
            ["player_not_online"] = "Player is not online!",
            ["time_not_specified"] = "You have to specify the time!",
            ["wrong_time"] = "Wrong time specified",
            ["no_permission"] = "No permission for this command!",
            ["player_banned_successfully"] = "You've banned {playerName} [{playerId}] from Twitter for {time}"
        },
    },
    ["clear_popular_songs"] = {
        enabled = true,
        name = "clearpopularsongs",
        suggestion_label = "Clear and reset the popular songs of the server",
        args = {},
        notifications = {
            ["error_prefix"] = "^1SYSTEM",
            ["success_prefix"] = "^2SYSTEM",
            ["no_permission"] = "No permission for this command!",
            ["songs_cleared_successfully"] = "All popular songs have been cleared!",
        }
    },
    ["reposition_phone"] = {
        enabled = true,
        name = "repositionphone",
        suggestion_label = "Resets your phone's position on the screen if you've dragged it out",
        args = {}
    }
}

Config.CommandNotification = function(source, title, message)
    TriggerClientEvent('chat:addMessage', source, {args = {title, message}})
end