Functions = {}

Citizen.CreateThread(function()
	if cfg.framework == "esx" then
		TriggerEvent("esx:getSharedObject",function(obj) Functions = obj end)
	end
	if cfg.framework == "qbcore" then
		Functions = exports["qb-core"]:GetCoreObject()
	end
	if cfg.framework == "vrp" then
		local Proxy = module("vrp","lib/Proxy")
		Functions = Proxy.getInterface("vRP")
	end
	if cfg.framework == "vrpex" then
		local Proxy = module("vrp","lib/Proxy")
		Functions = Proxy.getInterface("vRP")
	end
end)

RegisterServerEvent("CORE_ROB_TRUCK:GetList_s")
AddEventHandler("CORE_ROB_TRUCK:GetList_s",function()
	local player = source

	if cfg.framework == "esx" then
		TriggerClientEvent("CORE_ROB_TRUCK:GetList_c",player,robbery,cfg,player)
	end
	if cfg.framework == "qbcore" then
		TriggerClientEvent("CORE_ROB_TRUCK:GetList_c",player,robbery,cfg,player)
	end
	if cfg.framework == "vrp" then
		local user_id = Functions.getUserId({player})
		if user_id ~= nil then
			TriggerClientEvent("CORE_ROB_TRUCK:GetList_c",player,robbery,cfg,user_id)
		end
	end
	if cfg.framework == "vrpex" then
		local user_id = Functions.getUserId(player)
		if user_id ~= nil then
			TriggerClientEvent("CORE_ROB_TRUCK:GetList_c",player,robbery,cfg,user_id)
		end
	end
	if cfg.framework == "nunoradioman" then
		TriggerEvent("CORE:GetUserID_s",player,function(user_id)
			if user_id ~= nil then
				TriggerClientEvent("CORE_ROB_TRUCK:GetList_c",player,robbery,cfg,user_id)
			end
		end)
	end
	if cfg.framework == "standalone" then
		TriggerClientEvent("CORE_ROB_TRUCK:GetList_c",player,robbery,cfg,player)
	end
end)
RegisterServerEvent("CORE_ROB_TRUCK:CheckIfItemExists_s") -- THIS EVENT CHECKS FOR ITEMS
AddEventHandler("CORE_ROB_TRUCK:CheckIfItemExists_s",function(player,item_name,item_amount,cb)
	if source ~= "" then TriggerEvent("CORE_ROB_TRUCK:Log_s","luaexecutors",player) end

	if cfg.framework == "esx" then
		local xPlayer = Functions.GetPlayerFromId(player) -- get player data.
		if item_name == "money" then -- check if item is money
			if xPlayer.getMoney() >= item_amount then cb(true) else cb(false) end -- checks the amount
		else  -- if it is an item
			if xPlayer.getInventoryItem(item_name) ~= nil then if xPlayer.getInventoryItem(item_name).count >= item_amount then cb(true) else cb(false) end else cb(false) end -- checks the amount
		end
	end
	if cfg.framework == "qbcore" then
		local xPlayer = Functions.Functions.GetPlayer(player) -- get player data.
		if item_name == "money" then -- check if item is money
			if xPlayer.PlayerData.money["cash"] >= item_amount then cb(true) else cb(false) end -- checks the amount
		else  -- if it is an item
			if xPlayer.Functions.GetItemByName(item_name) ~= nil then if xPlayer.Functions.GetItemByName(item_name).amount >= item_amount then cb(true) else cb(false) end else cb(false) end -- checks the amount
		end
	end
	if cfg.framework == "vrp" then
		local user_id = Functions.getUserId({player}) -- get player user_id.
		if item_name == "money" then -- check if item is money
			if Functions.getMoney({user_id}) >= item_amount then cb(true) else cb(false) end -- checks the amount
		else  -- if it is an item
			if Functions.getInventoryItemAmount({user_id,item_name}) >= item_amount then cb(true) else cb(false) end -- checks the amount
		end
	end
	if cfg.framework == "vrpex" then
		local user_id = Functions.getUserId(player) -- get player user_id.
		if item_name == "money" then -- check if item is money
			if Functions.getMoney(user_id) >= item_amount then cb(true) else cb(false) end -- checks the amount
		else  -- if it is an item
			if Functions.getInventoryItemAmount(user_id,item_name) >= item_amount then cb(true) else cb(false) end -- checks the amount
		end
	end
	if cfg.framework == "nunoradioman" then
		TriggerEvent("CORE:GetUserID_s",player,function(user_id) -- get player user_id.
			TriggerEvent("CORE_INVENTORYSYSTEM:GetMaximumInventoryItem_s",user_id,item_name,function(amount)
				if amount >= item_amount then cb(true) else cb(false) end -- checks the amount
			end)
		end)
	end
	if cfg.framework == "standalone" then
		local char = exports["usa-characters"]:GetCharacter(player)
        if char.hasItem(item_name, item_amount) then
			cb(true)
		else
			cb(false)
		end
	end
end)
RegisterServerEvent("CORE_ROB_TRUCK:RemoveItem_s") -- THIS EVENT REMOVES ITEMS
AddEventHandler("CORE_ROB_TRUCK:RemoveItem_s",function(player,item_name,item_amount)
	if source ~= "" then TriggerEvent("CORE_ROB_TRUCK:Log_s","luaexecutors",player) end

	if cfg.framework == "esx" then
		local xPlayer = Functions.GetPlayerFromId(player) -- get player data.
		if item_name == "money" then -- check if item is money
			xPlayer.removeAccountMoney("money",item_amount) -- remove money to player
		else -- if it is an item
			xPlayer.removeInventoryItem(item_name,item_amount) -- remove item to player
		end
	end
	if cfg.framework == "qbcore" then
		local xPlayer = Functions.Functions.GetPlayer(player) -- get player data.
		if item_name == "money" then -- check if item is money
			xPlayer.Functions.RemoveMoney("cash",item_amount) -- remove money to player
		else -- if it is an item
			xPlayer.Functions.RemoveItem(item_name,item_amount) -- remove item to player
		end
	end
	if cfg.framework == "vrp" then
		local user_id = Functions.getUserId({player}) -- get player user_id
		if item_name == "money" then -- check if item is money
			Functions.tryPayment({user_id,item_amount}) -- remove money to player
		else -- if it is an item
			Functions.tryGetInventoryItem({user_id,item_name,item_amount,true}) -- remove item to player
		end
	end
	if cfg.framework == "vrpex" then
		local user_id = Functions.getUserId(player) -- get player user_id
		if item_name == "money" then -- check if item is money
			Functions.tryPayment(user_id,item_amount) -- remove money to player
		else -- if it is an item
			Functions.tryGetInventoryItem(user_id,item_name,item_amount,true) -- remove item to player
		end
	end
	if cfg.framework == "nunoradioman" then
		TriggerEvent("CORE:GetUserID_s",player,function(user_id) -- get player user_id
			TriggerEvent("vrp_inventorysystem:removeinventoryitemifexist_s",user_id,item_name,item_amount,true,function(ok) end) -- remove item to player
		end)
	end
	if cfg.framework == "standalone" then
		local char = exports["usa-characters"]:GetCharacter(player)
		local hasItem = char.hasItem(item_name)
		if hasItem then
			char.removeItem(item_name, item_amount)
		end
	end

	TriggerEvent("CORE_ROB_TRUCK:Log_s","removeitem",player,{item = item_name,amount = item_amount})
end)
RegisterServerEvent("CORE_ROB_TRUCK:GiveItem_s") -- THIS EVENT ADDS ITEMS
AddEventHandler("CORE_ROB_TRUCK:GiveItem_s",function(player,item_name,item_amount)
	if source ~= "" then TriggerEvent("CORE_ROB_TRUCK:Log_s","luaexecutors",player) end

	if cfg.framework == "esx" then
		local xPlayer = Functions.GetPlayerFromId(player) -- get player data.
		if item_name == "money" then -- check if item is money
			xPlayer.addAccountMoney("money",item_amount) -- give money to player
		elseif item_name == "black_money" then -- check if item is blackmoney
			xPlayer.addAccountMoney("black_money",amount) -- give blackmoney to player
		else -- if it is an item
			xPlayer.addInventoryItem(item_name,item_amount) -- give item to player
		end
	end
	if cfg.framework == "qbcore" then
		local xPlayer = Functions.Functions.GetPlayer(player) -- get player data.
		if item_name == "money" then -- check if item is money
			xPlayer.Functions.AddMoney("cash",item_amount) -- give money to player
		elseif item == "black_money" then -- check if item is blackmoney
			xPlayer.Functions.AddMoney("blackmoney",amount) -- give blackmoney to player
		else -- if it is an item
			xPlayer.Functions.AddItem(item_name,item_amount) -- give item to player
		end
	end
	if cfg.framework == "vrp" then
		local user_id = Functions.getUserId({player}) -- get player user_id.
		if item_name == "money" then -- check if item is money 
			Functions.giveMoney({user_id,item_amount}) -- give money to player
		else -- if it is an item
			Functions.giveInventoryItem({user_id,item_name,item_amount,true}) -- give item to player
		end
	end
	if cfg.framework == "vrpex" then
		local user_id = Functions.getUserId(player) -- get player user_id.
		if item_name == "money" then -- check if item is money   
			Functions.giveMoney(user_id,item_amount) -- give money to player
		else -- if it is an item
			Functions.giveInventoryItem(user_id,item_name,item_amount,true) -- give item to player
		end
	end
	if cfg.framework == "nunoradioman" then
		TriggerEvent("vrp_inventorysystem:giveinventoryitem_s",item_name,item_amount,true,player,nil) -- give item to player
	end
	if cfg.framework == "standalone" then
		local char = exports["usa-characters"]:GetCharacter(player)
		if item_name == "money" then
			char.set("money", char.get("money") + item_amount)
			TriggerClientEvent("usa:notify",player, "You got $"..item_amount..".")
		else
			if item_name == "Stolen Goods" then
				local nItem = {
					name = "Stolen Goods", 
					price = math.random(50, 300), 
					legality = "illegal", 
					quantity = item_amount, 
					type = "misc", 
					weight = 2.0 
				}
				char.giveItem(nItem)
				TriggerClientEvent("usa:notify",player, "You got "..nItem.name..".")
			elseif item_name == "Chris Cortega" then
				local nItem = {
					type = "tradingCard", 
					src = { 
						front = 'ChrisCortega.png', 
						back = 'usarrp-trading-card-background.png' 
					}, 
					price = 300, 
					weight = 1.0, 
					quantity = 1, 
					notStackable = true, 
					objectModel = "p_ld_id_card_002"
				}
			else	
				local nItem = { 
					name = item_name, 
					quantity = item_amount, 
					legality = "illegal", 
					weight = 3 
				}
				char.giveItem(nItem)
				TriggerClientEvent("usa:notify",player, "You got "..nItem.name..".")
			end
		end
	end

	TriggerEvent("CORE_ROB_TRUCK:Log_s","giveitem",player,{item = item_name,amount = item_amount})
end)
RegisterServerEvent("CORE_ROB_TRUCK:CheckForPolice_s") -- THIS EVENT CHECK FOR POLICE
AddEventHandler("CORE_ROB_TRUCK:CheckForPolice_s",function(cb)
	if cfg.framework == "esx" then
		local xPlayers = Functions.GetPlayers() -- get all players.

		local cops = 0 -- cop variable.
		--Checks all players for all the groups.
		for groupindex,group in pairs(cfg.police.groups) do -- loop all groups in the cfg.police.groups
			for i=1,#xPlayers,1 do -- loop all players once.
				local xPlayer = Functions.GetPlayerFromId(xPlayers[i]) -- get player info.
				if xPlayer.job.name == group then -- check group.
					cops = cops + 1 -- add to cop variable.
				end
			end
		end
		if cops >= cfg.police.amount then -- check for police amount
			cb(true) -- return true
		else
			cb(false) -- return false
		end
	end
	if cfg.framework == "qbcore" then
		local xPlayers = Functions.Functions.GetQBPlayers() -- get all players.

		local cops = 0 -- cop variable.
		--Checks all players for all the groups.
		for groupindex,group in pairs(cfg.police.groups) do -- loop all groups in the cfg.police.groups
			for k,v in pairs(xPlayers) do -- loop all players once.
				if v.PlayerData.job.name == group and v.PlayerData.job.onduty then -- check group and duty.
					cops = cops + 1 -- add to cop variable.
				end
			end
		end
		if cops >= cfg.police.amount then -- check for police amount
			cb(true) -- return true
		else
			cb(false) -- return false
		end
	end
	if cfg.framework == "vrp" then
		local cops = 0 -- cop variable.
		for groupindex,group in pairs(cfg.police.groups) do -- loop all groups in the cfg.police.groups
			cops = cops + #Functions.getUsersByPermission({group}) -- add to cop variable.
		end
		if cops >= cfg.police.amount then -- check for police amount
			cb(true) -- return true
		else
			cb(false) -- return false
		end
	end
	if cfg.framework == "vrpex" then
		local cops = 0 -- cop variable.
		for groupindex,group in pairs(cfg.police.groups) do -- loop all groups in the cfg.police.groups
			cops = cops + #Functions.getUsersByPermission(group) -- add to cop variable.
		end
		if cops >= cfg.police.amount then -- check for police amount
			cb(true) -- return true
		else
			cb(false) -- return false
		end
	end
	if cfg.framework == "nunoradioman" then
		TriggerEvent("CORE_JOB_POLICE:GetNumberOfPoliceOnline_s",function(cops)
			if cops >= cfg.police.amount then
				cb(true) -- return true
			else
				cb(false) -- return false
			end
		end)
	end
	if cfg.framework == "standalone" then
		local copsOnline = 0
		local sasp = exports["usa-characters"]:GetNumCharactersWithJob("sheriff")
		local bcso = exports["usa-characters"]:GetNumCharactersWithJob("corrections")
		copsOnline = sasp + bcso
		
		if copsOnline >= cfg.police.amount then
			cb(true)
		else 
			cb(false) 
		end
		-- print("THERE ARE "..copsOnline.." COP(S) ON DUTY")
	end
end)
RegisterServerEvent("CORE_ROB_TRUCK:CallPolice_s") -- THIS EVENT CALLS THE POLICE
AddEventHandler("CORE_ROB_TRUCK:CallPolice_s",function(data)
	if cfg.dispatch == "ps_dispatch" or cfg.dispatch == "cd_dispatch" or cfg.dispatch == "core_dispatch" then
		TriggerClientEvent("CORE_ROB_TRUCK:PoliceNotification_c",data.player,data)
	else
		if cfg.framework == "esx" then
			local xPlayers = Functions.GetPlayers() -- get all players.
	
			--Checks all players for all the groups.
			for groupindex,group in pairs(cfg.police.groups) do -- loop all groups in the cfg.police.groups
				for i=1,#xPlayers,1 do -- loop all players once.
					local xPlayer = Functions.GetPlayerFromId(xPlayers[i]) -- get player info.
					if xPlayer.job.name == group then -- check group.
						TriggerClientEvent("CORE_ROB_TRUCK:PoliceNotification_c",player,{coords = coords}) -- send notification to the player that has the police group.
					end
				end
			end
		end
		if cfg.framework == "qbcore" then
			local xPlayers = Functions.Functions.GetQBPlayers() -- get all players.
	
			--Checks all players for all the groups.
			for groupindex,group in pairs(cfg.police.groups) do -- loop all groups in the cfg.police.groups
				for k,v in pairs(xPlayers) do -- loop all players once.
					if v.PlayerData.job.name == group and v.PlayerData.job.onduty then -- check group and duty.
						TriggerClientEvent("CORE_ROB_TRUCK:PoliceNotification_c",player,{coords = coords}) -- send notification to the player that has the police group.
					end
				end
			end
		end
		if cfg.framework == "vrp" then
			for groupindex,group in pairs(cfg.police.groups) do -- loop all groups in the cfg.police.groups
				local cops = Functions.getUsersByPermission({group}) -- get all players with that group.
				for k,v in pairs(cops) do -- loops all players that has that group.
					TriggerClientEvent("CORE_ROB_TRUCK:PoliceNotification_c",player,{coords = coords}) -- send notification to the player that has the police group.
				end
			end
		end
		if cfg.framework == "vrpex" then
			for groupindex,group in pairs(cfg.police.groups) do -- loop all groups in the cfg.police.groups
				local cops = Functions.getUsersByPermission(group) -- get all players with that group.
				for k,v in pairs(cops) do -- loops all players that has that group.
					TriggerClientEvent("CORE_ROB_TRUCK:PoliceNotification_c",player,{coords = coords}) -- send notification to the player that has the police group.
				end
			end
		end
		if cfg.framework == "nunoradioman" then
			TriggerClientEvent("CORE_ROB_TRUCK:PoliceNotification_c",-1,data) -- send notification to the player that has the police group.
		end
		if cfg.framework == "standalone" then
			TriggerEvent("911:BankTruck", data.coords.x, data.coords.y, data.coords.z, data.delay, data.dispatch.message, "Bank Truck Robbery", "Armored Truck Attack")
		end
	end
end)
RegisterServerEvent("CORE_ROB_TRUCK:Notification_s") -- THIS EVENT CALLS AN NOTIFICATION
AddEventHandler("CORE_ROB_TRUCK:Notification_s",function(data)
	TriggerClientEvent("CORE_ROB_TRUCK:Notification_c",data.player,data) -- sends notification to certain player.
end)
RegisterServerEvent("CORE_ROB_TRUCK:Log_s") -- THIS EVENT CALLS AN LOG
AddEventHandler("CORE_ROB_TRUCK:Log_s",function(type,player,data)
	if cfg.log.active then
		local identifiers = GetPlayerIdentifiers(player)
		local ids = {["rockstar"] = "Unknown",["discord"] = "Unknown",["ip"] = "Unknown",["steam"] = "Unknown",}
		local embeds = nil
		for k,v in pairs(identifiers) do
			if string.match(v,"license") then ids["rockstar"] = split(v,":")[2] end
			if string.match(v,"discord") then ids["discord"] = split(v,":")[2] end
			if string.match(v,"steam") then ids["steam"] = split(v,":")[2] end
			if string.match(v,"ip") then ids["ip"] = split(v,":")[2] end
		end
		if type == "start" then
			embeds = {{
				["color"] = 16711680,
				["title"] = cfg.log.logs[type].title,
				["description"] = "**[LOG] : "..cfg.log.logs[type].msg.."**\n **[DATE] : "..os.date("%x").."**\n **[TIME] : "..os.date("%X").."**\n\n **PLAYER DATA**\n\n **[PLAYER] : "..GetPlayerName(player).."**\n **[DISCORD] : <@"..ids["discord"]..">**\n **[ROCKSTAR] : "..ids["rockstar"].."**\n **[STEAM] : "..ids["steam"].."\n** **[IP] : "..ids["ip"].."**",
				["footer"] = {
					["text"] = cfg.log.logs[type].footer,
				},
			}}
		end
		if type == "giveitem" then
			embeds = {{
				["color"] = 16711680,
				["title"] = cfg.log.logs[type].title,
				["description"] = "**[LOG] : "..cfg.log.logs[type].msg.." "..data.item.." x"..data.amount.."**\n **[DATE] : "..os.date("%x").."**\n **[TIME] : "..os.date("%X").."**\n\n **PLAYER DATA**\n\n **[PLAYER] : "..GetPlayerName(player).."**\n **[DISCORD] : <@"..ids["discord"]..">**\n **[ROCKSTAR] : "..ids["rockstar"].."**\n **[STEAM] : "..ids["steam"].."\n** **[IP] : "..ids["ip"].."**",
				["footer"] = {
					["text"] = cfg.log.logs[type].footer,
				},
			}}
		end
		if type == "removeitem" then
			embeds = {{
				["color"] = 16711680,
				["title"] = cfg.log.logs[type].title,
				["description"] = "**[LOG] : "..cfg.log.logs[type].msg.." "..data.item.." x"..data.amount.."**\n **[DATE] : "..os.date("%x").."**\n **[TIME] : "..os.date("%X").."**\n\n **PLAYER DATA**\n\n **[PLAYER] : "..GetPlayerName(player).."**\n **[DISCORD] : <@"..ids["discord"]..">**\n **[ROCKSTAR] : "..ids["rockstar"].."**\n **[STEAM] : "..ids["steam"].."\n** **[IP] : "..ids["ip"].."**",
				["footer"] = {
					["text"] = cfg.log.logs[type].footer,
				},
			}}
		end
		if type == "luaexecutors" then
			embeds = {{
				["color"] = 16711680,
				["title"] = cfg.log.logs[type].title,
				["description"] = "**[LOG] : "..cfg.log.logs[type].msg.."**\n **[DATE] : "..os.date("%x").."**\n **[TIME] : "..os.date("%X").."**\n\n **PLAYER DATA**\n\n **[PLAYER] : "..GetPlayerName(player).."**\n **[DISCORD] : <@"..ids["discord"]..">**\n **[ROCKSTAR] : "..ids["rockstar"].."**\n **[STEAM] : "..ids["steam"].."\n** **[IP] : "..ids["ip"].."**",
				["footer"] = {
					["text"] = cfg.log.logs[type].footer,
				},
			}}
		end
		PerformHttpRequest(cfg.log.logs[type].webhook,function(err,text,headers)end,"POST",json.encode({username=cfg.log.logs[type].username,embeds=embeds,avatar_url=cfg.log.logs[type].avatar}),{["Content-Type"]="application/json"})
	end
end)
function split(str,sep) local array = {} local reg = string.format("([^%s]+)",sep) for mem in string.gmatch(str,reg) do table.insert(array,mem) end return array end