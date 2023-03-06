local MENU_KEY = 38 -- "E"

local ITEMS = { -- must be kept in sync with one in sv_bike-shop.lua --
  {name = "BMX", price = 250, hash = 1131912276},
  {name = "Cruiser", price = 300, hash = 448402357},
  {name = "Fixster", price = 350, hash = -836512833},
  {name = "Scorcher", price = 500, hash = -186537451},
  {name = "TriBike", price = 550, hash = 1127861609},
  {name = "Low Rider Bike", price = 5000, hash = GetHashKey("lowriderb")}
}

local locations = {
	{ x = 125.1, y = 6629.6, z = 32.0, heading = 210.0 }, -- paleto
  {x = -1107.0, y = -1693.8, z = 4.4, heading = 320.0}, -- LS beach
  {x = 1508.9, y = 3769.7, z = 34.2, heading = 180.0}, -- sandy
  {x = 217.9, y = -868.8, z = 30.5, heading = -95.0}, -- ls legion square
  --{x = 220.78, y = -901.84, z = 30.69, heading = 160.0},
  {x = -1484.7, y = -675.58, z= 28.94, heading = 13.5},
  {x = 1853.91, y = 2581.94, z= 45.67, heading = 13.5}, -- Prison
  {x = -563.33245849609, y = -638.17126464844, z = 33.797878265381, heading = 304.0},
}

local closest = nil

local locationsData = {}
for i = 1, #locations do
  table.insert(locationsData, {
    coords = vector3(locations[i].x, locations[i].y, locations[i].z),
    text = "[E] - Bike Shop"
  })
end
exports.globals:register3dTextLocations(locationsData)

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

function isPlayerAtBikeShop()
	local playerCoords = GetEntityCoords(GetPlayerPed(-1) --[[Ped]], false)
	for i = 1, #locations do
		if GetDistanceBetweenCoords(playerCoords.x,playerCoords.y,playerCoords.z,locations[i].x,locations[i].y,locations[i].z,true) < 2.0 then
            closest = locations[i]
			return true
		end
	end
	return false
end

----------------------
-- Set up main menu --
----------------------
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Bike Shop", "~b~Welcome!", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(mainMenu)

function CreateItemList(menu)
  ---------------------------------------------
  -- Button for each weapon in each category --
  ---------------------------------------------
  for i = 1, #ITEMS do
    local item = NativeUI.CreateItem(ITEMS[i].name, "Purchase price: $" .. comma_value(ITEMS[i].price))
    item.Activated = function(parentmenu, selected)
      TriggerServerEvent("bikeShop:requestPurchase", i, closest)
    end
    menu:AddItem(item)
  end
end

----------------
-- add to GUI --
----------------
CreateItemList(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
    -- Process Menu --
    _menuPool:MouseControlsEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    _menuPool:ProcessMenus()
    -------------------
    -- draw help txt --
    -------------------
    if not isPlayerAtBikeShop() then
      if mainMenu:Visible() then
        mainMenu:Visible(false)
      end
    end
    --------------------------
    -- Listen for menu open --
    --------------------------
		if IsControlJustPressed(1, MENU_KEY) then
			if isPlayerAtBikeShop() then
        mainMenu:Visible(not mainMenu:Visible())
			end
		end
	end
end)

RegisterNetEvent("bikeShop:toggleMenu")
AddEventHandler("bikeShop:toggleMenu", function(toggle)
  mainMenu:Visible(toggle)
end)

RegisterNetEvent("bikeShop:spawnBike")
AddEventHandler("bikeShop:spawnBike", function(bike, location, plate)
  -- thread code stuff below was taken from an example on the wiki
  -- Create a thread so that we don't 'wait' the entire game
  Citizen.CreateThread(function()
    -- Request the model so that it can be spawned
    RequestModel(bike.hash)
    -- Check if it's loaded, if not then wait and re-request it.
    while not HasModelLoaded(bike.hash) do
      Citizen.Wait(100)
    end
    -- Model loaded, continue
    -- Spawn the vehicle at the gas station car dealership in paleto and assign the vehicle handle to 'vehicle'
    local vehicle = CreateVehicle(bike.hash, location.x, location.y, location.z, 0.0 --[[Heading]], true --[[Networked, set to false if you just want to be visible by the one that spawned it]], false --[[Dynamic]])
    TriggerEvent('persistent-vehicles/register-vehicle', vehicle)
    SetVehicleNumberPlateText(vehicle, plate)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
  end)
end)

local shopNPCHandles = {}
local NPC_PED_MODEL = -771835772
Citizen.CreateThread(function()
  while true do
    local playerCoords = GetEntityCoords(PlayerPedId(), false)
    for i = 1, #locations do
      if Vdist(playerCoords, locations[i].x, locations[i].y, locations[i].z) < 75 then
          if not shopNPCHandles[i] then
              RequestModel(NPC_PED_MODEL)
              while not HasModelLoaded(NPC_PED_MODEL) do
                  Wait(1)
              end
              shopNPCHandles[i] = CreatePed(0, NPC_PED_MODEL, locations[i].x, locations[i].y, locations[i].z - 0.5, locations[i].heading, false, false) -- need to add distance culling
              SetEntityCanBeDamaged(shopNPCHandles[i],false)
              SetPedCanRagdollFromPlayerImpact(shopNPCHandles[i],false)
              SetBlockingOfNonTemporaryEvents(shopNPCHandles[i],true)
              SetPedFleeAttributes(shopNPCHandles[i],0,0)
              SetPedCombatAttributes(shopNPCHandles[i],17,1)
              SetPedRandomComponentVariation(shopNPCHandles[i], true)
              TaskStartScenarioInPlace(shopNPCHandles[i], "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
          end
      else 
          if shopNPCHandles[i] then
              DeletePed(shopNPCHandles[i])
              shopNPCHandles[i] = nil
          end
      end
    end
    Wait(1)
  end
end)
