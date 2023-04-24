local DL_PRICE = 250
local CUSTOM_PLATE_PRICE = 7000

local BLACKLISTED_PLATE_PHRASES = {
	"nigger",
	"faggot",
	"fagg0t",
	"n1gger",
	"n1gg3r",
	"fuck",
	"shit",
	"server",
	"cock",
	"c0ck",
	"dick",
	"d1ck",
	"whore",
	"balls",
	"pussy",
	"vagina",
	"cunt",
}

RegisterServerEvent("dmv:buyLicense")
AddEventHandler("dmv:buyLicense", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local money = char.get("money")
	if money >= DL_PRICE then
		if char.hasItem("Driver's License") then
			TriggerClientEvent("usa:notify", source, "You already have a driver's license!")
			return
		end
		char.removeMoney(DL_PRICE)
		local timestamp = os.date("*t", os.time())
		local license = {
			name = "Driver\'s License",
			number = "F" .. tostring(math.random(1, 2543678)),
			quantity = 1,
			ownerName = char.getFullName(),
			ownerDob = char.get("dateOfBirth"),
			issued_by = 'Department of Motor Vehicles',
			expire = timestamp.month .. "/" .. timestamp.day .. "/" .. timestamp.year + 1,
			status = "valid",
			notDroppable = true,
			type = "license",
			weight = 0
		}
		char.giveItem(license, 1)
		TriggerClientEvent("usa:notify", source, "You have ~g~successfully~w~ purchased a Driver's License.")
	else
		TriggerClientEvent("usa:notify", source, "You don't have enough money to purchase a Driver's License!")
	end
end)

RegisterServerEvent("dmv:setLicenseStatus")
AddEventHandler("dmv:setLicenseStatus", function(status, target_id, days)
	local char = exports["usa-characters"]:GetCharacter(target_id)
	local license = char.getItem("Driver's License")
	if license then
		char.modifyItem("Driver's License", "status", status)
		if status == "suspended" then
			char.modifyItem("Driver's License", "suspension_start", os.time())
			char.modifyItem("Driver's License", "suspension_days", days)
			char.modifyItem("Driver's License", "suspension_start_date", os.date('%m-%d-%Y %H:%M:%S', os.time()))
		end
	end
end)

RegisterServerEvent("dmv:getLicenseStatus")
AddEventHandler("dmv:getLicenseStatus", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local license = char.getItem("Driver's License")
	if license then
		if license.status == "suspended" then
			TriggerClientEvent("usa:notify", source, "Your license was suspended for ~y~" .. license.suspension_days .. " day(s)~s~ starting on ~y~" .. license.suspension_start_date)
		else
			TriggerClientEvent("usa:notify", source, "Your license is ~g~valid~w~!")
		end
	else
		TriggerClientEvent("usa:notify", source, "You do not own a Driver's License!")
	end
end)

RegisterServerEvent("dmv:orderCustomPlate")
AddEventHandler("dmv:orderCustomPlate", function(oldPlate, newPlate)
	local src = source
	local c = exports["usa-characters"]:GetCharacter(src)
	oldPlate = exports.globals:trim(oldPlate:upper())
	newPlate = exports.globals:trim(newPlate:upper())
	if newPlate == "" or oldPlate == "" then
		TriggerClientEvent("usa:notify", src, "Must provide new and old plate")
		return
	end
	if newPlate:find(" ") then
		TriggerClientEvent("usa:notify", src, "Currently no support for spaces")
		return
	end
	if not exports.globals:isOnlyAlphaNumeric(newPlate) or not exports.globals:isOnlyAlphaNumeric(oldPlate) then
		TriggerClientEvent("usa:notify", src, "Only numbers and letters allowed")
		return
	end
	if doesCharacterOwnVehicle(c, oldPlate) then
		if c.get("bank") >= CUSTOM_PLATE_PRICE then
			if not getVehicleDBDoc(newPlate) then
				if not containsBlacklistedPhrase(newPlate) then
					TriggerEvent("es:exposeDBFunctions", function(db)
						-- make new db doc
						local oldVehDoc = getVehicleDBDoc(oldPlate)
						while not oldVehDoc do
							Wait(10)
						end
						oldVehDoc._id = nil
						oldVehDoc._rev = nil
						oldVehDoc.plate = newPlate
						db.createDocumentWithId("vehicles", oldVehDoc, newPlate, function(ok) end)
						-- delete old vehicle doc
						db.deleteDocument("vehicles", oldPlate, function() end)
						-- update nitro doc if any
						updateNitroDocIdentifier(oldPlate, newPlate)
						-- save in character owned vehicle plate list
						local vehs = c.get("vehicles")
						for i = 1, #vehs do
							if vehs[i] == oldPlate then
								vehs[i] = newPlate
								break
							end
						end
						c.set("vehicles", vehs)
						-- charge fee
						c.removeBank(CUSTOM_PLATE_PRICE, "DMV Custom Plate")
						-- notify success
						TriggerClientEvent("usa:notify", src, "Plate updated!")
						TriggerClientEvent("usa:notify", src, "~y~Fee:~w~ " .. exports.globals:comma_value(CUSTOM_PLATE_PRICE))
						-- notify garages to bypass vehicle plate ownership check for a vehicle that was used to drive to the DMV
						TriggerEvent("garage:notifyOfPlateChange", src, oldPlate, newPlate)
						-- send to discord #dmv-log --
						local url = GetConvar("dmv-log-webhook", "")
						local owner_name = c.getFullName()
						local car_make = oldVehDoc.make
						local car_model = oldVehDoc.model
						local makemodel = car_make .. " " .. car_model
						PerformHttpRequest(url, function(err, text, headers)
							if text then
								print(text)
							end
						end, "POST", json.encode({
							embeds = {
								{
									description = "**RO:** " .. owner_name .. " \n**MAKE/MODEL:** " .. makemodel .." \n**OLD PLATE:** " .. oldPlate .." \n**NEW PLATE:** " .. newPlate .."\n**TIMESTAMP:** " .. os.date('%m-%d-%Y %H:%M:%S', os.time()),
									color = 263172,
									author = {
										name = "Department of Motor Vehicles - Plate Change"
									}
								}
							}
						}), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
						-- update rcore_radiocar plate in DB
						if exports.rcore_radiocar:HasCarRadio(oldPlate) then
							exports.rcore_radiocar:RemoveRadioFromCar(oldPlate, function() print("removed old") end)
							exports.rcore_radiocar:GiveRadioToCar(newPlate, function() print("added new") end)
						end
					end)
				else
					TriggerClientEvent("usa:notify", src, "Blacklisted phrase found")
				end
			else
				TriggerClientEvent("usa:notify", src, "Plate already taken!")
			end
		else
			TriggerClientEvent("usa:notify", src, "You need at least " .. exports.globals:comma_value(CUSTOM_PLATE_PRICE) .. ' in the bank!')
		end
	else
		TriggerClientEvent("usa:notify", src, "You don't own that vehicle!")
	end
end)

function getLicenseStatus(src)
	local char = exports["usa-characters"]:GetCharacter(src)
	local license = char.getItem("Driver's License")
	if license then
		if license.status == "suspended" then
			return "suspended"
		else
			return "valid"
		end
	else
		return nil
	end
end

function doesCharacterOwnVehicle(char, plate)
	local vehs = char.get("vehicles")
	for i = 1, #vehs do
		if plate == vehs[i] then
			return true
		end
	end
	return false
end

function containsBlacklistedPhrase(plate)
	for i = 1, #BLACKLISTED_PLATE_PHRASES do
		local phrase = BLACKLISTED_PLATE_PHRASES[i]
		if plate:find(phrase:upper()) then
			return true
		end
	end
	return false
end

function getVehicleDBDoc(plate)
	local ret = nil
	TriggerEvent("es:exposeDBFunctions", function(db)
		db.getDocumentById("vehicles", plate, function(doc)
			if doc then
				ret = doc
			else
				ret = "failed"
			end
		end)
	end)
	while not ret do
		Wait(50)
	end
	if ret == "failed" then
		ret = nil
	end
	return ret
end

function updateNitroDocIdentifier(old, new)
	TriggerEvent("es:exposeDBFunctions", function(db)
		db.getDocumentById("vehicle-nitro-fuel", old, function(doc)
			if doc then
				doc._id = nil
				doc._rev = nil
				db.deleteDocument("vehicle-nitro-fuel", old, function(ok)
					db.createDocumentWithId("vehicle-nitro-fuel", doc, new, function(ok) end)
				end)
			end
		end)
	end)
end