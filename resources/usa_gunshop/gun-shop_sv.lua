local STORE_ITEMS = {
  ["Handguns"] = {
    { name = "Pistol", type = "weapon", hash = 453432689, price = 5000, quantity = 1, weight = 15, objectModel = "w_pi_pistol" },
    { name = "Heavy Pistol", type = "weapon", hash = -771403250, price = 7500, quantity = 1, weight = 20, objectModel = "w_pi_heavypistol" },
    { name = "50 Caliber", type = "weapon", hash = -1716589765, price = 10000, quantity = 1, weight = 20, objectModel = "w_pi_pistol50" },
    { name = "SNS Pistol", type = "weapon", hash = -1076751822, price = 4000, quantity = 1, weight = 12, objectModel = "w_pi_sns_pistol" },
    { name = "Glock", type = "weapon", hash = 1593441988, price = 7000, quantity = 1, weight = 15, objectModel = "w_pi_combatpistol" },
    { name = "MK2", type = "weapon", hash = -1075685676, price = 6000, quantity = 1, weight = 15 },
    { name = "Vintage Pistol", type = "weapon", hash = 137902532, price = 5000, quantity = 1, weight = 15, objectModel = "w_pi_vintage_pistol" },
    --{ name = "Stun Gun", type = "weapon", hash = 911657153, price = 1500, quantity = 1, weight = 5, objectModel = "w_pi_stungun" }
    --{ name = "Marksman Pistol", type = "weapon", hash = -598887786, price = 2000, quantity = 1, weight = 15 },
    --{ name = "Revolver", type = "weapon", hash = -1045183535, price = 2000, quantity = 1, weight = 15 }
  },
  ["Shotguns"] = {
    { name = "Pump Shotgun", type = "weapon", hash = 487013001, price = 10000, quantity = 1, weight = 25, objectModel = "w_sg_pumpshotgun" },
    { name = "Bullpup Shotgun", type = "weapon", hash = -1654528753, price = 25000, quantity = 1, weight = 30, objectModel = "w_sg_bullpupshotgun" },
    { name = "Musket", type = "weapon", hash = -1466123874, price = 15000, quantity = 1, weight = 35, objectModel = "w_ar_musket" }
  },
  ["Extras"] = {
    { name = "Body Armor", type = "misc", price = 1000, quantity = 1, weight = 15, objectModel = "prop_bodyarmour_03" },
    { name = "Fire Extinguisher", type = "weapon",  hash = 101631238, price = 400, weight = 20, objectModel = "prop_fire_hosereel" }
  },
  ["Magazines"] = {
    { name = "Empty 9mm Mag [7]", type = "magazine", price = 250, weight = 7, receives = "9mm", MAX_CAPACITY = 7, currentCapacity = 0 },
    { name = "Empty 9mm Mag [12]", type = "magazine", price = 250, weight = 7, receives = "9mm", MAX_CAPACITY = 12, currentCapacity = 0 },
    { name = "Empty .50 Cal Mag [9]", type = "magazine", price = 400, weight = 7, receives = ".50 Cal", MAX_CAPACITY = 9, currentCapacity = 0 },
    { name = "Empty .45 Mag [6]", type = "magazine", price = 300, weight = 7, receives = ".45", MAX_CAPACITY = 6, currentCapacity = 0 },
    { name = "Empty .45 Mag [18]", type = "magazine", price = 360, weight = 7, receives = ".45", MAX_CAPACITY = 18, currentCapacity = 0 },
  },
  ["Ammunition"] = {
    { name = "9mm Bullets", type = "ammo", price = 500, weight = 0.5, quantity = 10, objectModel = "prop_ld_ammo_pack_01" },
    { name = ".50 Cal Bullets", type = "ammo", price = 700, weight = 0.5, quantity = 10, objectModel = "prop_ld_ammo_pack_01" },
    { name = ".45 Bullets", type = "ammo", price = 500, weight = 0.5, quantity = 10, objectModel = "prop_ld_ammo_pack_01" },
    { name = "12 Gauge Shells", type = "ammo", price = 600, weight = 0.5, quantity = 10, objectModel = "prop_ld_ammo_pack_03" },
    { name = "Musket Ammo", type = "ammo", price = 600, weight = 0.5, quantity = 10, objectModel = "prop_ld_ammo_pack_03" }
  }
}

for category, items in pairs(STORE_ITEMS) do
    for i = 1, #items do
      items[i].legality = "legal"
      if items[i].type and items[i].type == "weapon" or items[i].type == "magazine" then
        items[i].notStackable = true
        if items[i].type == "weapon" then
          items[i].hash = items[i].hash & 0xFFFFFFFF -- make hash unsigned
        end
      end
    end
end

local LICENSE_PURCHASE_PRICE = 7000

exports["globals"]:PerformDBCheck("usa_gunshop", "legalweapons")

RegisterServerEvent("gunShop:getItems")
AddEventHandler("gunShop:getItems", function()
    TriggerClientEvent("gunShop:getItems", source, STORE_ITEMS)
end)

RegisterServerEvent("gunShop:requestPurchase")
AddEventHandler("gunShop:requestPurchase", function(category, index, business)
  local usource = source
  local requestedItem = STORE_ITEMS[category][index]
  local char = exports["usa-characters"]:GetCharacter(usource)
  local permit_status = checkPermit(char)
  local buyerName = char.getFullName()
  if permit_status == "valid" then
    local money = char.get("money")
    if char.hasEnoughMoneyOrBank(STORE_ITEMS[category][index].price) then
      if not char.canHoldItem(requestedItem) then
        TriggerClientEvent("usa:notify", source, "Inventory full!")
      else
        local weaponDB = {}
        requestedItem.uuid = exports.globals:generateID()
        if requestedItem.type == "weapon" then
          requestedItem.serialNumber = requestedItem.uuid
          weaponDB.serialNumber = requestedItem.uuid
          TriggerClientEvent("gunShop:addRecentlyPurchased", usource, buyerName)
        end
        char.giveItem(requestedItem, (requestedItem.quantity or 1))
        char.removeMoneyOrBank(STORE_ITEMS[category][index].price)
        if business then
            exports["usa-businesses"]:GiveBusinessCashPercent(business, STORE_ITEMS[category][index].price)
        end
        TriggerClientEvent("mini:equipWeapon", usource, STORE_ITEMS[category][index].hash, false, false)
        TriggerClientEvent('usa:notify', usource, 'Purchased: ~y~'..requestedItem.name.. '\n~s~Price: ~y~$'..STORE_ITEMS[category][index].price)
        if requestedItem.type == "weapon" and weaponDB.serialNumber then
          local timestamp = os.date("*t", os.time())
          weaponDB.name = requestedItem.name
          weaponDB.ownerName = char.getFullName()
          weaponDB.ownerDOB = char.get('dateOfBirth')
          weaponDB.issueDate = timestamp.month .. "/" .. timestamp.day .. "/" .. timestamp.year
          TriggerEvent('es:exposeDBFunctions', function(couchdb)
            couchdb.createDocumentWithId("legalweapons", weaponDB, weaponDB.serialNumber, function(success)
                if success then
                    print("* Weapon created serial["..(weaponDB.serialNumber or "No Serial").."] name["..weaponDB.name.."] owner["..weaponDB.ownerName.."] *")
                else
                    print("* Error: Weapon failed to be created!! *")
                end
            end)
          end)
        end
      end
    else
      TriggerClientEvent("usa:notify", source, "Not enough money!")
    end
  elseif permit_status == "suspended" then
    TriggerClientEvent("usa:notify", usource, "Your permit is suspended!")
  elseif permit_status == "none" then
    TriggerClientEvent("usa:notify", usource, "You do not have a valid ~y~Firearm Permit~s~!")
  end
end)

RegisterServerEvent('gunShop:requestOpenMenu')
AddEventHandler('gunShop:requestOpenMenu', function()
  local char = exports["usa-characters"]:GetCharacter(source)
  local permit_status = checkPermit(char)
  if permit_status == 'valid' then
    TriggerClientEvent('gunShop:openMenu', source)
  else
      if permit_status == "none" then
          TriggerClientEvent('usa:notify', source, 'No license! Hold E to purchase one for $' .. exports["globals"]:comma_value(LICENSE_PURCHASE_PRICE))
      elseif permit_status == "suspended" then
          TriggerClientEvent("usa:notify", source, "Your firearm permit is suspended!")
      end
  end
end)

RegisterServerEvent("gunShop:purchaseLicense")
AddEventHandler("gunShop:purchaseLicense", function(business)
  local usource = source
  local timestamp = os.date("*t", os.time())
  local char = exports["usa-characters"]:GetCharacter(usource)
  local permit_status = checkPermit(char)
  if not exports.globals:hasFelonyOnRecord(usource) then
    local NEW_GUN_LICENSE = {
      name = 'Firearm Permit',
      number = 'FP' .. tostring(math.random(1, 254367)),
      quantity = 1,
      ownerName = char.getFullName(),
      issued_by = "Ammunation",
      ownerDob = char.get("dateOfBirth"),
      expire = timestamp.month .. "/" .. timestamp.day .. "/" .. timestamp.year + 1,
      status = "valid",
      type = "license",
      notDroppable = true,
      weight = 0
    }
    if char.hasItem(NEW_GUN_LICENSE) then
      TriggerClientEvent("usa:notify", usource, "You already have a firearm permit!")
      return
    end
    if char.canHoldItem(NEW_GUN_LICENSE) then
      if char.hasEnoughMoneyOrBank(LICENSE_PURCHASE_PRICE) then
          char.giveItem(NEW_GUN_LICENSE)
          char.removeMoneyOrBank(LICENSE_PURCHASE_PRICE)
          TriggerClientEvent("usa:notify", usource, "You have accepted the terms and conditions and have been issued a CCW")
          TriggerClientEvent("gunShop:showCCWTerms", usource)
          if business then
              exports["usa-businesses"]:GiveBusinessCashPercent(business, LICENSE_PURCHASE_PRICE)
          end
      else
          TriggerClientEvent("usa:notify", usource, "Not enough money!")
      end
    else
      TriggerClientEvent("usa:notify", usource, "Inventory full!")
    end
  else
    TriggerClientEvent("usa:notify", usource, "You have a felony on your record! We can't issue you a permit!")
  end
end)

function checkPermit(char)
  local license = char.getItem("Firearm Permit")
  if license then
    return license.status
  end
  return "none"
end

function ShowCCWTerms(src)
    TriggerClientEvent('chatMessage', src, '', { 0, 0, 0 }, "^01) The license holder is legally allowed to carry a weapon so long as it remains ^3CONCEALED^0 at all times.")
    Wait(4000)
    TriggerClientEvent('chatMessage', src, '', { 0, 0, 0 }, "^02) If contacted by a law enforcement officer for any reason, and the license holder is armed, the license holder shall immediately inform the officer they are a CCW licensee and when the officer requests the license holder’s CCW license, the license holder will provide their CCW license as proof they are legally carrying a concealed weapon.")
    Wait(9000)
    TriggerClientEvent('chatMessage', src, '', { 0, 0, 0 }, "^03) License holder shall surrender the CCW license and/or concealed weapon to any sworn peace officer upon demand.")
    Wait(5000)
    TriggerClientEvent('chatMessage', src, '', { 0, 0, 0 }, "^04) License holder shall not unnecessarily display or expose the concealed weapon or license.")
end

function generateSerialNumber()
  local letters = {}
  for i = 65,  90 do table.insert(letters, string.char(i)) end -- add capital letters
  local serialEnding = math.random(100000000, 999999999)
  local serialLetter = letters[math.random(#letters)]
  return serialLetter .. serialEnding
end
