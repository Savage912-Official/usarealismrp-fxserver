----------------------------------------------------------------
-- HELP PREVENT ITEM DUPLICATIONS FROM MULTIPLE PERSON ACCESS --
----------------------------------------------------------------
local BUSY_VEHICLES = {}

function setVehicleBusy(plate)
  BUSY_VEHICLES[plate] = true
end

function getVehicleBusy(plate)
  return BUSY_VEHICLES[plate]
end

function removeVehicleBusy(plate)
  if BUSY_VEHICLES[plate] then
    BUSY_VEHICLES[plate] = nil
  end
end

-------------------------------
-- VEHICLE INVENTORY MANAGER --
-------------------------------
VehInventoryManager = {}

VehInventoryManager.beingAccessed = {
  --["12ABC123"] = { 114, 22 }
}

VehInventoryManager.tempVehicles = {
    -- ["12ABC123"] = { inventory }
}

function VehInventoryManager:NewInventory(capacity)
    return {
        MAX_ITEMS = 25,
        MAX_CAPACITY = capacity,
        currentWeight = 0.0,
        items = {}
    }
end

----------------------------------
-- Multiple User Access Helpers --
----------------------------------
function VehInventoryManager:AddPersonToInventory(plate, id)
  if not self.beingAccessed[plate] then
    self.beingAccessed[plate] = {}
  end
  self.beingAccessed[plate][id] = true
end

function VehInventoryManager:RemovePersonFromInventory(plate, id)
  if self.beingAccessed[plate] and self.beingAccessed[plate][id] then
    self.beingAccessed[plate][id] = nil
  end
end

----------------------------------
-- tempVehicles Helpers (for NPC vehicles without player owner) --
----------------------------------
function VehInventoryManager:newTempVehInv(plate)
    local toUseCapacity = (capacity or math.random(100, 200))
    self.tempVehicles[plate] = self:NewInventory(toUseCapacity)
    return self.tempVehicles[plate]
end

function VehInventoryManager:getTempVehInv(plate)
    return self.tempVehicles[plate]
end

function VehInventoryManager:updateTempVehInv(plate, updatedInv)
  self.tempVehicles[plate] = updatedInv
end

--------------------------
-- Item action helpers  --
--------------------------
VehInventoryManager.hasRoomForAnotherItem = function(inv)
  for i = 0, inv.MAX_ITEMS - 1 do
    if inv.items[tostring(i)] == nil then
      return true
    end
  end
  return false
end

VehInventoryManager.hasItem = function(inv, item)
  local targetItemName = (item.name or item)
  for i = 0, inv.MAX_ITEMS - 1 do
    local invItem = inv.items[tostring(i)]
    if invItem then
      if invItem.name:find(targetItemName) or invItem.name == targetItemName then
        return true
      end
    end
  end
  return false
end

VehInventoryManager.canHoldItem = function(inv, item)
  local newWeight = VehInventoryManager.calcWeight(inv) + ((item.weight or 1.0) * (item.quantity or 1))
  -- first check weight --
  if newWeight > inv.MAX_CAPACITY then
    return false
  end
  -- then check inventory space --
  if not item.notStackable then
    if VehInventoryManager.hasItem(inv, item) then
      return true
    else
      return VehInventoryManager.hasRoomForAnotherItem(inv)
    end
  else
    return VehInventoryManager.hasRoomForAnotherItem(inv)
  end
end

VehInventoryManager.putItemInFirstFreeSlot = function(plate, inv, item, cb)
  for i = 0, inv.MAX_ITEMS - 1 do
    i = tostring(i)
    if inv.items[i] == nil then
      inv.items[i] = item
      -- save --
      if not VehInventoryManager:getTempVehInv(plate) then
        TriggerEvent('es:exposeDBFunctions', function(db)
          db.updateDocument("vehicles", plate, { inventory = inv }, function()
            removeVehicleBusy(plate)
          end)
        end)
      else
          removeVehicleBusy(plate)
      end
      return
    end
  end
end

VehInventoryManager.putItemInSlot = function(plate, inv, item, slot)
  local retOk, retMsg = nil
  slot = tostring(slot)
  if not inv.items[slot] then -- no item in slot already
    inv.items[slot] = item
    retOk = true
  elseif inv.items[slot] and inv.items[slot].name == item.name and not item.notStackable then -- item in slot already, but stackable
    inv.items[slot].quantity = inv.items[slot].quantity + item.quantity
    retOk = true
  else
    retOk = false
    retMsg = "Invalid slot"
  end
  -- save --
  if not VehInventoryManager:getTempVehInv(plate) then
    local waiting = true
    TriggerEvent('es:exposeDBFunctions', function(db)
      db.updateDocument("vehicles", plate, { inventory = inv }, function()
        removeVehicleBusy(plate)
        waiting = false
      end)
    end)
    while waiting == true do
      Wait(1)
    end
  else
      removeVehicleBusy(plate)
  end
  return retOk, retMsg
end

VehInventoryManager.calcWeight = function(inv)
  local weight = 0
  for index, item in pairs(inv.items) do
    weight = weight + ((item.weight or 1.0) * (item.quantity or 1))
  end
  return weight
end

VehInventoryManager.removeItemInSlot = function(plate, inv, slot, quantity)
  slot = tostring(slot)
  if inv.items[slot].quantity - quantity < 0 then
    quantity = inv.items[slot].quantity
  end
  if inv.items[slot] then
    inv.items[slot].quantity = inv.items[slot].quantity - quantity
    if inv.items[slot].quantity <= 0 then
      inv.items[slot] = nil
    end
    -- save --
    if not VehInventoryManager:getTempVehInv(plate) then
        TriggerEvent('es:exposeDBFunctions', function(db)
          db.updateDocument("vehicles", plate, { inventory = inv }, function()
            removeVehicleBusy(plate)
          end)
        end)
    else
        removeVehicleBusy(plate)
    end
  end
end

VehInventoryManager.moveItemSlots = function(plate, inv, from, to)
  from = tostring(from)
  to = tostring(to)
  if inv.items[from] then
    if inv.items[to] then
      if not inv.items[to].notStackable and inv.items[to].name == inv.items[from].name then
        inv.items[to].quantity = inv.items[to].quantity + inv.items[from].quantity
        inv.items[from] = nil
      end
    else
      inv.items[to] = inv.items[from]
      inv.items[from] = nil
    end
  end
  -- save --
  if not VehInventoryManager:getTempVehInv(plate) then
      TriggerEvent('es:exposeDBFunctions', function(db)
        db.updateDocument("vehicles", plate, { inventory = inv }, function()
          removeVehicleBusy(plate)
        end)
      end)
  else
      removeVehicleBusy(plate)
  end
end

VehInventoryManager.removeAllIllegalItems = function(src, plate, inv, notify)
  -- remove --
  for i = 0, (inv.MAX_CAPACITY - 1) do
    local invItem = inv.items[tostring(i)]
    if invItem then
      if invItem.legality and invItem.legality == "illegal" then
        inv.items[tostring(i)] = nil
        if src and notify then
          TriggerClientEvent("usa:notify", src, "~y~Seized: ~w~(" .. (invItem.quantity or 1) .. "x) " .. invItem.name)
        end
      end
    end
  end
  -- save --
  TriggerEvent('es:exposeDBFunctions', function(db)
    db.updateDocument("vehicles", plate, { inventory = inv }, function() end)
  end)
end

VehInventoryManager.seizeVeh = function(src, plate, inv, notify, arg)
  -- remove --
  for i = 0, (inv.MAX_CAPACITY - 1) do
    local invItem = inv.items[tostring(i)]
    if invItem then
      if invItem.type and invItem.type == arg then
        inv.items[tostring(i)] = nil
        if src and notify then
          TriggerClientEvent("usa:notify", src, "~y~Seized: ~w~(" .. (invItem.quantity or 1) .. "x) " .. invItem.name)
        end
      end
    end
  end
  -- save --
  TriggerEvent('es:exposeDBFunctions', function(db)
    db.updateDocument("vehicles", plate, { inventory = inv }, function() end)
  end)
end