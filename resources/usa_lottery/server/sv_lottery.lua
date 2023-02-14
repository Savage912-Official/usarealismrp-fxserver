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
    local amount = result[1].total
    local reset = 1
    MySQL.Async.execute("UPDATE lotterytotal SET winner = '"..winningticket.."'")
    TriggerClientEvent("chatMessage", -1, "[^2Los Santos Lottery^0] Lottery winner has been chosen! Winning Number: " .. winningticket .. "\n Head over to Life Invader to claim your winnings.")
    MySQL.Async.execute("UPDATE lotterytotal SET total = '"..amount.."'")
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
            return "Lottery ends Today"
        elseif math == 1 then
            return "Lottery ends Tomorrow"
        else
            return "Lottery ends in "..math.." days."
        end
    end
}