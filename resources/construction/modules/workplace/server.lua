local Workers = {}

function GetDuty(source)
    return Workers[source]
end

function UpdateWorker(id, target)
    TriggerClientEvent("pickle_construction:updateWorker", target or -1, id or Workers, id and Workers[id] or nil)
end

RegisterNetEvent("pickle_construction:toggleDuty", function(bool)
    local cfg = Config.Workplace
    if not CanAccessGroup(source, cfg.duty.groups) then return ShowNotification(source, _L("workplace_no_access")) end
    Workers[source] = (bool and bool or not Workers[source])
    UpdateWorker(source)
    ShowNotification(source, _L("workplace_duty_toggle", string.lower(Workers[source] and _L("duty_on") or _L("duty_off"))))
end)

RegisterNetEvent("pickle_construction:storePurchase", function(index, amount)
    if not GetDuty(source) then return false, ShowNotification(source, _L("workplace_not_duty")) end
    if amount < 1 then return end
    local item = Config.Workplace.store.items[index]
    item.name = item.item
    local price = item.price * amount
    local money = Search(source, "money")
    if money < price then return false, ShowNotification(source, _L("store_cant_afford", _L("price", price - money))) end
    local char = exports["usa-characters"]:GetCharacter(source)
    if not char.canHoldItem(item, amount) then
        TriggerClientEvent("usa:notify", source, "Inventory full!", "^3INFO: ^0Inventory full! Unable to purchase item.")
        return false
    end
    RemoveItem(source, "money", price)
    AddItem(source, item.item, amount)
    ShowNotification(source, _L("store_purchased", item.label, _L("price", price)))
end)

RegisterServerCallback {
    eventName = "pickle_construction:purchaseVehicle",
    eventCallback = function(src, index)
        local vehicle = Config.Workplace.garage.vehicles[index]
        local price = vehicle.price
        local money = Search(source, "money")
        if money < price then return false, ShowNotification(source, _L("store_cant_afford", _L("price", price - money))) end 
        RemoveItem(source, "money", price)
        ShowNotification(source, _L("store_purchased", vehicle.label, _L("price", price)))
        return true
    end
}

RegisterNetEvent("pickle_construction:initializePlayer", function(bool)
    local source = source
    UpdateWorker(nil, source)
    UpdateLift(nil, source)
    UpdateSite(nil, source)
end)