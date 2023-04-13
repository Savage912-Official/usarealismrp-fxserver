local DROPPED_ITEMS = {}

local ITEM_EXPIRE_CHECK_INTERVAL = 30000 -- ms
local ITEM_EXPIRE_TIME = 45 -- minutes

local peopleViewingDroppedItems = {}

RegisterServerEvent("interaction:getDroppedItems")
AddEventHandler("interaction:getDroppedItems", function()
	TriggerClientEvent("interaction:getDroppedItems", source, DROPPED_ITEMS)
end)

RegisterServerEvent("interaction:addDroppedItem")
AddEventHandler("interaction:addDroppedItem", function(item)
	if not item.uuid then
		item.uuid = exports.globals:generateID()
	end
	item.dropTime = os.time()
	table.insert(DROPPED_ITEMS, item)
	TriggerClientEvent("interaction:addDroppedItem", -1, item)
	if item.name and item.name:find("Spike Strips") and item.coords then
		TriggerEvent("spikestrips:addStrip", item.coords)
	end
	for otherViewingSrc, yes in pairs(peopleViewingDroppedItems) do
		local nearbyItemsInv = getNearbyItemsAsInventoryForGUI(GetEntityCoords(GetPlayerPed(otherViewingSrc)))
		TriggerClientEvent("interaction:sendNUIMessage", otherViewingSrc, { type = "updateSecondaryInventory", inventory = nearbyItemsInv })
	end
end)

RegisterServerEvent("interaction:attemptPickup")
AddEventHandler("interaction:attemptPickup", function(item)
	local usource = source
	for i = #DROPPED_ITEMS, 1, -1 do
		if item.x == DROPPED_ITEMS[i].x and item.y == DROPPED_ITEMS[i].y and item.z == DROPPED_ITEMS[i].z and item.name == DROPPED_ITEMS[i].name then
			local success = attemptPickup(usource, DROPPED_ITEMS[i])
			if success then
				if DROPPED_ITEMS[i].name and DROPPED_ITEMS[i].name:find("Spike Strips") and DROPPED_ITEMS[i].coords then
					TriggerEvent("spikestrips:removeStrip", DROPPED_ITEMS[i].coords)
				end
				TriggerClientEvent("interaction:removeDroppedItem", -1, i)
				table.remove(DROPPED_ITEMS, i)
			end
			TriggerClientEvent("interaction:finishedPickupAttempt", usource)
			break
		end
	end
end)

RegisterServerEvent("interaction:removeDroppedItemAccessor")
AddEventHandler("interaction:removeDroppedItemAccessor", function()
	if peopleViewingDroppedItems[source] then
		peopleViewingDroppedItems[source] = nil
	end
end)

RegisterServerEvent("interaction:attemptPickupByUUID")
AddEventHandler("interaction:attemptPickupByUUID", function(itemUUID, targetIndex, src)
	local itemIndex = getDroppedItemIndexByUUID(itemUUID)
	local droppedItem = DROPPED_ITEMS[itemIndex]
	local ok = attemptPickup(src, droppedItem, targetIndex)
	if ok then
		if droppedItem.name and droppedItem.name:find("Spike Strips") and droppedItem.coords then
			TriggerEvent("spikestrips:removeStrip", droppedItem.coords)
		end
		TriggerClientEvent("interaction:removeDroppedItem", -1, itemIndex)
		table.remove(DROPPED_ITEMS, itemIndex)
		local char = exports["usa-characters"]:GetCharacter(src)
		local nearbyItemsInv = getNearbyItemsAsInventoryForGUI(GetEntityCoords(GetPlayerPed(src)))
		TriggerClientEvent("interaction:sendNUIMessage", src, { type = "updateBothInventories", inventory = { primary = char.get("inventory"), secondary = nearbyItemsInv}})
		-- refresh nearby players who are also looking at nearby items:
		for otherViewingSrc, yes in pairs(peopleViewingDroppedItems) do
			local nearbyItemsInv2 = getNearbyItemsAsInventoryForGUI(GetEntityCoords(GetPlayerPed(otherViewingSrc)))
			TriggerClientEvent("interaction:sendNUIMessage", otherViewingSrc, { type = "updateSecondaryInventory", inventory = nearbyItemsInv2 })
		end
	end
end)

RegisterServerEvent("interaction:attemptPickupWithGUI")
AddEventHandler("interaction:attemptPickupWithGUI", function(coords)
	local inventory = getNearbyItemsAsInventoryForGUI(coords)
	-- open GUI to let player choose items to pick up
	TriggerClientEvent("interaction:openGUIAndSendNUIData", source, {
		type = "showNearbyDroppedItems",
		inv = inventory
	})
	-- record person viewing dropped items so we can refresh them if someone updates it
	peopleViewingDroppedItems[source] = true
end)

RegisterServerEvent("interaction:dropMultipleOfItem")
AddEventHandler("interaction:dropMultipleOfItem", function(item)
	local toSend = {}
	for i = 1, item.quantity do
		local copy = item
		copy.quantity = 1
		copy.dropTime = os.time()
		if not copy.uuid then
			copy.uuid = exports.globals:generateID()
		end
		table.insert(DROPPED_ITEMS, copy)
		table.insert(toSend, copy)
	end
	TriggerClientEvent("interaction:dropMultiple", -1, toSend)
end)

function attemptPickup(src, item, targetIndex)
	if item then
		local char = exports["usa-characters"]:GetCharacter(src)
		if char.canHoldItem(item) then
			if not char.getItemByIndex(targetIndex) then
				char.setItemByIndex(targetIndex, item)
				TriggerClientEvent("usa:notify", src, "You picked up (x1) " .. item.name)
				TriggerClientEvent("usa:playAnimation", src, "anim@move_m@trash", "pickup", -8, 1, -1, 53, 0, 0, 0, 0, 2)
				return true
			else
				TriggerClientEvent("usa:notify", src, "Slot taken")
				return false
			end
		else
			TriggerClientEvent("usa:notify", src, "You can't hold that item! Inventory full.")
			return false
		end
	else
		TriggerClientEvent("usa:notify", src, "Invalid slot")
		return false
	end
end

function getMinutesFromTime(t)
	local reference = t
	local minutesfrom = os.difftime(os.time(), reference) / 60
	local minutes = math.floor(minutesfrom)
	return minutes
end

function getNearbyItemsAsInventoryForGUI(coords)
	local inventory = {
		items = {},
		currentWeight = 0,
		MAX_CAPACITY = 25,
		MAX_WEIGHT = 100,
	}
	-- gather nearby items relative to provided coords
	local toPlaceIndex = 0
	for i = 1, #DROPPED_ITEMS do
		local dist = #(coords - exports.globals:tableToVector3(DROPPED_ITEMS[i].coords))
		if dist < 3.0 then
			inventory.items[tostring(toPlaceIndex)] = DROPPED_ITEMS[i]
			toPlaceIndex = toPlaceIndex + 1
		end
	end
	return inventory
end

function getDroppedItemIndexByUUID(uuid)
	for i = 1, #DROPPED_ITEMS do
		if DROPPED_ITEMS[i].uuid and DROPPED_ITEMS[i].uuid == uuid then
			return i
		end
	end
	return nil
end

-- remove dropped items after ITEM_EXPIRE_TIME minutes --
Citizen.CreateThread(function()
	while true do
		if #DROPPED_ITEMS > 0 then
			for i = #DROPPED_ITEMS, 1, -1 do
				if not DROPPED_ITEMS[i].doNotAutoRemove then
					if (getMinutesFromTime(DROPPED_ITEMS[i].dropTime) > ITEM_EXPIRE_TIME) or (string.find(DROPPED_ITEMS[i].name, 'Key') and getMinutesFromTime(DROPPED_ITEMS[i].dropTime) > 5) then
						if DROPPED_ITEMS[i].name and DROPPED_ITEMS[i].name:find("Spike Strips") and DROPPED_ITEMS[i].coords then
							TriggerEvent("spikestrips:removeStrip", DROPPED_ITEMS[i].coords)
						end
						table.remove(DROPPED_ITEMS, i)
						TriggerClientEvent("interaction:removeDroppedItem", -1, i)
						break
					end
				end
			end
		end
		Wait(ITEM_EXPIRE_CHECK_INTERVAL)
	end
end)
