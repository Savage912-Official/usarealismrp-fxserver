local WHOLE_DAYS_TO_DELETE = 3
local DEFAULT_MONEY = 0
local DEFAULT_BANK = 5000
local MAX_DAILY_NEW_CHARS = 1

local createdCharCounts = {}

TriggerEvent('es:addCommand', 'swap', function(source, args, user)
	TriggerClientEvent("character:swap--check-distance", source)
end, { help = "Swap to another character (Must be at the clothing store or an owned property)." })


RegisterServerEvent("character:swapChar")
AddEventHandler("character:swapChar", function()
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(usource)
	local accountIdentifier = GetPlayerIdentifiers(usource)[1]
	char.set("lastRecordedLocation", GetEntityCoords(GetPlayerPed(usource)))
	exports["usa_rp2"]:handlePlayerDropDutyLog(char, GetPlayerName(usource), accountIdentifier)
	char.set("job", "civ")
	exports["usa-characters"]:SaveCurrentCharacter(usource, function()
		local steamID = GetPlayerIdentifiers(usource)[1]
		exports["usa-characters"]:LoadCharactersForSelection(steamID, function(characters)
			TriggerClientEvent("character:open", usource, 'home', characters)
		end)
	end)
end)

RegisterServerEvent("character:getCharactersAndOpenMenu")
AddEventHandler("character:getCharactersAndOpenMenu", function(menu, src)
	local usource = source
	if src then
		usource = src -- for when triggered from a server event (has no source)
	end
	exports["usa-characters"]:SaveCurrentCharacter(usource, function()
		local steamID = GetPlayerIdentifiers(usource)[1]
		exports["usa-characters"]:LoadCharactersForSelection(steamID, function(characters)
			TriggerClientEvent("character:open", usource, menu, characters)
		end)
	end)
end)

-- Creating a new character
RegisterServerEvent("character:new")
AddEventHandler("character:new", function(data)
	local usource = tonumber(source)
	local ident = GetPlayerIdentifiers(usource)[1]
	if createdCharCounts[ident] then 
		if createdCharCounts[ident] >= MAX_DAILY_NEW_CHARS then
			TriggerClientEvent("usa:notify", usource, "You've reached the daily new char limit!", "^0You've reached the daily new character limit!")
			return
		end
	else 
		createdCharCounts[ident] = 0
	end
	if IsValidInput(usource, data) then
		data = ValidateNameCapitlization(data)
		exports["usa-characters"]:CreateNewCharacter(usource, data, function()
			createdCharCounts[ident] = createdCharCounts[ident] + 1
			TriggerEvent("character:getCharactersAndOpenMenu", "home", usource)
		end)
	end
end)

RegisterServerEvent("character:delete")
AddEventHandler("character:delete", function(data)
	-- todo: make sure calling client actually owns a character with provided data.id to prevent deleting other players' chars
	local usource = source
	local id = data.id
	local rev = data.rev
	local createdTime = data.createdTime
	local characterAge = getWholeDaysFromTime(createdTime)
	if characterAge >= 3 then
		DeleteCharacterById(id, rev, function()
			print("Done deleting character with id: " .. id .. ".")
			TriggerEvent("usa-properties-og:server:resetcharproperties", id)
			TriggerEvent("usa-businesses:server:resetcharbusinesses", id)
			TriggerEvent("character:getCharactersAndOpenMenu", "home", usource)
		end)
	else
		print("Error: Can't delete a character whose age is less than " .. WHOLE_DAYS_TO_DELETE .. "!")
		TriggerClientEvent('chatMessage', usource, "Error", { 255, 50, 50 }, "Can't delete a character whose age is less than " .. WHOLE_DAYS_TO_DELETE .. " days!")
		TriggerClientEvent("usa:notify", usource, "Must be 3 days old to delete")
		TriggerEvent("character:getCharactersAndOpenMenu", "home", usource)
	end
end)

RegisterServerEvent("character:loadCharacter")
AddEventHandler("character:loadCharacter", function(id)
	TriggerClientEvent('chat:removeSuggestionAll', source)
	local user = exports["essentialmode"]:getPlayerFromId(source)
	if user then
		-- set commands --
		local myGroup = user.getGroup()
		for k,v in pairs(exports['essentialmode']:getCommands()) do
			if v.job == "everyone" and exports['essentialmode']:CanGroupTarget(myGroup, v.group) then
				TriggerClientEvent('chat:addSuggestion', source, '/' .. k, v.help, v.params)
			end
		end
		-- initialize character --
		exports["usa-characters"]:InitializeCharacter(source, id)
	end
end)

function getWholeDaysFromTime(time)
	local reference = time
	local daysfrom = os.difftime(os.time(), reference) / (24 * 60 * 60) -- seconds in a day
	local wholedays = math.floor(daysfrom)
	print("wholedays = " .. wholedays) -- today it prints "1"
	return wholedays
end

RegisterServerEvent('character:disconnect')
AddEventHandler('character:disconnect', function()
	DropPlayer(source, "Disconnected at character selection.")
end)

RegisterServerEvent('spawn:getCharLastLocation')
AddEventHandler('spawn:getCharLastLocation', function(charID)
	local src = source
	TriggerEvent('es:exposeDBFunctions', function(db)
		db.getDocumentById("characters", charID, function(doc)
			if doc then
				TriggerClientEvent("character:send-nui-message", src, {
					type = "gotCharLastLocation",
					coords = doc.lastRecordedLocation
				})
			end
		end)
	end)
end)

function SaveLastLocationWithRetry(src, coords)
	local c = exports["usa-characters"]:GetCharacter(src)
	TriggerEvent('es:exposeDBFunctions', function(db)
		db.updateDocument("characters", c.get("_id"), { lastRecordedLocation = coords }, function(doc, err, rtext) print("location updated in db, err: " .. err)
			if err == 409 then
				print("was 409! trying again...")
				SaveLastLocationWithRetry(src, coords)
			else
				print("done!")
			end
		end)
	end)
end

RegisterServerEvent('spawn:setCharLastLocation')
AddEventHandler('spawn:setCharLastLocation', function(coords)
	SaveLastLocationWithRetry(source, coords)
end)

RegisterServerEvent("spawn:loadCustomizations")
AddEventHandler("spawn:loadCustomizations", function(tats)
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(usource)
	TriggerEvent("es:exposeDBFunctions", function(db)
		db.getDocumentById("character-appearance", char.get("_id"), function(doc)
			if doc ~= false then
				local customizations = {
					headBlend = doc.headBlend,
					faceFeatures = doc.faceFeatures,
					headOverlays = doc.headOverlays,
					hair = doc.hair,
					eyeColor = doc.eyeColor,
					tattoos = doc.tattoos
				}
				TriggerClientEvent("spawn:loadCustomizations", usource, customizations, false)
			end
		end)
	end)
end)

function DeleteCharacterById(id, rev, cb)
	PerformHttpRequest("http://127.0.0.1:5984/characters/".. id .."?rev=".. rev, function(err, rText, headers)
		if err == 0 then
			RconPrint("\nrText = " .. rText)
			RconPrint("\nerr = " .. err)
		else
			cb()
		end
	end, "DELETE", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

function ContainsVowel(word)
	local vowels = {'a', 'e', 'i', 'o', 'u', 'y'}
	for i = 1, #vowels do
		if string.find(string.lower(word), vowels[i]) then
			return true
		end
	end
	return false
end

function ContainsSpecialCharacters(word)
	local SPECIAL_CHARS = {"!", "@", "#", "&", "*", "`", ":", ";", '"', "|", ">", "<", "?", "/", "=", "+", "_", '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'}
	for i = 1, #SPECIAL_CHARS do
		if string.find(word, SPECIAL_CHARS[i]) then
			return true
		end
	end
	return false
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function IsValidInput(src, data)
	local firstName = string.lower(data.name.first)
	local middleName = string.lower(data.name.middle)
	local lastName = string.lower(data.name.last)
	for i = 1, #BLACKLISTED_WORDS do
		local BLACKLISTED_WORD = BLACKLISTED_WORDS[i]
		if string.find(firstName, BLACKLISTED_WORD) or string.find(middleName, BLACKLISTED_WORD) or string.find(lastName, BLACKLISTED_WORD) then
			TriggerClientEvent('chatMessage', src, '^1^*[ERROR]^r^0 The character data provided is invalid or inappropriate! (1) '..BLACKLISTED_WORD)
			TriggerClientEvent("usa:notify", src, "The character data provided is invalid or inappropriate!")
			print('Character name contained forbidden words: '..firstName..' '..middleName..' '..lastName)
			return false
		end
	end
	if not ContainsVowel(firstName) or not ContainsVowel(lastName) then
		TriggerClientEvent('chatMessage', src, '^1^*[ERROR]^r^0 The character data provided is invalid or inappropriate! (2)')
		TriggerClientEvent("usa:notify", src, "The character data provided is invalid or inappropriate!")
		print('Character name did not contain a vowel: '..firstName..' '..middleName..' '..lastName)
		return false
	end
	if string.len(firstName) < 3 or string.len(lastName) < 3 then
		TriggerClientEvent('chatMessage', src, '^1^*[ERROR]^r^0 The character data provided is invalid or inappropriate! (3)')
		TriggerClientEvent("usa:notify", src, "The character data provided is invalid or inappropriate!")
		print('Character name was insufficient length: '..firstName..' '..middleName..' '..lastName)
		return false
	end
	if string.len(firstName) > 16 or (string.len(middleName) > 16 and middleName ~= '') or string.len(lastName) > 16 then
		TriggerClientEvent('chatMessage', src, '^1^*[ERROR]^r^0 The character data provided is invalid or inappropriate! (4)')
		TriggerClientEvent("usa:notify", src, "The character data provided is invalid or inappropriate!")
		print('Character name was insufficient length: '..firstName..' '..middleName..' '..lastName)
		return false
	end
	local dob_year = tonumber(string.sub(data.dateOfBirth, 1, 4))
	local now = os.date("*t", os.time())
	now.year = tonumber(now.year)
	if dob_year < 1915 or now.year - dob_year < 18 then
		TriggerClientEvent('chatMessage', src, '^1^*[ERROR]^r^0 The character data provided is invalid or inappropriate! (5)')
		TriggerClientEvent("usa:notify", src, "The character data provided is invalid or inappropriate!")
		print('Character date of birth was invalid: '..data.dateOfBirth)
		return false
	end
	if ContainsSpecialCharacters(firstName) or (ContainsSpecialCharacters(middleName) and middleName ~= '') or ContainsSpecialCharacters(lastName) then
		TriggerClientEvent('chatMessage', src, '^1^*[ERROR]^r^0 The character data provided is invalid or inappropriate! (6)')
		TriggerClientEvent("usa:notify", src, "The character data provided is invalid or inappropriate!")
		print('Character name contained special characters: '..firstName..' '..middleName..' '..lastName)
		return false
	end
	return true
end

function ValidateNameCapitlization(data)
	data.name.first = firstToUpper(data.name.first)
	data.name.middle = firstToUpper(data.name.middle)
	data.name.last = firstToUpper(data.name.last)
	return data
end
