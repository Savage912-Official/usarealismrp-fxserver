local FIRST_AID_KIT_FEE = 80

local civSkins = {
		"a_m_m_beach_01",
		"a_m_m_bevhills_01",
		"a_m_m_bevhills_02",
		"a_m_m_business_01",
		"a_m_m_eastsa_01",
		"a_m_m_eastsa_02",
		"a_m_m_farmer_01",
		"a_m_m_genfat_01",
		"a_m_m_golfer_01",
		"a_m_m_hillbilly_01",
		"a_m_m_indian_01",
		"a_m_m_mexcntry_01",
		"a_m_m_paparazzi_01",
		"a_m_m_tramp_01",
		"a_m_y_hiker_01",
		"a_m_y_genstreet_01",
		"a_m_m_socenlat_01",
		"a_m_m_og_boss_01",
		"a_f_y_tourist_02",
		"a_f_y_tourist_01",
		"a_f_y_soucent_01",
		"a_f_y_scdressy_01",
		"a_m_y_cyclist_01",
		"a_m_y_golfer_01",
		"S_M_M_Linecook",
		"S_M_Y_Barman_01",
		"S_M_Y_BusBoy_01",
		"S_M_Y_Waiter_01",
		"A_M_Y_StBla_01",
		"A_M_M_Tennis_01",
		"A_M_Y_BreakDance_01",
		"A_M_Y_SouCent_03",
		"S_M_M_Bouncer_01",
		"S_M_Y_Doorman_01",
		"A_F_M_Tramp_01"
}

local MECHS_ON_TO_BLOCK_IMPOUND_CMD = nil

AddEventHandler('es:playerLoaded', function(source, user)
	if GetPlayerName(source) then
		print("Player " .. GetPlayerName(source) .. " has loaded.")
	end
	TriggerClientEvent('usa_rp:playerLoaded', source)
end)

RegisterServerEvent("usa_rp:spawnPlayer")
AddEventHandler("usa_rp:spawnPlayer", function()
	local model = civSkins[math.random(1,#civSkins)]
	TriggerClientEvent("usa_rp:spawn", source, model)
end)


RegisterServerEvent("usa_rp:checkJailedStatusOnPlayerJoin")
AddEventHandler("usa_rp:checkJailedStatusOnPlayerJoin", function(id)
	if id then source = id end
	local time = exports["usa-characters"]:GetCharacterField(source, "jailTime")
	local name = exports["usa-characters"]:GetCharacterField(source, "name")
	local fullName = name.first .. " " .. name.middle .. " " .. name.last
	if time > 0 then
		TriggerClientEvent("jail:jail", source)
		exports["globals"]:notifyPlayersWithJobs({"corrections"}, "^3INFO: ^0" .. fullName .. " has woken up from a nap.")
	end
end)

RegisterServerEvent("hospital:buyFirstAidKit")
AddEventHandler("hospital:buyFirstAidKit", function()
	local kit = {
		name = "First Aid Kit",
		price = FIRST_AID_KIT_FEE,
		type = "misc",
		quantity = 1,
		legality = "legal",
		weight = 5,
		objectModel = "v_ret_ta_firstaid",
		blockedInPrison = true
	}
	local char = exports["usa-characters"]:GetCharacter(source)
	if char.get("money") >= FIRST_AID_KIT_FEE then
		if not char.canHoldItem(kit) then
			TriggerClientEvent("usa:notify", source, "Inventory full!")
			return
		end
		char.giveItem(kit)
		char.removeMoney(FIRST_AID_KIT_FEE)
		TriggerClientEvent("usa:notify", source, "Here is your first aid kit!")
	else
		TriggerClientEvent("usa:notify", source, "Not enough money! Need $" .. FIRST_AID_KIT_FEE .. "")
	end
end)

-- V E H I C L E  C O N T R O L S
TriggerEvent('es:addCommand', 'rollw', function(source, args, char)
	TriggerClientEvent("RollWindow", source)
end, {
	help = "Roll the windows down"
})

TriggerEvent('es:addCommand', 'open', function(source, args, char)
	if args[2] then
		print("opening " .. args[2])
		TriggerClientEvent("veh:openDoor", source, args[2])
		--TriggerClientEvent("usa:notify", source, "test")
	end
end, {
	help = "Open a door",
	params = {
		{ name = "door", help = "hood, trunk, fl, fr, bl, br, ambulance" }
	}
})

TriggerEvent('es:addCommand', 'close', function(source, args, char)
	if args[2] then
		TriggerClientEvent("veh:shutDoor", source, args[2])
	end
end, {
	help = "Shut a door",
	params = {
		{ name = "door", help = "hood, trunk, fl, fr, bl, br, ambulance" }
	}
})

TriggerEvent('es:addCommand', 'shut', function(source, args, char)
	if args[2] then
		TriggerClientEvent("veh:shutDoor", source, args[2])
	end
end, {
	help = "Shut a door",
	params = {
		{ name = "door", help = "hood, trunk, fl, fr, bl, br, ambulance" }
	}
})

TriggerEvent('es:addCommand', 'shuffle', function(source, args, char)
	TriggerClientEvent("usa:shuffleSeats", source)

end, {
	help = "Shuffle seats in a vehicle"
})

TriggerEvent('es:addCommand', 'bl', function(source, args, char)
	TriggerClientEvent("usa:toggleBrakelight", source)
end, {
	help = "Toggle your vehicle idle brakelights"
})

-- R O L L  D I C E
RegisterServerEvent("usa:rollDice")
AddEventHandler("usa:rollDice", function(location, max)
	if max then
		local roll = math.random(1, max)
		local chatMsg = "Person with SSN " .. source .. " rolls a " .. roll .. " out of " .. max
		local msg3D = "Rolls a " .. roll .. " out of " .. max
		exports["globals"]:sendLocalActionMessageChat(chatMsg, location)
		exports["globals"]:sendLocalActionMessage(source, msg3D)
	end
end)

TriggerEvent('es:addCommand', 'roll', function(source, args, char, location)
	local max = tonumber(args[2])
	if max then
		print("rolling " .. max)
		local roll = math.random(1, max)
		local msg = "rolls a " .. roll .. " out of " .. max
		exports["globals"]:sendLocalActionMessageChat(msg, location)
		exports["globals"]:sendLocalActionMessage(source, msg)
	end
end, {
	help = "Roll a random number.",
	params = {
		{ name = "max", help = "The max number to roll" }
	}
})

-- U T I L I T Y  F U N C T I O N S

-- see if user has item in Inventory:
-- if player has it, return it
-- if not, return nil
RegisterServerEvent("usa:getPlayerItem")
AddEventHandler("usa:getPlayerItem", function(from_source, item_name, callback)
	local char = exports["usa-characters"]:GetCharacter(tonumber(from_source))
	local item = char.getItem(item_name)
	if item then
		callback(item)
	else
		callback(nil)
	end
end)

-- see if user has item in Inventory:
-- if player has it, return it
-- if not, return nil
RegisterServerEvent("usa:getPlayerItems")
AddEventHandler("usa:getPlayerItems", function(from_source, item_names, callback)
	local return_items = {}
	local found = false
	local char = exports["usa-characters"]:GetCharacter(tonumber(from_source))
	for i = 1, #item_names do
		local item = char.getItem(item_names[i])
		if item then
			table.insert(return_items, item)
			found = true
		end
	end
	if found then
		callback(return_items)
	else
		callback(nil)
	end
end)

-- assumes quantity provided is less than or equal to_remove_item.quantity
RegisterServerEvent("usa:removeItem")
AddEventHandler("usa:removeItem", function(to_remove_item, quantity)
	local char = exports["usa-characters"]:GetCharacter(source)
	char.removeItem(to_remove_item, quantity)
end)

RegisterServerEvent("usa:loadCivCharacter")
AddEventHandler("usa:loadCivCharacter", function(id)
	local usource = source
	if id then usource = id end
	local char = exports["usa-characters"]:GetCharacter(usource)
	local appearance = char.get("appearance")
	local weapons = char.getWeapons()
	TriggerClientEvent("usa:loadCivCharacter", usource, appearance, weapons)
end)

RegisterServerEvent("usa:loadPlayerComponents")
AddEventHandler("usa:loadPlayerComponents", function(id)
	local usource = source
	if id then usource = id end
	local appearance = exports["usa-characters"]:GetCharacterField(usource, "appearance")
	TriggerClientEvent("usa:setPlayerComponents", usource, appearance)
end)

TriggerEvent('es:addJobCommand', 'impound', { "sheriff", "ems", "corrections" }, function(source, args, char)
	if MECHS_ON_TO_BLOCK_IMPOUND_CMD == nil or exports["usa-characters"]:GetNumCharactersWithJob("mechanic") < MECHS_ON_TO_BLOCK_IMPOUND_CMD then
		local msg = "Calls for State Tow"
		TriggerEvent('display:shareDisplayBySource', source, msg, 5, 370, 10, 8000, true)
		TriggerClientEvent('impoundVehicle', source, false)
	else
		TriggerClientEvent("usa:notify", source, "Must call a mechanic!")
	end
end, { help = "Impound a vehicle." })

RegisterServerEvent("impound:impoundVehicle")
AddEventHandler("impound:impoundVehicle", function(vehicle, plate)
	local user = exports["essentialmode"]:getPlayerFromId(source)
	local userGroup = user.getGroup()
	local playerJob = exports["usa-characters"]:GetCharacterField(source, "job")
	if playerJob == "mechanic" or playerJob == "sheriff" or playerJob == "ems" or playerJob == "corrections" or playerJob == "eventPlanner" or userGroup ~= "user" then
		if plate then
			-- update impounded status of vehicle in DB --
			TriggerEvent('es:exposeDBFunctions', function(couchdb)
				couchdb.updateDocument("vehicles", plate, { impounded = true }, function()
					-- done impounding vehicle --
				end)
			end)
		end
	else
		TriggerClientEvent("impound:notify", source, "Only ~y~law enforcement~w~,~y~medics~w~, and ~y~admins~w~ can use /impound!")
	end
end)

TriggerEvent('es:addCommand', 'dv', function(source, args, char)
    local group = exports["essentialmode"]:getPlayerFromId(source).getGroup()
    if group ~= "user" or char.get("job") == "eventPlanner" then
        TriggerClientEvent('impoundVehicle', source, true)
    end
end, { help = "(Delete) Impound a vehicle. DO NOT USE FOR TRAINS USE /dt INSTEAD" })

local JOBS_TO_LOG = {
	sheriff = {
		DISPLAY_NAME = "SASP",
		WEBHOOK_URL = GetConvar("sasp-timesheet-webhook", "")
		
	},
	corrections = {
		DISPLAY_NAME = "BCSO/Corrections",
		WEBHOOK_URL = GetConvar("bcso-timesheet-webhook", "")
		
	},
	ems = {
		DISPLAY_NAME = "EMS",
		WEBHOOK_URL = GetConvar("ems-timesheet-webhook", "")
	},
	doctor = {
		DISPLAY_NAME = "Pillbox Medical",
		WEBHOOK_URL = GetConvar("ems-timesheet-webhook", "")
	},
	realtor = {
		DISPLAY_NAME = "REA",
		WEBHOOK_URL = ""
	},
	judge = {
		DISPLAY_NAME = "Judge",
		WEBHOOK_URL = GetConvar("doj-timesheet-webhook", "")
	},
	lawyer = {
		DISPLAY_NAME = "Attorney",
		WEBHOOK_URL = GetConvar("doj-timesheet-webhook", "")
	},
	da = {
		DISPLAY_NAME = "District Attorney",
		WEBHOOK_URL = GetConvar("doj-timesheet-webhook", "")
	}
}

RegisterServerEvent('job:sendNewLog')
AddEventHandler('job:sendNewLog', function(source, job, isOnDuty)
	local char = exports["usa-characters"]:GetCharacter(source)
	local userName = char.getFullName()
	local steamName = GetPlayerName(source)
	local steamIdent = GetPlayerIdentifier(source)

	local reason = 'Clocked in'
	local color = 47156
	local author = "Timesheet"
	if not isOnDuty then
		reason = 'Clocked out'
		color = 13565952
	end

	PerformHttpRequest(JOBS_TO_LOG[job].WEBHOOK_URL, function(err, text, headers)
		if text then
			print(text)
		end
	end, "POST", json.encode({
		embeds = {
			{
				color = color,

				author = {
					name = author
				},
				fields = {
					{
						name = "Identifier 1",
						value = steamIdent,
						inline = true
					},
					{
						name = "Identifier 2",
						value = userName,
						inline = true
					},
					{
						name = "Identifier 3",
						value = steamName,
						inline = true
					},
					{
						name = "Job",
						value = JOBS_TO_LOG[job].DISPLAY_NAME,
						inline = true
					},
					{
						name = "Reason",
						value = reason,
						inline = true
					},
				},
				footer = {
					text = os.date('%m-%d-%Y %H:%M:%S', os.time()) .. ' PST'
				}
			}
		},
	}), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end)

function handlePlayerDropDutyLog(char, steamName, steamIdent)
	if char then
		local userJob = char.get('job')
		local userName = char.getFullName()
		if JOBS_TO_LOG[userJob] then
			local jobDisplayName = JOBS_TO_LOG[userJob].DISPLAY_NAME
			PerformHttpRequest(JOBS_TO_LOG[userJob].WEBHOOK_URL, function(err, text, headers)
				if text then
					print(text)
				end
			end, "POST", json.encode({
				embeds = {
					{
						author = {
							name = 'Clocked out'
						},

						fields = {
							{
								name = "Identifier 1",
								value = steamIdent,
								inline = true
							},
							{
								name = "Identifier 2",
								value = userName,
								inline = true
							},
							{
								name = "Identifier 3",
								value = steamName,
								inline = true
							},
							{
								name = "Department",
								value = jobDisplayName,
								inline = true
							},
							{
								name = "Reason",
								value = 'Went to sleep',
								inline = true
							},
						},

						footer = {
							text = os.date('%m-%d-%Y %H:%M:%S', os.time()) .. ' PST'
						}
					}
				},
			}), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
		end
	end
end

-- end util functions / start commands

TriggerEvent('es:addCommand', 'discord', function(source, args, char)
	TriggerClientEvent("chatMessage", source, "", {255, 255, 255}, "Discord: https://discord.gg/usarrp")
	TriggerClientEvent("chatMessage", source, "", {255, 255, 255}, "^3Join the discord channel to keep up with the community! If that link doesn't work, visit the website.")
end, {help = "View the server's discord link."})

------------------------
-- Feedback Command --
------------------------
local hasUsedCommand = {}
TriggerEvent('es:addCommand','feedback', function(source, args, char, message)
	local WEBHOOK_URL = GetConvar("feedback-webhook", "")
	local char = exports["usa-characters"]:GetCharacter(source)
	local char_name = char.getFullName()
	table.remove(args, 1)
	local message = table.concat(args, ' ')
	local msg = "**Server ID:** "..source.."\n**Steam Name:** "..GetPlayerName(source).."\n**Steam ID:** "..GetPlayerIdentifiers(source)[1].."\n**Character Name:** "..char_name.."\n**Character Playtime:** "..FormatSeconds(char.get("ingameTime")).." \n**Feedback:** "..message.."\n"

	if not hasUsedCommand[source] then
		exports.globals:SendDiscordLog(WEBHOOK_URL, msg)
		TriggerClientEvent("usa:notify", source, "Your feedback has been sent!")
		hasUsedCommand[source] = true
	else
		TriggerClientEvent("usa:notify", source, "You can only send feedback once every restart.")
	end
end, {
	help = "Submit feedback to the server staff.",
	params = {
		{ name = "message", help = "Feedback to send to staff." }
	}
})

function FormatSeconds(mins)
	local output = ""
	local days = math.floor(mins / 1440)
	local remainder = mins % 1440
	local hours = math.floor(remainder / 60)
	local mins = remainder % 60
	if days ~= 0 then
		output = days .. " Days"
	end
	if output ~= "" then
		output = output .. ", "
	end
	if hours ~= 0 then
		output = output .. hours .. " Hrs"
	end
	if output ~= "" then
		output = output .. ", "
	end
	output = output .. mins .. " Mins"
	return output
end