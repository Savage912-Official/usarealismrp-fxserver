local MAX_POLICE_IMPOUND_DAYS = 14

RegisterServerCallback { 
	eventName = "usa_impound:impoundVeh",
	eventCallback = function(src, plate, days)
		days = tonumber(days)
		if days > MAX_POLICE_IMPOUND_DAYS then
			TriggerClientEvent("usa:notify", src, false, "^3INFO: ^0" .. days .. " days exceeds the max of " .. MAX_POLICE_IMPOUND_DAYS .. " days")
			return false
		end
		local char = exports["usa-characters"]:GetCharacter(source)
		if not doesCharHavePerms(source) then
			return false
		end
		local vehInfo = exports.essentialmode:getDocument("vehicles", plate)
		local impoundInfo = {
			time = os.time(),
			days = tonumber(days),
			by = char.getFullName(),
			make = vehInfo.make,
			model = vehInfo.model
		}
		exports.essentialmode:updateDocument("police-impounded-vehicles", plate, impoundInfo, true)
		exports.essentialmode:updateDocument("vehicles", plate, { impounded = true })
		return true
	end
}

RegisterServerCallback { 
	eventName = "usa_impound:checkCop",
	eventCallback = function(src)
		return doesCharHavePerms(src)
	end
}

TriggerEvent('es:addJobCommand', 'releaseimpound', {'sheriff', 'corrections', 'judge'}, function(source, args, char)
	local plate = args[2]
	if plate then
		local impoundedInfo = exports.essentialmode:getDocument("police-impounded-vehicles", plate)
		if impoundedInfo then
			exports.essentialmode:deleteDocument("police-impounded-vehicles", plate)
			exports.essentialmode:updateDocument("vehicles", plate, { impounded = false })
			TriggerClientEvent("usa:notify", source, "Impound lifted")
		else
			TriggerClientEvent("usa:notify", source, "Not found")	
		end
	else
		TriggerClientEvent("usa:notify", source, "You need to provide a case sensitive plate!")
	end
end, {
	help = "Releases a Vehicle from Police Impound.",
	params = { 
		{name = "plate", help = "The plate of the vehicle to release."}
	}
})

RegisterServerEvent("usa_impound:showImpoundedVehicles")
AddEventHandler("usa_impound:showImpoundedVehicles", function()
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(source)
	if doesCharHavePerms(source) then
		local impoundedVehicles = exports.essentialmode:getAllDocumentsWithLimit("police-impounded-vehicles", 100)
		TriggerClientEvent("usa:notify", usource, false, "^3INFO: ^0Impounded vehicle list:")
		for i = 1, #impoundedVehicles do
			local daysAgo = math.floor(os.difftime(os.time(), impoundedVehicles[i].time) / (60 * 60 * 24))
			local msg = impoundedVehicles[i].make .. " " .. impoundedVehicles[i].model .. " [" .. impoundedVehicles[i]._id .. "] impounded " .. daysAgo .. " day(s) ago by " .. impoundedVehicles[i].by 
			TriggerClientEvent("usa:notify", usource, false, msg)
		end
	end
end)

function doesCharHavePerms(src)
	local char = exports["usa-characters"]:GetCharacter(src)
	local job = char.get("job")
	if (job == 'sheriff' and char.get('policeRank') > 2) or (job == 'corrections' and char.get('bcsoRank') > 2) then
		return true
	else
		return false
	end
end

exports.globals:PerformDBCheck("usa_impound", "police-impounded-vehicles")