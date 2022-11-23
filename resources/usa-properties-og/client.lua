--# Residential / Business Properties
--# own, store stuff, be a bawse
--# by: minipunch
--# made for: USA REALISM RP

local NEARBY_PROPERTIES = {} -- loaded from the server on first load or whenever a change is made. below data is only for reference whle making

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

RegisterNetEvent("properties:setPropertyBlips")
AddEventHandler("properties:setPropertyBlips", function(propertyLocations)
    RemoveBlips()
    AddBlips(propertyLocations)
end)

RegisterNetEvent("properties:setPropertyIdentifier")
AddEventHandler("properties:setPropertyIdentifier", function(ident)
    my_property_identifier = ident
end)

RegisterNetEvent("properties-og:setNearbyProperties")
AddEventHandler("properties-og:setNearbyProperties", function(nearby)
    NEARBY_PROPERTIES = nearby
end)

RegisterNetEvent("properties:update")
AddEventHandler("properties:update", function(property)
    if NEARBY_PROPERTIES[property.name] then
        NEARBY_PROPERTIES[property.name] = property
    end
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

Citizen.CreateThread(function()
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
                                        local item = NativeUI.CreateItem("Next Fee Due: " .. nearest_property_info.fee.end_date, "This property expires on: " .. nearest_property_info.fee.end_date)
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
                                          local add_owner_btn = NativeUI.CreateItem("Add Owner", "Add a co-owner to this property.")
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
                                    --drawTxt("Press [ ~b~E~w~ ] to store your vehicle in the garage!",7,1,0.5,0.8,0.6,255,255,255,255)
                                    --if IsControlJustPressed(0, MENU_KEY) then
                                        local vehicle = GetVehiclePedIsIn(me, false)
                                        local numberPlateText = GetVehicleNumberPlateText(vehicle)
                                        numberPlateText = exports.globals:trim(numberPlateText)
                                        TriggerServerEvent("properties:storeVehicle", nearest_property_info.name, numberPlateText)
                                        Wait(1000)
                                    --end
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
