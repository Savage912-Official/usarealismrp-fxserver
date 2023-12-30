local db = nil

local july4thRewardItems = {
    { name = "Large Firework", type = "misc", price = 2000, legality = "illegal", quantity = 5, weight = 15, objectModel = "ind_prop_firework_03" },
    { name = "Firework Gun", type = "weapon", hash = 2138347493, price = 5000, legality = "illegal", quantity = 1, weight = 35, objectModel = "w_lr_firework", notStackable = true },
    { name = "Firework Projectile", legality = "illegal", type = "ammo", price = 400, weight = 15, quantity = 1 },
    { name = "Firework Projectile", legality = "illegal", type = "ammo", price = 400, weight = 15, quantity = 1 },
    { name = "Firework Projectile", legality = "illegal", type = "ammo", price = 400, weight = 15, quantity = 1 },
    { name = "Firework Projectile", legality = "illegal", type = "ammo", price = 400, weight = 15, quantity = 1 },
    { name = "Firework Projectile", legality = "illegal", type = "ammo", price = 400, weight = 15, quantity = 1 },
}

TriggerEvent('es:exposeDBFunctions', function(couchdb)
    db = couchdb
end)

TriggerEvent("es:addCommand", "store", function(source, args, char, location)
    if CanPlayerStartCommerceSession(source) then 
        TriggerClientEvent("commerce:openStore", source)
    else 
        TriggerClientEvent("usa:notify", source, "Please sign into your FiveM account!", "^3USARRP STORE: ^0Please sign into your FiveM account! You can do this right after FiveM starts (see the top) or by clicking 'Settings' at the top.")
    end
end, {
	help = "Open the in-game market place!"
})

TriggerEvent("es:addCommand", "commerce", function(source, args, char, location)
    if CanPlayerStartCommerceSession(source) then 
        TriggerClientEvent("commerce:openStore", source)
    else 
        TriggerClientEvent("usa:notify", source, "Please sign into your FiveM account!", "^3USARRP STORE: ^0Please sign into your FiveM account! You can do this right after FiveM starts (see the top) or by clicking 'Settings' at the top.")
    end
end, {
	help = "Open the in-game market place!"
})

RegisterServerEvent("commerce:purchase")
AddEventHandler("commerce:purchase", function(id)
    local usource = source
    Citizen.CreateThread(function()
        LoadPlayerCommerceData(usource) -- makes HTTP GET request via cpp component for all available owned SKUs for player
        while not IsPlayerCommerceInfoLoaded(usource) do
            Wait(100)
        end
        if not DoesPlayerOwnSku(usource, id) then
            print("COMMERCE: starting commerce session for id " .. id .. ", type is " .. type(id))
            RequestPlayerCommerceSession(usource, id)
            TriggerClientEvent("usa:notify", usource, "A new web browser tab should open after selecting \"Yes\", check your web browser!", "^3USARRP STORE: ^0A new web browser tab should open after selecting \"Yes\", check your web browser!")
        else 
            print("COMMERCE: user already had SKU " .. id .. "!")
            TriggerClientEvent("usa:notify", usource, "You already own that item!", "^3USARRP STORE: ^0You already own that item!")
        end
    end)
end)

RegisterCommand("giveSupporterReward", function(source, args, rawCommand)
    if source == 0 then
        local type = args[1]
        local transactionID = args[2]
        print("storing " .. type .. " reward for claim! transaction ID: " .. transactionID)
        db.createDocumentWithId("tebex-transaction-ids", { type = type }, transactionID, function(ok) end)
    end
end, false)

TriggerEvent("es:addCommand", "claimreward", function(src, args, char, location)
    if args[2] and args[2]:find("tbx-") then
        local transactionID = args[2]
        db.getDocumentById("tebex-transaction-ids", transactionID, function(doc)
            if doc then
                if not doc.claimInfo then
                    TriggerClientEvent("usa:notify", src, "Claiming " .. doc.type .. " reward!")
                    if TEBEX_PACKAGE_FUNCTIONS[doc.type](src) then
                        TriggerClientEvent("usa:notify", src, "Success!")
                        doc.claimInfo = {
                            claimedBy = {
                                identifier = GetPlayerIdentifiers(src)[1],
                                name = char.getFullName(),
                            },
                            timestamp = os.date('%m-%d-%Y %H:%M:%S', os.time()),
                        }
                        db.updateDocument("tebex-transaction-ids", transactionID, doc, function(ok) end)
                        print("Tebex package successfully claimed (" .. transactionID .. ") by " .. char.getFullName() .. "!")
                    else
                        TriggerClientEvent("usa:notify", src, "Something went wrong!")
                    end
                else 
                    TriggerClientEvent("usa:notify", src, "Transaction ID already claimed!")
                end
            else
                TriggerClientEvent("usa:notify", src, "Transaction ID not found!")
            end
        end)
    elseif args[2] and args[2] == "july4th" then
        if char.get("job") ~= "eventPlanner" then
            db.getDocumentById("july-4th-rewards", char.get("_id"), function(doc)
                if not doc or (doc and not doc.claimed) then
                    -- mark as claimed
                    if not doc then
                        db.createDocumentWithId("july-4th-rewards", {claimed = true}, char.get("_id"), function(ok) end)
                    else
                        db.updateDocument("july-4th-rewards", char.get("_id"), {claimed = true}, function(ok) end)
                    end
                    -- give reward items
                    for i = 1, #july4thRewardItems do
                        local item = july4thRewardItems[i]
                        item.coords = GetEntityCoords(GetPlayerPed(src))
                        local newCoords = {
                            x = item.coords.x,
                            y = item.coords.y,
                            z = item.coords.z
                        }
                        newCoords.x = newCoords.x + (math.random() * 0.5)
                        newCoords.y = newCoords.y + (math.random() * 0.5)
                        newCoords.z = newCoords.z - 0.85
                        item.coords = newCoords
                        TriggerEvent("interaction:addDroppedItem", item)
                    end
                else
                    TriggerClientEvent("usa:notify", src, "Already claimed 4th of july reward!")            
                end
            end)
        else
            -- give reward items
            for i = 1, #july4thRewardItems do
                local item = july4thRewardItems[i]
                item.coords = GetEntityCoords(GetPlayerPed(src))
                local newCoords = {
                    x = item.coords.x,
                    y = item.coords.y,
                    z = item.coords.z
                }
                newCoords.x = newCoords.x + (math.random() * 0.5)
                newCoords.y = newCoords.y + (math.random() * 0.5)
                newCoords.z = newCoords.z - 0.85
                item.coords = newCoords
                TriggerEvent("interaction:addDroppedItem", item)
            end
        end
    elseif args[2] and args[2] == "xmas2023" then
        local currentDate = os.date("*t")
        if currentDate.month ~= 12 or currentDate.year ~= 2023 then
            TriggerClientEvent("usa:notify", src, "Reward has expired")
            return
        end
        local user = exports.essentialmode:getPlayerFromId(src)
        local doc = exports.essentialmode:getDocument("xmas-2023-rewards", user.getIdentifier())
        if doc then
            TriggerClientEvent("usa:notify", src, "Already claimed xmas 2023 reward!")            
            return
        end
        local ok = exports.essentialmode:createDocumentWithId("xmas-2023-rewards", user.getIdentifier(), { claimed = true, claimTime = os.time() })
        if ok then
            TriggerClientEvent("usa:notify", src, "Claimed Xmas 2023 Reward!", "^3INFO: ^0Claimed Christmas 2023 Present + $10k in the bank!")
            char.giveItem(exports.usa_rp2:getItem("Christmas Present"), 1)
            char.giveBank(10000, "Christmas Present")
        else
            TriggerClientEvent("usa:notify", src, "Something went wrong")    
        end
    else
        TriggerClientEvent("usa:notify", src, "Invalid reward code")
    end
end, {
    help = "Claim a reward",
    params = {
        { name = "rewardCode", help = "The reward code to claim" },
    }
})

exports["globals"]:PerformDBCheck("usa_utils", "tebex-transaction-ids", nil)
exports["globals"]:PerformDBCheck("usa_utils", "july-4th-rewards", nil)
exports["globals"]:PerformDBCheck("usa_utils", "xmas-2023-rewards", nil)