local DB_NAME = "sasp-outfits"

exports.globals:PerformDBCheck("usa_police", DB_NAME)

local JOB_NAME = "sheriff"

local armoryItems = {
    { name = "First Aid Kit", price = 25, weight = 5 },
    { name = "Fire Extinguisher", type = "weapon", hash = 101631238, price = 100, weight = 20 },
    { name = "Flare", type = "weapon", hash = 1233104067, price = 200, weight = 5 },
    { name = "Tear Gas", type = "weapon", hash = -1600701090, price = 300, weight = 3, minRank = 2 },
    { name = "Flashlight", type = "weapon", hash = -1951375401, price = 25, weight = 4 },
    { name = "Nightstick", type = "weapon", hash = 1737195953, price = 100, weight = 4 },
    { name = "Glock", type = "weapon", hash = 1593441988, price = 300, weight = 5 },
    { name = "Heavy Pistol", type = "weapon", hash = GetHashKey("WEAPON_HEAVYPISTOL"), price = 450, weight = 7 },
    { name = "Stun Gun", type = "weapon", hash = 911657153, price = 400, weight = 5 },
    { name = "SMG", type = "weapon", hash = 736523883, price = 750, weight = 10, minRank = 3 },
    { name = "MK2", type = "weapon", hash = -1075685676, price = 400, weight = 5, minRank = 2 },
    { name = "MK2 Pump Shotgun", type = "weapon", hash = 1432025498, price = 700, weight = 25 },
    { name = "MK2 Carbine Rifle", type = "weapon", hash = 4208062921, price = 700, weight = 15, minRank = 2 },
    { name = "Sniper Rifle", type = "weapon", hash = 100416529, price = 2000, weight = 30, minRank = 6 },
    { name = "Carbine Rifle", type = "weapon", hash = -2084633992, price = 1000, weight = 15, minRank = 3 },
    { name = "Beanbag Shotgun", type = "weapon", hash = GetHashKey("WEAPON_BEANBAGSHOTGUN"), price = 700, weight = 10 },
    { name = "Spike Strips", price = 700 },
    { name = "Police Radio", price = 300, type = "misc", weight = 5, notStackable = true },
    { name = "9mm Bullets", type = "ammo", price = 50, weight = 0.5, quantity = 15 },
    { name = ".45 Bullets", type = "ammo", price = 50, weight = 0.5, quantity = 18 },
    { name = "Empty .45 Mag [18]", type = "magazine", price = 50, weight = 3, receives = ".45", MAX_CAPACITY = 18, currentCapacity = 0 },
    { name = "Empty 9mm Mag [12]", type = "magazine", price = 50, weight = 3, receives = "9mm", MAX_CAPACITY = 12, currentCapacity = 0 },
    { name = "Empty 9mm Mag [30]", type = "magazine", price = 50, weight = 3, receives = "9mm", MAX_CAPACITY = 30, currentCapacity = 0 },
    { name = "12 Gauge Shells", type = "ammo", price = 50, weight = 0.5, quantity = 10 },
    { name = "7.62mm Bullets", type = "ammo", price = 50, weight = 0.5, quantity = 10 },
    { name = "Empty 7.62mm Mag [10]", type = "magazine", price = 50, weight = 3, receives = "7.62mm", MAX_CAPACITY = 10, currentCapacity = 0 },
    { name = "5.56mm Bullets", type = "ammo", price = 50, weight = 0.5, quantity = 30 },
    { name = "Empty 5.56mm Mag [30]", type = "magazine", price = 50, weight = 3, receives = "5.56mm", MAX_CAPACITY = 30, currentCapacity = 0 },
    { name = "Taser Cartridge", type = "ammo", price = 50, weight = 0.25, quantity = 1 },
    { name = "Beanbag Shell", type = "ammo", price = 50, weight = 0.5, quantity = 8, objectModel = "prop_ld_ammo_pack_02" },
    { name = "Flashbang", type = "weapon", hash = GetHashKey("WEAPON_FLASHBANG"), price = 150, weight = 2, minRank = 6 },
    { name = "Tint Meter", price = 50, weight = 2 },
    { name = "Battering Ram", type = "misc", price = 250, weight = 25, quantity = 1, serviceWeapon = true, notStackable = true},
}

for i = 1, #armoryItems do
	armoryItems[i].legality = "legal"
	if armoryItems[i].type == "weapon" then
		armoryItems[i].serviceWeapon = true
        armoryItems[i].notStackable = true
	end
    if armoryItems[i].type == "magazine" then
        armoryItems[i].notStackable = true
    end
	if not armoryItems[i].quantity then
		armoryItems[i].quantity = 1
	end
end

RegisterServerEvent("police:loadArmoryItems")
AddEventHandler("police:loadArmoryItems", function()
    TriggerClientEvent("police:loadArmoryItems", source, armoryItems)
end)

AddEventHandler('rconCommand', function(commandName, args)
    if commandName:lower() == 'whitelist' then
        local playerId = tonumber(table.remove(args, 1))
        local wl_type = table.remove(args, 1)
        local rank = tonumber(table.remove(args, 1)) -- 0 for unwhitelist, remove whitelist
        --RconPrint(type)
        if not playerId then
            RconPrint("\nYou must enter a player id!")
            CancelEvent()
            return
        elseif not GetPlayerName(playerId) then
            RconPrint("\nError: player with id #" .. playerId .. " does not exist!")
            CancelEvent()
            return
        elseif not wl_type then
            RconPrint("\nYou must enter a whitelist type: police, ems, doctor, corrections, da, judge or eventplanner")
            CancelEvent()
            return
        elseif not rank then
            RconPrint("\nYou must enter a rank for that player: 0 to un-whitelist. 1 is lowest rank, 10 is highest rank.")
            CancelEvent()
            return
        end

        if wl_type == "police" then
            local char = exports["usa-characters"]:GetCharacter(playerId)
            if rank > 0 then
                char.set("policeRank", rank)
                RconPrint("DEBUG: " .. playerId .. "'s police rank has been set to: " .. rank .. "!")
                TriggerClientEvent('chatMessage', tonumber(playerId), "CONSOLE", {255, 255, 255}, "You have been whitelisted for police, rank: " .. rank)
            else
                char.set("policeRank", 0)
                char.set("job", "civ")
                TriggerClientEvent("thirdEye:updateActionsForNewJob", playerId, "civ")
                RconPrint("DEBUG: " .. playerId .. " un-whitelisted as police.")
            end
        elseif wl_type == "ems" then
            local char = exports["usa-characters"]:GetCharacter(playerId)
            if rank > 0 then
                char.set("emsRank", rank)
                RconPrint("DEBUG: " .. playerId .. "'s EMS rank has been set to: " .. rank .. "!")
                TriggerClientEvent('chatMessage', tonumber(playerId), "CONSOLE", {255, 255, 255}, "You have been whitelisted for EMS, rank: " .. rank)
            else
                char.set("emsRank", 0)
                char.set("job", "civ")
                TriggerClientEvent("thirdEye:updateActionsForNewJob", playerId, "civ")
                RconPrint("DEBUG: " .. playerId .. " un-whitelisted as EMS.")
            end
        elseif wl_type == "doctor" then
            local char = exports["usa-characters"]:GetCharacter(playerId)
            if rank > 0 then
                char.set("doctorRank", rank)
                RconPrint("DEBUG: " .. playerId .. "'s Doctor rank has been set to: " .. rank .. "!")
                TriggerClientEvent('chatMessage', tonumber(playerId), "CONSOLE", {255, 255, 255}, "You have been whitelisted for Doctor, rank: " .. rank)
            else
                char.set("doctorRank", 0)
                char.set("job", "civ")
                TriggerClientEvent("thirdEye:updateActionsForNewJob", playerId, "civ")
                RconPrint("DEBUG: " .. playerId .. " un-whitelisted as Doctor.")
            end
        elseif wl_type == "da" then
            local char = exports["usa-characters"]:GetCharacter(playerId)
            if rank > 0 then
                char.set("daRank", rank)
                RconPrint("DEBUG: " .. playerId .. "'s DA rank has been set to: " .. rank .. "!")
                TriggerClientEvent('chatMessage', tonumber(playerId), "CONSOLE", {255, 255, 255}, "You have been whitelisted for da, rank: " .. rank)
            else
                char.set("daRank", 0)
                char.set("job", "civ")
                TriggerClientEvent("thirdEye:updateActionsForNewJob", playerId, "civ")
                RconPrint("DEBUG: " .. playerId .. " un-whitelisted as DA.")
            end
        elseif wl_type == "judge" then
            local char = exports["usa-characters"]:GetCharacter(playerId)
            if rank > 0 then
                char.set("judgeRank", rank)
                RconPrint("DEBUG: " .. playerId .. "'s judge rank has been set to: " .. rank .. "!")
                TriggerClientEvent('chatMessage', tonumber(playerId), "CONSOLE", {255, 255, 255}, "You have been whitelisted for judge, rank: " .. rank)
            else
                char.set("judgeRank", 0)
                char.set("job", "civ")
                TriggerClientEvent("thirdEye:updateActionsForNewJob", playerId, "civ")
                RconPrint("DEBUG: " .. playerId .. " un-whitelisted as judge.")
            end
        elseif wl_type == "realtor" then
            local char = exports["usa-characters"]:GetCharacter(playerId)
            if rank > 0 then
                char.set("realtorRank", rank)
                RconPrint("DEBUG: " .. playerId .. "'s realtor rank has been set to: " .. rank .. "!")
                TriggerClientEvent('chatMessage', tonumber(playerId), "CONSOLE", {255, 255, 255}, "You have been whitelisted for realtor, rank: " .. rank)
            else
                char.set("realtorRank", 0)
                char.set("job", "civ")
                TriggerClientEvent("thirdEye:updateActionsForNewJob", playerId, "civ")
                RconPrint("DEBUG: " .. playerId .. " un-whitelisted as realtor.")
            end
        elseif wl_type == "corrections" then
            local char = exports["usa-characters"]:GetCharacter(playerId)
            if rank > 0 then
                char.set("bcsoRank", rank)
                RconPrint("DEBUG: " .. playerId .. "'s BCSO rank has been set to: " .. rank .. "!")
                TriggerClientEvent('chatMessage', tonumber(playerId), "CONSOLE", {255, 255, 255}, "You have been whitelisted for BCSO, rank: " .. rank)
            else
                char.set("bcsoRank", 0)
                char.set("job", "civ")
                TriggerClientEvent("thirdEye:updateActionsForNewJob", playerId, "civ")
                RconPrint("DEBUG: " .. playerId .. " un-whitelisted from BCSO.")
            end
        elseif wl_type:lower() == "eventplanner" then
            local c = exports["usa-characters"]:GetCharacter(playerId)
            c.set("eventPlannerRank", rank)
            RconPrint("DEBUG: " .. playerId .. "'s event planner rank is now " .. rank)
        end
        CancelEvent()
    end
end)

TriggerEvent('es:addCommand', 'whitelist', function(source, args, char)
    if not args[2] then
        TriggerClientEvent("usa:notify", source, " You must enter a player id!")
        CancelEvent()
        return
    elseif not GetPlayerName(args[2]) then
        TriggerClientEvent("usa:notify", source, "Error: player with id #" .. args[2] .. " does not exist!")
        CancelEvent()
        return
    elseif not args[3] then
        TriggerClientEvent("usa:notify", source, "You must enter a whitelist type: police, ems, doctor, corrections or da")
        CancelEvent()
        return
    elseif not args[4] then
        TriggerClientEvent("usa:notify", source, "You must enter a rank for that player: 0 to un-whitelist. 1 is lowest rank, 10 is highest rank.")
        CancelEvent()
        return
    end
    local user = exports["essentialmode"]:getPlayerFromId(source)
    local user_group = user.getGroup()
    local user_rank = 0
    local playerId = tonumber(args[2])
    local type = string.lower(args[3])
    local rank = tonumber(args[4])
    local playerName = GetPlayerName(playerId)
    if type == "ems" then
        user_rank = tonumber(char.get("emsRank"))
    elseif type == "doctor" then
        user_rank = char.get("doctorRank")
        if (user_rank == nil) then
            user_rank = 0
        else
            user_rank = tonumber(user_rank)
        end 
    elseif type == "police" then
        user_rank = tonumber(char.get("policeRank"))
    elseif type == "corrections" then 
        user_rank = tonumber(char.get("bcsoRank"))
    elseif type == "da" then
        user_rank = char.get("daRank")
        if user_rank then
            user_rank = tonumber(user_rank)
        else
            user_rank = 0
        end
    else
        TriggerClientEvent("usa:notify", source, "That is not a valid whitelist please enter a valid type: police, ems, corrections or da")
        CancelEvent()
        return
    end

    if user_group == "admin" or user_group == "superadmin" or user_group == "owner" then
        user_rank = 999999 -- so admins can use /whitelist
    end

    if user_rank < 5 then
        TriggerClientEvent("usa:notify", source, "Error: must be ranked as 5 or above to set permissions!")
        return
    elseif rank > user_rank then
        print("Error: can't set a person's rank to something higher than your own!")
        TriggerClientEvent("usa:notify", source, "Error: can't set a person's rank to something higher than your own!")
        return
    elseif not playerName then
        print("Error: player with id #" .. playerId .. " does not exist!")
        TriggerClientEvent("usa:notify", source, "Error: player with id #" .. playerId .. " does not exist!")
        return
    elseif not type then
        print("You must enter a whitelist type: police, ems, doctor or da")
        TriggerClientEvent("usa:notify", source, "You must enter a whitelist type: police, corrections, ems, doctor or da")
        return
    elseif not rank then
        print("You must enter a whitelist status for that player: true or false")
        TriggerClientEvent("usa:notify", source, "You must enter a rank for that player: 0 to un-whitelist. 1 is lowest rank, 10 is highest rank.")
        return
    end
    local target = exports["usa-characters"]:GetCharacter(playerId)
    if rank > 0 then
        if type == "police" then
            target.set("policeRank", rank)
        elseif type == "corrections" then 
            target.set("bcsoRank", rank)
        elseif type == "ems" then
            target.set("emsRank", rank)
        elseif type == "doctor" then
            target.set("doctorRank", rank)
        elseif type == "da" then
            target.set("daRank", rank)
        end
        TriggerClientEvent("usa:notify", source, "Player " .. playerName .. " has been whitelisted for " .. type .. ", rank: " .. rank)
    else
        if type == "police" then
            target.set("policeRank", 0)
        elseif type == "corrections" then
            target.set("bcsoRank", 0)
        elseif type == "ems" then
            target.set("emsRank", 0)
        elseif type == "doctor" then
            target.set("doctorRank", 0)
        elseif type == "da" then
            target.set("daRank", 0)
        end
        local user_job = target.get("job")
        if user_job == "ems" or user_job == "doctor" or user_job == "fire" or user_job == "sheriff" or user_job == "corrections" then
            target.set("job", "civ")
            TriggerClientEvent("thirdEye:updateActionsForNewJob", playerId, "civ")
        end
        TriggerClientEvent("usa:notify", source, "Player " .. playerName .. " has been un-whitelisted for " .. type)
    end
end, {
    help = "Set a person's police, corrections, EMS, doctor or DA rank.",
    params = {
        { name = "id", help = "The player's server ID #" },
        { name = "type", help = "'police', 'corrections', 'ems', 'doctor' or 'da'" },
        { name = "rank", help = "0 to remove whitelist, 1 for lowest, 10 is max permissions" }
    }
})

TriggerEvent('es:addJobCommand', 'records', {'sheriff', 'police' , 'judge', 'corrections'}, function(source, args, char)
	if args[2] then
		local targetchar = exports["usa-characters"]:GetCharacter(tonumber(args[2]))
		if targetchar then
			local ownedVehicles = targetchar.get("vehicles")
			GetMakeModelPlate(ownedVehicles, function(vehs)
				local vehiclenames = ""
				local userVehicles = vehs
				for i = 1, #userVehicles do
					local vehicle = userVehicles[i]
					vehiclenames = vehiclenames .. userVehicles[i].model
					if i ~= #userVehicles then
						vehiclenames = vehiclenames .. ", "
					end
				end

				local insurance = targetchar.get("insurance")
				local insurance_month = insurance.expireMonth
				local insurance_year = insurance.expireYear
				local displayInsurance = "Invalid"
				if insurance_month and insurance_year then
					displayInsurance = insurance_month .. "/" .. insurance_year
				end
				if insurance.planName then
					displayInsurance = "Valid"
				end
                TriggerClientEvent('chatMessage', source, "", {255, 255, 255}, " " .. targetchar.getFullName() .. "'s Citizen Records")
                TriggerClientEvent('chatMessage', source, "", {255, 255, 255}, "^2Vehicles: ^0" .. vehiclenames .. " | ^2Insurance: ^0" .. displayInsurance .. " |")
            end)
		end
	end
end, {
	help = "View citizen records",
    params = {
		{ name = "id", help = "Citizen's ID" }
	}
})

RegisterServerEvent("policestation2:checkWhitelistForLockerRoom")
AddEventHandler("policestation2:checkWhitelistForLockerRoom", function()
    local playerIdentifiers = GetPlayerIdentifiers(source)
    local playerGameLicense = ""
    local char = exports["usa-characters"]:GetCharacter(source)
    local job = char.get("job")
    if char.get("policeRank") > 0 then
        TriggerClientEvent("policestation2:isWhitelisted", source)
    else
        TriggerClientEvent("usa:notify", source, "~y~You are not whitelisted for POLICE. Apply at https://www.usarrp.gg.")
    end
end)

RegisterServerEvent("policestation2:checkWhitelistForArmory")
AddEventHandler("policestation2:checkWhitelistForArmory", function()
    local playerIdentifiers = GetPlayerIdentifiers(source)
    local playerGameLicense = ""
    local char = exports["usa-characters"]:GetCharacter(source)
    local job = char.get("job")
    if (char.get("policeRank") > 0 and job == "sheriff") or (char.get("bcsoRank") > 0 and job == "corrections") then
        TriggerClientEvent("policestation2:showArmoury", source)
    else
        TriggerClientEvent("usa:notify", source, "~y~You are not on duty for POLICE. Apply at https://www.usarrp.gg.")
    end
end)

RegisterServerEvent("policestation2:requestPurchase")
AddEventHandler("policestation2:requestPurchase", function(index)
    local usource = source
    local weapon = armoryItems[index]
    if weapon.name == "Spike Strips" then
        TriggerEvent("spikestrips:equip", true, usource) -- true = pay required
    else
        local char = exports["usa-characters"]:GetCharacter(usource)
        local rank = nil
        if char.get("job") == "sheriff" then
            rank = char.get("policeRank")
        elseif char.get("job") == "corrections" then 
            rank = char.get("bcsoRank")
        end
        if weapon.minRank then
            if rank < weapon.minRank then
                TriggerClientEvent("usa:notify", usource, "Not high enough rank, need to be: " .. weapon.minRank)
                return
            end
        end
        if char.canHoldItem(weapon) then
            local user_money = char.get("money")
            if user_money - armoryItems[index].price >= 0 then
                local timestamp = os.date("*t", os.time())
                weapon.serialNumber = exports.globals:generateID()
                weapon.uuid = weapon.serialNumber
                local weaponDB = {}
                weaponDB.name = weapon.name
                weaponDB.serialNumber = weapon.uuid
                weaponDB.ownerName = char.getFullName()
                weaponDB.ownerDOB = char.get('dateOfBirth')
                weaponDB.issueDate = timestamp.month .. "/" .. timestamp.day .. "/" .. timestamp.year
                local attachments = GetWeaponAttachments(weapon.name)
                weaponDB.components = attachments
                weapon.components = attachments
                char.giveItem(weapon, (weapon.quantity or 1))
                char.removeMoney(armoryItems[index].price)
                TriggerClientEvent("mini:equipWeapon", usource, armoryItems[index].hash, attachments, false) -- equip
                TriggerClientEvent('usa:notify', usource, 'Purchased: ~y~'..weapon.name..'\n~s~Price: ~y~$'..armoryItems[index].price)
                TriggerEvent('es:exposeDBFunctions', function(couchdb)
                    couchdb.createDocumentWithId("legalweapons", weaponDB, weaponDB.serialNumber, function(success)
                        if success then
                            print("* Weapon created serial["..weaponDB.serialNumber.."] name["..weaponDB.name.."] owner["..weaponDB.ownerName.."] *")
                        else
                            print("* Error: Weapon failed to be created!! *")
                        end
                    end)
                end)
            else
                TriggerClientEvent("usa:notify", usource, "Not enough money!")
            end
        else
            TriggerClientEvent("usa:notify", usource, "Inventory is full!")
        end
    end
end)

RegisterServerEvent("policestation2:saveOutfit")
AddEventHandler("policestation2:saveOutfit", function(character, slot)
    local src = source
    local char = exports["usa-characters"]:GetCharacter(src)
    if char.get("job") == "sheriff" then
        TriggerEvent('es:exposeDBFunctions', function(db)
            local docID = char.get("_id") .. "-" .. slot
            db.createDocumentWithId(DB_NAME, character, docID, function(ok)
                if ok then
                    TriggerClientEvent("usa:notify", src, "Outfit in slot "..slot.." has been saved.")
                else
                    db.updateDocument(DB_NAME, docID, character, function(ok)
                        if ok then
                            TriggerClientEvent("usa:notify", src, "Outfit in slot "..slot.." has been updated.")
                        else 
                            TriggerClientEvent("usa:notify", src, "Error saving outfit")
                        end
                    end)
                end
            end)
        end)
    else
        TriggerClientEvent("usa:notify", source, "You must be on-duty to save a uniform.")
    end
end)

RegisterServerEvent("policestation2:loadOutfit")
AddEventHandler("policestation2:loadOutfit", function(slot)
    local src = source
    local char = exports["usa-characters"]:GetCharacter(src)
    if char.get("policeRank") > 0 then
        local docID = char.get("_id") .. "-" .. slot
        TriggerEvent('es:exposeDBFunctions', function(db)
            db.getDocumentById(DB_NAME, docID, function(outfit)
                TriggerClientEvent("policestation2:setCharacter", src, outfit)
                if char.get("job") ~= 'sheriff' then
                    char.set("job", JOB_NAME)
                    TriggerEvent('job:sendNewLog', src, JOB_NAME, true)
                    TriggerClientEvent("thirdEye:updateActionsForNewJob", src, JOB_NAME)
                end
                TriggerClientEvent('interaction:setPlayersJob', src, 'sheriff')
                TriggerEvent("eblips:add", {name = char.getName(), src = src, color = 3})
            end)
        end)
    else
        DropPlayer(source, "Exploiting. Your information has been logged and staff has been notified. If you feel this was by mistake, let a staff member know.")
    end
end)

RegisterServerEvent("policestation2:offduty")
AddEventHandler("policestation2:offduty", function()
    local char = exports["usa-characters"]:GetCharacter(source)
    --RemovePoliceWeapons(char)
    local playerWeapons = char.getWeapons() -- give back their civ weapons
    TriggerClientEvent('interaction:setPlayersJob', source, 'civ')
    TriggerClientEvent("policestation2:setciv", source, char.get("appearance"), playerWeapons)
    char.set("job", "civ")
    TriggerClientEvent("thirdEye:updateActionsForNewJob", source, "civ")
    TriggerEvent('job:sendNewLog', source, JOB_NAME, false)
    TriggerEvent("eblips:remove", source)
    TriggerClientEvent("radio:unsubscribe", source)
end)

RegisterServerEvent("police:buyFAK")
AddEventHandler("police:buyFAK", function()
    local char = exports["usa-characters"]:GetCharacter(source)
    local FAK = {
        name = "First Aid Kit",
        price = 50,
        type = "misc",
        quantity = 1,
        legality = "legal",
        weight = 5,
        objectModel = "v_ret_ta_firstaid",
        blockedInPrison = true
    }
    if char.canHoldItem(FAK) then
        if char.get("money") >= FAK.price then
            char.removeMoney(FAK.price)
            char.giveItem(FAK)
        else
            TriggerClientEvent("usa:notify", source, "Not enough money! Need $" .. FAK.price)
        end
    else
        TriggerClientEvent("usa:notify", source, "Inventory full!")
    end
end)

function GetWeaponAttachments(name)
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
    elseif name == "Carbine Rifle" then
        table.insert(attachments, "COMPONENT_AT_AR_FLSH")
        table.insert(attachments, "COMPONENT_AT_SCOPE_MEDIUM")
        -- table.insert(attachments, "COMPONENT_AT_AR_SUPP")
        table.insert(attachments, "COMPONENT_AT_AR_AFGRIP")
    end
    return attachments
end

function RemovePoliceWeapons(char)
    local weps = char.getWeapons()
    for i = #weps, 1, -1 do
        if weps[i].serviceWeapon then
            char.removeItemWithField("serialNumber", weps[i].serialNumber)
            local src = char.get("source")
            if src then
                TriggerClientEvent("interaction:equipWeapon", src, weps[i], false) -- to test
            end
        end
    end
end

function GetMakeModelPlate(plates, cb)
	-- query for the information needed from each vehicle --
	local endpoint = "/vehicles/_design/vehicleFilters/_view/getMakeModelPlate"
	local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
	PerformHttpRequest(url, function(err, responseText, headers)
		if responseText then
			local responseVehArray = {}
			--print(responseText)
			local data = json.decode(responseText)
			if data.rows then
				for i = 1, #data.rows do
					local veh = {
						plate = data.rows[i].value[1], -- plate
						make = data.rows[i].value[2], -- make
						model = data.rows[i].value[3] -- model
					}
					table.insert(responseVehArray, veh)
				end
			end
			-- send vehicles to client for displaying --
			--print("# of vehicles loaded for menu: " .. #responseVehArray)
			cb(responseVehArray)
		end
	end, "POST", json.encode({
		keys = plates
		--keys = { "86CSH075" }
	}), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end