

----------------------------------------------------------
---------------------load movie settings------------------
----------------------------------------------------------
-- Configure the opening hours
local openingHour = 0
local closingHour = 22

-- Configure the coordinates for all the cinemas
local cinemaLocations = {
  { ['name'] = "Downtown", ['x'] = 300.788, ['y'] = 200.752, ['z'] = 104.385},
  { ['name'] = "Morningwood", ['x'] = -1423.954, ['y'] = -213.62, ['z'] = 46.5},
  { ['name'] = "Vinewood",  ['x'] = 302.907, ['y'] = 135.939, ['z'] = 160.946},
  { ['name'] = "Paleto",  ['x'] = -145.119, ['y'] = 6304.858, ['z'] = 31.560}
}
local MovieState = false


--gets a random movie
function randomVideo()
 n = GetRandomIntInRange(0, 3)
   if n == 0 then
    return "PL_CINEMA_CARTOON"
   elseif n == 1 then
    return "PL_STD_CNT"
   elseif n == 2 then
    return "PL_STD_WZL"
   elseif n == 3 then
    return "PL_CINEMA_MULTIPLAYER_NO_MELTDOWN"
   elseif n == 4 then
    return "PL_CINEMA_ACTION"
   end
end

------------------------------------------------------------
---------------------set up movie---------------------------
------------------------------------------------------------
function SetupMovie()
  cinema = GetInteriorAtCoords(320.217, 263.81, 82.974)
  LoadInterior(cinema)
--this gets the hash key of the cinema screen
  cin_screen = GetHashKey("v_ilev_cin_screen")
   if not DoesEntityExist(tv) then
     tv = CreateObjectNoOffset(cin_screen, 320.1257, 248.6608, 86.56934, 1, true, false)
	 SetEntityHeading(tv, 179.99998474121)
    else
	 tv = GetClosestObjectOfType(319.884, 262.103, 82.917, 20.475, cin_screen, 0, 0, 0)
   end
--this checks if the rendertarget is registered and  registers rendertarget
  if not IsNamedRendertargetRegistered("cinscreen") then
    RegisterNamedRendertarget("cinscreen", 0)
  end
--this checks if the screen is linked to rendertarget and links screen to rendertarget
    if not IsNamedRendertargetLinked(cin_screen) then
        LinkNamedRendertarget(cin_screen)
    end
  rendertargetid = GetNamedRendertargetRenderId("cinscreen")
--this checks if the rendertarget is linked AND registered
  if IsNamedRendertargetLinked(cin_screen) and IsNamedRendertargetRegistered("cinscreen") then
--this sets the rendertargets channel and video
	Citizen.InvokeNative(0x9DD5A62390C3B735, 2, randomVideo(), 0)
--this sets the rendertarget
	SetTextRenderId(rendertargetid)
--duh sets the volume
	SetTvVolume(100)
--duh sets the cannel
    SetTvChannel(2)
--duh sets subtitles
    EnableMovieSubtitles(1)
--these are for the rendertarget 2d settings and stuff
    Citizen.InvokeNative(0x67A346B3CDB15CA5, 100.0)
    Citizen.InvokeNative(0x61BB1D9B3A95D802, 4)
    Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
  else
--this puts the rendertarget back to regular use(playing)
   SetTextRenderId(GetDefaultScriptRendertargetRenderId())
  end
  if MovieState == false then
    MovieState = true
    CreateMovieThread()
  end
end
function helpDisplay(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end
--this FUNCTION deletes the movie screen sets the channel to basicly nothing
function DeconstructMovie()
 local obj = GetClosestObjectOfType(319.884, 262.103, 82.917, 20.475, cin_screen, 0, 0, 0)
  cin_screen = GetHashKey("v_ilev_cin_screen")
  SetTvChannel(-1)
  ReleaseNamedRendertarget(GetHashKey("cinscreen"))
  SetTextRenderId(GetDefaultScriptRendertargetRenderId())
  SetEntityAsMissionEntity(obj,true,false)
  DeleteObject(obj)
end
--this FUNCTION is what draws the tv channel(needs to be in a loop)
function StartMovie()
    DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
end
--this starts the movie
function CreateMovieThread()
  Citizen.CreateThread(function()
    SetTextRenderId(GetNamedRendertargetRenderId("cinscreen"))
	Citizen.InvokeNative(0x9DD5A62390C3B735, 2, randomVideo(), 0)
	SetTvChannel(2)
	Citizen.InvokeNative(0x67A346B3CDB15CA5, 100.0)
    Citizen.InvokeNative(0x61BB1D9B3A95D802, 4)
    Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
    while(true) do
      Citizen.Wait(0)
      StartMovie()
    end
  end)
end
local entered_theater = {}
--this is the enter theater stuff
function IsPlayerInArea()
  playerPed = GetPlayerPed(-1)
  playerCoords = GetEntityCoords(playerPed, true)
  hour = GetClockHours()
  for k,v in ipairs(cinemaLocations) do
    -- Check if the player is near the cinema
    if #(playerCoords - vector3(v.x, v.y, v.z)) < 4.8 then
      -- Check if the cinema is open or closed.
      if hour < openingHour or hour > closingHour then
        helpDisplay("The cinema is ~r~closed ~w~come back between 1am and 22pm.", 0)
      else
        helpDisplay("Press ~INPUT_CONTEXT~ to watch a movie", 0)
        -- Check if the player is near the cinema and pressed "INPUT_CONTEXT"
        if IsControlPressed(0, 38) then
          TriggerServerEvent("movies:checkMoney")
        end
      end
    end
  end
end
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    IsPlayerInArea()
  end
end)
--if the player is not inside theater delete screen
Citizen.CreateThread(function()
 if GetRoomKeyFromEntity(PlayerPedId()) ~= -1337806789 and DoesEntityExist(GetClosestObjectOfType(319.884, 262.103, 82.917, 20.475, cin_screen, 0, 0, 0)) then
    DeconstructMovie()
 end
end)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    playerPed = GetPlayerPed(-1)
    --if player hits "esc" key while in theater they exit
    if IsControlPressed(0, 322) and GetRoomKeyFromEntity(PlayerPedId()) == -1337806789 then
      DoScreenFadeOut(1000)
      --SetEntityCoords(playerPed, 297.891, 193.296, 104.344, 161.925)
      SetEntityCoords(playerPed, entered_theater.x, entered_theater.y , entered_theater.z, 161.925)
      Citizen.Wait(30)
      DoScreenFadeIn(800)
      FreezeEntityPosition(GetPlayerPed(-1), 0)
      SetFollowPedCamViewMode(fistPerson)
      DeconstructMovie()
      --SetPlayerInvincible(PlayerId(), false)
      --ClearRoomForEntity(playerPed)
      MovieState = false
    end
    if GetRoomKeyFromEntity(PlayerPedId()) == -1337806789 then
      --SetPlayerInvisibleLocally(PlayerId(),  true)
      --SetEntityVisible(PlayerPedId(-1), false)
      --SetPlayerInvincible(PlayerId(), true)
      SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
      SetFollowPedCamViewMode(4)
    else
      --SetEntityVisible(PlayerPedId(-1), true)
      --SetPlayerInvincible(PlayerId(), false)
    end
  end
end)

-- Custom:
RegisterNetEvent("movies:enterTheatre")
AddEventHandler("movies:enterTheatre", function()
  local temp_playerPed = GetPlayerPed(-1)
  local temp_playerCoords = GetEntityCoords(temp_playerPed, true)
  entered_theater = temp_playerCoords
  DoScreenFadeOut(1000)
  SetupMovie()
  -- Teleport the Player inside the cinema
  Citizen.Wait(500)
  SetEntityCoords(temp_playerPed, 320.217, 263.81, 81.974, true, true, true, true)
  DoScreenFadeIn(800)
  Citizen.Wait(30)
  SetEntityHeading(temp_playerPed, 180.475)
  TaskLookAtCoord(GetPlayerPed(-1), 319.259, 251.827, 85.648, -1, 2048, 3)
  FreezeEntityPosition(GetPlayerPed(-1), 1)
  SetNotificationTextEntry('STRING')
  AddTextComponentString("press ~r~ESC ~w~key to exit")
  DrawNotification(false, false)
end)

----------------------
---- Set up blips ----
----------------------
for i = 1, #cinemaLocations do
  local blip = AddBlipForCoord(cinemaLocations[i]['x'], cinemaLocations[i]['y'], cinemaLocations[i]['z'])
  SetBlipSprite(blip, 135)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.8)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Movies')
  EndTextCommandSetBlipName(blip)
end