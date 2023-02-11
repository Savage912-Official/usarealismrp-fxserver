local detectableItems = {'weed', 'cocaine', 'meth', 'pseudo', 'phosphorus'}

TriggerEvent('es:addJobCommand', 'k9', {'sheriff', 'corrections'}, function(source, args, char, location)
	TriggerClientEvent('k9:openMenu', source)
end, {
	help = "Open the K9 interaction menu",
})

RegisterServerEvent('k9:playAnimOnAll')
AddEventHandler('k9:playAnimOnAll', function(net, dict, anim, a, b, c, d, e)
	TriggerClientEvent('k9:playAnim', -1, net, dict, anim, a, b, c, d, e)
end)

RegisterServerEvent('k9:smellPlayer')
AddEventHandler('k9:smellPlayer', function(targetSource)
	local char = exports["usa-characters"]:GetCharacter(targetSource)
	local inventory = char.get("inventory")
	for i = 0, (inventory.MAX_CAPACITY - 1) do
		if inventory.items[tostring(i)] then
			local item = inventory.items[tostring(i)]
			if IsItemDetectable(item.name) or item.residue then
				TriggerClientEvent('k9:returnSmell', source)
				return
			end
		end
	end
	TriggerClientEvent("usa:notify", source, "Dog does not smell anything abnormal")
end)

RegisterServerEvent('k9:smellVehicle')
AddEventHandler('k9:smellVehicle', function(targetPlate)
	local userSource = source
	local inv = exports["usa_vehinv"]:GetVehicleInventory(targetPlate)
	for i = 0, inv.MAX_ITEMS - 1 do
		local item = inv.items[tostring(i)]
		if item then
			if IsItemDetectable(item.name) or item.residue then
				TriggerClientEvent('k9:returnSmell', userSource)
				return
			end
		end
	end
	TriggerClientEvent("usa:notify", userSource, "Dog does not smell anything abnormal")
end)

function IsItemDetectable(itemName)
	for i = 1, #detectableItems do
		local item = detectableItems[i]
		if string.find(string.lower(itemName), item) then
			return true
		end
	end
	return false
end
