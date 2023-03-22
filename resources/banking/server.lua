local robbedATMs = {}
local players_that_blew_atm = {}
local ATM_ROBBED_TIMEOUT_HOURS = 4
local NUM_COPS_REQUIRED = 2

-- HELPER FUNCTIONS
function bankBalance(player)
	return exports["usa-characters"]:GetCharacterField(player, "bank")
end

function deposit(player, amount)
	if amount <= 0 then
		local bankbalance = bankBalance(player)
		local new_balance = bankbalance + math.abs(amount)

		local char = exports["usa-characters"]:GetCharacter(player)
		char.giveBank(math.abs(amount))

		TriggerClientEvent("banking:updateBalance", player, new_balance)
	end
end

function withdraw(player, amount)
	local bankbalance = bankBalance(player)
	local new_balance = bankbalance - math.abs(amount)

	local char = exports["usa-characters"]:GetCharacter(player)
	char.removeBank(math.abs(amount))

	TriggerClientEvent("banking:updateBalance", player, new_balance)
end

function round(num, numDecimalPlaces)
	if num and numDecimalPlaces then
		local mult = 10^(numDecimalPlaces or 0)
		return math.abs(math.floor(num * mult + 0.5) / mult)
	end
end

local notAllowedToDeposit = {}

AddEventHandler('bank:addNotAllowed', function(pl)
	notAllowedToDeposit[pl] = true

	local savedSource = pl
	SetTimeout(300000, function()
		notAllowedToDeposit[savedSource] = nil
	end)
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(targetID, amount)
	if amount <= 0 then 
		TriggerClientEvent("usa:notify", source, "Enter an amount greater than 0!")
		return
	end
	local char = exports["usa-characters"]:GetCharacter(source)
	local bank = char.get("bank")
	if bank >= amount then 
		local target = exports["usa-characters"]:GetCharacter(targetID)
		if target then
			char.removeBank(amount)
			target.giveBank(amount)
			TriggerClientEvent("usa:notify", source, "Transfer of ~g~$" .. exports["globals"]:comma_value(amount) .. "~w~ complete!")
			TriggerClientEvent("usa:notify", targetID, "A transfer of ~g~$" .. exports["globals"]:comma_value(amount) .. "~w~ has been transferred to your account!")
			-- Write to Admin log
			TriggerEvent("chat:sendToLogFile", source, "Player has transfered $" .. exports["globals"]:comma_value(amount) .. " to [ID:"..targetID.." / " ..GetPlayerIdentifiers(targetID)[1].."].")
		else
			TriggerClientEvent("usa:notify", source, "Error processing transfer request. Try again later.")
		end
	else
		TriggerClientEvent("usa:notify", source, "Not enough money to transfer!")
	end
end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local char = exports["usa-characters"]:GetCharacter(source)
	if notAllowedToDeposit[source] == nil then
		local rounded = math.ceil(tonumber(amount))
		if(string.len(rounded) >= 9) then
			TriggerClientEvent('usa:notify', source, "Amount to deposit too high!")
		else
			local money = char.get("money")
			local bank = char.get("bank")
			if (rounded <= money and rounded > 0) then
				local UpdBank = bank + rounded
				local UpdMoney = rounded - money
				-- Console + Admin Log
				print("BANK: Updating balance of "..GetPlayerName(source).."["..GetPlayerIdentifier(source).."] after depositing money["..rounded.."], with new bank total of bank["..UpdBank.."] and money["..UpdMoney.."]!")
				TriggerEvent("chat:sendToLogFile", source, "Player's balance is being updated after depositing [$"..rounded.."]. Their new total is Bank:[$"..UpdBank.."] and Money:[$"..UpdMoney.."]!")
				TriggerClientEvent("banking:updateBalance", source, (bank + rounded))
				TriggerClientEvent("banking:addBalance", source, rounded)
				char.removeMoney(rounded)
				char.giveBank(rounded)
			else
				TriggerClientEvent('usa:notify', source, "You do not have enough cash!")
			end
		end
	else
		TriggerClientEvent('usa:notify', source, "The bank has rejected your deposit!")
	end
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local char = exports["usa-characters"]:GetCharacter(source)
    local rounded = round(tonumber(amount), 0)
    if (string.len(tostring(rounded)) >= 9) then
    	TriggerClientEvent('usa:notify', source, "Amount to withdraw too high!")
    else
        local money = char.get("money")
		local bank = char.get("bank")
		if bank and tonumber(rounded) then
			if (tonumber(rounded) <= tonumber(bank)) then
				local UpdBank = bank - rounded
				local UpdMoney = rounded + money
				-- Console + Admin Log
				print("BANK: Updating balance of "..GetPlayerName(source).."["..GetPlayerIdentifier(source).."] after withdrawing money["..rounded.."], with new bank total of bank["..UpdBank.."] and money["..UpdMoney.."]!")
				TriggerEvent("chat:sendToLogFile", source, "Player's balance is being updated after withdrawing [$"..rounded.."]. Their new total is Bank:["..UpdBank.."] and Money:["..UpdMoney.."]!")
			  	TriggerClientEvent("banking:updateBalance", source, (bank - rounded))
			 	TriggerClientEvent("banking:removeBalance", source, rounded)
				char.giveMoney(rounded)
				char.removeBank(rounded)	
			else
			  TriggerClientEvent('usa:notify', source, "Amount to withdraw is over allowance!")
			end
		end
   	end
end)

-- Give Cash
TriggerEvent('es:addCommand', 'givecash', function(source, args, char)
	if #args == 3 then
		local toPlayer = tonumber(args[2])
		local toChar = exports["usa-characters"]:GetCharacter(toPlayer)
		if toChar then
			local to_user_name = toChar.getFullName()
			local amount = math.abs(math.ceil(tonumber(args[3])))
			if char.get("money") >= amount then
				TriggerClientEvent('bank:givecash', source, toPlayer, amount, "test", source)
			else 
				TriggerClientEvent('usa:notify', source, "You don't have that much!")
			end
		end
	else
		TriggerClientEvent('usa:notify', source, "~y~Usage: ~w~/givecash <id> <amount>")
	end
end, {
	help = "give cash to another player",
	params = {
		{ name = "id", help = "Players ID" },
		{ name = "money", help = "Amount of money" }
	}
})

AddEventHandler('rconCommand', function(cmd, args)
	if cmd == "setbank" then
		local target = tonumber(args[1])
		local newAmount = tonumber(args[2])
		if GetPlayerName(target) and newAmount and newAmount > 0 then
			exports["usa-characters"]:SetCharacterField(target, "bank", newAmount)
			TriggerClientEvent('chatMessage', target, "", {255, 255, 255}, "^2^*[SERVER] ^r^0Your bank has been set to ^2^*" .. newAmount..'^r^0.')
			TriggerEvent("usa:notifyStaff", '^2^*[STAFF]^r^0 Bank of ^2'..GetPlayerName(target)..' ['..target..'] ^0 has been set to ^2^*'..newAmount..'^r^0 by ^2^*console^r^0.')
			print('Bank set!')
			CancelEvent()
		end
	elseif cmd == "givebank" then
		local target = tonumber(args[1])
		local amountToGive = tonumber(args[2])
		if GetPlayerName(target) and newAmount and newAmount > 0 then
			local char = exports["usa-characters"]:GetCharacter(target)
			char.giveBank(amountToGive)
			TriggerClientEvent('chatMessage', target, "", {255, 255, 255}, "^2^*[SERVER] ^r^0You have received ^2^*" .. amount..'^r^0 in your bank.')
			TriggerEvent("usa:notifyStaff", '^2^*[STAFF]^r^0 Player ^2'..GetPlayerName(target)..' ['..target..'] ^0 has received ^2^*'..amountToGive..'^r^0 bank money from ^2^*console^r^0.')
			print('Bank set!')
			CancelEvent()
		end
	end
end)

RegisterServerEvent('bank:givecash')
AddEventHandler('bank:givecash', function(toPlayer, amount)
	amount = (tonumber(amount) or 0)
	amount = math.floor(amount)
	amount = math.abs(amount)
	local char = exports["usa-characters"]:GetCharacter(source)
	local recipient = exports["usa-characters"]:GetCharacter(toPlayer)
	if GetPlayerName(toPlayer) then
		local from_money = char.get("money")
		if (from_money >= amount) then
			char.removeMoney(amount)
			recipient.giveMoney(amount)
			TriggerClientEvent('usa:notify', source, "You've given " .. toPlayer .. " $" .. comma_value(amount))
			TriggerClientEvent('chatMessage', source, "", {}, "You've given " .. toPlayer .. " $" .. comma_value(amount))
			TriggerClientEvent('usa:notify', toPlayer, source .. " has given you $" .. comma_value(amount))
			TriggerClientEvent('chatMessage', toPlayer, "", {}, source .. " has given you $" .. comma_value(amount))
		else
			if (tonumber(from_money) < tonumber(amount)) then
				TriggerClientEvent('usa:notify', source, "You do not have enough cash!")
			end
		end
	else
		TriggerClientEvent('usa:notify', source, "Player not found!")
	end
end)

RegisterServerEvent("bank:showBankBalance")
AddEventHandler("bank:showBankBalance", function()
	local bank = exports["usa-characters"]:GetCharacterField(source, "bank")
	TriggerClientEvent("usa:notify", source, "Bank Balance: ~s~$" .. comma_value(bank))
end)

RegisterServerEvent("bank:getBalanceForGUI")
AddEventHandler("bank:getBalanceForGUI", function(coords)
	local canUse = true
	if robbedATMs[coords] ~= nil then
    	if GetGameTimer() - robbedATMs[coords] < ATM_ROBBED_TIMEOUT_HOURS * 3600000 then
    		canUse = false
    	end
    end
    if canUse then
		TriggerClientEvent("bank:getBalanceForGUI", source, exports["usa-characters"]:GetCharacterField(source, "bank"))
	else
		TriggerClientEvent("usa:notify", source, "This ATM looks damaged!")
	end
end)

TriggerEvent('es:addCommand', 'bank', function(source, args, char)
	local bank = char.get("bank")
	TriggerClientEvent("usa:notify", source, "Bank Balance: ~s~$" .. comma_value(bank))
end, { help = "view bank balance" })

function comma_value(amount)
	local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

RegisterServerEvent("banking:checkATMBlow")
AddEventHandler("banking:checkATMBlow", function(coords)
	local src = source
    local char = exports["usa-characters"]:GetCharacter(source)
    local canRob = true
    if robbedATMs[coords] ~= nil then
    	if GetGameTimer() - robbedATMs[coords] < ATM_ROBBED_TIMEOUT_HOURS * 3600000 then
    		canRob = false
    	end
    end
    exports.globals:getNumCops(function(numCops)
	    if numCops >= NUM_COPS_REQUIRED and canRob then
	        if char.hasItem("Thermite") then
	            robbedATMs[coords] = GetGameTimer()
	            char.removeItem("Thermite", 1)
	            TriggerClientEvent("banking:blowATM", src)
	        else
	            TriggerClientEvent("usa:notify", src, "You have no thermite!")
	        end
	    else 
	        TriggerClientEvent('usa:notify', src, 'The ATM looks damaged!')
	    end
	end)
end)

RegisterServerEvent("banking:checkATMDrill")
AddEventHandler("banking:checkATMDrill", function(coords)
	local src = source
	local canRob = true
	if robbedATMs[coords] ~= nil then
    	if GetGameTimer() - robbedATMs[coords] < ATM_ROBBED_TIMEOUT_HOURS * 3600000 then
    		canRob = false
    	end
    end
    exports.globals:getNumCops(function(numCops)
		if numCops >= NUM_COPS_REQUIRED and canRob then
			TriggerClientEvent("banking:StartDrillATM", src)
		else
	        TriggerClientEvent('usa:notify', src, 'The ATM looks damaged!')
	    end
	end)
end)

Citizen.CreateThread(function()
	while true do
		for player,timestamp in pairs(players_that_blew_atm) do
			if GetGameTimer() - timestamp > 120000 then
				players_that_blew_atm[player] = nil
			end
		end
		Citizen.Wait(1000)
	end
end)

RegisterNetEvent("banking:addPlayerToBlowList")
AddEventHandler("banking:addPlayerToBlowList", function()
	local src = source
	local timestamp = GetGameTimer()
	players_that_blew_atm[src] = timestamp
end)

RegisterServerEvent("banking:pickupMoney")
AddEventHandler("banking:pickupMoney", function()
	local src = source
	if players_that_blew_atm[src] ~= nil then
		local money = math.random(300,2000)
		local src = source
	    local char = exports["usa-characters"]:GetCharacter(source)
	    char.giveMoney(money)
		TriggerEvent("usa:notify", src, "You picked up a bundle of $" .. money)
	end
end)
