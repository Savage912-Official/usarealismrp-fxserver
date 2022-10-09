TotalFires = 0

CurrentFireID = 0
AllFires = {}

local CurrentWebhook = nil

--[[Essential Events]]--
if Config.Discord.UseWebHooks then
	TriggerEvent("dw:registerWebhook", Config.Discord.WEB_HOOK, Config.Discord.BOT_NAME, Config.Discord.WEB_IMAGE, function(hook)
		print("^1FireScript: ^7Discord Webhooks Connected!")
		hook.SendMessageAsync(Config.Discord.BOT_NAME, "**FireScript Logger Has Started!**")
		CurrentWebhook = hook
	end)
end


RegisterServerEvent("FireScript:FirePutOut")
AddEventHandler("FireScript:FirePutOut", function(id)
	StopFire(id)
end)

RegisterServerEvent("FireScript:StartFire")
AddEventHandler("FireScript:StartFire", function(id, x, y, z, street, road)
	if not AllFires[id]["position"] then
		AllFires[id]["position"] = vector3(x, y, z)
		AllFires[id]["street"] = street
		AllFires[id]["road"] = road
		TriggerEvent("FireScript:FireStarted", id)

		local toSend = {
			["position"] = {
				x = x, y = y, z = z
			},
			["flames"] = AllFires[id].flames,
			["spread"] = AllFires[id].spread,
			["info"] = AllFires[id].info
		}
		TriggerClientEvent('FireScript:SyncFire', -1, id, toSend)

	end
end)

RegisterServerEvent("FireScript:RequestFire")
AddEventHandler("FireScript:RequestFire", function()
	for id, data in ipairs(AllFires) do
		if data.position then
			local toSend = {
				["position"] = {
					x = data.position.x, y = data.position.y, z = data.position.z
				},
				["flames"] = data.flames,
				["spread"] = data.spread,
				["info"] = data.info
			}
			TriggerClientEvent('FireScript:SyncFire', source, id, toSend)
			TriggerClientEvent("FireScript:FireStarted", source, id, AllFires[id]["position"], false)
		end
	end
end)

RegisterServerEvent("FireScript:StopFire")
AddEventHandler("FireScript:StopFire", function(id)
	StopFire(id)
end)

--[[Commands]]--
TriggerEvent('es:addGroupCommand', 'startfire', "admin", function(source, args, char)
	if TotalFires < Config.MaxFires then
		if tonumber(args[2]) and tonumber(args[3]) and tostring(args[4]) then
			if not Config.FireTypes[args[4]] then
				TriggerClientEvent('chat:addMessage', source, {
					args = {"^1SYSTEM", "Invalid Fire Type!"}
				})
				return
			end
			local flames = tonumber(args[2])
			local spread = tonumber(args[3])

			if flames > Config.MaxFlames then flames = Config.MaxFlames end
			if flames < 1 then flames = 1 end

			if spread > Config.MaxSpread then spread = Config.MaxSpread end
			if spread < 1 then spread = 1 end

			TotalFires = TotalFires + 1

			--This is used to generate a new id for each fire
			CurrentFireID = CurrentFireID + 1

			local data = {
				["id"] = CurrentFireID,
				["creator"] = GetPlayerName(source),
				["flames"] = flames,
				["spread"] = spread,
				["info"] = Config.FireTypes[args[4]]
			}
			StartFire(source, data)
			TriggerClientEvent('chat:addMessage', source, {
				args = {"^1SYSTEM", "Started Fire [" .. CurrentFireID .. "] " .. TotalFires .. "/" .. Config.MaxFires .. " At Your Position"}
			})
		else
			TriggerClientEvent('chat:addMessage', source, {
				args = {"^1SYSTEM", "Invalid Usage: /startfire [Flames] [Spread] [Type]"}
			})
		end
	else
		TriggerClientEvent('chat:addMessage', source, {
			args = {"^1SYSTEM", "Can't Create More Fires! The Limit Of " .. Config.MaxFires .. " Is Reached!"}
		})
	end
end, {
	help = "Create a fire",
	params = {
		{ name = "Flames", help = "How many flames to spawn" },
		{ name = "Spread", help = "Radius flames spawn in" },
		{ name = "Type", help = "Type of fire (normal, normal2, chemical, electrical, bonfire)" }
	}
})

TriggerEvent('es:addGroupCommand', 'stopfire', "admin", function(source, args, char)
	if args[2] and tonumber(args[2]) then
		local id = tonumber(args[2])
		StopFire(id)--Stop A current fire id
		TriggerClientEvent('chat:addMessage', source, {
			args = {"^1SYSTEM", "Stoping Fire ID " .. id}
		})
	else
		TriggerClientEvent('FireScript:StopFire', source, id)--Request The Player To Stop The Fire At Current Position
		TriggerClientEvent('chat:addMessage', source, {
			args = {"^1SYSTEM", "Stoping Fire At Your Position"}
		})
	end
end, {
	help = "Stop a fire",
	params = {
		{ name = "id", help = "ID of fire, can be found using /getfires" },
	}
})

TriggerEvent('es:addGroupCommand', 'stopallfires', "admin", function(source, args, char)
	TriggerClientEvent('FireScript:StopFire', -1, -1)--Stop All Fires
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Stoped All Fires!"}
	})
	TriggerEvent("FireScript:FireEnded", false, source)
	CurrentFireID = 0
	TotalFires = 0
end, {
	help = "Stops all Fires",
	params = {}
})

TriggerEvent('es:addGroupCommand', 'getfires', "admin", function(source, args, char)
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Total Fires: " .. TotalFires .. " Lastest Fire ID: " .. CurrentFireID}
	})
end, {
	help = "Gets a list of fires and shows latest fire ID",
	params = {}
})

TriggerEvent('es:addGroupCommand', 'enablerandomfires', "admin", function(source, args, char)
	if args[2] then
		local enable = args[2]
		if enable == "true" or enable == "t" or enable == "1" then
			TriggerClientEvent('chat:addMessage', source, {
				args = {"^1SYSTEM", "Random Fires Enabled!"}
			})
			TriggerEvent("FireScript:EnableRandomFires", true)
			if CurrentWebhook then
				CurrentWebhook.SendEmbedAsync(Config.Discord.BOT_NAME, "Random Fires Enabled", "By " .. GetPlayerName(source), "1752220")
			end
		else
			TriggerClientEvent('chat:addMessage', source, {
				args = {"^1SYSTEM", "Random Fires Disabled!"}
			})
			TriggerEvent("FireScript:EnableRandomFires", false)
			if CurrentWebhook then
				CurrentWebhook.SendEmbedAsync(Config.Discord.BOT_NAME, "Random Fires Disabled", "By " .. GetPlayerName(source), "10038562")
			end
		end
	else
		TriggerClientEvent('chat:addMessage', source, {
			args = {"^1SYSTEM", "Invalid Usage: /enablerandomfires [Enable]"}
		})
	end
end, {
	help = "Enables or Disables Random Fires",
	params = {
		{ name = "enabled", help = "Whether random fires are enabled (true/false)" }
	}
})

--[[Functions]]--
function StartFire(source, data)
	local toSend = {
		["id"] = data.id
	}
	TriggerClientEvent('FireScript:StartFire', source, data)
	AllFires[data.id] = data
end

function StopFire(id)
	if AllFires[id] then
		TriggerClientEvent('FireScript:StopFire', -1, id)
		TriggerEvent("FireScript:FireEnded", id)
		TotalFires = TotalFires - 1
		if TotalFires < 0 then
			TotalFires = 0
		end
	end
end

function IsJobWhitelisted(source)
	if(not Config.UseFireJobWhitelist) then 
		return true
	end
    for _, id in ipairs(GetPlayerIdentifiers(source)) do
        if listcontains(Config.FireJobIdentifiers, id) then
            return true
        end
    end
    return false
end

function IsWhitelisted(source)
	local source = source
	local group = exports["essentialmode"]:getPlayerFromId(source).getGroup()

	if group == "owner" or group == "superadmin" or group == "admin" or group == "mod" then
		return true
	else
		return false
	end
end

function listcontains(list, var)
	for i = 1, #list do
        if list[i] == var then
            return true
        end
    end
	return false
end


--[[Important Events]]--
AddEventHandler('FireScript:FireStarted', function(id)
	if AllFires[id].creator then
		if CurrentWebhook then
			CurrentWebhook.SendEmbedAsync(Config.Discord.BOT_NAME, "Fire Started" .. " [" .. id .. "]", "Creator: " .. AllFires[id].creator .. "\nLocation: " .. AllFires[id]["street"] .. " | " .. AllFires[id]["road"], "10038562")
		end
	else--Random Fire
		if CurrentWebhook then
			CurrentWebhook.SendEmbedAsync(Config.Discord.BOT_NAME, "Random Fire Started [" .. id .. "]", "Location: " .. AllFires[id]["location"], "10038562")
		end
	end
	local road_street = ""
	if AllFires[id]["road"] ~= "" then
		road_street = AllFires[id]["street"] .. " | " .. AllFires[id]["road"]
	else
		road_street = AllFires[id]["street"]
	end
    TriggerEvent("911:UncontrolledFire", AllFires[id]["position"].x, AllFires[id]["position"].y, AllFires[id]["position"].z, road_street)
	TriggerClientEvent("FireScript:FireStarted", -1, id, AllFires[id]["position"], true)
end)

AddEventHandler('FireScript:FireEnded', function(data, id)
	if not data then
		if CurrentWebhook then
			CurrentWebhook.SendEmbedAsync(Config.Discord.BOT_NAME, "All Fire Stopped", "By " .. GetPlayerName(id), "1752220")
		end
		AllFires = {}
		TriggerClientEvent("FireScript:FireStopped", -1)
	else
		if AllFires[data].creator then
			if CurrentWebhook then
				CurrentWebhook.SendEmbedAsync(Config.Discord.BOT_NAME, "Fire Stopped [" .. data .. "]", "Creator: " .. AllFires[data].creator .. "\n" .. "Location: " .. AllFires[data]["street"] .. " | " .. AllFires[data]["road"] .. "\nRemaining Fires " .. (TotalFires - 1), "1752220")
			end
		else--Random Fire
			if CurrentWebhook then
				CurrentWebhook.SendEmbedAsync(Config.Discord.BOT_NAME, "Random Fire Stopped [" .. data .. "]", "Location: " .. AllFires[data]["location"], "1752220")
			end
		end
		TriggerClientEvent("FireScript:FireStopped", -1, data, AllFires[data].position)
		AllFires[data] = nil
	end
end)


print("FIRESCRIPT ^1Has Authenticated ^2Successfully! ^0By ^1ToxicScripts! ^7")