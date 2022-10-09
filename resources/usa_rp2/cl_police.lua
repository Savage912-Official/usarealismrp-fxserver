local spawnedCones = {}
local radioMuted = false

RegisterNetEvent("police:panicBlip")
AddEventHandler("police:panicBlip", function(targetID, name)
  local PANIC_BLIP_DURATION_SECONDS = 30
  local blipID = 161
  local blipHandle = AddBlipForEntity(GetPlayerPed(GetPlayerFromServerId(targetID)))
  SetBlipSprite(blipHandle, blipID)
  SetBlipSprite(blipHandle, 458)
  SetBlipDisplay(blipHandle, 4)
  SetBlipScale(blipHandle, 1.3)
  SetBlipFlashes(blipHandle, 458, true)
  SetBlipColour(blipHandle, 59)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Panic (" .. name .. ")")
  EndTextCommandSetBlipName(blipHandle)
  local start = GetGameTimer()
  while GetGameTimer() - start < PANIC_BLIP_DURATION_SECONDS * 1000 do
    Wait(1)
  end
  RemoveBlip(blipHandle)
end)

RegisterNetEvent("police:panicBlipAtCoord")
AddEventHandler("police:panicBlipAtCoord", function(coord, name)
  local PANIC_BLIP_DURATION_SECONDS = 30
  local blipID = 161
  local blipHandle = AddBlipForCoord(coord.x, coord.y, coord.z)
  SetBlipSprite(blipHandle, blipID)
  SetBlipSprite(blipHandle, 458)
  SetBlipDisplay(blipHandle, 4)
  SetBlipScale(blipHandle, 1.3)
  SetBlipFlashes(blipHandle, 458, true)
  SetBlipColour(blipHandle, 59)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Panic (" .. name .. ")")
  EndTextCommandSetBlipName(blipHandle)
  local start = GetGameTimer()
  while GetGameTimer() - start < PANIC_BLIP_DURATION_SECONDS * 1000 do
    Wait(1)
  end
  RemoveBlip(blipHandle)
end)

RegisterNetEvent("police:muteRadio")
AddEventHandler("police:muteRadio", function()
    radioMuted = not radioMuted
    if radioMuted then
        exports.tokovoip_script:removePlayerFromRadio(1)
    else
        exports.tokovoip_script:addPlayerToRadio(1)
        exports.globals:notify("Radio ~g~enabled~w~!")
    end
end)

Citizen.CreateThread(function()
    while true do
        if radioMuted then
            exports.globals:notify("Radio ~r~muted~w~!")
            Wait(1000)
        end
        Wait(2)
    end
end)

RegisterNetEvent("dispatch:setWaypoint")
AddEventHandler("dispatch:setWaypoint", function(targetServerId)
    local targetPed = GetPlayerFromServerId(targetServerId)
    --Citizen.Trace("targetPed = " .. targetPed)
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(targetPed), false))
    --Citizen.Trace("x = " .. x .. ", y = " .. y .. ", z = " .. z)
    ClearGpsPlayerWaypoint()
    SetNewWaypoint(x,y)
    --Citizen.Trace("waypoint set!")
end)

-- barrier --
RegisterNetEvent('createObject')
AddEventHandler('createObject', function(obj)
    SetObjectOnGround(obj)
end)

-- cone --
RegisterNetEvent('c_setCone')
AddEventHandler('c_setCone', function()
    SetConeOnGround()
end)

RegisterNetEvent('c_removeCones')
AddEventHandler('c_removeCones', function()
    removeCones()
end)

RegisterNetEvent('dispatch:notify')
AddEventHandler('dispatch:notify', function(lastName, source, msg)
  TriggerEvent('chatMessage', "", {255, 20, 10}, '^5^*[DISPATCH] ^r^0'..lastName..' ['..source..']: ^5'..msg) -- send to caller
  PlaySoundFrontend(-1,"Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
end)

-- SEARCH COMMAND --------------------------------------------------------------------------------------------------------

-- searches this client's player if hands are tied or is incapacitated
RegisterNetEvent("search:civSearchCheck")
AddEventHandler("search:civSearchCheck", function(searchedSrc, searcherSrc, isLEO)
  local me = PlayerPedId()
  local isIncapacitated = IsPedDeadOrDying(me, 1)
  local handsTied = exports["usa_rp2"]:areHandsTied()
  local handsUp = exports["usa_rp2"]:areHandsUp()
  if isIncapacitated or handsTied or isLEO or handsUp then
    TriggerServerEvent("search:searchPlayer", searchedSrc, searcherSrc)
  else
    TriggerServerEvent("search:civSearchedCheckFailedNotify", searcherSrc)
  end
end)

RegisterClientCallback { 
  eventName = "search:canBeSearched",
  eventCallback = function()
    local isIncapacitated = IsPedDeadOrDying(PlayerPedId(), 1)
    local handsTied = exports["usa_rp2"]:areHandsTied()
    local handsUp = exports["usa_rp2"]:areHandsUp()
    return isIncapacitated or handsTied or handsUp
  end
}

RegisterNetEvent("search:attemptToSearchNearestPerson")
AddEventHandler("search:attemptToSearchNearestPerson", function()
  TriggerEvent("usa:getClosestPlayer", 1.6, function(player)
    if player.id ~= 0 and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
      TriggerServerEvent("search:foundPlayerToSearch", player.id)
    elseif IsPedInAnyVehicle(PlayerPedId(), false) then
      TriggerEvent("veh:searchVeh")
    else
      TriggerEvent("usa:notify", "No person found to search!")
    end
  end)
end)

RegisterNetEvent("search:searchNearest")
AddEventHandler("search:searchNearest", function(src)
  TriggerEvent("usa:getClosestPlayer", 1.6, function(player)
    if player.id ~= 0 and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
      local playerPed = PlayerPedId()
      local playerHeading = GetEntityHeading(playerPed)
      local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.70, -1.0))
      TriggerEvent('search:playAnim')
      TriggerServerEvent('search:playSuspectAnim', player.id, x, y, z, playerHeading)
      Citizen.Wait(10000)
      TriggerServerEvent("search:searchPlayer", player.id, src)
    elseif IsPedInAnyVehicle(PlayerPedId(), false) then
      TriggerEvent("veh:searchVeh")
    end
  end)
end)

RegisterNetEvent("police:friskNearest")
AddEventHandler("police:friskNearest", function(src)
  TriggerEvent("usa:getClosestPlayer", 1.6, function(player)
    if player.id ~= 0 and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
      local playerPed = PlayerPedId()
      local playerHeading = GetEntityHeading(playerPed)
      local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.70, -1.0))
      TriggerEvent('search:playAnim')
      TriggerServerEvent('search:playSuspectAnim', player.id, x, y, z, playerHeading)
      Citizen.Wait(12000)
      TriggerServerEvent("police:frisk", player.id, src)
    end
  end)
end)

RegisterNetEvent("search:playAnim")
AddEventHandler("search:playAnim", function()
  local playerPed = PlayerPedId()
  local playerHeading = GetEntityHeading(playerPed)
  RequestAnimDict('anim@heists@load_box')
  while not HasAnimDictLoaded('anim@heists@load_box') do Citizen.Wait(0) end
  RequestAnimDict('anim@heists@box_carry@')
  while not HasAnimDictLoaded('anim@heists@box_carry@') do Citizen.Wait(0) end
  RequestAnimDict('missbigscore2aig_7@driver')
  while not HasAnimDictLoaded('missbigscore2aig_7@driver') do Citizen.Wait(0) end
  RequestAnimDict('mini@yoga')
  while not HasAnimDictLoaded('mini@yoga') do Citizen.Wait(0) end
  RequestAnimDict('missfam5_yoga')
  while not HasAnimDictLoaded('missfam5_yoga') do Citizen.Wait(0) end
  TaskPlayAnim(playerPed, 'anim@heists@load_box', 'idle', 8.0, 8.0, -1, 1, -1)
  Citizen.Wait(800)
  ClearPedTasks(playerPed)
  TaskPlayAnim(playerPed, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 1, -1)
  Citizen.Wait(800)
  ClearPedTasks(playerPed)
  TaskPlayAnim(playerPed, 'missfam5_yoga', 'start_pose', 8.0, 8.0, -1, 1, -1)
  Citizen.Wait(800)
  ClearPedTasks(playerPed)
  SetEntityHeading(playerPed, playerHeading - 10.0)
  TaskPlayAnim(playerPed, 'missbigscore2aig_7@driver', 'idle_to_boot_l', 8.0, 8.0, -1, 2, -1)
  Citizen.Wait(1500)
  ClearPedTasks(playerPed)
  TaskPlayAnim(playerPed, 'missbigscore2aig_7@driver', 'boot_l_loop', 8.0, 8.0, -1, 2, -1)
  Citizen.Wait(500)
  ClearPedTasks(playerPed)
  TaskPlayAnim(playerPed, 'mini@yoga', 'outro_2', 8.0, 8.0, -1, 1, -1)
  Citizen.Wait(2000)
  ClearPedTasks(playerPed)
  SetEntityHeading(playerPed, playerHeading + 10.0)
  TaskPlayAnim(playerPed, 'missbigscore2aig_7@driver', 'idle_to_boot_r', 8.0, 8.0, -1, 2, -1)
  Citizen.Wait(500)
  ClearPedTasks(playerPed)
  TaskPlayAnim(playerPed, 'missbigscore2aig_7@driver', 'boot_r_loop', 8.0, 8.0, -1, 2, -1)
  Citizen.Wait(1500)
  ClearPedTasks(playerPed)
  TaskPlayAnim(playerPed, 'mini@yoga', 'outro_2', 8.0, 8.0, -1, 1 , -1)
  Citizen.Wait(2000)
  ClearPedTasks(playerPed)
end)

RegisterNetEvent("search:playSuspectAnim")
AddEventHandler("search:playSuspectAnim", function(x, y, z, heading)
  local playerPed = PlayerPedId()
  FreezeEntityPosition(playerPed, true)
  SetEntityCoords(playerPed, x, y, z)
  SetEntityHeading(playerPed, heading)
  Citizen.Wait(13000)
  FreezeEntityPosition(playerPed, false)
end)


----------------------------------------------------------------------------------------------------------------------------

function SetObjectOnGround(obj)
    barrier = GetHashKey(obj)
    RequestModel(barrier)
    while not HasModelLoaded(barrier) do
      Wait(1)
    end
    local playerped = GetPlayerPed(-1)
    local coords = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 2.0, 0.0)
    local object = CreateObject(barrier, coords.x, coords.y, coords.z-1.9, true, true, false)
    PlaceObjectOnGroundProperly(object)
    local player_heading =  GetEntityHeading(playerped)
    SetEntityHeading(object, player_heading)
    table.insert(spawnedCones, object)
end

function SetConeOnGround()
    barrier = GetHashKey("prop_mp_cone_01")
    RequestModel(barrier)
    while not HasModelLoaded(barrier) do
      Citizen.Wait(1)
    end
    local playerped = GetPlayerPed(-1)
    local coords = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 2.0, 0.0)
    local object = CreateObject(barrier, coords.x, coords.y, coords.z-1.9, true, true, false)
    PlaceObjectOnGroundProperly(object)
    local player_heading =  GetEntityHeading(playerped)
    SetEntityHeading(object, player_heading)
    table.insert(spawnedCones, object)
end

function removeCones()
    for i = 1, #spawnedCones do
        local cone = spawnedCones[i]
        SetEntityAsMissionEntity(cone, true, true)
        DeleteObject(cone)
    end
    spawnedCones = {}
end

function requestDict(dict)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do Citizen.Wait(0) end
end

RegisterNetEvent("police:notify")
AddEventHandler("police:notify", function(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end)

RegisterNetEvent("police:getMoneyInput")
AddEventHandler("police:getMoneyInput", function()
  Citizen.CreateThread( function()
    TriggerEvent("hotkeys:enable", false)
    DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
    while true do
      if ( UpdateOnscreenKeyboard() == 1 ) then
          local input_amount = GetOnscreenKeyboardResult()
          if ( string.len( input_amount ) > 0 ) then
              local amount = tonumber( input_amount )
              if ( amount > 0 ) then
                  -- todo: prevent decimals
                  -- trigger server event to remove money
                  amount = round(amount, 0)
                  TriggerServerEvent("police:seizeCash", amount)
              end
              break
          else
              DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
          end
      elseif ( UpdateOnscreenKeyboard() == 2 ) then
          break
      end
      Citizen.Wait( 0 )
    end
    TriggerEvent("hotkeys:enable", true)
  end)
end)

function getVehicleInFrontOfUser()
	local playerped = GetPlayerPed(-1)
	local coordA = GetEntityCoords(playerped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 2.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)
	return targetVehicle
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function DrawSpecialText(m_text)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(250, 1)
end

---------------------------------------------------------------------
-- BAITCAR SCRIPT --
---------------------------------------------------------------------
local isInBaitCar = false
RegisterNetEvent("simp:baitCarDisable")
AddEventHandler("simp:baitCarDisable", function()
	local playerPed = PlayerPedId()
	local playerVeh = GetVehiclePedIsIn(playerPed)
	if IsPedInAnyVehicle(playerPed, false) then
		print("locking the doors!")
			SetVehicleDoorShut(playerVeh, 0, true)
			SetVehicleDoorShut(playerVeh, 1, true)
			SetVehicleDoorShut(playerVeh, 2, true)
			SetVehicleDoorShut(playerVeh, 3, true)
			SetVehicleDoorShut(playerVeh, 4, true)
			SetVehicleDoorShut(playerVeh, 5, true)
			TaskVehicleTempAction(playerPed, playerVeh, 27, 5000)
			PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 1)
			isInBaitCar = true
			SetVehicleEngineHealth(playerVeh, -4000)
			SetVehicleDoorsLocked(playerVeh, 4)
			SetNotificationTextEntry("STRING")
			AddTextComponentString("~r~WARNING:~s~~n~This is the SA State Police. You are under arrest.")
			DrawNotification(true, true)
	end
end)

RegisterNetEvent("simp:baitCarunlock")
AddEventHandler("simp:baitCarunlock", function()
	local playerPed = PlayerPedId()
	local playerVeh = GetVehiclePedIsIn(playerPed)
	if IsPedInAnyVehicle(playerPed, false) then
		isInBaitCar = false;
		SetVehicleDoorsLocked(playerVeh, 2)
		SetVehicleDoorsLocked(playerVeh, 1)
		SetNotificationTextEntry("STRING")
		AddTextComponentString('~y~Info:~s~~n~Step out of the vehicle and follow the instructions you are given.')
		DrawNotification(true, true)
	end
end)

-----------------------------------------------------------------------------------------------------------------------
-- BAITCAR SCRIPT CREATED BY TONI MORTON FOR THE FIVEM COMMUNITY, PLEASE GIVE CREDITS TO ME IF YOU USE THIS SCRIPT IN YOUR SERVER.  --
-----------------------------------------------------------------------------------------------------------------------

------------------end baitcar--------------------------

-- todo: somehow convet RGB value of vehicle color to human readable name for 911 report above
-- 15, 15, 15 or anything less = black
-- 240, 240, 240 or greater = white
-- 63, 66, 40 = dark green
-- 28, 30, 33 = gray
-- 74, 10, 10 = red

function GetClosestPlayerInfo(range)
	local closestDistance = 0
	local closestPlayerServerId = 0
	local closestName = ""
	for x = 0, 255 do
		if NetworkIsPlayerActive(x) then
			targetPed = GetPlayerPed(x)
			targetPedCoords = GetEntityCoords(targetPed, false)
			playerPedCoords = GetEntityCoords(GetPlayerPed(-1), false)
			distanceToTargetPed = Vdist(playerPedCoords.x, playerPedCoords.y, playerPedCoords.z, targetPedCoords.x, targetPedCoords.y, targetPedCoords.z)
			if targetPed ~= GetPlayerPed(-1) and IsEntityVisible(targetPed) then
				if distanceToTargetPed < range then
					if closestDistance == 0 then
						closestDistance = distanceToTargetPed
						closestPlayerServerId = GetPlayerServerId(x)
						closestName = GetPlayerName(x)
						hitHandlePed = GetPlayerPed(x)
						--rayHandle = CastRayPointToPoint(playerPedCoords.x, playerPedCoords.y, playerPedCoords.z, targetPedCoords.x, targetPedCoords.y, targetPedCoords.z, 12, GetPlayerPed(-1), 0)
						--a, b, c, d, hitHandlePed = GetRaycastResult(rayHandle)
					else
						if distanceToTargetPed <= closestDistance then
							closestDistance = distanceToTargetPed
							closestPlayerServerId = GetPlayerServerId(x)
							closestName = GetPlayerName(x)
							hitHandlePed = GetPlayerPed(x)
							--rayHandle = CastRayPointToPoint(playerPedCoords.x, playerPedCoords.y, playerPedCoords.z, targetPedCoords.x, targetPedCoords.y, targetPedCoords.z, 12, GetPlayerPed(-1), 0)
							--a, b, c, d, hitHandlePed = GetRaycastResult(rayHandle)
						end
					end
				end
			end
		end
	end
	return closestPlayerServerId, closestName, closestDistance
end

function ConvertRealCarToGtaCar(name)
  if string.lower(name) == "sabregt" then
    return "Ford Mustang Boss 302"
  elseif string.lower(name) == "sadler" then
    return "Ford F350 Super Duty"
  elseif string.lower(name) == "fugitive" then
    return "Masseratti Quattroporte"
  elseif string.lower(name) == "buffalo" then
    return "Chrystler 300C"
  elseif string.lower(name) == "ruiner" then
	return "Imponte Ruiner"
  elseif string.lower(name) == "bobcatxl" then
	return "Vapid Bobcat XL"
  elseif string.lower(name) == "dubsta" then
	return "Benefactor Dubsta"
  elseif string.lower(name) == "tornado3" then
	return "Declasse Tornado"
  elseif string.lower(name) == "oracle2" then
	return "Ubermacht Oracle XS"
  elseif string.lower(name) == "rebel02" then
	return "Karin Rebel"
  elseif string.lower(name) == "sanchez02" then
	return "Miabatsu Sanchez"
  elseif string.lower(name) == "sandking" then
	return "Vapid Sandking XL"
  elseif string.lower(name) == "emperor" then
	return "Albany Emperor"
  elseif string.lower(name) == "seminole" then
	return "Canis Seminole"
  elseif string.lower(name) == "blista2" then
	return "Dinka Blista Compact"
  elseif string.lower(name) == "flatbed" then
	return "MTL Flatbed (tow)"
  elseif string.lower(name) == "scrap" then
	return "Utility Scrap Truck"
  elseif string.lower(name) == "peyote" then
	return "Vapid Peyote"
  elseif string.lower(name) == "bfinject" then
	return "BF Injection"
  elseif string.lower(name) == "penumbra" then
	return "Nissan 370z"
  else
    return name
  end
end

RegisterNetEvent('badge:client:animation')
AddEventHandler('badge:client:animation', function()
    Citizen.CreateThread(function()
      local ped = PlayerPedId()
      local coords = GetEntityCoords(ped)
      local badgeProp = CreateObject(GetHashKey("prop_fib_badge"), coords.x, coords.y, coords.z + 0.2, true, true, true)
      local boneIndex = GetPedBoneIndex(ped, 28422)
      
      AttachEntityToEntity(badgeProp, ped, boneIndex, 0.0600, 0.0210, -0.0400, -90.00, -180.00, 78.999, true, true, false, true, 1, true)
      exports.globals:loadAnimDict('paper_1_rcm_alt1-8')
      TaskPlayAnim(ped, 'paper_1_rcm_alt1-8', 'player_one_dual-8', 8.0, -8, 10.0, 49, 0, 0, 0, 0)
      Citizen.Wait(3000)
      ClearPedSecondaryTask(ped)
      DeleteObject(badgeProp)
    end)
end)