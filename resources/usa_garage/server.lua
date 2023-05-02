--# Public vehicle parking garages to store player vehicles
--# For: USA Realism RP
--# By: minipunch

local WITHDRAW_FEE = 50
local IMPOUND_BASE_FEE = 500
local AUTOMATIC_TOW_SERVICE_FEE = 500
local AUTOMATIC_TOW_DISTANCE_PER_UNIT_FEE = 0.85
local POLICE_IMPOUND_STORAGE_COST_PER_DAY = 800

local recentlyChangedPlates = {}

RegisterServerEvent("garage:notifyOfPlateChange")
AddEventHandler("garage:notifyOfPlateChange", function(src, oldPlate, newPlate)
	print("adding recently changed plate!")
	local c = exports["usa-characters"]:GetCharacter(src)
	recentlyChangedPlates[c.get("_id")] = {}
	recentlyChangedPlates[c.get("_id")][oldPlate] = newPlate
end)

RegisterServerEvent("garage:giveKey")
AddEventHandler("garage:giveKey", function(key, src)
	if src then source = src end
	local char = exports["usa-characters"]:GetCharacter(source)
	local invKey = char.getItemWithField("plate", key.plate)
	if not invKey then
		char.giveItem(key)
	end
	-- add to server side list of plates being tracked for locking resource:
	TriggerEvent("lock:addPlate", key.plate)
end)

RegisterServerEvent("garage:storeKey")
AddEventHandler("garage:storeKey", function(plate)
	local char = exports["usa-characters"]:GetCharacter(source)
	local key = char.getItemWithField("plate", plate)
	if key then
		char.removeItem(key, 1)
		TriggerEvent("lock:removePlate", key.plate)
	end
end)

RegisterServerEvent("garage:storeVehicle")
AddEventHandler("garage:storeVehicle", function(handle, numberPlateText, required_jobs, garageCoords)
	local char = exports["usa-characters"]:GetCharacter(source)
	local isAuthorized = false
	local usource = source

	if required_jobs then
		local job = char.get("job")
		for i = 1, #required_jobs do
			if job == required_jobs[i] or (required_jobs[i] == 'sheriff' and char.get('policeRank') > 0) or (required_jobs[i] == 'corrections' and char.get('bcsoRank') > 0) or (required_jobs[i] == 'ems' and char.get('emsRank') > 0) or (required_jobs[i] == 'doctor' and char.get('emsRank') > 0) then
				isAuthorized = true
				break
			end
		end
	else
		isAuthorized = true
	end

	if isAuthorized then
		-- does player own vehicle as determined by the list of plates of their vehicles?
		local vehicles = char.get("vehicles")
		for i = 1, #vehicles do
			local vehicle = vehicles[i]
			if numberPlateText and vehicle then
				numberPlateText = exports.globals:trim(numberPlateText)
				if numberPlateText == vehicle then -- make sure player owns it
					TriggerEvent('es:exposeDBFunctions', function(couchdb)
						couchdb.updateDocument("vehicles", numberPlateText, { stored = true, stored_location = garageCoords }, function(doc, err, rtext)
							TriggerClientEvent("garage:storeVehicle", usource)
						end)
					end)
					return
				end
			end
		end
		-- no, so was plate recently changed?
		if recentlyChangedPlates[char.get("_id")] and recentlyChangedPlates[char.get("_id")][numberPlateText] then
			TriggerEvent('es:exposeDBFunctions', function(couchdb)
				local newPlate = recentlyChangedPlates[char.get("_id")][numberPlateText]
				couchdb.updateDocument("vehicles", newPlate, { stored = true }, function(doc, err, rtext)
					TriggerClientEvent("garage:storeVehicle", usource)
					recentlyChangedPlates[char.get("_id")][numberPlateText] = nil
				end)
			end)
			return
		end
		-- nope to either, just notify and abort
		TriggerClientEvent("usa:notify", usource, "You do not own that vehicle!")
		return
	else
		TriggerClientEvent("usa:notify", usource, "Garage prohibited!")
	end
end)

-- ask to retrieve vehicle from garage --
RegisterServerEvent("garage:vehicleSelected")
AddEventHandler("garage:vehicleSelected", function(vehicle, business, playerCoords, garageCoords)
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(source)
	local vehicles = char.get("vehicles")
	local money = char.get("money")
	local wasPoliceImpounded = false

	if vehicle.stored_location then
		local varType = type(vehicle.stored_location)
		if varType == "string" then -- means it is stored at a property (will be the name of the property)
			TriggerClientEvent("usa:notify", usource, "~y~Sorry!~s~ That vehicle is not stored at any of our garages.")
			return
		elseif varType == "table" then -- means it is stored at a public garage (will be an object with x,y,z coords)
			local storedGarageCoords = vector3(vehicle.stored_location.x, vehicle.stored_location.y, vehicle.stored_location.z)
			local atGarageCoordsVector = vector3(garageCoords.x, garageCoords.y, garageCoords.z)
			if #(atGarageCoordsVector - storedGarageCoords) > 15 then
				local automaticTowCost = calculateAutomaticTowCost(storedGarageCoords, atGarageCoordsVector)
				TriggerClientEvent("garage:toggleModal", usource, vehicle.plate, vehicle.stored_location, automaticTowCost, atGarageCoordsVector)
				return
			end
		end
	end

	vehicle.upgrades = exports["usa_mechanicjob"]:GetUpgradeObjectsFromIds(vehicle.upgrades)
	if vehicle.impounded == true then
		local impoundStorageFee = IMPOUND_BASE_FEE
		local policeImpoundInfo = exports.essentialmode:getDocument("police-impounded-vehicles", vehicle.plate)
		if policeImpoundInfo then
			local daysSinceImpound = exports.globals:GetHoursFromTime(policeImpoundInfo.time) / 24
			if daysSinceImpound <= policeImpoundInfo.days then
				TriggerClientEvent("usa:notify", usource, false, "^3STATE IMPOUND: ^0Your vehicle is being held by police for " .. (policeImpoundInfo.days - daysSinceImpound) .. " more day(s)")	
				return
			else
				impoundStorageFee = impoundStorageFee + (POLICE_IMPOUND_STORAGE_COST_PER_DAY * policeImpoundInfo.days)
				wasPoliceImpounded = true
			end
		end
		if hasEnoughMoney(char, impoundStorageFee) then
			TriggerClientEvent("usa:notify", usource, "~y~STATE IMPOUND: ~s~Vehicle retrieved from the impound! Fee: ~y~$"..impoundStorageFee..".00")
			GetVehicleCustomizations(vehicle.plate, function(customizations)
				vehicle.customizations = customizations
				TriggerClientEvent("garage:vehicleStored", usource, vehicle)
				TriggerEvent('es:exposeDBFunctions', function(couchdb)
					couchdb.updateDocument("vehicles", vehicle.plate, { impounded = false, stored = false, stored_location = "deleteMePlz!" }, function()
						removeMoney(char, impoundStorageFee)
						if business then
							exports["usa-businesses"]:GiveBusinessCashPercent(business, impoundStorageFee)
						end
						if wasPoliceImpounded then
							exports.essentialmode:deleteDocument("police-impounded-vehicles", vehicle.plate)
						end
					end)
				end)
			end)
		else
			TriggerClientEvent("usa:notify", usource, "~y~STATE IMPOUND: ~s~Your vehicle is impounded and can be retrieved for ~y~$"..impoundStorageFee..".00~s~!")
		end
	elseif vehicle.stored == true then
		local doPay = true
		if isAtProperty(char, playerCoords) then
			doPay = false
		end
		if doPay and not hasEnoughMoney(char, WITHDRAW_FEE) then
			TriggerClientEvent("usa:notify", usource, "Your vehicle can be retrieved for a fee of ~y~$".. WITHDRAW_FEE ..".00~s~!")
			return
		end
		GetVehicleCustomizations(vehicle.plate, function(customizations)
			vehicle.customizations = customizations
			TriggerClientEvent("garage:vehicleStored", usource, vehicle)
			TriggerEvent('es:exposeDBFunctions', function(couchdb)
				couchdb.updateDocument("vehicles", vehicle.plate, { stored = false, stored_location = "deleteMePlz!" }, function()
					if doPay then
						removeMoney(char, WITHDRAW_FEE)
						TriggerClientEvent("usa:notify", usource, "Vehicle retrieved from garage! Fee: ~y~$" .. WITHDRAW_FEE ..'.00')
					else 
						TriggerClientEvent("usa:notify", usource, "Vehicle retrieved from garage!")
					end
				end)
			end)
		end)
	end
end)

RegisterServerEvent("garage:openMenu")
AddEventHandler("garage:openMenu", function(required_jobs, _closest_shop)
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(source)
	if required_jobs then
		local job = char.get("job")
		for i = 1, #required_jobs do
			if required_jobs[i] == job or (required_jobs[i] == 'sheriff' and char.get('policeRank') > 0) or (required_jobs[i] == 'corrections' and char.get('bcsoRank') > 0) or (required_jobs[i] == 'ems' and char.get('emsRank') > 0) or (required_jobs[i] == 'doctor' and char.get('emsRank') > 0) then
				GetVehiclesForMenu(char.get("vehicles"), function(vehs)
					TriggerClientEvent("garage:openMenuWithVehiclesLoaded", usource, vehs)
				end)
				return
			end
		end
		TriggerClientEvent("usa:notify", usource, "Garage prohibited!")
	else
		GetVehiclesForMenu(char.get("vehicles"), function(vehs)
			TriggerClientEvent("garage:openMenuWithVehiclesLoaded", usource, vehs, _closest_shop)
		end)
	end
end)

RegisterServerEvent("garage:automaticTow")
AddEventHandler("garage:automaticTow", function(vehPlate, garageCoords)
	local src = source
	local char = exports["usa-characters"]:GetCharacter(src)
	-- calculate cost (distance from player to veh stored location)
	local storedCoords = exports.essentialmode:getDocument("vehicles", vehPlate).stored_location
	storedCoords = vector3(storedCoords.x, storedCoords.y, storedCoords.z)
	local cost = calculateAutomaticTowCost(storedCoords, garageCoords)
	if hasEnoughMoney(char, cost) then
		-- update vehicle stored_location to garageCoords
		local new = { x = garageCoords.x, y = garageCoords.y, z = garageCoords.z }
		exports.essentialmode:updateDocument("vehicles", vehPlate, { stored_location = new })
		-- take money from user
		removeMoney(char, cost)
		-- notify
		TriggerClientEvent("usa:notify", src, "Vehicle transfered!", "INFO: Vehicle transfer successful!")
	else
		TriggerClientEvent("usa:notify", src, "Not enough money!", "INFO: Not enough money!")
	end
end)

function GetVehiclesForMenu(plates, cb)
	local endpoint = "/vehicles/_design/vehicleFilters/_view/getVehiclesForGarageMenu"
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
						model = data.rows[i].value[3], -- model
						impounded = data.rows[i].value[4], -- impounded
						stored = data.rows[i].value[5], -- stored
						hash = data.rows[i].value[6], -- hash
						owner = data.rows[i].value[7], -- owner
						stats = data.rows[i].value[8], -- vehicle stats
						upgrades = data.rows[i].value[9], -- vehicle upgrades
						stored_location = data.rows[i].value[10], -- stored_location
					}
					table.insert(responseVehArray, veh)
				end
			end
			cb(responseVehArray)
		end
	end, "POST", json.encode({
		keys = plates
	}), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

function GetVehicleCustomizations(plate, cb)
	local endpoint = "/vehicles/_design/vehicleFilters/_view/getVehicleCustomizationsByPlate"
	local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
	PerformHttpRequest(url, function(err, responseText, headers)
		if responseText then
			local customizations = {}
			local data = json.decode(responseText)
			if data.rows and data.rows[1].value then
				customizations = data.rows[1].value[1] -- customizations
			end
			cb(customizations)
		end
	end, "POST", json.encode({
		keys = { plate }
	}), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

function IsDriverLicenseValid(source)
	local char = exports["usa-characters"]:GetCharacter(source)
	local license = char.getItem("Driver's License")
	if license and license.status == "valid" then
		return true
	end
	return false
end

function isAtProperty(char, coords)
	local gcoords = char.get("property")["garageCoords"]
	if not gcoords then
		return false
	end
	return exports.globals:getCoordDistance({x = gcoords[1], y = gcoords[2], z = gcoords[3]}, coords) < 10.0
end

function calculateAutomaticTowCost(startCoord, endCoord)
	local dist = #(startCoord - endCoord)
	local cost = AUTOMATIC_TOW_SERVICE_FEE + (AUTOMATIC_TOW_DISTANCE_PER_UNIT_FEE * dist)
	return math.floor(cost)
end

function hasEnoughMoney(char, amount)
	if char.get("money") >= amount then
		return true
	elseif char.get("bank") >= amount then
		return true
	else
		return false
	end
end

function removeMoney(char, amount)
	amount = math.abs(amount)
	if char.get("money") >= amount then
		char.removeMoney(amount)
	elseif char.get("bank") >= amount then
		char.removeBank(amount, "LS Garage System")
	end
end

RegisterServerCallback {
	eventName = "garage:getVehicleList",
	eventCallback = function(src)
		local char = exports["usa-characters"]:GetCharacter(src)
		local waiting = true
		local ret = nil
		local mycoords = GetEntityCoords(GetPlayerPed(src))
		GetVehiclesForMenu(char.get("vehicles"), function(vehs)
			for i = 1, #vehs do
				if vehs[i].stored_location then
					local varType = type(vehs[i].stored_location)
					if varType == "string" then
						vehs[i].storedStatus = vehs[i].stored_location
					elseif varType == "table" then
						if #(mycoords - vector3(vehs[i].stored_location.x, vehs[i].stored_location.y, vehs[i].stored_location.z)) > 15 then
							vehs[i].storedStatus = "Other Garage"
						else
							vehs[i].storedStatus = "Stored"
						end
					end
				elseif vehs[i].impounded == true then
					vehs[i].storedStatus = "Impounded"
				elseif vehs[i].stored == false then
					vehs[i].storedStatus = "Not stored"
				else
					vehs[i].storedStatus = "Stored"
				end
			end
			ret = vehs
			waiting = false
		end)
		while waiting do
			Wait(1)
		end
		return ret
	end
}
