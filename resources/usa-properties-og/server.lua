--# Residential / Business Properties
--# own, store stuff, be a bawse
--# by: minipunch
--# made for: USA REALISM RP

local PROPERTIES = {} -- loaded and updated by database

local BUSINESS_PAY_PERIOD_DAYS = 7
local HOUSE_PAY_PERIOD_DAYS = 30
local MAX_NUM_OF_PROPERTIES_SINGLE_PERSON = 7

local NEARBY_DISTANCE = 500

local CLIENT_UPDATE_INTERVAL = 10

local PROPERTY_TRANSFER_TIMEOUT_HOURS = 48

local peopleAccessingProperties = {}

local recentlyChangedPlates = {}

AddEventHandler("playerDropped", function(reason)
  for propName, people in pairs(peopleAccessingProperties) do
    for src, dummyTrueBool in pairs(peopleAccessingProperties[propName]) do
      if src == source then
        peopleAccessingProperties[propName][source] = nil
        return
      end
    end
  end
end)

AddEventHandler("character:loaded", function(char)
  local charIdent = char.get("_id")
  TriggerClientEvent("properties:setPropertyBlips", char.get("source"), GetOwnedPropertyCoords(charIdent, true))
  TriggerClientEvent("properties:setPropertyIdentifier", char.get("source"), charIdent)
end)

RegisterServerEvent("garage:notifyOfPlateChange")
AddEventHandler("garage:notifyOfPlateChange", function(src, oldPlate, newPlate)
	local c = exports["usa-characters"]:GetCharacter(src)
	recentlyChangedPlates[c.get("_id")] = {}
	recentlyChangedPlates[c.get("_id")][oldPlate] = newPlate
end)

RegisterServerEvent("properties-og:requestNearestData")
AddEventHandler("properties-og:requestNearestData", function(coords)
  local src = source
  Citizen.CreateThread(function()
    local nearbyInfo = {}
    local nearbyNames = {}
    -- first gather nearby properties from client's coords
    for name, info in pairs(PROPERTIES) do
        if getCoordDistance({x = info.x, y = info.y, z = info.z}, coords) < NEARBY_DISTANCE then
            nearbyInfo[name] = info
            nearbyNames[name] = true
        end
    end
    -- send to client (to remove no longer nearby properties)
    TriggerClientEvent("properties-og:updateNearby", src, nearbyNames)
    -- 'asynchronously' send nearest property data to client as to not send too much data in a single event (causing network thread hitches + mass client DCs)
    local lastSentTime = os.time()
    for name, info in pairs(nearbyInfo) do
      while os.difftime(os.time(), lastSentTime) < PROPERTY_DATA_SEND_INTERVAL_SEC do
        Wait(1)
      end
      TriggerClientEvent("properties-og:addNearbyProperty", src, name, info)
      lastSentTime = os.time()
    end
  end)
end)

RegisterServerEvent("properties:getPropertyMoney")
AddEventHandler("properties:getPropertyMoney", function(name, cb)
    cb(PROPERTIES[name].storage.money)
end)

RegisterServerEvent("properties:checkSpawnPoint")
AddEventHandler("properties:checkSpawnPoint", function(usource)
	local player = exports["usa-characters"]:GetCharacter(usource)
	local spawn = player.get("spawn")
	if type(spawn) ~= "nil" then
		print("spawn existed! checking if spawn is still valid after evictions!")
    if spawn.name then
      if PROPERTIES[spawn.name] then
        if PROPERTIES[spawn.name].owner.identifier == player.get("_id") then
          print("Still owns property, leaving spawn! 1")
        else
          print("does not own property anymore, resetting spawn! 1")
          player.set("spawn", nil)
        end
      end
    end
	end
end)

RegisterServerEvent("properties:setSpawnPoint")
AddEventHandler("properties:setSpawnPoint", function(spawn)
  local char = exports["usa-characters"]:GetCharacter(source)
  if spawn then
    char.set("spawn", spawn)
  else
    char.set("spawn", "deleteMePlz!")
  end
  TriggerClientEvent("usa:notify", source, "Spawn set!")
end)

----------------------
-- WARDROBE --
----------------------
RegisterServerEvent("properties:deleteOutfitByName")
AddEventHandler("properties:deleteOutfitByName", function(property_name, outfit_name)
    ----------------------------------------
    -- remove outfit from property --
    ----------------------------------------
    local wardrobe = PROPERTIES[property_name].wardrobe
    if  not wardrobe then
        wardrobe = {}
    end
    -- search for matching outfit to delete --
    for i = 1, #wardrobe do
        if wardrobe[i].name == outfit_name then
            --print("matching outfit found to delete!")
            -- remove --
            table.remove(PROPERTIES[property_name].wardrobe, i)
            -- update menu --
            TriggerClientEvent("properties:loadWardrobe", source, PROPERTIES[property_name].wardrobe)
            -- save property --
            SavePropertyData(property_name)
            return
        end
    end
end)

RegisterServerEvent("properties-og:saveOutfit")
AddEventHandler("properties-og:saveOutfit", function(property_name, outfit)
    -- add outfit to property --
    if  not PROPERTIES[property_name].wardrobe then
        PROPERTIES[property_name].wardrobe = {}
    end
    table.insert(PROPERTIES[property_name].wardrobe, outfit)
    -- update menu --
    TriggerClientEvent("properties:loadWardrobe", source, PROPERTIES[property_name].wardrobe)
  -- save property --
  SavePropertyData(property_name)
end)

RegisterServerEvent("properties:getWardrobe")
AddEventHandler("properties:getWardrobe", function(property_name)
    TriggerClientEvent("properties:loadWardrobe", source, PROPERTIES[property_name].wardrobe)
end)

----------------------------
-- ITEM STORAGE --
----------------------------
--[[
-- load stored items --
RegisterServerEvent("properties:loadStorage")
AddEventHandler("properties:loadStorage", function(name)
	TriggerClientEvent("properties:loadedStorage", source, PROPERTIES[name].storage.items)
end)

-- get items to store --
RegisterServerEvent("properties:getUserItemsToStore")
AddEventHandler("properties:getUserItemsToStore", function(user_source)
	local userSource = source
	if user_source then userSource = user_source end
    local player = exports["usa-characters"]:GetCharacter(userSource)
    if player then
      local items = {}
      local inventory = player.get("inventory")
      --for i = 1, #inventory do table.insert(items, inventory[i]) end
      for index, item in pairs(inventory.items) do
        table.insert(items, item)
      end
      --print("sending #" .. #items .. " items to client for storage menu")
      TriggerClientEvent("properties:setItemsToStore", userSource, items)
    end
end)
--]]

-- store cash in property --
RegisterServerEvent("properties-og:storeMoney")
AddEventHandler("properties-og:storeMoney", function(name, amount)
	local user_source = source
	local player = exports["usa-characters"]:GetCharacter(user_source)
	local user_money = player.get("money")
	if user_money - amount >= 0 then
		-- remove from player --
		player.removeMoney(amount)
		-- add to property --
		TriggerEvent("properties:addMoney", name, amount)
	else
		TriggerClientEvent("usa:notify", user_source, "You don't have that much money on you!")
	end
end)

-- try to store item --
--[[
RegisterServerEvent("properties:store")
AddEventHandler("properties:store", function(name, item, quantity)
  local user_source = source
  local char = exports["usa-characters"]:GetCharacter(user_source)
  item = char.getItem(item) -- server-sided validity check here, don't trust
  if not item then
    print("** [usa-properties-og] ALERT: Client " .. char.getFullName() .. " sent in an item that failed server validation! **")
    return
  end
  if item.type and item.type == "license" then
    TriggerClientEvent("usa:notify", user_source, "Can't store licenses!")
    return
  end
  -- remove from player --
  if item.uuid then
    char.removeItemByUUID(item.uuid, quantity)
  else
    char.removeItem(item, quantity)
  end
  local copy = item
  copy.quantity = quantity
  local had_already = false
  -- insert into property --
  for i = 1, #PROPERTIES[name].storage.items do
      if PROPERTIES[name].storage.items[i].name == item.name then
          if not PROPERTIES[name].storage.items[i].notStackable then
              had_already	= true
              PROPERTIES[name].storage.items[i].quantity = PROPERTIES[name].storage.items[i].quantity + quantity
          end
          break
      end
  end
  if not had_already then
      table.insert(PROPERTIES[name].storage.items, copy)
      --print("inserted item into house storage: " .. copy.name .. ", type: " .. copy.type .. ", customizations: " .. type(copy.components))
  end
  -- save property --
  SavePropertyData(name)
end)
--]]

function inventoryAsMapNotArray(inv)
  local isOldStyle = false
  for i, itemData in pairs(inv) do
    if type(i) ~= "string" then
      isOldStyle = true
      break
    end
  end
  if isOldStyle then
    local ret = {}
    for i, itemData in pairs(inv) do
      ret[tostring(i - 1)] = itemData
    end
    return ret
  else
    return inv
  end
end

function getInventoryCount(inv)
  local count = 0
  for i, itemData in pairs(inv) do
    count = count + 1
  end
  return count
end

RegisterServerEvent("properties-og:onStorageBtnSelected")
AddEventHandler("properties-og:onStorageBtnSelected", function(propertyName)
  -- get property inventory
  local propertyInv = PROPERTIES[propertyName].storage.items
  -- send to interaction-menu's inventory system for display and item movement
  local inventoryAsMap = inventoryAsMapNotArray(propertyInv)
  local invForGUI = {
    items = inventoryAsMap,
    MAX_CAPACITY = -1,
    MAX_ITEMS = getInventoryCount(inventoryAsMap)
  }
  TriggerClientEvent("interaction:openGUIAndSendNUIData", source, {
    type = "showPropertyInventory",
    inv = invForGUI,
    propertyName = propertyName
  })
  -- record id of person accessing
  if not peopleAccessingProperties[propertyName] then
    peopleAccessingProperties[propertyName] = {}
  end
  peopleAccessingProperties[propertyName][source] = true
end)

RegisterServerEvent("properties-og:markAsInventoryClosed")
AddEventHandler("properties-og:markAsInventoryClosed", function()
  for propName, people in pairs(peopleAccessingProperties) do
    for src, dummyTrueBool in pairs(peopleAccessingProperties[propName]) do
      if src == source then
        peopleAccessingProperties[propName][source] = nil
        return
      end
    end
  end
end)

RegisterServerEvent("properties-og:moveItemFromProperty")
AddEventHandler("properties-og:moveItemFromProperty", function(src, data)
  if not ownsProperty(data.propertyName, src) then
    TriggerClientEvent("usa:notify", src, "Not property owner")
    return
  end
  data.fromSlot = tostring(data.fromSlot)
  data.quantity = tonumber(data.quantity)
  if data.quantity <= 0 then
    TriggerClientEvent("usa:notify", src, "Invalid quantity")
    return
  end
  -- get item from property storage
  local inv = inventoryAsMapNotArray(PROPERTIES[data.propertyName].storage.items)
  local item = inv[data.fromSlot]
  -- try to store in player's inventory
  local char = exports["usa-characters"]:GetCharacter(src)
  if char.canHoldItem(item, (data.quantity or item.quantity)) then
    char.putItemInSlot(item, data.toSlot, (data.quantity or item.quantity), function(success)
      if success then
        -- remove from property inventory if success and save property data
        inv[data.fromSlot].quantity = inv[data.fromSlot].quantity - (data.quantity or item.quantity)
        if inv[data.fromSlot].quantity <= 0 then
          inv[data.fromSlot] = nil
        end
        PROPERTIES[data.propertyName].storage.items = inv
        SavePropertyData(data.propertyName)
        -- update primary and secondary inventories in the GUI:
        local invForGUI = {
          items = PROPERTIES[data.propertyName].storage.items,
          MAX_CAPACITY = -1,
          MAX_ITEMS = getInventoryCount(PROPERTIES[data.propertyName].storage.items)
        }
        TriggerClientEvent("interaction:sendNUIMessage", src, { type = "updateBothInventories", inventory = { primary = char.get("inventory"), secondary = invForGUI}})
        for id, dummyTrueBool in pairs(peopleAccessingProperties[data.propertyName]) do
          TriggerClientEvent("interaction:sendNUIMessage", id, { type = "updateSecondaryInventory", inventory = invForGUI})
        end
      end
    end)
  else
    TriggerClientEvent("usa:notify", src, "Inventory full!")
  end
end)

RegisterServerEvent("properties-og:moveItemToPropertyStorage")
AddEventHandler("properties-og:moveItemToPropertyStorage", function(src, data)
  -- move item to property
  local char = exports["usa-characters"]:GetCharacter(src)
  data.toSlot = tostring(data.toSlot)
  data.fromSlot = tostring(data.fromSlot)
  data.quantity = tonumber(data.quantity)
  local item = char.getItemByIndex(data.fromSlot)
  if data.quantity <= 0 or data.quantity > item.quantity then
    TriggerClientEvent("usa:notify", src, "Invalid quantity")
    return
  end
  if item.type and item.type == "license" then
    TriggerClientEvent("usa:notify", src, "Can't move that")
    return
  end
  local propertyInv = inventoryAsMapNotArray(PROPERTIES[data.propertyName].storage.items)
  if not propertyInv[data.toSlot] then
    propertyInv[data.toSlot] = item
    propertyInv[data.toSlot].quantity = (data.quantity or item.quantity)
  elseif propertyInv[data.toSlot] and not propertyInv[data.toSlot].notStackable and propertyInv[data.toSlot].name == item.name then
    propertyInv[data.toSlot].quantity = propertyInv[data.toSlot].quantity + (data.quantity or item.quantity)
  else
    TriggerClientEvent("usa:notify", src, "Invalid slot!")
    return
  end
  PROPERTIES[data.propertyName].storage.items = propertyInv
  SavePropertyData(data.propertyName)
  -- remove from person if success
  if item.type == "weapon" then
    TriggerClientEvent("interaction:equipWeapon", src, item, false)
  end
  char.removeItemByIndex(data.fromSlot, (data.quantity or item.quantity))
  -- update GUI
  local invForGUI = {
    items = PROPERTIES[data.propertyName].storage.items,
    MAX_CAPACITY = -1,
    MAX_ITEMS = getInventoryCount(PROPERTIES[data.propertyName].storage.items)
  }
  TriggerClientEvent("interaction:sendNUIMessage", src, { type = "updateBothInventories", inventory = { primary = char.get("inventory"), secondary = invForGUI}})
  for id, dummyTrueBool in pairs(peopleAccessingProperties[data.propertyName]) do
    TriggerClientEvent("interaction:sendNUIMessage", id, { type = "updateSecondaryInventory", inventory = invForGUI})
  end
end)

RegisterServerEvent("properties-og:moveItemWithinPropertyStorage")
AddEventHandler("properties-og:moveItemWithinPropertyStorage", function(src, data)
  print("moving item within property")
  -- move item to property
  local char = exports["usa-characters"]:GetCharacter(src)
  data.toSlot = tostring(data.toSlot)
  data.fromSlot = tostring(data.fromSlot)
  local propertyInv = PROPERTIES[data.propertyName].storage.items
  local item = propertyInv[data.fromSlot]
  if not propertyInv[data.toSlot] then
    propertyInv[data.toSlot] = item
    propertyInv[data.fromSlot] = nil
  elseif propertyInv[data.toSlot] and not propertyInv[data.toSlot].notStackable and propertyInv[data.toSlot].name == item.name then
    propertyInv[data.toSlot].quantity = propertyInv[data.toSlot].quantity + item.quantity
    propertyInv[data.fromSlot] = nil
  else
    TriggerClientEvent("usa:notify", src, "Invalid slot!")
    return
  end
  PROPERTIES[data.propertyName].storage.items = propertyInv
  SavePropertyData(data.propertyName)
  -- update GUI
  local invForGUI = {
    items = PROPERTIES[data.propertyName].storage.items,
    MAX_CAPACITY = -1,
    MAX_ITEMS = getInventoryCount(PROPERTIES[data.propertyName].storage.items)
  }
  for id, dummyTrueBool in pairs(peopleAccessingProperties[data.propertyName]) do
    TriggerClientEvent("interaction:sendNUIMessage", id, { type = "updateSecondaryInventory", inventory = invForGUI})
  end
end)

-- load stored money --
RegisterServerEvent("properties:loadMoneyForMenu")
AddEventHandler("properties:loadMoneyForMenu", function(name)
	TriggerClientEvent("properties:loadMoneyForMenu", source, PROPERTIES[name].storage.money)
end)

-- load stored vehicles --
RegisterServerEvent("properties:loadVehiclesForMenu")
AddEventHandler("properties:loadVehiclesForMenu", function(name)
    local usource = source
    GetVehiclesForMenu(name, function(vehs)
        TriggerClientEvent("properties:loadVehiclesForMenu", usource, vehs)
    end)
end)

-- store vehicle at property --
RegisterServerEvent("properties:storeVehicle")
AddEventHandler("properties:storeVehicle", function(property_name, plate) --IMPLEMENT
  plate = exports.globals:trim(plate)
  local usource = tonumber(source)
  -- check if player owns veh trying to store --
  local owns = false
  local user = exports["usa-characters"]:GetCharacter(usource)
  local uvehicles = user.get("vehicles")
  for i = 1, #uvehicles do
    if plate == uvehicles[i] then
        owns = true
    end
  end
  if owns or (recentlyChangedPlates[user.get("_id")] and recentlyChangedPlates[user.get("_id")][plate]) then
      -- store vehicle if owner --
      TriggerEvent('es:exposeDBFunctions', function(couchdb)
        if recentlyChangedPlates[user.get("_id")] and recentlyChangedPlates[user.get("_id")][plate] then
          plate = recentlyChangedPlates[user.get("_id")][plate] -- if they recently changed their plate at the DMV, they still own it even though original logic says they don't
        end
        couchdb.updateDocument("vehicles", plate, { stored_location = property_name }, function()
            -- delete vehicle on client --
            TriggerClientEvent("properties:storeVehicle", usource)
            -- remove key from inventory --
            user.removeItem("Key -- " .. plate)
        end)
      end)
  else
      TriggerClientEvent("usa:notify", usource, "You do not own that vehicle!")
  end
end)

-- retrieve vehicle from property --
RegisterServerEvent("properties:retrieveVehicle")
AddEventHandler("properties:retrieveVehicle", function(property_name, vehicle) -- IMPLEMENT
  local usource = source
  TriggerEvent('es:exposeDBFunctions', function(couchdb)
    couchdb.updateDocument("vehicles", vehicle.plate, { stored_location = "deleteMePlz!" }, function(err)
      vehicle.upgrades = exports["usa_mechanicjob"]:GetUpgradeObjectsFromIds(vehicle.upgrades)
        TriggerClientEvent("properties:retrieveVehicle", usource, vehicle)
    end)
  end)
end)

function InitDoors()
  local doors = {}
  for k,v in pairs(PROPERTIES) do
    if v.doors ~= nil then
      for index,door in ipairs(v.doors) do
        if v.owner.name == nil then
          door.locked = false
        end
        table.insert(doors, door)
      end
    end
  end
  exports["usa_doormanager"]:SetPropertyDoors(doors)
end

function AddDoorToDoormanager(door)
  exports["usa_doormanager"]:AddPropertyDoor(door)
end

function RemoveDoorToDoormanager(doorName)
  exports["usa_doormanager"]:RemovePropertyDoor(doorName)
end


-----------------------------
-- LOAD PROPERTIES FROM DB --
-----------------------------
function loadProperties()
	print("fetching all properties...")
	PerformHttpRequest("http://127.0.0.1:5984/properties/_all_docs?include_docs=true" --[[ string ]], function(err, text, headers)
		print("finished getting properties...")
		print("error code: " .. err)
		local response = json.decode(text)
		if response.rows then
			PROPERTIES = {} -- reset table
			print("#(response.rows) = " .. #(response.rows))
			-- insert all properties from 'properties' db into lua table
			for i = 1, #(response.rows) do
				if response.rows[i] then
					if response.rows[i].doc.name then
						PROPERTIES[response.rows[i].doc.name] = response.rows[i].doc
						print("loaded property: " .. response.rows[i].doc.name)
                    else
						print("Error loading property document at index #" .. i)
					end
				else
					print("Error loading property at index #" .. i)
				end
			end
			print("finished loading properties...")
			print("checking for owners to evict...")
			Evict_Owners()
      InitDoors()
		end
	end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

-- PERFORM FIRST TIME DB CHECK --
exports["globals"]:PerformDBCheck("usa-properties", "properties", loadProperties)

--------------------------------
-- Set will_leave               --
--------------------------------

RegisterServerEvent("properties:willLeave")
AddEventHandler("properties:willLeave", function(name, willLeave)
  local sourceIdent = exports["usa-characters"]:GetCharacter(source).get("_id")
  local ownerIdent = PROPERTIES[name].owner.identifier
  if sourceIdent == ownerIdent then
    PROPERTIES[name].will_leave = willLeave
    print(name.." set will leave to ".. tostring(willLeave))
    -- save property --
    SavePropertyData(name)
  end
end)

--------------------------------
-- ADD MONEY (from purchases) --
--------------------------------
RegisterServerEvent("properties:addMoney")
AddEventHandler("properties:addMoney", function(name, amount)
    PROPERTIES[name].storage.money = PROPERTIES[name].storage.money + amount
    print("$" .. amount .. " added!")
    -- save property --
    SavePropertyData(name)
end)

------------------
-- REMOVE MONEY --
------------------
RegisterServerEvent("properties:withdraw")
AddEventHandler("properties:withdraw", function(name, amount, savedSource, give_money_to_player)
  if savedSource then source = savedSource end -- if called from server file
  if not ownsProperty(name, source) then
    TriggerClientEvent("usa:notify", source, "Not property owner")
    return
  end
  if PROPERTIES[name].storage.money - amount >= 0 then
    -- remove from store --
    PROPERTIES[name].storage.money = PROPERTIES[name].storage.money - amount
    -- only take money if asked to --
    if give_money_to_player then
      -- add to player --
      local player = exports["usa-characters"]:GetCharacter(tonumber(source))
      if player then
        local user_money = player.get("money")
        player.giveMoney(amount)
        TriggerClientEvent("usa:notify", source, "~y~Withdrawn: ~w~$" .. amount)
        print("$" .. amount .. " withdrawn!")
      else
        print("failed to retrieve player in properties:withdraw!")
      end
    end
    -- save property --
    SavePropertyData(name)
  else
    TriggerClientEvent("usa:notify", source, "Don't have that much to withdraw!")
  end
end)

-----------------------
-- PURCHASE PROPERTY --
-----------------------
RegisterServerEvent("properties:purchaseProperty")
AddEventHandler("properties:purchaseProperty", function(property)
  local user_source = source
  local player = exports["usa-characters"]:GetCharacter(user_source)

	if GetNumberOfOwnedProperties(player.get("_id")) < MAX_NUM_OF_PROPERTIES_SINGLE_PERSON then
		if not property.type then property.type = "business" print("set property type to business") end
		--if property.type == "business" then ownership_length = BUSINESS_PAY_PERIOD_DAYS
		--elseif property.type == "house" then ownership_length = HOUSE_PAY_PERIOD_DAYS end

		local final_time = nil
		local today = os.date("*t", os.time())

		print("player #" .. user_source .. " wants to purchase " .. property.name)
		local user_money = player.get("money")
		local char_name = player.getFullName()

		--if user_money >= property.fee.price then
    if user_money >= PROPERTIES[property.name].fee.price then
			-- set new property info --
			PROPERTIES[property.name].fee.paid_time = os.time() -- save the time the property was purchased
			PROPERTIES[property.name].fee.paid = true
			if property.type == "business" then
				PROPERTIES[property.name].fee.due_days = BUSINESS_PAY_PERIOD_DAYS
				final_time = {day = today.day + BUSINESS_PAY_PERIOD_DAYS, month = today.month, year = today.year}
			elseif property.type == "house" then
				PROPERTIES[property.name].fee.due_days = HOUSE_PAY_PERIOD_DAYS
				final_time = {day = today.day, month = today.month + 1, year = today.year}
			end
			local endtime = os.time(final_time)
			PROPERTIES[property.name].fee.due_time = endtime
			PROPERTIES[property.name].fee.end_date = os.date("%x", endtime)
			PROPERTIES[property.name].owner.name = char_name
			PROPERTIES[property.name].owner.purchase_date = os.date("%x", os.time())
			PROPERTIES[property.name].owner.identifier = player.get("_id")
      if PROPERTIES[property.name].doors == nil then
        PROPERTIES[property.name].doors = {}
      end
      for i,v in ipairs(PROPERTIES[property.name].doors) do
        v.locked = true
        exports["usa_doormanager"]:toggleDoorLockByName(v.name, true)
      end
			-- update all clients property info --
            local PROPERTY_FOR_CLIENT = { -- only give client needed information for each property for performance reasons
                name = property.name,
                storage = {
                    money = PROPERTIES[property.name].storage.money
                },
                fee = PROPERTIES[property.name].fee,
                x = PROPERTIES[property.name].x,
                y = PROPERTIES[property.name].y,
                z = PROPERTIES[property.name].z,
                garage_coords = PROPERTIES[property.name].garage_coords,
                owner = PROPERTIES[property.name].owner,
                type = PROPERTIES[property.name].type,
                will_leave = PROPERTIES[property.name].will_leave
            }
			TriggerClientEvent("properties:update", -1, PROPERTY_FOR_CLIENT, true)
			-- subtract money --
			player.removeMoney(PROPERTIES[property.name].fee.price)
      -- save property --
      SavePropertyData(property.name)
      -- add map blip --
      TriggerClientEvent("properties:setPropertyBlips", user_source, GetOwnedPropertyCoords(player.get("_id"), true))
			-- send discord msg to #property-logs --
			local desc = "\n**Property:** " .. property.name .. "\n**Purchase Price:** $" .. comma_value(PROPERTIES[property.name].fee.price) ..  "\n**Purchased By:** " .. char_name .. "\n**Purchase Date:** ".. PROPERTIES[property.name].owner.purchase_date .. "\n**End Date:** " .. PROPERTIES[property.name].fee.end_date
			local url = GetConvar("property-log-webhook", "")
			PerformHttpRequest(url, function(err, text, headers)
				if text then
					print(text)
				end
			end, "POST", json.encode({
				embeds = {
					{
						description = desc,
						color = 524288,
						author = {
							name = "SAN ANDREAS PROPERTY MGMT"
						}
					}
				}
			}), { ["Content-Type"] = 'application/json' })
		else
			TriggerClientEvent("usa:notify", user_source, "You don't have enough money to purchase this property!")
		end
	else
		TriggerClientEvent("usa:notify", user_source, "You have reached your max number of properties!")
	end
end)

----------------------------
-- GET PROPERTY CO-OWNERS --
----------------------------
RegisterServerEvent("properties:getCoOwners")
AddEventHandler("properties:getCoOwners", function(property_name)
  -- check if property has any co owners already --
  if not PROPERTIES[property_name].coowners then
    PROPERTIES[property_name].coowners = {}
  end
  -- return to client --
  TriggerClientEvent("properties:getCoOwners", source, PROPERTIES[property_name].coowners)
end)

---------------------------
-- ADD PROPERTY CO-OWNER --
---------------------------
RegisterServerEvent("properties:addCoOwner")
AddEventHandler("properties:addCoOwner", function(property_name, id)
  if GetPlayerName(id) then
    -- check if property has any co owners already --
    if not PROPERTIES[property_name].coowners then
      PROPERTIES[property_name].coowners = {}
    end
    -- create person --
    local person = exports["usa-characters"]:GetCharacter(id)
    local coowner = {
      name = person.getFullName(),
      identifier = person.get("_id")
    }
    -- add person to list of co owners --
    table.insert(PROPERTIES[property_name].coowners, coowner)
    -- save --
    SavePropertyData(property_name)
    -- update all clients --
    TriggerClientEvent("properties:update", -1, PROPERTIES[property_name])
    -- add blip for co owner --
    TriggerClientEvent("properties:setPropertyBlips", id, GetOwnedPropertyCoords(coowner.identifier, true))
    -- notify --
    TriggerClientEvent("usa:notify", source, coowner.name .. " has been successfully added!")
  else
    TriggerClientEvent("usa:notify", source, "Person does not exist!")
  end
end)

RegisterServerEvent("properties:changeOwner")
AddEventHandler("properties:changeOwner", function(property_name, id)
  local sourceIdent = exports["usa-characters"]:GetCharacter(source).get("_id")
  local oldOwnerIdent = PROPERTIES[property_name].owner.identifier
  if sourceIdent == oldOwnerIdent then
    if source ~= id then
      if GetPlayerName(id) then
        -- create person --
        local person = exports["usa-characters"]:GetCharacter(id)
        if GetNumberOfOwnedProperties(person.get("_id")) < MAX_NUM_OF_PROPERTIES_SINGLE_PERSON then
          if PROPERTIES[property_name].lastTransfer == nil then
            PROPERTIES[property_name].lastTransfer = 0
          end
          if os.time() - tonumber(PROPERTIES[property_name].lastTransfer) > PROPERTY_TRANSFER_TIMEOUT_HOURS * 3600 then
            local new_owner = {
              name = person.getFullName(),
              purchase_date = PROPERTIES[property_name].owner.purchase_date,
              identifier = person.get("_id")
            }
            local oldOwner = PROPERTIES[property_name].owner.name
            PROPERTIES[property_name].owner = new_owner
            PROPERTIES[property_name].lastTransfer = os.time()
            -- save --
            SavePropertyData(property_name)
            -- update all clients --
            TriggerClientEvent("properties:update", -1, PROPERTIES[property_name])
            -- add blip for co owner --
            TriggerClientEvent("properties:setPropertyBlips", id, GetOwnedPropertyCoords(new_owner.identifier, true))
            TriggerClientEvent("properties:setPropertyBlips", source, GetOwnedPropertyCoords(exports["usa-characters"]:GetCharacter(source).get("_id"), true))
            -- notify --
            TriggerClientEvent("usa:notify", source, "The property has been transfered to "..new_owner.name)
            TriggerClientEvent("usa:notify", id, property_name .. " has been transfered into your ownership!")

            local desc = "**Property Transfer**:\n\n**Property:** " .. property_name .. "\n**Old Owner:** " .. oldOwner .. "\n**New Owner:** ".. new_owner.name
            local url = GetConvar("property-log-webhook", "")
            PerformHttpRequest(url, function(err, text, headers)
              if text then
                print(text)
              end
            end, "POST", json.encode({
              embeds = {
                {
                  description = desc,
                  color = 524288,
                  author = {
                    name = "SAN ANDREAS PROPERTY MGMT"
                  }
                }
              }
            }), { ["Content-Type"] = 'application/json' })
          else
            local timeSinceTrans = (os.time() - PROPERTIES[property_name].lastTransfer)/3600
            timeSinceTrans = exports["globals"]:round(timeSinceTrans, 1)
            TriggerClientEvent("usa:notify", source,"This property was transfered " .. timeSinceTrans .. " hours ago, there is a limit of 48 hours between transfers!")
          end
        else
          TriggerClientEvent("usa:notify", source,"This person has too many properties already!")
        end
      else
        TriggerClientEvent("usa:notify", source, "Person does not exist!")
      end
    else
      TriggerClientEvent("usa:notify", source, "You cant transfer a house to yourself!")
    end
  else
    TriggerClientEvent("usa:notify", source, "That is not your house!")
  end
end)

RegisterServerEvent("properties:addLEO")
AddEventHandler("properties:addLEO", function(property_name, id, source)
  if GetPlayerName(id) then
    if not PROPERTIES[property_name] then
      TriggerClientEvent("usa:notify", source, "Property does not exist, please check capitalisation!")
    else
      -- check if property has any co owners already --
      if not PROPERTIES[property_name].coowners then
        PROPERTIES[property_name].coowners = {}
      end
      -- create person --
      local person = exports["usa-characters"]:GetCharacter(tonumber(id))
      local job = person.get("job")
      local coowner = {
        name = person.getFullName(),
        identifier = person.get("_id")
      }
      if job == "sheriff" or job == "corrections" then
        -- add person to list of co owners --
        table.insert(PROPERTIES[property_name].coowners, coowner)
        -- save --
        SavePropertyData(property_name)
        -- update all clients --
        TriggerClientEvent("properties:update", -1, PROPERTIES[property_name])
        -- add blip for co owner --
        TriggerClientEvent("properties:setPropertyBlips", id, GetOwnedPropertyCoords(coowner.identifier, true))
        -- notify --
        TriggerClientEvent("usa:notify", source, coowner.name .. " has been successfully added!")
        TriggerClientEvent("usa:notify", id, "You were added to " .. PROPERTIES[property_name].name .. " by a judge to execute a warrant!")

        local judge = exports["usa-characters"]:GetCharacter(source)
        local judge_name = judge.getFullName()
        local officer = exports["usa-characters"]:GetCharacter(tonumber(id))
        local officer_name = officer.getFullName()
        local url = GetConvar("search-warrant-log-webhook", "")
        if not suspensions then suspensions = "None" end
        PerformHttpRequest(url, function(err, text, headers)
          if text then
            print(text)
          end
        end, "POST", json.encode({
          embeds = {
            {
              description = "**Judge:** " .. judge_name .. "\n**Property:** " .. property_name .. "\n**Officer Issued To:** " .. officer_name .. "\n**Timestamp:** " .. os.date('%m-%d-%Y %H:%M:%S', os.time()),
              color = 263172,
              author = {
                name = "DOJ: Search Warrant Issued"
              }
            }
          }
        }), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
      else
        TriggerClientEvent("usa:notify", source, coowner.name .. " is not a Law Enforcement Officer!")
      end
    end
  else
    TriggerClientEvent("usa:notify", source, "Person does not exist!")
  end
end)

------------------------------
-- REMOVE PROPERTY CO-OWNER --
------------------------------
RegisterServerEvent("properties:removeCoOwner")
AddEventHandler("properties:removeCoOwner", function(property_name, index)
  -- check if property has any co owners already --
  if not PROPERTIES[property_name].coowners then
    PROPERTIES[property_name] = {}
  end
  -- remove at index --
  if PROPERTIES[property_name].coowners[index] then
    table.remove(PROPERTIES[property_name].coowners, index)
    -- save --
    SavePropertyData(property_name)
    -- update all clients --
    TriggerClientEvent("properties:update", -1, PROPERTIES[property_name])
    -- notify --
    TriggerClientEvent("usa:notify", source, "Co-owner removed!")
  end
end)

RegisterServerEvent("properties:removeLEO")
AddEventHandler("properties:removeLEO", function(property_name, id, source)
  if GetPlayerName(id) then
    if not PROPERTIES[property_name] then
      TriggerClientEvent("usa:notify", source, "Property does not exist, please check capitalisation!")
    else
      -- check if property has any co owners already --
      if not PROPERTIES[property_name].coowners then
        PROPERTIES[property_name] = {}
      end
      local person = exports["usa-characters"]:GetCharacter(tonumber(id))
      local identifier = person.get("_id")
      local job = person.get("job")
      local name = person.getFullName()

      local index = nil
      for i=1,#PROPERTIES[property_name].coowners do
        print(PROPERTIES[property_name].coowners[i].identifier)
        if PROPERTIES[property_name].coowners[i].identifier == identifier then 
          index = i
          break
        end
      end

      if job == "sheriff" or job == "corrections" then
        -- remove at index --
        if PROPERTIES[property_name].coowners[index] then
          table.remove(PROPERTIES[property_name].coowners, index)
          -- save --
          SavePropertyData(property_name)
          -- update all clients --
          TriggerClientEvent("properties:update", -1, PROPERTIES[property_name])
          -- notify --
          TriggerClientEvent("usa:notify", source, "Warrant Revoked!")
          TriggerClientEvent("usa:notify", id, "Your warrant for " .. PROPERTIES[property_name].name .. " was revoked!")

          local judge = exports["usa-characters"]:GetCharacter(source)
          local judge_name = judge.getFullName()
          local officer = exports["usa-characters"]:GetCharacter(tonumber(id))
          local officer_name = officer.getFullName()
          local url = GetConvar("search-warrant-log-webhook", "")
          if not suspensions then suspensions = "None" end
          PerformHttpRequest(url, function(err, text, headers)
            if text then
              print(text)
            end
          end, "POST", json.encode({
            embeds = {
              {
                description = "**Judge:** " .. judge_name .. "\n**Property:** " .. property_name .. "\n**Officer Revoked From:** " .. officer_name .. "\n**Timestamp:** " .. os.date('%m-%d-%Y %H:%M:%S', os.time()),
                color = 263172,
                author = {
                  name = "DOJ: Search Warrant Revoked"
                }
              }
            }
          }), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
        end
      else
        TriggerClientEvent("usa:notify", source, name .. " is not a Law Enforcement Officer!")
      end
    end
  else
    TriggerClientEvent("usa:notify", source, "Person does not exist!")
  end
end)

function GetWholeDaysFromTime(reference_time)
	local timestamp = os.date("*t", os.time())
	local daysfrom = os.difftime(os.time(), reference_time) / (24 * 60 * 60) -- seconds in a day
	local wholedays = math.floor(daysfrom)
	print("property owned whole days: " .. wholedays) -- today it prints "1"
	return wholedays
end

function Evict_Owners()
  ---------------------------------------
  -- Evict owners whose leases expired --
  ---------------------------------------
  for name, info in pairs(PROPERTIES) do
    -- below if statement only temporarily here to adjust any old DB documents that didn't get the type attribute --
    if not info.type then
        PROPERTIES[name].type = "business"
    end
    -- see if eviction time has arrived
    if info.fee.paid_time then
      local max_ownable_days = 0
      if info.type == "business" then
          max_ownable_days = BUSINESS_PAY_PERIOD_DAYS
      elseif info.type == "house" then
          max_ownable_days = HOUSE_PAY_PERIOD_DAYS
      end
      if GetWholeDaysFromTime(info.fee.paid_time) >= max_ownable_days then
        if info.type == "house" then
          local ownerPlayer = exports["essentialmode"]:getDocument("characters", PROPERTIES[name].owner.identifier)
          if type(ownerPlayer) ~= "boolean" then
            if ownerPlayer.bank >= info.fee.price and not info.will_leave then
              print("** Money from bank of (" .. ownerPlayer.name.first .. " " .. ownerPlayer.name.last .. ") was used to pay for a month of rent. **")
              ownerPlayer.bank = ownerPlayer.bank - info.fee.price
              exports["essentialmode"]:updateDocument("characters", PROPERTIES[name].owner.identifier, ownerPlayer, true)
              PROPERTIES[name].fee.paid_time = os.time()
              PROPERTIES[name].fee.paid = true
              local final_time = nil
              local today = os.date("*t", os.time())
              PROPERTIES[name].fee.due_days = HOUSE_PAY_PERIOD_DAYS
              final_time = {day = today.day, month = (today.month + 1) % 12, year = today.year}
              local endtime = os.time(final_time)
              PROPERTIES[name].fee.due_time = endtime
              PROPERTIES[name].fee.end_date = os.date("%x", endtime)
              SavePropertyData(name)
            else
              print("***Not enough money or choosing not to stay, evicting owner of the " .. name .. " today, owner identifier: " .. PROPERTIES[name].owner.identifier .. "***")
              -- remove property owner information, make available for purchase --
              PROPERTIES[name].fee.end_date = 0
              PROPERTIES[name].fee.due_days = 0
              PROPERTIES[name].fee.paid_time = 0
              PROPERTIES[name].fee.paid = 0
              PROPERTIES[name].will_leave = false
              PROPERTIES[name].owner.name = nil
              PROPERTIES[name].owner.purchase_date = 0
              PROPERTIES[name].owner.identifier = "undefined"
              PROPERTIES[name].coowners = {}
              --PROPERTIES[name].storage.money = 0
              --PROPERTIES[name].storage.items = {}
              -- save property --
              SavePropertyData(name)
            end
          else
            print("noone owns this house")
          end
        else
          print("***Evicting owner of the " .. name .. " business today, owner identifier: " .. PROPERTIES[name].owner.identifier .. "***")
          -- remove property owner information, make available for purchase --
          PROPERTIES[name].fee.end_date = 0
          PROPERTIES[name].fee.due_days = 0
          PROPERTIES[name].fee.paid_time = 0
          PROPERTIES[name].fee.paid = 0
          PROPERTIES[name].owner.name = nil
          PROPERTIES[name].owner.purchase_date = 0
          PROPERTIES[name].owner.identifier = "undefined"
          PROPERTIES[name].coowners = {}
          --PROPERTIES[name].storage.money = 0
          --PROPERTIES[name].storage.items = {}
          -- save property --
          SavePropertyData(name)
        end
      end
    end
  end
end
-----------------------------------------

------------------------
-- Save Property Data --
------------------------
-- TODO: pass into save property data the specific field to update, instead of writing entire document every save
function SavePropertyData(property_name)
  TriggerEvent('es:exposeDBFunctions', function(couchdb)
    PROPERTIES[property_name]._rev = nil
    couchdb.updateDocument("properties", PROPERTIES[property_name]._id, PROPERTIES[property_name], function(status)
      print("called db.updateDocument checking status")
      if status == true then
        print("\nDocument updated.")
      else
        print("\nStatus Response: " .. tostring(status))
        if tostring(status) == "201" then
          print("\nDocument successfully updated!")
        end
      end
    end)
  end)
end

--[[
TriggerEvent('es:addCommand','loadproperties', function(source, args, user)
    if user.getGroup() == "owner" then
        print("inside /loadproperties command!")
        loadProperties()
        local steam_hex = GetPlayerIdentifiers(source)[1]
        TriggerClientEvent("properties:setPropertyIdentifier", source, steam_hex)
        --TriggerClientEvent("properties:updateAll", -1, PROPERTIES, false)
    end
end, {
	help = "Debug for properties"
})
--]]

TriggerEvent('es:addGroupCommand', 'addproperty', "mod", function(source, args, char)

  TriggerClientEvent("properties:startAddNewProperty", source)

end, {
  help = "Add a new residential property",
    params = {}
})

TriggerEvent('es:addGroupCommand', 'editproperty', "mod", function(source, args, char)

  TriggerClientEvent("properties:startEditProperty", source, args[2])

end, {
  help = "Edit a residential property",
    params = {
        { name = "Edit Parameter", help = "What to edit {door, garage, name, price}" },
    }
})

TriggerEvent('es:addGroupCommand', 'addpropertydoor', "mod", function(source, args, char)

  TriggerClientEvent("properties:startAddDoor", source)

end, {
  help = "Add Door to Property",
    params = {
    }
})

RegisterServerEvent("properties:AddDoor")
AddEventHandler("properties:AddDoor", function(name, hash, coords, heading, offset)
  local group = exports["essentialmode"]:getPlayerFromId(source).getGroup()
  if group == "owner" or group == "superadmin" or group == "admin" or group == "mod" then
    if PROPERTIES[name] ~= nil then
      if PROPERTIES[name].doors == nil then
        PROPERTIES[name].doors = {}
      end
      local door_id = ""
      local array = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
      for i=1,8 do
        local random = math.random(#array)
        door_id = door_id .. array[random]
      end
      local doorName = name:gsub("%s+", "").."Door"..door_id
      if string.sub(hash, 1, 1) == "-" then
          hash = tonumber(string.sub(hash, 2, string.len(hash)))
          hash = hash * -1
      else
          hash = tonumber(hash)
      end
      local locked = true
      if PROPERTIES[name].owner.name == nil then
        locked = false
      end
      local door = {
        name = doorName,
        x = coords.x,
        y = coords.y,
        z = coords.z,
        model = hash,
        locked = locked,
        offset = {offset.y, offset.x * -1, offset.z}, -- yes y is the first one dunno why but thats how doormanager works
        heading = heading,
        _dist = 1.5,
        property = true,
        property_name = name
      }
      table.insert(PROPERTIES[name].doors, door)
      AddDoorToDoormanager(door)
      SavePropertyData(name)
    else
      TriggerClientEvent("usa:notify", source, "Property Does not exist!")
    end
  end
end)

TriggerEvent('es:addGroupCommand', 'removepropertydoor', "mod", function(source, args, char)

  TriggerClientEvent("properties:startRemDoor", source)

end, {
  help = "Remove Door from Property",
    params = {
    }
})

RegisterServerEvent("properties:RemDoor")
AddEventHandler("properties:RemDoor", function(coords)
  local group = exports["essentialmode"]:getPlayerFromId(source).getGroup()
  if group == "owner" or group == "superadmin" or group == "admin" or group == "mod" then
    local FoundName = nil
    for name,property in pairs(PROPERTIES) do
      if property.doors ~= nil then
        for i,door in ipairs(property.doors) do
          if #(vector3(door.x,door.y,door.z) - coords) < 1.0 then
            TriggerClientEvent("doormanager:setRemovingDoor", -1, true)
            exports["usa_doormanager"]:toggleDoorLockByName(door.name, false)
            local doorName = door.name
            FoundName = door.property_name
            table.remove(property.doors, i)
            RemoveDoorToDoormanager(doorName)
            SavePropertyData(FoundName)
            TriggerClientEvent("doormanager:setRemovingDoor", -1, false)
          end
        end
      end
    end

    if FoundName == nil then
      TriggerClientEvent("usa:notify", source, "The selected object is not a property door")
    end
  end
end)

RegisterServerEvent("properties:editProperty")
AddEventHandler("properties:editProperty", function(arg, value, name)
  local group = exports["essentialmode"]:getPlayerFromId(source).getGroup()
  if group == "owner" or group == "superadmin" or group == "admin" or group == "mod" then
    local usource = source
    local name_already_exists = false
    if arg == "name" then
      for property_name,info in pairs(PROPERTIES) do
        if value == property_name then
          name_already_exists = true
        end
      end
    end
    if name_already_exists then
      TriggerClientEvent("usa:notify", usource, "A property with name already exists")
    else
      local property_to_edit = PROPERTIES[name]
      PROPERTIES[name] = nil
      if arg == "door" then
        property_to_edit.x = value.x
        property_to_edit.y = value.y
        property_to_edit.z = value.z
      elseif arg == "garage" then
        property_to_edit.garage_coords.x = value.x
        property_to_edit.garage_coords.y = value.y
        property_to_edit.garage_coords.z = value.z
      elseif arg == "name" then
          name = value
          property_to_edit.name = value
      elseif arg == "price" then
        property_to_edit.fee.price = value
      end
      TriggerEvent('es:exposeDBFunctions', function(db) -- this has to be exposeDBFunctions to allow the waiting until the update is done until the next bit is executed
        db.updateDocument("properties", property_to_edit._id, property_to_edit, function()
            local doc = exports.essentialmode:getDocument("properties", property_to_edit._id)
            property_to_edit._rev = doc._rev
            PROPERTIES[name] = property_to_edit

            exports["usa-characters"]:GetCharacters(function(serverChars)
            local owners = {}
            for k,v in pairs(serverChars) do
              if v.get("_id") == PROPERTIES[name].owner.identifier then
                table.insert(owners, {id = v.get("source"), ident = v.get("_id")}) 
              end
              for i,coowner in ipairs(PROPERTIES[name].coowners) do
                if v.get("_id") == coowner.identifier then
                  table.insert(owners, {id = v.get("source"), ident = v.get("_id")})
                end
              end
            end
            for i,v in ipairs(owners) do
              TriggerClientEvent("properties:setPropertyBlips", tonumber(v.id), GetOwnedPropertyCoords(v.ident, true))
            end
          end)
        end)
      end)
    end
  end
end)

RegisterServerEvent("properties:addNewProperty")
AddEventHandler("properties:addNewProperty", function(pLoc, gLoc, name, price)
  local group = exports["essentialmode"]:getPlayerFromId(source).getGroup()
  if group == "owner" or group == "superadmin" or group == "admin" or group == "mod" then
    local usource = source
    local name_already_exists = false
    for property_name,info in pairs(PROPERTIES) do
      if name == property_name then
        name_already_exists = true
      end
    end
    if not name_already_exists then
      local new_property = {
        owner = {
          name = null,
          purchase_date = 0,
          identifier = "undefined"
        },
        type = "house",
        name = name,
        will_leave = false,
        fee = {
          price =  price,
          paid_time = 0,
          due_time = 0,
          paid =  false,
          end_date = 0,
          due_days = 0,
        },
        y = pLoc.y,
        x = pLoc.x,
        z = pLoc.z,
        storage =  {
          money = 0,
          items = {}
        },
        garage_coords = {
          x = gLoc.x,
          y = gLoc.y,
          z = gLoc.z,
          heading = 214.7
        },
        vehicles = {},
        wardrobe = {},
        coowners = {}
      }
      -- add to db --
      TriggerEvent('es:exposeDBFunctions', function(GetDoc)
        -- insert into db
        GetDoc.createDocument("properties", new_property, function(docID)
          -- notify:
          print("**Property [" .. name .. "] added successfully! Make sure the circles are there!**")
          TriggerClientEvent("usa:notify", usource, "Property [" .. name .. "] added successfully! Make sure the circles are there!")
          -- update server --
          new_property._id = docID
          PROPERTIES[name] = new_property
        end)
      end)
    else
      TriggerClientEvent("usa:notify", usource, "A property with name already exists")
    end
  end
end)

-- To add business properties --
TriggerEvent('es:addGroupCommand', 'addbusinessproperty', 'admin', function(source, args, char)
  local usource = source
  local user = exports["essentialmode"]:getPlayerFromId(usource)
  print("inside /addbusinessproperty command!")
  -- usage: /addbusinessproperty [door X] [door Y] [door Z] [price] [name]
  local price = tonumber(args[5])
  local coords = {
    door = {
      x = tonumber(args[2]),
      y = tonumber(args[3]),
      z = tonumber(args[4])
    }
  }
  table.remove(args, 1)
  table.remove(args, 1)
  table.remove(args, 1)
  table.remove(args, 1)
  table.remove(args, 1)
  local name = table.concat(args, " ")
  local new_property = {
    owner = {
      name = null,
      purchase_date = 0,
      identifier = "undefined"
    },
    type = "business",
    name = name,
    fee = {
      price =  price,
      paid_time = 0,
      due_time = 0,
      paid =  false,
      end_date = 0,
      due_days = 0
      },
    y = coords.door.y,
    x = coords.door.x,
    z = coords.door.z,
    storage =  {
      money = 0,
      items = {}
    },
    wardrobe = {},
    coowners = {}
  }
  if name and price and coords.door.x then
    -- add to db --
    TriggerEvent('es:exposeDBFunctions', function(GetDoc)
      -- insert into db
      GetDoc.createDocument("properties", new_property, function(docID)
        -- notify:
        print("**Property [" .. name .. "] added successfully! Make sure the circle is there!**")
        TriggerClientEvent("usa:notify", usource, "Property [" .. name .. "] added successfully! Make sure the circle is there!")
        -- update server --
        new_property._id = docID
        PROPERTIES[name] = new_property
      end)
    end)
  else
    TriggerClientEvent("usa:notify", usource, "Invalid command format! Usage: /addproperty [door X] [door Y] [door Z] [price] [name]")
  end
end, {
	help = "Add a new business property",
    params = {
        { name = "Circle X", help = "Main circle X coordinate" },
        { name = "Circle Y", help = "Main circle Y coordinate" },
        { name = "Circle Z", help = "Main circle Z coordinate" },
        { name = "Price", help = "Price of business (ex: 40000). NO COMMAS OR DOLLAR SIGN!" },
        { name = "Name", help = "The name of the property" }
    }
})

AddEventHandler('rconCommand', function(commandName, args)
	if commandName == "refreshproperties" then
		loadProperties()
    exports["usa-characters"]:GetCharacters(function(players)
          for id, player in pairs(players) do
            if id and player then
              local newIdent = player.get("_id")
							if newIdent then
								print("setting player #" .. id .. " property ident to: " .. newIdent)
								TriggerClientEvent("properties:setPropertyIdentifier", id, newIdent)
							end
						end
					end
        end)

	elseif commandName == "properties" then
        -- TODO: pass in property name as argument and only display its data instead of all properties
        --[[
		for name, info in pairs(PROPERTIES) do
			if info.owner.name then
				RconPrint("Name: " .. info.name)
				RconPrint("\nOwner: " .. info.owner.name)
				RconPrint("\nIdent: " .. info.owner.identifier)
				RconPrint("\nCurrent Money: $" .. info.storage.money)
				RconPrint("\nItems: ")
				for k = 1, #info.storage.items do
					RconPrint("\n(" .. info.storage.items[k].quantity .. "x) " .. info.storage.items[k].name)
				end
				RconPrint("\nEnd Date: " .. info.fee.end_date .. "\n\n")
			end
		end
        --]]
        RconPrint("\nUpdating this command, currently unavailable...")
	elseif commandName == "addproperty" then
		-- usage: addproperty [door X] [door Y] [door Z] [garage X] [garage Y] [garage Z] [price] [name]
		local price = tonumber(args[7])
		local coords = {
			door = {
				x = tonumber(args[1]),
				y = tonumber(args[2]),
				z = tonumber(args[3])
			},
			garage = {
				x = tonumber(args[4]),
				y = tonumber(args[5]),
				z = tonumber(args[6])
			}
		}
		table.remove(args, 1)
		table.remove(args, 1)
		table.remove(args, 1)
		table.remove(args, 1)
		table.remove(args, 1)
		table.remove(args, 1)
		table.remove(args, 1)
		local name = table.concat(args, " ")
		local new_property = {
			owner = {
				name = null,
				purchase_date = 0,
				identifier = "undefined"
			},
			type = "house",
			name = name,
			fee = {
				price =  price,
				paid_time = 0,
				due_time = 0,
				paid =  false,
				end_date = 0,
				due_days = 0
			  },
			y = coords.door.y,
			x = coords.door.x,
			z = coords.door.z,
			storage =  {
				money = 0,
				items = {}
			},
		   garage_coords = {
				x = coords.garage.x,
				y = coords.garage.y,
				z = coords.garage.z,
				heading = 214.7
			 },
			vehicles = {}
		}
		if name and price and coords.door.x and coords.garage.x then
			-- add to db --
			TriggerEvent('es:exposeDBFunctions', function(GetDoc)
				-- insert into db
				GetDoc.createDocument("properties", new_property, function()
					-- notify:
					RconPrint("\nProperty [" .. name .. "] added successfully! Make sure the circles are there!")
					-- refresh properties:
					--loadProperties()
					-- can do refreshproperties for it to show up
				end)
			end)
		else
			RconPrint("\nInvalid command format! Usage: addproperty [door X] [door Y] [door Z] [garage X] [garage Y] [garage Z] [price] [name]")
		end
	elseif commandName == "removeproperty" then
    local name = table.concat(args, " ")
    if PROPERTIES[name] then
      local propertyId = PROPERTIES[name]._id
      -- remove from server memory
      PROPERTIES[name] = nil
      -- remove from disk
      TriggerEvent('es:exposeDBFunctions', function(db)
        db.deleteDocument("properties", propertyId, function(ok)
          if ok then
            RconPrint(name .. " has successfully been removed!")
          else
            RconPrint("Error deleting property " .. name)      
          end
        end)
      end)
    else
      RconPrint(name .. " was not found.")
    end
  end
end)

function GetOwnedPropertyCoords(identifier, includingCoOwner)
	local ret = {}
	for name, info in pairs(PROPERTIES) do
		if info.owner.identifier == identifier then -- is a full owner
			table.insert(ret, {x = info.x, y = info.y, z = info.z})
    elseif includingCoOwner then
      for i = 1, #info.coowners do
        if info.coowners[i].identifier == identifier then -- is a co-owner
          table.insert(ret, {x = info.x, y = info.y, z = info.z, coowner = true})
          break
        end
      end
    end
	end
	return ret
end

function GetOwnedProperties(identifier, includingCoOwner)
	local ret = {}
	for name, info in pairs(PROPERTIES) do
		if info.owner.identifier == identifier then
			table.insert(ret, info)
    elseif includingCoOwner then
      for i = 1, #info.coowners do
        if info.coowners[i].identifier == identifier then -- is a co-owner
          table.insert(ret, info)
          break
        end
      end
    end
	end
	return ret
end

function GetNumberOfOwnedProperties(identifier)
	local count = 0
	for name, info in pairs(PROPERTIES) do
		if info.owner.identifier == identifier then
			count = count + 1
		end
	end
	print("player with identifier [" .. identifier .. "] owns " .. count .. " properties")
	return count
end

function comma_value(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

-- get all vehicles stored at certain property, DEPENDS ON COUCH DB INDEX ON "stored_location" --
function GetVehiclesForMenu(property_name, cb)
    -- query for the information needed from each vehicle --
    local endpoint = "/vehicles/_find"
    local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
    PerformHttpRequest(url, function(err, responseText, headers)
        if responseText then
            local responseVehArray = {}
            --print(responseText)
            local data = json.decode(responseText)
            if data.docs then
              for i = 1, #data.docs do
                  local veh = {
                      make = data.docs[i].make,
                      model = data.docs[i].model,
                      plate = data.docs[i].plate,
                      hash = data.docs[i].hash,
                      owner = data.docs[i].owner,
                      stats = data.docs[i].stats,
                      upgrades = data.docs[i].upgrades,
                      customizations = data.docs[i].customizations
                  }
                  table.insert(responseVehArray, veh)
              end
            end
            -- send vehicles to client for displaying --
            --print("# of vehicles loaded for menu: " .. #responseVehArray)
            cb(responseVehArray)
        end
    end, "POST", json.encode({
        selector = {
            ["stored_location"] = property_name
        },
        fields = { "make", "model", "plate", "hash", "owner", "stats", "upgrades", "customizations" }
    }), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

function nroot(root, num)
	return num^(1/root)
end

function getCoordDistance(coords1, coords2)
    xdistance =  math.abs(coords1.x - coords2.x)
	ydistance = math.abs(coords1.y - coords2.y)
	zdistance = math.abs(coords1.z - coords2.z)
	return nroot(3, (xdistance ^ 3 + ydistance ^ 3 + zdistance ^ 3))
end

function TrimPropertyTableForClient(propertyInfo)
  local toSendInfo = {}
  toSendInfo.name = propertyInfo.name
  toSendInfo.x = propertyInfo.x
  toSendInfo.y = propertyInfo.y
  toSendInfo.z = propertyInfo.z
  toSendInfo.garage_coords = propertyInfo.garage_coords
  toSendInfo.owner = propertyInfo.owner
  toSendInfo.coowners = propertyInfo.coowners
  toSendInfo.fee = propertyInfo.fee
  toSendInfo.type = propertyInfo.type
  toSendInfo.will_leave = propertyInfo.will_leave
  return toSendInfo
end

function ownsProperty(name, src)
  local char = exports["usa-characters"]:GetCharacter(src)
  local owned = GetOwnedProperties(char.get("_id"), true)
  for i = 1, #owned do
    if owned[i].name == name then
      return true
    end
  end
  return false
end

-- send nearby property data to clients every CLIENT_UPDATE_INTERVAL seconds
Citizen.CreateThread(function()
  local lastUpdateTime = os.time()
  while true do
    if os.difftime(os.time(), lastUpdateTime) >= CLIENT_UPDATE_INTERVAL then
      lastUpdateTime = os.time()
      local players = GetPlayers()
      for i = 1, #players do
        local nearby = {}
        local coords = GetEntityCoords(GetPlayerPed(players[i]))
        for name, info in pairs(PROPERTIES) do
          if getCoordDistance({x = info.x, y = info.y, z = info.z}, coords) < NEARBY_DISTANCE then
            local trimmedTable = TrimPropertyTableForClient(info)
            nearby[name] = trimmedTable
          end
        end
        TriggerClientEvent("properties-og:setNearbyProperties", players[i], nearby)
      end
    end
    Wait(1)
  end
end)
