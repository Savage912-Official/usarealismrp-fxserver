-- Random number preparation
math.randomseed(os.time());
math.random(); math.random();

-- List of items
local ITEMS = {
    ["indiv"] = {
        exports.usa_rp2:getItem("Fruit Tart"),
        exports.usa_rp2:getItem("Pancake"),
        exports.usa_rp2:getItem("Miso Soup"),
        exports.usa_rp2:getItem("UWU Sandwich"),
        exports.usa_rp2:getItem("Weepy Cupcake"),
        exports.usa_rp2:getItem("Moon Mochi"),
        {name = "", price = 0}, -- Placeholder (This won't show up on the list, but don't delete because it's needed for the menu to work.)
    },
    ["combos"] = {
        exports.usa_rp2:getItem("Senpai Combo"),
        exports.usa_rp2:getItem("Buddha Bowl"),
        exports.usa_rp2:getItem("Bento Box"),
        exports.usa_rp2:getItem("Mini Licious Box"),
        {name = "", price = 0}, -- Placeholder (This won't show up on the list, but don't delete because it's needed for the menu to work.)
    },
    ["hotdrinks"] = {
        exports.usa_rp2:getItem("Coffee"),
        exports.usa_rp2:getItem("Espresso"),
        exports.usa_rp2:getItem("Macchiato"),
        exports.usa_rp2:getItem("Latte"),
        exports.usa_rp2:getItem("Mocha"),
        exports.usa_rp2:getItem("Alex's Special"),
        {name = "", price = 0}, -- Placeholder (This won't show up on the list, but don't delete because it's needed for the menu to work.)
    },
    ["colddrinks"] = {
        exports.usa_rp2:getItem("Blueberry Bubble Tea"),
        exports.usa_rp2:getItem("Mint Bubble Tea"),
        exports.usa_rp2:getItem("Rose Bubble Tea"),
        exports.usa_rp2:getItem("Rainbow Glitter Frappuccino"),
        {name = "", price = 0}, -- Placeholder (This won't show up on the list, but don't delete because it's needed for the menu to work.)
    }
}

-- Needed for new employees
local result_check = {uid = nil}

RegisterServerEvent("catcafe:loadItems")
AddEventHandler("catcafe:loadItems", function()
    TriggerClientEvent("catcafe:loadItems", source, ITEMS)
end)

RegisterServerEvent("catcafe:startJob")
AddEventHandler("catcafe:startJob", function(location)
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    local uid = char.get("_id")
    local result = MySQL.query.await('SELECT * FROM usa_catcafe WHERE uid = ?', {uid})
    for i = 1, #result do
        result_check = result[i]
    end
    if result_check.uid == uid then
        if char.get("job") ~= 'CatCafeEmployee' then
            char.set("job", "CatCafeEmployee")
            TriggerClientEvent("catcafe:startJob", usource, location)
        end
        if config.debugMode then print("Player found in DB, Clocking in") end
    else
        MySQL.insert('INSERT INTO usa_catcafe (uid) VALUES (?) ', {uid}, function(id)
            print("Successfully added to DB")
        end)
        if char.get("job") ~= 'CatCafeEmployee' then
            char.set("job", "CatCafeEmployee")
            TriggerClientEvent("catcafe:startJob", usource, location)
        end
        if config.debugMode then print("Player not found in DB, Adding to DB and clocking in") end
    end
    TriggerEvent("catcafe:updateLeaderboard")
end)

RegisterServerEvent("catcafe:quitJob")
AddEventHandler("catcafe:quitJob", function()
    local char = exports["usa-characters"]:GetCharacter(source)
    if char.get("job") == 'CatCafeEmployee' then
        char.set("job", "civ")
        TriggerClientEvent("catcafe:quitJob", source)
    end
end)

RegisterServerEvent("catcafe:checkCriminalHistory")
AddEventHandler("catcafe:checkCriminalHistory", function()
    local char = exports["usa-characters"]:GetCharacter(source)
    if config.CrimninalHistoryCheck then
        local criminal_history = char.get("criminalHistory")
        if #criminal_history > 0 then
            for i = 1, #criminal_history do
                if exports["usa_burger-shot"]:hasCriminalRecord(criminal_history[i].charges) then
                    TriggerClientEvent("usa:notify", source, "Unfortunately you have a pretty serious criminal background therefore, we are unable to hire you.")
                    return
                end
            end
        end
    end
    checkStrikes(char, source)
end)

RegisterServerEvent("catcafe:addStrike")
AddEventHandler("catcafe:addStrike", function()
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    local ident = char.get("_id")
    local strikes = MySQL.prepare.await('SELECT strikes FROM usa_catcafe WHERE uid = ?', {ident})
    if config.debugMode then 
        if strikes ~= nil then 
            print("potential strike value found.")
        else
            print("issue found for strikes.")
        end
    end
    -- Add Strike
    MySQL.update('UPDATE usa_catcafe SET strikes = ? WHERE uid = ?', {strikes + 1, ident}, function(affectedRows)
        if affectedRows then
            if config.debugMode then
                print("User received strike.")
            end
        end
    end)
    -- XP penalty
    local xp = MySQL.prepare.await('SELECT xp FROM usa_catcafe WHERE uid = ?', {ident})
    local XpPenalty = math.random(13,25)
    MySQL.update('UPDATE usa_catcafe SET xp = ? WHERE uid = ?', {xp - XpPenalty, ident}, function(affectedRows)
        if affectedRows then
            if config.debugMode then
                print("User lost xp.")
            end
            TriggerClientEvent('chat:addMessage', usource,{
                args = {"^4Cat Cafe", "You lost ["..XpPenalty.."] xp because you received a strike."}
            })
        end
    end)
        
end)


TriggerEvent('es:addCommand', 'payuwufines', function(source, args, char)
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    local ident = char.get("_id")
    local strikes = MySQL.prepare.await('SELECT strikes FROM usa_catcafe WHERE uid = ?', {ident})
    if config.debugMode then
        print("User Ident : "..ident)
        print("Strikes return is")
        if strikes >= 0 then
            print(strikes)
        elseif strikes == nil or not strikes then
            print("Error finding strikes")
        end
    end
    if strikes >= 1 then
        if char.get('money') >= config.fine then
            char.removeMoney(config.fine)
            MySQL.update('UPDATE usa_catcafe SET strikes = ? WHERE uid = ?', {0, ident}, function(affectedRows)
                if affectedRows then
                    if config.debugMode then
                        print("User payed fines")
                    end
                    TriggerClientEvent('usa:notify', usource, 'Your strikes have been cleared. Don\'t let me down and make the same mistake again!')
                end
                
            end)
        else
            TriggerClientEvent('usa:notify', usource, 'You do not have the funds!')
        end
    else
        TriggerClientEvent('usa:notify', usource, 'You do not have any strikes.')
    end
end, {
    help = "Pay off your strikes so you can work at Cat Cafe again.",
})

TriggerEvent('es:addCommand', 'uwustats', function(source, args, char)
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    local ident = char.get("_id")
    local rank, xp, strikes
    local stats = MySQL.prepare.await('SELECT * FROM usa_catcafe WHERE uid = ?', {ident})
    if stats then
        rank = stats.rank
        xp = stats.xp
        strikes = stats.strikes
    end
    if config.debugMode then
        print("Player's ident is ..["..ident.."]")
        if rank then print(rank) end
        if xp then print(xp) end
        if strikes then print(strikes) end

        if not rank or rank == nil then
            print("Error finding rank")
        end
        if not xp or xp == nil then
            print("Error finding XP")
        end
        if not strikes or strikes == nil then
            print("Error finding strikes")
        end
    end
    TriggerClientEvent('chat:addMessage', source,{
        args = {"^4Cat Cafe", "Your rank is ["..rank.."] You have ["..xp.."] xp and you have ["..strikes.."] strike(s)."}
    })
end, {
    help = "Check your Cat Cafe stats.",
})

TriggerEvent('es:addCommand', 'giveuwuxp', function(source, args, char)
	local group = exports["essentialmode"]:getPlayerFromId(source).getGroup()
	if group == "owner" then
		local targetSource = tonumber(args[2])
		if tonumber(args[2]) and GetPlayerName(args[2]) then
			local target = exports["usa-characters"]:GetCharacter(targetSource)
            local targetIdent = target.get("_id")
            local currentXP = MySQL.prepare.await('SELECT xp FROM usa_catcafe WHERE uid = ?', {targetIdent})
            local requestedXP = tonumber(args[3])
            MySQL.update('UPDATE usa_catcafe SET xp = ? WHERE uid = ?', {currentXP + requestedXP, targetIdent}, function(affectedRows)
                if affectedRows then
                    if config.debugMode then
                        print("User is receiving XP from command")
                    end
                    TriggerClientEvent('catcafe:xpNotify', targetSource, requestedXP)
                end
            end)
			TriggerEvent("usa:notifyStaff", '^2^*[STAFF]^r^0 Player ^2'..GetPlayerName(targetSource)..' ['..targetSource..'] ^0 has been given ['..args[3]..'] xp by ^2'..GetPlayerName(source)..' ['..source..'] ^0.')
			TriggerClientEvent('chatMessage', targetSource, '^2^*[STAFF]^r^0 You have been given XP by ^2'..GetPlayerName(source)..'^0.')
		else
            TriggerClientEvent("usa:notify", source, "User not found")
        end
	else
		TriggerClientEvent("usa:notify", source, "Not permitted")
	end
end, {
	help = "Give a player XP for Cat Cafe.",
	params = {
		{ name = "id", help = "id of person" },
        { name = "xp", help = "amount of xp" },
	}
})

RegisterServerEvent("catcafe:forceRemoveJob")
AddEventHandler("catcafe:forceRemoveJob", function()
    local char = exports["usa-characters"]:GetCharacter(source)
    char.set("job", "civ")
    TriggerClientEvent("catcafe:quitJob", source)
end)

RegisterServerEvent("catcafe:addxp")
AddEventHandler("catcafe:addxp", function(xpCooldown)
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    local ident = char.get("_id")
    if config.debugMode then
        if ident then
            print("Unique ID Found : ["..ident.."]")
        elseif not ident or ident == nil then
            print("Error retreiving char _id")
        end
    end
    if not xpCooldown then
        local xpEarning = math.random(3,7)
        local result = MySQL.prepare.await('SELECT xp FROM usa_catcafe WHERE uid = ?', {ident})
        if config.debugMode then
            if result then
                print("Result is found for adding XP")
            else
                print("There is a problem retrieving XP")
            end
        end
        MySQL.update('UPDATE usa_catcafe SET xp = ? WHERE uid = ?', {result + xpEarning, ident}, function(affectedRows)
            if affectedRows then
                if config.debugMode then
                    print("User is receiving XP - Script is running ok")
                end
                TriggerClientEvent('catcafe:xpNotify', usource, xpEarning)
            end
        end)
    else
        if config.debugMode then
            print("User is on XP cooldown")
        end
    end
end)

RegisterServerEvent("catcafe:getrank")
AddEventHandler("catcafe:getrank",function()
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    local ident = char.get("_id")
    local stats = MySQL.prepare.await('SELECT * FROM usa_catcafe WHERE uid = ?', {ident})
    if config.debugMode then
        if stats ~= nil then
            print("User rank is ["..stats.rank.."]")
            print("User xp is ["..stats.xp.."]")
            print("User xp is ["..stats.strikes.."]")
        else
            print("No rank found. New Player")
        end
    end
    if stats then
        TriggerClientEvent("catcafe:rank", usource, stats.rank)
    end
end)

RegisterServerEvent("catcafe:rankStatus")
AddEventHandler("catcafe:rankStatus", function()
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    local ident = char.get("_id")
    local name = char.get("name")
    local rankUpdateString = "Player ["..name.first.." "..name.last.."] has the rank of "
    local stats = MySQL.prepare.await('SELECT * FROM usa_catcafe WHERE uid = ?', {ident})
    local rank
    if stats then
        rank = stats.rank
    else
        rank = 'Pending'
    end
    MySQL.prepare('SELECT xp FROM usa_catcafe WHERE uid = ?', {ident}, function(result)
        -- debug stuff
        if config.debugMode then
            if result then
                print("Result found. Player has ["..result.."] xp.")
            else
                print("No xp results found")
            end
        end
        if result >= config.ranks["Employee"].xpRequired and result < config.ranks["Trainer"].xpRequired then
            rank = "Employee"
            MySQL.update('UPDATE usa_catcafe SET `rank` = ? WHERE uid = ?', {rank, ident}, function(affectedRows)
                if affectedRows then
                    if config.debugMode then
                        print(rankUpdateString..rank)
                    end
                end
            end)
        elseif result >= config.ranks["Trainer"].xpRequired and result < config.ranks["Shift Supervisor"].xpRequired then
            rank = "Trainer"
            MySQL.update('UPDATE usa_catcafe SET `rank` = ? WHERE uid = ?', {rank, ident}, function(affectedRows)
                if affectedRows then
                    if config.debugMode then
                        print(rankUpdateString..rank)
                    end
                end
            end)
        elseif result >= config.ranks["Shift Supervisor"].xpRequired and result < config.ranks["Shift Manager"].xpRequired then
            rank = "Shift Supervisor"
            MySQL.update('UPDATE usa_catcafe SET `rank` = ? WHERE uid = ?', {rank, ident}, function(affectedRows)
                if affectedRows then
                    if config.debugMode then
                        print(rankUpdateString..rank)
                    end
                end
            end)
        elseif result >= config.ranks["Shift Manager"].xpRequired and result < config.ranks["Store Manager"].xpRequired then
            rank = "Shift Manager"
            MySQL.update('UPDATE usa_catcafe SET `rank` = ? WHERE uid = ?', {rank, ident}, function(affectedRows)
                if affectedRows then
                    if config.debugMode then
                        print(rankUpdateString..rank)
                    end
                end
            end)
        elseif result >= config.ranks["Store Manager"].xpRequired then
            rank = "Store Manager"
            MySQL.update('UPDATE usa_catcafe SET `rank` = ? WHERE uid = ?', {rank, ident}, function(affectedRows)
                if affectedRows then
                    if config.debugMode then
                        print(rankUpdateString..rank)
                    end
                end
            end)
        end
        TriggerClientEvent("catcafe:updateRank", usource, rank)
    end)
end)

RegisterServerEvent("catcafe:retrievestats")
AddEventHandler("catcafe:retrievestats", function()
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    local ident = char.get("_id")
    local name = char.get("name")
    if config.debugMode then
        if ident then
            print(ident)
            print("The string length is ["..string.len(ident).."]")
        elseif not ident or ident == nil then
            print("Error retreiving char _id")
        end
    end
    local stats = MySQL.prepare.await('SELECT * FROM usa_catcafe WHERE uid = ?', {ident})
    local rank
    if stats then
        rank = stats.rank
        if config.debugMode then
            print("Existing User | "..ident.." | Player name is | "..name.first.." "..name.last)
            print("Rank was successfully retrieved")
        end
        local PayBonus = config.ranks[rank].PayBonus
        local craftAdjustmentTime = config.ranks[rank].craftAdjustmentTime
        local data = {a = rank, b = craftAdjustmentTime, c = PayBonus}
        if not stats.FirstName then
            addName(name, ident)
        end
        TriggerClientEvent("catcafe:loaddata", usource, data)
    else
        if config.debugMode then
            print("New User | "..ident)
            print("Rank was successfully retrieved")
        end
        TriggerClientEvent("catcafe:firsttime", usource)
    end
    if not rank or rank == nil then
        if config.debugMode then
            print("User with | "..ident)
            print("Problem retreiving SQL Rank.")
        end
    end
end)

RegisterServerEvent("catcafe:payB")
AddEventHandler("catcafe:payB", function(bool)
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    local ident = char.get("_id")
    local stats = MySQL.prepare.await('SELECT * FROM usa_catcafe WHERE uid = ?', {ident})
    local check = bool
    local rank
    if config.debugMode then
        print("Existing User | "..ident.." | Player name is | "..char.get("name").first.." "..char.get("name").last)
        print("Rank was successfully retrieved.. Event payB running")
    end
    if char.get("job") == "CatCafeEmployee" then
        if check then
            if stats then
                rank = stats.rank
                local PayBonus = config.ranks[rank].PayBonus
                char.giveMoney(PayBonus)
                TriggerEvent('catcafe:paybonus', usource, PayBonus)
            else
                exports["es_admin"]:BanPlayer(usource, "Modding (Executing Money Event in Cat Cafe P3). If you feel this was a mistake please let a staff member know.")
            end
        else
            exports["es_admin"]:BanPlayer(usource, "Modding (Executing Money Event in Cat Cafe P2). If you feel this was a mistake please let a staff member know.")
        end
    else
        exports["es_admin"]:BanPlayer(usource, "Modding (Executing Money Event in Cat Cafe P1). If you feel this was a mistake please let a staff member know.")
    end
end)

function checkStrikes(char, src)
    MySQL.prepare('SELECT strikes FROM usa_catcafe WHERE uid = ?', {char.get("_id")}, function(result)
        -- debug stuff
        if config.debugMode then
            if result then
                print("Result found. Player has ["..result.."] strikes.")
            else
                print("No results found, New employee.")
            end
        end
        if result then
            TriggerClientEvent('catcafe:checkStrikes', src, result)
        else -- If new employee
            TriggerClientEvent('catcafe:checkStrikes', src, 0)
        end
    end)
end

function addName(name, ident)
    MySQL.update('UPDATE usa_catcafe SET FirstName = ? WHERE uid = ?', {name.first, ident}, function(affectedRows)
        if affectedRows then
            if config.debugMode then
                print("First Name updated")
            end
        end
    end)
    MySQL.update('UPDATE usa_catcafe SET LastName = ? WHERE uid = ?', {name.last, ident}, function(affectedRows)
        if affectedRows then
            if config.debugMode then
                print("Last Name updated")
            end
        end
    end)
end

RegisterServerCallback {
	eventName = 'catcafe:removecashforingredients',
	eventCallback = function(source, category, index)
        local item = ITEMS[category][index]
        local char = exports["usa-characters"]:GetCharacter(source)
        local money = char.get("money")
        if money >= item.price then
            if char.canHoldItem(item) then
                char.removeMoney(item.price)
                char.giveItem(item)
                return true
            else
                TriggerClientEvent("usa:notify", source, "Inventory full!")
                return false
            end
        else
            TriggerClientEvent("usa:notify", source, "Not enough money!")
            return false
        end
	end
}

RegisterServerCallback {
	eventName = 'catcafe:PlayerHasIngredientMoney',
	eventCallback = function(source, category, index)
        local item = ITEMS[category][index]
        local char = exports["usa-characters"]:GetCharacter(source)
        local money = char.get("money")
        if money < item.price then
            TriggerClientEvent("usa:notify", source, "Not enough money!")
            return false
        else
            return true
        end
	end
}

RegisterServerCallback {
	eventName = 'catcafe:isPlayerInJob',
	eventCallback = function(source)
        local char = exports["usa-characters"]:GetCharacter(source)
        local job = char.get("job")
        if job == "civ" then
            return false
        else
            return true
        end
	end
}

RegisterServerCallback {
    eventName = 'catcafe:leaderboard',
    eventCallback = function()
        return GetLeaderboard()
    end
}

local data, firstPlace, secondPlace, thirdPlace, fourthPlace, fifthPlace
function GetLeaderboard()

    MySQL.query("SELECT * FROM usa_catcafe ORDER BY xp DESC LIMIT 5",{}, 
    function(result)
        if result[1] then
            firstPlace = {FirstName = result[1].FirstName, LastName = result[1].LastName, xp = result[1].xp}
        end
        if result[2] then
            secondPlace = {FirstName = result[2].FirstName, LastName = result[2].LastName, xp = result[2].xp}
        end
        if result[3] then
            thirdPlace = {FirstName = result[3].FirstName, LastName = result[3].LastName, xp = result[3].xp}
        end
        if result[4] then
            fourthPlace = {FirstName = result[4].FirstName, LastName = result[4].LastName, xp = result[4].xp}
        end
        if result[5] then
            fifthPlace = {FirstName = result[5].FirstName, LastName = result[5].LastName, xp = result[5].xp}
        end
    end)
    if config.debugMode then print("Updating CatCafe Leaderboard") end

    data = { first = firstPlace,  second = secondPlace,  third = thirdPlace,  fourth = fourthPlace,  fifth = fifthPlace }

    return data
end