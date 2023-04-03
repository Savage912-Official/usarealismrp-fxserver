local LOCATIONS = {
    {x = 1986.0, y = 3054.3, z = 47.3}, -- yellow jack
    {x = -560.2, y = 286.7, z = 82.3}, -- tequilala
    {x = -1400.6872558594, y = -598.57208251953, z = 30.319957733154}, -- bahama mamas
    {x = 127.4, y = -1284.6, z = 29.3}, -- vanilla unicorn
    {x = -435.6, y = 273.24, z = 83.42}, -- comedy club
    {x = -1577.31, y = -3018.51, z = -79.01}, -- night club
    {x = -1582.92, y = -3013.31, z = -76.0}, -- night club upper
    {x = -1435.8010253906,y = 205.99688720703, z = 57.82116317749}, -- hank alabaster's requested location (playboy mansion)
    {x = -3022.3759765625,y = 39.504207611084, z = 10.117781639099},
    {x = 1110.4865722656,y = 207.48405456543, z = -49.440128326416}, -- diamond casino
    {x = 4904.83203125, y = -4941.8154296875, z = 3.379533290863}, -- Cayo Perico island
    {x = -233.02548217773, y = -1498.24609375, z = 29.13104057312}, -- chamberlain hills community center (addon MLO)
    {x = -1293.1474609375, y = -297.61184692383, z = 36.050827026367}, -- arcade
    {x = 987.72308349609, y = -95.18229675293, z = 74.845748901367}, -- outlaw biker
    {x = 2511.150390625, y = 4097.0048828125, z = 38.584575653076}, -- lunatix biker
    {x = -536.58551025391, y = -611.26580810547, z = 34.681777954102}, -- MLO Mall Bar
    -- {x = -584.31604003906, y = -1060.4056396484, z = 22.344203948975}, -- Cat Cafe Bar (UwU Cafe)
    {x = -434.47225952148, y = -32.409156799316, z = 40.875095367432}, --Cockatoos Downstairs Bar
    {x = -192.63305664063, y = -1337.0927734375, z = 34.989784240723} --Cookie Jar
}

local locationsData = {}
for i = 1, #LOCATIONS do
  table.insert(locationsData, {
	coords = vector3(LOCATIONS[i].x, LOCATIONS[i].y, LOCATIONS[i].z),
	text = "[E] - Bar"
  })
end
exports.globals:register3dTextLocations(locationsData)

local ITEMS = {} -- loaded from server
TriggerServerEvent("bars:loadItems")

local MENU_OPEN_KEY = 38

local closest_bar = nil

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Bar", "~b~Welcome!", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(mainMenu)

RegisterNetEvent("bars:loadItems")
AddEventHandler("bars:loadItems", function(items)
  ITEMS = items
  -----------------
  -- Create Menu --
  -----------------
  CreateBarMenu(mainMenu)
  _menuPool:RefreshIndex()
end)

function CreateBarMenu(menu)
    for category, items in pairs(ITEMS) do
        local submenu = _menuPool:AddSubMenu(menu, category, "See our selection of " .. string.lower(category), true --[[KEEP POSITION]])
        for name, info in pairs(items) do
            local item = NativeUI.CreateItem(name, "($" .. comma_value(info.price) .. ") " .. (info.caption or ""))
            item.Activated = function(parentmenu, selected)
              local business = exports["usa-businesses"]:GetClosestStore(15)
              TriggerServerEvent("bars:buy", category, name, business)
            end
            submenu.SubMenu:AddItem(item)
        end
    end
end

Citizen.CreateThread(function()
  while true do
    Wait(0)
    local me = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(me, false)

    _menuPool:MouseControlsEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    _menuPool:ProcessMenus()

		if IsControlJustPressed(1, MENU_OPEN_KEY) then
      for i = 1, #LOCATIONS do
        if Vdist(playerCoords, LOCATIONS[i].x, LOCATIONS[i].y, LOCATIONS[i].z) < 2.0 then
					closest_bar = LOCATIONS[i] --// set shop player is at
					if not _menuPool:IsAnyMenuOpen() then
            mainMenu:Visible(true)
            break
					else
						_menuPool:CloseAllMenus()
					end
        end
      end
		end

		if _menuPool:IsAnyMenuOpen() then
      if Vdist(playerCoords, closest_bar.x, closest_bar.y, closest_bar.z) > 3.0 then
				closest_bar = nil
				_menuPool:CloseAllMenus()
      end
		end
  end
end)

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

function DrawText3D(x, y, z, distance, text)
  if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) < distance then
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 470
    DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
  end
end
