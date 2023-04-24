-- to prevent "money injection"
local TRUCKERS = {}

--
-- Functions
--

function getMoney(playerId)
	local char = exports["usa-characters"]:GetCharacter(playerId)
	return char.get("money")
end

function addMoney(playerId, amount)
	local char = exports["usa-characters"]:GetCharacter(playerId)
	char.giveBank(amount, "Los Santos Trucking LTD")
end

function removeMoney(playerId, amount)
	local char = exports["usa-characters"]:GetCharacter(playerId)
	if char.get("money") >= amount then
		char.removeMoney(amount)
		return true
	else
		return false
	end
end

function doesPlayerHaveValidLicense(playerId)
	local status = exports["usa_dmv"]:getLicenseStatus(playerId)
	if not status or status == "suspended" then
		return false
	else 
		return true
	end
end

--
-- Events
--

RegisterServerEvent('encore_trucking:loadDelivered')
AddEventHandler('encore_trucking:loadDelivered', function(securityToken)
	local playerId = source
	if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
		return false
	end
	local totalRouteDistance = TRUCKERS[playerId].distanceToPickup + TRUCKERS[playerId].distanceToDelivery
	local payout   = math.floor(totalRouteDistance * Config.PayPerMeter) + math.random(0, 200)

	addMoney(playerId, payout)

	TriggerClientEvent('encore_trucking:helper:showNotification', playerId, 'Received ~g~$' .. payout .. '~s~ commission from trucking.')
end)

RegisterServerEvent('encore_trucking:rentTruck')
AddEventHandler('encore_trucking:rentTruck', function()
	local playerId = source

	if not doesPlayerHaveValidLicense(playerId) then
		TriggerClientEvent('encore_trucking:helper:showNotification', playerId, 'Invalid driver\'s license!')
		return
	end

	if getMoney(playerId) < Config.TruckRentalPrice then
		TriggerClientEvent('encore_trucking:helper:showNotification', playerId, 'You do not have enough money to rent a truck.')
		return
	end

	if removeMoney(playerId, Config.TruckRentalPrice) then
		TriggerClientEvent('encore_trucking:startJob', playerId)
	else 
		TriggerClientEvent("usa:notify", playerId, "Not enough money for security deposit!")
	end
end)

RegisterServerEvent('encore_trucking:registerTrucker')
AddEventHandler('encore_trucking:registerTrucker', function(distanceToPickup, distanceToDelivery)
	TRUCKERS[source] = {
		distanceToPickup = distanceToPickup,
		distanceToDelivery = distanceToDelivery
	}
end)

RegisterServerEvent('encore_trucking:putKeysInTruck')
AddEventHandler('encore_trucking:putKeysInTruck', function(plate)
	local keys = {
		name = "Key -- " .. plate,
		quantity = 1,
		type = "key",
		owner = "Encore Trucking",
		make = "Semi",
		model = "Truck",
		plate = plate
	}
	keys.coords = GetEntityCoords(GetPlayerPed(source))
    TriggerEvent("interaction:addDroppedItem", keys)
end)

RegisterServerEvent('encore_trucking:returnTruck')
AddEventHandler('encore_trucking:returnTruck', function()
	local playerId = source

	addMoney(playerId, Config.TruckRentalPrice)

	TriggerClientEvent('encore_trucking:helper:showNotification', playerId, 'Your $' .. Config.TruckRentalPrice .. ' deposit was returned to you.')
end)

AddEventHandler("playerDropped", function(reason)
	if TRUCKERS[source] then
		TRUCKERS[source] = nil
		print("[encore_trucking] REMOVED TRUCKER!")
	end
end)