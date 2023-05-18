CreateThread(function()
    if Config.Framework ~= "standalone" then
        return
    end

    --- @param source number
    --- @return string | nil
    function GetIdentifier(source)
        local char = exports["usa-characters"]:GetCharacter(source)
        if char ~= nil then
            return char.get("_id")
        else
            return nil
        end
    end

    ---Check if a player has a phone with a specific number
    ---@param source any
    ---@param number string
    ---@return boolean
    function HasPhoneItem(source, number)
        if not Config.Item.Require then
            return true
        end
        local char = exports["usa-characters"]:GetCharacter(source)
        if char ~= nil then
            local hasPhone = char.hasItem("Cell Phone")
            return hasPhone
        else
            return false
        end
    end

    ---Get a player's character name
    ---@param source any
    ---@return string # Firstname
    ---@return string # Lastname
    function GetCharacterName(source)
        local char = exports["usa-characters"]:GetCharacter(source)
        if char ~= nil then
            return char.getName()
        else
            return nil
        end
    end

    ---Get an array of player sources with a specific job
    ---@param job string
    ---@return table # Player sources
    function GetEmployees(job)
        local ret = {}
        local waiting = true
        exports["usa-characters"]:GetCharacters(function(chars)
            if job ~= "police" then
                for id, char in pairs(chars) do
                    if char.get("job") == job then
                        table.insert(ret, char.get("source"))
                    end
                end
            else
                for id, char in pairs(chars) do
                    if char.get("job") == "sheriff" or char.get("job") == "corrections" then
                        table.insert(ret, char.get("source"))
                    end
                end
            end
            waiting = false
        end)
        while waiting do
            Wait(1)
        end
        return ret
    end

    ---Get the bank balance of a player
    ---@param source any
    ---@return integer
    function GetBalance(source)
        local char = exports["usa-characters"]:GetCharacter(source)
        local money = tonumber(char.get("bank"))
        return money
    end

    ---Add money to a player's bank account
    ---@param source any
    ---@param amount integer
    ---@return boolean # Success
    function AddMoney(source, amount)
        local char = exports["usa-characters"]:GetCharacter(source)
        if char ~= nil then
            char.giveBank(amount)
            return true
        else
            return false
        end
    end

    ---Remove money from a player's bank account
    ---@param source any
    ---@param amount integer
    ---@return boolean # Success
    function RemoveMoney(source, amount)
        if GetBalance(source) > amount then
            local char = exports["usa-characters"]:GetCharacter(source)
            if char ~= nil then
                char.removeBank(amount)
                return true
            else
                return false
            end
        else
            return false
        end
    end

    ---Send a message to a player
    ---@param source number
    ---@param message string
    function Notify(source, message)
        TriggerClientEvent("chat:addMessage", source, {
            color = { 255, 255, 255 },
            multiline = true,
            args = { "Phone", message }
        })
        --TriggerClientEvent("usa:notify", source, false, message)
    end

    -- todo:

    -- GARAGE APP
    function GetPlayerVehicles(source, cb)
        local char = exports["usa-characters"]:GetCharacter(source)
        local playerPlates = char.get("vehicles")
        local playerVehicles = {}
        local endpoint = "/vehicles/_design/vehicleFilters/_view/getVehiclesForGarageMenu"
        local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
        PerformHttpRequest(url, function(err, responseText, headers)
            if responseText then
                local playerVehicles = {}
                local data = json.decode(responseText)
                if data.rows then
                    for i = 1, #data.rows do
                        local location = "out"
                        if data.rows[i].value[10] ~= nil then
                            local varType = type(data.rows[i].value[10])
                            if varType == "string" then
                                location = data.rows[i].value[10]
                            elseif varType == "table" then
                                location = "Garage"
                            end
                        elseif data.rows[i].value[5] then
                            location = "Garage"
                        end
                        if data.rows[i].value[4] then
                            location = "Impounded"
                        end
                        local fuel = 100.0
                        if data.rows[i].value[8] and data.rows[i].value[8].fuel then
                            fuel = data.rows[i].value[8].fuel
                        end
                        local veh = {
                            plate = data.rows[i].value[1], -- the vehicle plate
                            type = "car", -- the vehicle type
                            location = location, -- the location of the vehicle, set to out if the vehicle is not in a garage. Otherwise we recommend setting it to the garage name, or impounded
                            model = data.rows[i].value[3],
                            statistics = { -- this is optional
                                fuel = math.floor(fuel), -- the vehicle fuel, 0-100
                            }
                        }
                        table.insert(playerVehicles, veh)
                    end
                end
                cb(playerVehicles)
            end
        end, "POST", json.encode({
            keys = playerPlates
        }), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
    end

    function GetVehicle(source, cb, plate)
        local vehicle = exports["essentialmode"]:getDocument("vehicles", plate)
        cb(vehicle)
    end

    function IsAdmin(source)
        local group = exports["essentialmode"]:getPlayerFromId(source).getGroup()
        if group == "owner" or group == "superadmin" or group == "admin" or group == "mod" then
            return true
        else
            return false
        end
    end

    -- COMPANIES APP
    function GetJob(source)
        local char = exports["usa-characters"]:GetCharacter(source)
        if char ~= nil then
            local job = char.get("job")
            if job == "sheriff" or job == "corrections" then
                job = "police"
            end
            return job
        else
            return nil
        end
    end

    function RefreshCompanies()
        local jobsWithActivePlayers = {}
        TriggerEvent("es:getPlayers", function(players)
            if players then
                for id, player in pairs(players) do
                    local job = GetJob(id)
                    if job then
                        jobsWithActivePlayers[job] = true
                    end
                end
                for i = 1, #Config.Companies.Services do
                    local jobData = Config.Companies.Services[i]
                    Config.Companies.Services[i].open = jobsWithActivePlayers[jobData.job] or false
                end
            end
        end)
    end

    TriggerEvent('es:addGroupCommand', 'toggleverified', "owner", function(source, args, char)
        local app, username, verified = args[2], args[3], tonumber(args[4])
        if (app ~= "twitter" and app ~= "instagram") or (not username) or (verified ~= 1 and verified ~= 0) then
            Notify(source, "Invalid usage of /toggleverified")
        end

        ToggleVerified(app, username, verified)
    end, {
        help = "Toggle verified for a user profile",
        params = {
            {
                name = "app",
                help = "The app, twitter or instagram"
            },
            {
                name = "username",
                help = "The profile username"
            },
            {
                name = "verified",
                help = "The verified state, 1 or 0"
            }
        }
    })

    TriggerEvent('es:addCommand','changeaccountpassword', function(source, args, char)
        local app, username, oldPassword, newPassword = args[2], args[3], args[4], args[5]
        if (app ~= "twitter" and app ~= "instagram") or (not username) or (not oldPassword) or (not newPassword) then
            Notify(source, "Invalid usage of /changeaccountpassword")
        end

        MySQL.Async.fetchAll('SELECT password FROM phone_'..app..'_accounts WHERE username = @username', { ['@username'] = username }, function(result)
          if VerifyPasswordHash(oldPassword, result[1].password) then
             local passwordChanged = exports["lb-phone"]:ChangePassword(app, username, newPassword)
             if passwordChanged then
                TriggerClientEvent("usa:notify", source, "You have changed the password for "..username.." on "..app)
                TriggerClientEvent("lb-phone:reloadPhoneStandalone", source)
             else
                TriggerClientEvent("usa:notify", source, "There was an error changing the password try again later or contact staff!")
             end
          else
            TriggerClientEvent("usa:notify", source, "The old password you have entered is wrong!")
          end
        end)
    end, {
        help = "Toggle verified for a user profile",
        params = {
            {
                name = "app",
                help = "The app, twitter or instagram"
            },
            {
                name = "username",
                help = "The profile username"
            },
            {
                name = "oldPassword",
                help = "Old Password of Account"
            },
            {
                name = "newPassword",
                help = "New Password of Account"
            }
        }
    })

    TriggerEvent('es:addCommand','reloadphone', function(source, args, char)
        TriggerClientEvent("lb-phone:reloadPhoneStandalone", source)
    end, {
        help = "Reloads the Phone (Use for any bugs!)",
    })

    lib.callback.register('lb-phone:hasPhone', function(source, number)
        return HasPhoneItem(source, number)
    end)

end)