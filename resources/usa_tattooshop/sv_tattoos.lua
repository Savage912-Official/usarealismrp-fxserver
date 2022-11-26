--# made by: minipunch
--# for: USA REALISM RP

local TATTOO_FEE = 2000

RegisterServerEvent("tattoo:save")
AddEventHandler("tattoo:save", function(appearance, business, num, prev_app)
	local char = exports["usa-characters"]:GetCharacter(source)
	local price = TATTOO_FEE * math.abs(num)
	if char.get("money") >= price then
		TriggerClientEvent("usa:notify", source, "~y~You paid: ~w~$" .. price)
		char.removeMoney(price)
		if business then
			exports["usa-businesses"]:GiveBusinessCashPercent(business, price)
		end
		saveAppearance(char.get("_id"), appearance)
	else
		TriggerClientEvent("usa:notify", source, "You don't have enough money to pay the total: $" .. price)
		TriggerClientEvent("spawn:loadCustomizations", source, prev_app)
	end
end)

function saveAppearance(charID, appearance)
	TriggerEvent("es:exposeDBFunctions", function(db)
		db.updateDocument("character-appearance", charID, appearance, function(doc) end, true)
	end)
end

exports["globals"]:PerformDBCheck("usa_tattooshop", "character-appearance", nil)