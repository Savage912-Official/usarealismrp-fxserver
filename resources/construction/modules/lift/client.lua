local Lifts = {}
local LocalLifts = {}
local ControllingLift = false

function GetLift(index)
    if LocalLifts[index] and DoesEntityExist(LocalLifts[index].lift) then
        return LocalLifts[index]
    elseif LocalLifts[index] then
        return DeleteLift(index)
    end
end

function DeleteLift(index)
    if not LocalLifts[index] then return end
    local lift = LocalLifts[index]

    if DoesEntityExist(lift.lift) then 
        DeleteEntity(lift.lift)
    end

    if DoesEntityExist(lift.base) then 
        DeleteEntity(lift.base)
    end

    for i=1, #lift.rails do 
        if DoesEntityExist(lift.rails[i]) then 
            DeleteEntity(lift.rails[i])
        end
    end
end

function EnsureLift(index)
    local lift = GetLift(index)
    if lift then return lift end

    local lift = {}

    local data = Lifts[index]
    local coords = data.coords
    local heading = data.heading
    local railHeight = data.railHeight

    local prop = CreateProp(`prop_conslift_lift`, coords.x, coords.y, data.currentHeight, false, true)
    SetEntityHeading(prop, heading)
    FreezeEntityPosition(prop, true)
    lift.lift = prop

    local prop = CreateProp(`prop_conslift_base`, coords.x, coords.y, coords.z, false, true)
    SetEntityHeading(prop, heading - 90.0)
    FreezeEntityPosition(prop, true)
    lift.base = prop

    lift.rails = {}
    for i=1, railHeight do 
        local prop = CreateProp(`prop_conslift_rail`, coords.x, coords.y, coords.z + (i * 5.0), false, true)
        SetEntityHeading(prop, heading - 90.0)
        FreezeEntityPosition(prop, true)
        table.insert(lift.rails, prop)
    end
    LocalLifts[index] = lift
    return lift
end

function ControlLift(index)
    if ControllingLift then return end
    ControllingLift = true
    CreateThread(function()
        lib.showTextUI(_L("lift_controls"))
        local offset = 1.0
        while ControllingLift do
            local lift = GetLift(index)
            if not lift or #(GetOffsetFromEntityInWorldCoords(lift.lift, 0.0, -3.0, -2.0) - GetEntityCoords(PlayerPedId())) > 1.3 then break end
            if IsControlJustPressed(1, 172) then 
                TriggerServerEvent("pickle_construction:moveLift", index, "up", true, GetEntityCoords(lift.lift).z)
            elseif IsControlJustReleased(1, 172) then 
                TriggerServerEvent("pickle_construction:moveLift", index, "up", false, GetEntityCoords(lift.lift).z)
            end
            if IsControlJustPressed(1, 173) then 
                TriggerServerEvent("pickle_construction:moveLift", index, "down", true, GetEntityCoords(lift.lift).z)
            elseif IsControlJustReleased(1, 173) then 
                TriggerServerEvent("pickle_construction:moveLift", index, "down", false, GetEntityCoords(lift.lift).z)
            end 
            Wait(0)
        end
        ControllingLift = false
        lib.hideTextUI()
        local lift = GetLift(index)
        if not lift then return end
        TriggerServerEvent("pickle_construction:moveLift", index, "down", false, GetEntityCoords(lift.lift).z)
    end)
end

function RemoveLift(index)
    local pass = TriggerServerCallback {
        eventName = "pickle_construction:canRemoveLift",
        args = {index}
    }
    if not pass then return ShowNotification("Unable to remove lift") end
    local success = Config.Lift.remove()
    if not success then return end
    TriggerServerEvent("pickle_construction:removeLift", index)
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local wait = 1500
        for k,v in pairs(Lifts) do 
            local dist = #(v2(v.coords) - v2(coords))
            if (dist < Config.RenderDistance) then 
                wait = 0
                local lift = EnsureLift(k)
                local location = GetOffsetFromEntityInWorldCoords(lift.lift, 0.0, -3.0, -2.0)
                local dist = #(location - coords)
                if dist < 1.3 then 
                    ControlLift(k)
                end
                local location = GetOffsetFromEntityInWorldCoords(lift.base, -1.2, 0.0, 1.0)
                local dist = #(location - coords)
                if dist < 1.3 and not ShowInteractText(_L("lift_remove")) and IsControlJustPressed(1, 51) then 
                    RemoveLift(k)
                end
            elseif (GetLift(k)) then
                DeleteLift(k)
            end
        end 
        Wait(wait)
    end
end)

RegisterNetEvent("pickle_construction:moveLift", function(id, direction, toggle, height)
    local lift = GetLift(id)
    local data = Lifts[id]
    if not lift or not data then return end

    local coords = data.coords
    local minHeight = (coords.z + 3.0)
    local maxHeight = minHeight + (5.0 * #lift.rails)
    local speed = 0.015
    local prop = lift.lift

    SetEntityCoords(prop, coords.x, coords.y, height)
    
    if not toggle then return end
    CreateThread(function()
        while true do 
            local data = Lifts[id]
            if data.direction == direction or data.moving == toggle then break end
            Wait(0)
        end
        while true do 
            local lift = GetLift(id)
            local data = Lifts[id]
            if not lift or not data then break end
            if data.direction ~= direction or data.moving ~= toggle then break end
            if direction == "up" then 
                SlideObject(prop, coords.x, coords.y, maxHeight, speed, speed, speed, true)
            elseif direction == "down" then 
                SlideObject(prop, coords.x, coords.y, minHeight, speed, speed, speed, true)
            end
            Wait(0)
        end
    end)
end)

RegisterNetEvent("pickle_construction:removeLift", function(id) 
    DeleteLift(id)
end)

RegisterNetEvent("pickle_construction:createLift", function() 
    local input = lib.inputDialog(_L("lift_menu_title"), {_L("lift_menu_rails")})
    if not input or not tonumber(input[1]) then return end
    local success = Config.Lift.spawn()
    if not success then return end
    local ped = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.5, -1.3)
    TriggerServerEvent("pickle_construction:spawnLift", coords, GetEntityHeading(ped) - 180.0, tonumber(input[1]))
end)

RegisterNetEvent("pickle_construction:updateLift", function(id, data)
    if type(id) == "table" then 
        Lifts = id
    else
        Lifts[id] = data
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for k,v in pairs(LocalLifts) do 
        DeleteLift(k)
    end
end)