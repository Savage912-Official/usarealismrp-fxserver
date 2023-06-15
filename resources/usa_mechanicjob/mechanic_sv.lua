exports["globals"]:PerformDBCheck("usa_mechanicjob", "mechanicjob")
exports["globals"]:PerformDBCheck("usa_mechanicjob", "vehicle-underglow")
exports["globals"]:PerformDBCheck("usa_mechanicjob", "mechanic-part-orders")
exports["globals"]:PerformDBCheck("usa_mechanicjob", "mechanic-part-deliveries")

local NEEDS_TO_BE_CLOCKED_IN = true

local TOW_REWARD = {850, 1250}

local TRUCKS_FOR_RANK = {
	[1] = {"flatbed"},
	[2] = {"flatbed", "fordflatbed"},
	[3] = {"flatbed", "isgtow", "fordflatbed", "wrecker"}
}

local PARTS_FOR_RANK = {
	[1] = {},
	[2] = {"NOS Install Kit", "NOS Bottle (Stage 1)", "NOS Bottle (Stage 2)", "Top Speed Tune", "NOS Gauge", "Custom Radio", "Low Grip Tires", "Normal Tires", "RGB Controller", "Underglow Kit", "Xenon Headlights", "Stage 1 Brakes", "5% Window Tint", "20% Window Tint", "35% Window Tint", "Tint Remover", "Stage 1 Transmission", "Stage 1 Intake", "Turbo", "Car Wash Kit"},
	[3] = {"NOS Install Kit", "NOS Bottle (Stage 1)", "NOS Bottle (Stage 2)", "NOS Bottle (Stage 3)", "Top Speed Tune", "NOS Gauge", "Custom Radio", "Manual Conversion Kit", "Auto Conversion Kit", "RGB Controller", "Low Grip Tires", "Normal Tires", "Underglow Kit", "Xenon Headlights", "Stage 1 Brakes", "Stage 2 Brakes", "5% Window Tint", "20% Window Tint", "35% Window Tint", "Tint Remover", "Stage 1 Transmission", "Stage 2 Transmission", "Stage 1 Intake", "Stage 2 Intake", "Turbo", "20% Armor", "Repair Kit", "Car Wash Kit"}
}

local PARTS_DELIVERY_TIME_DAYS = 1

local installQueue = {}

RegisterServerEvent("towJob:giveReward")
AddEventHandler("towJob:giveReward", function(securityToken)
	local src = source
	if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), src, securityToken) then
		return false
	end
	local char = exports["usa-characters"]:GetCharacter(src)
	if char.get("job") == "mechanic" then
		local amountRewarded = math.random(TOW_REWARD[1], TOW_REWARD[2])
		char.giveMoney(amountRewarded)
		TriggerClientEvent('usa:notify', src, 'Vehicle impounded, you have received: ~y~$'..amountRewarded..'.00')
		print("TOW: " .. GetPlayerName(src) .. "["..GetPlayerIdentifier(src).."] has received amount["..amountRewarded..'] for impounding vehicle!')
	else
		DropPlayer(src, "Exploiting. Your information has been logged and staff has been notified. If you feel this was by mistake, let a staff member know.")
    	TriggerEvent("usa:notifyStaff", '^1^*[ANTICHEAT]^r^0 Player ^1'..GetPlayerName(src)..' ['..GetPlayerIdentifier(src)..'] ^0 has been kicked for attempting to exploit towJob:giveReward event, please intervene^0!')
    end
end)

TriggerEvent('es:addCommand', 'tow', function(source, args, char)
	TriggerClientEvent('towJob:towVehicle', source)
end, {
	help = "Load or unload the car in front of you onto a flatbed."
})

TriggerEvent('es:addJobCommand', 'install', { "mechanic" }, function(source, args, char)
	TriggerClientEvent("usa:notify", source, "Command no longer used", "^0The /install Command no longer used, press 'use' on a car part instead in your inventory")
end, {
	help = "Command no longer used, press 'use' on a car part instead in your inventory"
})

RegisterServerEvent("mechanic:usedPart")
AddEventHandler("mechanic:usedPart", function(part, nearbyVehPlate)
	tryInstallPart(source, part, nearbyVehPlate)
end)

RegisterServerEvent("towJob:setJob")
AddEventHandler("towJob:setJob", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local repairs = nil
	if char.get("job") == "mechanic" then
		TriggerClientEvent("towJob:offDuty", source)
		char.set("job", "civ")
		TriggerClientEvent("thirdEye:updateActionsForNewJob", source, "civ")
	else
		local drivers_license = char.getItem("Driver's License")
		if drivers_license then
			if drivers_license.status == "valid" then
				local usource = source
				char.set("job", "mechanic")
				TriggerClientEvent("thirdEye:updateActionsForNewJob", source, "mechanic")
				local ident = char.get("_id")
				MechanicHelper.getMechanicRepairCount(ident, function(repairCount)
					if repairCount >= Config.LEVEL_3_RANK_THRESH then
						TriggerClientEvent("towJob:onDuty", usource, true)
					else
						TriggerClientEvent("towJob:onDuty", usource, false)
					end
				end)
				return
			else
				TriggerClientEvent("usa:notify", source, "Your driver's license is ~y~suspended~s~!")
				return
			end
		end
		if not has_dl then
			TriggerClientEvent("usa:notify", source, "You do not have a driver's license!")
			return
		end
	end
end)

RegisterServerEvent("tow:forceRemoveJob")
AddEventHandler("tow:forceRemoveJob", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	char.set("job", "civ")
	TriggerClientEvent("thirdEye:updateActionsForNewJob", source, "civ")
	TriggerClientEvent("towJob:offDuty", source)
end)

RegisterServerEvent("mechanic:repairJobCheck")
AddEventHandler("mechanic:repairJobCheck", function()
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(usource)
	if NEEDS_TO_BE_CLOCKED_IN and char.get("job") ~= "mechanic" then
		TriggerClientEvent("usa:notify", source, "Must be on duty as mechanic!")
		return
	end
	local kit = char.getItem("Mechanic Tools")
	if kit then
		local ident = char.get("_id")
		MechanicHelper.getMechanicRepairCount(ident, function(repairCount)
			TriggerClientEvent("mechanic:repair", usource, repairCount)
		end)
	else 
		TriggerClientEvent("usa:notify", source, "You need a repair kit!")
	end
end)

RegisterServerEvent("mechanic:vehicleRepaired")
AddEventHandler("mechanic:vehicleRepaired", function()
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(usource)
	local ident = char.get("_id")
	MechanicHelper.incrementStat(ident, "repairCount", function(updatedVal)
		TriggerClientEvent("usa:notify", usource, "You have repaired " .. updatedVal .. " vehicle(s)!", "^3INFO: ^0You have repaired " .. updatedVal .. " vehicle(s)!")
		if updatedVal == Config.LEVEL_2_RANK_THRESH then -- notify of rank up
			TriggerClientEvent("usa:notify", usource, "You have reached mechanic level 2!", "^3INFO: ^0You have reached mechanic level 2!")
		end
	end)
end)

RegisterServerEvent("mechanic:installedUpgrade")
AddEventHandler("mechanic:installedUpgrade", function(plate, vehNetId, rank)
	print("installed upgrade! veh net id: " .. vehNetId)
	local usource = source
	local upgrade = UPGRADES[installQueue[usource]]
	local char = exports["usa-characters"]:GetCharacter(usource)
	plate = exports.globals:trim(plate)
	if upgrade then
		MechanicHelper.upgradeInstalled(plate, upgrade, function()
			installQueue[usource] = nil
			if upgrade.doSync then
				TriggerClientEvent("mechanic:syncUpgrade", -1, vehNetId, upgrade)
			end
			if upgrade.requiresItem then
				char.removeItem(upgrade.requiresItem, 1)
			end
		end)
	end
end)

RegisterServerEvent("mechanic:giveRepairKit")
AddEventHandler("mechanic:giveRepairKit", function(plate)
	plate = exports.globals:trim(plate)
	local repairKit = { name = "Mechanic Tools", price = 250, type = "vehicle", quantity = 1, legality = "legal", weight = 20, objectModel = "imp_prop_tool_box_01a"}
	TriggerEvent("vehicle:storeItemInFirstFreeSlot", source, plate, repairKit, false, function(success, inv) end)
end)

RegisterServerEvent("mechanic:spawnTruck")
AddEventHandler("mechanic:spawnTruck", function()
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(usource)
	local ident = char.get("_id")
	MechanicHelper.getMechanicRepairCount(ident, function(repairCount)
		TriggerClientEvent("mechanic:spawnTruck", usource, repairCount)
	end)
end)

RegisterServerEvent("mechanic:openTruckSpawnMenu")
AddEventHandler("mechanic:openTruckSpawnMenu", function()
	local src = source
	local char = exports["usa-characters"]:GetCharacter(src)
	MechanicHelper.getMechanicRank(char.get("_id"), function(rank)
		if rank == 0 then rank = 1 end -- if no DB doc yet, just use rank 1
		local availableTrucks = TRUCKS_FOR_RANK[rank]
		TriggerClientEvent("mechanic:openTruckSpawnMenuCL", src, availableTrucks)
	end)
end)

RegisterServerEvent("mechanic:openPartsMenu")
AddEventHandler("mechanic:openPartsMenu", function()
	local src = source
	local char = exports["usa-characters"]:GetCharacter(src)
	if char.get("job") == "mechanic" then
		MechanicHelper.getMechanicRank(char.get("_id"), function(rank)
			if rank == 0 then rank = 1 end
			local availableParts = PARTS_FOR_RANK[rank]
			MechanicHelper.getMechanicInfo(char.get("_id"), function(info)
				if not info then
					info = {}
				end
				if not info.orderedParts then
					info.orderedParts = {}
				end
				if not info.deliveredParts then
					info.deliveredParts = {}
				end
				info.orderedParts = updateDeliveryProgress(char, info.orderedParts)
				TriggerClientEvent("mechanic:openMechanicShopMenuCL", src, rank, availableParts, info.orderedParts, info.deliveredParts, os.time())
			end)
		end)
	else
		TriggerClientEvent("usa:notify", src, "Not signed in!")
	end
end)

RegisterServerEvent("mechanic:orderPart")
AddEventHandler("mechanic:orderPart", function(partName)
	local src = source
	local char = exports["usa-characters"]:GetCharacter(src)
	MechanicHelper.getMechanicRank(char.get("_id"), function(rank)
		if doesRankHaveAccessToPart(rank, partName) then
			if char.get("bank") >= PARTS[partName].price then
				local orderedPart = exports.globals:deepCopy(PARTS[partName])
				orderedPart.uuid = exports.globals:generateID()
				orderedPart.orderedTime = os.time()
				orderedPart.expectedDeliveryTimeDays = PARTS_DELIVERY_TIME_DAYS
				orderedPart.owner = char.get("_id")
				local ok = exports.essentialmode:createDocumentWithId("mechanic-part-orders", orderedPart.uuid, orderedPart)
				if ok then
					char.removeBank(orderedPart.price, "Mechanic Order ("..partName..")")
					local orderedParts = (exports.essentialmode:getDocumentsByRows("mechanic-part-orders", query) or {})
					TriggerClientEvent("mechanicMenu:sendDataToApp", src, { showNotification = true, notificationText = orderedPart.name .. " ordered for $" .. exports.globals:comma_value(orderedPart.price), orderedParts = orderedParts})
				end
			else
				TriggerClientEvent("usa:notify", src, "Not enough money! Need: $" .. exports.globals:comma_value(PARTS[partName].price))
			end
		end
	end)
end)

RegisterServerEvent("mechanic:claimDelivery")
AddEventHandler("mechanic:claimDelivery", function(partId)
	local src = source
	local char = exports["usa-characters"]:GetCharacter(src)
	local charCoords = GetEntityCoords(GetPlayerPed(src))
	local part = exports.essentialmode:getDocument("mechanic-part-deliveries", partId)
	if part then
		local newCoords = {}
		newCoords.x = charCoords.x + (math.random() * 2)
		newCoords.y = charCoords.y + (math.random() * 2)
		newCoords.z = charCoords.z - 0.8
		part.coords = newCoords
		TriggerEvent("interaction:addDroppedItem", part)
		exports.essentialmode:deleteDocument("mechanic-part-deliveries", partId)
		local query = {
			owner = char.get("_id")
		}
		local allDeliveries = (exports.essentialmode:getDocumentsByRows("mechanic-part-deliveries", query) or {})
		TriggerClientEvent("mechanicMenu:sendDataToApp", src, { showNotification = true, notificationText = part.name .. " claimed!", deliveredParts = allDeliveries })
	end
end)

RegisterServerEvent("mechanic:fetchDeliveryProgress")
AddEventHandler("mechanic:fetchDeliveryProgress", function()
	local src = source
	local char = exports["usa-characters"]:GetCharacter(src)
	local query = {
		["owner_identifier"] = char.get("_id")
	}
	local fields = {
		"_id",
		"orderedParts",
	}
	MechanicHelper.db.getSpecificFieldFromDocumentByRows("mechanicjob", query, fields, function(doc)
		if doc then
			if not doc.orderedParts then doc.orderedParts = {} end
			updateDeliveryProgress(char, doc.orderedParts)
		end
	end)
end)

AddEventHandler("playerDropped", function(reason)
	if installQueue[source] then 
		installQueue[source] = nil
	end
end)

function GetUpgradeObjectsFromIds(upgradeIds)
	local ret = {}
	if upgradeIds then
		for i = 1, #upgradeIds do 
			local id = upgradeIds[i]
			table.insert(ret, UPGRADES[id])
		end
	end
	return ret
end

function doesRankHaveAccessToPart(rank, partName)
	local availableParts = PARTS_FOR_RANK[rank]
	for i = 1, #availableParts do
		if partName == availableParts[i] then
			return true
		end
	end
	return false 
end

function updateDeliveryProgress(char, orders)
	if not orders then
		orders = {}
	end
	local newDeliveries = {}
	for i = #orders, 1, -1 do
		orders[i].deliveryProgress = math.min((os.difftime(os.time(), orders[i].orderedTime) / (60 * 60)) / 24, 1.0)
		if orders[i].deliveryProgress == 1.0 then -- is delivered
			table.insert(newDeliveries, orders[i])
			table.remove(orders, i)
		end
	end
	local query = {
		["owner_identifier"] = char.get("_id")
	}
	local fields = {
		"_id",
		"deliveredParts",
	}
	MechanicHelper.db.getSpecificFieldFromDocumentByRows("mechanicjob", query, fields, function(doc)
		if doc then
			if not doc.deliveredParts then
				doc.deliveredParts = {}
			end
			for i = 1, #newDeliveries do
				local wasAlreadyInserted = false -- we were seeing ordered parts being doubled when delivered... so let's ensure that won't happen here..
				for j = 1, #doc.deliveredParts do
					if doc.deliveredParts[j].uuid == newDeliveries[i].uuid then
						wasAlreadyInserted = true
						break
					end
				end
				if not wasAlreadyInserted then
					newDeliveries[i]._rev = nil
					exports.essentialmode:createDocumentWithId("mechanic-part-deliveries", newDeliveries[i].uuid, newDeliveries[i])
					exports.essentialmode:deleteDocument("mechanic-part-orders", newDeliveries[i].uuid)
				end
			end
		else
			print("no doc found when updating delivery progress")
		end
	end)
	return orders
end

function tryInstallPart(src, part, plate)
	print("trying to install " .. part.name .. " on veh with plate: " .. plate)
	local upgrade = getUpgradeFromPartName(part.name)
	if upgrade then
		local char = exports["usa-characters"]:GetCharacter(src)
		if upgrade.requiresItem then
			if not char.hasItem(upgrade.requiresItem) then
				TriggerClientEvent("usa:notify", src, "Need: " .. upgrade.requiresItem)
				return
			end
		end
		if upgrade.requiresUpgrades then
			if not MechanicHelper.doesVehicleHaveUpgrades(plate, upgrade.requiresUpgrades) then
				TriggerClientEvent("usa:notify", src, "Vehicle is missing required upgrades!")
				for i = 1, #upgrade.requiresUpgrades do
					TriggerClientEvent("usa:notify", src, "Need: " .. upgrade.requiresUpgrades[i])
				end
				return
			end
		end
		MechanicHelper.getMechanicRank(char.get("_id"), function(rank)
			if rank >= 2 then
				TriggerClientEvent('mechanic:tryInstall', src, upgrade, rank)
				installQueue[src] = upgrade.id
			else 
				TriggerClientEvent("usa:notify", src, "Must be lvl 2 or higher to install upgrades!", "^3INFO: ^0Must be a level 2 mechanic to install upgrades! Respond to more player calls and repair vehicles to rank up!")
			end
		end)
	end
end

function getUpgradeFromPartName(name)
	for k, v in pairs(UPGRADES) do
		if v.displayName == name then
			return v
		end
	end
end

function getNameFromCharId(id)
	local char = exports.essentialmode:getDocument("characters", id)
	if char then
		return char.name.first .. " " .. char.name.last
	else
		return nil
	end
end

function fetchLeaderboard()
	local allMechanics = exports.essentialmode:getAllDocuments("mechanicjob")
	local only50 = {}
	table.sort(allMechanics, function(a, b)
		return a.repairCount > b.repairCount
	end)
	for i = 1, 50 do
		if allMechanics[i] then
			allMechanics[i].name = getNameFromCharId(allMechanics[i].owner_identifier)
			if allMechanics[i].name then
				table.insert(only50, allMechanics[i])
			end
		end
	end
	return only50
end

--[[
	- attributes to make fully persistant -
	engine hp
	body hp
	dirt level
	tires popped
	door broken
]]

RegisterServerCallback {
	eventName = "mechanic:getUnderglow",
	eventCallback = function(src, vehPlate)
		vehPlate = exports.globals:trim(vehPlate)
		local doc = exports.essentialmode:getDocument("vehicle-underglow", vehPlate)
		return doc
	end
}

RegisterServerCallback {
	eventName = "mechanic:getVehicleUpgrades",
	eventCallback = function(src, vehPlate)
		vehPlate = exports.globals:trim(vehPlate)
		local doc = exports.essentialmode:getDocument("vehicles", vehPlate)
		return doc and doc.upgrades or nil
	end
}

RegisterServerCallback {
	eventName = "mechanic:getRepairCount",
	eventCallback = function(src)
		local retVal = nil
		local char = exports["usa-characters"]:GetCharacter(src)
		MechanicHelper.getMechanicRepairCount(char.get("_id"), function(count)
			retVal = count
		end)
		while retVal == nil do
			Wait(1)
		end
		return retVal
	end
}

RegisterServerCallback {
	eventName = "mechanic:loadMenuData",
	eventCallback = function(src)
		local ret = nil
		local src = source
		local char = exports["usa-characters"]:GetCharacter(src)
		if char.get("job") == "mechanic" then
			MechanicHelper.getMechanicRank(char.get("_id"), function(rank)
				if rank == 0 then rank = 1 end
				local availableParts = exports.globals:deepCopy(PARTS_FOR_RANK[rank])
				for i = 1, #availableParts do
					availableParts[i] = {
						name = availableParts[i],
						price = PARTS[availableParts[i]].price
					}
				end
				local info = {}
				info.rank = rank
				info.availableParts = availableParts
				info.playerName = char.getName()
				info.lvl2RequiredRepairCount = Config.LEVEL_2_RANK_THRESH
				ret = info
			end)
			while ret == nil do
				Wait(1)
			end
			return ret
		else
			TriggerClientEvent("usa:notify", src, "Not signed in!")
		end
	end
}

RegisterServerCallback {
	eventName = "mechanic:fetchOrders",
	eventCallback = function(src)
		local char = exports["usa-characters"]:GetCharacter(src)
		local query = {
			owner = char.get("_id")
		}
		local orderedParts = (exports.essentialmode:getDocumentsByRows("mechanic-part-orders", query) or {})
		orderedParts = updateDeliveryProgress(char, orderedParts)
		table.sort(orderedParts, function(a, b)
			return a.orderedTime < b.orderedTime
		end)
		return orderedParts
	end
}

RegisterServerCallback {
	eventName = "mechanic:fetchDeliveries",
	eventCallback = function(src)
		local char = exports["usa-characters"]:GetCharacter(src)
		local query = {
			owner = char.get("_id")
		}
		local deliveries = (exports.essentialmode:getDocumentsByRows("mechanic-part-deliveries", query) or {})
		table.sort(deliveries, function(a, b)
			return a.orderedTime < b.orderedTime
		end)
		return deliveries
	end
}

RegisterServerCallback {
	eventName = "mechanic:fetchLeaderboard",
	eventCallback = function(src)
		return fetchLeaderboard()
	end
}

RegisterServerEvent("mechanic:saveUnderglow")
AddEventHandler("mechanic:saveUnderglow", function(plate, r, g, b)
	exports.essentialmode:updateDocument("vehicle-underglow", plate, { r = r, g = g, b = b }, true)
end)

AddEventHandler("character:loaded", function(char) -- migration from old db format
	MechanicHelper.getMechanicInfo(char.get("_id"), function(info)
		if info then
			if info.orderedParts then
				for i = #info.orderedParts, 1, -1 do
					info.orderedParts[i]._rev = nil
					info.orderedParts[i].owner = char.get("_id")
					local ok = exports.essentialmode:createDocumentWithId("mechanic-part-orders", info.orderedParts[i].uuid, info.orderedParts[i])
					if ok then
						table.remove(info.orderedParts, i)
					end
				end
			end
			if info.deliveredParts then
				for i = #info.deliveredParts, 1, -1 do
					info.deliveredParts[i]._rev = nil
					info.deliveredParts[i].owner = char.get("_id")
					local ok = exports.essentialmode:createDocumentWithId("mechanic-part-deliveries", info.deliveredParts[i].uuid, info.deliveredParts[i])
					if ok then
						table.remove(info.deliveredParts, i)
					end
				end
			end
			exports.essentialmode:updateDocument("mechanicjob", info._id, { deliveredParts = "deleteMePlz!", orderedParts = "deleteMePlz!" })
		end
	end)
end)
