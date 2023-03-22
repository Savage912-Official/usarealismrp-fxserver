--# Script by MrFRZ & minipunch
--# made for USA REALISM RP
--# Adds /mask, /glasses, /hat, /vest for players to toggle them on and off easily

-- Hat prop on / off --
TriggerEvent('es:addCommand', 'hat', function(source, args, char, location)
	TriggerClientEvent("headprops:toggleProp", source, 0)
end, { help = "Take your hat on / off." })

-- Glasses prop on / off --
TriggerEvent('es:addCommand', 'glasses', function(source, args, char, location)
	TriggerClientEvent("headprops:toggleProp", source, 1)
end, { help = "Take your glasses on / off." })

-- Mask component on / off --
TriggerEvent('es:addCommand', 'mask', function(source, args, char, location)
	TriggerClientEvent("headprops:toggleComponent", source, 1)
end, { help = "Take your mask on / off." })

-- Vest component on / off --
TriggerEvent('es:addCommand', 'vest', function(source, args, char, location)
	TriggerClientEvent("headprops:toggleComponent", source, 9)
end, { help = "Take your vest on / off." })

-- DatBoiWeep's Changes --
-- Toggles shirt --
TriggerEvent('es:addCommand', 'shirt', function(source, args, char, location)
	TriggerClientEvent("headprops:toggleComponent", source, 11)
end, { help = "Take your shirt(s) on / off." })

-- Toggles pants --
TriggerEvent('es:addCommand', 'pants', function(source, args, char, location)
	TriggerClientEvent("headprops:toggleComponent", source, 4)
end, { help = "Take your pants on / off." })

-- Toggles backpacks --
TriggerEvent('es:addCommand', 'bag', function(source, args, char, location)
	TriggerClientEvent("headprops:toggleComponent", source, 5)
end, { help = "Take your bag on / off." })

-- Toggles shoes--
TriggerEvent('es:addCommand', 'shoes', function(source, args, char, location)
	TriggerClientEvent("headprops:toggleComponent", source, 6)
end, { help = "Take your shoes on / off." })

-- Toggles hair--
TriggerEvent('es:addCommand', 'baldcap', function(source, args, char, location)
	TriggerClientEvent("headprops:toggleComponent", source, 2)
end, { help = "Put a baldcap on / off." })

-- Puts Hair up / down
TriggerEvent('es:addCommand', 'hair', function(source, args, char, location)
	TriggerClientEvent("hair:toggleHair", source, 2)
end, { help = "Put hair up / down." })

RegisterServerEvent("headprops:loadPropOrComponent")
AddEventHandler("headprops:loadPropOrComponent", function(isProp, id, doEquip)
	local char = exports["usa-characters"]:GetCharacter(source)
	local appearance = char.get("appearance")
	if isProp then
		if appearance.props then
			TriggerClientEvent("headprops:cacheProp", source, id, appearance.props[id], appearance.propstexture[id], doEquip)
		end
	else
		if appearance.components then
			print("getting component with id " .. id .. ", type is " .. type(id))
			TriggerClientEvent("headprops:cacheComponent", source, id, appearance.components[id], appearance.componentstexture[id], doEquip)
		end
	end
	return
end)