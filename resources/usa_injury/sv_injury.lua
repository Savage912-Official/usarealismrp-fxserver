local MAX_BED_DISTANCE = 1000

BASE_CHECKIN_PRICE = 25 -- must be kept the same with one in cl_injury under check-in section

injuries = { -- ensure this is the same as cl_injury.lua
	--[GetHashKey("WEAPON_UNARMED")] = {type = 'blunt', bleed = 7200, string = 'Fists', treatableWithBandage = true, treatmentPrice = 50, dropEvidence = 0.5}, -- WEAPON_UNARMED
	[GetHashKey("WEAPON_ANIMAL")] = {type = 'laceration', bleed = 1500, string = 'Animal Attack', treatableWithBandage = true, treatmentPrice = 80, dropEvidence = 0.9}, -- WEAPON_ANIMAL
	[GetHashKey("WEAPON_COUGAR")] = {type = 'laceration', bleed = 900, string = 'Animal Attack', treatableWithBandage = false, treatmentPrice = 90, dropEvidence = 0.9}, -- WEAPON_COUGAR
	[GetHashKey("WEAPON_KNIFE")] = {type = 'laceration', bleed = 480, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 90, dropEvidence = 1.0}, -- WEAPON_KNIFE
	[GetHashKey("WEAPON_SHIV")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0}, -- WEAPON_SHIV
	[GetHashKey("WEAPON_THROWINGKNIFE")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0},
	[GetHashKey("WEAPON_NINJASTAR")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0},
	[GetHashKey("WEAPON_NINJASTAR2")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0},
	[GetHashKey("WEAPON_KATANAS")] = {type = 'laceration', bleed = 1750, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 150, dropEvidence = 1.0}, -- WEAPON_KATANA
	[GetHashKey("WEAPON_NIGHTSTICK")] = {type = 'blunt', bleed = 2400, string = 'Blunt Object', treatableWithBandage = true, treatmentPrice = 30, dropEvidence = 0.8}, -- WEAPON_NIGHTSTICK
	[GetHashKey("WEAPON_HAMMER")] = {type = 'blunt', bleed = 1200, string = 'Concentrated Blunt Object', treatableWithBandage = true, treatmentPrice = 30, dropEvidence = 0.9}, -- WEAPON_HAMMER
	[GetHashKey("WEAPON_BAT")] = {type = 'blunt', bleed = 900, string = 'Large Blunt Object', treatableWithBandage = false, treatmentPrice = 70, dropEvidence = 0.9}, -- WEAPON_BAT
	[GetHashKey("WEAPON_GOLFCLUB")] = {type = 'blunt', bleed = 1200, string = 'Large Blunt Object', treatableWithBandage = false, treatmentPrice = 10, dropEvidence = 0.6}, -- WEAPON_GOLFCLUB
	[GetHashKey("WEAPON_CROWBAR")] = {type = 'blunt', bleed = 900, string = 'Blunt Object', treatableWithBandage = false, treatmentPrice = 45, dropEvidence = 0.8}, -- WEAPON_CROWBAR
	[GetHashKey("WEAPON_MACHINEPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_APPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_PISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PISTOL
	[GetHashKey("WEAPON_COMBATPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_COMBATPISTOL
	[GetHashKey("WEAPON_CERAMICPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_CERAMICPISTOL
	[GetHashKey("WEAPON_PISTOL50")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PISTOL50
	[GetHashKey("WEAPON_GUSENBERG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_SMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_SMG
	[GetHashKey("WEAPON_SCARSC")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_COMBATPDW")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_COMBATPDW
	[GetHashKey("WEAPON_ASSAULTSMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_SMG_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_MICROSMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_MINISMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_ASSAULTRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_AKORUS")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_TACTICALRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_MILITARYRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_CARBINERIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_CARBINERIFLE
	[GetHashKey("WEAPON_PUMPSHOTGUN")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PUMPSHOTGUN
	[GetHashKey("WEAPON_SAWNOFFSHOTGUN")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_DBSHOTGUN")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_DBSHOTGUN
	[GetHashKey("WEAPON_BULLPUPSHOTGUN")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_BULLPUPSHOTGUN
	[GetHashKey("WEAPON_STUNGUN")] = {type = 'penetrating', bleed = 3600, string = 'Prongs', treatableWithBandage = true, treatmentPrice = 25, dropEvidence = 0.0}, -- WEAPON_STUNGUN
	[GetHashKey("WEAPON_SNIPERRIFLE")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_SNIPERRIFLE
	[GetHashKey("WEAPON_REMOTESNIPER")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_REMOTESNIPER
	[GetHashKey("WEAPON_GRENADE")] = {type = 'penetrating', bleed = 120, string = 'Shrapnel Wound', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_GRENADE
	[GetHashKey("WEAPON_MOLOTOV")] = {type = 'burn', bleed = 600, string = 'Molotov Residue', treatableWithBandage = false, treatmentPrice = 80, dropEvidence = 1.0}, -- WEAPON_MOLOTOV
	[GetHashKey("WEAPON_PETROLCAN")] = {type = 'burn', bleed = 600, string = 'Gasoline Residue', treatableWithBandage = false, treatmentPrice = 90, dropEvidence = 1.0}, -- WEAPON_PETROLCAN
	[GetHashKey("WEAPON_FLARE")] = {type = 'burn', bleed = 1800, string = 'Concentrated Heat', treatableWithBandage = true, treatmentPrice = 65, dropEvidence = 0.7}, -- WEAPON_FLARE
	[GetHashKey("WEAPON_EXPLOSION")] = {type = 'burn', bleed = 120, string = 'Explosion', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_EXPLOSION
	--[GetHashKey("WEAPON_FALL")] = {type = 'blunt', bleed = 2700, string = 'Fall', treatableWithBandage = true, treatmentPrice = 30, dropEvidence = 0.2}, -- WEAPON_FALL
	--[GetHashKey("WEAPON_RAMMED_BY_CAR")] = {type = 'blunt', bleed = 1800, string = 'Vehicle Accident', treatableWithBandage = true, treatmentPrice = 50, dropEvidence = 0.0}, -- WEAPON_RAMMED_BY_CAR
	--[GetHashKey("WEAPON_RUN_OVER_BY_CAR")] = {type = 'blunt', bleed = 1500, string = 'Vehicle Accident', treatableWithBandage = true, treatmentPrice = 50, dropEvidence = 0.4}, -- WEAPON_RUN_OVER_BY_CAR
	[GetHashKey("WEAPON_FIRE")] = {type = 'burn', bleed = 600, string = 'Fire', treatableWithBandage = false, treatmentPrice = 50, dropEvidence = 1.0}, -- WEAPON_FIRE
	[GetHashKey("WEAPON_SNSPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_SNSPISTOL
	[GetHashKey("WEAPON_SNSPISTOL_MK2")] = {type = 'penetrating', bleed = 310, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_SNSPISTOL_MK2
	[GetHashKey("WEAPON_BOTTLE")] = {type = 'laceration', bleed = 600, string = 'Sharp Glass', treatableWithBandage = false, treatmentPrice = 40, dropEvidence = 1.0}, -- WEAPON_BOTTLE
	[GetHashKey("WEAPON_HEAVYPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_HEAVYPISTOL
	[GetHashKey("WEAPON_DAGGER")] = {type = 'laceration', bleed = 480, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 90, dropEvidence = 1.0}, -- WEAPON_DAGGER
	[GetHashKey("WEAPON_VINTAGEPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_VINTAGEPISTOL
	[GetHashKey("WEAPON_MUSKET")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_MUSKET
	[GetHashKey("WEAPON_MARKSMANRIFLE")] = {type = 'penetrating', bleed = 240, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_MARKSMANRIFLE
	[GetHashKey("WEAPON_FLAREGUN")] = {type = 'burn', bleed = 1200, string = 'Concentrated Heat', treatableWithBandage = true, treatmentPrice = 80, dropEvidence = 1.0}, -- WEAPON_FLAREGUN
	[GetHashKey("WEAPON_MARKSMANPISTOL")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_MARKSMANPISTOL
	[GetHashKey("WEAPON_KNUCKLE")] = {type = 'blunt', bleed = 1200, string = 'Blunt Object', treatableWithBandage = true, treatmentPrice = 70, dropEvidence = 1.0}, -- WEAPON_KNUCKLE
	[GetHashKey("WEAPON_HATCHET")] = {type = 'laceration', bleed = 360, string = 'Large Sharp Object', treatableWithBandage = false, treatmentPrice = 300, dropEvidence = 1.0}, -- WEAPON_HATCHET
	[GetHashKey("WEAPON_MACHETE")] = {type = 'laceration', bleed = 360, string = 'Large Sharp Object', treatableWithBandage = false, treatmentPrice = 300, dropEvidence = 1.0}, -- WEAPON_MACHETE
	[GetHashKey("WEAPON_SWITCHBLADE")] = {type = 'laceration', bleed = 480, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 70, dropEvidence = 1.0}, -- WEAPON_SWITCHBLADE
	[GetHashKey("WEAPON_REVOLVER")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_REVOLVER
	[GetHashKey("WEAPON_REVOLVERULTRA")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
	[GetHashKey("WEAPON_NAVYREVOLVER")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_NAVYREVOLVER
    [GetHashKey("WEAPON_DOUBLEACTION")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_DOUBLEACTION
    [GetHashKey("WEAPON_REVOLVER_MK2")] = {type = 'penetrating', bleed = 125, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_REVOLVER_MK2
	[GetHashKey("WEAPON_BATTLEAXE")] = {type = 'laceration', bleed = 240, string = 'Large Sharp Object', treatableWithBandage = false, treatmentPrice = 300, dropEvidence = 1.0}, -- WEAPON_BATTLEAXE
	[GetHashKey("WEAPON_POOLCUE")] = {type = 'blunt', bleed = 1800, string = 'Large Blunt Object', treatableWithBandage = false, treatmentPrice = 65, dropEvidence = 1.0}, -- WEAPON_POOLCUE
	[GetHashKey("WEAPON_WRENCH")] = {type = 'blunt', bleed = 900, string = 'Concentrated Blunt Object', treatableWithBandage = false, treatmentPrice = 80, dropEvidence = 1.0}, -- WEAPON_WRENCH
	[GetHashKey("WEAPON_FLASHLIGHT")] = {type = 'blunt', bleed = 2700, string = 'Blunt Object', treatableWithBandage = true, treatmentPrice = 40, dropEvidence = 0.6}, -- WEAPON_FLASHLIGHT
	[GetHashKey("WEAPON_PISTOL_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PISTOL_MK2
	[GetHashKey("WEAPON_CARBINERIFLE_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_CARBINERIFLE_MK2
	[GetHashKey("WEAPON_PUMPSHOTGUN_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PUMPSHOTGUN_MK2
	[GetHashKey("WEAPON_ASSAULTRIFLE_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, 
	[GetHashKey("WEAPON_COMPACTRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_COMPACTRIFLE
}

local WEBHOOK_URL = GetConvar("injury-log-webhook", "")

TriggerEvent('es:addCommand', 'injuries' , function(source, args, char)
	TriggerClientEvent("injuries:showMyInjuries", source)
end, {
	help = "Inspect the nearest player's injuries or your own injuries"
})

TriggerEvent('es:addCommand', 'inspect' , function(source, args, char)
	local _source = source
	local targetSource = tonumber(args[2])
	local user = exports["essentialmode"]:getPlayerFromId(source)
	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get("job")
	local group = user.getGroup()
	if job == "corrections" or job == "sheriff" or job == "cop" or job == "ems" or job == "doctor" or group == "mod" or group == "admin" or group == "superadmin" or group == "owner" then
		if targetSource and GetPlayerName(targetSource) then
			TriggerEvent('injuries:getPlayerInjuries', targetSource, _source)
		else
			TriggerClientEvent("injuries:inspectNearestPed", _source, _source)
		end
	end
end, {
	help = "Inspect the nearest player's injuries",
	params = {
		{ name = "id", help = "id of person (omit to treat nearest)" }
	}
})

TriggerEvent('es:addJobCommand', 'treat', {"doctor"}, function(source, args, char)
	local _source = source
	table.remove(args,1)
   	local boneToTreat = table.concat(args, " ")
	TriggerClientEvent("injuries:treatNearestPed", _source, boneToTreat)
end, {
	help = "Treat the nearest player's injuries",
	params = {
		{ name = "bone", help = "bone to treat" }
	}
})

TriggerEvent('es:addJobCommand', 'bandage', {'ems', 'doctor', 'sheriff', 'corrections'}, function(source, args, char)
	if not char.hasItem("First Aid Kit") then
		TriggerClientEvent("usa:notify", source, "No first aid kit")
		return
	end
	char.removeItem("First Aid Kit", 1)
	local _source = source
	local targetSource = tonumber(args[2])
	if targetSource and GetPlayerName(targetSource) then
		TriggerEvent('injuries:bandagePlayer', targetSource)
		TriggerClientEvent('usa:notify', _source, 'Patient\'s injuries have been bandaged.')
		exports.globals:sendLocalActionMessage(_source, "gives bandage", 5.0, 3500)
		TriggerClientEvent("usa:playAnimation", _source, "anim@move_m@trash", "pickup", -8, 1, -1, 53, 0, 0, 0, 0, 3)
	else
		TriggerClientEvent('injuries:bandageNearestPed', _source)
	end
end, {
	help = 'Bandage the nearest player\'s injuries',
	params = {
		{ name = "id", help = "id of person (omit to bandage nearest)" }
	}
})

TriggerEvent('es:addJobCommand', 'epi', {'ems', 'doctor', 'sheriff', 'corrections'}, function(source, args, char)
	local _source = source
	local targetSource = tonumber(args[2])
	if targetSource and GetPlayerName(targetSource) and targetSource ~= _source then
		TriggerClientEvent('usa_injury:epi', targetSource, true)
		TriggerClientEvent('usa:notify', _source, 'Patient has been injected with epinephrine.')
		exports.globals:sendLocalActionMessage(_source, "injects with epinephrine", 5.0, 3500)
		TriggerClientEvent("usa:playAnimation", _source, "amb@medic@standing@tendtodead@base", "base", -8, 1, -1, 33, 0, 0, 0, 0, 3)
	end
end, {
	help = 'Inject target with epinephrine to wake them from unconsciousness temporarily',
	params = {
		{ name = "id", help = "id of person to use epi pen on" }
	}
})

TriggerEvent('es:addJobCommand', 'newrecord', {'ems', 'doctor'}, function(source, args, char)
	local targetSource = tonumber(args[2])
	local payment = math.ceil(tonumber(args[3]))
	if payment > 5000 then
		TriggerClientEvent('usa:notify', source, 'Payment too high!')
		return
	end
	table.remove(args, 1)
	table.remove(args, 1)
	table.remove(args, 1)
	local details = table.concat(args, " ")
	if not details or not GetPlayerName(targetSource) then return end
	local target = exports["usa-characters"]:GetCharacter(targetSource)
	local targetBank = target.get('bank')
	local targetName = target.getFullName()
	local targetDOB = target.get('dateOfBirth')
	local userName = char.getFullName()
	target.removeBank(payment)
	TriggerClientEvent('usa:notify', targetSource, 'You have been charged ~y~$' .. payment .. '~s~ in medical fees, payment processed from bank.')
	TriggerClientEvent('usa:notify', source, 'Medical record has been created!')
	PerformHttpRequest(WEBHOOK_URL, function(err, text, headers)
		if text then
			print(text)
		end
	end, "POST", json.encode({
		embeds = {
			{
				description = "**Patient Name:** " .. targetName .. "\n**Patient DOB:** " .. targetDOB .. "\n**Payment:** $" .. payment .."\n**Details:** \n⠀"..details.."\n**Signature:** "..userName.."\n**Timestamp:** " .. os.date('%m-%d-%Y %H:%M:%S', os.time()),
				color = 263172,
				author = {
					name = "New Medical Record"
				}
			}
		}
	}), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end, {
	help = 'Sign off a new field on a patient\'s record',
	params = {
		{ name = "id", help = "id of person" },
		{ name = "payment", help = "payment for treatment" },
		{ name = "details", help = "treatment notes and details"}
	}
})

RegisterServerEvent('injuries:validateCheckin')
AddEventHandler('injuries:validateCheckin', function(playerInjuries, isPedDead, x, y, z, isMale)
	local usource = source
	local treatmentTimeMinutes = 2
	local char = exports["usa-characters"]:GetCharacter(usource)
	local userBank = char.get('bank')
	local totalPrice = BASE_CHECKIN_PRICE
	local copsCalled = false
	local isPolice = IsPlayerCop(usource)
	local chance = math.random()
	for bone, injuries in pairs(playerInjuries) do
		for injury, data in pairs(playerInjuries[bone]) do
			if chance < 0.45 then
				local name
				if SuspiciousWound(injuries[injury].string) and not copsCalled and not isPolice then
					if chance > 0.25 then name = char.getFullName() else name = "Unidentified Individual" end
					TriggerEvent('911:SuspiciousHospitalInjuries', name, x, y, z)
					copsCalled = true
				end
			end
			-- print(chance) -- DEBUG
			totalPrice = totalPrice + injuries[injury].treatmentPrice
			if injuries[injury].string == "High-speed Projectile" then 
				treatmentTimeMinutes = treatmentTimeMinutes + 3
			elseif injuries[injury].string == "Knife Puncture" then 
				treatmentTimeMinutes = treatmentTimeMinutes + 2
			elseif injuries[injury].string == "Explosion" then 
				treatmentTimeMinutes = treatmentTimeMinutes + 3
			elseif injuries[injury].string == "Large Sharp Object" then 
				treatmentTimeMinutes = treatmentTimeMinutes + 2
			end
		end
	end
	if treatmentTimeMinutes > 15 then
		treatmentTimeMinutes = 15
	end
	TriggerEvent('injuries:getHospitalBeds', function(hospitalBeds)
		local playerCoords = GetEntityCoords(GetPlayerPed(usource))
		for i = 1, #hospitalBeds do
			local distToBed = exports.globals:getCoordDistance(playerCoords, {x = hospitalBeds[i].objCoords[1], y = hospitalBeds[i].objCoords[2], z = hospitalBeds[i].objCoords[3]})
			if distToBed <= MAX_BED_DISTANCE then
				if hospitalBeds[i].occupied == nil then
					hospitalBeds[i].occupied = targetPlayerId
					bed = {
						heading = hospitalBeds[i].heading,
						coords = hospitalBeds[i].objCoords,
						model = hospitalBeds[i].objModel
					}
					TriggerClientEvent('ems:hospitalize', usource, treatmentTimeMinutes, bed, i)
					break
				end
			end
		end
	end)
	TriggerClientEvent("chatMessage", usource, '^3^*[HOSPITAL] ^r^7You have been admitted to the hospital, please wait while you are treated.')
	TriggerClientEvent('chatMessage', usource, 'The payment has been deducted from your bank balance.')
	print('INJURIES: '..PlayerName(usource) .. ' has checked-in to hospital and was charged amount['..totalPrice..']')
	if char.get('job') ~= 'sheriff' and char.get("job") ~= "corrections" and char.get("job") ~= "ems" then
		char.removeBank(totalPrice)
	end
end)

RegisterServerEvent('injuries:sendLog')
AddEventHandler('injuries:sendLog', function(log, payment)
	local char = exports["usa-characters"]:GetCharacter(source)
	local userName = char.getFullName()
	local userDOB = char.get('dateOfBirth')
	PerformHttpRequest(WEBHOOK_URL, function(err, text, headers)
		if text then
			print(text)
		end
	end, "POST", json.encode({
		embeds = {
			{
				description = "**Patient Name:** " .. userName .. "\n**Patient DOB:** " .. userDOB .. "\n**Payment:** $" .. payment .."\n**Details:** "..log.."\n**Timestamp:** " .. os.date('%m-%d-%Y %H:%M:%S', os.time()),
				color = 263172,
				author = {
					name = "New Medical Record"
				}
			}
		}
	}), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end)

RegisterServerEvent('injuries:chargeForInjuries')
AddEventHandler('injuries:chargeForInjuries', function(playerInjuries, multiplier, respawn)
	local char = exports["usa-characters"]:GetCharacter(source)
	local totalPrice = BASE_CHECKIN_PRICE
	for bone, injuries in pairs(playerInjuries) do
		for injury, data in pairs(playerInjuries[bone]) do
			totalPrice = totalPrice + injuries[injury].treatmentPrice
		end
	end
	if type(multiplier) == 'number' then
		totalPrice = totalPrice * multiplier
	end
	local job = char.get("job")
	if job == "sheriff" or job == "corrections" or job == "ems" then
		char.removeBank(math.floor(totalPrice * 0.25))
	else 
		char.removeBank(totalPrice)
	end
	print('INJURIES: '..PlayerName(source) .. ' has been charged amount['..totalPrice..'] in bank for hospital fees!')
	if respawn then
		TriggerClientEvent('chatMessage', source, '^3^*[HOSPITAL] ^r^7You have been charged ^3$'..totalPrice..'^0 in hospital fees.')
		char.set('injuries', {})
		TriggerClientEvent('injuries:updateInjuries', source, {})
	end
	TriggerClientEvent('chatMessage', source, 'The payment has been deducted from your bank balance.')
end)

RegisterServerEvent('injuries:getPlayerInjuries')
AddEventHandler('injuries:getPlayerInjuries', function(sourceToGetInjuriesFrom, sourceToReturnInjuries)
	TriggerClientEvent('injuries:returnInjuries', sourceToGetInjuriesFrom, sourceToReturnInjuries)
end)

RegisterServerEvent('injuries:inspectMyInjuries')
AddEventHandler('injuries:inspectMyInjuries', function(sourceToReturnInjuries, injuries, myPed)
	local char = exports["usa-characters"]:GetCharacter(source)
	local targetSource = char.get("source")
	TriggerEvent('display:shareDisplayBySource', sourceToReturnInjuries, 'inspects injuries', 4, 470, 10, 4000, true)
	TriggerClientEvent('injuries:displayInspectedInjuries', sourceToReturnInjuries, injuries, targetSource, myPed)
end)

RegisterServerEvent('injuries:treatPlayer')
AddEventHandler('injuries:treatPlayer', function(sourceToTreat, boneToTreat)
	TriggerClientEvent('injuries:treatMyInjuries', sourceToTreat, boneToTreat, source)
end)

RegisterServerEvent('injuries:bandagePlayer')
AddEventHandler('injuries:bandagePlayer', function(sourceToBandage)
	if source then
		TriggerClientEvent('usa:notify', source, 'Patient\'s injuries have been bandaged.')
	end
	TriggerClientEvent('injuries:bandageMyInjuries', sourceToBandage)
end)

RegisterServerEvent('injuries:notify')
AddEventHandler('injuries:notify', function(sourceToNotify, message)
	TriggerClientEvent('usa:notify', sourceToNotify, message)
end)

RegisterServerEvent('injuries:saveData')
AddEventHandler('injuries:saveData', function(playerInjuries)
	local char = exports["usa-characters"]:GetCharacter(source)
	if char then
		char.set('injuries', playerInjuries)
	end
end)

RegisterServerEvent('injuries:requestData')
AddEventHandler('injuries:requestData', function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local playerInjuries = char.get('injuries')
	if playerInjuries then
		TriggerClientEvent('injuries:updateInjuries', source, playerInjuries)
	else
    TriggerClientEvent("injuries:removeInjuries", source)
  end
end)

TriggerEvent('es:addCommand', 'heal', function(source, args, char)
	print("healing")
	local group = exports["essentialmode"]:getPlayerFromId(source).getGroup()
	if group ~= "user" or char.get("job") == "eventPlanner" then
		local targetSource = tonumber(args[2])
		if tonumber(args[2]) and GetPlayerName(args[2]) then
			print("healing")
			local target = exports["usa-characters"]:GetCharacter(targetSource)
			target.set('injuries', {})
			TriggerClientEvent('death:allowRevive', targetSource)
			Citizen.Wait(100)
			TriggerClientEvent('injuries:updateInjuries', targetSource, {})
			TriggerClientEvent('usa:notify', source, 'Player has been healed.')
			TriggerEvent("usa:notifyStaff", '^2^*[STAFF]^r^0 Player ^2'..GetPlayerName(targetSource)..' ['..targetSource..'] ^0 has been healed by ^2'..GetPlayerName(source)..' ['..source..'] ^0.')
			TriggerClientEvent('chatMessage', targetSource, '^2^*[STAFF]^r^0 You have been healed by ^2'..GetPlayerName(source)..'^0.')
		end
	else
		TriggerClientEvent("usa:notify", source, "Not permitted")
	end
end, {
	help = "Heal a player's injuries.",
	params = {
		{ name = "id", help = "id of person" }
	}
})

function PlayerName(source)
	return GetPlayerName(source)..'['..GetPlayerIdentifier(source)..']'
end

function SuspiciousWound(woundType)
	local susWounds = {
		["High-speed Projectile"] = true,
		["Concentrated Blunt Object"] = true,
		["Large Blunt Object"] = true,
		["Large Sharp Object"] = true,
		["Concentrated Heat"] = true,
		["Knife Puncture"] = true,
		["Sharp Glass"] = true,
		["Explosion"] = true,
		["Gasoline Residue"] = true,
		["Molotov Residu"] = true
	}
	return susWounds[woundType]
end

function IsPlayerCop(src)
	local char = exports["usa-characters"]:GetCharacter(src)
	if char.get("job") == "sheriff" or char.get("job") == "corrections" then
		return true
	else
		return false
	end
end
