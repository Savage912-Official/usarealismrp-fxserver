RegisterServerEvent('oe-aviator:removeMoneyCallBack')
AddEventHandler('oe-aviator:removeMoneyCallBack', function(data)
	local char = exports["usa-characters"]:GetCharacter(source)
	
	if char == nil then
		print("Player loading in")
	else
		char.removeMoney(data)
	end
end)

RegisterServerEvent('oe-aviator:addMoneyCallBack')
AddEventHandler('oe-aviator:addMoneyCallBack', function(data)
	local char = exports["usa-characters"]:GetCharacter(source)

	if char == nil then
		print("Player loading in")
	else
		char.giveMoney(data)
	end
end)

RegisterServerEvent('oe-aviator:loadMoneyServer')
AddEventHandler('oe-aviator:loadMoneyServer', function(data, cashMoney)
	local char = exports["usa-characters"]:GetCharacter(source)
	local cashMoney = char.get("money")

	if char == nil then
		print("Player loading in")
	else
		TriggerClientEvent('oe-aviator:approveMoney', source, cashMoney)
	end
end)