local Workers = {}
local menuOpen = false

function GetDuty(source)
    return Workers[source or GetPlayerServerId(PlayerId())]
end

function ToggleDuty(bool)
    TriggerServerEvent("pickle_construction:toggleDuty", bool)
end

function OpenStoreMenu()
    if not GetDuty() then return ShowNotification(_L("workplace_not_duty")) end
    local _options = {}
    for i=1, #Config.Workplace.store.items do
        table.insert(_options, {label = Config.Workplace.store.items[i].label, description = _L("price", Config.Workplace.store.items[i].price)})
    end
    if #_options < 1 then return end
    menuOpen = true
    lib.registerMenu({
        id = "pickle_construction:store",
        title = _L("store_menu_title"),
        position = "top-right",
        onClose = function(keyPressed)
            menuOpen = false
        end,
        options = _options
    }, function(selected, scrollIndex, args)
        local input = lib.inputDialog(_L("store_menu_input_title", Config.Workplace.store.items[selected].label, _L("price", Config.Workplace.store.items[selected].price)), {_L("store_menu_input_quantity")})
        if not input or not tonumber(input[1]) then return ShowNotification(_L("store_menu_input_invalid")) end
        TriggerServerEvent("pickle_construction:storePurchase", selected, tonumber(input[1]))
        menuOpen = false
    end)
    
    lib.showMenu("pickle_construction:store")
end

function OpenGarageMenu()
    if not GetDuty() then return ShowNotification(_L("workplace_not_duty")) end
    local _options = {}
    for i=1, #Config.Workplace.garage.vehicles do
        table.insert(_options, {label = Config.Workplace.garage.vehicles[i].label, description = _L("price", Config.Workplace.garage.vehicles[i].price)})
    end
    if #_options < 1 then return end
    menuOpen = true
    lib.registerMenu({
        id = "pickle_construction:garage",
        title = _L("garage_menu_title"),
        position = "top-right",
        onClose = function(keyPressed)
            menuOpen = false
        end,
        options = _options
    }, function(selected, scrollIndex, args)
        local model = Config.Workplace.garage.vehicles[selected].model
        local coords, heading = Config.Workplace.garage.location, Config.Workplace.garage.heading
        local result = TriggerServerCallback {
            eventName = "pickle_construction:purchaseVehicle",
            args = {selected}
        }
        if not result then return end
        local vehicle = CreateVeh(model, coords.x, coords.y, coords.z, heading, true, false)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        menuOpen = false
        -- give key to owner
        local vehicle_key = {
            name = "Key -- " .. GetVehicleNumberPlateText(vehicle),
            quantity = 1,
            type = "key",
            owner = "constructionCompany",
            make = "construction",
            model = "veh",
            plate = GetVehicleNumberPlateText(vehicle)
        }
        TriggerServerEvent("garage:giveKey", vehicle_key)
    end)
    
    lib.showMenu("pickle_construction:garage")
end

CreateThread(function()
    TriggerServerEvent("pickle_construction:initializePlayer")
    local blip = Config.Workplace.duty.blip
    if blip then 
        CreateBlip({
            Label = blip.Label,
            ID = blip.ID,
            Location = Config.Workplace.duty.location,
            Scale = blip.Scale,
            Color = blip.Color,
            Display = blip.Display,
        })
    end
    local blip = Config.Workplace.store.blip
    if blip then 
        CreateBlip({
            Label = blip.Label,
            ID = blip.ID,
            Location = Config.Workplace.store.location,
            Scale = blip.Scale,
            Color = blip.Color,
            Display = blip.Display,
        })
    end
    local blip = Config.Workplace.garage.blip
    if blip then 
        CreateBlip({
            Label = blip.Label,
            ID = blip.ID,
            Location = Config.Workplace.garage.location,
            Scale = blip.Scale,
            Color = blip.Color,
            Display = blip.Display,
        })
    end
    while true do
        local wait = 1500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local cfg = Config.Workplace
        local location = cfg.duty.location
        local dist = #(location - coords)
        if dist < 30.0 then 
            wait = 0
        end
        DrawMarker(0, location.x, location.y, location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.35, 0.35, 0.35, 255, 172, 28, 127, false, false)
        if dist < 1.0 and not ShowInteractText(_L("workplace_duty", GetDuty() and _L("duty_off") or _L("duty_on"))) and IsControlJustPressed(1, 51) then
            ToggleDuty()
        end
        local location = cfg.store.location
        local dist = #(location - coords)
        if dist < 30.0 then 
            wait = 0
        end
        DrawMarker(0, location.x, location.y, location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.35, 0.35, 0.35, 255, 172, 28, 127, false, false)
        if dist < 1.0 and not ShowInteractText(_L("workplace_store")) and IsControlJustPressed(1, 51) then
            OpenStoreMenu()
        end
        local location = cfg.garage.location
        local dist = #(location - coords)
        if dist < 30.0 then 
            wait = 0
        end
        DrawMarker(0, location.x, location.y, location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.35, 0.35, 0.35, 255, 172, 28, 127, false, false)
        if dist < 1.0 and not ShowInteractText(_L(GetVehiclePedIsIn(PlayerPedId()) == 0 and "workplace_garage" or "workplace_garage_return")) and IsControlJustPressed(1, 51) then
            if GetVehiclePedIsIn(PlayerPedId()) == 0 then 
                OpenGarageMenu()
            else
                DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
                ShowNotification(_L("workplace_garage_returned"))
            end
        end
        Wait(wait)
    end
end)

RegisterNetEvent("pickle_construction:updateWorker", function(id, data)
    if type(id) == "table" then 
        Workers = id
    else
        Workers[id] = data
        if id == GetPlayerServerId(PlayerId()) then 
            ToggleDutyEvent(data)
        end
    end
end)