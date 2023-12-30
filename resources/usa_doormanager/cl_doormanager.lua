--# by: minipunch
--# for USA REALISM rp
--# This script keeps a server sided track of frozen states on objects like doors or gates that can be toggled by being in the activation area and pressing "E"

local DOORS_TO_MANAGE = {} -- loaded from server file on start of resource

local LOCK_KEY = 38 -- "E"
local ACTIVATE_LOCK_SWITCH_DISTANCE = 1.5
local KEY_PRESS_DELAY = 1000
local DRAW_MARKER_RANGE = 50
local LOCK_TIMEOUT_SECONDS = 300
local LOCKING_TEXT_MAX_DISTANCE = 75.0
local DEBUG = false
local doorsBeingLocked = {}
local doorRadius = 1.0
local drawTextRange = 2.0

local NEARBY_DOOR_CHECK_SECONDS = 1

local FIRST_JOIN = true

local playerPed = GetPlayerPed(-1)
local playerCoords = GetEntityCoords(playerPed)

local lastRecordedNearbyDoors = {}

RegisterNetEvent("doormanager:debug")
AddEventHandler("doormanager:debug", function()
  DEBUG = not DEBUG
end)

RegisterNetEvent("doormanager:update")
AddEventHandler("doormanager:update", function(doors)
  DOORS_TO_MANAGE = doors
  --SpawnAllPrisonCellDoors(DOORS_TO_MANAGE)
end)

-- manage doors during certain hours --
Citizen.CreateThread(function()
  while true do
      for i = 1, #DOORS_TO_MANAGE do
        local door = DOORS_TO_MANAGE[i]
        if door.unlockedAfter then
          if door.locked and GetClockHours() > door.unlockedAfter then -- needs to be unlocked
            TriggerServerEvent('doormanager:forceToggleLock', i)
          elseif not door.locked and GetClockHours() <= door.unlockedAfter then -- needs to be locked
            TriggerServerEvent('doormanager:forceToggleLock', i)
          end
        end
        Wait(10)
      end
      Wait(30000)
  end
end)

-- delete horrible sliding cell doors so we can replace with better ones --
Citizen.CreateThread(function()
  while true do
    local me = PlayerPedId()
    local myCoords = GetEntityCoords(me)
    for i = 1, #DOORS_TO_MANAGE do
      local door = DOORS_TO_MANAGE[i]
      if door.cell_block then
        if Vdist2(myCoords, door.x, door.y, door.z) < 500.0 then
          local doorObject = GetClosestObjectOfType(door.x, door.y, door.z, 1.0, door.model, false, false, false)
          if DoesEntityExist(doorObject) then
            -- print("deleting cell door!")
            SetEntityAsMissionEntity(doorObject, true, true)
            DeleteEntity(doorObject)
          end
        end
      end
    end
    Wait(4000)
  end
end)

-- custom prison cell door lock / unlock system since the default sliding gates are horrible --
Citizen.CreateThread(function()
  while true do
    local me = PlayerPedId()
    local myCoords = GetEntityCoords(me)
    for i = 1, #DOORS_TO_MANAGE do
      local door = DOORS_TO_MANAGE[i]
      if door.cell_block then
        if Vdist2(myCoords, door.x, door.y, door.z) < 1000.0 then
          if door.locked then
            MakeSureCellDoorPropExists(door)
          else
            MakeSureCellDoorPropDeleted(door)
          end
        end
      end
    end
    Wait(1500)
  end
end)

----------------------------------------------------------------------------------------
-- LOAD STATE OF DOORS ON FIRST JOIN / DRAW 3D TEXT / LISTEN FOR DOOR TOGGLE KEYPRESS --
----------------------------------------------------------------------------------------
Citizen.CreateThread(function()

  local NEARBY_THRESHOLD = 100
  local lastFetch = GetGameTimer()

  while true do
    while GetGameTimer() - lastFetch < NEARBY_DOOR_CHECK_SECONDS * 1000 do
      Wait(1)
    end
    lastFetch = GetGameTimer()
    local mycoords = GetEntityCoords(PlayerPedId())
    lastRecordedNearbyDoors = {}
    for i = 1, #DOORS_TO_MANAGE do
      local door = DOORS_TO_MANAGE[i]
      if door.x then
        if Vdist(door.x, door.y, door.z, mycoords) <= NEARBY_THRESHOLD then
          table.insert(lastRecordedNearbyDoors, i)
        end
      end
    end
    Wait(1)
  end
end)

local loopCheckIn = nil
local removingDoor = false

function doorLoop()
  Citizen.CreateThread(function()
    local lastKeyPress = 0
    while true do
      Wait(1)
      loopCheckIn = GetGameTimer()
      if not removingDoor then
        if FIRST_JOIN then
          TriggerServerEvent("doormanager:firstJoin")
          FIRST_JOIN = false
        end

        playerPed = GetPlayerPed(-1)
        playerCoords = GetEntityCoords(playerPed)
        
        if IsControlJustPressed(1, LOCK_KEY) and GetGameTimer() - lastKeyPress > KEY_PRESS_DELAY then
          lastKeyPress = GetGameTimer()
          for i = 1, #DOORS_TO_MANAGE do
            if removingDoor then
              break
            end
            local door = DOORS_TO_MANAGE[i]
            if not doorsBeingLocked[door.name] and Vdist(door.x, door.y, door.z, playerCoords.x, playerCoords.y, playerCoords.z) <= door._dist and not door.static then
              PlayLockAnim()
              Citizen.Wait(400)
              TriggerServerEvent("doormanager:checkDoorLock", i, door.x, door.y, door.z)
              --if SOUND_ENABLE then TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 1.2, "cell-lock", 0.2) end
            end
          end
        end

        for i = 1, #lastRecordedNearbyDoors do
          if removingDoor then
            break
          end
          local index = lastRecordedNearbyDoors[i]
          local door = DOORS_TO_MANAGE[index]
          doorRadius = 1.0
          drawTextRange = 2.0
          if door.gate then drawTextRange = 7.0 doorRadius = 6.0 end
          if Vdist(door.x, door.y, door.z, playerCoords.x, playerCoords.y, playerCoords.z) < drawTextRange then
            if not door.static and door.offset and not doorsBeingLocked[door.name] then
              local doorObject = GetClosestObjectOfType(door.x, door.y, door.z, doorRadius, door.model, false, false, false)
              local doorCoords = GetEntityCoords(doorObject)
              if not door.gate then
                --print("heading: " .. GetEntityHeading(doorObject))
                local offsetX, offsetY, offsetZ = table.unpack(door.offset)
                local angle = math.rad(180+GetEntityHeading(doorObject))
                local x=doorCoords.x+offsetY*math.cos(angle)
                local y=doorCoords.y+offsetY*math.sin(angle)
                if door.locked then DrawText3Ds(x+offsetX, y, doorCoords.z+offsetZ, "[E] - Locked") else DrawText3Ds(x+offsetX, y, doorCoords.z+offsetZ, "[E] - Unlocked") end
              else
                local offsetX, offsetY, offsetZ = table.unpack(door.offset)
                local x, y, z = table.unpack(doorCoords)
                --print(doorCoords)
                if door.locked and not doorsBeingLocked[door.name] then DrawText3Ds(x+offsetX, y+offsetY, z+offsetZ, "[E] - Locked") else DrawText3Ds(x+offsetX, y+offsetY, z+offsetZ, "[E] - Unlocked") end
              end
            elseif not door.static and not doorsBeingLocked[door.name] and not door.offset then
              if door.locked then
                DrawText3Ds(door.x, door.y, door.z, "[E] - Locked")
              else
                DrawText3Ds(door.x, door.y, door.z, "[E] - Unlocked")
              end
            end
          end
        end
      else
        break
      end
    end
  end)
end

local loopStopped = false
RegisterNetEvent("doormanager:setRemovingDoor")
AddEventHandler("doormanager:setRemovingDoor", function(bool)
  if not bool then
    while not loopStopped do
      Citizen.Wait(1)
    end
    loopStopped = false
    removingDoor = bool
    doorLoop()
  else
    removingDoor = bool
    print("Do not worry if you see an error below this, its just staff removing a door")
  end
end)

loopCheckIn = GetGameTimer()
doorLoop()

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if loopCheckIn ~= nil then
      if GetGameTimer() - loopCheckIn > 1000 then
        loopStopped = true
      end
    end
  end
end)

------------------------------------------------------------------------------------
-- MAKE SURE DOORS STAY LOCKED (things like leaving the area would unlock things) --
------------------------------------------------------------------------------------
Citizen.CreateThread(function()
  while true do
    for i = 1, #lastRecordedNearbyDoors do
      local index = lastRecordedNearbyDoors[i]
      local door = DOORS_TO_MANAGE[index]
      if door.locked then
        if not door.cell_block and door.gate then doorRadius = 6.0 end
        if DEBUG then print("making sure door is locked: " ..door.name) end
        local doorObject = GetClosestObjectOfType(door.x, door.y, door.z, doorRadius, door.model, false, false, false)
        if doorObject then
          if DEBUG then print("ent: " .. doorObject) end
          if not doorsBeingLocked[door.name] then
            FreezeEntityPosition(doorObject, true)
          end
        end
      end
    end
  Wait(3000) -- check approx. every X seconds
  end
end)

RegisterNetEvent("doormanager:toggleDoorLock")
AddEventHandler("doormanager:toggleDoorLock", function(index, locked, x, y, z)
  local doorRadius = 5.0  
  local door = DOORS_TO_MANAGE[index]
  if door then
      if door.gate then
        doorRadius = 15.0
      end
      DOORS_TO_MANAGE[index].locked = locked
      if not door.cell_block then
        local doorObject = GetClosestObjectOfType(x, y, z, doorRadius, door.model, false, false, false)
        if locked and door.offset then
          doorsBeingLocked[door.name] = true
          local startedWaitingForLock = GetGameTimer()
          if not door.gate then
            while math.floor(GetEntityHeading(doorObject)) ~= door.heading do
              if DoesEntityExist(doorObject) then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local doorCoords = GetEntityCoords(doorObject)
                local offsetX, offsetY, offsetZ = table.unpack(door.offset)
                if Vdist(x, y, z, table.unpack(playerCoords)) < drawTextRange then
                  local angle = math.rad(180+GetEntityHeading(doorObject))
                  local r = offsetY
                  local x=doorCoords.x+r*math.cos(angle)
                  local y=doorCoords.y+r*math.sin(angle)
                  DrawText3Ds(x+offsetX, y, doorCoords.z+offsetZ, "Locking...")
                end
              else 
                doorObject = GetClosestObjectOfType(x, y, z, doorRadius, door.model, false, false, false)
                Wait(1000)
                if not DoesEntityExist(doorObject) then
                  if GetGameTimer() - startedWaitingForLock >= LOCK_TIMEOUT_SECONDS * 1000 then
                    break
                  end
                end
              end
              Wait(1)
            end
          else
            _x, _y, _z = table.unpack(door.lockedCoords)
            while GetDistanceBetweenCoords(GetEntityCoords(doorObject).x, GetEntityCoords(doorObject).y, GetEntityCoords(doorObject).z, _x, _y, _z, false) > 0.2 do
              if DoesEntityExist(doorObject) then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local doorCoords = GetEntityCoords(doorObject)
                local offsetX, offsetY, offsetZ = table.unpack(door.offset)
                if Vdist(x, y, z, table.unpack(playerCoords)) < 8.0 then
                  DrawText3Ds(doorCoords.x+offsetX, doorCoords.y+offsetY, doorCoords.z+offsetZ, 'Locking...')
                end
              else 
                doorObject = GetClosestObjectOfType(x, y, z, doorRadius, door.model, false, false, false)
                Wait(1000)
                if not DoesEntityExist(doorObject) then
                  if GetGameTimer() - startedWaitingForLock >= LOCK_TIMEOUT_SECONDS * 1000 then
                    break
                  end
                end
              end
              Wait(1)
            end
          end
          doorsBeingLocked[door.name] = nil
        end
        FreezeEntityPosition(doorObject, locked)
      else
        togglePrisonCellDoor(door)
      end
  end
end)

RegisterNetEvent('doormanager:thermiteDoor')
AddEventHandler('doormanager:thermiteDoor', function()
    for i = 1, #DOORS_TO_MANAGE do
        local door = DOORS_TO_MANAGE[i]
        if door.thermiteable then
            local mycoords = GetEntityCoords(GetPlayerPed(-1), false)
            local x, y, z = table.unpack(mycoords)
            local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
            local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
            TriggerServerEvent("911:JewelleryRobbery", x, y, z, lastStreetNAME)

            if math.random() < 0.30 then
                StartEntityFire(GetPlayerPed(-1))
            else
                TriggerServerEvent('doormanager:checkDoorLock', i, door.x, door.y, door.z, true, true)
                exports.globals:notify("You've damaged the jewelry store door locks!", "^3INFO: ^0You've damaged the jewelry store door locks!")
                Wait(5000)
                exports.globals:notify('Once you have collected the goods head to Jamestown and locate the buyer!', "^3INFO: ^0Once you have collected the goods head to Jamestown and locate the buyer!")
            end
        end
    end
end)

RegisterNetEvent('doormanager:advancedPick')
AddEventHandler('doormanager:advancedPick', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #DOORS_TO_MANAGE do
        local door = DOORS_TO_MANAGE[i]
        local x, y, z = door.x, door.y, door.z
        if Vdist(playerCoords, x, y, z) < 1.5 then
            if door.advancedlockpickable then
              local numCops = TriggerServerCallback {
                eventName = "globals:getNumCops",
                args = {}
              }
              if numCops <= 3 and door.name:find("Bolingbroke") then
                exports.globals:notify("Lockpick not working!")
                return
              end
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
                if math.random() >= 0.40 or door.name:find("Bolingbroke") then
                    TriggerServerEvent('911:LockpickingDoor', x, y, z, lastStreetNAME, isMale)
                end
                TriggerEvent('lockpick:openlockpick')
            else
                TriggerEvent('usa:notify', 'You cannot use advanced lockpicks here!')
                return
            end
        end
    end
end)

RegisterNetEvent('doormanager:advancedSuccess')
AddEventHandler('doormanager:advancedSuccess', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #DOORS_TO_MANAGE do
        local door = DOORS_TO_MANAGE[i]
        local x, y, z = door.x, door.y, door.z
        if Vdist(playerCoords, x, y, z) < 1.5 then
            if door.advancedlockpickable then
                TriggerServerEvent('doormanager:checkDoorLock', i, door.x, door.y, door.z, true)
                TriggerEvent("usa:notify", "Lockpick was ~y~successful~s~!")
                return
            end
        end
    end
end)

RegisterNetEvent('doormanager:DoorClipboard')
AddEventHandler('doormanager:DoorClipboard', function(name, jobs, doorHash)
  if string.sub(doorHash, 1, 1) == "-" then
    doorHash = tonumber(string.sub(doorHash, 2, string.len(doorHash)))
    doorHash = doorHash * -1
  else
    doorHash = tonumber(doorHash)
  end
  local door = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, doorHash, false, false, false)
  local door_x = round(GetEntityCoords(door).x, 2)
  local door_y = round(GetEntityCoords(door).y, 2)
  local door_z = round(GetEntityCoords(door).z, 2)
  local door_heading = round(GetEntityHeading(door))
  local message = '{name = "' .. name .. '", x = ' .. door_x .. ', y = ' .. door_y .. ', z = ' .. door_z .. ', model = ' .. doorHash .. ', locked = true, offset={0.0, -1.0, 0.0}, heading=' .. door_heading .. ', _dist = 1.5, allowedJobs = {' .. jobs .. '}},'
  print(message)
  SendNUIMessage({
    message = message
  })
end)

RegisterNetEvent('doormanager:StaticClipboard')
AddEventHandler('doormanager:StaticClipboard', function(name, jobs, doorHash)
  if string.sub(doorHash, 1, 1) == "-" then
    doorHash = tonumber(string.sub(doorHash, 2, string.len(doorHash)))
    doorHash = doorHash * -1
  else
    doorHash = tonumber(doorHash)
  end
  local door = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, doorHash, false, false, false)
  local door_x = round(GetEntityCoords(door).x, 2)
  local door_y = round(GetEntityCoords(door).y, 2)
  local door_z = round(GetEntityCoords(door).z, 2)
  local door_heading = round(GetEntityHeading(door))
  local message = '{name = "' .. name .. '", x = ' .. door_x .. ', y = ' .. door_y .. ', z = ' .. door_z .. ', model = ' .. doorHash .. ', locked = true, offset={0.0, -1.0, 0.0}, heading=' .. door_heading .. ', _dist = 1.5, allowedJobs = {' .. jobs .. '}, static = true, gate = true, lockedCoords = {'..door_x..', '..door_y..', '..door_z..'}},'
  print(message)
  SendNUIMessage({
    message = message
  })
end)

RegisterNetEvent('doormanager:GateClipboard')
AddEventHandler('doormanager:GateClipboard', function(name, jobs, doorHash)
  if string.sub(doorHash, 1, 1) == "-" then
    doorHash = tonumber(string.sub(doorHash, 2, string.len(doorHash)))
    doorHash = doorHash * -1
  else
    doorHash = tonumber(doorHash)
  end
  local door = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, doorHash, false, false, false)
  local door_x = round(GetEntityCoords(door).x, 2)
  local door_y = round(GetEntityCoords(door).y, 2)
  local door_z = round(GetEntityCoords(door).z, 2)
  local door_heading = round(GetEntityHeading(door))
  local message = '{name = "'..name..'", x = '..door_x..', y = '..door_y..', z = '..door_z..', model = '..doorHash..', locked = true, _dist = 8.0, gate = true, offset={0.0, 0.0, 0.0}, lockedCoords = {'..door_x..', '..door_y..', '..door_z..'}, allowedJobs = {' .. jobs .. '}},'
  print(message)
  SendNUIMessage({
    message = message
  })
end)

RegisterNetEvent('doormanager:CellClipboard')
AddEventHandler('doormanager:CellClipboard', function(name, jobs, doorHash)
  if string.sub(doorHash, 1, 1) == "-" then
    doorHash = tonumber(string.sub(doorHash, 2, string.len(doorHash)))
    doorHash = doorHash * -1
  else
    doorHash = tonumber(doorHash)
  end
  local door = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, doorHash, false, false, false)
  local door_x = round(GetEntityCoords(door).x, 2)
  local door_y = round(GetEntityCoords(door).y, 2)
  local door_z = round(GetEntityCoords(door).z, 2)
  local door_heading = round(GetEntityHeading(door))

  local message = '{name = "'..name..'", x = '..door_x..', y = '..door_y..', z = '..door_z..', model = '..doorHash..', customDoor = { coords = {x = '..door_x..', y = '..door_y..', z = '..door_z..'}, model = GetHashKey("prop_ld_jail_door"), rot = 131.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {' .. jobs .. '}},'
  print(message)
  SendNUIMessage({
    message = message
  })
end)

function CreateCellDoor(door)
  local cellDoorHandle = CreateObject(door.customDoor.model, door.customDoor.coords.x, door.customDoor.coords.y, door.customDoor.coords.z, false, false, true)
  SetEntityCollision(cellDoorHandle, true, true)
  SetEntityAsMissionEntity(cellDoorHandle, true, true)
  FreezeEntityPosition(cellDoorHandle, true)
  SetEntityRotation(cellDoorHandle, 0.0, 0.0, (door.customDoor.rot or -90.0), true)
end

function togglePrisonCellDoor(door)
  if door.customDoor then
    if door.locked then
      local cellDoor = GetClosestObjectOfType(door.customDoor.coords.x, door.customDoor.coords.y, door.customDoor.coords.z, 1.3, door.customDoor.model, false, false, false)
      if not DoesEntityExist(cellDoor) then
        --print("Creating cell door at: " .. door.customDoor.coords.x .. " " .. door.customDoor.coords.y .. " " .. door.customDoor.coords.z)
        --print("instead of : " .. door.x .. " " .. door.y .. " " .. door.z)
        -- 1557126584
        CreateCellDoor(door)
      end
    else
      local cellDoor = GetClosestObjectOfType(door.customDoor.coords.x, door.customDoor.coords.y, door.customDoor.coords.z, 1.3, door.customDoor.model, false, false, false)
      if DoesEntityExist(cellDoor) then
        --print("Deleting cell door at: " .. door.customDoor.coords.x .. " " .. door.customDoor.coords.y .. " " .. door.customDoor.coords.z)
        SetEntityAsMissionEntity(cellDoor, true, true)
        DeleteEntity(cellDoor)
      end
    end
  end
end

function MakeSureCellDoorPropExists(door)
  if door.cell_block and door.customDoor then
    local cellDoor = GetClosestObjectOfType(door.customDoor.coords.x, door.customDoor.coords.y, door.customDoor.coords.z, 1.0, door.customDoor.model, false, false, false)
    if not DoesEntityExist(cellDoor) then
      --print("Creating cell door at: " .. door.customDoor.coords.x .. " " .. door.customDoor.coords.y .. " " .. door.customDoor.coords.z)
      -- 1557126584
      CreateCellDoor(door)
    end
  else 
    print("not a cell door or no customDoor specified")
  end
end

function MakeSureCellDoorPropDeleted(door)
  if door.cell_block and door.customDoor then
    local cellDoor = GetClosestObjectOfType(door.customDoor.coords.x, door.customDoor.coords.y, door.customDoor.coords.z, 1.0, door.customDoor.model, false, false, false)
    if DoesEntityExist(cellDoor) then
      --print("Deleting cell door at: " .. door.customDoor.coords.x .. " " .. door.customDoor.coords.y .. " " .. door.customDoor.coords.z)
      SetEntityAsMissionEntity(cellDoor, true, true)
      DeleteEntity(cellDoor)
    end
  else
    print("not a cell door or no customDoor specified")
  end
end

function SpawnAllPrisonCellDoors(doors)
  for i = 1, #doors do
    togglePrisonCellDoor(doors[i])
  end
end

function DrawTimer(beginTime, duration, x, y, text)
    if not HasStreamedTextureDictLoaded('timerbars') then
        RequestStreamedTextureDict('timerbars')
        while not HasStreamedTextureDictLoaded('timerbars') do
            Citizen.Wait(0)
        end
    end

    if GetTimeDifference(GetGameTimer(), beginTime) < duration then
        w = (GetTimeDifference(GetGameTimer(), beginTime) * (0.085 / duration))
    end

    local correction = ((1.0 - math.floor(GetSafeZoneSize(), 2)) * 100) * 0.005
    x, y = x - correction, y - correction

    Set_2dLayer(0)
    DrawSprite('timerbars', 'all_black_bg', x, y, 0.15, 0.0325, 0.0, 255, 255, 255, 180)

    Set_2dLayer(1)
    DrawRect(x + 0.0275, y, 0.085, 0.0125, 100, 0, 0, 180)

    Set_2dLayer(2)
    DrawRect(x - 0.015 + (w / 2), y, w, 0.0125, 150, 0, 0, 180)

    SetTextColour(255, 255, 255, 180)
    SetTextFont(0)
    SetTextScale(0.3, 0.3)
    SetTextCentre(true)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    Set_2dLayer(3)
    DrawText(x - 0.06, y - 0.012)
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end

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

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

function PlayLockAnim()
    if not IsPedCuffed(GetPlayerPed(-1)) then
        loadAnimDict('anim@mp_player_intmenu@key_fob@')
        ped = GetPlayerPed(-1)
        TaskPlayAnim(ped, "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, 1.0, -1, 48)
    end
end

function round(value, numDecimalPlaces)
  if numDecimalPlaces then
    local power = 10^numDecimalPlaces
    return math.floor((value * power) + 0.5) / (power)
  else
    return math.floor(value + 0.5)
  end
end