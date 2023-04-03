local adCost = 200
local anonAdCost = 800

local jobNames = {
	['civ'] = false,
	['taxi'] = 'Taxi',
	['mechanic'] = 'Mechanic',
	['sheriff'] = 'Peace Officer (SASP)',
	['da'] = 'District Attorney',
	['ems'] = 'Medical Responder (LSFD)',
	['doctor'] = 'Doctor',
	['corrections'] = 'Peace Officer (BCSO)',
	['lawyer'] = 'Attorney',
	['judge'] = 'Judge',
	['CatCafeEmployee'] = 'Cat Cafe Employee'
}

TriggerEvent('es:addCommand', 'ad', function(source, args, char)
	if not (args[2] == nil) then
		if char.get("money") >= adCost then
			local sender = char.getName()
			if char.hasItem("Cell Phone") then
				table.remove(args, 1)
				char.removeMoney(adCost)
				exports["usa-characters"]:GetCharacters(function(characters)
					for id, char in pairs(characters) do
						if char.hasItem("Cell Phone") then
							TriggerClientEvent('chatMessage', id, "[Advertisement] - " .. sender, {171, 67, 227}, table.concat(args, " "))
						end
					end
				end)
			else
				TriggerClientEvent('usa:notify', source, 'You do not have a cell phone!')
			end
		else
			TriggerClientEvent('usa:notify',source, 'You do not have enough money!')
		end
	else
		TriggerClientEvent('usa:notify',source, 'Please make sure to include a message!')
	end
end, {help = "Send an advertisement ($".. adCost ..").", params = {{name = "message", help = "the advertisement"}}})

local lastAnonAdAuthor = nil
TriggerEvent('es:addCommand', 'anonad', function(source, args, char)
	if not (args[2] == nil) then
		if char.get("money") >= anonAdCost then
			if char.hasItem("Cell Phone") then
				table.remove(args, 1) -- remove "anonad"
				char.removeMoney(anonAdCost)
				lastAnonAdAuthor = "(#" .. source .. ") " .. char.getFullName()
				exports["usa-characters"]:GetCharacters(function(characters)
					for id, char in pairs(characters) do
						if char.hasItem("Cell Phone") then
							TriggerClientEvent('chatMessage', id, "[Advertisement]", {171, 67, 227}, table.concat(args, " "))
						end
					end
				end)
			else
				TriggerClientEvent('usa:notify', source, 'You do not have a cell phone!')
			end
		else
			TriggerClientEvent("usa:notify", source, "You don't have enough money!")
		end
	else
		TriggerClientEvent('usa:notify',source, 'Please make sure to include a message!')
	end
end, {help = "Send an anonymous advertisement ($".. anonAdCost ..")", params = {{name = "message", help = "the advertisement"}}})

TriggerEvent('es:addGroupCommand', 'lastanonad', 'mod', function(source, args, char)
	if lastAnonAdAuthor then
		TriggerClientEvent('chatMessage', source, "SYSTEM", {171, 67, 227}, "The last anon ad was sent by: " .. lastAnonAdAuthor)
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {171, 67, 227}, "There is no last anon ad author recorded.")
	end
end, {
	help = "Find out who sent the last anonymous advertisement"
})

TriggerEvent('es:addCommand', 'me', function(source, args, char, location)
	table.remove(args,1)
	local msg = table.concat(args, " ")
	TriggerEvent('display:shareDisplayBySource', source, msg, 5, 370, 10, 8000, true)
	exports["globals"]:sendLocalActionMessageChat("Person with SSN " .. source .. " " .. msg, location, 20)
	TriggerEvent('rcore_cam:me', source, msg)
end, {help = "Talk as yourself doing an action.", params = {{name = "message", help = "the action"}}})

TriggerEvent('es:addCommand', 'showid', function(source, args, char, location)
	showid(source, char, location)
end, {help = "Present your identification card / DL."})

TriggerEvent('es:addJobCommand', 'fakeid', {'sheriff', 'corrections'}, function(source, args, char, location)
	local job = char.get("job")
	if char.get("policeRank") < 4 and (job == "sheriff" or job == "police") then
		TriggerClientEvent("usa:notify", source, "Not high enough rank!")
		return
	elseif char.get("bcsoRank") < 5 and job == 'corrections' then
		TriggerClientEvent("usa:notify", source, "Not high enough rank!")
		return
	end

	if args[2] and args[3] and args[4] and args[5] and args[6] then
		local fullName = args[2] ..' '.. args[3]
		local dob = args[4] ..'-'.. args[5] ..'-'.. args[6]
		exports["globals"]:sendLocalActionMessage(source, "shows ID")
		local msg = "^4^*[STATE ID]^0 Name: ^r" .. fullName .. " ^4^*|^0 SSN: ^r" .. source .. " ^4^*| ^0DOB: ^r" .. dob
		exports["globals"]:sendLocalActionMessageChat(msg, location)
	end
end, {
	help = "Present a fake identification card",
	params = {
		{ name = "first name", help = "first name to show on ID" },
		{ name = "last name", help = "last name to show on ID" },
		{ name = "dob year", help = "date of birth year to show on ID" },
		{ name = "dob month", help = "date of birth month to show on ID" },
		{ name = "dob day", help = "date of birth day to show on ID" }
	}
})

-- TriggerEvent('es:addJobCommand', 'faketweet', {'sheriff'}, function(source, args, char, location)
-- 	local job = char.get("job")
-- 	if char.get("policeRank") < 4 and (job == "sheriff" or job == "police") then
-- 		TriggerClientEvent("usa:notify", source, "Not high enough rank!")
-- 		return
-- 	end
-- 	local name = "@" .. args[2] .. "_" .. args[3]
-- 	name = string.lower(name)
-- 	table.remove(args, 1)
-- 	table.remove(args, 1)
-- 	table.remove(args, 1)
-- 	local msg = table.concat(args, " ")
-- 	exports["usa-characters"]:GetCharacters(function(characters)
-- 		for id, char in pairs(characters) do
-- 			if char.hasItem("Cell Phone") then
-- 				TriggerClientEvent('chatMessage', id, "[TWEET] - " .. name, {29,161,242}, msg)
-- 			end
-- 		end
-- 	end)
-- 	TriggerEvent("chat:sendToLogFile", source, "[TWEET] - " .. name .. ": " .. msg)
-- end, {
-- 	help = "Send a fake tweet",
-- 	params = {
-- 		{ name = "first name", help = "first name to show on tweet" },
-- 		{ name = "last name", help = "last name to show on tweet" },
-- 	}
-- })

TriggerEvent('es:addJobCommand', 'fakead', {'sheriff', 'corrections'}, function(source, args, char, location)
	local job = char.get("job")
	if char.get("policeRank") < 4 and (job == "sheriff" or job == "police") then
		TriggerClientEvent("usa:notify", source, "Not high enough rank!")
		return
	elseif char.get("bcsoRank") < 5 and job == 'corrections' then
		TriggerClientEvent("usa:notify", source, "Not high enough rank!")
		return
	end
	local name = args[2] .. " " .. args[3]
	table.remove(args, 1)
	table.remove(args, 1)
	table.remove(args, 1)
	local msg = table.concat(args, " ")
	exports["usa-characters"]:GetCharacters(function(characters)
		for id, char in pairs(characters) do
			if char.hasItem("Cell Phone") then
				TriggerClientEvent('chatMessage', id, "[Advertisement] - " .. name, {171, 67, 227}, msg)
			end
		end
	end)
end, {
	help = "Send a fake advertisement",
	params = {
		{ name = "first name", help = "first name to show on ad" },
		{ name = "last name", help = "last name to show on ad" },
		{ name = "message", help = "the advertisement message" }
	}
})

TriggerEvent('es:addCommand', 'id', function(source, args, char, location)
	showid(source, char, location)
end, {help = "Present your identification card / DL."})

RegisterServerEvent("altchat:showID")
AddEventHandler("altchat:showID", function(location)
	local char = exports["usa-characters"]:GetCharacter(source)
	showid(source, char, location)
end)

function showid(src, u, location)
	local job = u.get("job")
	local employer = nil
	if job == 'corrections' then
		if u.get("bcsoRank") > 2 then
            employer = jobNames[job]
        else
        	employer = 'Correctional Officer (BCSO)'
        end
		while employer == nil do
			Wait(0)
		end
	else
		employer = jobNames[job]
	end
	local char_name = u.getFullName()
	local dob = u.get("dateOfBirth")
	exports["globals"]:sendLocalActionMessage(src, "shows ID")
	local msg = "^4^*[STATE ID]^0 Name: ^r" .. char_name .. " ^4^*|^0 SSN: ^r" .. src .. " ^4^*| ^0DOB: ^r" .. dob
	if employer then msg = "^4^*[STATE ID]^0 Name: ^r" .. char_name .. " ^4^*|^0 SSN: ^r" .. src .. " ^4^*| ^0DOB: ^r" .. dob .. " ^4^*| ^0Employer: ^r".. employer end
	exports["globals"]:sendLocalActionMessageChat(msg, location)
end

function GetIdString(src, u)
	local job = u.get("job")
	local employer = jobNames[job]
	local char_name = u.getFullName()
	local dob = u.get("dateOfBirth")
	local msg = "^4^*[ID]^0 Name: ^r" .. char_name .. " ^4^*|^0 SSN: ^r" .. src .. " ^4^*| ^0DOB: ^r" .. dob
	if employer then msg = "^4^*[ID]^0 Name: ^r" .. char_name .. " ^4^*|^0 SSN: ^r" .. src .. " ^4^*| ^0DOB: ^r" .. dob .. " ^4^*| ^0Employer: ^r".. employer end
	return msg
end