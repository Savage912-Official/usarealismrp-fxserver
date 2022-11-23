--# made by: minipunch
--# for: USA REALISM RP

local BARBER_SHOPS = {
  {x = -279.154, y = 6226.192, z = 31.705}, -- paleto,
  {x = -34.519523620605, y = -152.94702148438, z = 57.076740264893}, -- Hawick
  {x = 1213.0939941406, y = -474.31896972656, z = 66.20824432373}, -- Mirror Park
  {x = 1932.3427734375, y = 3731.9072265625, z = 32.844657897949}, -- Sandy Shores
  {x = -1281.9802246094, y = -1119.6861572266, z = 7.0001249313354}, -- Baycity Ave
  {x = 139.21583557129, y = -1708.9689941406, z = 29.301620483398}, -- Carson Ave
  {x = -815.59008789063, y = -182.16806030273, z = 37.568920135498}, -- Mad Wayne Thunder Drive
  {x = -557.18505859375, y = -585.46990966797, z = 41.430267333984} -- Mall Barber #2
}

for i = 1, #BARBER_SHOPS do -- place map blips
  TriggerEvent("usa_map_blips:addMapBlip", {BARBER_SHOPS[i].x, BARBER_SHOPS[i].y, BARBER_SHOPS[i].z}, 71, 4, 0.8, 13, true, 'Barber Shop', 'barber_shops') --coords, sprite, display, scale, color, shortRange, name, groupName)
end

local purchases = {}

local closest_shop = nil --// keep track of closest shop to help keep track of shop player is currently at

local MENU_OPEN_KEY = 38

local MAX_EYE_COLORS = 31
local MAX_PARENT_OPTIONS = 45
local MAX_COLOR_OPTIONS = 85

-- Draw Markers / Help Text / Listen for menu open key press --
Citizen.CreateThread(function()
  local openedMenu = false
  while true do
      Wait(1)
      -- vars --
      local me = GetPlayerPed(-1)
      local playerCoords = GetEntityCoords(me, false)

    for i = 1, #BARBER_SHOPS do
        if Vdist(playerCoords.x,playerCoords.y,playerCoords.z,BARBER_SHOPS[i].x,BARBER_SHOPS[i].y,BARBER_SHOPS[i].z)  <  3 then
            DrawText3D(BARBER_SHOPS[i].x,BARBER_SHOPS[i].y,BARBER_SHOPS[i].z, '[E] - Barber Shop (~g~$70.00~s~)')
            if IsControlJustPressed(1, MENU_OPEN_KEY) then
                closest_shop = BARBER_SHOPS[i] --// set shop player is at
                local config = {
                  ped = false,
                  headBlend = true,
                  faceFeatures = true,
                  headOverlays = true,
                  components = false,
                  props = false,
                  tattoos = false,
                  skipTattooSetOnExit = true,
                  skipModelSetOnExit = true
                }
                exports['fivem-appearance']:startPlayerCustomization(function (appearance)
                  if (appearance) then
                    local business = exports["usa-businesses"]:GetClosestStore(30)
                    TriggerServerEvent("barber:save", appearance, business)
                  else
                    print('Canceled')
                  end
                end, config)
            end
        else
            if closest_shop == BARBER_SHOPS[i] then
                closest_shop = nil
            end
        end
    end
  end
end)

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

RegisterNetEvent("barber:loadCustomizations")
AddEventHandler("barber:loadCustomizations", function(customizations)
  exports["fivem-appearance"]:setPlayerAppearance(customizations)
end)