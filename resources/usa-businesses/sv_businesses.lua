BUSINESS_AMOUT_CHAR = {}

RegisterServerEvent("business:storeMoney")
AddEventHandler("business:storeMoney", function(name, amount)
  local usource = source
  amount = math.abs(amount)
  local char = exports["usa-characters"]:GetCharacter(source)
  if char.get("money") >= amount then
    char.removeMoney(amount)
    GiveBusinessCash(name, amount, function(success)
      TriggerClientEvent("usa:notify", usource, "Deposited: $" .. comma_value(amount))
    end)
  end
end)

RegisterServerEvent("business:withdraw")
AddEventHandler("business:withdraw", function(name, amount)
  local usource = source
  GetBusinessOwner(name, function(owner)
    local char = exports["usa-characters"]:GetCharacter(usource)
    if owner.identifiers.id == char.get("_id") then -- make sure player is owner
      GetBusinessStorage(name, function(storage)
        amount = math.abs(amount)
        if storage.cash >= amount then
          storage.cash = storage.cash - amount -- remove money from property
          SetBusinessStorage(name, storage, function(success)
            if success then
              char.giveMoney(amount)
            end
          end)
        else
          TriggerClientEvent("usa:notify", usource, "Invalid withdraw amount")
        end
      end)
    else
      DropPlayer(usource, "Exploiting")
    end
  end)
end)

RegisterServerEvent("business:store")
AddEventHandler("business:store", function(name, item, amount)
  local usource = source
  local char = exports["usa-characters"]:GetCharacter(usource)
  if char.hasItem(item.name) then -- make sure player actually has item
    local i
    if item.number then -- cell phones
      i = char.getItemWithField("number", item.number)
    else
      i = char.getItem(item.name)
    end
    if i.type ~= "license" then
      if i.quantity >= amount then
        char.removeItem(i, amount) -- remove item from player
        i.quantity = amount
        AddItemToBusinessStorage(name, i, function(success) -- store item at business
          if success then
            if i.type == "weapon" then -- if weapon
              TriggerClientEvent("interaction:equipWeapon", usource, i, false)
            end
            TriggerClientEvent("usa:notify", usource, "Item stored!")
          end
        end)
      end
    else
      TriggerClientEvent("usa:notify", usource, "Can't store licenses!")
    end
  else
    DropPlayer(usource, "Exploiting")
  end
end)

RegisterServerEvent("business:retrieve")
AddEventHandler("business:retrieve", function(name, item, amount)
  local usource = source
  local char = exports["usa-characters"]:GetCharacter(usource)
  GetBusinessStorage(name, function(storage)
    local items = storage.items
    if item.type == "weapon" and (item.uuid or item.serialNumber) then -- only weapon's have serialNumber's (because they could have same name w/ different components etc)
      for i = 1, #items do
        if (items[i].serialNumber and items[i].serialNumber == item.serialNumber) or (items[i].uuid and items[i].uuid == item.uuid) then
          local toGiveCopy = items[i]
          if char.canHoldItem(items[i]) then -- make sure player can hold amount of item
            table.remove(storage.items, i)
            -- update storage and give item to player
            SetBusinessStorage(name, storage, function(success)
              if success then
                char.giveItem(toGiveCopy)
                TriggerClientEvent("interaction:equipWeapon", usource, toGiveCopy, true, false, false)
                TriggerClientEvent("usa:notify", usource, "Retrieved: " .. item.name)
              end
            end)
            break
          else
            TriggerClientEvent("usa:notify", usource, "Inventory full!")
            return
          end
        end
      end
    else -- not a weapon
      for i = 1, #items do
        if items[i].name == item.name then
          local toGiveCopy = items[i]
          if char.canHoldItem(toGiveCopy, amount) then -- make sure player can hold amount of item
            if items[i].quantity >= amount then -- player requesting less than or equal to amount in storage
              if items[i].quantity - amount >= 1 then
                storage.items[i].quantity = storage.items[i].quantity - amount -- decrement in storage
              else
                table.remove(storage.items, i) -- remove from storage
              end
              -- update storage and give amount of item to player
              SetBusinessStorage(name, storage, function(success)
                if success then
                  toGiveCopy.quantity = amount
                  char.giveItem(toGiveCopy)
                  TriggerClientEvent("usa:notify", usource, "Retrieved: (x" .. amount .. ") " .. item.name)
                end
              end)
              break
            else
              TriggerClientEvent("usa:notify", usource, "Invalid quantity")
              return
            end
          else
            TriggerClientEvent("usa:notify", usource, "Inventory full!")
            return
          end
        end
      end
    end
  end)
end)

RegisterServerEvent("business:tryOpenMenuByName")
AddEventHandler("business:tryOpenMenuByName", function(name)
  print("trying to open business: " .. name)
  local usource = source
  local char = exports["usa-characters"]:GetCharacter(usource)
  local id = char.get("_id")
  GetBusinessByName(name, function(business)
    if business and business.owner.identifiers then
      if business.owner.identifiers.id == id then
        -- this player was the owner of this business --
        local inv = FormatInventory(char.get("inventory"))
        TriggerClientEvent("business:showMenu", usource, business, inv)
      else
        -- this player is not the owner of this business --
        TriggerClientEvent("business:notOwner", usource, business)
        local message = "This business is owned by ~y~" .. business.owner.name.full .. "~w~!"
        TriggerClientEvent("usa:notify", usource, message)
      end
    else
      -- no one owns this business --
      local message = "This business is for ~g~sale~w~!"
      message = message .. "\n"
      message = message .. "Hold ~y~E~w~ to lease for $" .. comma_value(BUSINESSES[name].price) .. " / biweekly"
      TriggerClientEvent("usa:notify", usource, message)
    end
  end)
end)

RegisterServerEvent("business:lease")
AddEventHandler("business:lease", function(name)
  print("player wants to purchase business with name: " .. name)
  local usource = source
  GetBusinessByName(name, function(business)
    if business and business.owner.name then
      TriggerClientEvent("usa:notify", usource, "~y~Owner:~w~ " .. business.owner.name.full)
    else
      local char = exports["usa-characters"]:GetCharacter(usource)
      if char.get("money") >= BUSINESSES[name].price then -- if has enough cash
        if BUSINESS_AMOUT_CHAR[char.get("_id")] < MAX_OWNED_BUSINESSES then
          char.removeMoney(BUSINESSES[name].price) -- take money
          BUSINESS_AMOUT_CHAR[char.get("_id")] = BUSINESS_AMOUT_CHAR[char.get("_id")] + 1
          CreateNewBusiness(usource, name, function(newBusinessDoc) -- create doc
            TriggerClientEvent("usa:notify", usource, "You now own: " .. name .. "! " .. BUSINESS_AMOUT_CHAR[char.get("_id")] .. "/" .. MAX_OWNED_BUSINESSES .. " max businesses!")
            SendToDiscordLog(newBusinessDoc)
            TriggerClientEvent("businesses:addMapBlip", usource, BUSINESSES[name].position)
          end)
        else
          TriggerClientEvent("usa:notify", usource, "You already have too many businesses!")
        end
      else
        TriggerClientEvent("usa:notify", usource, "You need $" .. comma_value(BUSINESSES[name].price) .. " to lease this business.")
      end
    end
  end)
end)

AddEventHandler("character:loaded", function(char)
  -- grab all owned businesses with this char's identifier and send their positions to the client for adding blips to map
  loadCharBusinesses(char)
end)

AddEventHandler('onResourceStart', function(resourceName)
  for i,v in ipairs(GetPlayers()) do
    -- grab all owned businesses with this char's identifier and send their positions to the client for adding blips to map
    local char = exports["usa-characters"]:GetCharacter(tonumber(v))
    loadCharBusinesses(char)
  end
end)

function loadCharBusinesses(char)
  TriggerEvent("es:exposeDBFunctions", function(db)
    local query = {
      owner = {
        identifiers = {
          id = char.get("_id")
        }
      }
    }
    db.findDocuments("businesses", { selector = query }, function(docs)
      local ownedBusinessesMapBlipData = {}
      local counter = 0
      for i = 1, #docs do
        counter = counter + 1
        print(docs[i].name)
        ownedBusinessesMapBlipData[docs[i].name] = BUSINESSES[docs[i].name].position
      end
      BUSINESS_AMOUT_CHAR[char.get("_id")] = counter
      TriggerClientEvent("businesses:addMapBlips", char.get("source"), ownedBusinessesMapBlipData)
    end)
  end)
end

-- remove percentage from cash and return amount taken --
function RobPercentageOfCashFromBusiness(name, percentage, cb)
    GetBusinessStorage(name, function(storage)
        local reward = math.floor(storage.cash * percentage)
        storage.cash = storage.cash - reward
        SetBusinessStorage(name, storage, function(success)
            cb(reward)
        end)
    end)
end

function CheckBusinessLeases()
  -- get each business' paid time & _id
  -- if any are due, remove their owners
  for name, info in pairs(BUSINESSES) do
    GetBusinessFeeInfo(RemoveSpaces(name), function(fee)
      if GetWholeDaysFromTime(fee.paidAt) > LEASE_PERIOD_DAYS then
        print("Lease expired for business: " .. fee._id)
        TriggerEvent("es:exposeDBFunctions", function(db)
          db.updateDocument("businesses", fee._id, { owner = {} }, function(err)
            print("Owner evicted from " .. fee._id .. "!")
          end)
        end)
      end
    end)
  end
end

function FormatInventory(charInv)
  local inv = {}
  for i = 0, charInv.MAX_CAPACITY - 1 do
    if charInv.items[tostring(i)] then
      table.insert(inv, charInv.items[tostring(i)])
    end
  end
  return inv
end

function AddItemToBusinessStorage(name, item, cb)
  GetBusinessStorage(name, function(storage)
    local hasAlready = false
    if not item.serialNumber then -- not a weapon (stackable)
      local items = storage.items
      for i = 1, #items do
        if items[i].name == item.name then
          storage.items[i].quantity = storage.items[i].quantity + item.quantity -- found, just increment quantity
          hasAlready = true
          break
        end
      end
      if not hasAlready then
        table.insert(storage.items, item) -- not found, insert
      end
    else
      table.insert(storage.items, item) -- just insert, not stackable
    end
    SetBusinessStorage(name, storage, function(success)
      cb(success)
    end)
  end)
end

function GetBusinessStorage(name, cb)
  local endpoint = "/businesses/_design/businessFilters/_view/getBusinessStorage"
  local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
  PerformHttpRequest(url, function(err, responseText, headers)
    if err == 404 then
      return
    end
    local data = json.decode(responseText)
    if data.total_rows > 0 then
      if data.rows then
        for i = 1, #data.rows do
          local storage = data.rows[i].value
          cb(storage)
        end
      end
    else
      cb(nil)
    end
  end, "POST", json.encode({
    keys = { RemoveSpaces(name) }
  }), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

function SetBusinessStorage(name, storage, cb)
  TriggerEvent("es:exposeDBFunctions", function(db)
    db.updateDocument("businesses", RemoveSpaces(name), { storage = storage }, function(err)
      cb(true)
    end)
  end)
end

function GiveBusinessCash(name, amount, cb)
  GetBusinessStorage(name, function(storage)
    storage.cash = storage.cash + amount
    -- set money --
    TriggerEvent("es:exposeDBFunctions", function(db)
      db.updateDocument("businesses", RemoveSpaces(name), { storage = storage }, function(err)
        cb(true)
      end)
    end)
  end)
end

function GiveBusinessCashPercent(name, amount)
  if name then
    GetBusinessStorage(name, function(storage)
      if storage then
        storage.cash = storage.cash + math.floor((BUSINESSES[name].purchasePercentage or DEFAULT_PURCHASE_PERCENT_REWARD) * amount)
        -- set money --
        TriggerEvent("es:exposeDBFunctions", function(db)
          db.updateDocument("businesses", RemoveSpaces(name), { storage = storage }, function(newDoc) end)
        end)
      else
        print("usa-businesses: Error getting storage inside of GiveBusinessCashPercent")
      end
    end)
  end
end

function CreateNewBusiness(src, name, cb)
  local owner = exports["usa-characters"]:GetCharacter(src)
  TriggerEvent('es:exposeDBFunctions', function(db)
    GetBusinessByName(name, function(business)
      if business then
        UpdateOwnerOfExistingBusinessDoc(src, name, owner, cb, db)
      else
        CreateEntirelyNewBusinessDoc(src, name, owner, cb, db)
      end
    end)
  end)
end

function UpdateOwnerOfExistingBusinessDoc(src, name, owner, cb, db)
  local newOwner = {
    identifiers = {
      id = owner.get("_id"),
      steam = GetPlayerIdentifiers(src)[1]
    },
    name = {
      full = owner.getFullName()
    }
  }
  local today = os.date("*t", os.time())
  local leaseEndTime = os.time({day = today.day + LEASE_PERIOD_DAYS, month = today.month, year = today.year}) -- todo: need to make sure 2 week date is calculated correctly,,
  local newFeeDeets = {
    price = BUSINESSES[name].price,
    paidAt = os.time(),
    due = {
      time = leaseEndTime,
      date = os.date("%x", leaseEndTime)
    }
  }
  db.updateDocument("businesses", RemoveSpaces(name), { owner = newOwner, fee = newFeeDeets}, function(newDoc)
    cb(newDoc)
  end)
end

function CreateEntirelyNewBusinessDoc(src, name, owner, cb, db)
    local business = {}
    business.name = name
    business.owner = {
      identifiers = {
        id = owner.get("_id"),
        steam = GetPlayerIdentifiers(src)[1]
      },
      name = {
        full = owner.getFullName()
      }
    }
    business.storage = {
      cash = 0,
      items = {}
    }
    local today = os.date("*t", os.time())
    local leaseEndTime = os.time({day = today.day + LEASE_PERIOD_DAYS, month = today.month, year = today.year}) -- todo: need to make sure 2 week date is calculated correctly,,
    business.fee = {
      price = BUSINESSES[name].price,
      paidAt = os.time(),
      due = {
        time = leaseEndTime,
        date = os.date("%x", leaseEndTime)
      }
    }
    db.createDocumentWithId("businesses", business, RemoveSpaces(name), function(success)
      if success then
        cb(business)
      else
        TriggerClientEvent("usa:notify", src, "There was a problem signing the lease!")
      end
    end)
end

function GetBusinessOwner(name, cb)
  local endpoint = "/businesses/_design/businessFilters/_view/getBusinessOwner"
  local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
  PerformHttpRequest(url, function(err, responseText, headers)
    if err == 404 then
      return
    end
    local data = json.decode(responseText)
    if data.total_rows > 0 then
      if data.rows then
        for i = 1, #data.rows do
          local owner = data.rows[i].value
          cb(owner)
        end
      end
    end
  end, "POST", json.encode({
    keys = { RemoveSpaces(name) }
  }), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

function GetBusinessByName(name, cb)
  local endpoint = "/businesses/_design/businessFilters/_view/getBusinessByName"
  local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
  PerformHttpRequest(url, function(err, responseText, headers)
    if err == 404 then
      cb(nil)
      return
    end
    local data = json.decode(responseText)
    if #data.rows > 0 then
      if data.rows then
        for i = 1, #data.rows do
          local business = data.rows[i].value
          cb(business)
        end
      end
    else
      cb(nil)
    end
  end, "POST", json.encode({
    keys = { RemoveSpaces(name) }
  }), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

function GetBusinessFeeInfo(name, cb)
  local endpoint = "/businesses/_design/businessFilters/_view/getBusinessFeeInfo"
  local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
  PerformHttpRequest(url, function(err, responseText, headers)
    if err == 404 then
      return
    end
    local data = json.decode(responseText)
    if data.total_rows > 0 then
      if data.rows then
        for i = 1, #data.rows do
          local info = {
            _id = data.rows[i].value[1],
            paidAt = data.rows[i].value[2]
          }
          cb(info)
        end
      end
    end
  end, "POST", json.encode({
    keys = { RemoveSpaces(name) }
  }), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

function RemoveSpaces(s)
  return s:gsub("%s+", "")
end

function GetWholeDaysFromTime(time)
	local reference = time
	local daysfrom = os.difftime(os.time(), reference) / (24 * 60 * 60) -- seconds in a day
	local wholedays = math.floor(daysfrom)
	return wholedays
end

function SendToDiscordLog(business)
  local desc = "\n**Property:** " .. business.name .. "\n**Purchase Price:** $" .. comma_value(business.fee.price) ..  "\n**Purchased By:** " .. business.owner.name.full .. "\n**End Date:** " .. business.fee.due.date
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
          name = "SAN ANDREAS BUSINESS MGMT"
        }
      }
    }
  }), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
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

exports["globals"]:PerformDBCheck("usa-businesses", "businesses", CheckBusinessLeases)
