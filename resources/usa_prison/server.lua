local DB_NAME = "correctionaldepartment"

exports.globals:PerformDBCheck("usa_prison", DB_NAME)

local WEAPONS = {
	{ hash = "WEAPON_NIGHTSTICK", type = "weapon", name = "Nightstick", rank = 1, weight = 4, price = 50},
    { hash = "WEAPON_FLASHLIGHT", type = "weapon", name = "Flashlight", rank = 1, weight = 4, price = 50},
    { hash = GetHashKey("WEAPON_STUNGUN"), type = "weapon", name = "Stun Gun", rank = 1, weight = 5, price = 200},
    { hash = 1593441988, type = "weapon", name = "Glock", rank = 1, weight = 5, price = 200},
	{ name = "Heavy Pistol", type = "weapon", hash = GetHashKey("WEAPON_HEAVYPISTOL"), rank = 1, price = 400, weight = 7 },
	{ hash = -1600701090, type = "weapon", name = "Tear Gas", rank = 2, weight = 3, price = 150},
	{ name = "SMG", type = "weapon", hash = 736523883, rank = 2, price = 500, weight = 10 },
	{ name = "MK2 Pump Shotgun", type = "weapon", hash = 1432025498, rank = 2, price = 500, weight = 25 },
	{ name = "MK2 Carbine Rifle", type = "weapon", hash = 4208062921, rank = 2, price = 700, weight = 15},
	{ name = "Carbine Rifle", type = "weapon", hash = -2084633992, rank = 3, price = 1000, weight = 15},
	{ name = "SMG MK2", type = "weapon", hash = 0x78A97CD0, price = 750, rank = 2, weight = 20 },
	{ name = "Sniper Rifle", type = "weapon", hash = 100416529, rank = 2, weight = 30, price = 2000},
	{ name = "Spike Strips", type = "misc", rank = 4 },
    { name = "Police Radio", type = "misc", rank = 1, weight = 5, price = 300 },
	{ name = "7.62mm Bullets", type = "ammo", price = 50, weight = 0.5, quantity = 10 },
	{ name = "Empty 7.62mm Mag [10]", type = "magazine", price = 50, weight = 3, receives = "7.62mm", MAX_CAPACITY = 10, currentCapacity = 0 },
	{ name = "9mm Bullets", type = "ammo", price = 50, weight = 0.5, quantity = 15 },
	{ name = ".45 Bullets", type = "ammo", price = 50, weight = 0.5, quantity = 18 },
	{ name = "Empty .45 Mag [18]", type = "magazine", price = 50, weight = 3, receives = ".45", MAX_CAPACITY = 18, currentCapacity = 0 },
    { name = "Empty 9mm Mag [12]", type = "magazine", price = 50, weight = 3, receives = "9mm", MAX_CAPACITY = 12, currentCapacity = 0 },
    { name = "Empty 9mm Mag [30]", type = "magazine", price = 50, weight = 3, receives = "9mm", MAX_CAPACITY = 30, currentCapacity = 0 },
	{ name = "5.56mm Bullets", type = "ammo", price = 50, weight = 0.5, quantity = 30 },
    { name = "Empty 5.56mm Mag [30]", type = "magazine", price = 50, weight = 3, receives = "5.56mm", MAX_CAPACITY = 30, currentCapacity = 0 },
	{ name = "12 Gauge Shells", type = "ammo", price = 50, weight = 0.5, quantity = 10 },
	{ name = "Taser Cartridge", type = "ammo", price = 50, weight = 0.25, quantity = 1 },
    { name = "Flashbang", type = "weapon", hash = GetHashKey("WEAPON_FLASHBANG"), price = 150, weight = 2, rank = 5 }
}

for i = 1, #WEAPONS do
	WEAPONS[i].legality = "legal"
	if WEAPONS[i].type == "weapon" then
		WEAPONS[i].serviceWeapon = true
		WEAPONS[i].notStackable = true
	end
	if WEAPONS[i].type == "magazine" then
        WEAPONS[i].notStackable = true
    end
	if not WEAPONS[i].quantity then
		WEAPONS[i].quantity = 1
	end
end

local function GetWeaponAttachments(name)
    local attachments = {}
    if name == "MK2 Carbine Rifle" then
        table.insert(attachments, 'COMPONENT_AT_SIGHTS')
        table.insert(attachments, 'COMPONENT_AT_AR_FLSH')
        table.insert(attachments, 'COMPONENT_AT_AR_AFGRIP_02')
        --table.insert(attachments, 'COMPONENT_CARBINERIFLE_MK2_CLIP_FMJ')
        table.insert(attachments, 'COMPONENT_AT_CR_BARREL_02')
        table.insert(attachments, 'COMPONENT_AT_MUZZLE_06')
    elseif name == "MK2 Pump Shotgun" then
        table.insert(attachments, 'COMPONENT_AT_SIGHTS')
        table.insert(attachments, 'COMPONENT_AT_AR_FLSH')
        --table.insert(attachments, 'COMPONENT_PUMPSHOTGUN_MK2_CLIP_HOLLOWPOINT')
    elseif name == "Glock" then
        table.insert(attachments, 0x359B7AAE)
    elseif name == "SMG MK2" then
        table.insert(attachments, "COMPONENT_AT_AR_FLSH")
        table.insert(attachments, "COMPONENT_AT_SIGHTS_SMG")
    end
    return attachments
end

RegisterServerEvent("doc:getWeapons")
AddEventHandler("doc:getWeapons", function()
	TriggerClientEvent("doc:getWeapons", source, WEAPONS)
end)

-- Check inmates remaining jail time --
TriggerEvent('es:addJobCommand', 'roster', {"sheriff", "corrections", "da", "judge"}, function(source, args, char)
	local hasInmates = false
	TriggerClientEvent('chatMessage', source, "", {255, 255, 255}, "^1^*[BOLINGBROKE PENITENTIARY]")
	exports["usa-characters"]:GetCharacters(function(characters)
		for id, char in pairs(characters) do
			local time = char.get("jailTime")
			if time then
				if time > 0 then
					hasInmates = true
					TriggerClientEvent('chatMessage', source, "", {255, 255, 255}, "^1 - ^0" .. char.getFullName() .. " ^1^*|^r^0 " .. time .. " month(s)")
				end
			end
		end
		if not hasInmates then
			TriggerClientEvent('chatMessage', source, "", {255, 255, 255}, "^1 - ^0There are no inmates at this time")
		end
	end)
end, {
	help = "See who is booked into the prison."
})

----------------
-- the prison --
----------------
local cellblockOpen = false

TriggerEvent('es:addJobCommand', 'c', {"corrections"}, function(source, args, char)
	cellblockOpen = not cellblockOpen
	print("cellblock is now: " .. tostring(cellblockOpen))
	TriggerClientEvent('toggleJailDoors', -1, cellblockOpen)
end)

RegisterServerEvent("jail:checkJobForWarp")
AddEventHandler("jail:checkJobForWarp", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get("job")
	if job == "sheriff" or job == "ems" or job == "fire" or job == "corrections" or job == "doctor" then
		TriggerClientEvent("jail:continueWarp", source)
	else
		TriggerClientEvent("usa:notify", source, "That area is prohibited!")
	end
end)

RegisterServerEvent("doc:checkWhitelist")
AddEventHandler("doc:checkWhitelist", function(loc)
	local char = exports["usa-characters"]:GetCharacter(source)
	if char.get("bcsoRank") > 0 then
		TriggerClientEvent("doc:open", source, loc)
	else
		TriggerClientEvent("usa:notify", source, "~y~You are not whitelisted for BCSO. Apply at https://www.usarrp.gg.")
	end
end)

RegisterServerEvent("doc:offduty")
AddEventHandler("doc:offduty", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get("job")
	-------------------------
	-- put back to civ job --
	-------------------------
	if job == "corrections" then
		TriggerEvent('job:sendNewLog', source, "corrections", false)
	end
	--exports["usa_ems"]:RemoveServiceWeapons(char)
	char.set("job", "civ")
	TriggerClientEvent("usa:notify", source, "You have clocked out!")
	TriggerEvent("eblips:remove", source)
	TriggerClientEvent("interaction:setPlayersJob", source, "civ")
	local playerWeapons = char.getWeapons()
	local appearance = char.get("appearance")
	TriggerClientEvent("doc:setciv", source, appearance, playerWeapons)
	-----------------------------------
	-- change back into civ clothing --
	-----------------------------------
	--print("closing DOC menu!")
	TriggerClientEvent("doc:close", source)
	TriggerClientEvent("ptt:isEmergency", source, false)
	TriggerClientEvent("radio:unsubscribe", source)
end)

RegisterServerEvent("doc:forceDuty")
AddEventHandler("doc:forceDuty", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get("job")
	if job ~= "corrections" then
		----------------------------
		-- set to corrections job --
		----------------------------
		char.set("job", "corrections")
		TriggerEvent("doc:loadUniform", 1, source)
		TriggerClientEvent("usa:notify", source, "You have clocked in!")
		TriggerEvent('job:sendNewLog', source, "corrections", true)
		TriggerClientEvent("ptt:isEmergency", source, true)
		TriggerClientEvent("interaction:setPlayersJob", source, "corrections")
		TriggerEvent("eblips:add", {name = char.getName(), src = source, color = 82})
	end
end)

RegisterServerEvent("doc:saveOutfit")
AddEventHandler("doc:saveOutfit", function(uniform, slot)
	local usource = source
	local player_identifer = GetPlayerIdentifiers(usource)[1]
	TriggerEvent('es:exposeDBFunctions', function(db)
		db.getDocumentByRow(DB_NAME, "identifier" , player_identifer, function(result)
			if type(result) ~= "boolean" then
				db.getDocumentByRow(DB_NAME, "identifier" , player_identifer, function(result)
					local uniforms = result.uniform or {}
					uniforms[tostring(slot)] = uniform
					db.updateDocument(DB_NAME, result._id, {uniform = uniforms}, function()
						TriggerClientEvent("usa:notify", usource, "Uniform saved!")
					end)
				end)
			else
				local target = exports["usa-characters"]:GetCharacter(tonumber(usource))
				local uniforms = {}
				uniforms[tostring(slot)] = uniform
				local employee = {
					identifier = player_identifer,
					name = target.getFullName(),
					uniform = uniforms,
				}
				db.createDocument("correctionaldepartment", employee, function()
					print("new co created in db")
				end)
				TriggerClientEvent("usa:notify", usource, "Uniform saved!")
			end
		end)	
	end)
end)

RegisterServerEvent("doc:loadOutfit")
AddEventHandler("doc:loadOutfit", function(slot, id)
	if id then source = id end
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(usource)
	local job = char.get("job")
	local player_identifer = GetPlayerIdentifiers(usource)[1]
	if job ~= "corrections" then
		char.set("job", "corrections")
		TriggerEvent('job:sendNewLog', source, "corrections", true)
		TriggerClientEvent("usa:notify", usource, "You have clocked in!")
		TriggerClientEvent("ptt:isEmergency", usource, true)
		TriggerClientEvent("interaction:setPlayersJob", usource, "corrections")
		TriggerEvent("eblips:add", {name = char.getName(), src = usource, color = 82})
	end
	TriggerEvent('es:exposeDBFunctions', function(usersTable)
		usersTable.getDocumentByRow(DB_NAME, "identifier" , player_identifer, function(result)
			if result and result.uniform then
				TriggerClientEvent("doc:uniformLoaded", usource, result.uniform[tostring(slot)] or nil)
			end
		end)
	end)
end)

RegisterServerEvent("doc:spawnVehicle")
AddEventHandler("doc:spawnVehicle", function(veh)
	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get("job")
	if job == "corrections" then
		TriggerClientEvent("doc:spawnVehicle", source, veh)
	else
		TriggerClientEvent("usa:notify", source, "You are not on-duty!")
	end
end)

-- weapon rank check --
RegisterServerEvent("doc:checkRankForWeapon")
AddEventHandler("doc:checkRankForWeapon", function(weapon)
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(usource)
	local job = char.get("job")
	if job == "corrections" then
		weapon.rank = (weapon.rank or 1)
		if char.get("bcsoRank") >= weapon.rank then
			if weapon.name == "Spike Strips" then
				TriggerEvent("spikestrips:equip", true, usource)
			else
				if char.canHoldItem(weapon) then
					if char.get("money") < weapon.price then
						TriggerClientEvent("usa:notify", usource, "Not enough money!")
						return
					end
					char.removeMoney(weapon.price)
					weapon.serialNumber = exports.globals:generateID()
					weapon.uuid = weapon.serialNumber
					weapon.components = GetWeaponAttachments(weapon.name)
					TriggerClientEvent("doc:equipWeapon", usource, weapon)
					char.giveItem(weapon)
					local weaponDB = {}
					weaponDB.name = weapon.name
					weaponDB.serialNumber = weapon.uuid
					weaponDB.ownerName = char.getFullName()
					weaponDB.ownerDOB = char.get('dateOfBirth')
					local timestamp = os.date("*t", os.time())
					weaponDB.issueDate = timestamp.month .. "/" .. timestamp.day .. "/" .. timestamp.year
					TriggerEvent('es:exposeDBFunctions', function(db)
					db.createDocumentWithId("legalweapons", weaponDB, weaponDB.serialNumber, function(success)
						if success then
							print("* Weapon created serial["..weaponDB.serialNumber.."] name["..weaponDB.name.."] owner["..weaponDB.ownerName.."] *")
						else
							print("* Error: Weapon failed to be created!! *")
						end
					end)
					end)
				else
					TriggerClientEvent("usa:notify", usource, "Inventory full!")
				end
			end
		else
			TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
		end
	else
		TriggerClientEvent("usa:notify", usource, "You are not on-duty!")
	end
end)

RegisterServerEvent("prison:retrieveItems")
AddEventHandler("prison:retrieveItems", function()
	print("retrieving items!")
	local src = source
	local char = exports["usa-characters"]:GetCharacter(src)
	char.dropAllItems("license")
	local charid = char.get("_id")
	TriggerEvent('es:exposeDBFunctions', function(db)
		db.getDocumentById("prisonitemstorage", charid, function(inv)
			if not inv then
				print("error")
			else
				for i = 0, inv.inventory.MAX_CAPACITY do
					i = tostring(i)
					if inv.inventory.items[i] then
						char.giveItem(inv.inventory.items[i])
						inv.inventory.items[i] = nil
					end
				end
				TriggerClientEvent("usa:notify", src, "Here are your belongings back! Stay out of trouble!")
				db.deleteDocument("prisonitemstorage", charid, function(ok) end)
			end
		end)
	end)
end)

RegisterServerCallback {
	eventName = "jail:isInPrison",
	eventCallback = function(source)
		local char = exports["usa-characters"]:GetCharacter(source)
		return char.get("jailTime") > 0
	end
}