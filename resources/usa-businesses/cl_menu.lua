--# Business Properties
--# own, store stuff, be a bawse
--# by: minipunch, distritic
--# made for: USA REALISM RP

local _menuPool = nil

---------------------------------------------
-- get closest property from given (usually player) coords  --
---------------------------------------------
RegisterNetEvent("business:getPropertyGivenCoords")
AddEventHandler("business:getPropertyGivenCoords", function(x,y,z, cb)
  local closest = 1000000000000.0
  local closest_property = nil
  for name, info in pairs(BUSINESSES) do
    if #(vector3(x, y, z) - vector3(info.position.x, info.position.y, info.position.z)) < 50.0 and #(vector3(x, y, z) - vector3(info.position.x, info.position.y, info.position.z)) < closest then
      closest = #(vector3(x, y, z) - vector3(info.position.x, info.position.y, info.position.z))
      closest_property = info
    end
  end
  if closest_property then
    cb(closest_property)
  else
    cb(nil)
  end
end)

RegisterNetEvent("business:showMenu")
AddEventHandler("business:showMenu", function(business, charInv)
  _menuPool = NativeUI.CreatePool()
  ----------------------------
  -- create main menu  --
  ----------------------------
  mainMenu = NativeUI.CreateMenu(business.name, "~b~You own this property!", 50 --[[X COORD]], 320 --[[Y COORD]])
  ---------------------------
  -- next fee due date  --
  ---------------------------
  local item = NativeUI.CreateItem("Next Fee Due: " .. business.fee.due.date, "This property expires on: " .. business.fee.due.date)
  mainMenu:AddItem(item)
  ------------------------------
  -- load /display money --
  ------------------------------
  local item = NativeUI.CreateItem("Money: ~g~$" .. comma_value(business.storage.cash), "Amount of money stored at this property.")
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
          if ( string.len( input_amount ) > 0 ) then
            local amount = tonumber( input_amount )
            amount = math.floor(amount, 0)
            if ( amount > 0 ) then
              TriggerServerEvent("business:storeMoney", business.name, amount)
            else
              exports.globals:notify("Please enter an amount greater than 0")
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
              TriggerServerEvent("business:withdraw", business.name, amount, nil, true)
            else
              exports.globals:notify("Please enter an amount greater than 0")
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
  ---------------------
  -- item retrieval  --
  ---------------------
  local retrieval_submenu = _menuPool:AddSubMenu(mainMenu, "Storage", "Retrieve items from this property.", true --[[KEEP POSITION]])
  if #business.storage.items > 0 then
    for i = 1, #business.storage.items do
      local item = business.storage.items[i]
      local color = ""
      if item.legality == "legal" then
        color = ""
      else
        color = "~r~"
      end
      local itembtn = NativeUI.CreateItem(color .. "(" .. item.quantity .. "x) " .. item.name, "Withdraw some amount of this item.")
      itembtn.Activated = function(parentmenu, selected)
        RemoveMenuPool(_menuPool)
        ----------------------------------------------------------------
        -- ask for quantity to retrieve, then try to retrieve it --
        ----------------------------------------------------------------
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
                  if item.quantity - amount >= 0 then
                    TriggerServerEvent("business:retrieve", business.name, item, amount)
                  else
                    exports.globals:notify("Quantity input too high!")
                  end
                else
                  exports.globals:notify("Quantity input too low!")
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
      retrieval_submenu.SubMenu:AddItem(itembtn)
    end
  else
    local item = NativeUI.CreateItem("You have nothing stored here!", "Press \"Store Items\" to store something here.")
    retrieval_submenu.SubMenu:AddItem(item)
  end
  --------------------
  -- item storage --
  --------------------
  local storage_submenu = _menuPool:AddSubMenu(mainMenu, "Store Items", "Store items at this property.", true --[[KEEP POSITION]])
  if #charInv > 0 then
    for i = 1, #charInv do
      local item = charInv[i]
      local color = ""
      if item.legality == "legal" then
        color = ""
      else
        color = "~r~"
      end
      local itembtn = NativeUI.CreateItem(color .. "(" .. item.quantity .. "x) " .. item.name, "Store some amount of this item.")
      itembtn.Activated = function(parentmenu, selected)
        RemoveMenuPool(_menuPool)
        -- ask for quantity to store, then try to store it --
        Citizen.CreateThread( function()
          TriggerEvent("hotkeys:enable", false)
          DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
          while true do
            if ( UpdateOnscreenKeyboard() == 1 ) then
              local input_amount = GetOnscreenKeyboardResult()
              if ( string.len( input_amount ) > 0 ) then
                local amount = tonumber( input_amount )
                amount = math.floor(amount, 0)
                if amount > 0 then
                  if not item.quantity then item.quantity = 1 end
                  if item.quantity - amount >= 0 then
                    print("storing item [" .. item.name .. "] with quantity [" .. item.quantity .. "]")
                    TriggerServerEvent("business:store", business.name, item, amount)
                  else
                    exports.globals:notify("Quantity input too high!")
                  end
                else
                  exports.globals:notify("Quantity input too low!")
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
      storage_submenu.SubMenu:AddItem(itembtn)
    end
  else
    local item = NativeUI.CreateItem("No items to store!", "You have nothing to store.")
    storage_submenu.SubMenu:AddItem(item)
  end
  --[[
  if business.owner.identifiers.id == mySteamID then -- only allow true owners (non co owners) to modify co owners
    ----------------------------
    -- add / remove property co-owners --
    ----------------------------
    local coowners_submenu = _menuPool:AddSubMenu(mainMenu, "Owners", "Manage property co-owners.", true)
    for i = 1, #menu_data.coowners do
      local coowner_submenu = _menuPool:AddSubMenu(coowners_submenu, menu_data.coowners[i].name, "Manage this person's ownership status" , true)
      -- remove as owner --
      local removeownerbtn = NativeUI.CreateItem("Remove", "Click to remove this person as a co-owner.")
      removeownerbtn.Activated = function(pmenu, selected)
        RemoveMenuPool(_menuPool)
        TriggerServerEvent("properties:removeCoOwner", nearest_property_info.name, i)
      end
      coowner_submenu:AddItem(removeownerbtn)
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
      end )
    end
    coowners_submenu:AddItem(add_owner_btn)
  end
  --]]
  _menuPool:RefreshIndex()
  _menuPool:Add(mainMenu)
  mainMenu:Visible(true)
end)

--------------------------------------------
-- draw markers / close menu when far away --
--------------------------------------------
Citizen.CreateThread(function()
  local me = GetPlayerPed(-1)
  while true do
    Wait(5)
    if _menuPool then
      if _menuPool:IsAnyMenuOpen() then
        _menuPool:MouseControlsEnabled(false)
        _menuPool:ControlDisablingEnabled(false)
        _menuPool:ProcessMenus()
      end
      if mainMenu:Visible() and not GetClosestStore(5) then
        mainMenu:Visible(false)
      end 
    end
  end
end)

function GetUserInput()
  TriggerEvent("hotkeys:enable", false)
  -- get withdraw amount from user input --
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
    pool:CloseAllMenus()
    _menuPool = nil
end
