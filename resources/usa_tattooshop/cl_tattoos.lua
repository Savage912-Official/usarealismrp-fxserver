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

-- local TATTOOS = nil

local closest_shop = nil
local MENU_KEY = 38


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

----------------------------------------
-- SHOP DETECTION LOOP --
----------------------------------------
Citizen.CreateThread(function()
  -- listen for btn press --
    while true do
        Wait(1)
        local me = GetPlayerPed(-1)
        local player_coords = GetEntityCoords(me)
        
        for i = 1, #SHOPS do
            if Vdist(player_coords.x, player_coords.y, player_coords.z, SHOPS[i].x, SHOPS[i].y, SHOPS[i].z) < 3.0 then
                DrawText3D(SHOPS[i].x, SHOPS[i].y, SHOPS[i].z, "[E] - Tattoo Shop")
                if IsControlJustPressed(1, MENU_KEY) then
                    closest_shop = SHOPS[i] --// set shop player is at
                    local config = {
                        ped = false,
                        headBlend = false,
                        faceFeatures = false,
                        headOverlays = false,
                        components = false,
                        props = false,
                        tattoos = true,
                        skipTattooSetOnExit = false,
                        skipModelSetOnExit = false
                    }
                    local prev_app = exports['fivem-appearance']:getPedAppearance(PlayerPedId())
                    local prev_tat = exports['fivem-appearance']:getPedTattoos(PlayerPedId())
                    local prev_tat_count = 0
                    for k,v in pairs(prev_tat) do
                        prev_tat_count = prev_tat_count + #v
                    end
                    exports['fivem-appearance']:startPlayerCustomization(function (appearance)
                        if (appearance) then
                            local business = exports["usa-businesses"]:GetClosestStore(30)
                            local new_tat = exports['fivem-appearance']:getPedTattoos()
                            local new_tat_count = 0
                            for k,v in pairs(new_tat) do
                                new_tat_count = new_tat_count + #v
                            end
                            local tat_diff = new_tat_count - prev_tat_count
                            TriggerServerEvent("tattoo:save", appearance, business, tat_diff, prev_app)
                        else
                            TriggerEvent("spawn:loadCustomizations", prev_app)
                        end
                    end, config)
                end
            else
                if closest_shop == SHOPS[i] then
                    closest_shop = nil
                end
            end
        end
    end
end)

----------------------
---- Set up blips ----
----------------------
for i = 1, #SHOPS do
    TriggerEvent("usa_map_blips:addMapBlip", {SHOPS[i].x, SHOPS[i].y, SHOPS[i].z}, 75, 4, 0.8, 1, true, 'Tattoo Shop', 'tattoo_shops') --coords, sprite, display, scale, color, shortRange, name, groupName)
end