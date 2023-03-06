local Item = { name = "Lottery Ticket", legality = "legal", quantity = 1, type = "misc", weight = 1 },

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000 * 60)
        local check = 'placeholder'
        local reset = MySQL.query.await('SELECT * FROM lotterytotal where lotto = ?', {check})
        local math = reset[1].day + 1
        local resetday = 14
        if os.date('%H:%M') == Config.Reset then
            if reset[1].day ~= resetday then
                MySQL.Async.execute("UPDATE lotterytotal SET day = '"..math.."'")
            else
                TriggerEvent('usa_lottery:choosewinner')
            end
        end
    end
end)

RegisterNetEvent("usa_lottery:choosewinner", function()
    local winningticket = math.random(1, 500)
    local check = 'placeholder'
    local result = MySQL.query.await('SELECT * FROM lotterytotal where lotto = ?', {check})
    local govAmount = Config.Gov_Percentage * result[1].total
    local restAmount = result[1].total - govAmount
    -- etc...
    local reset = 1
    local fundAccount = Config.GovAccounts[math.random(1, #Config.GovAccounts)]
    MySQL.Async.execute("UPDATE lotterytotal SET winner = '"..winningticket.."'")
    MySQL.Async.execute("UPDATE lotterytotal SET previoustotal = '"..restAmount.."'")
    MySQL.Async.execute("UPDATE lotterytotal SET previouswinnernum = '"..winningticket.."'")
    TriggerClientEvent("chatMessage", -1, "[^2Los Santos Lottery^0] Lottery winner has been chosen! Winning Number: " .. winningticket .. "\n Head over to Life Invader to claim your winnings.")

    GetCurrentBalance(fundAccount, function(bal)
        local finishedBalance = bal + govAmount
        SaveNewBalance(finishedBalance, fundAccount)
        
        amountChanged = govAmount
        agencyName = fundAccount
        typeChanged = "Deposit"
        SendToDiscordLog()
    end, fundAccount)
    
    MySQL.Async.execute("UPDATE lotterytotal SET total = '"..math.floor(restAmount).."'")
    MySQL.Async.execute("UPDATE lotterytotal SET day = '"..reset.."'")
end)

RegisterNetEvent("usa_lottery:claimtotal", function()
    local src = source
    local char = exports["usa-characters"]:GetCharacter(src)
    local cid = char.get("_id")
    local check = 'placeholder'
    local result = MySQL.query.await('SELECT * FROM lotterytotal where lotto = ?', {check})
    local amount = result[1].total
    local winningnumber = result[1].winner
    local reset = 0

    if winningnumber >= 1 then
        local checkticket = MySQL.query.await('SELECT * FROM lottery where cid = @cid', { ['@cid'] = char.get("_id") })
        local ticketnumber = checkticket[1].ticketnumber
        if ticketnumber == winningnumber then
            char.giveMoney(amount)
            char.removeItem(Item)
            MySQL.Async.execute("UPDATE lotterytotal SET total = '"..reset.."'")
            MySQL.Async.execute("UPDATE lotterytotal SET winner = '"..reset.."'")
            MySQL.query('DELETE FROM lottery WHERE cid = ?', {cid})
            local charDoc = exports.essentialmode:getDocument("characters", cid)
            local name = charDoc.name.first .. " " .. charDoc.name.middle .. " " .. charDoc.name.last
            MySQL.update('UPDATE lotterytotal SET previouswinner = ?', { json.encode(name) })
            MySQL.query('DELETE FROM lottery') -- This is so when the lottery is claimed by winner it will delete all other users from the database so they can buy a new ticket for the new lottery.
        else
            TriggerClientEvent('usa:notify', src, 'Sorry but this ticket doesn\'t match.')
            char.removeItem(Item)
            MySQL.query('DELETE FROM lottery WHERE cid = ?', {cid})
        end
    else
        TriggerClientEvent('usa:notify', src, 'A winner hasn\'t been chosen yet.')
    end
end)

RegisterNetEvent("usa_lottery:checkticketnumber", function()
    local src = source
    local char = exports["usa-characters"]:GetCharacter(src)
    local cid = char.get("_id")

    local checkticket = MySQL.query.await('SELECT * FROM lottery where cid = @cid', { ['@cid'] = char.get("_id") })
    local ticketnumber = checkticket[1].ticketnumber
    TriggerClientEvent('usa:notify', src, 'Your ticket number is '.. ticketnumber .. '.')
end)

RegisterNetEvent("usa_lottery:purchaselottery", function()
    local src = source
    local char = exports["usa-characters"]:GetCharacter(src)
    local cid = char.get("_id")
    local cost = Config.TicketPrice
    local ticketnumber = math.random(1, 500)
	
    if char.hasEnoughMoneyOrBank(cost) then
        char.removeMoneyOrBank(cost)
        TriggerClientEvent('usa:notify', src, 'You have bought a lottery ticket!')
        MySQL.insert("INSERT INTO `lottery` (`cid`, `ticketnumber`) VALUES ('"..cid.."', '"..ticketnumber.."')")
        local check = 'placeholder'
        local totalamount = MySQL.query.await('SELECT * FROM lotterytotal where lotto = ?', {check})
        local newamount = totalamount[1].total + cost
        MySQL.update("UPDATE lotterytotal SET total = '"..newamount.."' WHERE lotto = '"..check.."'")     
        char.giveItem(Item)
    else   
        TriggerClientEvent('usa:notify', src, 'You don\'t have enough money')
    end
end)

RegisterServerCallback { 
    eventName = "usa_lottery:haspurchased",
    eventCallback = function(source)
        local src = source
        local char = exports["usa-characters"]:GetCharacter(src)
        local cid = char.get("_id")
        local result = MySQL.query.await('SELECT cid FROM lottery WHERE cid = @cid', { ['@cid'] = char.get("_id") })

        if result[1] ~= nil then
            return true
        else
            return false
        end
    end
}

RegisterServerCallback { 
    eventName = "usa_lottery:daycheck",
    eventCallback = function()
        local check = 'placeholder'
        local result = MySQL.query.await('SELECT * FROM lotterytotal where lotto = ?', {check})
        local math = 14 - result[1].day

        if math == 0 then
            return "Today"
        elseif math == 1 then
            return "Tomorrow"
        else
            return "In "..math.." days"
        end
    end
}

RegisterServerCallback { 
    eventName = "usa_lottery:lottototal",
    eventCallback = function()
        local check = 'placeholder'
        local result = MySQL.query.await('SELECT * FROM lotterytotal where lotto = ?', {check})
        local total = result[1].total

        return "$"..exports.globals:comma_value(total)..""
    end
}

RegisterServerCallback { 
    eventName = "usa_lottery:previouswinner",
    eventCallback = function()
        local check = 'placeholder'
        local result = MySQL.query.await('SELECT * FROM lotterytotal where lotto = ?', {check})
        local previouswinner = result[1].previouswinner
        local previouswinnernum = result[1].previouswinnernum

        if previouswinner ~= nil and previouswinnernum ~= nil then
            return previouswinner .. "   Winning Number: " .. previouswinnernum
        else
            return "Not Available"
        end
    end
}

RegisterServerCallback { 
    eventName = "usa_lottery:previoustotal",
    eventCallback = function()
        local check = 'placeholder'
        local result = MySQL.query.await('SELECT * FROM lotterytotal where lotto = ?', {check})
        local previoustotal = result[1].previoustotal

        if previoustotal ~= nil then
            return "$".. exports.globals:comma_value(previoustotal)
        else
            return "Not Available"
        end
    end
}

function SaveNewBalance(finishedBalance, fundAccount)
    exports.essentialmode:updateDocument("govfunds", fundAccount, { content = finishedBalance })
end

function GetCurrentBalance(ident, cb)
    local doc = exports.essentialmode:getDocument("govfunds", ident)
    if doc then
        cb(doc.content)
    end
end

function SendToDiscordLog()
    local desc = "\n**Name:** Los Santos Lottery \n**".. typeChanged ..":** $" .. exports.globals:comma_value(amountChanged) ..  "\n**Agency:** " .. agencyName
	local url = GetConvar("gov-funds-webhook", "")
    PerformHttpRequest(url, function(err, text, headers)
      if text then
        print(text)
      end
    end, "POST", json.encode({
      embeds = {
        {
          description = desc,
          color = 524288,
          author = {
            name = "Government Funds Log"
          }
        }
      }
    }), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end
