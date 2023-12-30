RegisterServerCallback {
    eventName = "pawnShop:getItemsToSell",
    eventCallback = function(src)
        local char = exports["usa-characters"]:GetCharacter(src)
        local inv = char.get("inventory")
        local ret = {}
        for index, itemInfo in pairs(inv.items) do
            if (itemInfo.type and itemInfo.type ~= "license") or not itemInfo.type then
                if acceptableItem(itemInfo) then
                    table.insert(ret, {
                        name = itemInfo.name,
                        quantity = itemInfo.quantity,
                        uuid = itemInfo.uuid,
                        sellPrice = getSellPrice(itemInfo)
                    })
                end
            end
        end
        return ret
    end
}

RegisterServerEvent("pawnShop:sell", function(itemId, quantity)
    print("trying to sell item with id: " .. itemId .. ", quantity: " .. quantity)
    local char = exports["usa-characters"]:GetCharacter(source)
    local item = char.getItemByUUID(itemId)
    if not item then
        return
    end
    if not acceptableItem(item) then
        TriggerClientEvent("usa:notify", source, "We don't buy that")
        return
    end
    if quantity > item.quantity then
        TriggerClientEvent("usa:notify", source, "Invalid quantity")
        return
    end
    local sellPrice = getSellPrice(item) * quantity
    char.removeItemByUUID(itemId, quantity)
    char.giveBank(sellPrice)
    TriggerClientEvent("usa:notify", source, "Sold " .. quantity .. " for: $" .. exports.globals:comma_value(sellPrice), "Sold " .. quantity .. " " .. item.name .. "(s) for: $" .. exports.globals:comma_value(sellPrice))
end)


function getSellPrice(itemInfo)
    if itemInfo.name == "Stolen Goods" then
        return math.random(700, 2000)
    else
        return ((itemInfo.price and math.floor(itemInfo.price / 1.65)) or 250)
    end
end

function acceptableItem(item)
    if item.name:find("Key") then
        return false
    elseif item.name:find("nail") then
        return false
    elseif item.name:find("planks") then 
        return false
    elseif item.name:find("lift") or item.name:find("lift_rail") then
        return false
    elseif item.name:find("garden_pitcher") or item.name:find("leafblower") then
        return false
    elseif item.type then
        if item.type == "license" then
            return false
        elseif item.type == "food" or item.type == "drink" then
            return false
        elseif item.type == "ammo" then
            return false
        else
            return true
        end
    else
        return true
    end
end