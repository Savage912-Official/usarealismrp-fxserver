local randomnames = {
    "Frida Kline",
    "Tianna Rocha",
    "Aiden Nielsen",
    "Bryan Murphy",
    "Corinne Bowers",
    "Danica Monroe",
    "Kathleen Oliver",
    "Karsyn Campbell",
    "Jaylah Michael",
    "Amare Mullen",
    "Steven Park",
    "Phillip Drake",
    "Alfred Wolf",
    "Zackary Mullins",
    "Theodore Hull",
    "Aisha Bass",
    "Lillianna Dunn",
    "Karli Coleman",
    "Timothy Galloway",
    "Jada Kaufman"
}
--
--[[ Framework specific functions ]]--
--

local framework = shConfig.framework
local supportedFrameworks = { ESX = true, QB = true, CUSTOM = true }

if not supportedFrameworks[framework] then
    print("[^1ERROR^7] Invalid framework used in '/config/shared.lua' - please choose a supported value (ESX / QB / CUSTOM).")
end

local ESX, QBCore
if framework == 'ESX' then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif framework == 'QB' then
    QBCore = exports['qb-core']:GetCoreObject()
end

function getPlayerIdentifier(playerId)
    if framework == 'ESX' then
        return tostring(ESX.GetPlayerFromId(playerId).identifier)
    elseif framework == 'QB' then
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player then
            return tostring(Player.PlayerData.citizenid)
        end

        return -1
    else
        -- CUSTOM
        local char = exports["usa-characters"]:GetCharacter(playerId)
        if not char then
            return
        else
            return char.get("_id")
        end
    end
end

function getPlayerMoney(playerId)
    if framework == 'ESX' then
        return ESX.GetPlayerFromId(playerId).getMoney()
    elseif framework == 'QB' then
        return QBCore.Functions.GetPlayer(playerId).PlayerData.money.cash
    else
        -- CUSTOM
        local char = exports["usa-characters"]:GetCharacter(playerId)
        return char.get("bank")
    end
end

function removePlayerMoney(playerId, amount)
    if framework == 'ESX' then
        ESX.GetPlayerFromId(playerId).removeMoney(amount)
    elseif framework == 'QB' then
        local Player = QBCore.Functions.GetPlayer(playerId)
        Player.Functions.RemoveMoney('cash', amount)
    else
        -- CUSTOM
        local char = exports["usa-characters"]:GetCharacter(playerId)
        char.set("bank", char.get("bank") - amount)
        TriggerClientEvent("usa:notify",playerId, "$"..amount.." has been ~r~removed~w~ from your bank account.")
    end
end

function givePlayerMoney(playerId, amount)
    if framework == 'ESX' then
        ESX.GetPlayerFromId(playerId).addMoney(amount)
    elseif framework == 'QB' then
        local Player = QBCore.Functions.GetPlayer(playerId)
        Player.Functions.AddMoney('cash', amount)
    else
        -- CUSTOM
        local char = exports["usa-characters"]:GetCharacter(playerId)
        char.set("bank", char.get("bank") + amount)
        TriggerClientEvent("usa:notify",playerId, "$"..amount.." has been ~g~added~w~ to your bank account.")
    end
end

function giveItem(playerId, itemId, amount)
    if framework == 'ESX' then

    elseif framework == 'QB' then

    else
        -- CUSTOM
        local char = exports["usa-characters"]:GetCharacter(playerId)
        local item = {
            name = itemId,
            quantity = amount,
            legality = "legal",
            weight = 8,
        }
        if itemId == "NOS Bottle (Stage 1)" or itemId == "NOS Bottle (Stage 2)" or itemId == "NOS Bottle (Stage 3)" then
            item.weight = 50
            item.type = "mechanicPart"
            item.notStackable = true
            item.objectModel = "prop_byard_gastank02"
        elseif itemId == "Repair kit" then
            item.type = "misc"
            item.notStackable = true
            item.objectModel = "imp_prop_tool_box_01a"
        elseif itemId == "Racing Dongle" then
            item.type = "misc" 
            item.legality = "legal"
            item.weight = 1
            item.objectModel = "hei_prop_hst_usb_drive"
        elseif itemId == "Bank Laptop" then
            item.type = "misc"
            item.quantity = 1
            item.legality = "legal"
            item.notStackable = true
            item.weight = 10
            item.objectModel = "imp_prop_impexp_tablet"
        elseif itemId == "Hotwiring Kit" then
            item.type = "misc"
            item.legality = "illegal"
            item.notStackable = true
            item.weight = 10
        end
        char.giveItem(item)
        TriggerClientEvent("usa:notify", "You have picked up your item!")
    end
end

-- Use this variable if you want to set the police count with an event from another resource. If it's not nil, it will be used.
local policeCount

function getOnDutyPoliceAmount()
    if policeCount or framework == 'QB' then
        if not policeCount then -- If the QB framework has yet not set the police count.
            policeCount = 0
        end

        return policeCount
    elseif framework == 'ESX' then
        return exports["esx_service"]:GetInServiceCount("police")
    else
        -- CUSTOM
        exports.globals:getNumCops(function(num)
            policeCount = num
        end)
        if policeCount == nil then
            policeCount = 0
        end
        return policeCount
    end
end

-- This is event is only relevant if you're using QB. If you're using QB, please check the readme to make sure you have triggered this event in qb-policejob.
AddEventHandler('police:SetCopCount', function(amount)
    policeCount = amount
end)

--
--[[ General]]--
--

function notifyPlayer(playerId, message, type)
    -- TriggerClientEvent("usa:notify", playerId, message)
    TriggerClientEvent('rahe-boosting:client:notify', playerId, message, type)
end

-- The event which will be triggered when a player successfully completes his VIN scratch boosting contract.
-- This event must be used to give a vehicle to the player.
AddEventHandler('rahe-boosting:server:vinScratchSuccessful', function(playerId, vehicleModel, vehicleModelName, licensePlate, vehicleProperties, contractOwnerIdentifier)
    local char = exports["usa-characters"]:GetCharacter(playerId)
    local vehInfo = nil
    local vehicle, vehicle_key
    local restrictedVehModel = {'taxi', 'DABABY','rumpo'} -- Added a vehicle you want to get VIN Scratched? Be sure to add it to this list mofo.
    if vehicleModel ~= restrictedVehModel then
        vehInfo = exports["usa_carshop"]:GetVehicleByHashName(vehicleModel)
        -- print("Vehicle Model is ["..vehicleModel.."] and was not a restricted vehicle. Assigning info") -- debug
    end
    -- print(vehInfo) -- debug
    if vehInfo ~= nil then
        -- print("VehInfo has data, now attaching attributes") -- debug
        vehicle = {
            owner = char.getFullName(),
            make = vehInfo.make,
            model = vehInfo.model,
            hash = vehInfo.hash,
            plate = licensePlate,
            stored = true,
            price = vehInfo.price * 0.05,
            inventory = exports["usa_vehinv"]:NewInventory(vehInfo.storage_capacity),
            storage_capacity = vehInfo.storage_capacity,
        }
        vehicle_key = {
            name = "Key -- " .. licensePlate,
            quantity = 1,
            type = "key",
            owner = char.getFullName(),
            make = vehInfo.make,
            model = vehInfo.model,
            plate = licensePlate
        }
        -- print("Vehicle make is ["..vehicle.make.."] and the model is ["..vehicle.model.."].") -- debug
    else
        -- print("VehInfo has NO DATA, attaching default attributes") -- debug
        vehicle = {
            owner = char.getFullName(),
            make = vehicleModelName,
            model = vehicleModelName,
            hash = vehicleModel,
            plate = licensePlate,
            stored = true,
            price = 0,
            inventory = exports["usa_vehinv"]:NewInventory(100),
            storage_capacity = 100,
        }
        vehicle_key = {
            name = "Key -- " .. licensePlate,
            quantity = 1,
            type = "key",
            owner = char.getFullName(),
            make = vehicleModelName,
            model = vehicleModelName,
            plate = licensePlate
        }
        -- print("Vehicle make is ["..vehicle.make.."] and the model is ["..vehicle.model.."].") -- debug
    end
    -- print("The total sell price of this vehicle will be "..vehicle.price) -- DEBUG STUFF FOR WEEPY
    -- add vehicle to database
    exports.usa_carshop:AddVehicleToDB(vehicle)
    -- add vehicle to player's list of owned vehicles
    local vehs = char.get("vehicles")
    table.insert(vehs, vehicle.plate)
    char.set("vehicles", vehs)
    -- Add vehicles to MySQL for boosting vehicles
    MySQL.insert('INSERT INTO boosted_vehicles (owner_id, local_owner, vehicle, hash, plate, price) VALUES (?, ?, ?, ?, ?, ?)', {
        char.get("_id"),
        randomnames[math.random(#randomnames)],
        vehicleModel,
        GetHashKey(vehicleModel),
        licensePlate,
        vehicle.price
    })
    print("Vehicle successfully added to DB")
    -- notify
    notifyPlayer(playerId, "Your vehicle has been dropped off.", G_NOTIFICATION_TYPE_SUCCESS)
end)

-- Testing Phase
-- TriggerEvent('es:addCommand', 'boostitems', function(source, args, char)
--     local char = exports["usa-characters"]:GetCharacter(source)
--     local itemOne = { name = "Tablet", type = "misc",  quantity = 1,  legality = "legal",  weight = 3,  objectModel = "imp_prop_impexp_tablet" }
--     local itemTwo = { name = "Hacking Device", type = 'misc', legality = "illegal", weight = 5, quantity = 1, objectModel = "bkr_prop_fakeid_tablet_01a" }
--     local itemThree = { name = "GPS Removal Device",  type = 'misc',  legality = "illegal",  weight = 5,  quantity = 1,  objectModel = "bkr_prop_fakeid_tablet_01a" }
--     local itemFour = { name = 'Hotwiring Kit',  type = 'misc',  legality = 'illegal',  quantity = 3,  weight = 5 }
--     local itemFive = { name = 'Lockpick',  type = 'misc',  legality = 'illegal',  quantity = 5,  weight = 2 }
--     char.giveItem(itemOne)
--     char.giveItem(itemTwo)
--     char.giveItem(itemThree)
--     char.giveItem(itemFour)
--     char.giveItem(itemFive)
-- end, { help = "Get Boost Items - TESTING PURPOSES" })

-- Function that determines if player is a superuser (is allowed to use the admin panel).
function isPlayerSuperUser(playerIdentifier, playerId)
    local user = exports.essentialmode:getPlayerFromId(playerId)
    local ugroup = user.getGroup()
    local allowed = {"owner", "superadmin"}
    for i = 1, #allowed do
        if allowed[i] == ugroup then
            return true
        end
    end
    return false
end

RegisterServerCallback {
	eventName = 'rahe-boosting:isCop',
	eventCallback = function(source)		
		local char = exports["usa-characters"]:GetCharacter(source)
        if char == nil then
            print("Player loading in")
        elseif char.get("job") == 'sheriff' or char.get("job") == 'corrections' then
            return true
        end
        return false
	end
}