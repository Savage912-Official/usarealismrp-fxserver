local JOBS = {
  ["Sand"] = {
    harvest = {x = 2952.7, y = 2789.5, z = 41.5, reward_item_name = "Raw Sand", time = 15, radius = 17},
    process = {x = 1223.3, y = 1875.2, z = 78.9, time = 18, reward_item_name = "Processed Sand", radius = 4.5},
    sell = {x = 843.4, y = -3205.4, z = 6.0, heading = 10.0},
    peds = {
      {x = 2970.6, y = 2799.5, z = 41.4, heading = 90.0, hash = -1453933154, scenario = "WORLD_HUMAN_HANG_OUT_STREET", type="info", gives_directions_to = "process", name = "Mike"},
      {x = 1219.9, y = 1868.8, z = 78.9, heading = 10.0, hash = -973145378, scenario = "WORLD_HUMAN_HANG_OUT_STREET", type = "info", gives_directions_to = "sale", name = "Gonzolo"},
      {x = 843.5, y = -3203.8, z = 5.99, heading = 170.0, hash = -973145378, scenario = "WORLD_HUMAN_HANG_OUT_STREET", type = "prop", gives_directions_to = nil, name = "Jeff"}
      -- x = 1223.3, y = 1875.2, z = 78.9 (ped to process at)
    },
    anims = {
      harvest = {
        dict = "anim@move_m@trash",
        name = "pickup"
      }
    },
    sound = nil,
    mapBlip = {
      show = true,
      id = 120,
      color = 4,
      scale = 1.0,
      name = "Sand Mining"
    }
  },
  ["Corn"] = {
    harvest = {reward_item_name = "Raw Corn"},
    process = {x = 2415.8889160156, y = 4992.48046875, z = 46.155170440674, time = 18, reward_item_name = "Corn", radius = 4.5},
    sell = {x =  1674.802734375, y = 4884.2299804688, z = 42.077098846436, heading = 10.0},
    peds = {
      {x = 2413.7785644531, y = 4987.7177734375, z = 46.216709136963, heading = 43.0, hash = -973145378, scenario = "WORLD_HUMAN_HANG_OUT_STREET", type = "info", gives_directions_to = "sale", name = "George"},
      {x =  1674.802734375, y = 4884.2299804688, z = 42.077098846436, heading = 43.0, hash = -973145378, scenario = "WORLD_HUMAN_HANG_OUT_STREET", type = "prop", gives_directions_to = nil, name = "Steve"}
      -- x = 1223.3, y = 1875.2, z = 78.9 (ped to process at)
    },
    anims = {
      harvest = {
        dict = "anim@move_m@trash",
        name = "pickup"
      }
    },
    sound = nil
  }
}

Citizen.CreateThread(function()
  for name, info in pairs(JOBS) do
    if info.mapBlip and info.mapBlip.show then
      local blip = AddBlipForCoord(info.harvest.x, info.harvest.y, info.harvest.z)
  		SetBlipSprite(blip, info.mapBlip.id)
  		SetBlipDisplay(blip, 4)
  		SetBlipScale(blip, info.mapBlip.scale or 0.8)
  		SetBlipColour(blip, info.mapBlip.color)
  		SetBlipAsShortRange(blip, true)
  		BeginTextCommandSetBlipName("STRING")
  		AddTextComponentString(info.mapBlip.name)
  		EndTextCommandSetBlipName(blip)
    end
  end
end)

-------------------------------------------------------------------
-- todo: make it so the info peds give directions to the next point
-------------------------------------------------------------------

local KEY = 38 -- "E"
local SOUND_ENABLE = true

--------------------
-- Spawn job peds --
--------------------
-- S P A W N  J O B  P E D S
Citizen.CreateThread(function()
	for name, data in pairs(JOBS) do
		for i = 1, #data.peds do
      local hash = data.peds[i].hash
  		--local hash = GetHashKey(data.ped.model)
  		RequestModel(hash)
  		while not HasModelLoaded(hash) do
  			Citizen.Wait(0)
  		end
  		local ped = CreatePed(4, hash, data.peds[i].x, data.peds[i].y, data.peds[i].z, data.peds[i].heading --[[Heading]], false --[[Networked, set to false if you just want to be visible by the one that spawned it]], true --[[Dynamic]])
      data.peds[i].handle = ped
      SetEntityCanBeDamaged(ped,false)
  		SetPedCanRagdollFromPlayerImpact(ped,false)
  		TaskSetBlockingOfNonTemporaryEvents(ped,true)
  		SetPedFleeAttributes(ped,0,0)
  		SetPedCombatAttributes(ped,17,1)
  		SetPedRandomComponentVariation(ped, true)
      TaskStartScenarioInPlace(ped, data.peds[i].scenario, 0, true);
    end
	end
end)

------------------------------------------------
-- See if player is close to any job location --
------------------------------------------------
Citizen.CreateThread(function()
  while true do
    local player_ped = GetPlayerPed(-1)
    local player_coords = GetEntityCoords(player_ped)
    for job, places in pairs(JOBS) do
      if not IsPedInAnyVehicle(player_ped) then
        if places.harvest.x and Vdist(player_coords, places.harvest.x, places.harvest.y, places.harvest.z) < places.harvest.radius then
          --print("player is close to harvest job location:  " .. job)
          drawTxt("Press ~g~E~w~ to dig!",0,1,0.5,0.8,0.6,255,255,255,255)
          if IsControlJustPressed(1, KEY) then
            TriggerServerEvent("HPS:checkCriminalHistory", job, places.harvest.time, "Harvest")
            --TriggerServerEvent("HPS:checkItem", job, places.harvest.time, "Harvest")
            Wait(places.harvest.time * 1000) -- prevent spamming
          end
        elseif Vdist(player_coords, places.process.x, places.process.y, places.process.z) < places.process.radius then
          --print("player is close to process job location:  " .. job)
          drawTxt("Press ~g~E~w~ to process " .. job .. "!",0,1,0.5,0.8,0.6,255,255,255,255)
          if IsControlJustPressed(1, KEY) then
            TriggerServerEvent("HPS:checkItem", job, places.process.time, "Process")
            Wait(places.process.time * 1000) -- prevent spamming
          end
        elseif places.sell and Vdist(player_coords, places.sell.x, places.sell.y, places.sell.z) < 3.0 then
          drawTxt("Press ~g~E~w~ to sell " .. job .. "!",0,1,0.5,0.8,0.6,255,255,255,255)
          if IsControlJustPressed(1, KEY) and not IsPedInAnyVehicle(player_ped) then
            TriggerServerEvent("HPS:checkItem", job, 0, "Sale")
            --Sell(job, places.harvest_time)
          end
        end
        if places.peds then
          -- check for info peds:
          for i = 1, #places.peds do
            if Vdist(player_coords, places.peds[i].x, places.peds[i].y, places.peds[i].z) < 2.5 then
              if places.peds[i].type == "info" then
                drawTxt("Press ~g~E~w~ to speak with " .. places.peds[i].name .. "!",0,1,0.5,0.8,0.6,255,255,255,255)
                if IsControlJustPressed(1, KEY) then
                  ClearGpsPlayerWaypoint()
                  if places.peds[i].gives_directions_to == "process" then
                    if job == "Sand" then
                      TriggerEvent("usa:notify", "You can harvest here")
                    end
                    TriggerEvent("usa:notify", "Here are directions to the place where you can process " .. places.harvest.reward_item_name .. "s")
                    SetNewWaypoint(places.process.x, places.process.y)
                  elseif places.peds[i].gives_directions_to == "sale" then
                    if job == "Sand" then
                      TriggerEvent("usa:notify", "You can process here")
                    end
                    TriggerEvent("usa:notify", "Here are directions to a place where you can sell " .. places.process.reward_item_name)
                    SetNewWaypoint(places.sell.x, places.sell.y)
                  end
                  -- play ped sound:
                  local sounds = {
                    {sound = "Shout_Threaten_Ped", param = "Speech_Params_Force_Shouted_Critical"},
                    {sound = "Shout_Threaten_Gang", param = "Speech_Params_Force_Shouted_Critical"},
                    {sound = "Generic_Hi", param = "Speech_Params_Force"}
                  }
                  local random_sound = sounds[math.random(1, tonumber(#sounds))]
                  PlayAmbientSpeech1(places.peds[i].handle, random_sound.sound, random_sound.param)
                end
              end
            end
          end
        end
      end
    end
    Wait(0)
  end
end)

------------------
-- Draw Markers --
------------------
Citizen.CreateThread(function()
  while true do
    for job, places in pairs(JOBS) do
      if places.sell then
        local player_coords = GetEntityCoords(GetPlayerPed(-1))
        if Vdist(player_coords, places.sell.x, places.sell.y, places.sell.z) < 50 then
          DrawMarker(27, places.sell.x, places.sell.y, places.sell.z - 0.9, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
        end
      end
    end
    Wait(0)
  end
end)

-------------------
-- CUSTOM EVENTS --
-------------------
RegisterNetEvent("HPS:continueHarvesting")
AddEventHandler("HPS:continueHarvesting", function(job_name, process_time)
  for job, things in pairs(JOBS) do
    if job == job_name then
      TriggerEvent("usa:notify", "~y~Harvesting: ~w~(x1) " .. things.harvest.reward_item_name)
      Harvest(job, things.harvest.time)
    end
  end
end)

RegisterNetEvent("HPS:continueProcessing")
AddEventHandler("HPS:continueProcessing", function(job_name, process_time)
  for job, things in pairs(JOBS) do
    if job == job_name then
      TriggerEvent("usa:notify", "~y~Processing: ~w~(x1) " .. things.process.reward_item_name)
      Process(job_name, things.process.time)
    end
  end
end)

------------------
-- HARVEST ITEM --
------------------
function Harvest(to_harvest_item_name, harvest_time)
  if JOBS[to_harvest_item_name].anims then
    TriggerEvent("usa:playAnimation", JOBS[to_harvest_item_name].anims.harvest.dict, JOBS[to_harvest_item_name].anims.harvest.name, -8, 1, -1, 53, 0, 0, 0, 0, harvest_time)
  end
  if JOBS[to_harvest_item_name].sound then
    -- play sound:
    if SOUND_ENABLE then TriggerServerEvent("InteractSound_SV:PlayOnSource", JOBS[to_harvest_item_name].sound, 0.1) end
  end
  -- pause for time
  Wait(harvest_time * 1000)
  -- give item harvested item:
  TriggerServerEvent("HPS:rewardItem", to_harvest_item_name, "Harvest")
end

------------------
-- PROCESS ITEM --
------------------
function Process(to_process_item_name, process_time)
  TriggerEvent("usa:playAnimation", "timetable@jimmy@ig_1@idle_a", "hydrotropic_bud_or_something", -8, 1, -1, 53, 0, 0, 0, 0, process_time)
  -- play sound:
  if JOBS[to_process_item_name].sound then
    if SOUND_ENABLE then TriggerServerEvent("InteractSound_SV:PlayOnSource", JOBS[to_process_item_name].sound, 0.105) end
  end
  -- pause for time
  Wait(process_time * 1000)
  -- give item harvested item:
  TriggerServerEvent("HPS:rewardItem", to_process_item_name, "Process")
end

----------------------
-- UTLITY FUNCTIONS --
----------------------
function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end
