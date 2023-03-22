local MENU_KEY = 38 -- "E"

local closest = nil

local locationsData = {}
for i = 1, #Config.Shop_Locations do
  table.insert(locationsData, {
    coords = vector3(Config.Shop_Locations[i].x, Config.Shop_Locations[i].y, Config.Shop_Locations[i].z),
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
	for i = 1, #Config.Shop_Locations do
		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, Config.Shop_Locations[i].x, Config.Shop_Locations[i].y, Config.Shop_Locations[i].z, true) < 2.0 then
      closest = Config.Shop_Locations[i]
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
  for i = 1, #Config.Bikes do
    local item = NativeUI.CreateItem(Config.Bikes[i].name, "Purchase price: $" .. comma_value(Config.Bikes[i].price))
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
    for i = 1, #Config.Shop_Locations do
      if Vdist(playerCoords, Config.Shop_Locations[i].x, Config.Shop_Locations[i].y, Config.Shop_Locations[i].z) < 75 then
        if not shopNPCHandles[i] then
          RequestModel(NPC_PED_MODEL)
          while not HasModelLoaded(NPC_PED_MODEL) do
            Wait(1)
          end
          shopNPCHandles[i] = CreatePed(0, NPC_PED_MODEL, Config.Shop_Locations[i].x, Config.Shop_Locations[i].y, Config.Shop_Locations[i].z - 0.5, Config.Shop_Locations[i].heading, false, false) -- need to add distance culling
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