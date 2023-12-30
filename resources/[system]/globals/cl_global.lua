local KEYS = {
  TAB = 37,
  SCROLL_UP = 241,
  SCROLL_DOWN = 242,
  ONE = 157,
  TWO = 158,
  THREE = 160,
  FOUR = 164,
  FIVE = 165,
  E = 46,
  P = 199,
  V = 0,
  Y = 246,
  RIGHT_CLICK = 25,
  Q = 44
}

local MAX_ITEM_TRADE_DISTANCE = 1.5
local MAX_TACKLE_DISTANCE = 1.5
local ACTION_MESSAGE_TIME_SECONDS = 6.5

function MaxItemTradeDistance()
	return MAX_ITEM_TRADE_DISTANCE
end

function MaxTackleDistance()
	return MAX_TACKLE_DISTANCE
end

function GetKeys()
  return KEYS
end

--------------------------------------------------------------
-- Send GTA style notification above minimap on bottom left --
--------------------------------------------------------------
function notify(msg, chatMsg)
  if msg then
    msg = msg:gsub("~y~", "")
    msg = msg:gsub("~w~", "")
    msg = msg:gsub("~g~", "")
    msg = msg:gsub("~r~", "")
    msg = msg:gsub("~s~", "")
    lib.notify({
      title = msg,
      position = "center-left"
      --description = 'Notification description',
      --type = 'success'
    })
  end
  if chatMsg then 
    TriggerEvent("chatMessage", "", {}, chatMsg)
  end
end

-----------------------------------------------------------------------------------------
-- Easy to use API for FiveM iterator functions to loop through all entities of a type --
-- Call exports.globals:EnumrateObjects() for objects, etc...
-- Ex: for veh in exports.globals:EnumrateVehicles() do
--      print("vehicle handle: " .. veh)
--     end
-----------------------------------------------------------------------------------------
local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end

    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)

    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next

    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateObjects()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

-------------------------------------
-- Start action (me) message --
-------------------------------------
local nbrDisplaying = 0
RegisterNetEvent('globals:startActionMessage')
AddEventHandler('globals:startActionMessage', function(source, text, maxDist, time)
  offset = 0 + (nbrDisplaying*0.06)
  if nbrDisplaying < 5 then
    local targetPlayer = GetPlayerFromServerId(source)
    if targetPlayer ~= -1 then
      Display(targetPlayer, text, offset, maxDist, time)
    end
  end
end)

function Display(ped, text, offset, maxDist, time)
  local displaying = true
  Citizen.CreateThread(function()
    Wait(time)
    displaying = false
  end)
  Citizen.CreateThread(function()
    nbrDisplaying = nbrDisplaying + 1
    while displaying do
      Wait(0)
      local targetPedCoords = GetEntityCoords(GetPlayerPed(ped), false)
      local myCoords = GetEntityCoords(PlayerPedId())
      if Vdist(targetPedCoords, myCoords) < maxDist then
        DrawText3D(targetPedCoords['x'], targetPedCoords['y'], targetPedCoords['z']+offset+0.3, text)
      end
    end
    nbrDisplaying = nbrDisplaying - 1
  end)
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

function GetUserInput(placeholder, charLimit)
  -- get withdraw amount from user input --
  --DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 15 )
  TriggerEvent("hotkeys:enable", false)
  DisplayOnscreenKeyboard(1, "", "", (placeholder or ""), "", "", "", (charLimit or 15))
  while true do
      if ( UpdateOnscreenKeyboard() == 1 ) then
          local input = GetOnscreenKeyboardResult()
          if ( string.len( input ) > 0 ) then
              -- do something with the input var
              TriggerEvent("hotkeys:enable", true)
              return input
          else
              DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 15 )
          end
      elseif ( UpdateOnscreenKeyboard() == 2 ) then
          break
      end
      Wait( 0 )
  end
  TriggerEvent("hotkeys:enable", true)
end

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

function Draw3DTextForOthers(msg)
	TriggerServerEvent("globals:send3DText", msg)
end

function DrawTimerBar(beginTime, duration, x, y, text)
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

function dump(o)
  if type(o) == 'table' then
     local s = '{ '
     for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. dump(v) .. ','
     end
     return s .. '} '
  else
     return tostring(o)
  end
end

function loadAnimDict(dict)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
      Wait(1)
  end
end

function getClosestVehicle(maxRange)
  local me = PlayerPedId()
  local mycoords = GetEntityCoords(me)
  local closest = {}
  closest.dist = 999999999
  closest.veh = nil
  for veh in EnumerateVehicles() do
      local vehCoords = GetEntityCoords(veh)
      local dist = Vdist(mycoords.x, mycoords.y, mycoords.z, vehCoords.x, vehCoords.y, vehCoords.z)
      if dist < closest.dist and dist < (maxRange or 500) then
          closest.dist = dist
          closest.handle = veh
      end
  end
  return closest.handle
end

function trim(s)
  if s then
    return (s:gsub("^%s*(.-)%s*$", "%1"))
  end
end

function createCulledNonNetworkedPedAtCoords(model, locations, maxDist, _3dText, _3dTextDrawDist, keypressFunc, key)
  local nearbyLocation = nil
  if type(model) == "string" then
      model = GetHashKey(model)
  end
  -- spawn ped when close, delete when far
  Citizen.CreateThread(function()
    local shopNPCHandles = {}
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId(), false)
        nearbyLocation = nil
        for i = 1, #locations do
          local dist = Vdist(playerCoords, locations[i].x, locations[i].y, locations[i].z)
          if dist < maxDist then
            nearbyLocation = locations[i]
            nearbyLocation.dist = dist
            if not shopNPCHandles[i] then
              RequestModel(model)
              while not HasModelLoaded(model) do
                  Wait(1)
              end
              shopNPCHandles[i] = CreatePed(0, model, locations[i].x, locations[i].y, locations[i].z - 0.5, (locations[i].heading or 0), false, false) -- need to add distance culling
              SetEntityCanBeDamaged(shopNPCHandles[i],false)
              SetPedCanRagdollFromPlayerImpact(shopNPCHandles[i],false)
              SetBlockingOfNonTemporaryEvents(shopNPCHandles[i],true)
              SetPedFleeAttributes(shopNPCHandles[i],0,0)
              SetPedCombatAttributes(shopNPCHandles[i],17,1)
              SetPedRandomComponentVariation(shopNPCHandles[i], true)
              TaskStartScenarioInPlace(shopNPCHandles[i], "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
              Wait(5000)
              FreezeEntityPosition(shopNPCHandles[i], true)
            end
          else 
            if shopNPCHandles[i] then
                DeletePed(shopNPCHandles[i])
                shopNPCHandles[i] = nil
            end
          end
        end
        Wait(1000)
    end
  end)
  -- draw 3d text when nearby
  if _3dText then
    Citizen.CreateThread(function()
      while true do
        if nearbyLocation and nearbyLocation.dist <= _3dTextDrawDist then
          DrawText3D(nearbyLocation.x, nearbyLocation.y, nearbyLocation.z, _3dText)
          -- listen for keypress
          if keypressFunc then
            if IsControlJustPressed(0, key) then
              keypressFunc()
            end
          end
        end
        Wait(1)
      end
    end)
  end
end

function playAnimation(dict, name, duration, flag, timerBarText)
  exports.globals:loadAnimDict(dict)
  Citizen.CreateThread(function()
      TriggerEvent("interaction:setBusy", true)
      local me = PlayerPedId()
      local startTime = GetGameTimer()
      while GetGameTimer() - startTime < duration do
          if timerBarText then
              exports.globals:DrawTimerBar(startTime, duration, 1.42, 1.475, timerBarText)
          end
          if not IsEntityPlayingAnim(me, dict, name, 3) then
              TriggerEvent("usa:playAnimation", dict, name, -8, 1, -1, flag, 0, 0, 0, 0)
          end
          Wait(1)
      end
      if not IsPedInAnyVehicle(me, true) then
          ClearPedTasksImmediately(me)
      else
          if IsEntityPlayingAnim(me, dict, name, 3) then
              StopAnimTask(me, dict, name, 1.0)
          end
          ClearPedTasks(me)
      end
      TriggerEvent("interaction:setBusy", false)
  end)
end

exports("sleep", function(timeMs)
  local start = GetGameTimer()
  while GetGameTimer() - start < timeMs do
    Wait(1)
  end
end)

exports("tableToVector3", function(coordTable)
	return vector3(coordTable.x, coordTable.y, coordTable.z)
end)