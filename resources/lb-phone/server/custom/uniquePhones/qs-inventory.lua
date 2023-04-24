CreateThread(function()
    if Config.Item.Inventory ~= "qs-inventory" or not Config.Item.Unique or not Config.Item.Require then
        return
    end

    local QS, QB
    if Config.Framework == "esx" then
        TriggerEvent("qs-core:getSharedObject", function(library)
            QS = library
        end)
    elseif Config.Framework == "qb" then
        QB = exports["qb-core"]:GetCoreObject()
    end

    local function GetItemsByName(source, name)
        if Config.Framework == "esx" then
            local inventory = QS.GetPlayerFromId(source).PlayerData.items
            local items = {}
            for _, item in pairs(inventory) do
                if item?.name == name then
                    items[#items+1] = item
                end
            end
            return items
        elseif Config.Framework == "qb" then
            local inventory = QB.Functions.GetPlayer(source).PlayerData.items
            local items = {}
            for _, item in pairs(inventory) do
                if item?.name == name then
                    items[#items+1] = item
                end
            end
            return items
        end
    end

    function HasPhoneNumber(source, phoneNumber)
        debugprint("checking if " .. source .. " has a phone item with number", phoneNumber)
        local phones = GetItemsByName(source, Config.Item.Name)
        for i = 1, #phones do
            local phone = phones[i]
            if phone?.info?.lbPhoneNumber == phoneNumber then
                debugprint("they do")
                return true
            end
        end
        debugprint("they do not")
        return false
    end

    function SetPhoneNumber(source, phoneNumber)
        if Config.Framework == "esx" then
            local qPlayer = QS.GetPlayerFromId(source)
            local items = qPlayer.PlayerData.items
            for i = 1, #items do
                local item = items[i]
                if item and item.name == Config.Item.Name and item.info.lbPhoneNumber == nil then
                    item.info.lbPhoneNumber = phoneNumber
                    item.info.lbFormattedNumber = FormatNumber(phoneNumber)
                    qPlayer.SetInventory(items, true)
                    return true
                end
            end
            return false
        elseif Config.Framework == "qb" then
            local qPlayer = QB.Functions.GetPlayer(source)
            local items = qPlayer.PlayerData.items
            for i = 1, #items do
                local item = items[i]
                if item and item.name == Config.Item.Name and item.info.lbPhoneNumber == nil then
                    item.info.lbPhoneNumber = phoneNumber
                    item.info.lbFormattedNumber = FormatNumber(phoneNumber)
                    qPlayer.Functions.SetInventory(items, true)
                    return true
                end
            end
            return false
        end
    end

    function SetItemName(source, phoneNumber, name)
        if Config.Framework == "esx" then
            local qPlayer = QS.GetPlayerFromId(source)
            local items = qPlayer.PlayerData.items
            for i = 1, #items do
                local item = items[i]
                if item and item.name == Config.Item.Name and item.info.lbPhoneNumber == phoneNumber then
                    item.info.lbPhoneName = name
                    item.info.lbFormattedNumber = FormatNumber(phoneNumber)
                    qPlayer.SetInventory(items, true)
                    return true
                end
            end
        elseif Config.Framework == "qb" then
            local qPlayer = QB.Functions.GetPlayer(source)
            local items = qPlayer.PlayerData.items
            for i = 1, #items do
                local item = items[i]
                if item and item.name == Config.Item.Name and item.info.lbPhoneNumber == phoneNumber then
                    item.info.lbPhoneName = name
                    item.info.lbFormattedNumber = FormatNumber(phoneNumber)
                    qPlayer.Functions.SetInventory(items, true)
                    return true
                end
            end
        end
    end

    if Config.Framework == "esx" then
        QS.RegisterUsableItem(Config.Item.Name, function(source, item)
            if item then
                TriggerClientEvent("lb-phone:usePhoneItem", source, item)
            end
        end) 
    elseif Config.Framework == "qb" then
        QB.Functions.CreateUseableItem(Config.Item.Name, function(source, item)
            if item then
                TriggerClientEvent("lb-phone:usePhoneItem", source, item)
            end
        end)
    end
end)
