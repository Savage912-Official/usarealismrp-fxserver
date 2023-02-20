--# Created by: minipunch
--# for USA REALISM rep
--# requres 'globals' resource to send notifications and usa_rp to change their model, check their jail time on join, and stuff like that

-- Each cell block floor starts from the leftmost cell and wraps around until finished (cell numbers)
local CELLS = {
	{x = 1767.6765136719, y = 2501.0712890625, z = 45.740745544434, occupant = nil}, -- Cell 1
	{x = 1764.2520751953, y = 2499.0471191406, z = 45.740772247314, occupant = nil}, -- Cell 2
	{x = 1761.2839355469, y = 2497.3190917969, z = 45.740772247314, occupant = nil}, -- Cell 3
	{x = 1754.935546875, y = 2493.5183105469, z = 45.740772247314, occupant = nil}, -- Cell 4
	{x = 1752.2100830078, y = 2491.8581542969, z = 45.740749359131, occupant = nil}, -- Cell 5
	{x = 1748.9245605469, y = 2490.0551757813, z = 45.740749359131, occupant = nil}, -- Cell 6
	{x = 1767.6411132813, y = 2500.9851074219, z = 49.693042755127, occupant = nil}, -- Cell 7
	{x = 1764.6899414063, y = 2499.1826171875, z = 49.693050384521, occupant = nil}, -- Cell 8
	{x = 1761.4486083984, y = 2497.2639160156, z = 49.693046569824, occupant = nil}, -- Cell 9
	{x = 1758.0531005859, y = 2495.8103027344, z = 49.693054199219, occupant = nil}, -- Cell 10
	{x = 1754.9320068359, y = 2494.3276367188, z = 49.693046569824, occupant = nil}, -- Cell 11
	{x = 1751.9644775391, y = 2492.0417480469, z = 49.693050384521, occupant = nil}, -- Cell 12
	{x = 1748.7556152344, y = 2490.1962890625, z = 49.693042755127, occupant = nil}, -- Cell 13
	{x = 1758.5069580078, y = 2472.4377441406, z = 45.740745544434, occupant = nil}, -- Cell 14
	{x = 1761.7844238281, y = 2474.1655273438, z = 45.740745544434, occupant = nil}, -- Cell 15
	{x = 1764.6411132813, y = 2476.3666992188, z = 45.740772247314, occupant = nil}, -- Cell 16
	{x = 1768.19921875, y = 2477.8666992188, z = 45.740726470947, occupant = nil}, -- Cell 17
	{x = 1771.2290039063, y = 2479.6123046875, z = 45.740745544434, occupant = nil}, -- Cell 18
	{x = 1774.1466064453, y = 2481.6750488281, z = 45.740760803223, occupant = nil}, -- Cell 19
	{x = 1777.7443847656, y = 2483.2238769531, z = 45.740760803223, occupant = nil}, -- Cell 20
	{x = 1758.3173828125, y = 2472.7045898438, z = 49.693050384521, occupant = nil}, -- Cell 21
	{x = 1762.1300048828, y = 2473.6948242188, z = 49.693050384521, occupant = nil}, -- Cell 22
	{x = 1764.7816162109, y = 2476.2902832031, z = 49.693054199219, occupant = nil}, -- Cell 23
	{x = 1767.9769287109, y = 2477.9680175781, z = 49.693046569824, occupant = nil}, -- Cell 24
	{x = 1770.8480224609, y = 2479.720703125, z = 49.693046569824, occupant = nil}, -- Cell 25
	{x = 1774.1553955078, y = 2481.6520996094, z = 49.693042755127, occupant = nil}, -- Cell 26
	{x = 1777.3125, y = 2483.3032226563, z = 49.693046569824, occupant = nil}, -- Cell 27
}

local alarm_on = false

local DB_NAME = "prisonitemstorage"

exports["globals"]:PerformDBCheck("usa_jail", DB_NAME)

-- V2
TriggerEvent('es:addCommand', 'jail', function(source, args, char)
	local job = char.get("job")
	local jailtime = char.get("jailTime")
	if job == "sheriff" or job == "cop" or job == "corrections" or job == "judge" then
		TriggerClientEvent("jail:openMenu", tonumber(source))
	elseif jailtime > 0 then
		TriggerClientEvent("usa:notify", tonumber(source), "You have ~y~" .. jailtime .. " month(s) ~w~left in your jail sentence.")
	end
end, {
	help = "See how much time you have left in jail / jail a player (police)"
})

TriggerEvent('es:addJobCommand', 'togglealarm', { "corrections", "sheriff", "cop"}, function(source, args, char)
	if alarm_on == false then
		alarm_on = true
	    TriggerClientEvent('chat:addMessage', source, { args = { '^1PRISON SYSTEM', 'Prison Alarm Activated!' } })
	    TriggerEvent("jail:startalarmSV")
	else
		alarm_on = false
		TriggerClientEvent('chat:addMessage', source, { args = { '^1PRISON SYSTEM', 'Prison Alarm Deactivated!' } })
		TriggerEvent("jail:stopalarmSV")
	end
end, {
	help = "Toggle the Prison Alarm on or off (Police/Corrections)"
})

TriggerEvent('es:addJobCommand', 'lockdoors', {"corrections"}, function(source, args, char)
	TriggerEvent("doormanager:lockPrisonDoors")
	TriggerClientEvent("usa:notify", source, "All Jail Doors have been locked!")
end, {
	help = "Lock all Cell Doors (Corrections)"
})

RegisterServerEvent("jail:jailPlayerFromMenu")
AddEventHandler("jail:jailPlayerFromMenu", function(data)
	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get('job')
	if job == 'sheriff' or job == 'corrections' or job == "judge" then
		local arrestingOfficerName = char.getFullName()
		jailPlayer(source, data, arrestingOfficerName, data.gender)
	else
		DropPlayer(source, "Exploiting. Your information has been logged and staff has been notified. If you feel this was by mistake, let a staff member know.")
		TriggerEvent("usa:notifyStaff", '^1^*[ANTICHEAT]^r^0 Player ^1'..GetPlayerName(source)..' ['..GetPlayerIdentifier(source)..'] ^0 has been kicked for LUA injection, please intervene^0!')
	end
end)

function jailPlayer(src, data, officerName, gender)
	local targetPlayer = tonumber(data.id)
	if not GetPlayerName(targetPlayer) then TriggerClientEvent("usa:notify", src, 'Player to jail not found!') return end
	local sentence = tonumber(data.sentence)
	local reason = data.charges
	local fine = data.fine
	if sentence == nil then
		TriggerClientEvent("usa:notify", src, 'Invalid jail time!')
		CancelEvent()
		return
	elseif not tonumber(fine) then
		TriggerClientEvent("usa:notify", src, 'Invalid fine!')
		CancelEvent()
		return
	end
	if tonumber(fine) then
		fine = tonumber(fine)
		fine = math.ceil(fine)
		print("after rounding, fine: " .. fine)
	end
	local inmate = exports["usa-characters"]:GetCharacter(targetPlayer)
	-- assign an open cell --
	local assigned_cell = CELLS[1] -- use CELLS[1] just in case there are no open cells (lol)
	for i = 1, #CELLS do
		if not CELLS[i].occupant then
			CELLS[i].occupant = {
				name = inmate.getFullName()
			}
			assigned_cell = CELLS[i]
			break
		end
	end
	-- send to assigned cell --
	local inmate_name = inmate.getFullName()

	exports["globals"]:notifyPlayersWithJobs({"sheriff", "corrections"}, "^3Jail: ^0".. inmate_name .. " has been jailed for ^3" .. sentence .. "^0 month(s).")
	exports["globals"]:notifyPlayersWithJobs({"sheriff", "corrections"}, "^3Charges:^0 " .. reason)
	exports["globals"]:notifyPlayersWithJobs({"sheriff", "corrections"}, "^3Fine:^0 $" .. fine)

	TriggerClientEvent("jail:jail", targetPlayer, assigned_cell, gender)
	inmate.removeWeapons()
	inmate.removeIllegalItems()

	if inmate.get("jailTime") == 0 then

		local inv = inmate.get("inventory")
		for i = 0, inv.MAX_CAPACITY do
			i = tostring(i)
			if inv.items[i] and inv.items[i].type and inv.items[i].type == "license" then
				inv.items[i] = nil
			end
		end
		local invtable = {
			inventory = inv,
			storedAt = os.time()
		}
		local charid = inmate.get("_id")
		TriggerEvent('es:exposeDBFunctions', function(db)
			db.createDocumentWithId(DB_NAME, invtable, charid, function(cb1)
				if cb1 then
					inmate.removeAllItems("license")
					TriggerClientEvent("usa:notify", targetPlayer, "Your belongings have been stored until your release!")
				else
					db.updateDocument(DB_NAME, charid, invtable, function(cb2)
						if cb2 then
							inmate.removeAllItems("license")
							TriggerClientEvent("usa:notify", targetPlayer, "Your belongings have been stored until your release!")
						else 
							TriggerClientEvent("usa:notify", targetPlayer, "There was an issue with taking your belongings automatically, please inform a CO about this.")
						end
					end)
				end
			end)
		end)
	end

	inmate.set("jailTime", sentence)
	inmate.set("job", "civ")

	inmate.removeBank(fine)

	if inmate.get("bank") < 0 then
		TriggerClientEvent("usa:notify", src, "Person owes money to the state!", "^3INFO: ^0The person you jailed now owes $" .. inmate.get("bank") .. " to the state. They can now legally have their assets (vehicles, properties, etc) worth that amount seized now unless they can pay the amount they owe.")
	end

	TriggerClientEvent("usa:notify", targetPlayer, "You have been fined: $" .. fine)
	-- add to criminal history --
	local playerCriminalHistory = inmate.get("criminalHistory")
	local record = {
		sentence = sentence,
		charges = reason,
		arrestingOfficer = officerName,
		timestamp = os.date('%m-%d-%Y %H:%M:%S', os.time()),
		type = "arrest",
		number = 'A'..math.random(10000000, 99999999)
	}

	table.insert(playerCriminalHistory, record)
	inmate.set("criminalHistory", playerCriminalHistory)
	TriggerEvent("warrants:removeAnyActiveWarrants", inmate.get("name"), inmate.get("dateOfBirth"))

	local suspensions = ""
	if GetDLSuspensionDays(reason) > 0 then
		TriggerEvent("dmv:setLicenseStatus", "suspended", targetPlayer, GetDLSuspensionDays(reason))
		TriggerClientEvent("usa:notify", targetPlayer, "Your driver's license has been suspended for " .. GetDLSuspensionDays(reason) .. " day(s)")
		suspensions = "\nDL suspended for " .. GetDLSuspensionDays(reason) .. " day(s)"
	end
	-- suspend gun permit if necessary --
	if GetFPRevoked(reason) then
		TriggerEvent("police:revokeFirearmPermit", targetPlayer)
		-- If we revoke FP permit, revoke the pilot license too
		TriggerEvent("police:suspendPilotLicense", targetPlayer)
		TriggerClientEvent("usa:notify", targetPlayer, "Your firearm permit has been revoked!")
		suspensions = suspensions .. "\nFP revoked permanently"
	end
	-- send to discord #jail-logs --
	local url = GetConvar("jail-log-webhook", "")
	if not suspensions then suspensions = "None" end
	PerformHttpRequest(url, function(err, text, headers)
		if text then
			print(text)
		end
	end, "POST", json.encode({
		embeds = {
			{
				description = "**Name:** " .. inmate_name .. " \n**Sentence:** " .. sentence .. " months" .. " \n**Charges:** " ..reason.. "\n**Fine:** $" .. fine .. "\n**Suspensions:** " .. (suspensions or "None") .. "\n**Arresting Officer:** " ..officerName.."\n**Timestamp:** " .. os.date('%m-%d-%Y %H:%M:%S', os.time()),
				color = 263172,
				author = {
					name = "Blaine County Correctional Facility"
				}
			}
		}
	}), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

RegisterServerEvent("jail:clearCell")
AddEventHandler("jail:clearCell", function(cell, clearJailTime)
	for i = 1, #CELLS do
		if CELLS[i].occupant and cell.occupant then
			if CELLS[i].occupant.name == cell.occupant.name then
				print("evicting person from cell #: " .. i .. "!")
				CELLS[i].occupant = nil
				break
			end
		end
	end
	-- clear jail time --
	if clearJailTime then
		local char = exports["usa-characters"]:GetCharacter(source)
		char.set("jailTime", 0)
	end
end)

RegisterServerEvent("jail:notifyEscapee")
AddEventHandler("jail:notifyEscapee", function()
	local WEBHOOK_URL = GetConvar("detention-webhook", "")
	local char = exports["usa-characters"]:GetCharacter(source)
	local inmate_name = char.getFullName()
	local charid = char.get("_id")
	exports["globals"]:notifyPlayersWithJobs({"sheriff", "corrections"}, "^3INFO: ^0A person has escaped from Bolingbroke Penitentiary! ^3Inmate info: ^0" .. inmate_name)

	exports.globals:SendDiscordLog(WEBHOOK_URL, "An inmate escaped! Name: `" .. inmate_name .. "`")

	TriggerEvent('es:exposeDBFunctions', function(db)
		db.deleteDocument(DB_NAME, charid, function(ok)
			-- print(ok) --debug
		end)
	end)

	alarm_on = true
	TriggerEvent("jail:startalarmSV", -1)
	SetTimeout(5 * 60 * 1000, function ()
		if alarm_on then
			alarm_on = false
			TriggerClientEvent("jail:stopalarmCL", -1)
		end
	end)
end)

RegisterServerEvent("jail:startalarmSV")
AddEventHandler('jail:startalarmSV', function()
	TriggerClientEvent("jail:startalarmCL", -1)
	TriggerEvent("doormanager:lockPrisonDoors")
end)

RegisterServerEvent("jail:stopalarmSV")
AddEventHandler('jail:stopalarmSV', function()
	TriggerClientEvent("jail:stopalarmCL", -1)
end)

RegisterServerEvent("jail:checkalarm")
AddEventHandler('jail:checkalarm', function()
	if alarm_on then
		TriggerClientEvent("jail:startalarmCL", source)
	else
		TriggerClientEvent("jail:stopalarmCL", source)
	end
end)

function GetFPRevoked(charges) -- firearm permit
	local numbers = {
		'187', '192', '206', '207', '211', '215', '245', '600', '487', '836.6', '26500', '11392', '16590', '18720', '29800', '30605', '33410', '2331', '2800.2', '2800.3', '2800.4', '51-50', '5150', '186.22', '18 U.S. Code § 922', '18 U.S. Code § 842'
	}

	for _, code in pairs(numbers) do
		if string.find(charges, code) then
			return true
		end
	end
	return false
end

function GetDLSuspensionDays(charges) -- driver license
	local codes = {
		['2800.1'] = 3,
		['2800.2'] = 14,
		['2800.3'] = 20,
		['2800.4'] = 20,
		["20001"] = 5,
		["20002"] = 3,
		["23103(b)"] = 4,
		["23153"] = 30,
		["10851"] = 4,
		["14601"] = 2,
	}
	local daysTotal = 0
	for code, days in pairs(codes) do
		if string.find(charges, code) then
			daysTotal = daysTotal + days
		end
	end
	return daysTotal
end

function jailStatusLoop()
	SetTimeout(60000, function()
		exports["usa-characters"]:GetCharacters(function(characters)
			for id, char in pairs(characters) do
				local jailtime = char.get("jailTime")
				if not jailtime then
					jailtime = 0
				end
				if jailtime > 0 then
					local newJailTime = jailtime - 1
					char.set("jailTime", newJailTime)
					if newJailTime == 0 then
						TriggerClientEvent("jail:release", tonumber(id), char.get("appearance"))
						exports["globals"]:notifyPlayersWithJob("corrections", "^3CORRECTIONS:^0 " .. char.getName() .. " has been released.")
					end
				end
			end
			jailStatusLoop()
		end)
	end)
end

jailStatusLoop()
