local SHOPS = {
  {x = -293.711, y = 6200.428, z = 31.487}, -- paleto
  {x = 1863.775, y = 3747.57, z = 33.03}, -- sandy shores
  {x = 323.947, y = 179.87, z = 103.586}, -- los santos, vinewood area
  {x = 1321.550, y = -1653.529, z = 52.27}, -- los santos, east side
  {x = -1155.323, y = -1426.81, z = 4.9}, -- los santos, west side vespucci beach
  {x = -3169.1, y = 1076.8, z = 20.8}, -- ls, west coast
  {x = -255.64067077637, y = -1530.5904541016, z = 32.483879089355}, -- chamberlain hills community center (addon MLO)
  {x = 2511.6831054688, y = 4089.3657226563, z = 35.585105895996}, -- lunatix biker (addon MLO)
  {x = -585.83850097656, y = -597.84173583984, z = 41.430263519287} -- Mall MLO
}

local TATTOOS = nil

local purchased_tattoos = {}

local closest_shop = nil

local MENU_KEY = 38

---------------------
-- Load Tattoos --
---------------------
TriggerServerEvent("tattoo:loadTattoos")

RegisterNetEvent("tattoo:loadTattoos")
AddEventHandler("tattoo:loadTattoos", function(tats)
    TATTOOS = tats
end)

RegisterNetEvent("tattoo:removeTattoos")
AddEventHandler("tattoo:removeTattoos", function()
  ClearPedDecorations(GetPlayerPed(-1))
end)

------------------------
--- utility functions --
------------------------
function drawMarkers()
	for i = 1, #SHOPS do
		DrawMarker(27,SHOPS[i].x,SHOPS[i].y,SHOPS[i].z-0.9,0,0,0,0,0,0,3.001,3.0001,0.5001,0,155,255,200,0,0,0,0)
	end
end

function DrawText3D(x, y, z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
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

function RemoveClothes()
  local me = GetPlayerPed(-1)
  -- remove clothing (to see tattoos) --
  if IsPedModel(me,"mp_m_freemode_01") or IsPedModel(me,"mp_f_freemode_01") then
    if(GetEntityModel(me) == -1667301416) then -- female
      SetPedComponentVariation(me, 8, 14,0, 2)
      SetPedComponentVariation(me, 3, 15,0, 2)
      SetPedComponentVariation(me, 11, 15,1, 2)
      SetPedComponentVariation(me, 4, 43,0, 2)
    else -- male
      SetPedComponentVariation(me, 8, 15,0, 2) -- torso 1
      SetPedComponentVariation(me, 3, 15,0, 2) -- arms/hands
      SetPedComponentVariation(me, 11, 15,0, 2) -- torso 2
      SetPedComponentVariation(me, 4, 14,0, 2) -- legs
    end
  end
  -- remove weird black box on back/front? --
  SetPedComponentVariation(me, 10, 0, 0, 0)
end

-------------
-- Menu --
-------------
_menuPool = NativeUI.CreatePool()
MainMenu = NativeUI.CreateMenu("Sick Tatz", "~b~Welcome!", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(MainMenu)

-------------------------
-- Wait for Tattoos --
-------------------------
Citizen.CreateThread(function()
    while not TATTOOS do
        Wait(100)
    end

    local tattoos_submenu = _menuPool:AddSubMenu(MainMenu, "Tattoos", "See our selection of tattoos.", true --[[KEEP POSITION]])
    -----------------------------
    -- Category Submenus--
    -----------------------------
    for category, items in pairs(TATTOOS) do
        local category_submenu = _menuPool:AddSubMenu(tattoos_submenu.SubMenu, category, "See our selection of " .. category .. " tattoos.", true --[[KEEP POSITION]])
        for i = 1, #items.tattoos do
            local tat = items.tattoos[i]
            local tattoo = NativeUI.CreateItem(tat.LocalizedName, "Zone: " .. tat.Zone .. ", Price: $" .. comma_value(tat.Price))
            tattoo.Activated = function(pmenu, selected)
                local hashname = tat.HashNameMale
                if IsPedModel(GetPlayerPed(-1), "mp_m_freemode_01") then
                    hashname = tat.HashNameMale
                elseif IsPedModel(GetPlayerPed(-1), "mp_f_freemode_01") then
                    hashname = tat.HashNameFemale
                else
                    hashname = tat.HashNameMale
                end
                ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(items.category), GetHashKey(hashname))
                table.insert(purchased_tattoos, {category = items.category, human_readable_name = tat.LocalizedName, hash_name = hashname})
            end
            category_submenu.SubMenu:AddItem(tattoo)
        end
    end

    MainMenu:AddItem(tattoos_submenu.SubMenu)

    ----------------------------------
    -- Checkout Tattoos Button --
    ----------------------------------
    local item = NativeUI.CreateItem("Checkout", "Purchase all selected tattoos")
    item.Activated = function(parentmenu, selected)
        MainMenu:Visible(false)
        if #purchased_tattoos > 0 then
          local business = exports["usa-businesses"]:GetClosestStore(15)
          TriggerServerEvent("tattoo:checkout", purchased_tattoos, business)
        else
            exports.globals:notify("No tattoos selected!")
            TriggerServerEvent("usa:loadPlayerComponents")
        end
    end
    MainMenu:AddItem(item)
    ----------------------------------
    -- Remove Tattoos Button --
    ----------------------------------
    local item = NativeUI.CreateItem("~r~Remove All Tattoos", "CAUTION: Removes all tattoos")
    item.Activated = function(parentmenu, selected)
        MainMenu:Visible(false)
        TriggerServerEvent("tattoo:removeTattoos")
    end
    MainMenu:AddItem(item)
    --------------------
    -- Exit Button --
    --------------------
    local item = NativeUI.CreateItem("Exit", "Exit the shop without checking out")
    item.Activated = function(parentmenu, selected)
        MainMenu:Visible(false)
        TriggerServerEvent("usa:loadPlayerComponents")
    end
    MainMenu:AddItem(item)

    _menuPool:RefreshIndex()
end)

----------------------------------------
-- SHOP DETECTION LOOP --
----------------------------------------
Citizen.CreateThread(function()
  -- listen for btn press --
  while true do
    local me = GetPlayerPed(-1)
    local player_coords = GetEntityCoords(me)
    ----------------------
    -- process menu --
    ----------------------
    _menuPool:MouseControlsEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    _menuPool:ProcessMenus()
    ---------------------------
    -- open / close menu --
    ---------------------------
    for i = 1, #SHOPS do
        if not MainMenu:Visible() then
          if Vdist(player_coords.x, player_coords.y, player_coords.z, SHOPS[i].x, SHOPS[i].y, SHOPS[i].z) < 3.0 then
            DrawText3D(SHOPS[i].x, SHOPS[i].y, SHOPS[i].z, "[E] - Tattoo Shop")
            if IsControlJustPressed(1, MENU_KEY) and not IsPedDeadOrDying(me) then
                closest_shop = SHOPS[i]
                MainMenu:Visible(true)
                RemoveClothes()
                --ClearPedDecorations(me)
                purchased_tattoos = {}
            end
          end
        end
      if closest_shop then
        if Vdist(player_coords.x, player_coords.y, player_coords.z, closest_shop.x, closest_shop.y, closest_shop.z) >= 3.0 then
          closest_shop = nil
          TriggerServerEvent("usa:loadPlayerComponents")
          if _menuPool:IsAnyMenuOpen() then
              _menuPool:CloseAllMenus()
          end
        end
      end
    end
    --drawMarkers()
    Wait(0)
  end
end)

----------------------
---- Set up blips ----
----------------------
for i = 1, #SHOPS do
    TriggerEvent("usa_map_blips:addMapBlip", {SHOPS[i].x, SHOPS[i].y, SHOPS[i].z}, 75, 4, 0.8, 1, true, 'Tattoo Shop', 'tattoo_shops') --coords, sprite, display, scale, color, shortRange, name, groupName)
end