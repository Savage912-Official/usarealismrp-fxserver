Config.CivJob = "civ"
Config.IsItemNeeded = true
Config.NeededItem = "Driver's License"
Config.UseBuiltInPay = false
Config.PayInterval = 600 -- seconds between pay with built in pay
Config.PayAmount = 1000 -- amount of pay each time player gets payed
Config.TrainTicketCost = 100
Config.MetroTicketCost = 50
Config.CustomCheck = false -- if you want a server side custom check that permits clockin in
Config.MapUpdateInterval = 1

Config.Functions = {
	getMoney = function(source)
		-- server side check money of player
		-- return amount of money (int) to check against
		local money = exports["usa-characters"]:GetCharacterField(source, "money")
		return money
	end,
	removeMoney = function(source, amount)
		-- server side remove money from player
		local char = exports["usa-characters"]:GetCharacter(source)
		char.removeMoney(amount)
	end,
	addMoney = function(source, amount)
		-- server side add money to player
		local char = exports["usa-characters"]:GetCharacter(source)
		char.giveBank(amount)
	end,
	getPlayerId = function(source)
		-- server side function to get a player identifier
		local char = exports["usa-characters"]:GetCharacter(source)
		char.get("_id")
	end,
	getJob = function(source)
		-- server side function to get players job
		local job = exports["usa-characters"]:GetCharacterField(source, "job")
		return job
	end,
	setJob = function(source, job)
		-- server side function to set players job
		local char = exports["usa-characters"]:GetCharacter(source)
		char.set("job", job)
	end,
	checkNeededItem = function(source)
		-- server side function to check players inventory
		-- return true or false if item is found
		local char = exports["usa-characters"]:GetCharacter(source)
		if char.hasItem(Config.NeededItem) then
			return true
		else
			return false
		end
	end,
	customCheck = function(source, job)
		-- server side function to check if a player is able to clock in or not return true if, permitted false if not
		-- source is player id and job is either train or metro
		return true
	end
}

TriggerEvent('es:addJobCommand', 'deletetrain', {'metroDriver', 'trainDriver'}, function(source, args, char, location)
	local source = source
	TriggerClientEvent("max_trains:delTrain", source)
end, {
	help = "Delete your current Train!",
	params = {
	}
})