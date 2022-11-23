local hands_up = false
local hands_tied = false
local blindfolded = false

local bag = nil

---------------
-- blindfold --
---------------
RegisterNetEvent("crim:blindfold")
AddEventHandler("crim:blindfold", function(on, dont_send_message, dont_notify)
  --SetNuiFocus(on, false)
  SendNUIMessage({
    type = "enableui",
    enable = on,
    blindfold = on
  })
  blindfolded = on
  if not dont_send_message then
    if on then
      if not dont_notify then
        TriggerEvent("usa:notify", "You have been blindfolded!")
      end
      bag = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true) -- Create head bag object!
      AttachEntityToEntity(bag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- Attach object to head
    else
      if not dont_notify then
        TriggerEvent("usa:notify", "Blindfold removed!")
      end
      DeleteEntity(bag)
      SetEntityAsNoLongerNeeded(bag)
    end
  end
end)

RegisterNetEvent("crim:attemptToBlindfoldNearestPerson")
AddEventHandler("crim:attemptToBlindfoldNearestPerson", function(blindfold)
  TriggerEvent("usa:getClosestPlayer", 1.5, function(player)
    if player.id ~= 0 and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
      TriggerServerEvent("crim:foundPlayerToBlindfold", player.id, blindfold)
    else
      TriggerEvent("usa:notify", "No person found to blindfold!")
    end
  end)
end)

RegisterNetEvent("civ:robPlayerIfTiedOrDowned")
AddEventHandler("civ:robPlayerIfTiedOrDowned", function(fromSrc)
  local me = PlayerPedId()
  local isDowned = IsPedDeadOrDying(me, 1)
  local isTied = exports["usa_rp2"]:areHandsTied()
  local handsUp = exports["usa_rp2"]:areHandsUp()
  if isDowned or isTied or handsUp then
    TriggerServerEvent("civ:continueRobbingPlayer", fromSrc)
  else
    TriggerServerEvent("civ:notify", fromSrc, "Person not downed / hands tied / hands not up")
  end
end)

RegisterNetEvent("crim:attemptToRobNearestPerson")
AddEventHandler("crim:attemptToRobNearestPerson", function()
  TriggerEvent("usa:getClosestPlayer", 1.5, function(player)
    if player.id ~= 0 and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
      TriggerServerEvent("crim:foundPlayerToRob", player.id)
    else
      TriggerEvent("usa:notify", "No person found to rob!")
    end
  end)
end)

RegisterNetEvent("crim:attemptToTieNearestPerson")
AddEventHandler("crim:attemptToTieNearestPerson", function(tying_up)
  TriggerEvent("usa:getClosestPlayer", 1.5, function(player)
    if player.id ~= 0 and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
      local playerPed = PlayerPedId()
      local playerCoords = GetEntityCoords(playerPed)
      local playerHeading = GetEntityHeading(playerPed)
      local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.65, -1.0))
      TriggerServerEvent("crim:foundPlayerToTie", player.id, tying_up, x, y, z, playerHeading)
    else
      TriggerEvent("usa:notify", "No person found to tie!")
    end
  end)
end)

RegisterNetEvent("crim:tieHands")
AddEventHandler("crim:tieHands", function(x, y, z, heading)
  local close_enough = false
  local playerPed = PlayerPedId()
  if DoesEntityExist(playerPed) then
    -- tie up hands:
    Citizen.CreateThread(function()
      RequestAnimDict("mp_arresting")
      while not HasAnimDictLoaded("mp_arresting") do
        Citizen.Wait(100)
      end
      RequestAnimDict('mp_arrest_paired')
      while not HasAnimDictLoaded('mp_arrest_paired') do
          Citizen.Wait(0)
      end
      --local tying_hands = true
      --[[
      local resisted = false
      Citizen.CreateThread(function()
        TriggerEvent('usa:showHelp', true, 'Tap ~INPUT_PICKUP~ to resist being tied up!')
        local resistance = 0
        while tying_hands do
          Citizen.Wait(0)
          if resistance > 0 then
            DrawTimer(GetGameTimer() - resistance, 3200, 1.42, 1.475, 'RESISTING')
          end
          if IsControlJustPressed(0, 38) then
            resistance = resistance + 250
            if resistance > 3200 then
              ClearPedTasks(playerPed)
              FreezeEntityPosition(playerPed, false)
              DisablePlayerFiring(playerPed, false)
              resisted = true
              TriggerEvent('usa:showHelp', true, 'You have resisted being tied up!')
              break
            end
          end
        end
      end)
      --]]
      DisablePlayerFiring(playerPed, true)
      SetEntityCoords(playerPed, x, y, z)
      SetEntityHeading(playerPed, heading)
      Citizen.Wait(100)
      ClearPedTasksImmediately(playerPed)
      FreezeEntityPosition(playerPed, true)
      TaskPlayAnim(playerPed, "mp_arrest_paired", "crook_p2_back_right", 8.0, 1.0, -1, 6, 0, 0, 0, 0)
      Citizen.Wait(3200)
      ClearPedTasks(playerPed)
      FreezeEntityPosition(playerPed, false)
      DisablePlayerFiring(playerPed, false)
      ClearPedSecondaryTask(playerPed)
      --tying_hands = false
      --if not resisted then
      TaskPlayAnim(playerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      -- FreezeEntityPosition(lPed, true)
      TriggerEvent("usa:showHelp", true, "Your hands have been ~r~tied together~w~.")
      hands_tied = true
      hands_up = false
      --end
    end)
  end
end)

RegisterNetEvent("crim:untieHands")
AddEventHandler("crim:untieHands", function(from_id, x, y, z, heading)
  if hands_tied then
    local playerPed = PlayerPedId()
    if DoesEntityExist(playerPed) then
      if closeEnoughToPlayer(from_id) then
        hands_tied = false
        ClearPedSecondaryTask(playerPed)
        SetEnableHandcuffs(playerPed, false)
        RequestAnimDict('mp_arrest_paired')
        while not HasAnimDictLoaded('mp_arrest_paired') do
          Citizen.Wait(0)
        end
        DisablePlayerFiring(playerPed, true)
        SetEntityCoords(playerPed, x, y, z)
        SetEntityHeading(playerPed, heading)
        Citizen.Wait(100)
        ClearPedTasksImmediately(playerPed)
        FreezeEntityPosition(playerPed, true)
        TaskPlayAnim(playerPed, "mp_arrest_paired", "crook_p2_back_right", 8.0, 1.0, -1, 6, 0, 0, 0, 0)
        Citizen.Wait(3200)
        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
        DisablePlayerFiring(playerPed, false)
        ClearPedSecondaryTask(playerPed)
        SetEnableHandcuffs(playerPed, false)
        --FreezeEntityPosition(lPed, false)
        TriggerEvent("usa:showHelp", true, "You have been ~g~released~w~.")
      end
    end
  end
end)

RegisterNetEvent('crim:tyingHandsAnim')
AddEventHandler('crim:tyingHandsAnim', function()
  local playerPed = PlayerPedId()
  RequestAnimDict('mp_arrest_paired')
  RequestAnimDict('missprologueig_2')
  while not HasAnimDictLoaded('mp_arrest_paired') do
      Citizen.Wait(0)
  end
  while not HasAnimDictLoaded('missprologueig_2') do
      Citizen.Wait(0)
  end
  FreezeEntityPosition(playerPed, true)
  ClearPedTasksImmediately(playerPed)
  TaskPlayAnim(playerPed, "mp_arrest_paired", "cop_p2_back_right", 8.0, 1.0, -1, 6, 0, 0, 0, 0)
  Citizen.Wait(3600)
  ClearPedTasks(playerPed)
  FreezeEntityPosition(playerPed, false)
end)

RegisterNetEvent('ping:requestPing')
AddEventHandler('ping:requestPing', function()
  local playerPed = PlayerPedId()
  if not IsPedCuffed(playerPed) then
    TriggerEvent('usa:showHelp', true, 'A person has requested your location, use /pingaccept to accept this request.')
    TriggerEvent('usa:notify', 'A person has requested your location, use /pingaccept to accept this request.')
  end
end)

RegisterNetEvent('ping:sendLocation')
AddEventHandler('ping:sendLocation', function(coords)
  TriggerEvent('usa:showHelp', true, 'Your ping accept was requested, check your GPS!')
  TriggerEvent('usa:notify', 'Your ping request was accepted, check your GPS!')
  local newBlip = {
      handle = nil,
      created_at = nil
  }
  local handle = AddBlipForCoord(coords.x, coords.y, coords.z)
  SetNewWaypoint(coords.x, coords.y)
  SetBlipSprite(handle, 280)
  SetBlipDisplay(handle, 2)
  SetBlipScale(handle, 1.2)
  SetBlipColour(handle, 48)
  SetBlipAsShortRange(handle, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Ping Location')
  EndTextCommandSetBlipName(handle)
  Citizen.Wait(60000)
  RemoveBlip(handle)
end)

Citizen.CreateThread(function()
	while true do
		Wait(5)
    local playerPed = PlayerPedId()
		if hands_tied then
			--DisableControlAction(1, 245, true) 245 = 5 FOR TEXT CHAT
			DisableControlAction(1, 117, true)
			DisableControlAction(1, 73, true)
			DisableControlAction(1, 29, true)
			DisableControlAction(1, 322, true)

			--DisableControlAction(1, 18, true)
			DisableControlAction(1, 24, true)
			DisableControlAction(1, 69, true)
			DisableControlAction(1, 92, true)
			DisableControlAction(1, 106, true)
			DisableControlAction(1, 122, true)
			DisableControlAction(1, 135, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 144, true)
			--DisableControlAction(1, 176, true)
			DisableControlAction(1, 223, true)
			DisableControlAction(1, 229, true)
			DisableControlAction(1, 237, true)
			DisableControlAction(1, 257, true)
			DisableControlAction(1, 329, true)
			DisableControlAction(1, 80, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 250, true)
			DisableControlAction(1, 263, true)
			DisableControlAction(1, 310, true)
			--DisableControlAction(0, 288, true) -- interaction menu (F1)

			DisableControlAction(1, 22, true)
			DisableControlAction(1, 55, true)
			DisableControlAction(1, 76, true)
			DisableControlAction(1, 102, true)
			DisableControlAction(1, 114, true)
			DisableControlAction(1, 143, true)
			DisableControlAction(1, 179, true)
			DisableControlAction(1, 193, true)
			DisableControlAction(1, 203, true)
			DisableControlAction(1, 216, true)
			DisableControlAction(1, 255, true)
			DisableControlAction(1, 298, true)
			DisableControlAction(1, 321, true)
			DisableControlAction(1, 328, true)
			DisableControlAction(1, 331, true)
			DisableControlAction(0, 63, false)
			DisableControlAction(0, 64, false)
			DisableControlAction(0, 59, false)
			DisableControlAction(0, 278, false)
			DisableControlAction(0, 279, false)
			DisableControlAction(0, 68, false)
			DisableControlAction(0, 69, false)
			DisableControlAction(0, 75, false)
			DisableControlAction(0, 76, false)
			DisableControlAction(0, 102, false)
			DisableControlAction(0, 81, false)
			DisableControlAction(0, 82, false)
			DisableControlAction(0, 83, false)
			DisableControlAction(0, 84, false)
			DisableControlAction(0, 85, false)
			DisableControlAction(0, 86, false)
			DisableControlAction(0, 106, false)
			DisableControlAction(0, 25, false)

			-- slow down while cuffed
			--SetEntityVelocity(GetPlayerPed(-1), 0.3, 0.3, 0.0)
			DisableControlAction(0, 21, true)

			if not IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 3) then
				RequestAnimDict("mp_arresting")
				while not HasAnimDictLoaded("mp_arresting") do
					Wait(100)
				end
				TaskPlayAnim(playerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
			end
		end
		-- remove blind folds if dead:
		if IsPedDeadOrDying(playerPed, 1) and blindfolded then
			TriggerEvent("crim:blindfold", false, true)
			blindfolded = false
		end
	end
end)

RegisterNetEvent('cuff:forceHandsDown')
AddEventHandler('cuff:forceHandsDown', function(cb)
  hands_up = false
  cb()
end)
-- hands up animation --
Citizen.CreateThread(function()
  local dict = "ped"
  local anim = "handsup_base"
  while true do
    local playerPed = PlayerPedId()
    DisableControlAction(0, 73, true)
    if IsControlPressed(1, 323) and DoesEntityExist(playerPed) and not IsPedDeadOrDying(playerPed) then
      Citizen.CreateThread(function()
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
          Citizen.Wait(100)
        end
        if not hands_up then
          hands_up = true
          TaskPlayAnim(playerPed, dict, anim,  8.0, -8, -1, 49, 0, 0, 0, 0)
        end
      end)
    end
    if IsControlReleased(1, 323) then
      Citizen.Wait(500)
      if DoesEntityExist(playerPed) then
        Citizen.CreateThread(function()
          RequestAnimDict(dict)
          while not HasAnimDictLoaded(dict) do
            Citizen.Wait(100)
          end
          if hands_up then
            hands_up = false
            TriggerServerEvent("civ:handsDown")
            ClearPedSecondaryTask(playerPed)
            Wait(800)
          end
        end)
      end
    end
    Wait(0)
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if hands_up then
      DisableControlAction(24, 37, true)
      DisablePlayerFiring(ped, true)
      DisableControlAction(0, 21, true)
      DisableControlAction(0, 22, true)
      DisableControlAction(0, 23, true)
      DisableControlAction(0, 26, true)
      DisableControlAction(0, 24, true)
      DisableControlAction(0, 25, true)
      DisableControlAction(0, 44, true)
      DisableControlAction(0, 140, true)
      DisableControlAction(0, 141, true)
      DisableControlAction(0, 142, true)
      if IsPedInAnyVehicle(PlayerPedId(), true) and hands_up then
        DisableControlAction(20, 30, true)
      end
    end
  end
end)

RegisterNetEvent("crim:areHandsUp")
AddEventHandler("crim:areHandsUp", function(from_source, to_source, action, x, y, z, heading)
  if hands_up == true and closeEnoughToPlayer(from_source) then
    if action == "tie" then
      TriggerServerEvent("crim:continueTyingHands", from_source, to_source, true, x, y, z, heading)
    elseif action == "rob" then
      TriggerServerEvent("crim:continueRobbing", true, from_source, to_source)
    elseif action == "search" then
      TriggerServerEvent("search:searchPlayer", to_source, from_source)
    end
  else
    TriggerServerEvent("crim:continueTyingHands", from_source, to_source, false)
  end
end)

RegisterNetEvent("crim:areHandsTied")
AddEventHandler("crim:areHandsTied", function(from_source, to_source, action)
  -- don't need to check distance (or can't cause ped is in vehicle):
  if action == "unseat" then
    if hands_tied == true then
      TriggerEvent("place:unseat", from_source, false)
      return
    end
  end
  -- need to check distance
  if hands_tied == true and closeEnoughToPlayer(from_source) then
    if action == "rob" then
      -- hands were up, continue stealing cash
      TriggerServerEvent("crim:continueRobbing", true, from_source, to_source)
    elseif action == "blindfold" then
      TriggerServerEvent("crim:continueBlindfolding", true, from_source, to_source)
    elseif action == "placet" then
      TriggerEvent('trunkhide:hideInNearestTrunk')
    elseif action == "search" then
      TriggerServerEvent("search:searchPlayer", to_source, from_source)
    end
  else
    -- notify player that their target's hands were(n't) tied
    TriggerServerEvent("crim:continueRobbing", false, from_source, to_source)
  end
end)

local currentWalkstyle = nil

RegisterNetEvent("civ:changeWalkStyle")
AddEventHandler("civ:changeWalkStyle", function(style)
	if style and style ~= 0 then
		SetClipset(style)
    currentWalkstyle = style -- used in client.lua to set walk style when recovered from low hp
	else
		ResetPedMovementClipset(GetPlayerPed(-1), 0 )
    currentWalkstyle = nil
	end
end)

RegisterNetEvent("civ:forceWalkStyle")
AddEventHandler("civ:forceWalkStyle", function(style)
  if style and style ~= 0 then
    SetClipset(style)
  else
    ResetPedMovementClipset(GetPlayerPed(-1), 0 )
  end
end)

RegisterNetEvent("civ:resetWalkStyle")
AddEventHandler("civ:resetWalkStyle", function()
  SetClipset(currentWalkstyle)
end)

local lastVehicle = {
  handle = 0,
  enabled = false,
  underglow = {}
}

RegisterNetEvent("civ:toggleUnderglow")
AddEventHandler("civ:toggleUnderglow", function()
  --print('underglow!')
  local playerPed = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(playerPed)
  if GetPedInVehicleSeat(playerVeh, -1) == playerPed then
    --print('is driver')
    if playerVeh == lastVehicle.handle then
      --print('player in old vehicle!')
      if not lastVehicle.enabled then
        --print('enabling!')
        for i = 1, #lastVehicle.underglow do
          local index = lastVehicle.underglow[i]
          SetVehicleNeonLightEnabled(playerVeh, index, true)
        end
        lastVehicle.enabled = true
      else
        --print('disabling!')
        for i = 0, 3 do
          SetVehicleNeonLightEnabled(playerVeh, i, false)
        end
        lastVehicle.enabled = false
      end
    else
      --print('player is in a new vehicle')
      if lastVehicle.handle ~= 0 then
        SetVehicleNeonLightsColour(lastVehicle.handle, r, g, b)
        for i = 1, #lastVehicle.underglow do
          local index = lastVehicle.underglow[i]
          SetVehicleNeonLightEnabled(lastVehicle.handle, index, true)
        end
      end
      for i = 0, 3 do
        if IsVehicleNeonLightEnabled(playerVeh, i) then
          table.insert(lastVehicle.underglow, i)
          lastVehicle.enabled = true
        end
      end
      lastVehicle.handle = playerVeh
      TriggerEvent('civ:toggleUnderglow')
      --print('new vehicle added!')
    end
  else
    TriggerEvent('usa:notify', 'You must be the driver to do this!')
  end
end)

-- trading/selling vehicles --
RegisterNetEvent("vehicle:confirmSell")
AddEventHandler("vehicle:confirmSell", function(details)
  local responded = false
  local message = "~y~OFFER: ~w~$" .. details.price .. " for ~w~" .. details.make .. " " .. details.model .. " [" .. details.plate .. "]" .. "\nAccept? ~g~Y~w~/~r~Backspace"
  TriggerEvent("usa:notify", message)
  Citizen.CreateThread(function()
      while not responded do
          Wait(1)
          DrawSpecialText( "~y~OFFER: ~w~$" .. details.price .. " for ~w~" .. details.make .. " " .. details.model .. " [" .. details.plate .. "]" .. "\nAccept? ~g~Y~w~/~r~Backspace" )
          if IsControlJustPressed(1, 246) then -- Y key
              print("player wants to buy vehicle!")
              responded = true
              TriggerServerEvent("vehicle:confirmSell", details, true)
          elseif IsControlJustPressed(1, 177) then -- Backspace key
              print("player does not want to buy vehicle!")
              responded = true
              TriggerServerEvent("vehicle:confirmSell", details, false)
          end
      end
  end)
end)

function closeEnoughToPlayer(from_id)
  local lPed = GetPlayerPed(-1)
  -- see if close enough to target
  for id = 0, 255 do
    if NetworkIsPlayerActive(id) then
      if GetPlayerServerId(id) == tonumber(from_id) then
        local target_ped = GetPlayerPed(id)
        if Vdist(GetEntityCoords(lPed, 1), GetEntityCoords(target_ped, 1)) < 1.0 then
          return true
        else
          return false
        end
      end
    end
  end
  return false
end

function SetClipset(clipset)
  local ped = GetPlayerPed( -1 )
  if DoesEntityExist(ped) and not IsEntityDead(ped) then
    if not IsPauseMenuActive() then
      if not IsPedInAnyVehicle(ped, true) then
		ResetPedMovementClipset(ped, 0 )
        RequestAnimSet(clipset)
        while not HasAnimSetLoaded(clipset) do
            Citizen.Wait(1)
        end
        SetPedMovementClipset(ped, clipset, 0.25)
      end
    end
  end
end

---------------------------------------
-- Make vehicle radio louder / quiet --
---------------------------------------
local IS_VEHICLE_LOUD = false

RegisterNetEvent("civ:radioLoudToggle")
AddEventHandler("civ:radioLoudToggle", function()
  local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
  if veh ~= 0 then
    IS_VEHICLE_LOUD = not IS_VEHICLE_LOUD
    SetVehicleRadioLoud(veh, IS_VEHICLE_LOUD)
    if IS_VEHICLE_LOUD then
      exports.globals:notify("Radio: ~g~loud~w~!")
    else
      exports.globals:notify("Radio: ~y~normal~w~!")
    end
  else
    exports.globals:notify("Must be in a vehicle!")
  end
end)

-----------------------------
--------- SURRENDER ---------
-----------------------------

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent( 'KneelHU' )
AddEventHandler( 'KneelHU', function()
    local player = GetPlayerPed( -1 )
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
        loadAnimDict( "random@arrests" )
		loadAnimDict( "random@arrests@busted" )
		if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then
			TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (3000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
        else
            TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (4000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (500)
			TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (1000)
			TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
        end
    end
end )

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(0,21,true)
		end
	end
end)

-- Configure this: SNOWBALLS
local enableWeatherControl = false
-- Set this to true if you want this resource to set the weather to xmas for you.
-- DO NOT SET THIS TO TRUE IF YOU HAVE ANOTHER RESOURCE ALREADY MANAGING/SYNCING THE WEATHER FOR YOU.

local G_KEY = 47


-- No need to touch anything below.
Citizen.CreateThread(function()

    local showHelp = true
    local snowStuffEnabled = false
    local SNOWBALL_HASH = `WEAPON_SNOWBALL`

    while true do
      local ped = GetPlayerPed(-1)

      if enableWeatherControl then
          SetWeatherTypeNowPersist('XMAS')
      end
      
      if IsNextWeatherType('XMAS') then -- check for xmas weather type
        -- enable frozen water effect (water isn't actually ice, just looks like there's an ice layer on top of the water)
        N_0xc54a08c85ae4d410(3.0)

        if not snowStuffEnabled then
          RequestScriptAudioBank("ICE_FOOTSTEPS", false)
          RequestScriptAudioBank("SNOW_FOOTSTEPS", false)
          RequestNamedPtfxAsset("core_snow")
          while not HasNamedPtfxAssetLoaded("core_snow") do
            Citizen.Wait(0)
          end
          UseParticleFxAssetNextCall("core_snow")
          SetForceVehicleTrails(true)
          SetForcePedFootstepsTracks(true)
          RequestAnimDict('anim@mp_snowball') -- pre-load snowball animation
          snowStuffEnabled = true
        end

        if IsControlJustReleased(0, G_KEY) and not IsPedInAnyVehicle(ped, true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) and not IsPedRagdoll(ped) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(ped) and not IsPedSprinting(ped) and GetInteriorFromEntity(ped) == 0 and not IsPedShooting(ped) and not IsPedUsingAnyScenario(ped) and not IsPedInCover(ped, 0) then -- check if the snowball should be picked up
            TaskPlayAnim(ped, 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0) -- pickup the snowball
            Citizen.Wait(1950) -- wait 1.95 seconds to prevent spam clicking and getting a lot of snowballs without waiting for animatin to finish.
            GiveWeaponToPed(ped, SNOWBALL_HASH, 2, false, true) -- get 2 snowballs each time.
        end
      else
        -- disable frozen water effect
        if snowStuffEnabled then
          N_0xc54a08c85ae4d410(0.0)
          snowStuffEnabled = false
          RemoveNamedPtfxAsset("core_snow")
          ReleaseNamedScriptAudioBank("ICE_FOOTSTEPS")
          ReleaseNamedScriptAudioBank("SNOW_FOOTSTEPS")
          SetForceVehicleTrails(false)
          SetForcePedFootstepsTracks(false)
        end
      end
      Wait(0)
    end
end)

phone = false
phoneId = 0
frontCam = false
local on = false

function CellFrontCamActivate(activate)
  return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

RegisterNetEvent("camera:selfie")
AddEventHandler("camera:selfie", function()
  if not on then
    -- create phone:
    CreateMobilePhone(0)
    CellCamActivate(true, true)
    phone = true
    -- go into selfie mode:
    frontCam = true
    CellFrontCamActivate(frontCam)
    on = true
  else
    -- close phone:
    DestroyMobilePhone()
    phone = false
    CellCamActivate(false, false)
    if firstTime == true then
      firstTime = false
      Citizen.Wait(2500)
      displayDoneMission = true
    end
    on = false
    frontCam = false
  end
end)

Citizen.CreateThread(function()
DestroyMobilePhone()
  while true do
    Citizen.Wait(0)

    if phone == true then
      HideHudComponentThisFrame(7)
      HideHudComponentThisFrame(8)
      HideHudComponentThisFrame(9)
      HideHudComponentThisFrame(6)
      HideHudComponentThisFrame(19)
      HideHudAndRadarThisFrame()
    end

  end
end)

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

function areHandsUp()
  return hands_up
end

function areHandsTied()
  return hands_tied
end

function isBlindfolded()
  return isBlindfolded
end