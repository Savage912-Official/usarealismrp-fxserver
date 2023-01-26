local COOLDOWN_TIME_HOURS = 5

local webhook = nil
local x,y,z = nil, nil, nil
local hacked = false
local num = 0 
local isDoorBeingHacked = false
local haveGuardsSpawned = false
local randomHintBlipXOffset = math.random(10, math.floor(Config.HintBlipRadius / 2))
local randomHintBlipYOffset = math.random(10, math.floor(Config.HintBlipRadius / 2))

local crates = {
	--[[
	{x = 1052.95, 	 y = -3110.31,  z = -39.99,	h = 180.0, opened = false},
	{x = 1055.56, 	 y = -3110.26,	z = -39.99,	h = 180.0, opened = false},
	{x = 1057.91, 	 y = -3110.14,  z = -39.99,	h = 180.0, opened = false},
	{x = 1060.26, 	 y = -3110.37,  z = -39.99,	h = 180.0, opened = false},
	{x = 1062.74,    y = -3110.54,  z = -39.99,	h = 180.0, opened = false},
	{x = 1065.12,    y = -3110.50,  z = -39.99,	h = 180.0, opened = false},
	{x = 1067.44,    y = -3110.62,  z = -39.99,	h = 180.0, opened = false},
	--]]

	{x = 1067.44, 	 y = -3102.73,  z = -39.99,	h = 0.0, opened = false},
	{x = 1065.25, 	 y = -3102.79,  z = -39.99,	h = 0.0, opened = false},
	{x = 1062.81, 	 y = -3103.26,  z = -39.99,	h = 0.0, opened = false},
	{x = 1060.10, 	 y = -3103.00,  z = -39.99,	h = 0.0, opened = false},
	{x = 1057.83, 	 y = -3103.01,  z = -39.99,	h = 0.0, opened = false},
	--{x = 1055.58, 	 y = -3103.02,  z = -39.99,	h = 0.0, opened = false},
	--{x = 1053.06,	 y = -3103.05,  z = -39.99,	h = 0.0, opened = false},
	
	--[[
	{x = 1053.13, 	 y = -3095.97,  z = -39.99,	h = 0.0, opened = false},
	{x = 1055.64,    y = -3095.93,  z = -39.99,	h = 0.0, opened = false},
	{x = 1057.88,	 y = -3095.97,  z = -39.99,	h = 0.0, opened = false},
	{x = 1060.34,	 y = -3095.87,  z = -39.99,	h = 0.0, opened = false},
	{x = 1062.74,	 y = -3095.90,  z = -39.99,	h = 0.0, opened = false},
	{x = 1065.34,	 y = -3095.99,  z = -39.99,	h = 0.0, opened = false},
	{x = 1067.60,  	 y = -3095.97,  z = -39.99,	h = 0.0, opened = false},
	--]]
}

-- Warehouse Entry Locations
local locations = {
	[1]={x = -619.60, 	y = -1111.81, 	z = 22.17, hint = "There's a warehouse in the back of the Korean Plaza in Little Seoul on Calais Avenue. There's a white garage door we can hack open -- if you're any good at that."},
	[2]={x = -1413.34,	y = -654.71, 	z = 28.67, hint = "There's a door we can try to hack open behind those apartments on Marathon Avenue in LS."},
	[3]={x = -1370.22,	y = -324.45, 	z = 39.25, hint = "There's a door we can try to hack open behind Woody's Autos in LS."},
	[4]={x = -617.51, 	y = 314.43, 	z = 82.25, hint = "There's a door we can try to hack open across the street from the Liquor Hole on Eclipse Boulevard in LS."},
	[5]={x = 150.54, 	y = 322.66, 	z = 112.33, hint = "There's a door inside a garage right where Las Lagunas Blvd meets Clinton Ave in LS."},
	[6]={x = 569.06, 	y = 2796.66, 	z = 42.01, hint = "There's a door in Harmony we can try to get in to."},
	[7]={x = 905.85, 	y = 3586.51, 	z = 33.42, hint = "There's a door in Sandy Shores we can try to hack in to."},
	[8] = {x = -707.56939697266, y = -2448.1044921875, z = 13.944402694702, hint = "There's a set of doors by the lowkey nightclub next to the Los Santos Airport that you can try and hack into."},
	[9] = {x = -52.059631347656, y = 6395.5522460938, z = 31.490346908569, hint = "There's a door at one of the warehouses across from Clucking Bells in Paleto that you can try and hack into."},
--	[10] = {x = 5003.3681640625, y = -5149.7998046875, z = 2.5803475379944, hint = "There's a backdoor at one of the rusted over warehouses on the island, they're the ones closest to the mansion, if you find it you can try and hack into it."}  | Removed this one as it causes issues whenever entering/leaving. Do not activate again unless you fix it please - Khajit
}

RegisterServerCallback {
	eventName = 'av_warehouse:entrada',
	eventCallback = function(source)		
		return {x = x, y = y, z = z, n = num}
	end
}

RegisterServerCallback {
	eventName = 'av-warehouse:getLocations',
	eventCallback = function(source)		
		return locations
	end
}

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		local ubicacion = math.random(1, #locations)		
		local coord = locations[ubicacion]
		num = math.random(111,999)
		x, y, z = coord.x, coord.y, coord.z
		if Config.PrintCoords == 'server' then
			print('^3[AV Warehouse]: ^5'..x..' '..y..' '..z..'^7')
		elseif Config.PrintCoords == 'discord' then
			local content = {
				{
					["color"] = '12386304',
					["title"] = "** AV Warehouse **",
					["description"] = '**Warehouse coords: **'..x..' '..y..' '..z,
					["footer"] = {
						["text"] = 'AV Warehouse',
					},
				}
			}
			TriggerEvent('av_warehouse:discord',content)
		elseif Config.PrintCoords == 'both' then
			print('^3[AV Warehouse]: ^5'..x..' '..y..' '..z..'^7')
			local content = {
				{
					["color"] = '12386304',
					["title"] = "** AV Warehouse **",
					["description"] = '**Warehouse coords: **'..x..' '..y..' '..z,
					["footer"] = {
						["text"] = 'AV Warehouse',
					},
				}
			}
			TriggerEvent('av_warehouse:discord',content)
		else
			print('^3[AV Warehouse]: ^5 Something is wrong on Config.lua line 3^7')
		end
	end
end)

RegisterServerEvent('av_warehouse:hacked')
AddEventHandler('av_warehouse:hacked', function()
	if hacked then return end	

	local src = source

	local char = exports["usa-characters"]:GetCharacter(src)
	local nombre = char.getName()
	local hora = os.date("%d/%m/%Y %X")

	if Config.removeDoorItem then
		char.removeItem(Config.DoorItem,1)
	end

	hacked = true

	SetTimeout(COOLDOWN_TIME_HOURS * 60 * 60 * 1000, function()
		print('^3[AV Warehouse]: ^2Cooldown finished^0')
		TriggerEvent('av_warehouse:reset')
	end)
	
	print('^3[AV Warehouse]: ^2Cooldown started^0')
	
	TriggerClientEvent("av_warehouse:setDoorText", -1, Config.Lang["enter"])

	local content = {
		{
			["color"] = '12386304',
			["title"] = "** AV Warehouse **",
			["description"] = '**'..nombre..'** stole the Warehouse',
			["footer"] = {
				["text"] = hora,
			},
		}
	}
	TriggerEvent('av_warehouse:discord',content)
end)

RegisterServerEvent('av_warehouse:loot')
AddEventHandler('av_warehouse:loot', function(a, crateIndex, securityToken)
	if crates[crateIndex].opened then
		TriggerClientEvent("usa:notify", source, "Already opened!")
		return
	end
	local src = source
    if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), src, securityToken) then
		return false
	end
	local char = exports["usa-characters"]:GetCharacter(src)
	-- lua injection check:	
	if a ~= num then 
		local nombre = char.getName()	
		local content = {
			{
				["color"] = '12386304',
				["title"] = "** AV Warehouse **",
				["description"] = '**'..nombre..'** was caught cheating, using Lua injector',
				["footer"] = {
					["text"] = 'AV Warehouse',
				},
			}
		}
		TriggerEvent('av_warehouse:discord',content)
		DropPlayer(source,'Buy a better Lua Executor.... :/')
		print('^3[AV Warehouse]: ^2CHEATER: ^0'..nombre)
		return
	end
	-- mark crate as opened:
	crates[crateIndex].opened = true
	-- sync with others who are also in warehouse:
	TriggerClientEvent("av_warehouse:openCrate", -1, crateIndex)
	-- give random reward:
	local loot = math.random(1, #Config.Rewards)
	local caja = Config.Rewards[loot]	
	if caja.type == 'items' then		
		for _, item in pairs(caja.reward) do
			item.coords = GetEntityCoords(GetPlayerPed(src))
			local newCoords = {
				x = item.coords.x,
				y = item.coords.y,
				z = item.coords.z
			}
			newCoords.x = newCoords.x + (math.random() * 1)
			newCoords.y = newCoords.y + (math.random() * 1)
			newCoords.z = newCoords.z - 0.85
			item.coords = newCoords
			if not item.quantity then
				item.quantity = 1
			end
			if item.type and (item.type == "magazine" or item.type == "weapon") then
				item.notStackable = true
			end
			TriggerEvent("interaction:addDroppedItem", item)
			TriggerClientEvent("usa:notify", src, Config.Lang['you_stole']..''..item.quantity..'x '..item.name)
		end		
	elseif caja.type == 'weapons' then
		for _, wp in pairs(caja.reward) do
			wp.coords = GetEntityCoords(GetPlayerPed(src))
			local newCoords = {
				x = wp.coords.x,
				y = wp.coords.y,
				z = wp.coords.z
			}
			newCoords.x = newCoords.x + (math.random() * 1)
			newCoords.y = newCoords.y + (math.random() * 1)
			newCoords.z = newCoords.z - 0.85
			wp.coords = newCoords
			TriggerEvent("interaction:addDroppedItem", wp)
			TriggerClientEvent("usa:notify", src, Config.Lang['you_stole']..'1x '..wp.name)
		end
	elseif caja.type == 'money' then
		for _, money in pairs(caja.reward) do
			local toGiveAmount = math.floor(money.amount + (math.random() * 6000))
			char.giveMoney(toGiveAmount)
			TriggerClientEvent("usa:notify", src, Config.Lang['you_stole']..'$'..exports.globals:comma_value(toGiveAmount))
		end
	end
end)

RegisterServerEvent('av_warehouse:reset')
AddEventHandler('av_warehouse:reset', function()
	local ubicacion = math.random(1, #locations)		
	local coord = locations[ubicacion]
	x, y, z = coord.x, coord.y, coord.z	 
	TriggerClientEvent('av_warehouse:reset',-1,x,y,z)
	for i = 1, #crates do
		crates[i].opened = false
	end
	if Config.PrintCoords == 'server' then
		print('^3[AV Warehouse]: ^5'..x..' '..y..' '..z..'^7')
	elseif Config.PrintCoords == 'discord' then
		local content = {
			{
				["color"] = '12386304',
				["title"] = "** AV Warehouse **",
				["description"] = '**Warehouse coords: **'..x..' '..y..' '..z,
				["footer"] = {
					["text"] = 'AV Warehouse',
				},
			}
		}
		TriggerEvent('av_warehouse:discord',content)
	elseif Config.PrintCoords == 'both' then
		print('^3[AV Warehouse]: ^5'..x..' '..y..' '..z..'^7')
		local content = {
			{
				["color"] = '12386304',
				["title"] = "** AV Warehouse **",
				["description"] = '**Warehouse coords: **'..x..' '..y..' '..z,
				["footer"] = {
					["text"] = 'AV Warehouse',
				},
			}
		}
		TriggerEvent('av_warehouse:discord',content)
	else
		print('^3[AV Warehouse]: ^5 Something is wrong on Config.lua line 3^7')
	end
	haveGuardsSpawned = false
	isDoorBeingHacked = false
	hacked = false
	randomHintBlipXOffset = math.random(10, Config.HintBlipRadius / 2)
	randomHintBlipYOffset = math.random(10, Config.HintBlipRadius / 2)
end)

RegisterServerEvent('av_warehouse:police')
AddEventHandler('av_warehouse:police', function(coords)
	TriggerClientEvent('av_warehouse:notify',-1,coords)
end)

RegisterServerCallback {
	eventName = 'av_warehouse:copAndItemCheck',
	eventCallback = function(source)
		local src = source
		local numCops = nil
		exports.globals:getNumCops(function(n)
			numCops = n
		end)
		while numCops == nil do
			Wait(1)
		end
		if numCops >= Config.MinCops then
			if Config.UseItem then
				local char = exports["usa-characters"]:GetCharacter(src)
				if not char.hasItem(Config.DoorItem) then
					TriggerClientEvent("usa:notify", src, Config.Lang['no_item'])
					return true
				end
			end
		else
			TriggerClientEvent("usa:notify", src, Config.Lang['no_cops'])
			return true
		end
	end
}

RegisterServerEvent('av_warehouse:discord')
AddEventHandler('av_warehouse:discord', function(content)
	if webhook and Config.sendDiscordMessageOnStart then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
	end
end)

RegisterServerEvent('av_warehouse:setIsHacking')
AddEventHandler('av_warehouse:setIsHacking', function(isHacking)
	isDoorBeingHacked = isHacking
end)

RegisterServerEvent('av_warehouse:setGuardsSpawned')
AddEventHandler('av_warehouse:setGuardsSpawned', function(value)
	haveGuardsSpawned = value
end)

RegisterServerEvent('av_warehouse:hint')
AddEventHandler('av_warehouse:hint', function()
	local char = exports["usa-characters"]:GetCharacter(source)
	if char.hasItem("Grappling Hook") and char.hasItem("Sticky Bomb") then
		local msgAuthorColor = {84, 165, 133}
		TriggerClientEvent("chatMessage", source, "INFO", msgAuthorColor, "Oh, nice! You got some stickies and a grappling hook! Perfect! I think if you head down to that white wall of the mansion just behind me there should be a section you can try to get over with the hook.")
		TriggerClientEvent("chatMessage", source, "INFO", msgAuthorColor, "Once inside, there are 2 rooms I know of that hold valuables. One is up some stairs of the tall red building. I think it is the owner's office. You should see a safe inside it. The other is like in the basement area past some metal gates.")
		TriggerClientEvent("chatMessage", source, "INFO", msgAuthorColor, "Be careful, there are guards all over!")
	else
		for _, info in pairs(locations) do
			if x == info.x and y == info.y and z == info.z then
				local msgAuthorColor = {84, 165, 133}
				TriggerClientEvent("chatMessage", source, "INFO", msgAuthorColor, "See that nice mansion down there? It's loaded with cash, weapons, and all sorts of goodies. It's owned by a cartel member from Mexico. I know how we can get in there, too.")
				TriggerClientEvent("chatMessage", source, "INFO", msgAuthorColor, info.hint)
				TriggerClientEvent("chatMessage", source, "INFO", msgAuthorColor, "Once inside, there might be some guards to deal with, but then we should be able to crack open the crates and get out. Just bring a crowbar. I've also marked your map temporarily with about where it is.")
				TriggerClientEvent("chatMessage", source, "INFO", msgAuthorColor, "If you're lucky you'll find a grappling hook and maybe some sticky bombs we can use to get over the mansion walls and into the safes. If not, you'll have to try again another time.")
				TriggerClientEvent("av_warehouse:addHintBlip", source, x + randomHintBlipXOffset, y + randomHintBlipYOffset, z, Config.HintBlipRadius)
			end
		end
	end
end)

RegisterServerCallback {
	eventName = 'av_warehouse:isBeingHacked',
	eventCallback = function(source)
		return isDoorBeingHacked
	end
}

RegisterServerCallback {
	eventName = 'av_warehouse:hasBeenHacked',
	eventCallback = function(source)
		return hacked
	end
}

RegisterServerCallback {
	eventName = 'av_warehouse:loadCrates',
	eventCallback = function(source)		
		return crates
	end
}

RegisterServerCallback {
	eventName = 'av_warehouse:haveGuardsSpawned',
	eventCallback = function(source)
		return haveGuardsSpawned
	end
}

RegisterServerCallback {
	eventName = 'av_warehouse:hasCrowbar',
	eventCallback = function(source)
		local c = exports["usa-characters"]:GetCharacter(source)
		return c.hasItem("Crowbar")
	end
}
