local CARWASH_PRICE = 200


RegisterServerEvent('carwash:checkmoney')
AddEventHandler('carwash:checkmoney', function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local money = char.get("money")
	if money >= CARWASH_PRICE then
		char.removeMoney(CARWASH_PRICE)
		TriggerClientEvent('carwash:success', source)
	else
		TriggerClientEvent('usa:notify', source, 'You cannot afford this purchase!')
	end
end)