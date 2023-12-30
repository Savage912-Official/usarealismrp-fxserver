local usableItems = {}

exports("registerUsableItem", function(...)
    local args = {...}
    local itemName = args[1]
    local func = args[2]
    usableItems[itemName] = func
    print("registered action for item: " .. itemName)
end)

RegisterServerEvent("interaction:attemptItemUse")
AddEventHandler("interaction:attemptItemUse", function(itemObj)
    print("attempting item use for: " .. json.encode(itemObj))
    print("usableItems[name] type: " .. type(usableItems[itemObj.name]))
    if usableItems[itemObj.name] then
        usableItems[itemObj.name](source)
    else
        TriggerClientEvent("usa:notify", source, "There is no use action for that item!")
    end
end)