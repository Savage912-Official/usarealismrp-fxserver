local maxTicketAmount = 150000

local POLICE_RANKS = {
	["SASP"] = {
		[1] = "Cadet",
		[2] = "Trooper",
		[3] = "Senior Trooper",
		[4] = "Lead Senior Trooper",
		[5] = "Corporal",
		[6] = "Sergeant",
		[7] = "Staff Sergeant",
		[8] = "Lieutenant",
		[9] = "Captain",
		[10] = "Assistant Commissioner",
		[11] = "Deputy Commissioner",
		[12] = "Commissioner",
		[13] = "Director of Emergency Services"
	},
	["BCSO"] = {
		[1] = "Correctional Deputy",
		[2] = "Senior Correctional Deputy",
		[3] = "Probational Deputy",
		[4] = "Sheriff's Deputy",
		[5] = "Senior Sheriff's Deputy",
		[6] = "Corporal",
		[7] = "Sergeant",
		[8] = "Captain",
		[9] = "Commander",
		[10] = "Undersheriff",
		[11] = "Sheriff"
	},
	["EMS"] = {
		[1] = "Probationary Fire Paramedic",
		[2] = "Fire Paramedic",
		[3] = "Sr. Fire Paramedic",
		[4] = "Engineer",
		[5] = "Lieutenant",
		[6] = "Captain",
		[7] = "Battalion Chief",
		[8] = "Assistant Fire Chief",
		[9] = "Fire Chief"
	},
	["Doctor"] = {
		[1] = "Intern Nurse/Doctor",
		[2] = "Registered Nurse/Resident Doctor",
		[3] = "Attending Doctor/Psychiatrist",
		[4] = "Pillbox Team Leader",
		[5] = "Director of Department",
		[6] = "Co-Dean of Medicine",
		[7] = "Dean of Medicine"
	}
}

local target_player_id = 0

TriggerEvent('es:addJobCommand', 'ticket', { 'sheriff', 'police' , 'judge', "corrections"}, function(source, args, char)
	local targetPlayer = tonumber(args[2])
	local amount = math.ceil(tonumber(args[3]))
	table.remove(args, 1)
	table.remove(args, 1)
	table.remove(args, 1)
	local reason = table.concat(args, " ")
	if not targetPlayer or not amount or reason == "" or reason == " " or amount > maxTicketAmount then
		TriggerClientEvent("usa:notify", source, "~y~Usage: ~w~/ticket [id] [amount] [infractions]")
		return
	end
	local target = exports["usa-characters"]:GetCharacter(targetPlayer)
	local target_name = target.getFullName()
	local target_bank = target.get('bank')
	TriggerClientEvent('usa:notify', source, 'Ticket issued to ~y~'..target_name..'~s~ for ~y~$'..amount..'~s~!')
	target.removeBank(amount, "Police Ticket")
	local ticket = {
		reason = reason,
		fine = amount,
		timestamp = os.date('%m-%d-%Y %H:%M:%S', os.time()),
		issuedBy = char.getFullName(),
		type = "ticket",
		number = 'T'..math.random(10000000, 99999999)
	}
	local user_history = target.get("criminalHistory")
	table.insert(user_history, ticket)
	target.set("criminalHistory", user_history)
	TriggerClientEvent('chatMessage', targetPlayer, '^3^*[TICKET] ^r^0You have been issued a ticket for ^3$'..amount..'^0. ('..reason..')')
end, {
	help = "Write a ticket to player",
	params = {
		{ name = "id", help = "Players ID" },
		{ name = "amount", help = "Fine Amount" },
		{ name = "infractions", help = "Traffic Infractions" }
	}
})

-- /dispatch
TriggerEvent('es:addJobCommand', 'dispatch', { "corrections", "sheriff", "ems", "taxi", "mechanic" }, function(source, args, char)
	local target = tonumber(args[2])
	if GetPlayerName(target) then
		table.remove(args,1)
		table.remove(args,1)
		local msg = table.concat(args, " ")
		TriggerClientEvent('dispatch:notify', target, char.get("name").last, source, msg)
		local cjob = char.get("job")
		local targetJobs = {}
		if cjob == "sheriff" or cjob == "corrections" or cjob == "ems" then
			targetJobs = {"sheriff", "corrections", "ems"}
		else
			targetJobs = {cjob}
		end
		exports["globals"]:notifyPlayersWithJobs(targetJobs, '^5^*[DISPATCH] ^r^0'..char.get("name").last..' ['..source..'] to #'..target..': '..msg, "onlyDeputiesNoCOs") -- send to all others players with same job as dispatcher
	else
		TriggerClientEvent("usa:notify", source, "Error: caller id # not entered")
	end
end, {
	help = "Send a message as dispatch.",
	params = {
		{ name = "id", help = "Players ID" },
		{ name = "message", help = "Message to player" }
	}
})

TriggerEvent('es:addJobCommand', 'barrier', { "corrections", "sheriff", "ems", "fire"}, function(source, args, char)
	local obj = nil
	if args[2] == "1" then
		obj = "prop_mp_cone_01"
	elseif args[2] == "2" then
		obj = "prop_barrier_work05"
	end
	TriggerClientEvent('createObject', source, obj)
end, {
	help = "Place a barrier",
	params = {
		{ name = "Barrier Number", help = "Either 1 or 2. 1 = cone, 2 = wood barrier" }
	}
})

TriggerEvent('es:addJobCommand', 'cone', { "corrections", "sheriff", "ems", "fire", "mechanic" }, function(source, args, char)
	TriggerClientEvent('c_setCone', source)
end, {
	help = "Drop a cone down"
})

TriggerEvent('es:addJobCommand', 'pickup', { "corrections", "sheriff", "ems", "fire", "mechanic" }, function(source, args, char)
	TriggerClientEvent('c_removeCones', source)
end, {
	help = "Pick up cones or barriers"
})

TriggerEvent('es:addJobCommand', 'removecones', { "corrections", "sheriff", "ems", "fire", "mechanic" }, function(source, args, char)
	TriggerClientEvent('c_removeCones', source)
end, {
	help = "Pick up cones or barriers"
})

function comma_value(amount)
  local formatted = amount
  while true do
	formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
	if (k==0) then
	  break
	end
  end
  return formatted
end

function isCloseEnoughToSearch(id1, id2)
	local coords1 = GetEntityCoords(GetPlayerPed(id1))
	local coords2 = GetEntityCoords(GetPlayerPed(id2))
	if exports.globals:getCoordDistance(coords1, coords2) < 3 then
		return true
	else
		return false
	end
end

---------- SEARCH COMMAND ----------
RegisterServerEvent("search:searchPlayer")
AddEventHandler("search:searchPlayer", function(playerId, src)
	if not GetPlayerName(playerId) then -- online check
		TriggerClientEvent("usa:notify", src, "No person found")
		return
	end
	if not isCloseEnoughToSearch(src, playerId) then
		TriggerClientEvent("usa:notify", src, "Not close enough")
		return
	end
	local char = exports["usa-characters"]:GetCharacter(playerId)
	local items = {}
	local inventory = char.get("inventory")
	for i = 0, (inventory.MAX_CAPACITY - 1) do
		if inventory.items[tostring(i)] then
			local item = inventory.items[tostring(i)]
			if item.type ~= "license" then
				table.insert(items, inventory.items[tostring(i)])
			end
		end
	end
	TriggerClientEvent("chatMessage", src, "", {0,0,0}, "^3^*[SEARCH]")
	local idString = exports["usa_altchat"]:GetIdString(playerId, char)
	TriggerClientEvent("chatMessage", src, "", {0,0,0}, idString)
	TriggerClientEvent("chatMessage", src, "", {0,0,0}, "^3Cash Found:^0 $" .. comma_value(char.get("money")))
	for i = 1, #items do
		local name = items[i].name
		local quantity = items[i].quantity
		local legality = items[i].legality
		if legality == "illegal" then
			TriggerClientEvent("chatMessage", src, "", {}, "^1(x" .. quantity .. ") " .. name) -- print item red
		else
			if items[i].serialNumber then
				TriggerClientEvent("chatMessage", src, "", {}, "^0(x" .. quantity .. ") " .. name .. ' - '..items[i].serialNumber) -- print item
			elseif items[i].residue and items[i].name == 'Razor Blade' then
				TriggerClientEvent("chatMessage", src, "", {}, "^0(x" .. quantity .. ") " .. name .. ' (Powdery Residue)') -- print item
			elseif items[i].residue and items[i].name == 'Large Scissors' then
				TriggerClientEvent("chatMessage", src, "", {}, "^0(x" .. quantity .. ") " .. name .. ' (Odor of Marijuana)') -- print item
			else
				TriggerClientEvent("chatMessage", src, "", {}, "^0(x" .. (quantity or "?") .. ") " .. name)
			end
		end
		if items[i].components then
			for k = 1, #items[i].components do
				TriggerClientEvent("chatMessage", src, "", {0, 50, 0}, "^0		+ " .. items[i].components[k])
			end
		end
	end
	if src ~= playerId then
		-- open inventory UI for person doing searching showing items of searched person
		TriggerClientEvent("interaction:openGUIAndSendNUIData", src, {
			type = "showSearchedInventory",
			inv = inventory,
			searchedPersonSource = playerId
		})
		-- add to list of people accessing that inventory (so we can keep track of who needs to be updated if multiple people are searching a single inventory at once)
		TriggerEvent("inventory:addInventoryAccessor", playerId, src)
	end
end)

RegisterServerEvent("police:frisk")
AddEventHandler("police:frisk", function(playerId, src)
	local char = exports["usa-characters"]:GetCharacter(playerId)
	local weapons = char.getWeapons()
	if char.get("money") > 8000 then -- a large sum of money
		TriggerClientEvent("chatMessage", src, "", {0,0,0}, "^3^*[SEARCH] ^r^0Cash Found:^0 $" .. comma_value(char.get("money")))
	end
	if #weapons > 0 then
		for i = 1, #weapons do
			Wait(2000)
			local name = weapons[i].name
			local quantity = weapons[i].quantity
			local legality = weapons[i].legality
			if legality == "illegal" then
				TriggerClientEvent("chatMessage", src, "", {}, "^1(x" .. quantity .. ") " .. name) -- print item red
			else
				if weapons[i].serialNumber then
					TriggerClientEvent("chatMessage", src, "", {}, "^0(x" .. quantity .. ") " .. name .. ' - '..weapons[i].serialNumber)
				else
					TriggerClientEvent("chatMessage", src, "", {}, "^0(x" .. quantity .. ") " .. name)
				end
			end
			if weapons[i].components then
				for k = 1, #weapons[i].components do
					TriggerClientEvent("chatMessage", src, "", {0, 50, 0}, "^0		+ " .. weapons[i].components[k])
				end
			end
		end
	else
		TriggerClientEvent("chatMessage", src, "", {0,0,0}, "^3INFO: ^0Nothing found on player!")
	end
	local items = char.getInventoryItems()
	for i = 1, #items do 
		local item = items[i]
		if item.legality == "illegal" then 
			if item.quantity > 8 then 
				TriggerClientEvent("chatMessage", src, "", {}, "^0You feel a ^3large amount^0 of what feels like " .. item.name .. "(s)") -- print item red
			end
		end
	end
end)

RegisterServerEvent("search:playSuspectAnim")
AddEventHandler("search:playSuspectAnim", function(sourceToSearch, x, y, z, heading)
	TriggerClientEvent("search:playSuspectAnim", sourceToSearch, x, y, z, heading)
end)

function canBypassDownedOrTiedCheck(char)
	local isLEO = false
	local charJob = char.get("job")
	if charJob == "corrections" then
		return true
	elseif charJob == "sheriff" then
		return true
	elseif charJob == "ems" then
		return true
	else
		return false
	end
end

RegisterServerEvent("search:foundPlayerToSearch")
AddEventHandler("search:foundPlayerToSearch", function(id)
	local src = source
	local fromChar = exports["usa-characters"]:GetCharacter(src)
	local canBypassSearchChecks = canBypassDownedOrTiedCheck(fromChar)
	local civCanBeSearched = TriggerClientCallback {
		source = id,
		eventName = "search:canBeSearched",
		args = {}
	}
	if canBypassSearchChecks or civCanBeSearched then
		TriggerEvent("search:searchPlayer", id, src)
	else
		TriggerClientEvent("usa:notify", src, "Player not downed, tied, hands up")
	end
end)

RegisterServerEvent("search:civSearchedCheckFailedNotify")
AddEventHandler("search:civSearchedCheckFailedNotify", function(playerId)
	TriggerClientEvent("usa:notify", playerId, "Person not downed / tied up / hands not up")
end)

TriggerEvent('es:addCommand', 'search', function(source, args, char)
	if exports["usa-arena"]:isPlayerPlaying(source) then
		TriggerClientEvent("usa:notify", source, "Can't do that here", "^3INFO: ^0Can't search when playing in the arena")
		return
	end
	local job = char.get("job")
	if job == "sheriff" or job == "corrections" then
		if not tonumber(args[2]) then
			TriggerClientEvent("search:searchNearest", source, source)
		else
			TriggerClientEvent("usa:playAnimation", source, "anim@move_m@trash", "pickup", -8, 1, -1, 53, 0, 0, 0, 0, 4)
			TriggerEvent("search:searchPlayer", tonumber(args[2]), source)
		end
	else
		TriggerClientEvent("search:attemptToSearchNearestPerson", source)
	end
end, {help = "Search the nearest person or vehicle"})

TriggerEvent('es:addJobCommand', 'frisk', {"sheriff", "ems", "corrections"}, function(source, args, char)
	if not tonumber(args[2]) then
		TriggerClientEvent("police:friskNearest", source, source)
	else
		TriggerClientEvent("usa:playAnimation", source, "anim@move_m@trash", "pickup", -8, 1, -1, 53, 0, 0, 0, 0, 4)
		TriggerEvent("police:frisk", tonumber(args[2]), source)
	end
end, {help = "Search the nearest person or vehicle"})

--------------------------------------------------------------------------------------------------------------------------------------------------

-- start bait car
TriggerEvent('es:addJobCommand', 'lockbc',  {"sheriff", "corrections"}, function(source, args, user)
	local ServerID = args[2]
	if not tonumber(ServerID) then return end
	TriggerClientEvent("simp:baitCarDisable", tonumber(ServerID))
end, {
	help = "Lock the bait car's doors and shut off the engine",
	params = {
		{ name = "id", help = "Player's ID" }
	}
})

TriggerEvent('es:addJobCommand', 'unlockbc',  {"sheriff", "corrections"}, function(source, args, user)
	local ServerID = args[2]
	if not tonumber(ServerID) then return end
	TriggerClientEvent("simp:baitCarunlock", tonumber(ServerID))
end, {
	help = "Unlock the bait car's doors",
	params = {
		{ name = "id", help = "Player's ID" }
	}
})
-- end bait car

-- start seize contraband
TriggerEvent('es:addJobCommand', 'seize', { "sheriff", "corrections" }, function(source, args, char)
	local targetId = tonumber(args[2])
	local arg = args[3]
	if arg and targetId then
		if arg == "contraband" then
			local target = exports["usa-characters"]:GetCharacter(targetId)
			local seized = target.removeIllegalItems()
			for i = 1, #seized do
				TriggerClientEvent("usa:notify", source, "~y~Seized: ~w~(x".. (seized[i].quantity or 1) ..") " .. seized[i].name)
				TriggerClientEvent("usa:notify", targetId, "~y~Seized: ~w~(x".. (seized[i].quantity or 1) ..") " .. seized[i].name)
			end
			exports["globals"]:sendLocalActionMessage(source, "Removes contraband")
			TriggerClientEvent("chatMessage", targetId, "", {0, 0, 0}, "^0" .. char.getName() .. " seized your illegal contraband.")
		elseif arg == "cash" then
			target_player_id = targetId
			TriggerClientEvent("police:getMoneyInput", source)
		elseif arg == "weapons" then
			local target = exports["usa-characters"]:GetCharacter(targetId)
			target.removeWeapons()
			TriggerClientEvent("usa:notify", source, "Weapons seized!")
			exports["globals"]:sendLocalActionMessage(source, "Removes weapons")
			TriggerClientEvent("chatMessage", targetId, "", {0, 0, 0}, "^0" .. char.getName() .. " seized your weapons.")
		elseif arg == "ammo" then
			local target = exports["usa-characters"]:GetCharacter(targetId)
			target.removeItemWithField("type", "ammo", true)
			TriggerClientEvent("usa:notify", source, "Ammo seized!")
			exports["globals"]:sendLocalActionMessage(source, "Removes ammo")
			TriggerClientEvent("chatMessage", targetId, "", {0, 0, 0}, "^0" .. char.getName() .. " seized your ammo.")
		elseif arg == "mags" then
			local target = exports["usa-characters"]:GetCharacter(targetId)
			target.removeItemWithField("type", "magazine", true)
			TriggerClientEvent("usa:notify", source, "Magazines seized!")
			exports["globals"]:sendLocalActionMessage(source, "Removes magazines")
			TriggerClientEvent("chatMessage", targetId, "", {0, 0, 0}, "^0" .. char.getName() .. " seized your magazines.")
		else
			TriggerClientEvent("usa:notify", source, "Invalid Seize Type")
		end
	end
end, {
	help = "Seize cash/items from a person.",
	params = {
		{ name = "id", help = "Player's' ID" },
		{ name = "type", help = "'cash', 'weapons', 'contraband', 'ammo', or 'mags'" }
	}
})

TriggerEvent('es:addJobCommand', 'seizeveh', { "sheriff", "corrections" }, function(source, args, char)
	local arg = args[2]
	if arg then
		if arg == "contraband" then
			TriggerClientEvent("interaction:seizeVehContraband", source)
		elseif arg == "weapons" then
			arg = "weapon"
			TriggerClientEvent("interaction:seizeVeh", source, arg)
		elseif arg == "ammo" then
			TriggerClientEvent("interaction:seizeVeh", source, arg)
		elseif arg == "mags" then
			arg = "magazine"
			TriggerClientEvent("interaction:seizeVeh", source, arg)
		else
			TriggerClientEvent("usa:notify", source, "Invalid Seize Type")
		end
	end
end, {
	help = "Seize items from a vehicle.",
	params = {
		{ name = "type", help = "'weapons', 'contraband', 'ammo', or 'mags'" }
	}
})

RegisterServerEvent("police:seizeCash")
AddEventHandler("police:seizeCash", function(amount)
	local target_money = exports["usa-characters"]:GetCharacterField(target_player_id, "money")
	local char = exports["usa-characters"]:GetCharacter(source)
	if target_money - amount >= 0 then
		exports["usa-characters"]:SetCharacterField(target_player_id, "money", target_money - amount)
		TriggerClientEvent("usa:notify", source, "~y~Seized: ~w~$" .. amount)
		TriggerClientEvent("usa:notify", target_player_id, "~y~Seized: ~w~$" .. amount)
		exports["globals"]:sendLocalActionMessage(source, "Removes cash")
		TriggerClientEvent("chatMessage", source, "", {0, 0, 0}, "^0Seized: $" .. amount)
		TriggerClientEvent("chatMessage", target_player_id, "", {0, 0, 0}, "^0" .. char.getName() .. " seized $" .. amount .. " from you.")
	end
end)

TriggerEvent('es:addCommand', 'showbadge', function(source, args, char, location)
	local police_rank = char.get("policeRank")
	local bcso_rank = char.get("bcsoRank")
	local ems_rank = char.get("emsRank")
	local doctor_rank = char.get("doctorRank")
	if (doctor_rank == nil) then
		doctor_rank = 0
	end
	local char_name = char.getFullName()

	if args[2] == "sasp" then	
		if police_rank > 0 then
			exports["globals"]:sendLocalActionMessage(source, char_name .. " shows official police badge.")
			TriggerClientEvent("badge:client:animation", source)
			local msg = "^*[SASP BADGE]^r ^2Name: ^0" .. char_name .. " - ^2SSN: ^0" .. source .. " - ^2Rank: ^0" .. GetRankName(police_rank, "sheriff")
			exports["globals"]:sendLocalActionMessageChat(msg, location)
		else
			TriggerClientEvent("usa:notify", source, "Not whitelisted for this dept.")
		end
	elseif args[2] == "bcso" then
		if bcso_rank > 0 then
			exports["globals"]:sendLocalActionMessage(source, char_name .. " shows official police badge.")
			TriggerClientEvent("badge:client:animation", source)
			local msg = "^*[BCSO BADGE]^r ^2Name: ^0" .. char_name .. " - ^2SSN: ^0" .. source .. " - ^2Rank: ^0" .. GetRankName(bcso_rank, "corrections")
			exports["globals"]:sendLocalActionMessageChat(msg, location)
		else
			TriggerClientEvent("usa:notify", source, "Not whitelisted for this dept.")
		end
	elseif args[2] == "ems" then
		if ems_rank > 0 then
			exports["globals"]:sendLocalActionMessage(source, char_name .. " shows official ems badge.")
			TriggerClientEvent("badge:client:animation", source)
			local msg = "^*[EMS BADGE]^r ^2Name: ^0" .. char_name .. " - ^2SSN: ^0" .. source .. " - ^2Rank: ^0" .. GetRankName(ems_rank, "ems")
			exports["globals"]:sendLocalActionMessageChat(msg, location)
		else
			TriggerClientEvent("usa:notify", source, "Not whitelisted for this dept.")
		end
	elseif args[2] == "doctor" then
		if doctor_rank > 0 then
			exports["globals"]:sendLocalActionMessage(source, char_name .. " shows official pillbox id card.")
			TriggerClientEvent("badge:client:animation", source)
			local msg = "^*[Pillbox ID Card]^r ^2Name: ^0" .. char_name .. " - ^2SSN: ^0" .. source .. " - ^2Rank: ^0" .. GetRankName(doctor_rank, "doctor")
			exports["globals"]:sendLocalActionMessageChat(msg, location)
		else
			TriggerClientEvent("usa:notify", source, "Not whitelisted for this dept.")
		end
	elseif args[2] == nil then
		if police_rank > 0 then
			exports["globals"]:sendLocalActionMessage(source, char_name .. " shows official police badge.")
			TriggerClientEvent("badge:client:animation", source)
			local msg = "^*[SASP BADGE]^r ^2Name: ^0" .. char_name .. " - ^2SSN: ^0" .. source .. " - ^2Rank: ^0" .. GetRankName(police_rank, "sheriff")
			exports["globals"]:sendLocalActionMessageChat(msg, location)
		elseif bcso_rank > 0 then
			exports["globals"]:sendLocalActionMessage(source, char_name .. " shows official police badge.")
			TriggerClientEvent("badge:client:animation", source)
			local msg = "^*[BCSO BADGE]^r ^2Name: ^0" .. char_name .. " - ^2SSN: ^0" .. source .. " - ^2Rank: ^0" .. GetRankName(bcso_rank, "corrections")
			exports["globals"]:sendLocalActionMessageChat(msg, location)
		elseif ems_rank > 0 then
			exports["globals"]:sendLocalActionMessage(source, char_name .. " shows official ems badge.")
			TriggerClientEvent("badge:client:animation", source)
			local msg = "^*[EMS BADGE]^r ^2Name: ^0" .. char_name .. " - ^2SSN: ^0" .. source .. " - ^2Rank: ^0" .. GetRankName(ems_rank, "ems")
			exports["globals"]:sendLocalActionMessageChat(msg, location)
		elseif doctor_rank > 0 then
			exports["globals"]:sendLocalActionMessage(source, char_name .. " shows official pillbox id card.")
			TriggerClientEvent("badge:client:animation", source)
			local msg = "^*[Pillbox ID Card]^r ^2Name: ^0" .. char_name .. " - ^2SSN: ^0" .. source .. " - ^2Rank: ^0" .. GetRankName(doctor_rank, "doctor")
			exports["globals"]:sendLocalActionMessageChat(msg, location)
		end
	end
end, {
	help = "Show official police or ems badge.",
	params = {
		{ name = "dept", help = "Department: sasp, bcso, ems, doctor." }
	}
})

function GetRankName(rank, dept)
	local department = nil
	if dept == "corrections" then 
		department = "BCSO"
	elseif dept == "sheriff" then 
		department = "SASP"
	elseif dept == "ems" then
		department = "EMS"
	elseif dept == "doctor" then
		department = "Doctor"
	end
	return POLICE_RANKS[department][rank]
end

function GetPublicServantIds()
	local sasp = exports["usa-characters"]:GetPlayerIdsWithJob("sheriff")
	local bcso = exports["usa-characters"]:GetPlayerIdsWithJob("corrections")
	local ems = exports["usa-characters"]:GetPlayerIdsWithJob("ems")
	local doctor = exports["usa-characters"]:GetPlayerIdsWithJob("doctor")
	local judge = exports["usa-characters"]:GetPlayerIdsWithJob("judge")
	local all = {}
	for i = 1, #sasp do table.insert(all, sasp[i]) end
	for i = 1, #bcso do table.insert(all, bcso[i]) end
	for i = 1, #ems do table.insert(all, ems[i]) end
	for i = 1, #doctor do table.insert(all, doctor[i]) end
	for i = 1, #judge do table.insert(all, judge[i]) end
	return all
end

function PutPanicBlipOnMap(id, coord, name)
	TriggerClientEvent("police:panicBlipAtCoord", id, coord, name)
end

function SendPanicTextAlert(id, msg)
	TriggerClientEvent("chatMessage", id, "DISPATCH", {255, 0, 0}, "^0" .. msg)
end

function PlayPanicButtonSound(id)
	TriggerClientEvent('InteractSound_CL:PlayOnOne', id, "panicButton", 0.26)
end

TriggerEvent('es:addJobCommand', 'p', { "sheriff", "ems", "corrections", "doctor", "judge" }, function(source, args, char, location)
	-- for all public servants:
		-- put blip on map for x seconds
		-- send text message alert
		-- play panic button sound
	local publicServants = GetPublicServantIds()
	for i = 1, #publicServants do 
		local id = publicServants[i]
		local panicCoords = GetEntityCoords(GetPlayerPed(source))
		PutPanicBlipOnMap(id, panicCoords, char.get("name").last)
		local msg = "(10-99) Panic button pressed by " .. char.getFullName()
		SendPanicTextAlert(id, msg)
		PlayPanicButtonSound(id)
	end
end, { help = "Press your panic button. CAUTION: ONLY FOR EXTREME EMERGENCIES."})

-- revoke gun license / firearm permit --
RegisterServerEvent("police:revokeFirearmPermit")
AddEventHandler("police:revokeFirearmPermit", function(source)
	local char = exports["usa-characters"]:GetCharacter(source)
	local permit = char.getItem("Firearm Permit")
	local flyingPermit = char.getItem("Aircraft License")
	if permit then
		char.modifyItem(permit, "status", "suspended")
	end

	if flyingPermit then
		char.modifyItem(flyingPermit, "status", "suspended")
	end
end)

RegisterServerEvent('police:suspendPilotLicense')
AddEventHandler('police:suspendPilotLicense', function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local flyingPermit = char.getItem("Aircraft License")

	if flyingPermit then
		char.modifyItem(flyingPermit, "status", "suspended")
	end
end)

-- check suspension dates --
RegisterServerEvent("police:checkSuspension")
AddEventHandler("police:checkSuspension", function(character)
	local dl =  character.getItem("Driver's License")
	local bl = character.getItem("Boat License")
	local al = character.getItem("Aircraft License")
	local bar = character.getItem("Bar Certificate")

	-- DL --
	if dl then
		if dl.status == "suspended" then
			if dl.suspension_start then
				local reference = dl.suspension_start
				local daysfrom = os.difftime(os.time(), reference) / (24 * 60 * 60) -- seconds in a day
				local wholedays = math.floor(daysfrom)
				if wholedays >= dl.suspension_days then
					character.modifyItem(dl, "status", "valid")
				end
			end
		end
	end

	if bl then
		if bl.status == "suspended" then
			if bl.suspension_start then
				local reference = bl.suspension_start
				local daysfrom = os.difftime(os.time(), reference) / (24 * 60 * 60) -- seconds in a day
				local wholedays = math.floor(daysfrom)
				if wholedays >= bl.suspension_days then
					character.modifyItem(bl, "status", "valid")
				end
			end
		end
	end

	if al then
		if al.status == "suspended" then
			if al.suspension_start then
				local reference = al.suspension_start
				local daysfrom = os.difftime(os.time(), reference) / (24 * 60 * 60) -- seconds in a day
				local wholedays = math.floor(daysfrom)
				if wholedays >= al.suspension_days then
					character.modifyItem(al, "status", "valid")
				end
			end
		end
	end

	if bar then
		if bar.status == "suspended" then
			if bar.suspension_start then
				local reference = bar.suspension_start
				local daysfrom = os.difftime(os.time(), reference) / (24 * 60 * 60) -- seconds in a day
				local wholedays = math.floor(daysfrom)
				if wholedays >= bar.suspension_days then
					character.modifyItem(bar, "status", "valid")
				end
			end
		end
	end
end)
