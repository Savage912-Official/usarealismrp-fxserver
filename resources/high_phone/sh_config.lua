-- Framework functions
FOB = true -- Do not rename this variable! And if your framework doesn't have shared objects, keep and set this variable to true!
TriggerEvent(Config.SharedObject, function(obj) FOB = obj end)

if(not IsDuplicityVersion()) then
    Citizen.CreateThread(function()
        while FOB == nil do
            TriggerEvent(Config.SharedObject, function(obj) FOB = obj end)
            Citizen.Wait(10)
        end
    end)
end

Config.Events = {
    playerLoaded = "high_callback:load", -- player loaded server-side event, requires a player source as the 1st argument.
    playerDropped = "high_callback:drop", -- player disconnected server-side event, requires a player source as the 1st argument.
    updateJob = "high_callback:setJob" -- player job updated server-side event, requires a player source as the 1st argument.
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
        amount = "amount" -- Price/amount of the invoice column
    }
}


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

    RegisterServerEvent("high_phone:checkForPhone")
    AddEventHandler("high_phone:checkForPhone", function()
        local char = exports["usa-characters"]:GetCharacter(source)
        local phone = char.getItem("Cell Phone")
        if not phone then
            TriggerClientEvent("usa:notify", source, "You have no cell phone!", "INFO: You need to buy a cell phone from a GENERAL STORE!")
        end
    end)

end

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

    -- Server-side get players function
    getPlayers = function()
        return GetPlayers()
    end,

    -- Client-side get closest player
    getClosestPlayer = function()
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

    -- Server-side get player data
    getPlayer = function(source)
        if source == "" or source == nil or not source then
            return nil 
        end
        local self = {}
        if type(source) == "string" then 
            self.source = tonumber(source)
        else 
            self.source = source
        end
        local char = exports["usa-characters"]:GetCharacter(self.source)
        if char == nil or not char then 
            return nil 
        end
        self.group = exports["essentialmode"]:getPlayerFromId(self.source).getGroup()
        self.job = char.get("job")
        if self.job == "ems" or self.job == "sheriff" or self.job == "corrections" then 
            self.jobName = "emergency"
        else
            self.jobName = self.job
        end
        self.jobGrade = 10
        self.identifier = char.get("_id")
        self.money = {cash = char.get("money"), bank = char.get("bank")}
        self.number = Players[self.source] ~= nil and Players[self.source].number or nil

        self.getIdentity = function()                
            local name = char.get("name")
            return {firstname = name.first, lastname = name.last}
        end

        self.addBankMoney = function(amount) 
            char.giveBank(amount)
        end
        self.addCash = function(amount) 
            char.giveMoney(amout)
        end
        self.removeBankMoney = function(amount) 
            char.removeBank(amount)
        end
        self.removeCash = function(amount) 
            char.removeMoney(amount)
        end

        self.getItemCount = function(item)

            local inv = char.getInventoryItems()
            local c = 0

            for k,v in ipairs(inv) do
                if v.name == item then 
                    c = c + 1
                end
            end
            return c
        end

        return self

    end,

    -- Server-side get player data by identifier
    getPlayerByIdentifier = function(ident)
        local player = nil
        TriggerEvent("es:getPlayers", function(players)
            for i,v in pairs(players) do
                local s = v.get("source")
                local p = Config.FrameworkFunctions.getPlayer(s)
                -- print("checking identifier " .. p.identifier)
                if p.identifier == ident then 
                    -- print("it matches")
                    player = p
                    break
                end
            end
        end)
        return player
    end
}

Config.CustomCallbacks = {
    -- Advertisments app
    ["postAd"] = function(data)
        TriggerServerEvent("high_phone:postAd", data.title, data.content, data.image, data.data)
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
        end, data.number, data.anonymous)
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
    }
}