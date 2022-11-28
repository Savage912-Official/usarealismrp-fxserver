RegisterServerCallback {
	eventName = 'oe-aviator:hasItems',
	eventCallback = function(source)
        local char = exports["usa-characters"]:GetCharacter(source)
		return (char.hasItem("Tablet") and char.hasItem("Casino Dongle"))
	end
}

RegisterServerEvent('oe-aviator:removeMoneyCallBack')
AddEventHandler('oe-aviator:removeMoneyCallBack', function(data)
	local char = exports["usa-characters"]:GetCharacter(source)
	data = tonumber(data)
	
	if char == nil then
		--print("Player loading in")
	else
		char.removeMoney(math.abs(data))
	end
end)

RegisterServerEvent('oe-aviator:addMoneyCallBack')
AddEventHandler('oe-aviator:addMoneyCallBack', function(data, securityToken)
	local char = exports["usa-characters"]:GetCharacter(source)

	if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
		return false
	end

	if char == nil then
		--print("Player loading in")
	else
		char.giveMoney(data)
	end
end)

RegisterServerEvent('oe-aviator:loadMoneyServer')
AddEventHandler('oe-aviator:loadMoneyServer', function(data, cashMoney)
	local char = exports["usa-characters"]:GetCharacter(source)

	if char == nil then
		--print("Player loading in")
	else
		local cashMoney = char.get("money")
		TriggerClientEvent('oe-aviator:approveMoney', source, cashMoney)
	end
end)
