local PAY_PER_CHICKEN_MEAT = 250
local KILL = {}

local chickenItems = {
	{name = "Chicken", type = "chicken", legality = "legal", weight = 20, image = "https://i1.wp.com/freepngimages.com/wp-content/uploads/2016/11/chicken-transparent-background.png?fit=457%2C750"},
	{name = "Chicken carcass", type = "chicken", legality = "legal", weight = 10, image = "https://img.pngio.com/dead-chicken-tyranachupng-dead-chicken-png-939_939.png"},
	{name = "Featherless chicken carcass", type = "chicken", legality = "legal", weight = 10, image = "https://cdn.shopify.com/s/files/1/2554/4616/t/5/assets/Image-47_299x.png?16156401367434920007"},
	{name = "Raw chicken meat", type = "chicken", legality = "legal", weight = 1, image = "https://www.pattonsbargainbutcher.com.au/uploads/3/0/1/3/30136237/4385440.png?376"}
}

--need an intermediary function to pass parameters to a callback in LUA
function endItemRetrieval(character, src, chickenItemToGive, quantityToGive, chickenItemToRemove, quantityToRemove, endMessage)
	return function()
		if KILL[src] then -- KILL flag is set if player walks too far away from a chicken factory circle while processing
			-- remove KILL flag for player
			KILL[src] = nil
			return
		end

		if math.random() < 0.1 then
			TriggerClientEvent("chickenJob:endProcessingAnimation", src)
			TriggerClientEvent("usa:notify", src, "The chicken escaped!")
			TriggerClientEvent("chickenJob:spawnChicken", src, true)
			return
		end

		TriggerClientEvent("chickenJob:endProcessingAnimation", src)
		TriggerClientEvent("usa:notify", src, endMessage)

		-- remove item if necessary
		if chickenItemToRemove then
			if not character.hasItem(chickenItemToRemove) then
				return
			else
				character.removeItem(chickenItemToRemove, quantityToRemove)
			end
		end

		-- give item to player
		chickenItemToGive.quantity = quantityToGive
		character.giveItem(chickenItemToGive)
	end
end

RegisterServerEvent("chickenJob:toggleDuty")
AddEventHandler("chickenJob:toggleDuty", function()
	local user_job = exports["usa-characters"]:GetCharacterField(source, "job")
	if user_job == "chickenFactory" then
		TriggerClientEvent("usa:notify", source, "You are now clocked out!")
		exports["usa-characters"]:SetCharacterField(source, "job", "civ")
		-- set a timeout to avoid spamming the job
		timeout = true
		SetTimeout(10000, function()
			timeout = false
		end)
	else
		if not timeout then
			TriggerClientEvent("usa:notify", source, "You are now clocked in!")
			exports["usa-characters"]:SetCharacterField(source, "job", "chickenFactory")
		else
			TriggerClientEvent("usa:notify", source, "You are clocking in and out too fast!")
		end
	end
end)

RegisterServerEvent("chickenJob:getChicken")
AddEventHandler("chickenJob:getChicken", function()
	local character = exports["usa-characters"]:GetCharacter(source)

	if character.get("job") ~= "chickenFactory" then
		TriggerClientEvent("chickenJob:notify", source, "You aren't clocked in!")
		return
	end

	if not character.canHoldItem(chickenItems[1]) then
		TriggerClientEvent("usa:notify", source, "You dont have room to hold that!")
		return
	end

	TriggerClientEvent("usa:notify", source, "You reach into the cage to grab a chicken...")
	TriggerClientEvent("chickenJob:startProcessingAnimation", source)
	SetTimeout(5000, endItemRetrieval(character, source, chickenItems[1], 1, nil, 0, "You've caught a chicken!"))
end)

RegisterServerEvent("chickenJob:killChicken")
AddEventHandler("chickenJob:killChicken", function()
	local character = exports["usa-characters"]:GetCharacter(source)

	if character.get("job") ~= "chickenFactory" then
		TriggerClientEvent("chickenJob:notify", source, "You aren't clocked in!")
		return
	end

	if character.hasItem(chickenItems[1].name) then
		TriggerClientEvent("usa:notify", source, "You snap the chicken's neck and begin to cut off the head...")
		TriggerClientEvent("chickenJob:startProcessingAnimation", source)
		SetTimeout(2000, endItemRetrieval(character, source, chickenItems[2], 1, chickenItems[1], 1, "The bloodied chicken head falls into the bin."))
	else
		TriggerClientEvent("usa:notify", source, "You dont have a Chicken to kill!")
	end
end)

RegisterServerEvent("chickenJob:pluckChicken")
AddEventHandler("chickenJob:pluckChicken", function()
	local character = exports["usa-characters"]:GetCharacter(source)

	if character.get("job") ~= "chickenFactory" then
		TriggerClientEvent("chickenJob:notify", source, "You aren't clocked in!")
		return
	end

	if character.hasItem(chickenItems[2].name) then
		TriggerClientEvent("usa:notify", source, "You begin to pluck the feathers from the chicken's skin...")
		TriggerClientEvent("chickenJob:startProcessingAnimation", source)
		SetTimeout(30000, endItemRetrieval(character, source, chickenItems[3], 1, chickenItems[2], 1, "You pluck the last feather from the body."))
	else
		TriggerClientEvent("usa:notify", source, "You dont have a dead chicken to pluck!")
	end
end)

RegisterServerEvent("chickenJob:chopChicken")
AddEventHandler("chickenJob:chopChicken", function()
	local character = exports["usa-characters"]:GetCharacter(source)

	if character.get("job") ~= "chickenFactory" then
		TriggerClientEvent("usa:notify", source, "You aren't clocked in!")
		return
	end

	if character.hasItem(chickenItems[3].name) then
		TriggerClientEvent("usa:notify", source, "You begin to gut and cut raw meat from the chicken")
		TriggerClientEvent("chickenJob:startProcessingAnimation", source)
		SetTimeout(30000, endItemRetrieval(character, source, chickenItems[4], 4, chickenItems[3], 1, "You finish harvesting the chicken meat"))
	else
		TriggerClientEvent("usa:notify", source, "You dont have a plucked chicken!")
	end
end)

RegisterServerEvent("chickenJob:depositChickenMeat")
AddEventHandler("chickenJob:depositChickenMeat", function()
	local character = exports["usa-characters"]:GetCharacter(source)

	if character.get("job") ~= "chickenFactory" then
		TriggerClientEvent("usa:notify", source, "You aren't clocked in!")
		return
	end

	local item = character.getItem(chickenItems[4].name)
	if item then
		character.removeItem(item, item.quantity)
		character.set("money", character.get("money") + (PAY_PER_CHICKEN_MEAT * item.quantity))
		TriggerClientEvent("usa:notify", source, "~y~You earned: ~w~$" .. PAY_PER_CHICKEN_MEAT * item.quantity .. "!")
	else
		TriggerClientEvent("usa:notify", source, "You dont have any chicken meat!")
	end
end)

RegisterServerEvent("chickenJob:killTask")
AddEventHandler("chickenJob:killTask", function()
	KILL[source] = true
end)

RegisterServerEvent("chickenJob:spawnChicken")
AddEventHandler("chickenJob:spawnChicken", function(itemName)
	local char = exports["usa-characters"]:GetCharacter(source)
	char.removeItem(itemName, 1)
end)
