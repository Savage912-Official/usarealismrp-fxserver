local Lifts = {}

function UpdateLift(id, target)
    TriggerClientEvent("pickle_construction:updateLift", target or -1, id or Lifts, id and Lifts[id] or nil)
end

function GetNetworkEntity(netId)
    return NetworkGetEntityFromNetworkId(netId)
end

function RemoveEntity(netId)
    local entity = GetNetworkEntity(netId)
    if not DoesEntityExist(entity) then return end
    DeleteEntity(entity)
end

function PropFix(props, heading)
    local lift = GetNetworkEntity(props.lift)
    local base = GetNetworkEntity(props.base)
    SetEntityHeading(lift, heading)
    SetEntityHeading(base, heading - 90.01)
    for i=1, #props.rails do 
        local rail = GetNetworkEntity(props.rails[i])
        SetEntityHeading(rail, heading - 90.01)
    end
end

function CanPlayerLift(source, id, spawnData, startLift)
    if not GetDuty(source) then return false, _L("workplace_not_duty") end
    if spawnData then 
        local count = Search(source, "lift")
        local railCount = Search(source, "lift_rail")
        if count < 1 then return false, _L("lift_missing") end
        if spawnData.railHeight < 1 or railCount < spawnData.railHeight then return false, _L("lift_rail_missing", spawnData.railHeight - railCount) end
        if startLift then 
            RemoveItem(source, "lift", 1)
            RemoveItem(source, "lift_rail", spawnData.railHeight)
        end
    else
        if not Lifts[id] then return false end
        if startLift then 
            AddItem(source, "lift", 1)
            AddItem(source, "lift_rail", Lifts[id].railHeight)
        end
    end
    return true
end

RegisterNetEvent("pickle_construction:moveLift", function(id, direction, toggle, height)
    Lifts[id].moving = toggle 
    Lifts[id].direction = (toggle and direction or nil)
    Lifts[id].currentHeight = height - 2.75
    UpdateLift(id)
    
    TriggerClientEvent("pickle_construction:moveLift", -1, id, direction, toggle, height)
end)

RegisterNetEvent("pickle_construction:spawnLift", function(coords, heading, railHeight)
    local success, msg = CanPlayerLift(source, nil, {railHeight = railHeight}, true)
    if not success then return ShowNotification(source, msg) end
    local lift = {
        coords = coords,
        heading = heading,
        railHeight = railHeight,
        currentHeight = coords.z,
        moving = nil,
        direction = nil,
        controller = nil,
    }
    
    local id = nil

    repeat
        id = os.time() .. "_" .. math.random(1000, 9999)
    until not Lifts[id] 

    Lifts[id] = lift
    UpdateLift(id)

    local char = exports["usa-characters"]:GetCharacter(source)
    char.removeItem("lift")
end)

RegisterNetEvent("pickle_construction:removeLift", function(id)
    local source = source
    local success, msg = CanPlayerLift(source, id, nil, true)
    if not success then return ShowNotification(source, msg) end 
    Lifts[id] = nil
    UpdateLift(id)
    SetTimeout(1000, function()
        TriggerClientEvent("pickle_construction:removeLift", -1, id)
    end)
end)

RegisterServerCallback {
    eventName = "pickle_construction:canRemoveLift",
    eventCallback = function(src, id)
        return CanPlayerLift(src, id)
    end
}

RegisterUsableItem("lift", function(source)
    if not GetDuty(source) then return false, ShowNotification(source, _L("workplace_not_duty")) end
    TriggerClientEvent("pickle_construction:createLift", source)
end)

-- todo: fix how lift is not removed from inventory when placed