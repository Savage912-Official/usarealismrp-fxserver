local REWARD_RANGES = {
    fur = {
        low = 230,
        high = 450
    },
    meat = {
        low = 200,
        high = 350
    }
}

RegisterServerEvent("hunting:skinforfurandmeat")
AddEventHandler("hunting:skinforfurandmeat", function(securityToken)
    if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
		return false
	end
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    local fur = {
        name = "Animal Fur",
        legality = "legal",
        quantity = 1,
        type = 'misc',
        weight = 7
    }
    local meat = {
        name = "Butchered Meat",
        legality = "legal",
        quantity = math.random(1, 5),
        type = 'misc',
        weight = 5
    }
    if char.canHoldItem(fur) then
        char.giveItem(fur)
    else
        TriggerClientEvent('usa:notify', usource, 'Inventory is full!')
    end

    if char.canHoldItem(meat) then
        char.giveItem(meat)
    else
        TriggerClientEvent('usa:notify', usource, 'Inventory is full!')
    end
end)

RegisterServerEvent('hunting:cookMeat')
AddEventHandler('hunting:cookMeat', function(itemName)
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    if char.hasItem(itemName) then
        TriggerClientEvent('hunting:cookMeat', source)
    end
end)

RegisterServerEvent('hunting:giveCookedMeat')
AddEventHandler('hunting:giveCookedMeat', function(securityToken)
    if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
		return false
	end
    local char = exports["usa-characters"]:GetCharacter(source)
    if char.hasItem("Butchered Meat") then
        if char.canHoldItem(cookedMeat) then
            local cookedMeat = {
                name = "Cooked Meat",
                legality = "legal",
                quantity = 1,
                type = 'food',
                substance = 25.0,
                weight = 5
            }
            char.removeItem("Butchered Meat")
            char.giveItem(cookedMeat)
            TriggerClientEvent("usa:notify", source, "Your meat is now ready to eat!")
        else
            TriggerClientEvent("usa:notify", source, "Inventory full")
        end
    end
end)

RegisterServerEvent("hunting:sellFur")
AddEventHandler("hunting:sellFur", function()
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    if char.hasItem("Animal Fur") then
        char.removeItem("Animal Fur", 1)
        local reward = math.random(REWARD_RANGES.fur.low, REWARD_RANGES.fur.high)
        char.giveMoney(reward)
        TriggerClientEvent('usa:notify', usource, 'You have been paid $' .. reward)
    else
        TriggerClientEvent('usa:notify', usource, 'You do not have any fur for sale!')
    end
    TriggerClientEvent("hunting:sellFur", source)
end)

RegisterServerEvent("hunting:sellMeat")
AddEventHandler("hunting:sellMeat", function()
    local usource = source
    local char = exports["usa-characters"]:GetCharacter(usource)
    if char.hasItem("Butchered Meat") then
        char.removeItem("Butchered Meat", 1)
        local reward = math.random(REWARD_RANGES.fur.low, REWARD_RANGES.fur.high)
        char.giveMoney(reward)
        TriggerClientEvent('usa:notify', usource, 'You have been paid $' .. reward)
    else
        TriggerClientEvent('usa:notify', usource, 'You do not have any meat to sell!')
    end

    TriggerClientEvent("hunting:sellMeat", source)
end)

RegisterServerCallback {
	eventName = 'hunting:doesHaveMeat',
	eventCallback = function(source)
        local char = exports["usa-characters"]:GetCharacter(source)
		return char.hasItem("Butchered Meat")
	end
}
