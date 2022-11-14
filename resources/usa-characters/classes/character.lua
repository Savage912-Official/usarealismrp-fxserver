function CreateCharacter(data)
  -- private:
  local self = data

  self.hasRoomForAnotherItem = function()
    for i = 0, self.inventory.MAX_CAPACITY - 1 do
      if self.inventory.items[tostring(i)] == nil then
        return true
      end
    end
    return false
  end

  self.hasItem = function(item)
    local targetItemName = (item.name or item)
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local invItem = inv.items[tostring(i)]
      if invItem then
        if invItem.name:find(targetItemName) or invItem.name == targetItemName then
          return true
        end
      end
    end
    return false
  end

  self.adjustChatSuggestions = function(data)
    TriggerClientEvent('chat:removeSuggestionAll', self.source)
    for k,v in pairs(exports['essentialmode']:getCommands()) do
      if v.job == "everyone" then
        local group = exports["essentialmode"]:getPlayerFromId(self.source).getGroup()
        if exports['essentialmode']:CanGroupTarget(group, v.group) then
          TriggerClientEvent('chat:addSuggestion', self.source, '/' .. k, v.help, v.params)
        end
      else
        local allowed = 0;
        for k,vc in pairs(v.job) do
          if data == vc then
            allowed = 1
          end
        end
        if allowed == 1 then
          TriggerClientEvent('chat:addSuggestion', self.source, '/' .. k, v.help, v.params)
        end
      end
    end
  end

  -- public:
  local rTable = {}

  rTable.getSelf = function()
    return self
  end

  rTable.get = function(field)
    return self[field]
  end

  rTable.set = function(field, data)
    self[field] = data
    if field == "money" then
      TriggerClientEvent("es:setMoneyDisplay", self.source, 1, data)
    elseif field == "job" then
      if data == "ems" then
        TriggerClientEvent("fire:setEMS", self.source, true)
      else
        TriggerClientEvent("fire:setEMS", self.source, false)
      end
      self.adjustChatSuggestions(data)
      TriggerClientEvent("usa_trains:setJob", self.source, data)
    end
  end

  rTable.giveMoney = function(amount)
    self.money = self.money + tonumber(amount)
    TriggerClientEvent("es:setMoneyDisplay", self.source, 1, self.money)
  end

  rTable.removeMoney = function(amount)
    amount = math.abs(amount)
    self.money = self.money - tonumber(amount)
    TriggerClientEvent("es:setMoneyDisplay", self.source, 1, self.money)
  end

  rTable.giveBank = function(amount)
    self.bank = self.bank + tonumber(amount)
  end

  rTable.removeBank = function(amount)
    self.bank = self.bank - tonumber(amount)
  end

  rTable.getName = function()
    return self.name.first .. " " .. self.name.last
  end

  rTable.getFullName = function()
    return self.name.first .. " " .. self.name.middle .. " " .. self.name.last
  end

  rTable.getInventoryWeight = function()
    local weight = 0
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local invItem = inv.items[tostring(i)]
      if invItem then
        weight = weight + ((invItem.weight or 1.0) * (invItem.quantity or 1))
      end
    end
    return weight
  end

  rTable.getWeapons = function()
    local weps = {}
    local inv = self.inventory
    for i = 0, self.inventory.MAX_CAPACITY - 1 do
      local item = self.inventory.items[tostring(i)]
      if item then
        if item.type == "weapon" then
          table.insert(weps, item)
        end
      end
    end
    return weps
  end

  rTable.hasWeapons = function()
    local inv = self.inventory
    for i = 0, self.inventory.MAX_CAPACITY - 1 do
      local item = self.inventory.items[tostring(i)]
      if item then
        if item.type == "weapon" then
          return true
        end
      end
    end
    return false
  end

  rTable.removeWeapons = function()
    local toIgnoreWeps = {"Plasma Pistol"}
    function shouldIgnoreWep(item)
      for i = 1, #toIgnoreWeps do
        if toIgnoreWeps[i] == item.name then
          return true
        end
      end
      return false
    end
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local item = inv.items[tostring(i)]
      if item and not shouldIgnoreWep(item) then
        if item.type == "weapon" then
          TriggerClientEvent("interaction:equipWeapon", self.source, item, false)
          self.inventory.items[tostring(i)] = nil
        end
      end
    end
  end

  rTable.getLicenses = function()
    local licenses = {}
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local item = inv.items[tostring(i)]
      if item then
        if item.type == "license" then
          table.insert(licenses, item)
        end
      end
    end
    return licenses
  end

  rTable.hasItem = function(item)
    return self.hasItem(item)
  end

  rTable.hasItemOfQuantity = function(itemName, quantity)
    local total = 0
    for i = 0, self.inventory.MAX_CAPACITY - 1 do
      local item = self.inventory.items[tostring(i)]
      if item and item.name == itemName then
        total = total + item.quantity
      end
    end
    return total >= quantity
  end

  rTable.hasItemWithExactName = function(item)
    local targetItemName = (item.name or item)
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local invItem = inv.items[tostring(i)]
      if invItem then
        if invItem.name == targetItemName then
          return true
        end
      end
    end
    return false
  end

  rTable.canHoldItem = function(item, quantity)
    if quantity then
      item.quantity = quantity
    end
    local newWeight = rTable.getInventoryWeight() + ((item.weight or 1.0) * (item.quantity or 1))
    -- first check weight --
    if newWeight > self.inventory.MAX_WEIGHT then
      return false
    end
    -- then check inventory space --
    if not item.notStackable then
      if self.hasItem(item) then
        return true
      else
        return self.hasRoomForAnotherItem()
      end
    else
      return self.hasRoomForAnotherItem()
    end
  end

  rTable.getItem = function(item)
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local lookingAtItem = inv.items[tostring(i)]
      if lookingAtItem then
        if type(item) == "string" then
          if lookingAtItem.name == item.name or lookingAtItem.name:find(item) then
            return lookingAtItem
          end
        elseif type(item) == "table" then
          if lookingAtItem.name == item.name or lookingAtItem.name:find(item.name) then
            if item.type == "weapon" then
              if lookingAtItem.serialNumber == item.serialNumber then
                return lookingAtItem
              end
            else
              return lookingAtItem
            end
          end
        end
      end
    end
    return nil
  end

  rTable.getAllItemsOfType = function(inType)
    local items = {}
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local lookingAtItem = inv.items[tostring(i)]
      if lookingAtItem then
        if lookingAtItem.type == inType then
          table.insert(items, lookingAtItem)
        end
      end
    end
    return items
  end

  rTable.getItemWithExactName = function(itemName)
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local item = inv.items[tostring(i)]
      if item then
        if item.name == itemName then
          return item
        end
      end
    end
    return nil
  end

  rTable.getItemByIndex = function(index)
    if self.inventory.items[tostring(index)] then
      return self.inventory.items[tostring(index)]
    else
      return nil
    end
  end

  rTable.setItemByIndex = function(index, item)
    self.inventory.items[tostring(index)] = item
  end

  rTable.getItemWithField = function(field, val)
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local item = inv.items[tostring(i)]
      if item then
        if item[field] == val then
          return item
        end
      end
    end
    return nil
  end

  rTable.getItemByUUID = function(uuid)
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local item = inv.items[tostring(i)]
      if item then
        if item.uuid and item.uuid == uuid then
          return item
        end
      end
    end
    return nil
  end

  rTable.getInventoryItems = function()
    local items = {}
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local item = inv.items[tostring(i)]
      if item then
        table.insert(items, item)
      end
    end
    return items
  end

  rTable.giveItem = function(item, quantity)
    if not item.uuid then
      item.uuid = exports.globals:generateID()
    end
    if not item.createdTime then
      item.createdTime = os.time()
    end
    if quantity then
      item.quantity = quantity
    end
    if item.type and (item.type == "food" or item.type == "drink") then
      item.notStackable = true
    end
    local firstFreeSlot = nil
     for i = 0, self.inventory.MAX_CAPACITY - 1 do
       if self.inventory.items[tostring(i)] == nil and not firstFreeSlot then
         firstFreeSlot = tostring(i)
       elseif self.inventory.items[tostring(i)] and self.inventory.items[tostring(i)].name == item.name and not item.notStackable then
         self.inventory.items[tostring(i)].quantity = self.inventory.items[tostring(i)].quantity + item.quantity
         return
       end
     end
     if firstFreeSlot then
       self.inventory.items[firstFreeSlot] = item
     end
  end

  rTable.putItemInSlot = function(item, slot, quantity, cb)
    if quantity then
      item.quantity = quantity
    end
    slot = tostring(slot)
    if not self.inventory.items[slot] then -- move to empty slot
      self.inventory.items[slot] = item
      cb(true)
    elseif self.inventory.items[slot] and self.inventory.items[slot].name == item.name and not item.notStackable then -- not empty, but stackable
      self.inventory.items[slot].quantity = self.inventory.items[slot].quantity + item.quantity
      cb(true)
    else
      cb(false)
    end
  end

-- can pass -1 as quantity to remove item completely
-- supports passing in an item name as well as an entire item object (which performs extended field matching)
-- this function is kinda messy, note to anyone reading: it is better if we remove items by the removeByUUID function instead of using this...
  rTable.removeItem = function(item, quantity)

    quantity = (quantity or 1)

    local function decrementQuantity(tempItem)
      local newQuantity = tempItem.quantity - quantity
      local quantityLeftToRemove = math.max(0, quantity - tempItem.quantity)
      if quantity == -1 then
        newQuantity = 0
      end
      if newQuantity <= 0 then
        tempItem = nil
      else
        tempItem.quantity = newQuantity
      end
      return tempItem, quantityLeftToRemove
    end
    
    while (quantity > 0) do
      local itemFound = false
      for i = 0, self.inventory.MAX_CAPACITY - 1 do
        i = tostring(i)
        if self.inventory.items[i] then
          if type(item) == "string" then -- simple name matching
            if self.inventory.items[i].name:find(item) or self.inventory.items[i].name == item then
              if self.inventory.items[i].type and self.inventory.items[i].type == "weapon" then
                TriggerClientEvent("interaction:equipWeapon", self.source, self.inventory.items[i], false)
              end
              self.inventory.items[i], quantity = decrementQuantity(self.inventory.items[i])
              itemFound = true
              break
            end
          elseif type(item) == "table" then -- extended field matching
            if self.inventory.items[i].name:find(item.name) or self.inventory.items[i].name == item.name then
              if item.type and item.type == "weapon" then
                if (item.serialNumber and item.serialNumber == self.inventory.items[i].serialNumber) or (item.uuid and item.uuid == self.inventory.items[i].uuid) then
                  TriggerClientEvent("interaction:equipWeapon", self.source, self.inventory.items[i], false)
                  self.inventory.items[i], quantity = decrementQuantity(self.inventory.items[i])
                  itemFound = true
                  break
                end
              elseif item.type and (item.type == "magazine" or item.type == "ammo") then
                if item.uuid == self.inventory.items[i].uuid then
                  self.inventory.items[i], quantity = decrementQuantity(self.inventory.items[i])
                  if self.inventory.items[i] == nil then
                    return -- end if item was removed
                  end
                  itemFound = true
                  break
                end
              else
                self.inventory.items[i], quantity = decrementQuantity(self.inventory.items[i])
                itemFound = true
                break
              end
            end
          end
        end
      end
      if not itemFound then
        break
      end
    end

  end

  rTable.removeItemByUUID = function(uuid, quantity)
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local lookingAtItem = inv.items[tostring(i)]
      if lookingAtItem then
        if lookingAtItem.uuid and lookingAtItem.uuid == uuid then
          if quantity then
            self.inventory.items[tostring(i)].quantity = self.inventory.items[tostring(i)].quantity - quantity
          else
            self.inventory.items[tostring(i)].quantity = 0
          end
          if self.inventory.items[tostring(i)].quantity <= 0 then
            if self.inventory.items[tostring(i)].type and self.inventory.items[tostring(i)].type == "weapon" then
              TriggerClientEvent("interaction:equipWeapon", self.source, self.inventory.items[i], false)
            end
            self.inventory.items[tostring(i)] = nil
          end
          return
        end
      end
    end
  end

  rTable.removeItemWithField = function(field, val, removeAll)
    for i = 0, self.inventory.MAX_CAPACITY - 1 do
      if self.inventory.items[tostring(i)] then
        local item = self.inventory.items[tostring(i)]
        if item[field] then
          if item[field] == val then
            self.inventory.items[tostring(i)] = nil
            if not removeAll then
              return
            end
          end
        end
      end
    end
  end

  rTable.removeItemWithFieldValues = function(fieldValuesTable)
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local lookingAtItem = inv.items[tostring(i)]
      if lookingAtItem then
        local allMatch = true
        for key, val in pairs(fieldValuesTable) do
          if key ~= "image" and not lookingAtItem[key] or lookingAtItem[key] ~= val then
            allMatch = false
            break
          end
        end
        if allMatch then
          print("found matching item when removing")
          self.inventory.items[tostring(i)] = nil
          return
        end
      end
    end
  end

  rTable.removeAllItems = function(excludeType)
    for i = 0, self.inventory.MAX_CAPACITY - 1 do
      i = tostring(i)
      if self.inventory.items[i] then
        if not excludeType or (excludeType and self.inventory.items[i].type and self.inventory.items[i].type ~= excludeType) then
          self.inventory.items[i] = nil
        end
      end
    end
  end

  rTable.dropAllItems = function(excludeType)
    local mycoords = GetEntityCoords(GetPlayerPed(self.source))
    for i = 0, self.inventory.MAX_CAPACITY - 1 do
      i = tostring(i)
      if self.inventory.items[i] then
        if not excludeType or (excludeType and self.inventory.items[i].type and self.inventory.items[i].type ~= excludeType) then
          self.inventory.items[i].coords = {x = mycoords.x, y = mycoords.y, z = mycoords.z}
          self.inventory.items[i].coords.x = self.inventory.items[i].coords.x + (math.random() * 1)
          self.inventory.items[i].coords.y = self.inventory.items[i].coords.y + (math.random() * 1)
          self.inventory.items[i].coords.z = self.inventory.items[i].coords.z - 0.8
          TriggerEvent("interaction:addDroppedItem", self.inventory.items[i])
          self.inventory.items[i] = nil
        end
      end
    end
  end

  rTable.removeItemByIndex = function(index, quantity)
    if self.inventory.items[tostring(index)] then
      local newQuantity = self.inventory.items[tostring(index)].quantity - quantity
      if (quantity == -1) then
        newQuantity = 0
      end
      if newQuantity <= 0 then
        if self.inventory.items[tostring(index)].name:find("Radio") then
          TriggerClientEvent("Radio.Set", self.source, false, {})
        end
        self.inventory.items[tostring(index)] = nil
      else
        self.inventory.items[tostring(index)].quantity = newQuantity
      end
    end
  end

  rTable.removeIllegalItems = function()
    local seized = {}
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local item = inv.items[tostring(i)]
      if item then
        if item.legality == "illegal" then
          table.insert(seized, item)
          if item.type == "weapon" then
            TriggerClientEvent("interaction:equipWeapon", self.source, item, false)
          end
          self.inventory.items[tostring(i)] = nil
        end
      end
    end
    return seized
  end

  rTable.modifyItemByUUID = function(uuid, newVals)
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local lookingAtItem = inv.items[tostring(i)]
      if lookingAtItem then
        if lookingAtItem.uuid and lookingAtItem.uuid == uuid then
          for key, val in pairs(newVals) do
            self.inventory.items[tostring(i)][key] = val
          end
          if self.inventory.items[tostring(i)].quantity <= 0 then
            self.inventory.items[tostring(i)] = nil -- remove item if an update passed in was setting quantity to <= 0
          end
          return
        end
      end
    end
  end

  rTable.removeAttributesFromItemByUUID = function(uuid, attributesToRemove)
    local inv = self.inventory
    for i = 0, inv.MAX_CAPACITY - 1 do
      local lookingAtItem = inv.items[tostring(i)]
      if lookingAtItem then
        if lookingAtItem.uuid and lookingAtItem.uuid == uuid then
          for j = 1, #attributesToRemove do
            self.inventory.items[tostring(i)][attributesToRemove[j]] = nil
          end
          return
        end
      end
    end
  end

  rTable.modifyItem = function(itemName, field, newVal)
    local n = (itemName.name or itemName)
    for i = 0, self.inventory.MAX_CAPACITY - 1 do
      if self.inventory.items[tostring(i)] then
        if self.inventory.items[tostring(i)].name:find(n) then
          self.inventory.items[tostring(i)][field] = newVal
          return
        end
      end
    end
  end

  rTable.moveItemSlots = function(from, to)
    from = tostring(from)
    to = tostring(to)
    local inv = self.inventory
    if inv.items[from] then
      if inv.items[to] then
        if not inv.items[to].notStackable and inv.items[to].name == inv.items[from].name then
          self.inventory.items[to].quantity = inv.items[to].quantity + inv.items[from].quantity
          self.inventory.items[from] = nil
        end
      else
        -- make sure to remove weapon from client ped if the player moved their selected weapon out slot with it drawn (to prevent infinite ammo exploiting)
        if self.inventory.items[from].type and self.inventory.items[from].type == "weapon" then
          if (self.currentlySelectedIndex and self.currentlySelectedIndex == tonumber(from)) or (self.lastSelectedIndex and self.lastSelectedIndex == tonumber(from)) then -- only checking lastSelectedIndex here due to an issue with usa_holster
            TriggerClientEvent("interaction:equipWeapon", self.source, self.inventory.items[from], false)
          end
        end
        -- do the move!
        self.inventory.items[to] = inv.items[from]
        self.inventory.items[from] = nil
      end
    end
  end

  rTable.setCoords = function(coords)
    if coords and self.source then
      TriggerClientEvent("character:setCoords", self.source, coords)
    end
  end

  rTable.notify = function(message)
    TriggerClientEvent("usa:notify", self.source, message, "INFO: " .. message)
  end

  return rTable
end
