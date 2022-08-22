local ITEMS = {
    helicopters = {
        ["Havok"] = { name = "Havok", hash = "havok", price = 65000},
        ["Frogger"] = { name = "Frogger", hash = "frogger", price = 75000},
        ["Supervolito"] = { name = "Supervolito", hash = "supervolito", price = 75000},
        ["Swift"] = { name = "Swift", hash = "swift", price = 85000},
        ["Swift 2"] = { name = "Swift 2", hash = "swift2", price = 90000}
    },
    planes = {
        ["Cuban 800"] = { name = "Cuban 800", hash = "cuban800", price = 70000},
        ["Dodo"] = { name = "Dodo", hash = "dodo", price = 85000},
        ["Duster"] = { name = "Duster", hash = "duster", price = 50000},
        ["Mammatus"] = { name = "Mammatus", hash = "mammatus", price = 80000},
        ["Stunt"] = { name = "Stunt", hash = "stunt", price = 85000},
        ["Microlight"] = { name = "Microlight", hash = "microlight", price = 45000},
        ["Alpha Z1"] = { name = "Alpha Z!", hash = "alphaz1", price = 110000},
        ["Seabreeze"] = { name = "Seabreeze", hash = "seabreeze", price = 100000},
        ["Velum"] = { name = "Velum", hash = "velum", price = 85000},
        ["Vestra"] = { name = "Vestra", hash = "vestra", price = 150000},
        ["Nimbus"] = { name = "Nimbus", hash = "nimbus", price = 150000},
        ["Shamal"] = { name = "Shamal", hash = "shamal", price = 150000},
        ["Luxor"] = { name = "Luxor", hash = "luxor", price = 150000},
        ["Luxor 2"] = { name = "Luxor 2", hash = "luxor2", price = 155000}
    }
}

local LICENSE_PURCHASE_PRICE = 1000

local RENTAL_PERCENTAGE = 0.40
local CLAIM_PERCENTAGE = 0.05

local PARACHUTE_ITEM = { name = "Parachute", type = "weapon", hash = "GADGET_PARACHUTE", price = 500, legality = "legal", quantity = 1, weight = 8, objectModel = "prop_parachute" }

RegisterServerEvent('aircraft:requestOpenMenu')
AddEventHandler('aircraft:requestOpenMenu', function()
  local char = exports["usa-characters"]:GetCharacter(source)
  local license = char.getItem("Aircraft License")
    if license then
            TriggerClientEvent('aircraft:openMenu', source, (char.get("aircraft") or {}))
    else
        TriggerClientEvent('usa:notify', source, 'No license! Hold E to purchase one for $' .. exports["globals"]:comma_value(LICENSE_PURCHASE_PRICE))
    end
end)

RegisterServerEvent('aircraft:loadItems')
AddEventHandler('aircraft:loadItems', function()
    TriggerClientEvent("aircraft:loadItems", source, ITEMS, RENTAL_PERCENTAGE, CLAIM_PERCENTAGE)
end)

RegisterServerEvent('aircraft:purchaseParachute')
AddEventHandler('aircraft:purchaseParachute', function()
    local char = exports["usa-characters"]:GetCharacter(source)
    if char.canHoldItem(PARACHUTE_ITEM) then
        if char.get("money") >= PARACHUTE_ITEM.price then
          char.removeMoney(PARACHUTE_ITEM.price)
          char.giveItem(PARACHUTE_ITEM, 1)
          TriggerClientEvent("usa:notify", source, "Purchased: ~y~" .. PARACHUTE_ITEM.name)
        else
            TriggerClientEvent("usa:notify", source, "Not enough money")
        end
    else
        TriggerClientEvent("usa:notify", source, "Inventory full")
    end
end)

-- # note: plate == first 8 digits of aircraft.id
RegisterServerEvent('aircraft:requestReturn')
AddEventHandler('aircraft:requestReturn', function(plate)
    local char = exports["usa-characters"]:GetCharacter(source)
    local aircraft = char.get("aircraft")
    plate = plate:gsub("%s+", "") -- strip any whitespace for when client sends plate # with trailing whitespace for some reason
    for i = 1, #aircraft do 
        if tostring(aircraft[i].id):sub(1, 8) == plate then
            aircraft[i].stored = true
            char.set("aircraft", aircraft)
            TriggerClientEvent("usa:notify", source, "Aircraft returned!")
            return
        end
    end
end)

RegisterServerEvent('aircraft:requestRent')
AddEventHandler('aircraft:requestRent', function(name, business)
    local char = exports["usa-characters"]:GetCharacter(source)
    local aircraft = getAircraftItemFromName(name)
    local rentalPrice = math.floor(RENTAL_PERCENTAGE * aircraft.price)
    if char.get("money") >= rentalPrice then
        char.removeMoney(rentalPrice)
        if business then
            exports["usa-businesses"]:GiveBusinessCashPercent(business, rentalPrice)
        end
        TriggerClientEvent("aircraft:spawn", source, aircraft.hash)
        TriggerClientEvent("usa:notify", source, "Rent successful!")
    else 
        TriggerClientEvent("usa:notify", source, "Not enough money!")
    end
end)

RegisterServerEvent('aircraft:requestPurchase')
AddEventHandler('aircraft:requestPurchase', function(name, business)
    local char = exports["usa-characters"]:GetCharacter(source)
    local aircraft = getAircraftItemFromName(name)
    if char.get("money") >= aircraft.price then 
        char.removeMoney(aircraft.price)
        if business then 
            exports["usa-businesses"]:GiveBusinessCashPercent(business, aircraft.price)
        end
        local charAircraft = char.get("aircraft")
        aircraft.id = exports.globals:generateID(8)
        aircraft.plate = aircraft.id
        aircraft.stored = false
        table.insert(charAircraft, aircraft)
        char.set("aircraft", charAircraft)
        TriggerClientEvent("aircraft:spawn", source, aircraft.hash, aircraft.id)
        TriggerClientEvent("usa:notify", source, "Purchase successful!")
    else 
        TriggerClientEvent("usa:notify", source, "Not enough money!")
    end
end)

RegisterServerEvent('aircraft:requestSell')
AddEventHandler('aircraft:requestSell', function(id)
    local char = exports["usa-characters"]:GetCharacter(source)
    local aircraft = char.get("aircraft")
    for i = 1, #aircraft do
        if aircraft[i].id == id then
            local sellAmount = math.floor(0.50 * aircraft[i].price)
            char.giveMoney(sellAmount)
            TriggerClientEvent("usa:notify", source, aircraft[i].name .. " sold for $" .. exports.globals:comma_value(sellAmount))
            table.remove(aircraft, i)
            char.set("aircraft", aircraft)
            return
        end
    end
end)

RegisterServerEvent('aircraft:requestRetrieval')
AddEventHandler('aircraft:requestRetrieval', function(id)
    local char = exports["usa-characters"]:GetCharacter(source)
    local aircraft = char.get("aircraft")
    for i = 1, #aircraft do
        if aircraft[i].id == id then
            if not aircraft[i].plate then
                aircraft[i].plate = id
            end
            if aircraft[i].stored then
                aircraft[i].stored = false
                char.set("aircraft", aircraft)
                TriggerClientEvent("aircraft:spawn", source, aircraft[i].hash, aircraft[i].plate)
                TriggerClientEvent("usa:notify", source, "Retrieved!")
            else 
                TriggerClientEvent("usa:notify", source, "Not stored!")
            end
            return
        end
    end
end)

RegisterServerEvent('aircraft:claim')
AddEventHandler('aircraft:claim', function(id)
    local char = exports["usa-characters"]:GetCharacter(source)
    local aircraft = char.get("aircraft")
    for i = 1, #aircraft do
        if aircraft[i].id == id then
            local fee = CLAIM_PERCENTAGE * aircraft[i].price
            fee = math.floor(fee)
            if char.get("money") >= fee then
                char.removeMoney(fee)
                aircraft[i].stored = true
                char.set("aircraft", aircraft)
                TriggerClientEvent("usa:notify", source, aircraft[i].name .. " claimed for $" .. exports.globals:comma_value(fee))
            else
                TriggerClientEvent("usa:notify", source, "Not enough money!")
            end
            return
        end
    end
end)

RegisterServerEvent("aircraft:purchaseLicense")
AddEventHandler("aircraft:purchaseLicense", function(business)
    local timestamp = os.date("*t", os.time())
    local char = exports["usa-characters"]:GetCharacter(source)
    local NEW_PILOT_LICENSE = {
        name = 'Aircraft License',
        number = 'PL' .. tostring(math.random(1, 254367)),
        quantity = 1,
        ownerName = char.getFullName(),
        issued_by = "Seaview Aircrafts",
        ownerDob = char.get("dateOfBirth"),
        expire = timestamp.month .. "/" .. timestamp.day .. "/" .. timestamp.year + 1,
        status = "valid",
        type = "license",
        notDroppable = true,
        weight = 0
    }
    if char.hasItem('Aircraft License') then
        TriggerClientEvent("usa:notify", source, 'You already have a pilots license!')
    else
        if char.get("money") < LICENSE_PURCHASE_PRICE then
            TriggerClientEvent("usa:notify", source, "Not enough money!")
            return
        end
        if not char.canHoldItem(NEW_PILOT_LICENSE) then
            TriggerClientEvent("usa:notify", source, "Inventory full!")
            return
        end
        char.giveItem(NEW_PILOT_LICENSE)
        char.removeMoney(LICENSE_PURCHASE_PRICE)
        if business then
            exports["usa-businesses"]:GiveBusinessCashPercent(business, LICENSE_PURCHASE_PRICE)
        end
        TriggerClientEvent("usa:notify", source, "You have been issued a pilot's license!")
    end
end)

function getAircraftItemFromName(name)
    for category, categoryItems in pairs(ITEMS) do
        for itemName, info in pairs(categoryItems) do
            if itemName == name then
                return info
            end
        end
    end
    return nil
end