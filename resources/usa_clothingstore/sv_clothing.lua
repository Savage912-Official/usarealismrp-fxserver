function round(num, numDecimalPlaces)
	local mult = 5^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

-- charge customer --
RegisterServerEvent("clothing-store:chargeCustomer")
AddEventHandler("clothing-store:chargeCustomer", function(business)
	local amount = 60
	local char = exports["usa-characters"]:GetCharacter(source)
	local money = char.get("money")
	if money - amount >= 0 then
		char.removeMoney(amount)
		TriggerClientEvent("clothing-store:openMenu", source)
		if business then
			exports["usa-businesses"]:GiveBusinessCashPercent(business, amount)
		end
	else
		TriggerClientEvent("usa:notify", source, "You don't have enough money!")
	end
end)

RegisterServerEvent("mini:save")
AddEventHandler("mini:save", function(appearance)
	local char = exports["usa-characters"]:GetCharacter(source)
	local character = exports["usa-characters"]:GetCharacter(source)

	local cAppearance = character.get("appearance")
	cAppearance.hash = appearance.hash
	cAppearance.componentstexture = appearance.componentstexture
	cAppearance.components = appearance.components
	cAppearance.propstexture = appearance.propstexture
	cAppearance.props = appearance.props
	character.set("appearance", cAppearance)

	TriggerClientEvent("headprops:cacheProp", source, 0, appearance.props[9], appearance.propstexture[9])
	TriggerClientEvent("headprops:cacheProp", source, 1, appearance.props[9], appearance.propstexture[9])
	TriggerClientEvent("headprops:cacheComponent", source, 1, appearance.components[1], appearance.componentstexture[1])
	TriggerClientEvent("headprops:cacheComponent", source, 9, appearance.components[9], appearance.componentstexture[9])

	TriggerClientEvent("usa:notify", source, "Character has been saved!")
end)

RegisterServerEvent("mini:giveMeMyWeaponsPlease")
AddEventHandler("mini:giveMeMyWeaponsPlease", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	if char then
		local playerWeapons = char.getWeapons()
    	TriggerClientEvent("CS:giveWeapons", source, playerWeapons)
	end
end)

RegisterServerCallback { 
    eventName = "usa_clothingstore:GetSteamHex",
    eventCallback = function(source)
		local steam = GetPlayerIdentifiers(source)[1]
        return steam
    end
}