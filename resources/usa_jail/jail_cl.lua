--# Created by: minipunch
--# for USA REALISM rep
--# requres 'globals' resource to send notifications and usa_rp to change their model, check their jail time on join, and stuff like that

local releaseX, releaseY, releaseZ = 1847.086, 2585.990, 45.672
local assigned_cell = nil
local tabletObject

local menuEnabled = false
local gracePeriod = false
local allowedOut = false

function EnableGui(enable)
    SetNuiFocus(enable, enable)
    menuEnabled = enable
    SetPedCanSwitchWeapon(GetPlayerPed(-1), (not menuEnabled))

    SendNUIMessage({
        type = "enableui",
        enable = enable
    })
end

RegisterNetEvent("jail:openMenu")
AddEventHandler("jail:openMenu", function()
    EnableGui(true, true)
    SetPedCanSwitchWeapon(GetPlayerPed(-1), false)
    -- look at clipboard:
    local playerPed = PlayerPedId()
    local dict = "amb@world_human_seat_wall_tablet@female@base"
    RequestAnimDict(dict)
    if tabletObject == nil then
        tabletObject = CreateObject(GetHashKey('prop_cs_tablet'), GetEntityCoords(playerPed), 1, 1, 1)
        AttachEntityToEntity(tabletObject, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
    end
    while not HasAnimDictLoaded(dict) do Citizen.Wait(100) end
    if not IsEntityPlayingAnim(playerPed, dict, 'base', 3) then
    --local tablet = CreateObject(GetHashKey('prop_cs_tablet'), 0.0, 0.0, 0.0, true, false, true)
    --AttachEntityToEntity(tablet, playerPed, GetPedBoneIndex(playerPed, 57005), 0.1, 0.0, 0.0, 0.5, 0.0, -0.2, true, true, false, true, 1.0, false)
        TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
    end
end)

RegisterNUICallback('submit', function(data, cb)
  local playerPed = PlayerPedId()
  DeleteEntity(tabletObject)
  ClearPedTasks(playerPed)
  tabletObject = nil
	EnableGui(false, false) -- close form
    TriggerServerEvent("jail:jailPlayerFromMenu", data)
    cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)
  local playerPed = PlayerPedId()
    DeleteEntity(tabletObject)
    ClearPedTasks(playerPed)
    tabletObject = nil
    EnableGui(false, false)
    cb('ok')
end)

Citizen.CreateThread(function()
  while true do
    -- jail menu check --
    if menuEnabled then
      DisableControlAction(29, 241, menuEnabled) -- scroll up
      DisableControlAction(29, 242, menuEnabled) -- scroll down
      DisableControlAction(0, 1, menuEnabled) -- LookLeftRight
      DisableControlAction(0, 2, menuEnabled) -- LookUpDown
      DisableControlAction(0, 142, menuEnabled) -- MeleeAttackAlternate
      DisableControlAction(0, 106, menuEnabled) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({
          type = "click"
        })
      end
    end
    -- escaping jail check --
    if assigned_cell then
      local playerCoords = GetEntityCoords(PlayerPedId())
      if Vdist(playerCoords, assigned_cell.x, assigned_cell.y, assigned_cell.z) > 350 and not gracePeriod and not allowedAwayFromPrison then
        TriggerEvent("jail:escaped")
        assigned_cell = nil
      elseif Vdist(playerCoords, assigned_cell.x, assigned_cell.y, assigned_cell.z) > 350 and gracePeriod then
        SetEntityCoords(playerPed, assigned_cell.x, assigned_cell.y, assigned_cell.z, 1, 0, 0, 1) -- tp to jail
      end
    end
    Citizen.Wait(0)
  end
end)

-- end of NUI menu stuff

RegisterNetEvent("jail:jail")
AddEventHandler("jail:jail", function(cell, gender)
  gracePeriod = true
  local playerPed = PlayerPedId()
  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'cell-door', 0.5)
  DoScreenFadeOut(1000)
  Citizen.Wait(1000)
  if not cell then
    cell = {x = 1779.7791748047, y = 2580.640625, z = 45.792705535889, occupant = nil}
  end
  RequestCollisionAtCoord(cell.x, cell.y, cell.z)
  Wait(1000)
  SetEntityCoords(playerPed, cell.x, cell.y, cell.z, 1, 0, 0, 1) -- tp to jail
  while not HasCollisionLoadedAroundEntity(playerPed) do
      Citizen.Wait(100)
      SetEntityCoords(playerPed, cell.x, cell.y, cell.z, 1, 0, 0, 1) -- tp to jail
  end
  assigned_cell = cell
  TriggerEvent("cuff:unCuff", true)
  if not gender then
    gender = 'male'
    local isFemale = IsPedModel(playerPed, GetHashKey("mp_f_freemode_01"))
    if isFemale then 
      gender = 'female'
    end
  end
  TriggerEvent("jail:changeClothes", gender)
  TriggerEvent("jail:removeWeapons")
  TriggerEvent("usa:toggleJailedStatus", true)
  DoScreenFadeIn(1000)
  Wait(5000)
  gracePeriod = false
end)

RegisterNetEvent("jail:release")
AddEventHandler("jail:release", function(character)
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)
  Citizen.CreateThread(function()
    local model
    SetEntityCoords(playerPed, releaseX, releaseY, releaseZ, 1, 0, 0, 1) -- release from jail
    if not character.hash then
      model = GetHashKey("a_m_y_skater_01")
      RequestModel(model)
      while not HasModelLoaded(model) do -- Wait for model to load
        Citizen.Wait(100)
      end
      SetPlayerModel(PlayerId(), model)
      SetModelAsNoLongerNeeded(model)
    else
      TriggerEvent("usa:setPlayerComponents", character)
    end
    TriggerServerEvent("jail:clearCell", assigned_cell, false)
    TriggerEvent("cuff:unCuff", true)
    assigned_cell = nil
    TriggerEvent("usa:toggleJailedStatus", false)
  end)
end)

RegisterNetEvent("jail:escaped")
AddEventHandler("jail:escaped", function()
  TriggerServerEvent("jail:clearCell", assigned_cell, true)
  TriggerServerEvent("jail:notifyEscapee")
  TriggerEvent("usa:notify", "You escaped prison!")
  TriggerEvent("usa:toggleJailedStatus", false)
end)

RegisterNetEvent("jail:removeWeapons")
AddEventHandler("jail:removeWeapons", function()
	RemoveAllPedWeapons(PlayerPedId(), true) -- strip weapons
end)

RegisterNetEvent("jail:changeClothes")
AddEventHandler("jail:changeClothes", function(gender)
    local playerPed = PlayerPedId()
    -- only change clothes if male, since there is no female prisoner ped --
    if gender == "male" or gender == "undefined" or not gender then
        if not IsPedModel(playerPed, GetHashKey("mp_m_freemode_01")) then
            Citizen.CreateThread(function()
                local model = GetHashKey("S_M_Y_Prisoner_01")
                RequestModel(model)
                while not HasModelLoaded(model) do -- Wait for model to load
                    Citizen.Wait(100)
                end
                SetPlayerModel(PlayerId(), model)
                SetModelAsNoLongerNeeded(model)
                SetPedRandomComponentVariation(GetPlayerPed(-1), false)
            end)
        else
            --SetPedComponentVariation(me, 4, 7, 15, 0)
            SetPedComponentVariation(playerPed, 1, 0, 1, 2)
            SetPedComponentVariation(GetPlayerPed(-1), 4, 11, 0, 2) -- legs
            SetPedComponentVariation(GetPlayerPed(-1), 6, 13, 0, 2) -- shoes
            SetPedComponentVariation(GetPlayerPed(-1), 11, 57, 0, 2) -- torso
            SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) -- undershirt (aka torso 1)
            SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) -- accessories
            SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 2) -- Armor
            SetPedComponentVariation(GetPlayerPed(-1), 10, 0, 0, 2) -- Decals
            SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2) -- Arms
            SetPedComponentVariation(GetPlayerPed(-1), 5, 0, 0, 2) -- bags
            for i = 0, 7 do
              ClearPedProp(playerPed, i)
            end
        end
    else
        if IsPedModel(playerPed, GetHashKey("mp_f_freemode_01")) then
          SetPedComponentVariation(playerPed, 1, 0, 1, 2)
          SetPedComponentVariation(GetPlayerPed(-1), 4, 3, 15, 2) -- legs
          SetPedComponentVariation(GetPlayerPed(-1), 5, 0, 0, 2) -- bags
          SetPedComponentVariation(GetPlayerPed(-1), 4, 3, 15, 2) -- legs
          SetPedComponentVariation(GetPlayerPed(-1), 6, 1, 0, 2) -- shoes
          SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) -- accessories
          SetPedComponentVariation(GetPlayerPed(-1), 11, 9, 1, 2) -- torso
          SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) -- undershirt aka torso 1
          SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2) -- arms
          SetPedComponentVariation(GetPlayerPed(-1), 10, 0, 0, 2) -- decals
          SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 2) -- armor
          for i = 0, 7 do
            ClearPedProp(playerPed, i)
          end
        end
    end
end)

RegisterNetEvent("jail:setAllowedOut")
AddEventHandler("jail:setAllowedOut", function(status)
  allowedOut = status
end)

RegisterNetEvent("jail:startalarmCL")
AddEventHandler('jail:startalarmCL', function()
    local alarmIpl = GetInteriorAtCoordsWithType(1787.004,2593.1984,45.7978,"int_prison_main")
    RefreshInterior(alarmIpl)
    EnableInteriorProp(alarmIpl, "prison_alarm")
    while not PrepareAlarm("PRISON_ALARMS") do
            Citizen.Wait(0)
        end
        StartAlarm("PRISON_ALARMS", true)
    end)

RegisterNetEvent("jail:stopalarmCL")
AddEventHandler('jail:stopalarmCL', function()
    local alarmIpl = GetInteriorAtCoordsWithType(1787.004,2593.1984,45.7978,"int_prison_main")
    RefreshInterior(alarmIpl)
    DisableInteriorProp(alarmIpl, "prison_alarm")
    Citizen.CreateThread(function()
        while not PrepareAlarm("PRISON_ALARMS") do
            Citizen.Wait(100)
        end
        StopAllAlarms(true)
    end)
end)

Citizen.CreateThread(function()
  TriggerServerEvent("jail:checkalarm")
end)