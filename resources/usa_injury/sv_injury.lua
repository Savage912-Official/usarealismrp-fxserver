local WEBHOOK_URL = GetConvar("injury-log-webhook", "")

local InjuriesC = Config.Injuries

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
	local totalPrice = Config.BASE_CHECKIN_PRICE
	local copsCalled = false
	local isPolice = IsPlayerCop(usource)
	local chance = math.random()
	for bone, InjuriesC in pairs(playerInjuries) do
		for injury, data in pairs(playerInjuries[bone]) do
			if chance < 0.45 then
				local name
				if SuspiciousWound(Config.Injuries[injury].string) and not copsCalled and not isPolice then
					if chance > 0.25 then name = char.getFullName() else name = "Unidentified Individual" end
					TriggerEvent('911:SuspiciousHospitalInjuries', name, x, y, z)
					copsCalled = true
				end
			end
			-- print(chance) -- DEBUG
			totalPrice = totalPrice + Config.Injuries[injury].treatmentPrice
			if Config.Injuries[injury].string == "High-speed Projectile" then 
				treatmentTimeMinutes = treatmentTimeMinutes + 3
			elseif Config.Injuries[injury].string == "Knife Puncture" then 
				treatmentTimeMinutes = treatmentTimeMinutes + 2
			elseif Config.Injuries[injury].string == "Explosion" then 
				treatmentTimeMinutes = treatmentTimeMinutes + 3
			elseif Config.Injuries[injury].string == "Large Sharp Object" then 
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
			if distToBed <= Config.MAX_BED_DISTANCE then
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
	for bone, InjuriesC in pairs(playerInjuries) do
		for injury, data in pairs(playerInjuries[bone]) do
			totalPrice = totalPrice + Config.Injuries[injury].treatmentPrice
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
AddEventHandler('injuries:inspectMyInjuries', function(sourceToReturnInjuries, InjuriesC, myPed)
	local char = exports["usa-characters"]:GetCharacter(source)
	local targetSource = char.get("source")
	TriggerEvent('display:shareDisplayBySource', sourceToReturnInjuries, 'inspects injuries', 4, 470, 10, 4000, true)
	TriggerClientEvent('injuries:displayInspectedInjuries', sourceToReturnInjuries, InjuriesC, targetSource, myPed)
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
