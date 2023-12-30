--# Residential / Business Properties
--# own, store stuff, be a bawse
--# by: minipunch
--# made for: USA REALISM RP

local ALL_PROPERTIES = {}
local NEARBY_PROPERTIES = {}

local my_property_identifier = nil -- gets updated by the server on first load, this is the hex steam ID of the player

local nearest_property_info = nil

local MENU_KEY = 38

local menu_data = {
    user_items = nil,
    property_items = nil,
    wardrobe = nil,
    vehicles = nil,
    money = nil,
    coowners = nil
}

local _menuPool = nil

local closest_coords = {
	x = nil,
	y = nil,
	z = nil
}

local VEHICLE_DAMAGES = {}

local waitingForWardrobeToLoad = false

local currentMapBlips = {} -- used to mark owned properties as blips on map on character load

local PROPERTY_NAME_MAX_LENGTH = 35

local NEARBY_PROPERTY_INTERVAL_CHECK_MS = 5000

TriggerServerEvent("properties:loadForClient")

RegisterNetEvent("properties:setPropertyBlips")
AddEventHandler("properties:setPropertyBlips", function(propertyLocations)
    RemoveBlips()
    AddBlips(propertyLocations)
end)

RegisterNetEvent("properties:setPropertyIdentifier")
AddEventHandler("properties:setPropertyIdentifier", function(ident)
    my_property_identifier = ident
end)

RegisterNetEvent("properties:setPropertiesForClient")
AddEventHandler("properties:setPropertiesForClient", function(properties)
    ALL_PROPERTIES = properties
end)

RegisterNetEvent("properties:update")
AddEventHandler("properties:update", function(property)
    ALL_PROPERTIES[property.name] = property
end)

RegisterNetEvent("properties:remove")
AddEventHandler("properties:remove", function(name)
    ALL_PROPERTIES[name] = nil
end)

RegisterNetEvent("properties:loadWardrobe")
AddEventHandler("properties:loadWardrobe", function(wardrobe)
    menu_data.wardrobe = wardrobe
    waitingForWardrobeToLoad = false
end)

-- list items to store --
RegisterNetEvent("properties:setItemsToStore")
AddEventHandler("properties:setItemsToStore", function(items)
    menu_data.user_items = items
end)

-- list items to retrieve --
RegisterNetEvent("properties:loadedStorage")
AddEventHandler("properties:loadedStorage", function(items)
    menu_data.property_items = items
end)
--

-- money from property --
RegisterNetEvent("properties:loadMoneyForMenu")
AddEventHandler("properties:loadMoneyForMenu", function(money)
    menu_data.money = money
end)

-- vehicles from property --
RegisterNetEvent("properties:loadVehiclesForMenu")
AddEventHandler("properties:loadVehiclesForMenu", function(vehicles)
    menu_data.vehicles = vehicles
end)

-- getting co owners --
RegisterNetEvent("properties:getCoOwners")
AddEventHandler("properties:getCoOwners", function(coowners)
    menu_data.coowners = coowners
end)

-- storing vehicle --
RegisterNetEvent("properties:storeVehicle")
AddEventHandler("properties:storeVehicle", function()
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
    local underglowEnabled = isUnderglowOn(veh)
	local underglowR, underglowG, underglowB = GetVehicleNeonLightsColour(veh)
    local plate = GetVehicleNumberPlateText(veh)
    plate = exports.globals:trim(plate)
    TriggerEvent("usa:notify", "~g~Vehicle stored!")
    -- store engine / body damage --
    VEHICLE_DAMAGES[plate] = {
        engine_health = GetVehicleEngineHealth(veh),
        body_health = GetVehicleBodyHealth(veh),
		dirt_level = GetVehicleDirtLevel(veh),
		windows = {
			[0] = IsVehicleWindowIntact(veh, 0),
			[1] = IsVehicleWindowIntact(veh, 1),
			[2] = IsVehicleWindowIntact(veh, 2),
			[3] = IsVehicleWindowIntact(veh, 3)
		}
    }
    -- delete veh --
    SetEntityAsMissionEntity(veh, true, true)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
    -- save fuel
    TriggerServerEvent("fuel:save", plate)
    -- save underglow
    if underglowEnabled then
        -- save underglow color (cause it can be changed with the RGB controller)
        TriggerServerEvent("mechanic:saveUnderglow", plate, underglowR, underglowG, underglowB)
    end

end)

-- retrieving vehicle --
RegisterNetEvent("properties:retrieveVehicle")
AddEventHandler("properties:retrieveVehicle", function(vehicle)
  local playerVehicle = vehicle
  local modelHash = vehicle.hash
  local plateText = vehicle.plate

  if type(modelHash) ~= "number" then
    modelHash = GetHashKey(modelHash)
  end

  Citizen.CreateThread(function()

    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
      Citizen.Wait(100)
    end

    local playerPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerPed, false)
    local heading = GetEntityHeading(playerPed)
    local vehicle = CreateVehicle(modelHash, playerCoords.x, playerCoords.y, playerCoords.z, heading, true, false)
    SetVehicleNumberPlateText(vehicle, plateText)
    SetVehicleOnGroundProperly(vehicle)
    SetVehRadioStation(vehicle, "OFF")
    SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
    SetVehicleEngineOn(vehicle, true, false, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleExplodesOnHighExplosionDamage(vehicle, false)

    -- Vehicle Wheel Fitment
	exports['ae-fitment']:GetWheelFitment(vehicle, playerVehicle.plate)

    -- car customizations
    if playerVehicle.customizations then
        TriggerEvent("customs:applyCustomizations", playerVehicle.customizations)
    end

    -- veh fuel level
    if playerVehicle.stats then
        if playerVehicle.stats.fuel then
            TriggerServerEvent("fuel:setFuelAmount", playerVehicle.plate, playerVehicle.stats.fuel)
        end
    end

    -- any mechanic-installed upgrades
    if playerVehicle.upgrades then
        exports["usa_mechanicjob"]:ApplyUpgrades(vehicle, playerVehicle.upgrades)
    end

    -- apply any stored engine / body damage --
    if VEHICLE_DAMAGES[playerVehicle.plate] then
      SetVehicleBodyHealth(vehicle, VEHICLE_DAMAGES[playerVehicle.plate].body_health)
      SetVehicleEngineHealth(vehicle, VEHICLE_DAMAGES[playerVehicle.plate].engine_health)
      SetVehicleDirtLevel(vehicle, VEHICLE_DAMAGES[playerVehicle.plate].dirt_level)
      for index, intact in pairs(VEHICLE_DAMAGES[playerVehicle.plate].windows) do
        if not intact then
          SmashVehicleWindow(vehicle, index)
        end
      end
    end

    -- give key to owner --
    local vehicle_key = {
      name = "Key -- " .. playerVehicle.plate,
      quantity = 1,
      type = "key",
      owner = playerVehicle.owner,
      make = playerVehicle.make,
      model = playerVehicle.model,
      plate = playerVehicle.plate
    }

    -- give key to owner
    TriggerServerEvent("garage:giveKey", vehicle_key)

  end)

end)

---------------------------------------------
-- get closest property from given (usually player) coords  --
---------------------------------------------
RegisterNetEvent("properties:getPropertyGivenCoords")
AddEventHandler("properties:getPropertyGivenCoords", function(x,y,z, cb)
    local closest = 1000000000000.0
    local closest_property = nil
    for name, info in pairs(NEARBY_PROPERTIES) do
        if Vdist(x, y, z, info.x, info.y, info.z)  < 50.0 and Vdist(x, y, z, info.x, info.y, info.z) < closest then
            closest = Vdist(x, y, z, info.x, info.y, info.z)
            closest_property = info
        end
    end
    if closest_property then
        cb(closest_property)
    else
        cb(nil)
    end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent("properties:startAddDoor")
AddEventHandler("properties:startAddDoor", function()
    local closestDist = 1000000000.0
    local closestDoor = nil
    for object in exports["globals"]:EnumerateObjects() do
        local dist = #(GetEntityCoords(object) - GetEntityCoords(PlayerPedId()))
        if dist < 2.5 and dist < closestDist then
            closestDist = dist
            closestDoor = object 
        end
    end
    if closestDoor ~= nil then
        SetEntityDrawOutline(closestDoor, true)
        local confirmed = false
        local canceled = false
        local before = GetGameTimer()
        local lockedOffset = {x = 0.0, y = 0.0, z = 0.0}
        local doorCoords = GetEntityCoords(closestDoor)
        while not confirmed and not canceled and (GetGameTimer() - before) < 30000 do
            Citizen.Wait(0)
            alert("~b~Add Door? ~INPUT_MP_TEXT_CHAT_TEAM~ ~INPUT_REPLAY_ENDPOINT~\n~b~Move text with arrow keys")
            -- local angle = math.rad(180+GetEntityHeading(closestDoor))
            -- local x=doorCoords.x+lockedOffset.y*math.cos(angle)
            -- local y=doorCoords.y+lockedOffset.y*math.sin(angle)
            local offset = GetOffsetFromEntityInWorldCoords(closestDoor, lockedOffset.x, lockedOffset.y, lockedOffset.z)
            DrawText3Ds(offset.x, offset.y, offset.z, "[E] - Locked")
            if IsControlJustPressed(0, 246) then
                confirmed = true
            elseif IsControlJustPressed(0, 306) then
                canceled = true
                TriggerEvent("usa:notify", "Adding Door Cancelled!")
            elseif IsControlPressed(0, 187) then -- down
                lockedOffset.z = lockedOffset.z - 0.025
            elseif IsControlPressed(0, 188) then -- up
                lockedOffset.z = lockedOffset.z + 0.025
            elseif IsControlPressed(0, 189) then -- left
                lockedOffset.x = lockedOffset.x - 0.025
            elseif IsControlPressed(0, 190) then -- right
                lockedOffset.x = lockedOffset.x + 0.025
            end
        end
        if not confirmed and not canceled then
            TriggerEvent("usa:notify", "Timed Out")
            canceled = true
        end
        SetEntityDrawOutline(closestDoor, false)
        if not canceled then
            local closestPDist = 1000000000000.0
            local closest_property = ""
            for name, info in pairs(NEARBY_PROPERTIES) do
                local dist = #(GetEntityCoords(PlayerPedId()) - vector3(info.x, info.y, info.z))
                if dist < 50.0 and dist < closestPDist then
                    closestPDist = dist
                    closest_property = info
                end
            end
            local name = nil
            canceled = false
            TriggerEvent("hotkeys:enable", false)
            DisplayOnscreenKeyboard( false, "", "", closest_property.name, "", "", "", PROPERTY_NAME_MAX_LENGTH )
            while true do
                alert("~b~Enter property door is in")
                if ( UpdateOnscreenKeyboard() == 1 ) then
                    local input = GetOnscreenKeyboardResult()
                    if ( string.len( input ) > 0 ) then
                            name = input
                        break
                    else
                        DisplayOnscreenKeyboard( false, "", "", closest_property.name, "", "", "", PROPERTY_NAME_MAX_LENGTH )
                    end
                elseif ( UpdateOnscreenKeyboard() == 2 ) then
                    canceled = true
                    TriggerEvent("usa:notify", "Adding Door Cancelled!")
                    break
                end
                Wait( 0 )
            end
            TriggerEvent("hotkeys:enable", true)

            if not canceled then
                local hash = GetEntityModel(closestDoor)
                local coords = GetEntityCoords(closestDoor)
                local heading = round(GetEntityHeading(closestDoor), 0)
                TriggerServerEvent("properties:AddDoor", name, hash, coords, heading, lockedOffset)
            end
        end
    else
        TriggerEvent("usa:notify", "No object found nearby!")
    end
end)

RegisterNetEvent("properties:startRemDoor")
AddEventHandler("properties:startRemDoor", function()
    local closestDist = 1000000000.0
    local closestDoor = nil
    for object in exports["globals"]:EnumerateObjects() do
        local dist = #(GetEntityCoords(object) - GetEntityCoords(PlayerPedId()))
        if dist < 2.5 and dist < closestDist then
            closestDist = dist
            closestDoor = object 
        end
    end
    if closestDoor ~= nil then
        SetEntityDrawOutline(closestDoor, true)
        local confirmed = false
        local canceled = false
        local before = GetGameTimer()
        while not confirmed and not canceled and (GetGameTimer() - before) < 30000 do
            Citizen.Wait(0)
            alert("~b~Remove Door? ~INPUT_MP_TEXT_CHAT_TEAM~ ~INPUT_REPLAY_ENDPOINT~")
            if IsControlJustPressed(0, 246) then
                confirmed = true
            elseif IsControlJustPressed(0, 306) then
                canceled = true
                TriggerEvent("usa:notify", "Removing Door Cancelled!")
            end
        end
        if not confirmed and not canceled then
            TriggerEvent("usa:notify", "Timed Out")
            canceled = true
        end
        SetEntityDrawOutline(closestDoor, false)
        if not canceled then
            local coords = GetEntityCoords(closestDoor)
            TriggerServerEvent("properties:RemDoor", coords)
        end
    else
        TriggerClientEvent("usa:notify", "No object found nearby!")
    end
end)

RegisterNetEvent("properties:startEditProperty")
AddEventHandler("properties:startEditProperty", function(param)
    local closest = 1000000000000.0
    local closest_property = nil
    for name, info in pairs(NEARBY_PROPERTIES) do
        local dist = #(GetEntityCoords(PlayerPedId()) - vector3(info.x, info.y, info.z))
        if dist < 50.0 and dist < closest then
            closest = dist
            closest_property = info
        end
    end
    if closest_property then
        if param == "door" then
            local prop_coords = nil
            local confirmed = false
            local canceled = false
            local before = GetGameTimer()
            while not confirmed and not canceled and (GetGameTimer() - before) < 60000 do
                Citizen.Wait(0)
                alert("~b~Select Property Location ~INPUT_MP_TEXT_CHAT_TEAM~\n~r~Cancel ~INPUT_REPLAY_ENDPOINT~")
                if IsControlJustPressed(0, 246) then
                    confirmed = true
                    prop_coords = GetEntityCoords(PlayerPedId())
                elseif IsControlJustPressed(0, 306) then
                    canceled = true
                    TriggerEvent("usa:notify", "Stopped Editing Property!")
                end
            end
            if not confirmed and not canceled then
                TriggerEvent("usa:notify", "Timed Out")
                canceled = true
            end
            if not canceled then
                TriggerServerEvent("properties:editProperty", param, prop_coords, closest_property.name)
            end
        elseif param == "garage" then
            local garage_coords = nil
            local confirmed = false
            local canceled = false
            local before = GetGameTimer()
            while not confirmed and not canceled and (GetGameTimer() - before) < 60000 do
                Citizen.Wait(0)
                alert("~b~Select Garage Location Location ~INPUT_MP_TEXT_CHAT_TEAM~\n~r~Cancel ~INPUT_REPLAY_ENDPOINT~")
                if IsControlJustPressed(0, 246) then
                    confirmed = true
                    garage_coords = GetEntityCoords(PlayerPedId())
                elseif IsControlJustPressed(0, 306) then
                    canceled = true
                    TriggerEvent("usa:notify", "Stopped Editing Property!")
                end
            end
            if not confirmed and not canceled then
                TriggerEvent("usa:notify", "Timed Out")
                canceled = true
            end

            if not canceled then
                TriggerServerEvent("properties:editProperty", param, garage_coords, closest_property.name)
            end
        elseif param == "name" then
            local newName = nil
            local canceled = false
            TriggerEvent("hotkeys:enable", false)
            DisplayOnscreenKeyboard( false, "", "", closest_property.name, "", "", "", PROPERTY_NAME_MAX_LENGTH )
            while true do
                alert("~b~Enter New Property Name")
                if ( UpdateOnscreenKeyboard() == 1 ) then
                    local input = GetOnscreenKeyboardResult()
                    if ( string.len( input ) > 0 ) then
                            newName = input
                        break
                    else
                        DisplayOnscreenKeyboard( false, "", "", closest_property.name, "", "", "", PROPERTY_NAME_MAX_LENGTH )
                    end
                elseif ( UpdateOnscreenKeyboard() == 2 ) then
                    canceled = true
                    TriggerEvent("usa:notify", "Stopped Adding Property!")
                    break
                end
                Wait( 0 )
            end
            TriggerEvent("hotkeys:enable", true)

            if not canceled then
                TriggerServerEvent("properties:editProperty", param, newName, closest_property.name)
            end
        elseif param == "price" then
            local newPrice = nil
            local oldPrice = tostring(closest_property.fee.price)
            local canceled = false
            TriggerEvent("hotkeys:enable", false)
            DisplayOnscreenKeyboard( false, "", "", oldPrice, "", "", "", 9 )
            while true do
                alert("~b~Enter Property Price")
                if ( UpdateOnscreenKeyboard() == 1 ) then
                    local input = GetOnscreenKeyboardResult()
                    if ( string.len( input ) > 0 ) then
                        input = tonumber(input)
                        if input == nil then
                            TriggerEvent("usa:notify", "Not a valid price!")
                            DisplayOnscreenKeyboard( false, "", "", oldPrice, "", "", "", 9 )
                        else
                            if input > 0 then
                                newPrice = input
                                break
                            else
                                TriggerEvent("usa:notify", "Price needs to be more than 0!")
                                DisplayOnscreenKeyboard( false, "", "", oldPrice, "", "", "", 9 )
                            end
                        end
                    else
                        DisplayOnscreenKeyboard( false, "", "", oldPrice, "", "", "", 9 )
                    end
                elseif ( UpdateOnscreenKeyboard() == 2 ) then
                    canceled = true
                    TriggerEvent("usa:notify", "Stopped Adding Property!")
                    break
                end
                Wait( 0 )
            end
            TriggerEvent("hotkeys:enable", true)

            if not canceled then
                TriggerServerEvent("properties:editProperty", param, newPrice, closest_property.name)
            end
        end
    else
        TriggerEvent("usa:notify", "No Properties nearby")
    end
end)

RegisterNetEvent("properties:startAddNewProperty")
AddEventHandler("properties:startAddNewProperty", function()
    local prop_coords = nil
    local garage_coords = nil
    local prop_name = nil
    local prop_price = nil

    local confirmed = false
    local canceled = false
    local before = GetGameTimer()
    while not confirmed and not canceled and (GetGameTimer() - before) < 60000 do
        Citizen.Wait(0)
        alert("~b~Select Property Location ~INPUT_MP_TEXT_CHAT_TEAM~\n~r~Cancel ~INPUT_REPLAY_ENDPOINT~")
        if IsControlJustPressed(0, 246) then
            confirmed = true
            prop_coords = GetEntityCoords(PlayerPedId())
        elseif IsControlJustPressed(0, 306) then
            canceled = true
            TriggerEvent("usa:notify", "Stopped Adding Property!")
        end
    end
    if not confirmed and not canceled then
        TriggerEvent("usa:notify", "Timed Out")
        canceled = true
    end

    if not canceled then
        confirmed = false
        canceled = false
        before = GetGameTimer()
        while not confirmed and not canceled and (GetGameTimer() - before) < 60000 do
            Citizen.Wait(0)
            alert("~b~Select Garage Location Location ~INPUT_MP_TEXT_CHAT_TEAM~\n~r~Cancel ~INPUT_REPLAY_ENDPOINT~")
            if IsControlJustPressed(0, 246) then
                confirmed = true
                garage_coords = GetEntityCoords(PlayerPedId())
            elseif IsControlJustPressed(0, 306) then
                canceled = true
                TriggerEvent("usa:notify", "Stopped Adding Property!")
            end
        end
        if not confirmed and not canceled then
            TriggerEvent("usa:notify", "Timed Out")
            canceled = true
        end

        if not canceled then
            canceled = false
            TriggerEvent("hotkeys:enable", false)
            DisplayOnscreenKeyboard( false, "", "", "Name", "", "", "", 20 )
            while true do
                alert("~b~Enter Property Name")
                if ( UpdateOnscreenKeyboard() == 1 ) then
                    local input = GetOnscreenKeyboardResult()
                    if ( string.len( input ) > 0 ) then
                            prop_name = input
                        break
                    else
                        DisplayOnscreenKeyboard( false, "", "", "Name", "", "", "", 20 )
                    end
                elseif ( UpdateOnscreenKeyboard() == 2 ) then
                    canceled = true
                    TriggerEvent("usa:notify", "Stopped Adding Property!")
                    break
                end
                Wait( 0 )
            end
            TriggerEvent("hotkeys:enable", true)

            if not canceled then
                canceled = false
                TriggerEvent("hotkeys:enable", false)
                DisplayOnscreenKeyboard( false, "", "", "Price", "", "", "", 9 )
                while true do
                    alert("~b~Enter Property Price")
                    if ( UpdateOnscreenKeyboard() == 1 ) then
                        local input = GetOnscreenKeyboardResult()
                        if ( string.len( input ) > 0 ) then
                            input = tonumber(input)
                            if input == nil then
                                TriggerEvent("usa:notify", "Not a valid price!")
                                DisplayOnscreenKeyboard( false, "", "", "Price", "", "", "", 9 )
                            else
                                if input > 0 then
                                    prop_price = input
                                    break
                                else
                                    TriggerEvent("usa:notify", "Price needs to be more than 0!")
                                    DisplayOnscreenKeyboard( false, "", "", "Price", "", "", "", 9 )
                                end
                            end
                        else
                            DisplayOnscreenKeyboard( false, "", "", "Price", "", "", "", 9 )
                        end
                    elseif ( UpdateOnscreenKeyboard() == 2 ) then
                        canceled = true
                        TriggerEvent("usa:notify", "Stopped Adding Property!")
                        break
                    end
                    Wait( 0 )
                end
                TriggerEvent("hotkeys:enable", true)

                if not canceled then
                    TriggerServerEvent("properties:addNewProperty", prop_coords, garage_coords, prop_name, prop_price)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    local last_check_toggle = 0
	while true do
		if IsControlJustPressed(0, MENU_KEY) then
			local me = GetPlayerPed(-1)
			for name, info in pairs(NEARBY_PROPERTIES) do
				-- see if close to display menu --
                if GetDistanceBetweenCoords(GetEntityCoords(me), info.x, info.y, info.z, true) < 1 then
                    nearest_property_info = NEARBY_PROPERTIES[name]
                    closest_coords.x, closest_coords.y, closest_coords.z = info.x, info.y, info.z
                        --drawTxt("Press [ ~b~E~w~ ] to access the " .. name .. " property menu!",7,1,0.5,0.8,0.6,255,255,255,255)
                        --if IsControlJustPressed(0, MENU_KEY) then
                            Citizen.CreateThread(function()
                                _menuPool = NativeUI.CreatePool()
                                ------------------------------
                                -- check for any owner --
                                ------------------------------
                                if nearest_property_info.owner.name then
                                    ---------------------------------------
                                    -- check if this client is owner --
                                    ---------------------------------------
                                    local can_open = {
                                      status = false,
                                      owner = false
                                    }
                                    if nearest_property_info.owner.identifier == my_property_identifier then
                                      can_open = {
                                        status = true,
                                        owner = true
                                      }
                                    else
                                      if nearest_property_info.coowners then
                                        for i = 1, #nearest_property_info.coowners do
                                          if nearest_property_info.coowners[i].identifier == my_property_identifier then
                                            can_open = {
                                              status = true,
                                              owner = false
                                            }
                                            break
                                          end
                                        end
                                      end
                                    end
                                    if can_open.status == true then
                                        ----------------------------
                                        -- create main menu  --
                                        ----------------------------
                                        if can_open.owner == true then
                                          mainMenu = NativeUI.CreateMenu(name, "~b~You own this property!", 50 --[[X COORD]], 320 --[[Y COORD]])
                                        else
                                          mainMenu = NativeUI.CreateMenu(name, "~b~You co-own this property!", 50 --[[X COORD]], 320 --[[Y COORD]])
                                        end
                                        ---------------------------
                                        -- next fee due date  --
                                        ---------------------------
                                        local item = NativeUI.CreateItem("Next Fee Due: " .. nearest_property_info.fee.end_date, "Fee of $" .. nearest_property_info.fee.price .. " due on: " .. nearest_property_info.fee.end_date)
                                        mainMenu:AddItem(item)
                                        ---------------------------
                                        -- leave property        --
                                        ---------------------------
                                        if nearest_property_info.will_leave == nil then
                                            nearest_property_info.will_leave = false
                                        end
                                        local item = nil
                                        if can_open.owner == true then
                                            item = NativeUI.CreateCheckboxItem("Continue Tennancy", not nearest_property_info.will_leave, "Enable/Disable if you want to continue paying for this property", 1)
                                            item.CheckboxEvent = function(parentmenu, selected, checked)
                                                if GetGameTimer() - last_check_toggle > 5000 then
                                                    last_check_toggle = GetGameTimer()
                                                    nearest_property_info.will_leave = not checked
                                                    TriggerServerEvent("properties:willLeave", nearest_property_info.name, not checked)
                                                else
                                                    TriggerEvent("usa:notify", "You are doing that too fast!")
                                                    RemoveMenuPool(_menuPool)
                                                end
                                            end
                                        else
                                            if nearest_property_info.will_leave then
                                                item = NativeUI.CreateItem("Tennancy Ending", "The owner has chosen not to continue paying and the house will go up for sale")
                                            else
                                                item = NativeUI.CreateItem("Tennancy Continuing", "The Tennancy will continue as normal")
                                            end
                                        end
                                        mainMenu:AddItem(item)
                                        ------------------------------
                                        -- load /display money --
                                        ------------------------------
                                        TriggerServerEvent("properties:loadMoneyForMenu", nearest_property_info.name)
                                        while not menu_data.money do
                                            Wait(10)
                                        end
                                        local item = NativeUI.CreateItem("Money: ~g~$" .. comma_value(menu_data.money), "Amount of money stored at this property.")
                                        mainMenu:AddItem(item)
                                        --------------------
                                        -- store money --
                                        --------------------
                                        local item = NativeUI.CreateItem("Store Money", "Store an amount of money at this property.")
                                        item.Activated = function(parentmenu, selected)
                                            -----------------------------
                                            -- get amount to store --
                                            -----------------------------
                                            -- 1) close menu
                                            RemoveMenuPool(_menuPool)
                                            -- 2) get input
                                            Citizen.CreateThread( function()
                                                TriggerEvent("hotkeys:enable", false)
                                                DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
                                                while true do
                                                    if ( UpdateOnscreenKeyboard() == 1 ) then
                                                        local input_amount = GetOnscreenKeyboardResult()
                                                        print("keyboard result: " .. input_amount)
                                                        if ( string.len( input_amount ) > 0 ) then
                                                            local amount = tonumber( input_amount )
                                                            amount = math.floor(amount, 0)
                                                            if ( amount > 0 ) then
                                                                print("storing: $" .. amount)
                                                                TriggerServerEvent("properties-og:storeMoney", nearest_property_info.name, amount)
                                                            end
                                                            break
                                                        else
                                                            DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
                                                        end
                                                    elseif ( UpdateOnscreenKeyboard() == 2 ) then
                                                        break
                                                    end
                                                    Wait( 0 )
                                                end
                                                TriggerEvent("hotkeys:enable", true)
                                            end )
                                        end
                                        mainMenu:AddItem(item)
                                        --------------------------
                                        -- withdraw money --
                                        --------------------------
                                        local item = NativeUI.CreateItem("Withdraw Money", "Withdraw an amount of money from this property.")
                                        item.Activated = function(parentmenu, selected)
                                            ----------------------------------
                                            -- get amount to withdraw --
                                            ----------------------------------
                                            -- close menu --
                                            RemoveMenuPool(_menuPool)
                                            -- get input to withdraw --
                                            Citizen.CreateThread( function()
                                                TriggerEvent("hotkeys:enable", false)
                                                DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
                                                while true do
                                                    if ( UpdateOnscreenKeyboard() == 1 ) then
                                                        local input_amount = GetOnscreenKeyboardResult()
                                                        if ( string.len( input_amount ) > 0 ) then
                                                            local amount = tonumber( input_amount )
                                                            amount = math.floor(amount, 0)
                                                            if ( amount > 0 ) then
                                                                TriggerServerEvent("properties:withdraw", nearest_property_info.name, amount, nil, true)
                                                            end
                                                            break
                                                        else
                                                            DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
                                                        end
                                                    elseif ( UpdateOnscreenKeyboard() == 2 ) then
                                                        break
                                                    end
                                                    Wait( 0 )
                                                end
                                                TriggerEvent("hotkeys:enable", true)
                                            end)
                                        end
                                        mainMenu:AddItem(item)
                                        ----------------------------
                                        -- access house inventory --
                                        ----------------------------
                                        local inventoryBtn = NativeUI.CreateItem("Storage", "Retrieve and store items from this property.")
                                        inventoryBtn.Activated = function(parentmenu, selected)
                                            TriggerServerEvent("properties-og:onStorageBtnSelected", nearest_property_info.name)
                                            mainMenu:Visible(false)
                                        end
                                        mainMenu:AddItem(inventoryBtn)
                                        -----------------
                                        -- wardrobe --
                                        -----------------
                                        local wardrobe_submenu = _menuPool:AddSubMenu(mainMenu, "Wardrobe", "Store and retrieve outfits here.", true --[[KEEP POSITION]])
                                        TriggerServerEvent("properties:getWardrobe", nearest_property_info.name)
                                        waitingForWardrobeToLoad = true
                                        while waitingForWardrobeToLoad do
                                            Wait(10)
                                        end
                                        if menu_data.wardrobe and #menu_data.wardrobe > 0 then
                                            for x  = 1, #menu_data.wardrobe do
                                                local outfit = menu_data.wardrobe[x]
                                                ---------------------------------------------
                                                -- submenu for each wardrobe item --
                                                ---------------------------------------------
                                                local wardrobe_submenu2 = _menuPool:AddSubMenu(wardrobe_submenu.SubMenu, outfit.name, "Put on or delete " .. outfit.name, true --[[KEEP POSITION]])
                                                local putonbtn = NativeUI.CreateItem("Put On", "Put on " .. outfit.name)
                                                putonbtn.Activated = function(parentmenu, selected)
                                                    SetPedOutfit(outfit.clothing)
                                                    RemoveMenuPool(_menuPool)
                                                end
                                                wardrobe_submenu2.SubMenu:AddItem(putonbtn)
                                                local deletebtn = NativeUI.CreateItem("Delete", "Delete " .. outfit.name)
                                                deletebtn.Activated = function(parentmenu, selected)
                                                    TriggerServerEvent("properties:deleteOutfitByName", nearest_property_info.name, outfit.name)
                                                    RemoveMenuPool(_menuPool)
                                                end
                                                wardrobe_submenu2.SubMenu:AddItem(deletebtn)
                                            end
                                        else
											local noitemsbtn = NativeUI.CreateItem("You have no outfits saved!", "Press the 'Save Current Outfit' button to save an outfit.")
											wardrobe_submenu.SubMenu:AddItem(noitemsbtn)
										end
                                        -------------------
                                        -- save button --
                                        -------------------
                                        local savebtn = NativeUI.CreateItem("Save Current Outfit", "Save your current outfit.")
                                        savebtn.Activated = function(parentmenu, selected)
                                            RemoveMenuPool(_menuPool)
                                            Citizen.CreateThread(function()
                                                -- get user input for name
                                                local outfitname = GetUserInput()
                                                if outfitname then
                                                    -- save player's outfit
                                                    local clothing = GetPedOutfit()
                                                    -- build the object
                                                    local outfit = {
                                                        name = outfitname,
                                                        clothing = clothing
                                                    }
                                                    TriggerServerEvent("properties-og:saveOutfit", nearest_property_info.name, outfit)
                                                    RemoveMenuPool(_menuPool)
                                                end
                                            end)
                                        end
                                        wardrobe_submenu.SubMenu:AddItem(savebtn)
                                        -------------------
                                        -- spawn here --
                                        -------------------
                                        local spawnbtn = NativeUI.CreateItem("Spawn Here", "Set your spawn to this location.")
                                        spawnbtn.Activated = function(parentmenu, selected)
                                            local spawn = { x = nearest_property_info.x, y = nearest_property_info.y, z = nearest_property_info.z, name = nearest_property_info.name }
                                            TriggerServerEvent("properties:setSpawnPoint", spawn)
                                        end
                                        mainMenu:AddItem(spawnbtn)
                                        if can_open.owner == true then -- only allow true owners (non co owners) to modify co owners
                                          ----------------------------
                                          -- add / remove property co-owners --
                                          ----------------------------
                                          local coowners_submenu = _menuPool:AddSubMenu(mainMenu, "Owners", "Manage property co-owners.", true --[[KEEP POSITION]])
                                          -- transfer ownership
                                          local transferOwner = NativeUI.CreateItem("Transfer Ownership", "Transfer the property to another player")
                                          transferOwner.Activated = function(parentmenu, selected)
                                            RemoveMenuPool(_menuPool)
                                            Citizen.CreateThread( function()
                                                TriggerEvent("hotkeys:enable", false)
                                                DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
                                                while true do
                                                    if ( UpdateOnscreenKeyboard() == 1 ) then
                                                        local server_id = GetOnscreenKeyboardResult()
                                                        if ( string.len( server_id ) > 0 ) then
                                                            local server_id = tonumber( server_id )
                                                            if ( server_id > 0 ) then
                                                                local confirmed = false
                                                                local before = GetGameTimer()
                                                                while not confirmed and (GetGameTimer() - before) < 30000 do
                                                                    Citizen.Wait(0)
                                                                    alert("~r~Transfer Ownership to "..server_id.."? ~INPUT_MP_TEXT_CHAT_TEAM~~r~/~INPUT_REPLAY_ENDPOINT~")
                                                                    if IsControlJustPressed(0, 246) then
                                                                        confirmed = true
                                                                        TriggerServerEvent("properties:requestChangeOwner", nearest_property_info.name, server_id)
                                                                    elseif IsControlJustPressed(0, 306) then
                                                                        confirmed = true
                                                                        TriggerEvent("usa:notify", "You stopped the transfer!")
                                                                    end
                                                                end
                                                                if not confirmed then
                                                                    TriggerEvent("usa:notify", "Transfer Timed Out")
                                                                end
                                                            end
                                                            break
                                                        else
                                                            DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
                                                        end
                                                    elseif ( UpdateOnscreenKeyboard() == 2 ) then
                                                        break
                                                    end
                                                    Wait( 0 )
                                                end
                                                TriggerEvent("hotkeys:enable", true)
                                            end )
                                          end
                                          coowners_submenu.SubMenu:AddItem(transferOwner)
                                          TriggerServerEvent("properties:getCoOwners", nearest_property_info.name)
                                          while not menu_data.coowners do
                                            Wait(1)
                                          end
                                          for i = 1, #menu_data.coowners do
                                            local coowner_submenu = _menuPool:AddSubMenu(coowners_submenu.SubMenu, menu_data.coowners[i].name, "Manage this person's ownership status" , true --[[KEEP POSITION]])
                                            -- remove as owner --
                                            local removeownerbtn = NativeUI.CreateItem("Remove", "Click to remove this person as a co-owner.")
                                            removeownerbtn.Activated = function(pmenu, selected)
                                              RemoveMenuPool(_menuPool)
                                              TriggerServerEvent("properties:removeCoOwner", nearest_property_info.name, i)
                                            end
                                            coowner_submenu.SubMenu:AddItem(removeownerbtn)
                                          end
                                          local add_owner_btn = NativeUI.CreateItem("Add Co-Owner", "Add a co-owner to this property.")
                                          add_owner_btn.Activated = function(parentmenu, selected)
                                            ------------------------------------------------
                                            -- get server ID of player to add as co-owner --
                                            ------------------------------------------------
                                            -- 1) close menu
                                            RemoveMenuPool(_menuPool)
                                            -- 2) get input
                                            Citizen.CreateThread( function()
                                                TriggerEvent("hotkeys:enable", false)
                                                DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
                                                while true do
                                                    if ( UpdateOnscreenKeyboard() == 1 ) then
                                                        local server_id = GetOnscreenKeyboardResult()
                                                        if ( string.len( server_id ) > 0 ) then
                                                            local server_id = tonumber( server_id )
                                                            if ( server_id > 0 ) then
                                                                TriggerServerEvent("properties:addCoOwner", nearest_property_info.name, server_id)
                                                            end
                                                            break
                                                        else
                                                            DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
                                                        end
                                                    elseif ( UpdateOnscreenKeyboard() == 2 ) then
                                                        break
                                                    end
                                                    Wait( 0 )
                                                end
                                                TriggerEvent("hotkeys:enable", true)
                                            end )
                                          end
                                          coowners_submenu.SubMenu:AddItem(add_owner_btn)
                                        else
                                              local coowners_submenu = _menuPool:AddSubMenu(mainMenu, "Co-Owners", "See co-owners.", true --[[KEEP POSITION]])
                                              TriggerServerEvent("properties:getCoOwners", nearest_property_info.name)
                                              while not menu_data.coowners do
                                                Wait(1)
                                              end
                                              for i = 1, #menu_data.coowners do
                                                local coowner = NativeUI.CreateItem(menu_data.coowners[i].name, "Lives Here")
                                                coowners_submenu.SubMenu:AddItem(coowner)
                                              end
                                        end
                                    else
                                        mainMenu = NativeUI.CreateMenu(name, "", 50 --[[X COORD]], 320 --[[Y COORD]])
                                        local itembtn = NativeUI.CreateItem("Owner: " .. nearest_property_info.owner.name, nearest_property_info.owner.name .. " owns this property.")
                                        mainMenu:AddItem(itembtn)
                                        local itembtn2 = NativeUI.CreateItem("End Date: " .. nearest_property_info.fee.end_date, "This property will be up for sale on " .. nearest_property_info.fee.end_date)
                                        mainMenu:AddItem(itembtn2)
                                        if nearest_property_info.type == "business" then
                                            local itembtn3 = NativeUI.CreateItem("~r~Rob", "Rob this property of its money!")
                                            itembtn3.Activated = function(parentmenu, selected)
                                                if IsPedArmed(GetPlayerPed(-1), 7) then
                                                    TriggerServerEvent('es_holdup:rob', nearest_property_info.name)
                                                    RemoveMenuPool(_menuPool)
                                                else
                                                    TriggerEvent("usa:notify", "I am not threatend!")
                                                end
                                            end
                                            mainMenu:AddItem(itembtn3)
                                        end
                                    end
                                else
                                    ---------------------------
                                    -- create main menu --
                                    ---------------------------
                                    mainMenu = NativeUI.CreateMenu(name, "This property is for sale!", 50 --[[X COORD]], 320 --[[Y COORD]])
                                    -----------------
                                    -- no owner --
                                    -----------------
                                    local pricebtn = NativeUI.CreateItem("Price : $" .. comma_value(nearest_property_info.fee.price), "This property costs $" .. comma_value(nearest_property_info.fee.price))
                                    mainMenu:AddItem(pricebtn)
                                    local purchasebtn = NativeUI.CreateItem("Purchase", "Buy this property for $" .. comma_value(nearest_property_info.fee.price) .. "!")
                                    purchasebtn.Activated = function(parentmenu, selected)
                                        TriggerServerEvent("properties:purchaseProperty", nearest_property_info)
                                        RemoveMenuPool(_menuPool)
                                    end
                                    mainMenu:AddItem(purchasebtn)
                                end
                                --[[
                                ----------------
                                -- close btn --
                                ----------------
                                local closebtn = NativeUI.CreateItem("Close Menu", "Close this property menu.")
                                closebtn.Activated = function(parentmenu, selected)
                                    RemoveMenuPool(_menuPool)
                                end
                                mainMenu:AddItem(closebtn)
                                --]]
                                _menuPool:RefreshIndex()
                                _menuPool:Add(mainMenu)
                                mainMenu:Visible(true)
                            end)
                        --end
                elseif info.garage_coords then
                    if GetDistanceBetweenCoords(GetEntityCoords(me), info.garage_coords.x, info.garage_coords.y, info.garage_coords.z, true) < 1 then
                        nearest_property_info = NEARBY_PROPERTIES[name]
                        closest_coords.x, closest_coords.y, closest_coords.z = info.garage_coords.x, info.garage_coords.y, info.garage_coords.z
                        if IsPedInAnyVehicle(me, true) then
                            if nearest_property_info.owner then
                              local can_open = {
                                status = false,
                                owner = false
                              }
                              if nearest_property_info.owner.identifier == my_property_identifier then
                                can_open = {
                                  status = true,
                                  owner = true
                                }
                              else
                                if nearest_property_info.coowners then
                                  for i = 1, #nearest_property_info.coowners do
                                    if nearest_property_info.coowners[i].identifier == my_property_identifier then
                                      can_open = {
                                        status = true,
                                        owner = false
                                      }
                                      break
                                    end
                                  end
                                end
                              end
                                if can_open.status == true then
                                    local vehicle = GetVehiclePedIsIn(me, false)
                                    local numberPlateText = GetVehicleNumberPlateText(vehicle)
                                    numberPlateText = exports.globals:trim(numberPlateText)
                                    TriggerServerEvent("properties:storeVehicle", nearest_property_info.name, numberPlateText)
                                    Wait(1000)
                                end
                            end
                        else
                            --drawTxt("Press [ ~b~E~w~ ] to access the " .. name .. " property garage!",7,1,0.5,0.8,0.6,255,255,255,255)
                            --if IsControlJustPressed(0, MENU_KEY) then
                                if nearest_property_info.owner then
                                  local can_open = {
                                    status = false,
                                    owner = false
                                  }
                                  if nearest_property_info.owner.identifier == my_property_identifier then
                                    can_open = {
                                      status = true,
                                      owner = true
                                    }
                                  else
                                    if nearest_property_info.coowners then
                                      for i = 1, #nearest_property_info.coowners do
                                        if nearest_property_info.coowners[i].identifier == my_property_identifier then
                                          can_open = {
                                            status = true,
                                            owner = false
                                          }
                                          break
                                        end
                                      end
                                    end
                                  end
                                    if can_open.status == true then
                                        Citizen.CreateThread(function()
                                            TriggerServerEvent("properties:loadVehiclesForMenu", nearest_property_info.name)
                                            while not menu_data.vehicles do
                                                Wait(10)
                                            end
                                            _menuPool = NativeUI.CreatePool()
                                            mainMenu = NativeUI.CreateMenu(nearest_property_info.name, "~b~Property Garage", 50 --[[X COORD]], 320 --[[Y COORD]])
                                            ---------------------------
                                            -- next fee due date  --
                                            ---------------------------
                                            for i = 1, #menu_data.vehicles do
                                                local veh = menu_data.vehicles[i]
                                                local item = NativeUI.CreateItem((veh.owner or "Someone") .. "'s " .. (veh.make or "INVALIDMAKE") .. " " .. (veh.model or "INVALIDMODEL") .. " [" .. (veh.plate or "N/A") .. "]", "Press enter to withdraw this vehicle.")
                                                item.Activated = function(parentmenu, selected)
                                                    RemoveMenuPool(_menuPool)
                                                    TriggerServerEvent("properties:retrieveVehicle", name, veh)
                                                end
                                                mainMenu:AddItem(item)
                                            end
                                            ---------------------------------------
                                            -- Add to menu pool and open --
                                            ---------------------------------------
                                            _menuPool:RefreshIndex()
                                            _menuPool:Add(mainMenu)
                                            mainMenu:Visible(true)
                                        end)
                                    end
                                end
                            --end
                        end
                    end
                end
			end
		end
		Wait(5)
	end
end)

RegisterNetEvent("properties:confirmNewOwner")
AddEventHandler("properties:confirmNewOwner", function(property_name, id, old_owner_id, owner_name)
    local alert = lib.alertDialog({
        header = '*Property Transfer*',
        content = owner_name .. ' is trying to transfer the property "'..property_name..'" to you, do you want to accept this?',
        centered = true,
        cancel = true,
        labels = {cancel = "Decline", confirm = "Accept"}
    })

    local accepted = false
    if alert == "confirm" then
        accepted = true
    end
    TriggerServerEvent("properties:changeOwner", property_name, id, old_owner_id, accepted)
end)

--------------------------------------------
-- draw markers / close menu when far away --
--------------------------------------------
Citizen.CreateThread(function()
    local me = GetPlayerPed(-1)
    while true do
        Wait(5)
        local me = GetPlayerPed(-1)
		local mycoords = GetEntityCoords(me)
        for name, info in pairs(NEARBY_PROPERTIES) do
            if GetDistanceBetweenCoords(info.x, info.y, info.z, mycoords.x, mycoords.y, mycoords.z, true) < 50 then
                -- draw main property marker --
                if info.owner.name then
                    DrawMarker(27, info.x, info.y, info.z-0.9, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 124--[[r]], 41 --[[g]], 153 --[[b]], 90, 0, 0, 2, 0, 0, 0, 0)
                else
                    DrawMarker(27, info.x, info.y, info.z-0.9, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 183 --[[r]], 240 --[[g]], 65 --[[b]], 90, 0, 0, 2, 0, 0, 0, 0)
                end
                -- draw garage marker --
                if info.garage_coords then
                    DrawMarker(27, info.garage_coords.x, info.garage_coords.y, info.garage_coords.z-0.9, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255 --[[r]], 92 --[[g]], 92 --[[b]], 90, 0, 0, 2, 0, 0, 0, 0)
                end
				-- draw special text --
				if GetDistanceBetweenCoords(info.x, info.y, info.z, mycoords.x, mycoords.y, mycoords.z, true) < 1 then
					drawTxt("Press [ ~b~E~w~ ] to access the " .. name .. " property menu!",7,1,0.5,0.8,0.6,255,255,255,255)
				elseif info.garage_coords then
					if GetDistanceBetweenCoords(info.garage_coords.x, info.garage_coords.y, info.garage_coords.z, mycoords.x, mycoords.y, mycoords.z, true) < 1 then
						if IsPedInAnyVehicle(me, true) then
                            if info.owner then
                                local can_open = {
                                    status = false,
                                    owner = false
                                }
                                if info.owner.identifier == my_property_identifier then
                                    can_open = {
                                        status = true,
                                        owner = true
                                    }
                                else
                                    if info.coowners then
                                        for i = 1, #info.coowners do
                                            if info.coowners[i].identifier == my_property_identifier then
                                                can_open = {
                                                    status = true,
                                                    owner = false
                                                }
                                                break
                                            end
                                        end
                                    end
                                end
                                if can_open.status == true then
                                    drawTxt("Press [ ~b~E~w~ ] to store your vehicle in the garage!",7,1,0.5,0.8,0.6,255,255,255,255)
                                end
                            end
						else
							drawTxt("Press [ ~b~E~w~ ] to access the " .. name .. " property garage!",7,1,0.5,0.8,0.6,255,255,255,255)
						end
					end
				end
            end
        end
        --print("typeof _menuPool: " .. type(_menuPool))
        if _menuPool then
            _menuPool:MouseControlsEnabled(false)
            _menuPool:ControlDisablingEnabled(false)
            _menuPool:ProcessMenus()
        end
        if closest_coords.x then
            if GetDistanceBetweenCoords(GetEntityCoords(me), closest_coords.x, closest_coords.y, closest_coords.z, true) > 2 then
                closest_coords.x, closest_coords.y, closest_coords.z = nil, nil, nil
                if _menuPool then
                    RemoveMenuPool(_menuPool)
                end
                TriggerEvent("interaction:forceShutGUI", { secondaryInventoryType = "property" })
            end
        end
    end
end)

function SetPedOutfit(outfit)
  Citizen.CreateThread(function()
    --print("applying ped outfit!")
    local ped = GetPlayerPed(-1)
    for key, value in pairs(outfit) do
      if type(value) == "table" then -- since first version was not a table, this will ignore those outfits
        if key ~= "props" then
          -- clothing --
          --print("setting " .. key .. " to " .. value.component_value .. ", " .. value.texture_value) -- debug
          SetPedComponentVariation(ped, tonumber(key), value.component_value, value.texture_value, 2)
        elseif key == "props" then
          ClearPedProps()
          -- hats / glasses / earrings / that kinda what not --
          for prop_index, prop_values in pairs(value) do
            SetPedPropIndex(ped, tonumber(prop_index), tonumber(prop_values.prop_value), tonumber(prop_values.prop_texture_value), true)
          end
        end
      end
    end
  end)
end

function ClearPedProps()
  for i = 0, 3 do
    ClearPedProp(GetPlayerPed(-1), i)
  end
end

function GetPedOutfit()
    --print("saving clothing:")
    local ped = GetPlayerPed(-1)
    local clothing = {
        [8] = { -- torso (undershirt)
        component_value = GetPedDrawableVariation(ped, 8),
        texture_value = GetPedTextureVariation(ped, 8)
        },
        [7] = { -- ties
        component_value = GetPedDrawableVariation(ped, 7),
        texture_value = GetPedTextureVariation(ped, 7)
        },
        [3] = { -- arms/hands
        component_value = GetPedDrawableVariation(ped, 3),
        texture_value = GetPedTextureVariation(ped, 3)
        },
        [11] = { -- torso 2 (jackets)
        component_value = GetPedDrawableVariation(ped,11),
        texture_value = GetPedTextureVariation(ped,11)
        },
        [4] = { -- legs
        component_value = GetPedDrawableVariation(ped, 4),
        texture_value = GetPedTextureVariation(ped, 4)
        },
        [6] = { -- feet
        component_value = GetPedDrawableVariation(ped, 6),
        texture_value = GetPedTextureVariation(ped, 6)
        },
        ["props"] = {
            [0] = {
                prop_value = GetPedPropIndex(ped, 0),
                prop_texture_value = GetPedPropTextureIndex(ped, 0)
            },
            [1] = {
                prop_value = GetPedPropIndex(ped, 1),
                prop_texture_value = GetPedPropTextureIndex(ped, 1)
            },
            [2] = {
                prop_value = GetPedPropIndex(ped, 2),
                prop_texture_value = GetPedPropTextureIndex(ped, 2)
            },
            [3] = {
                prop_value = GetPedPropIndex(ped, 3),
                prop_texture_value = GetPedPropTextureIndex(ped, 3)
            }
        }
    }
    return clothing
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function GetUserInput()
    -- get withdraw amount from user input --
    TriggerEvent("hotkeys:enable", false)
    DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 15 )
    while true do
        if ( UpdateOnscreenKeyboard() == 1 ) then
            local input = GetOnscreenKeyboardResult()
            if ( string.len( input ) > 0 ) then
                -- do something with the input var
                TriggerEvent("hotkeys:enable", true)
                return input
            else
                DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 15 )
            end
        elseif ( UpdateOnscreenKeyboard() == 2 ) then
            break
        end
        Wait( 0 )
    end
    TriggerEvent("hotkeys:enable", true)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end

function RemoveMenuPool(pool)
    menu_data.property_items = nil
    menu_data.user_items = nil
    menu_data.money = nil
    menu_data.vehicles = nil
    menu_data.wardrobe = nil
    menu_data.coowners = nil
    _menuPool = nil
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function AddBlips(locations)
    for i = 1, #locations do
        local b = AddBlipForCoord(locations[i].x, locations[i].y, locations[i].z)
        SetBlipSprite(b, 40)
        SetBlipDisplay(b, 4)
        SetBlipScale(b, 0.75)
        if locations[i].coowner then
            SetBlipColour(b, 11)
        else
            SetBlipColour(b, 61)
        end
        SetBlipAsShortRange(b, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Your Property')
        EndTextCommandSetBlipName(b)
        table.insert(currentMapBlips, b)
    end
end

function RemoveBlips()
    for i = 1, #currentMapBlips do
        RemoveBlip(currentMapBlips[i])
    end
end

function isUnderglowOn(veh)
	local indexes = {0, 1, 2, 3}
	for i = 1, #indexes do
		if IsVehicleNeonLightEnabled(veh, indexes[i]) then
			return true
		end
	end
	return false
end

function isNearbyPropertyOwner()
    local playerCoords = GetEntityCoords(PlayerPedId())
    for _, info in pairs(NEARBY_PROPERTIES) do
        local distance = GetDistanceBetweenCoords(playerCoords, info.x, info.y, info.z, true)
        if distance < 1 then
            if info.owner and info.owner.identifier == my_property_identifier then
                return true
            elseif info.coowners then
                for _, coowner in ipairs(info.coowners) do
                    if coowner.identifier == my_property_identifier then
                        return true
                    end
                end
            end
        end
    end
    return false
end
exports("isNearbyPropertyOwner", isNearbyPropertyOwner)

Citizen.CreateThread(function()
    local lastCheck = GetGameTimer()
    while true do
        if GetGameTimer() - lastCheck > NEARBY_PROPERTY_INTERVAL_CHECK_MS then
            lastCheck = GetGameTimer()
            NEARBY_PROPERTIES = {}
            local mycoords = GetEntityCoords(PlayerPedId())
            for name, info in pairs(ALL_PROPERTIES) do
                local dist = #(mycoords - vector3(info.x, info.y, info.z))
                if dist < 100 then
                    NEARBY_PROPERTIES[name] = info
                end
            end
        end
        Wait(1)
    end
end)