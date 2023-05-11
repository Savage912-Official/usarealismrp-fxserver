--# by minipunch
--# for USA REALISM rp
--# Made for the 24/7 stores as general stores for various items

local GENERAL_STORE_LOCATIONS = Config.GENERAL_STORE_LOCATIONS
local HARDWARE_STORE_LOCATIONS = Config.HARDWARE_STORE_LOCATIONS

local ShopliftingAreas = {}

RegisterNetEvent('generalStore:loadShopliftAreas')
AddEventHandler('generalStore:loadShopliftAreas', function(areas)
  ShopliftingAreas = areas
end)

TriggerServerEvent('generalStore:loadShopliftAreas')

--------------------
-- Spawn job peds --
--------------------
local JOB_PEDS = { -- Z coords are Z-1 or the ped will float!
  --{x = -331.043, y = 6086.09, z = 30.40, heading = 180.0}
  --[[
  {x = 1727.7, y = 6415.6, z = 34.03, heading = 250.0},
  {x = 549.2, y = 2670.9, z = 41.2, heading = 95.0, hash = -573920724}, -- harmony
  {x = 1165.9, y = 2710.9, z = 37.2, heading = 180.0, hash = -573920724}, -- harmony
  {x = 1959.96, y = 3740.2, z = 32.3, heading = 300.0, hash = -573920724}, -- sandy shores
  {x = -3242.6, y = 999.9, z = 11.83, heading = 320.0, hash = -573920724}, -- north west los santos coast
  {x = -3039.1, y = 584.5, z = 6.9, heading = 30.0, hash = -573920724}, -- north west los santos coast
  {x = -2966.1, y = 390.8, z = 15.0, heading = 85.0, hash = -573920724}, -- north west los santos coast
  {x = 372.5, y = 326.7, z = 102.6, heading = 250.0, hash = -573920724}, -- los santos
  {x = -1221.7, y = -908.5, z = 11.3, heading = 40.0, hash = -573920724}, -- los santos
  {x = 1133.9, y = -982.6, z = 46.2, heading = 260.0, hash = -573920724}, -- los santos
  {x = -47.0, y = -1758.6, z = 28.4, heading = 90.0}, -- los santos
  {x = 24.34, y = -1347.215, z = 28.49, heading = 270.0}, -- los santos
  {x = -705.99, y = -914.53, z = 18.21, heading = 95.55}, -- los santos
  {x = 1697.088, y = 4923.35, z = 41.06, heading = 322.0}, -- los santos
  {x = 1165.02, y = -323.60, z = 68.2, heading = 95.0}, -- los santos
  {x = 2557.145, y = 380.64, z = 107.62, heading = 350.0, hash = -573920724}, -- sandy
  {x = 2677.729, y = 3279.42, z = 54.24, heading = 330.0, hash = -573920724}, -- senora fwy
  {x = -1819.304, y = 793.56, z = 137.088, heading = 132.0}, -- richman
  --]]
  {x = 1335.4675292969, y = -1651.5319824219, z = 51.249050140381, heading = 40.0},
  {x = -547.81866455078, y = -582.59674072266, z = 34.681812286377, heading = 180.0}
}

local BLIPS = {}
local GENERAL_STORE_ITEMS = {} -- loaded from server
local HARDWARE_STORE_ITEMS = {}

local MENU_KEY = 38

local TIMEOUT = nil

-------------------
-- utility funcs --
-------------------
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

function IsNearStore(store)
  local mycoords = GetEntityCoords(GetPlayerPed(-1))
  if Vdist(store.x, store.y, store.z, mycoords.x, mycoords.y, mycoords.z) < 1.7 then
    return true
  else
    return false
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
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
end

----------------------
---- Set up blips ----
----------------------
for i = 1, #GENERAL_STORE_LOCATIONS do
  if not GENERAL_STORE_LOCATIONS[i].prison then
    TriggerEvent("usa_map_blips:addMapBlip", {GENERAL_STORE_LOCATIONS[i].x, GENERAL_STORE_LOCATIONS[i].y, GENERAL_STORE_LOCATIONS[i].z}, 52, 4, 0.7, 36, true, 'General Store', 'general_stores') --coords, sprite, display, scale, color, shortRange, name, groupName)
  end
end
for i = 1, #HARDWARE_STORE_LOCATIONS do
    TriggerEvent("usa_map_blips:addMapBlip", {HARDWARE_STORE_LOCATIONS[i].x, HARDWARE_STORE_LOCATIONS[i].y, HARDWARE_STORE_LOCATIONS[i].z}, 473, 4, 0.7, 64, true, 'Hardware Store', 'hardware_stores') --coords, sprite, display, scale, color, shortRange, name, groupName)
end

local NEARBY_GENERAL_STORE_LOCATIONS = {}
local NearbyShopliftingAreas = {}
local NEARBY_HARDWARE_STORE_LOCATIONS = {}

Citizen.CreateThread(function()
  while true do
    local mycoords = GetEntityCoords(GetPlayerPed(-1))

    for i = 1, #GENERAL_STORE_LOCATIONS do
      local dist = Vdist(mycoords.x, mycoords.y, mycoords.z, GENERAL_STORE_LOCATIONS[i].x, GENERAL_STORE_LOCATIONS[i].y, GENERAL_STORE_LOCATIONS[i].z)
      if dist < 5 then
        NEARBY_GENERAL_STORE_LOCATIONS[i] = true
      else
        NEARBY_GENERAL_STORE_LOCATIONS[i] = nil
      end
    end

    for i = 1, #ShopliftingAreas do
      local dist = Vdist(mycoords.x, mycoords.y, mycoords.z, ShopliftingAreas[i].x, ShopliftingAreas[i].y, ShopliftingAreas[i].z)
      if dist < 1.5 then
        NearbyShopliftingAreas[i] = true
      else
        NearbyShopliftingAreas[i] = nil
      end
    end

    for i = 1, #HARDWARE_STORE_LOCATIONS do
      local dist = Vdist(mycoords.x, mycoords.y, mycoords.z, HARDWARE_STORE_LOCATIONS[i].x, HARDWARE_STORE_LOCATIONS[i].y, HARDWARE_STORE_LOCATIONS[i].z)
      if dist < 7 then
        NEARBY_HARDWARE_STORE_LOCATIONS[i] = true
      else
        NEARBY_HARDWARE_STORE_LOCATIONS[i] = nil
      end
    end

    Wait(500)
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(1)
    local mycoords = GetEntityCoords(GetPlayerPed(-1))
    for index, isNearby in pairs(NEARBY_GENERAL_STORE_LOCATIONS) do
      DrawText3D(GENERAL_STORE_LOCATIONS[index].x, GENERAL_STORE_LOCATIONS[index].y, GENERAL_STORE_LOCATIONS[index].z, '[E] - General Store')
    end

    for index, isNearby in pairs(NearbyShopliftingAreas) do
      exports.globals:DrawText3D(ShopliftingAreas[index].x, ShopliftingAreas[index].y, ShopliftingAreas[index].z, '[E] - Shoplift')
      if IsControlJustPressed(1, MENU_KEY) then
        if IsNearStore(ShopliftingAreas[index]) then
          TriggerServerEvent('generalStore:attemptShoplift', index)
        end
      end
    end

    for index, isNearby in pairs(NEARBY_HARDWARE_STORE_LOCATIONS) do
      DrawText3D(HARDWARE_STORE_LOCATIONS[index].x, HARDWARE_STORE_LOCATIONS[index].y, HARDWARE_STORE_LOCATIONS[index].z, '[E] - Hardware Store')
    end

    if IsControlJustPressed(1, MENU_KEY) then
      -- see if close to any stores --
      for i = 1, #GENERAL_STORE_LOCATIONS do
        if IsNearStore(GENERAL_STORE_LOCATIONS[i]) then
          TriggerEvent("stores:openMenu")
        end
      end
      for i = 1, #HARDWARE_STORE_LOCATIONS do
        if IsNearStore(HARDWARE_STORE_LOCATIONS[i]) then
          TriggerEvent("stores:openMenu")
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    local playerCoords = GetEntityCoords(PlayerPedId(), false)
    for i = 1, #JOB_PEDS do
      if Vdist(JOB_PEDS[i].x, JOB_PEDS[i].y, JOB_PEDS[i].z, playerCoords.x, playerCoords.y, playerCoords.z) < 60 then
        if not JOB_PEDS[i].pedHandle then
          local hash = -840346158
          if JOB_PEDS[i].hash then
            hash = JOB_PEDS[i].hash
          end
          RequestModel(hash)
          while not HasModelLoaded(hash) do
            RequestModel(hash)
            Wait(0)
          end
          local ped = CreatePed(4, hash, JOB_PEDS[i].x, JOB_PEDS[i].y, JOB_PEDS[i].z, JOB_PEDS[i].heading, false, true)
          SetEntityCanBeDamaged(ped,false)
          SetPedCanRagdollFromPlayerImpact(ped,false)
          TaskSetBlockingOfNonTemporaryEvents(ped,true)
          SetPedFleeAttributes(ped,0,0)
          SetPedCombatAttributes(ped,17,1)
          SetPedRandomComponentVariation(ped, true)
          TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
          JOB_PEDS[i].pedHandle = ped
        end
      else
        if JOB_PEDS[i].pedHandle then
          DeletePed(JOB_PEDS[i].pedHandle)
          JOB_PEDS[i].pedHandle = nil
        end
      end
    end
    Wait(100)
  end
end)

RegisterNetEvent('generalStore:performShoplift')
AddEventHandler('generalStore:performShoplift', function(area)
  local beginTime = GetGameTimer()
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)
  local SHOPLIFT_ANIMATION_TIME_SECONDS = 10

  if math.random() < 0.2 then -- 20% chance to call police
    local x, y, z = table.unpack(playerCoords)
    local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
    local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
    local isMale = true
    if GetEntityModel(playerPed) == GetHashKey("mp_f_freemode_01") then
      isMale = false
    elseif GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01") then
      isMale = true
    else
      isMale = IsPedMale(playerPed)
    end
    TriggerServerEvent("911:Shoplifting", x, y, z, lastStreetNAME, isMale)
  end

  exports.globals:loadAnimDict("anim@am_hold_up@male") -- play animation
  while GetGameTimer() - beginTime < SHOPLIFT_ANIMATION_TIME_SECONDS * 1000 do
    exports.globals:DrawTimerBar(beginTime, SHOPLIFT_ANIMATION_TIME_SECONDS * 1000, 1.42, 1.475, 'Stealing')
    if not IsEntityPlayingAnim(playerPed, "anim@am_hold_up@male", "shoplift_mid", 3) then
      TaskPlayAnim(playerPed, "anim@am_hold_up@male", "shoplift_mid", 8.0, 1.0, SHOPLIFT_ANIMATION_TIME_SECONDS * 1000, 11, 1.0, false, false, false)
    end
    DisableControlAction(0, 86, true) -- disable spamming E
    Wait(1)
  end
  ClearPedTasks(playerPed)

  TriggerServerEvent('generalStore:giveStolenItem') -- give item
end)

RegisterNetEvent('generalStore:markAsShoplifted')
AddEventHandler('generalStore:markAsShoplifted', function(area)
  ShopliftingAreas[area].shoplifted = true
end)
