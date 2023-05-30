local playerSpinRecord = {}
local playerRewardRecord = {}

math.randomseed(os.time())
isRoll = false
local car = Config.Cars[math.random(#Config.Cars)]

RegisterServerCallback {
	eventName = "luckyWheel:getPrizeCar",
	eventCallback = function(src)
		return car
	end
}

RegisterServerEvent('vns_cs_wheel:getwheel')
AddEventHandler('vns_cs_wheel:getwheel', function()
    local _source = source
	local char = exports["usa-characters"]:GetCharacter(source)
    if not isRoll then
		if char.get("money") >= Config.SpinMoney then
			if Config.DailySpin == true then
				if not playerSpinRecord[char.get("_id")] then
					TriggerEvent("vns_cs_wheel:startwheel", char, source)
					char.removeMoney(Config.SpinMoney)
					exports["usa-businesses"]:GiveBusinessCashPercent("Casino", Config.SpinMoney)
				else
					TriggerClientEvent("usa:notify", source, "You've already used your daily spin", "INFO: You've already used your daily spin")
				end
			elseif Config.DailySpin == false then
				TriggerEvent("vns_cs_wheel:startwheel", char, source)
				char.removeMoney(Config.SpinMoney)
			end
		else
			TriggerClientEvent("usa:notify", source, "Not enough money to spin!", "INFO: Not enough money to spin!")
		end
	end
end)	
	
RegisterServerEvent('vns_cs_wheel:startwheel')
AddEventHandler('vns_cs_wheel:startwheel', function(char, source)
    local _source = source
    if not isRoll then
		playerSpinRecord[char.get("_id")] = true
		isRoll = true
		local rnd = math.random(1, 1000)
		local price = 0
		local priceIndex = 0
		for k,v in pairs(Config.Prices) do
			if (rnd > v.probability.a) and (rnd <= v.probability.b) then
				price = v
				priceIndex = k
				break
			end
		end
		TriggerClientEvent("vns_cs_wheel:syncanim", _source, priceIndex)
		TriggerClientEvent("vns_cs_wheel:startroll", -1, _source, priceIndex, price)
	end
end)

RegisterServerEvent('vns_cs_wheel:give')
AddEventHandler('vns_cs_wheel:give', function(s, reward, securityToken)
	if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), s, securityToken) then
		return false
	end
	local char = exports["usa-characters"]:GetCharacter(s)
	if not playerRewardRecord[char.get("_id")] then -- prevent lua injection exploit, limit calling of this event by any client to 1 per restart to match the script
		isRoll = false
		if reward.type == 'car' then
			print("won car: " .. car)
			-- create data
			local newPlate = exports["usa_carshop"]:generate_random_number_plate()
			local vehInfo = exports["usa_carshop"]:GetVehicleByHashName(car)
			local vehicle = {
				owner = char.getFullName(),
				make = vehInfo.make,
				model = vehInfo.model,
				hash = vehInfo.hash,
				plate = newPlate,
				stored = true,
				price = vehInfo.price,
				inventory = exports["usa_vehinv"]:NewInventory(vehInfo.storage_capacity),
				storage_capacity = vehInfo.storage_capacity
			}
			local vehicle_key = {
				name = "Key -- " .. newPlate,
				quantity = 1,
				type = "key",
				owner = char.getFullName(),
				make = vehInfo.make,
				model = vehInfo.model,
				plate = newPlate
			}
			-- add vehicle to database
			exports.usa_carshop:AddVehicleToDB(vehicle)
			-- add vehicle to player's list of owned vehicles
			local vehs = char.get("vehicles")
			table.insert(vehs, vehicle.plate)
			char.set("vehicles", vehs)
			-- notify
			TriggerClientEvent("usa:notify", s, "You won a car!!", "INFO: " .. "You won a " .. vehicle.make .. " " .. vehicle.model .. "! Congratulations!! Check your garage!!")
		elseif reward.type == 'item' then
			print("won item: " .. reward.count .. " " .. reward.name)
			if reward.name == "Trading Card" then
				-- choose random trading card item to give
				local tradingCardItems = exports.usa_rp2:getAllItemsByFieldVal("type", "tradingCard")
				local randomCard = tradingCardItems[math.random(#tradingCardItems)]
				char.giveItem(randomCard)
			else
				local item = exports.usa_rp2:getItem(reward.name)
				item.quantity = reward.count
				char.giveItem(item)
			end
			TriggerClientEvent("usa:notify", s, "Won: " .. reward.name .. "!", "INFO: " .. "You won " .. reward.name .. "!")
		elseif reward.type == 'money' then
			print("won money")
			reward.count = math.abs(reward.count)
			char.giveBank(reward.count, "Diamond Casino")
			TriggerClientEvent("usa:notify", s, "Won: $" .. exports.globals:comma_value(reward.count) .. "!", "INFO: " .. "You won $" .. exports.globals:comma_value(reward.count) .. "!")
		end
		TriggerClientEvent("vns_cs_wheel:rollFinished", -1)
		playerRewardRecord[char.get("_id")] = true
	end
end)

RegisterServerEvent('vns_cs_wheel:stoproll')
AddEventHandler('vns_cs_wheel:stoproll', function()
	isRoll = false
end)

-- todo: hardcode reward.name to be a trading card so we can test real fast and then move on!!