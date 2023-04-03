local KEY = 38 -- "E"
local SOUND_ENABLE = true
local processed = false
local harvested = false

local WEED_PROCESS_LOCATIONS = {
  vector3(1036.35, -3203.71, -38.17),
  --vector3(382.287109375, -816.33471679688, 29.30421257019),
  vector3(165.33766174316, -233.84161376953, 50.055225372314), --White widow
  vector3(440.03646850586, -1886.7438964844, 31.739208221436),
  vector3(-1075.3463134766, -1678.7690429688, 4.575234413147),
  vector3(2229.373046875, 5605.4873046875, 54.872550964355),
  --vector3(-247.1794128418, -1513.9282226563, 29.161888122559) -- chamberlain hills community center addon MLO
}

function isNearWeedProcessingSpot(range)
  local playerCoords = GetEntityCoords(PlayerPedId())
  local isNearAny = false
  for i = 1, #WEED_PROCESS_LOCATIONS do
    if Vdist(playerCoords, WEED_PROCESS_LOCATIONS[i]) < range then
      return true
    end
  end
  return false
end

------------------------------------------------
-- See if player is close to any job location --
------------------------------------------------
Citizen.CreateThread(function()
  while true do
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #WEED_PROCESS_LOCATIONS do
      DrawText3D(WEED_PROCESS_LOCATIONS[i].x, WEED_PROCESS_LOCATIONS[i].y, WEED_PROCESS_LOCATIONS[i].z, 5, '[E] - Process Weed')
    end
    DrawText3D(2856.12, 4458.76, 48.5, 3, '[E] - Enter')
    DrawText3D(1066.40, -3183.47, -39.16, 5, '[E] - Exit')
    if IsControlJustPressed(1, KEY) then
      if isNearWeedProcessingSpot(3.5) and not processed then
        Wait(500)
        if not IsControlPressed(1, KEY) then
          TriggerServerEvent("weed:checkItem", "Process")
          Wait(5000) -- prevent spamming
        end
      elseif Vdist(playerCoords, 2856.12, 4458.76, 48.5) < 1.5 then
        DoorTransition(playerPed, 1066.40, -3183.47, -39.16, 86.0)
      elseif Vdist(playerCoords, 1066.40, -3183.47, -39.16, 86.0) < 1.5 then
        DoorTransition(playerPed, 2856.12, 4458.76, 48.5, 9.85)
  	  end
    end
    Wait(0)
  end
end)

-------------------
-- CUSTOM EVENTS --
-------------------
RegisterNetEvent("weed:continueHarvesting")
AddEventHandler("weed:continueHarvesting", function()
  local playerPed = PlayerPedId()
  local beginTime = GetGameTimer()
  harvested = true
  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
  while not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b") do Citizen.Wait(100) end
  TaskPlayAnim(playerPed,"amb@prop_human_bum_bin@idle_b","idle_d", 100.0, 200.0, 0.3, 121, 0.2, 0, 0, 0)
  TriggerServerEvent("InteractSound_SV:PlayOnSource", "trimming", 0.1)
  while GetGameTimer() - beginTime < 15000 do
    Citizen.Wait(0)
    if Vdist(GetEntityCoords(playerPed), 2224.04, 5577.28, 52.7) < 9 then
      DrawTimer(beginTime, 15000, 1.42, 1.475, 'HARVESTING')
    else
      harvested = false
      ClearPedTasks(playerPed)
      TriggerEvent('usa:notify', 'You went too far away!')
      break
    end
  end
  if harvested then
    while securityToken == nil do
      Wait(1)
    end
    TriggerServerEvent("weed:rewardItem", "Harvest", securityToken)
    TriggerEvent('usa:notify', 'You have harvested a ~y~Weed Bud~s~.')
    TriggerEvent('evidence:weedScent')
    ClearPedTasks(playerPed)
    harvested = false
  end
end)

RegisterNetEvent("weed:continueProcessing")
AddEventHandler("weed:continueProcessing", function()
  local playerPed = PlayerPedId()
  local beginTime = GetGameTimer()
  processed = true
  RequestAnimDict("timetable@jimmy@ig_1@idle_a")
  while not HasAnimDictLoaded("timetable@jimmy@ig_1@idle_a") do Citizen.Wait(100) end
  TaskPlayAnim(playerPed,"timetable@jimmy@ig_1@idle_a","hydrotropic_bud_or_something", 100.0, 200.0, 0.3, 121, 0.2, 0, 0, 0)
  while GetGameTimer() - beginTime < 25000 do
    Citizen.Wait(0)
    if isNearWeedProcessingSpot(5) then
      DrawTimer(beginTime, 25000, 1.42, 1.475, 'PROCESSING')
    else
      processed = false
      ClearPedTasks(playerPed)
      TriggerEvent('usa:notify', 'You went too far away!')
      break
    end
  end
  if processed then
    while securityToken == nil do
      Wait(1)
    end
    TriggerServerEvent("weed:rewardItem", "Process", securityToken)
    TriggerEvent('usa:notify', 'You have processed a ~y~Weed Bud~s~.')
    ClearPedTasks(playerPed)
    processed = false
  end
end)

----------------------
-- UTLITY FUNCTIONS --
----------------------

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

function DrawText3D(x, y, z, distance, text)
    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), x, y, z, true) < distance then
        local onScreen,_x,_y=World3dToScreen2d(x,y,z)
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 380
        DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
    end
end

function PlayDoorAnimation()
    while ( not HasAnimDictLoaded( 'anim@mp_player_intmenu@key_fob@' ) ) do
        RequestAnimDict( 'anim@mp_player_intmenu@key_fob@' )
        Citizen.Wait( 0 )
  end
    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, 1.0, -1, 48)
end

function DoorTransition(playerPed, x, y, z, heading)
  PlayDoorAnimation()
  DoScreenFadeOut(500)
  Wait(500)
  RequestCollisionAtCoord(x, y, z)
  SetEntityCoordsNoOffset(playerPed, x, y, z, false, false, false, true)
  SetEntityHeading(playerPed, heading)
  while not HasCollisionLoadedAroundEntity(playerPed) do
      Citizen.Wait(100)
      SetEntityCoords(playerPed, x, y, z, 1, 0, 0, 1)
  end
  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'door-shut', 0.5)
  Wait(2000)
  DoScreenFadeIn(500)
end
