local deathLog = {}

local RESPAWN_FEE = 1000

local MAX_DEATH_LOG_COUNT = 15

RegisterServerEvent("death:respawn")
AddEventHandler("death:respawn", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get("job")
	if job ~= "sheriff" and job ~= "corrections" and job ~= "ems" then
		local m = char.get("money")
		if m >= RESPAWN_FEE then
			char.removeMoney(RESPAWN_FEE)
		end
	end

	-- other stuff --
	TriggerClientEvent("crim:untieHands", source, source)
	TriggerClientEvent("crim:blindfold", source, false, true)
	TriggerEvent("usa_rp:checkJailedStatusOnPlayerJoin", source)
	TriggerClientEvent("evidence:updateData", source, "levelBAC", 0.0)
	TriggerEvent("chat:sendToLogFile", source, "Player respawned at Timestamp: ".. os.date('%m-%d-%Y %H:%M:%S', os.time()))

	-- Remove Illegals --
	local permitStatus = exports["usa_gunshop"]:checkPermit(char)
	if job == "police" or job == "sheriff" or job == "corrections" or job == "ems" or job == "doctor" then return end
	if exports.globals:hasFelonyOnRecord(source) or permitStatus == 'suspended' or permitStatus == 'none' then
		char.removeWeapons()
		TriggerClientEvent("usa:notify", source, "Your illegal weapons have been taken.")
	end
	char.removeIllegalItems()
	TriggerClientEvent("usa:notify", source, "Your illegal items have been taken.")
end)

RegisterServerEvent('death:revivePerson')
AddEventHandler('death:revivePerson', function(targetSource)
	local user = exports["essentialmode"]:getPlayerFromId(source)
	local job = exports["usa-characters"]:GetCharacterField(source, "job")
	if job == "cop" or
	job == "corrections" or
	job == "sheriff" or
	job == "highwaypatrol" or
	job == "ems" or
	job == "doctor" or
	job == "fire" or
	user.getGroup() == "mod" or
	user.getGroup() == "admin" or
	user.getGroup() == "superadmin" or
	user.getGroup() == "owner" then
		TriggerClientEvent('death:allowRevive', targetSource)
	end
end)

TriggerEvent('es:addCommand', 'revive', function(source, args, char)
	local user = exports["essentialmode"]:getPlayerFromId(source)
	local job = char.get("job")
	if job == "cop" or
		job == "corrections" or
		job == "sheriff" or
		job == "highwaypatrol" or
		job == "ems" or
		job == "doctor" or
		user.getGroup() == "mod" or
		user.getGroup() == "admin" or
		user.getGroup() == "superadmin" or
		user.getGroup() == "owner" then
		if args[2] == nil then
			TriggerClientEvent("death:reviveNearest", source)
		else
			TriggerClientEvent("death:allowRevive", tonumber(args[2]))
		end
	else
		TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "You don't have permissions to use this command.")
	end
end, {
	help = "Revive a player (EMS/Staff)",
	params = {
		{ name = "id", help = "Player's ID (omit to revive nearest ped)" }
	}
})

function splitString(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

function serializeTable(val, name, skipnewlines, depth)
	skipnewlines = skipnewlines or false
	depth = depth or 0

	local tmp = string.rep(" ", depth)

	if name then tmp = tmp .. name .. " = " end

	if type(val) == "table" then
		tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

		for k, v in pairs(val) do
			tmp =  tmp .. serializeTable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
		end

		tmp = tmp .. string.rep(" ", depth) .. "}"
	elseif type(val) == "number" then
		tmp = tmp .. tostring(val)
	elseif type(val) == "string" then
		tmp = tmp .. string.format("%q", val)
	elseif type(val) == "boolean" then
		tmp = tmp .. (val and "true" or "false")
	else
		tmp = tmp .. "\"[inserializeable datatype:" .. type(val) .. "]\""
	end

	return tmp
end

-- Rcon commands
AddEventHandler('rconCommand', function(commandName, args)
	if commandName == "revive" then
		local targetId = args[1]
		if not targetId then RconPrint("Error: no target id"); CancelEvent() return end
		TriggerClientEvent("RPD:revivePerson", targetId)
		CancelEvent()
	elseif commandName == "log" then
		for i = 1, #deathLog do
			RconPrint("\nDEATH #" .. i)
			RconPrint("\nDied: " .. deathLog[i].deadPlayerName)
			RconPrint("\nKiller: " .. deathLog[i].killerName .. " (#" .. deathLog[i].killerId .. ")")
			RconPrint("\nCause: " .. deathLog[i].cause)
			RconPrint("\nTime: " .. deathLog[i].timestamp)
		end
		CancelEvent()
	end
end)

TriggerEvent('es:addGroupCommand', 'log', "mod", function(source, args, user)
	for i = 1, #deathLog do
		TriggerClientEvent("chatMessage", source, "", {0,0,0}, "^3DEATH #" .. i)
		if deathLog[i].deadPlayerId ~= 0 then
			local char = exports["usa-characters"]:GetCharacter(deathLog[i].deadPlayerId)
			if char then
				local name = char.getFullName()
				TriggerClientEvent("chatMessage", source, "", {0,0,0}, "^0Died: " .. name .. " (#" .. deathLog[i].deadPlayerId .. " / " .. deathLog[i].deadPlayerName .. ")")
			else
				TriggerClientEvent("chatMessage", source, "", {0,0,0}, "^0Died: " .. "<Left Server?>" .. " (#" .. deathLog[i].deadPlayerId .. " / " .. deathLog[i].deadPlayerName .. ")")
			end
		else
			TriggerClientEvent("chatMessage", source, "", {0,0,0}, "^0Died: Unknown")
		end
		if deathLog[i].killerId ~= 0 then
			local char = exports["usa-characters"]:GetCharacter(deathLog[i].killerId)
			if char then
				local name = char.getFullName()
				TriggerClientEvent("chatMessage", source, "", {0,0,0}, "^0Killer: " .. name .. " (#" .. deathLog[i].killerId .. " / " .. deathLog[i].killerName .. ")")
			else
				TriggerClientEvent("chatMessage", source, "", {0,0,0}, "^0Killer: " .. "<Left Server?>" .. " (#" .. deathLog[i].killerId .. " / " .. deathLog[i].killerName .. ")")
			end
		else
			TriggerClientEvent("chatMessage", source, "", {0,0,0}, "^0Killer: Unknown")
		end
		TriggerClientEvent("chatMessage", source, "", {0,0,0}, "^0Time: " .. deathLog[i].timestamp)
	end
end, {
	help = "View death log"
})

RegisterServerEvent("death:newDeathLog")
AddEventHandler("death:newDeathLog", function(log)
	log.timestamp = os.date('%m-%d-%Y %H:%M:%S', os.time())
	if #deathLog >= MAX_DEATH_LOG_COUNT then
		--deathLog = {}
		table.remove(deathLog, 1)
	end
	table.insert(deathLog, log)
	print("Player " .. log.killerName .. " (#" .. log.killerId .. ") just killed player " .. log.deadPlayerName .. "(#" .. log.deadPlayerId .. ").")
	TriggerEvent("chat:sendToLogFile", source, "has died. " .. log.killerName .. " (#" .. log.killerId .. ") just killed player " .. log.deadPlayerName .. "(#" .. log.deadPlayerId .. "), cause [" .. log.cause .. "]. Timestamp: " .. os.date('%m-%d-%Y %H:%M:%S', os.time()))
end)

-- END DEATH LOG

TriggerEvent('es:addCommand', 'whodownedme', function(src, args, char)
	local lastKillerID = TriggerClientCallback {
		source = src,
		eventName = "death:getKillerID",
		args = {}
	}
	if lastKillerID ~= nil then
		TriggerClientEvent("usa:notify", src, "Last killer: " .. GetPlayerIdentifiers(lastKillerID)[1], "Last killer: " .. GetPlayerIdentifiers(lastKillerID)[1])
	else
		TriggerClientEvent("usa:notify", src, "Unknown!")
	end
end, {
	help = "Display the Steam ID of the person who downed you to include in player report"
})