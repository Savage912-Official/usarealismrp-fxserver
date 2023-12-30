function RegisterUsableItem(...)
    exports["interaction-menu"]:registerUsableItem(...)
end

function ShowNotification(target, text)
	TriggerClientEvent(GetCurrentResourceName()..":showNotification", target, text)
end

function Search(source, name)
    local char = exports["usa-characters"]:GetCharacter(source)
    if name == "money" then
        return char.get("bank")
    elseif name == "bank" then
        return char.get("bank")
    else
        local item = char.getItem(name)
        if item then
            return item.quantity
        else
            return 0
        end
    end
end

function AddItem(source, name, amount)
    local char = exports["usa-characters"]:GetCharacter(source)
    if name == "money" then
        char.giveBank(amount)
        amount = amount + math.random(0, 400)
        TriggerClientEvent("usa:notify", source, "Earned: $" .. exports.globals:comma_value(amount), "^3INFO: ^0Earned: $" .. exports.globals:comma_value(amount))
        return true
    elseif name == "bank" then
        char.giveBank(amount)
        return true
    else
        local item = {
            name = name,
            quantity = amount,
            type = "landscaping"
        }
        char.giveItem(item)
        return true
    end
end

function RemoveItem(source, name, amount)
    local char = exports["usa-characters"]:GetCharacter(source)
    if name == "money" then
        char.removeBank(amount)
        return true
    elseif name == "bank" then
        char.removeBank(amount)
        return true
    else
        char.removeItem(name, amount)
        return true
    end
end  

function CanAccessGroup(source, data)
    --[[
    if not data then return true end
    local pdata = QBCore.Functions.GetPlayer(source).PlayerData
    for k,v in pairs(data) do 
        if (pdata.job.name == k and pdata.job.grade.level >= v) then return true end
    end
    return false
    --]]
    return true
end 

function GetIdentifier(source)
    local char = exports["usa-characters"]:GetCharacter(source)
    return char.get("_id")
end