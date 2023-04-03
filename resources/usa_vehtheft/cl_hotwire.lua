local engineOn
local hasKeys = false
local isHotwiring = false
local timeout = GetGameTimer()
local veh = GetVehiclePedIsIn(playerPed, true)
local playerHotwiredVehicles = {}
local searchedVehicles = {}
local Result = nil
local NUI_status = false

local VEHICLE_ITEM_SEARCH_TIME = 20000
local HOTWIRE_BREAK_CHANCE = 0.40
local ENABLE_KEY_CHECK_FOR_ENGINE = true

Citizen.CreateThread(function()
  local wasInVeh = false
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        veh = GetVehiclePedIsIn(playerPed, true)
        engineOn = GetIsVehicleEngineRunning(veh)
        if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(playerPed == -1) then
          if not wasInVeh and ENABLE_KEY_CHECK_FOR_ENGINE then
            TriggerServerEvent('veh:checkForKey', exports.globals:trim(GetVehicleNumberPlateText(veh)), GetIsVehicleEngineRunning(veh))
            wasInVeh = true
          end
        else
          if wasInVeh then
            wasInVeh = false
          end
        end
        if engineOn then
          if not hasKeys and ENABLE_KEY_CHECK_FOR_ENGINE then
            SetVehicleEngineOn(veh, false, true, true)
          else
            if DoesEntityExist(playerPed) and IsPedInAnyVehicle(playerPed, false) and IsControlPressed(2, 75) and not IsEntityDead(playerPed) and not IsPauseMenuActive() then
                local engineWasRunning = GetIsVehicleEngineRunning(GetVehiclePedIsIn(playerPed, true))
                Citizen.Wait(1000)
                if DoesEntityExist(playerPed) and not IsPedInAnyVehicle(playerPed, false) and not IsEntityDead(playerPed) and not IsPauseMenuActive() then
                    local vehBeingLeft = GetVehiclePedIsIn(playerPed, true)
                    if (engineWasRunning) then
                      SetVehicleEngineOn(vehBeingLeft, true, true, true)
                    end
                end
            end
          end
        elseif IsControlJustPressed(0, 71) and not IsEntityDead(playerPed) and DoesEntityExist(playerPed) and IsPedInAnyVehicle(playerPed, false) and GetGameTimer() - timeout > 10000 and ENABLE_KEY_CHECK_FOR_ENGINE then
            timeout = GetGameTimer()
            local veh = GetVehiclePedIsIn(playerPed, true)
            TriggerServerEvent('veh:checkForKey', exports.globals:trim(GetVehicleNumberPlateText(veh)))
        end
    end
end)

RegisterNetEvent('hotwire:enableKeyEngineCheck')
AddEventHandler('hotwire:enableKeyEngineCheck', function(status)
  ENABLE_KEY_CHECK_FOR_ENGINE = status
end)

RegisterNetEvent('veh:returnPlateToCheck')
AddEventHandler('veh:returnPlateToCheck', function()
  if veh then
    TriggerServerEvent("veh:checkForKey", exports.globals:trim(GetVehicleNumberPlateText(veh)))
  end
end)

RegisterNetEvent('veh:searchVeh')
AddEventHandler('veh:searchVeh', function()
  local playerPed = PlayerPedId()
  local vehicle = veh
  if GetVehicleClass(vehicle) == 18 or GetVehicleClass(vehicle) == 13 then -- emergency = 18, cycles = 13
      exports.globals:notify("Can't search this vehicle") 
      return
  end
  if not IsPedCuffed(playerPed) and GetPedInVehicleSeat(vehicle, -1) == playerPed and GetVehicleDoorLockStatus(vehicle) ~= 4 then
    local curVehPlate = exports.globals:trim(GetVehicleNumberPlateText(vehicle))
    for _, searchedPlate in pairs(searchedVehicles) do
      if curVehPlate == searchedPlate then
        return -- vehicle has already been searched
      end
    end
    table.insert(searchedVehicles, curVehPlate)
    RequestAnimDict('veh@handler@base')
    while not HasAnimDictLoaded('veh@handler@base') do
      Citizen.Wait(100)
    end
    local searchBegin = GetGameTimer()
    while GetGameTimer() - searchBegin < VEHICLE_ITEM_SEARCH_TIME do
      Citizen.Wait(0)
      DisableControlAction(0, 86, true)
      DisableControlAction(0, 244, true)
      DisableControlAction(0, 245, true)
      DisableControlAction(0, 288, true)
      DisableControlAction(0, 79, true)
      DisableControlAction(0, 73, true)
      DisableControlAction(0, 75, true)
      DisableControlAction(0, 37, true)
      DisableControlAction(0, 311, true)
      if not IsEntityPlayingAnim(playerPed, 'veh@handler@base', 'hotwire', 3) then
        TaskPlayAnim(playerPed, 'veh@handler@base', 'hotwire', 8.0, 1.0, -1, 49, 1.0, false, false, false)
      end
      DrawTimer(searchBegin, VEHICLE_ITEM_SEARCH_TIME, 1.42, 1.475, 'SEARCHING')
    end
    ClearPedTasks(playerPed)
    TriggerServerEvent('veh:searchResult')
  end
end)

RegisterNetEvent("veh:toggleEngine")
AddEventHandler('veh:toggleEngine', function(_hasKey, _engineOn)
  -- _engineOn to turn the engine on instantly, used when checking if the player is entering a vehicle with the engine already on
  hasKeys = _hasKey
  if not IsVehicleBlacklisted(veh) and GetPedInVehicleSeat(veh, -1) == PlayerPedId() and not IsPedCuffed(PlayerPedId()) then
    local playerPed = PlayerPedId()
    if _hasKey and veh then
      if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
        if _engineOn then
          engineOn = _engineOn
          --print('turned on instantly duuude')
          SetVehicleEngineOn(veh, _engineOn, true, true)
        else
          engineOn = not engineOn
          SetVehicleEngineOn(veh, engineOn, false, true)
        end
      end
    else
      --print(GetVehicleNumberPlateText(veh))
      for k, v in pairs(playerHotwiredVehicles) do
        --print(k)
        if exports.globals:trim(GetVehicleNumberPlateText(veh)) == k then
          --print('hotwired vehicle')
          if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
            hasKeys = true
            if _engineOn then
              engineOn = _engineOn
              --print('turned on instantly duuude')
              SetVehicleEngineOn(veh, _engineOn, true, true)
            else
              engineOn = not engineOn
              SetVehicleEngineOn(veh, engineOn, false, true)
            end
            return
          end
        end
      end
      if not isHotwiring then
        local beginTime = GetGameTimer()
        while GetGameTimer() - beginTime < 3000 do
          Citizen.Wait(0)
          ShowHelp('You do not have the keys to this vehicle!', 0)
          exports.globals:notify('You do not have the keys to this vehicle!')
        end
      end
    end
  end
end)

RegisterNetEvent('veh:hotwireVehicle')
AddEventHandler('veh:hotwireVehicle', function()
  local playerPed = PlayerPedId()
  if veh and GetPedInVehicleSeat(veh, -1) == playerPed and not IsPedCuffed(PlayerPedId()) then
    if not hasKeys and DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
      if math.random() < 0.40 and IsAreaPopulated() then
        local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
        local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
        local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
        local primary, secondary = GetVehicleColours(veh)
        local isMale = true
        if GetEntityModel(playerPed) == GetHashKey("mp_f_freemode_01") then
          isMale = false
        elseif GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01") then 
          isMale = true
        else
          isMale = IsPedMale(playerPed)
        end
        TriggerServerEvent('911:HotwiringVehicle', x, y, z, lastStreetNAME, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))), exports.globals:trim(GetVehicleNumberPlateText(veh)), isMale, primary, secondary)
      end

      RequestAnimDict('veh@handler@base')
      while not HasAnimDictLoaded('veh@handler@base') do
        Citizen.Wait(100)
      end

      if not isHotwiring then
        isHotwiring = true
        if math.random() < HOTWIRE_BREAK_CHANCE then
          TriggerServerEvent('veh:removeHotwiringKit')
        end
        if not IsEntityPlayingAnim(playerPed, 'veh@handler@base', 'hotwire', 3) then
          TaskPlayAnim(playerPed, 'veh@handler@base', 'hotwire', 8.0, 1.0, -1, 49, 1.0, false, false, false)
        end
        local success = lib.skillCheck({'easy', 'easy', 'medium', 'medium', 'hard'}, {'w', 'a', 's', 'd'})
        if success then
          TriggerEvent('usa:notify', 'The hotwiring kit was ~g~successful~s~!')
          isHotwiring = false
          hasKeys = true
          playerHotwiredVehicles[GetVehicleNumberPlateText(veh)] = true
          SetVehicleEngineOn(veh, true, false, false)
          ClearPedTasks(playerPed)
          Citizen.CreateThread(function()
            local timeToWait = math.random((5 * 60000), (20 * 60000))
            Citizen.Wait(timeToWait)
            TriggerServerEvent('mdt:addTempVehicle', GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))), 'Unknown', exports.globals:trim(GetVehicleNumberPlateText(veh)), true)
            --print('flagging as stolen!')
          end)
        else
          TriggerEvent('usa:notify', 'The hotwiring kit was ~y~unsuccessful~s~!')
          ClearPedTasks(playerPed)
          isHotwiring = false
        end
      end
    end
  else
    TriggerEvent('usa:notify', 'A suitable vehicle is ~y~not found~s~!')
  end
end)

RegisterNetEvent('veh:slimjimVehInFrontPolice')
AddEventHandler('veh:slimjimVehInFrontPolice', function()
  local targetVehicle = getVehicleInFrontOfUser()
  local boostingInfo = Entity(targetVehicle).state.boostingData
  if boostingInfo ~= nil and boostingInfo.advancedSystem then
    TriggerEvent("usa:notify", 'You need a ~r~professional system~w~ to access this vehicle!')
    return 
  end
  local playerPed = PlayerPedId()
  local veh = getVehicleInFrontOfUser()
  if veh ~= 0 and GetEntityType(veh) == 2 and GetVehicleClass(veh) ~= 21 and GetVehicleClass(veh) ~= 16 and GetVehicleClass(veh) ~= 15 and GetVehicleClass(veh) ~= 14 and GetVehicleClass(veh) ~= 13  and not IsPedCuffed(PlayerPedId()) then
    RequestAnimDict('veh@break_in@0h@p_m_one@')
    while not HasAnimDictLoaded('veh@break_in@0h@p_m_one@') do
      Citizen.Wait(100)
    end
    local beginTime = GetGameTimer()
      Citizen.CreateThread(function()
        while GetGameTimer() - beginTime < 5000 do
          Citizen.Wait(0)
          DrawTimer(beginTime, 5000, 1.42, 1.475, 'SLIMJIMMING')
          DisableControlAction(0, 86, true)
          DisableControlAction(0, 244, true)
          DisableControlAction(0, 245, true)
          DisableControlAction(0, 288, true)
          DisableControlAction(0, 79, true)
          DisableControlAction(0, 73, true)
          DisableControlAction(0, 75, true)
          DisableControlAction(0, 37, true)
          DisableControlAction(0, 311, true)
        end
      end)
      while GetGameTimer() - beginTime < 5000 do
        isSlimjimming = true
        if not IsEntityPlayingAnim(playerPed, 'veh@break_in@0h@p_m_one@', 'low_force_entry_ds', 3) then
          local x, y, z = table.unpack(GetEntityCoords(playerPed))
          TaskPlayAnim(playerPed, 'veh@break_in@0h@p_m_one@', 'low_force_entry_ds', 8.0, 1.0, -1, 11, 1.0, false, false, false)
          Citizen.Wait(2000)
          ClearPedTasks(playerPed)
          SetEntityCoords(playerPed, x, y, z - 1.0, false, false, false, false)
        end
        Citizen.Wait(0)
      end
    isSlimjimming = false
    TriggerEvent('usa:notify', 'The vehicle has been ~y~unlocked~s~!')
    SetVehicleDoorsLocked(veh, 1)
    SetVehicleDoorsLockedForAllPlayers(veh, 0)
    if not GetIsVehicleEngineRunning(veh) then
      SetVehicleNeedsToBeHotwired(veh, true)
    end
  else
    TriggerEvent('usa:notify', 'A suitable vehicle is ~y~not found~s~!')
  end
end)

RegisterNetEvent('veh:hotwireVehPolice')
AddEventHandler('veh:hotwireVehPolice', function()
    local ped = GetPlayerPed(-1)
		local targetVehicle = GetVehiclePedIsUsing(ped, false)
		local boostingInfo = Entity(targetVehicle).state.boostingData
		if boostingInfo ~= nil and boostingInfo.advancedSystem then
			TriggerEvent("usa:notify", 'You need a ~r~professional system~w~ to turn this vehicle on!')
			return 
		end
  local playerPed = PlayerPedId()
  if veh and GetPedInVehicleSeat(veh, -1) == playerPed then
    if not hasKeys and DoesEntityExist(playerPed) and not IsEntityDead(playerPed) and not IsPedCuffed(PlayerPedId()) then
      RequestAnimDict('veh@handler@base')
      while not HasAnimDictLoaded('veh@handler@base') do
        Citizen.Wait(100)
      end
      local beginTime = GetGameTimer()
      while GetGameTimer() - beginTime < 5000 do
        isHotwiring = true
        DisableControlAction(0, 86, true)
        DisableControlAction(0, 244, true)
        DisableControlAction(0, 245, true)
        DisableControlAction(0, 288, true)
        DisableControlAction(0, 79, true)
        DisableControlAction(0, 73, true)
        DisableControlAction(0, 75, true)
        DisableControlAction(0, 37, true)
        DisableControlAction(0, 311, true)
        if not IsEntityPlayingAnim(playerPed, 'veh@handler@base', 'hotwire', 3) then
          TaskPlayAnim(playerPed, 'veh@handler@base', 'hotwire', 8.0, 1.0, -1, 49, 1.0, false, false, false)
        end
        DrawTimer(beginTime, 5000, 1.42, 1.475, 'HOTWIRING')
        Citizen.Wait(0)
      end
      isHotwiring = false
      ClearPedTasks(playerPed)
      hasKeys = true
      playerHotwiredVehicles[exports.globals:trim(GetVehicleNumberPlateText(veh))] = true
      TriggerEvent('usa:notify', 'The vehicle has been ~y~hotwired~s~!')
      SetVehicleEngineOn(veh, true, false, false)
    end
  else
    TriggerEvent('usa:notify', 'A suitable vehicle is ~y~not found~s~!')
  end
end)

function getVehicleInFrontOfUser()
  local playerped = GetPlayerPed(-1)
  local coordA = GetEntityCoords(playerped, 1)
  local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
  local targetVehicle = getVehicleInDirection(coordA, coordB)
  return targetVehicle
end

function getVehicleInDirection(coordFrom, coordTo)
  local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
  return vehicle
end

function ShowHelp(text, bleep)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, bleep, -1)
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

function IsVehicleBlacklisted(vehicle)
  if GetVehicleClass(vehicle) == 13 or GetVehicleClass(vehicle) == 21 then
    return true
  else
    return false
  end
end

function IsAreaPopulated()
  local AREAS = {
    {x = 1491.839, y = 3112.53, z = 40.656, range = 330}, -- sandy shores airport area // 75 - 150 probably range
    {x = 151.62, y = 1038.808, z = 32.735, range = 1200}, -- los santos // 600 - 900 ish?
    {x = -3161.96, y = 790.088, z = 6.824, range = 650}, -- west coast, NW of los santos // 300 - 400 ish?
    {x = 2356.744, y = 4776.75, z = 34.613, range = 600}, -- grape seed // 350 - 450 ish?
    {x = 145.209, y = 6304.922, z = 40.277, range = 650}, -- paleto bay // 500 - 600
    {x = -1070.5, y = 5323.5, z = 46.339, range = 700}, -- S of Paleto Bay // 350 - 500 ish
    {x = -2550.21, y = 2321.747, z = 33.059, range = 350}, -- west of map, gas station // 100 - 200
    {x = 1927.374, y = 3765.77, z = 32.309, range = 350}, -- sandy shores
    {x = 895.649, y = 2697.049, z = 41.985, range = 200}, -- harmony
    {x = -1093.773, y = -2970.00, z = 13.944, range = 300}, -- LS airport
    {x = 1070.506, y = -3111.021, z = 5.9, range = 450} -- LS ship cargo area
  }
  local my_coords = GetEntityCoords(me, true)
  for k = 1, #AREAS do
    if Vdist(my_coords.x, my_coords.y, my_coords.z, AREAS[k].x, AREAS[k].y, AREAS[k].z) <= AREAS[k].range then
      --print("within range of populated area!")
      return true
    end
  end
  return false
end

function DrawText3D(x, y, z, distance, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) < distance then
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
end
