local default_voip = 8.5
local civilianSpawns = {
    --{x = 391.611, y = -948.984, z = 29.3978}, -- atlee & sinner st
    --{x = 95.2552, y = -1310.8, z = 29.2921}, -- near strip club
    --{x = 10.6334, y = -718.769, z = 44.2174} -- pitts suggestion
    --{x = 434.14, y = -646.847, z = 28.7314}, -- daschound bus station 1
    --{x = 434.753, y = -629.007, z = 28.7186}, -- daschound hus station 2
    --{x = 412.16, y = -619.049, z = 28.7015}, -- daschound bus station 3
    --{x = -536.625, y = -218.624, z = 38.8497}, -- DMV spawn in LS
    --{x = 232.919, y = -880.539, z = 30.5921}, -- legion square
    --{x = 233.919, y = -880.539, z = 30.5921}, -- legion square
    --{x = 234.919, y = -880.539, z = 30.5921} -- legion square
    {x = -288.624, y = 6229.223, z = 31.454}, -- paleto (barber shop)
    {x = 178.346, y = 6636.780, z = 31.6}, -- paleto (gas station)
    {x = -391.130, y = 6216.655, z = 31.473} -- paleto (procopio dr)
    -- Meth Delivery -402.63 y 6316.12 z 28.95 heading 222.26 DONE
}

local playerPed = GetPlayerPed(-1)

local blacklistedVehicles = {
  -1649536104,
  177270108,
  -1600252419,
  1543134283,
  562680400,
  -32236122,
  782665360,
  -1881846085,
  -1860900134,
  970385471,
  -1281684762,
  -114627507,
  2010166902,
  -82626025,
  -1924433270,
  643608993,
  1542143200,
  2044532910,
  -638562243,
  2069146067,
  1692272545,
  1489874736,
  -692292317,
  -212993243,
  447548909,
  1181327175,
  -42959138,
  1036591958,
  -1242608589,
  -749299473,
  -32878452,
  1565978651,
  1043222410,
  -1700874274,
  -1210451983,
  GetHashKey('oppressor')

}

local KEYS = {
  E = 38
}

local VEH_CLASS = {
    Bicycle = 13,
    Motorcycle = 8
}

-- DISCORD RICH PRESENCE --
SetDiscordAppId("517228692834091033")
SetDiscordRichPresenceAsset("5a158f46d2aefd14d3c7a16f3f4bc72b")
SetDiscordRichPresenceAssetText("USARRP")
SetDiscordRichPresenceAction(0, "Connect", "fivem://connect/cfx.re/join/8kgomm")
SetDiscordRichPresenceAction(1, "Website", "https://usarrp.gg")

-- REMOVE AI WEAPON DROPS:
function RemoveWeaponDrops()
  local pickupList = {"PICKUP_AMMO_BULLET_MP","PICKUP_AMMO_FIREWORK","PICKUP_AMMO_FLAREGUN","PICKUP_AMMO_GRENADELAUNCHER","PICKUP_AMMO_GRENADELAUNCHER_MP","PICKUP_AMMO_HOMINGLAUNCHER","PICKUP_AMMO_MG","PICKUP_AMMO_MINIGUN","PICKUP_AMMO_MISSILE_MP","PICKUP_AMMO_PISTOL","PICKUP_AMMO_RIFLE","PICKUP_AMMO_RPG","PICKUP_AMMO_SHOTGUN","PICKUP_AMMO_SMG","PICKUP_AMMO_SNIPER","PICKUP_ARMOUR_STANDARD","PICKUP_CAMERA","PICKUP_CUSTOM_SCRIPT","PICKUP_GANG_ATTACK_MONEY","PICKUP_HEALTH_SNACK","PICKUP_HEALTH_STANDARD","PICKUP_MONEY_CASE","PICKUP_MONEY_DEP_BAG","PICKUP_MONEY_MED_BAG","PICKUP_MONEY_PAPER_BAG","PICKUP_MONEY_PURSE","PICKUP_MONEY_SECURITY_CASE","PICKUP_MONEY_VARIABLE","PICKUP_MONEY_WALLET","PICKUP_PARACHUTE","PICKUP_PORTABLE_CRATE_FIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL","PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW","PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE","PICKUP_PORTABLE_PACKAGE","PICKUP_SUBMARINE","PICKUP_VEHICLE_ARMOUR_STANDARD","PICKUP_VEHICLE_CUSTOM_SCRIPT","PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW","PICKUP_VEHICLE_HEALTH_STANDARD","PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW","PICKUP_VEHICLE_MONEY_VARIABLE","PICKUP_VEHICLE_WEAPON_APPISTOL","PICKUP_VEHICLE_WEAPON_ASSAULTSMG","PICKUP_VEHICLE_WEAPON_COMBATPISTOL","PICKUP_VEHICLE_WEAPON_GRENADE","PICKUP_VEHICLE_WEAPON_MICROSMG","PICKUP_VEHICLE_WEAPON_MOLOTOV","PICKUP_VEHICLE_WEAPON_PISTOL","PICKUP_VEHICLE_WEAPON_PISTOL50","PICKUP_VEHICLE_WEAPON_SAWNOFF","PICKUP_VEHICLE_WEAPON_SMG","PICKUP_VEHICLE_WEAPON_SMOKEGRENADE","PICKUP_VEHICLE_WEAPON_STICKYBOMB","PICKUP_WEAPON_ADVANCEDRIFLE","PICKUP_WEAPON_APPISTOL","PICKUP_WEAPON_ASSAULTRIFLE","PICKUP_WEAPON_ASSAULTSHOTGUN","PICKUP_WEAPON_ASSAULTSMG","PICKUP_WEAPON_AUTOSHOTGUN","PICKUP_WEAPON_BAT","PICKUP_WEAPON_BATTLEAXE","PICKUP_WEAPON_BOTTLE","PICKUP_WEAPON_BULLPUPRIFLE","PICKUP_WEAPON_BULLPUPSHOTGUN","PICKUP_WEAPON_CARBINERIFLE","PICKUP_WEAPON_COMBATMG","PICKUP_WEAPON_COMBATPDW","PICKUP_WEAPON_COMBATPISTOL","PICKUP_WEAPON_COMPACTLAUNCHER","PICKUP_WEAPON_COMPACTRIFLE","PICKUP_WEAPON_CROWBAR","PICKUP_WEAPON_DAGGER","PICKUP_WEAPON_DBSHOTGUN","PICKUP_WEAPON_FIREWORK","PICKUP_WEAPON_FLAREGUN","PICKUP_WEAPON_FLASHLIGHT","PICKUP_WEAPON_GRENADE","PICKUP_WEAPON_GRENADELAUNCHER","PICKUP_WEAPON_GUSENBERG","PICKUP_WEAPON_GOLFCLUB","PICKUP_WEAPON_HAMMER","PICKUP_WEAPON_HATCHET","PICKUP_WEAPON_HEAVYPISTOL","PICKUP_WEAPON_HEAVYSHOTGUN","PICKUP_WEAPON_HEAVYSNIPER","PICKUP_WEAPON_HOMINGLAUNCHER","PICKUP_WEAPON_KNIFE","PICKUP_WEAPON_KNUCKLE","PICKUP_WEAPON_MACHETE","PICKUP_WEAPON_MACHINEPISTOL","PICKUP_WEAPON_MARKSMANPISTOL","PICKUP_WEAPON_MARKSMANRIFLE","PICKUP_WEAPON_MG","PICKUP_WEAPON_MICROSMG","PICKUP_WEAPON_MINIGUN","PICKUP_WEAPON_MINISMG","PICKUP_WEAPON_MOLOTOV","PICKUP_WEAPON_MUSKET","PICKUP_WEAPON_NIGHTSTICK","PICKUP_WEAPON_PETROLCAN","PICKUP_WEAPON_PIPEBOMB","PICKUP_WEAPON_PISTOL","PICKUP_WEAPON_PISTOL50","PICKUP_WEAPON_POOLCUE","PICKUP_WEAPON_PROXMINE","PICKUP_WEAPON_PUMPSHOTGUN","PICKUP_WEAPON_RAILGUN","PICKUP_WEAPON_REVOLVER","PICKUP_WEAPON_RPG","PICKUP_WEAPON_SAWNOFFSHOTGUN","PICKUP_WEAPON_SMG","PICKUP_WEAPON_SMOKEGRENADE","PICKUP_WEAPON_SNIPERRIFLE","PICKUP_WEAPON_SNSPISTOL","PICKUP_WEAPON_SPECIALCARBINE","PICKUP_WEAPON_STICKYBOMB","PICKUP_WEAPON_STUNGUN","PICKUP_WEAPON_SWITCHBLADE","PICKUP_WEAPON_VINTAGEPISTOL","PICKUP_WEAPON_WRENCH", "PICKUP_WEAPON_RAYCARBINE"}
  for a = 1, #pickupList do
    N_0x616093ec6b139dd9(PlayerId(), GetHashKey(pickupList[a]), false)
  end
end

Citizen.CreateThread(function()     
  RemoveWeaponDrops()
end)

Citizen.CreateThread(function()
    -- Other stuff normally here, stripped for the sake of only scenario stuff
    local SCENARIO_TYPES = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL", -- Zancudo Small Planes
        "WORLD_VEHICLE_MILITARY_PLANES_BIG", -- Zancudo Big Planes
    }
    local SCENARIO_GROUPS = {
        2017590552, -- LSIA planes
        2141866469, -- Sandy Shores planes
        1409640232, -- Grapeseed planes
        "ng_planes", -- Far up in the skies jets
    }
    local SUPPRESSED_MODELS = {
        "SHAMAL", -- They spawn on LSIA and try to take off
        "LUXOR", -- They spawn on LSIA and try to take off
        "LUXOR2", -- They spawn on LSIA and try to take off
        "JET", -- They spawn on LSIA and try to take off and land, remove this if you still want em in the skies
        "LAZER", -- They spawn on Zancudo and try to take off
        "TITAN", -- They spawn on Zancudo and try to take off
        "BARRACKS", -- Regularily driving around the Zancudo airport surface
        "BARRACKS2", -- Regularily driving around the Zancudo airport surface
        "CRUSADER", -- Regularily driving around the Zancudo airport surface
        "RHINO", -- Regularily driving around the Zancudo airport surface
        "AIRTUG", -- Regularily spawns on the LSIA airport surface
        "RIPLEY", -- Regularily spawns on the LSIA airport surface
    }

    while true do
        for _, sctyp in next, SCENARIO_TYPES do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, SCENARIO_GROUPS do
            SetScenarioGroupEnabled(scgrp, false)
        end
        for _, model in next, SUPPRESSED_MODELS do
            SetVehicleModelIsSuppressed(GetHashKey(model), true)
        end
        Wait(10000)
    end
end)

Citizen.CreateThread(function()
	for i = 1, 12 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false) -- disable AI LEO/EMS dispatching
	end
end)

------------------------------
-- FIRST LOAD / SPAWNING IN --
------------------------------

RegisterNetEvent('usa_rp:playerLoaded')
AddEventHandler('usa_rp:playerLoaded', function()
    exports.spawnmanager:setAutoSpawn(false)
    exports.spawnmanager:forceRespawn()
    NetworkSetTalkerProximity(default_voip)
    SetAudioFlag("DisableFlightMusic", 1)
    Citizen.Trace("calling usa_rp:spawnPlayer!")
    TriggerServerEvent('usa_rp:spawnPlayer')
end)

RegisterNetEvent('usa_rp:spawn')
AddEventHandler('usa_rp:spawn', function(defaultModel)
  local spawn = {x = 0.0, y = 0.0, z = 0.0}
  spawn = civilianSpawns[math.random(1, #civilianSpawns)]
  exports.spawnmanager:spawnPlayer({x = spawn.x, y = spawn.y, z = spawn.z, model = defaultModel, heading = 0.0}, function()
  TriggerServerEvent('mini:checkPlayerBannedOnSpawn') -- CHECK BAN STATUS
  end)
end)

-------------------
-- RANDOM THINGS --
-------------------
-- Pause Menu Title & Don't Regen Health --
function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  Wait(1000)
  SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
end)

Citizen.CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', 'USA REALISM RP - HTTPS://USARRP.GG')
end)

-- DISTRITIC'S RAGDOLL ON JUMP --
local ragdoll_chance = 0.30 -- 80 = 80%

Citizen.CreateThread(function()
	while true do
		Wait(100) -- check every 100 ticks, performance matters
    --if DoesEntityExist(playerPed) and IsPedUsingActionMode(playerPed) then -- disable action mode/combat stance when engaged in combat (thing which makes you run around like an idiot when shooting)
        --SetPedUsingActionMode(playerPed, -1, -1, 1)
    --end
		if IsPedOnFoot(playerPed) and not IsPedSwimming(playerPed) and (IsPedRunning(playerPed) or IsPedSprinting(playerPed)) and not IsPedClimbing(playerPed) and IsPedJumping(playerPed) and not IsPedRagdoll(playerPed) then
      local chance_result = math.random()
			if chance_result < ragdoll_chance then
				Wait(600) -- roughly when the ped loses grip
        TriggerEvent('injuries:triggerGrace', function()
				  SetPedToRagdoll(playerPed, 1000, 1000, 3)
        end)
			else
				Wait(2000) -- cooldown before continuing
			end
		end
	end
end)

-- clear NPC cops --
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(150)
		local playerLocalisation = GetEntityCoords(playerPed)
		ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
	end
end)

-- no police npc / never wanted
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local playerVeh = GetVehiclePedIsIn(playerPed, false)
        local vehModel = GetEntityModel(playerVeh)
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(),0,false)
            SetPlayerWantedLevelNow(PlayerId(),false)
            SetMaxWantedLevel(0)
        end
        for i = 1, #blacklistedVehicles do
          local blacklistedVeh = blacklistedVehicles[i]
          if vehModel == blacklistedVeh then
            SetEntityAsMissionEntity(playerVeh, true, true)
            DeleteVehicle(playerVeh)
          end
        end
    end
end)

SetAudioFlag('PoliceScannerDisabled', true)

-- spawn peds
local locations = {
      stripclub = {
        {x = 102.423, y = -1290.594, z = 28.2587, animDict = "mini@strip_club@private_dance@part1", animName = "priv_dance_p1", model = "CSB_Stripper_02", heading = (math.random(50, 360)) * 1.0},
        {x = 104.256, y = -1294.67, z = 28.2587, animDict = "mini@strip_club@private_dance@part3", animName = "priv_dance_p3", model = "CSB_Stripper_01", heading = (math.random(50, 360)) * 1.0},
        {x = 109.00591278076, y = -1290.1696777344, z = 28.2587, animDict = "mini@strip_club@private_dance@part2", animName = "priv_dance_p2", model = "CSB_Stripper_01", heading = (math.random(50, 360)) * 1.0},
        {x = 109.57312774658, y = -1289.064453125, z = 28.2587, animDict = "mini@strip_club@private_dance@part3", animName = "priv_dance_p3", model = "S_F_Y_Stripper_02", heading = (math.random(50, 360)) * 1.0},
        {x = 107.92155456543, y = -1288.7708740234, z = 28.2587, animDict = "mini@strip_club@private_dance@part2", animName = "priv_dance_p2", model = "CSB_Stripper_02", heading = (math.random(50, 360)) * 1.0},
        {x = 129.442, y = -1283.407, z = 28.272, animDict = "missfbi3_party_d", animName = "stand_talk_loop_a_female", model = "S_F_Y_Bartender_01", heading = 122.471}
    },
    illegal_weapon_extra_shop = {
        {x = 752.996, y = -3192.206, z = 5.07, animDict = "", animName = "", model = "G_M_Y_SALVABOSS_01", heading = 302.471, scenario = "WORLD_HUMAN_SMOKING"}
    },
    nightclub = {
        {x = -1572.2, y = -3013.3, z = -74.4, animDict = "", animName = "" , model = 793439294, heading = -60.0},
    }
}
Citizen.CreateThread(function()
  while true do
    local playerCoords = GetEntityCoords(PlayerPedId(), false)
    for _, location in pairs(locations) do
      for i = 1, #location do
        if Vdist(location[i].x, location[i].y, location[i].z, playerCoords.x, playerCoords.y, playerCoords.z) < 50 then
          if not location[i].pedHandle then
            local hash = location[i].model
            if type(hash) ~= "number" then
                hash = GetHashKey(location[i].model)
            end
            RequestModel(hash)
            while not HasModelLoaded(hash) do
              Wait(100)
            end
            local ped = CreatePed(4, hash, location[i].x, location[i].y, location[i].z, location[i].heading, false, true)
            SetEntityCanBeDamaged(ped,false)
            SetPedCanRagdollFromPlayerImpact(ped,false)
            TaskSetBlockingOfNonTemporaryEvents(ped,true)
            SetPedFleeAttributes(ped,0,0)
            SetPedCombatAttributes(ped,17,1)
            if not location[i].scenario then
              RequestAnimDict(location[i].animDict)
              while not HasAnimDictLoaded(location[i].animDict) do
                Citizen.Wait(100)
              end
              TaskPlayAnim(ped, location[i].animDict, location[i].animName, 8.0, -8, -1, 7, 0, 0, 0, 0)
            else
              TaskStartScenarioInPlace(ped, location[i].scenario, 0, 1)
            end
            location[i].pedHandle = ped
            Wait(1400) -- just to offset ped animations a bit so they aren't un-naturely synced
          end
        else 
          if location[i].pedHandle then
            DeletePed(location[i].pedHandle)
            location[i].pedHandle = nil
          end
        end
      end
    end
    Wait(100)
  end
end)

-- save player vehicle wheel position on exit --
Citizen.CreateThread(function()
    local angle = 0.0
    local speed = 0.0
    while true do
        local veh = GetVehiclePedIsUsing(playerPed)
        if DoesEntityExist(veh) then
            local tangle = GetVehicleSteeringAngle(veh)
            if tangle > 10.0 or tangle < -10.0 then
                angle = tangle
            end
            speed = GetEntitySpeed(veh)
            local vehicle = GetVehiclePedIsIn(playerPed, true)
            if speed < 0.1 and DoesEntityExist(vehicle) and not GetIsTaskActive(playerPed, 151) and not GetIsVehicleEngineRunning(vehicle) then
                SetVehicleSteeringAngle(GetVehiclePedIsIn(playerPed, true), angle)
            end
        end
        Wait(1)
    end
end)

----------------------
-- player crouching --
----------------------
local crouched = false
local KEY_1 = 19 -- alt
local KEY_2 = 173 -- down arrow
local clipset = "move_ped_crouched"
Citizen.CreateThread( function()
  while true do
    Citizen.Wait( 10 )
    if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed ) ) then
      if ( not IsPauseMenuActive() ) then
        if ( IsControlPressed( 1, KEY_1 ) and IsControlJustPressed( 1, KEY_2 ) and not IsPedInAnyVehicle(playerPed, true) ) then
          RequestAnimSet( clipset )
          while ( not HasAnimSetLoaded( clipset ) ) do
            Citizen.Wait( 100 )
          end
          if ( crouched == true ) then
            ResetPedMovementClipset( playerPed, 0 )
            crouched = false
          elseif ( crouched == false ) then
            SetPedMovementClipset( playerPed, clipset, 0.25 )
            crouched = true
          end
        end
      end
    end
  end
end)

---------------------------------------------------------
-- stop seat shuffling in vehicles, vehicle brakelight --
---------------------------------------------------------
local brakeLight = true

RegisterNetEvent("usa:shuffleSeats")
AddEventHandler("usa:shuffleSeats", function()
  if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), 0) == playerPed then
    Wait(700)
    SetPedIntoVehicle(playerPed, GetVehiclePedIsIn(playerPed, false), -1)
  elseif IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then
    Wait(700)
    SetPedIntoVehicle(playerPed, GetVehiclePedIsIn(playerPed, false), 0)
  else
    CancelEvent()
  end
end)

RegisterNetEvent('usa:toggleBrakelight')
AddEventHandler('usa:toggleBrakelight', function()
    brakeLight = not brakeLight
    if brakeLight then
        TriggerEvent('usa:notify', 'Your idle brakelight is now ~g~on~s~.')
    else
        TriggerEvent('usa:notify', 'Your idle brakelight is now ~r~off~s~.')
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)

        
        if IsPedInAnyVehicle(playerPed, false) then
          local curVeh = GetVehiclePedIsIn(playerPed, false)
            if GetPedInVehicleSeat(curVeh, 0) == playerPed then
                if GetIsTaskActive(playerPed, 165) then
                    SetPedIntoVehicle(playerPed, curVeh, 0)
                end
            end
        end

        if brakeLight then
            if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
                if IsPedSittingInAnyVehicle(playerPed) then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)

                    if GetVehicleClass(vehicle) ~= 14 and GetVehicleClass(vehicle) ~= 15 and GetVehicleClass(vehicle) ~= 16 and GetVehicleClass(veh) ~= 21 then
                        if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                            if GetEntitySpeed(vehicle) == 0 and GetIsVehicleEngineRunning(vehicle) then
                                SetVehicleBrakeLights(vehicle, true)
                            end
                        end
                    end
                end
            end
        end
    end
end)

------------------------------------
-- V E H I C L E  C O N T R O L S --
-- roll windows [usage: /rollw]   --
------------------------------------
local windowup = true
RegisterNetEvent("RollWindow")
AddEventHandler('RollWindow', function()
    local playerCar = GetVehiclePedIsIn(playerPed, false)
    if DoesEntityExist(playerCar) then
        if ( GetPedInVehicleSeat( playerCar, -1 ) == playerPed ) then
          --SetEntityAsMissionEntity( playerCar, true, true )
          if ( windowup ) then
            RollDownWindow(playerCar, 0)
            RollDownWindow(playerCar, 1)
            --TriggerEvent('chatMessage', '', {255,0,0}, 'Windows down')
            windowup = false
          else
            RollUpWindow(playerCar, 0)
            RollUpWindow(playerCar, 1)
            --TriggerEvent('chatMessage', '', {255,0,0}, 'Windows up')
            windowup = true
          end
        end
    end
end )

local last_car = 0

RegisterNetEvent("veh:openDoor")
AddEventHandler("veh:openDoor", function(index)
   -- print("opening door with index = " .. index)
        local playerCar = GetVehiclePedIsIn(playerPed, true)
        if playerCar ~= 0 then
          last_car = playerCar
        else
          playerCar = last_car
        end
        if index == "trunk" then
            --print("index was trunk!")
            SetVehicleDoorOpen(playerCar, 5, true, true)
        elseif index == "hood" then
            SetVehicleDoorOpen(playerCar, 4, true, true)
        elseif index == "fl" then
            SetVehicleDoorOpen(playerCar, 0, true, true)
        elseif index == "fr" then
            SetVehicleDoorOpen(playerCar, 1, true, true)
        elseif index == "bl" then
            SetVehicleDoorOpen(playerCar, 2, true, true)
        elseif index == "br" then
        SetVehicleDoorOpen(playerCar, 3, true, true)
        elseif index == "ambulance" then
            SetVehicleDoorOpen(playerCar, 2, true, true)
            SetVehicleDoorOpen(playerCar, 3, true, true)
        end
end)

RegisterNetEvent("veh:shutDoor")
AddEventHandler('veh:shutDoor', function(index)
    --print("inside shut door!")
        local playerCar = GetVehiclePedIsIn(playerPed, false)
        if playerCar ~= 0 then
          last_car = playerCar
        else
          playerCar = last_car
        end
        if index == "trunk" then
            SetVehicleDoorShut(playerCar, 5, false)
        elseif index == "hood" then
            SetVehicleDoorShut(playerCar, 4, false)
        elseif index == "fl" then
            SetVehicleDoorShut(playerCar, 0, false)
        elseif index == "fr" then
            SetVehicleDoorShut(playerCar, 1, false)
        elseif index == "bl" then
            SetVehicleDoorShut(playerCar, 2, false)
        elseif index == "br" then
        SetVehicleDoorShut(playerCar, 3, false)
        elseif index == "ambulance" then
            SetVehicleDoorShut(playerCar, 2, false)
            SetVehicleDoorShut(playerCar, 3, false)
        end
end)

-- void SET_VEHICLE_NEEDS_TO_BE_HOTWIRED(Vehicle vehicle, BOOL toggle);

local policeVehicles = {
    1171614426, -- ambulance
    1127131465, -- fbi
    -1647941228, -- fbi2
    1938952078, -- firetruck
    2046537925, -- police
    -1627000575, -- police2
    1912215274, -- police3
    -1973172295, -- police4
    0x9C32EB57, -- Police5
    0xB2FF98F0, -- police 6
    0xC4B53C5B, -- police 7
    0xD0AF544F, -- police 8
    -34623805, -- policeb
    741586030, -- pranger
    -1205689942, -- riot
	-672516475, -- unmarked9
	-1960928017, -- unmarked8
	-59441254, -- unmarked7 (slicktop)
	-1663942570, -- unmarked6
	1109330673, -- unmarked4
	-1285460620, -- unmarked3
	1383443358 -- unmarked1

}

Citizen.CreateThread(function()
  while true do
    playerPed = PlayerPedId() -- !! IMPORTANT! DO NOT DELETE! THIS SETS playerPed FOR THE _WHOLE_ SCRIPT!! !!
    Wait(2)
  end
end)

------------------------------------
-- remove vehicle weapon rewards  --
------------------------------------
Citizen.CreateThread(function()
    while true do
        Wait(10)
        DisablePlayerVehicleRewards(PlayerId())
    end
end)

-----------------------
-- UTILITY FUNCTIONS --
-----------------------
RegisterNetEvent("usa:notify")
AddEventHandler("usa:notify", function(msg, chatMsg)
  if msg ~= false then
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
      TriggerEvent('chatMessage', '', {0,0,0}, '^0' .. chatMsg)
  end
end)

RegisterNetEvent('usa:showHelp')
AddEventHandler('usa:showHelp', function(beep, msg)
  SetTextComponentFormat("STRING")
  AddTextComponentString(msg)
  DisplayHelpTextFromStringLabel(0, 0, beep, -1)
end)

local playing_anim = nil
RegisterNetEvent("usa:playAnimation")
AddEventHandler("usa:playAnimation", function(animDict, animName, speed, speedMult, duration, flag, playbackRate, lockX, lockY, lockZ, actualDuration)
    local me = PlayerPedId()
    local isInVeh = IsPedInAnyVehicle(me, true)
    if isInVeh and flag == 53 then
      return -- avoids falling through ground when doing animation in car
    end
    if not IsPedDeadOrDying(me) then
      -- load animation
      RequestAnimDict(animDict)
      while not HasAnimDictLoaded(animDict) do
          Citizen.Wait(100)
      end
      TaskPlayAnim(me, animDict, animName, speed, speedMult, duration, flag, playbackRate, lockX, lockY, lockZ)
      playing_anim = {
          dict = animDict,
          name = animName
      }
      if actualDuration then
          Wait(actualDuration * 1000)
          StopAnimTask(me, animDict, animName, 1.0)
      else
        while IsEntityPlayingAnim(me, animDict, animName, 3) do
          Wait(10)
        end
        StopAnimTask(me, animDict, animName, 1.0)
      end
    end
end)

RegisterNetEvent("usa:playSound")
AddEventHandler("usa:playSound", function(soundParams)
  -- play start up / shut off sound
  PlaySoundFrontend(table.unpack(soundParams))
end)

RegisterNetEvent("usa:playScenario")
AddEventHandler("usa:playScenario", function(scenario)
    TaskStartScenarioInPlace(playerPed, scenario, 0, 1)
end)

RegisterNetEvent("usa:heal")
AddEventHandler("usa:heal", function(amount)
	local curr_hp = GetEntityHealth(playerPed)
	SetEntityHealth(playerPed, curr_hp + amount)
end)

-- prevent falling through vehicle when eating/drink and entering vehicle:
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
    --print("trying to enter: " .. GetVehiclePedIsTryingToEnter(PlayerPedId(GetPlayerPed(-1))))
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(playerPed))) then
      --ClearPedSecondaryTask(GetPlayerPed(-1))
      if playing_anim then
        StopAnimTask(playerPed, playing_anim.dict, playing_anim.name, 1.0)
      end
		end
	end
end)

RegisterNetEvent("usa:dropWeapon")
AddEventHandler("usa:dropWeapon", function(weapon_hash)
	--print("typeof weapon_hash: " .. type(weapon_hash))
  RemoveWeaponFromPed(playerPed, weapon_hash) -- right params?
  --SetPedDropsWeapon(weapon_hash) -- or this? or both?
end)

RegisterNetEvent("usa:loadCivCharacter")
AddEventHandler("usa:loadCivCharacter", function(character, playerWeapons)
  Citizen.CreateThread(function()
    local ped = GetPlayerPed(-1)
    local model
    if not character.hash then -- does not have any customizations saved
      --print("did not find character.hash!")
      model = -408329255 -- some random black dude with no shirt on, lawl
    else
      --print("found a character hash!")
      model = character.hash
    end
    RequestModel(model)
    while not HasModelLoaded(model) do -- Wait for model to load
      Citizen.Wait(100)
    end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    -- give model customizations if available
    if character.hash then
      for key, value in pairs(character["components"]) do
        SetPedComponentVariation(ped, tonumber(key), value, character["componentstexture"][key], 0)
      end
      for key, value in pairs(character["props"]) do
        SetPedPropIndex(ped, tonumber(key), value, character["propstexture"][key], true)
      end
    end
    TriggerServerEvent("spawn:loadCustomizations")
    -- give weapons
    if playerWeapons then
      for i = 1, #playerWeapons do
        local weapon = playerWeapons[i]
        local currentWeaponAmmo = ((weapon.magazine and weapon.magazine.currentCapacity) or 0)
        TriggerEvent("interaction:equipWeapon", weapon, true, currentWeaponAmmo, false)
      end
    end
  end)
end)

RegisterNetEvent("usa:setPlayerComponents")
AddEventHandler("usa:setPlayerComponents", function(character)
  -- set model and clothing --
  if character.hash then
    if character.hash == GetHashKey("mp_m_freemode_01") or character.hash == GetHashKey("mp_f_freemode_01") then
      -- set clothing --
      for key, value in pairs(character["components"]) do
        SetPedComponentVariation(playerPed, tonumber(key), value, character["componentstexture"][key], 0)
      end
      -- set props --
      ClearPedProp(playerPed, 6) -- left wrist (needed for usa_vangelico)
      ClearPedProp(playerPed, 7) -- right wrist (needed for usa_vangelico)
      for key, value in pairs(character["props"]) do
        ClearPedProp(playerPed, tonumber(key))
        SetPedPropIndex(playerPed, tonumber(key), value, character["propstexture"][key], true)
      end
      -- set tattoos --
      ClearPedDecorations(playerPed)
      -- set barbershop customizations --
      TriggerServerEvent("spawn:loadCustomizations")
    else
      -- non-MP model --
      Citizen.CreateThread(function()
				RequestModel(character.hash)
				while not HasModelLoaded(character.hash) do
					Citizen.Wait(100)
				end
				SetPlayerModel(PlayerId(), character.hash)
				SetPedRandomComponentVariation(playerPed, true)
				SetModelAsNoLongerNeeded(character.hash)
			end)
    end
  else
    -- set default --
    Citizen.CreateThread(function()
      local model = GetHashKey("a_m_y_skater_01")
      RequestModel(model)
      while not HasModelLoaded(model) do
        Citizen.Wait(100)
      end
      SetPlayerModel(PlayerId(), model)
      SetPedRandomComponentVariation(playerPed, true)
      SetModelAsNoLongerNeeded(model)
    end)
  end
end)

RegisterNetEvent("usa:getClosestPlayer")
AddEventHandler("usa:getClosestPlayer", function(range, cb)
	local id, name, dist = GetClosestPlayerInfo(range)
  local player = {
    id = id,
    name = name,
    dist = dist
  }
  cb(player)
end)

function GetClosestPlayerInfo(range)
	local closestDistance = 0
	local closestPlayerServerId = 0
	local closestName = ""
	for x = 0, 255 do
		if NetworkIsPlayerActive(x) then
			targetPed = GetPlayerPed(x)
			targetPedCoords = GetEntityCoords(targetPed, false)
			playerPedCoords = GetEntityCoords(playerPed, false)
			distanceToTargetPed = Vdist(playerPedCoords.x, playerPedCoords.y, playerPedCoords.z, targetPedCoords.x, targetPedCoords.y, targetPedCoords.z)
			if targetPed ~= playerPed and IsEntityVisible(targetPed) then
				if distanceToTargetPed < 10 then
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

--------------------------------
------ DELETE VEHICLE ----------
--------------------------------
RegisterNetEvent("impound:notify")
AddEventHandler("impound:notify", function(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end)

-- Register a network event
RegisterNetEvent( 'impoundVehicle' )

-- The distance to check in front of the player for a vehicle
-- Distance is in GTA units, which are quite big
local distanceToCheck = 5.0

-- Add an event handler for the deleteVehicle event.
-- Gets called when a user types in /impound in chat (see server.lua)
AddEventHandler('impoundVehicle', function(doImmediately)
  local ped = PlayerPedId()
  local pos = GetEntityCoords(ped)
  local nearestVeh = GetClosestVehicle(pos.x, pos.y, pos.z, 3.0, 0, 70)
  local currentVeh = GetVehiclePedIsIn(ped, false)

  if currentVeh and DoesEntityExist(currentVeh) then
      local plate = GetVehicleNumberPlateText(currentVeh)
      TriggerServerEvent("impound:impoundVehicle", currentVeh, plate)

      local success = lib.progressBar({
          duration = doImmediately and 1000 or 45000,
          label = 'Impounding vehicle',
          canCancel = true,
          anim = {
              dict = 'missfam4',
              clip = 'base'
          },
          prop = {
              model = 'prop_fib_clipboard',
              pos = vec3(0.0, 0.0, 0.0),
              rot = vec3(0.0, 0.0, 0.0)
          },
          disable = {
              move = true,
              combat = true
          },
      })

      if success then
          NetworkRequestControlOfEntity(currentVeh)
          local timeout = 5000 
          while not NetworkHasControlOfEntity(currentVeh) do
              Wait(100)
              timeout = timeout - 100
              if timeout <= 0 then
                  exports.globals:notify("Failed to impound the vehicle.", "^3INFO: ^0Timeout exceeded.")
                  return
              end
          end

          SetEntityAsMissionEntity(currentVeh, true, true)
          while not IsEntityAMissionEntity(currentVeh) do
              Wait(100)
          end

          DeleteVehicle(currentVeh)
          if DoesEntityExist(currentVeh) then
              DeleteEntity(currentVeh)
          end

          exports.globals:notify("Vehicle Impounded!", "^3INFO: ^0Vehicle Impounded!")
          ClearPedTasks(ped)
      else
          exports.globals:notify("Impound cancelled.", "^3INFO: ^0Impound cancelled.")
      end
  elseif nearestVeh and DoesEntityExist(nearestVeh) then
      local plate = GetVehicleNumberPlateText(nearestVeh)
      TriggerServerEvent("impound:impoundVehicle", nearestVeh, plate)

      local success = lib.progressBar({
          duration = doImmediately and 1000 or 45000,
          label = 'Impounding nearest vehicle',
          canCancel = true,
          anim = {
              dict = 'missfam4',
              clip = 'base'
          },
          prop = {
              model = 'prop_fib_clipboard',
              pos = vec3(0.0, 0.0, 0.0),
              rot = vec3(0.0, 0.0, 0.0)
          },
          disable = {
              move = true,
              combat = true
          },
      })

      if success then
          NetworkRequestControlOfEntity(nearestVeh)
          local timeout = 5000 
          while not NetworkHasControlOfEntity(nearestVeh) do
              Wait(100)
              timeout = timeout - 100
              if timeout <= 0 then
                  exports.globals:notify("Failed to impound the nearest vehicle.", "^3INFO: ^0Timeout exceeded.")
                  return
              end
          end

          SetEntityAsMissionEntity(nearestVeh, true, true)
          while not IsEntityAMissionEntity(nearestVeh) do
              Wait(100)
          end

          DeleteVehicle(nearestVeh)
          if DoesEntityExist(nearestVeh) then
              DeleteEntity(nearestVeh)
          end

          exports.globals:notify("Nearest Vehicle Impounded!", "^3INFO: ^0Nearest Vehicle Impounded!")
          ClearPedTasks(ped)
      else
          exports.globals:notify("Impound cancelled.", "^3INFO: ^0Impound cancelled.")
      end
  else
      exports.globals:notify("No nearby vehicle to impound.", "^3INFO: ^0No nearby vehicle.")
  end
end)

--------------------------------
------ FINGER POINTING ---------
--------------------------------

local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(1)

        if once then
            once = false
        end

        if IsControlJustPressed(0, 29) and not mp_pointing and GetLastInputMethod(0) then
            Wait(50)
            if IsControlPressed(0, 29) then
                startPointing()
                mp_pointing = true
            end
        elseif (IsControlJustReleased(0, 29) and mp_pointing) then
            mp_pointing = false
            stopPointing()
        end

        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

        end
    end
end)

-- Credit to Savage for code
Citizen.CreateThread(function()
  while true do
      DistantCopCarSirens(false)
      Citizen.Wait(400)
  end
end)

-- Gets a vehicle in a certain direction
-- Credit to Konijima
function GetVehicleInDirection( coordFrom, coordTo, distance, ped )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    if Vdist2(GetEntityCoords(ped), GetEntityCoords(vehicle)) < distance then
        return vehicle
    else 
        return nil
    end
end

-- Shows a notification on the player's screen
function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

function log( msg )
    Citizen.Trace( "\n[DEBUG]: " .. msg )
end
------------------------------
------------------------------
------------------------------

-- disable controlling when in air --
function disableAirControl(ped, veh)
	--if not IsThisModelBlacklisted(veh) then
		if IsPedSittingInAnyVehicle(ped) then
			if GetPedInVehicleSeat(veh, -1) == ped then
				if IsEntityInAir(veh) and GetVehicleClass(veh) ~= VEH_CLASS.Motorcycle and GetVehicleClass(veh) ~= VEH_CLASS.Bicycle then
					DisableControlAction(0, 59)
					DisableControlAction(0, 60)
				end
			end
		end
	--end
end

Citizen.CreateThread(function()
    while true do
		local ped = GetPlayerPed(-1)
		local veh = GetVehiclePedIsIn(ped)
		if DoesEntityExist(veh) then
			disableAirControl(ped, veh)
		end
		Wait(1)
	end
end)

-- add static objects --
local LARGE_XMAS_TREE_MODEL = 118627012
local ATM_MODEL = GetHashKey("prop_atm_02")
local ATM_MODEL2 = GetHashKey("prop_atm_01")
local PRISON_TV = GetHashKey("prop_cs_tv_stand")
local PHONEBOX_STANDING = GetHashKey("p_phonebox_01b_s")

local STATIC_OBJECTS = {
  AUTOREPAIR_ATM = {
    coords = vector3(948.26678466797, -966.03826904297, 38.399954223633),
    heading = 275.0,
    obj = ATM_MODEL2
  },
  MRPDINSIDE_ATM = {
    coords = vector3(450.7041015625, -978.35429199219, 29.659582824707),
    heading = 0.0,
    obj = ATM_MODEL2
  },
  LEGACYTAVERN_ATM = {
    coords = vector3(-563.4963, 280.9992, 81.07641),
    heading = 175.0,
    obj = ATM_MODEL2
  },
  ARENA_AMMUNATION = {
    obj = GetHashKey("gr_prop_gr_bench_02b"),
    coords = vector3(-1306.193, -3388.326, 12.94015),
    heading = 58.0
  },
  --LEGION = {226.48237609863, -895.41094970703, 28.692138671875},
  --UPPER_PILLBOX = {242.40295410156, -565.30682373047, 41.278789520264},
  --BURGERSHOT = { -1191.5321044922, -894.51275634766, 18.479234695435},
  --PDM = { -30.562828063965, -1100.5909423828, 32.261386108398},
  --MRPD = { 455.22213745117, -1024.1641845703, 26.466562271118},
  --[[
  BS_ATM = {
    coords = vector3(-1205.6720947266, -889.24501953125, 12.570239067078),
    heading = 215.0,
    obj = ATM_MODEL
  }
  XMAS_TREE_LEGION = {
    coords = vector3(226.48237609863, -895.41094970703, 28.692138671875),
    obj = LARGE_XMAS_TREE_MODEL
  },
  XMAS_TREE_UPPER_PILLBOX = {
    coords = vector3(242.40295410156, -565.30682373047, 41.278789520264),
    obj = LARGE_XMAS_TREE_MODEL
  },
  XMAS_TREE_UPPER_BURGERSHOT = {
    coords = vector3(-1191.5321044922, -894.51275634766, 18.479234695435),
    obj = LARGE_XMAS_TREE_MODEL
  },
  XMAS_TREE_UPPER_PDM = {
    coords = vector3(-30.562828063965, -1100.5909423828, 32.261386108398),
    obj = LARGE_XMAS_TREE_MODEL
  },
  --]]
  LAMESAPD_ATM = {
    coords = vector3(827.39788818359, -1287.6212158203, 27.234066009521),
    heading = 268.0,
    obj = ATM_MODEL2
  },
  AUTOEXOTIC_ATM = {
    coords = vector3(540.60186767578, -183.83302307129, 53.485401153564),
    heading = 270.0,
    obj = ATM_MODEL2
  }
}

for _, info in pairs(STATIC_OBJECTS) do
  local handle = CreateObject(info.obj, info.coords.x, info.coords.y, info.coords.z, false, false, false)
  info.handle = handle
  if info.heading then
    SetEntityHeading(handle, info.heading)
  end
  FreezeEntityPosition(handle, true)
end

AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() == resourceName then
    for _, info in pairs(STATIC_OBJECTS) do
      if info.handle and DoesEntityExist(info.handle) then
        DeleteObject(info.handle)
        info.handle = nil
      end
    end
  end
end)

-- Vehicle Neon Controls --
local VehiclesWithNeons = {}

local function HasNeon(vehicle)
  if VehiclesWithNeons[vehicle] ~= nil then
    return true
  end

  if IsVehicleNeonLightEnabled(vehicle) then
    VehiclesWithNeons[vehicle] = true
    return true
  end
end

local function LightLogic()
	local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false)

	if not vehicle or not IsPedInAnyVehicle(playerPed, false) or GetPedInVehicleSeat(vehicle, -1) ~= playerPed then return end -- ignore if not in car or driver seat
	
	local hasNeons = HasNeon(vehicle)

	if not hasNeons then return end
    
  local neonsOn = (VehiclesWithNeons[vehicle] ~= nil and VehiclesWithNeons[vehicle] or false)

	SetVehicleNeonLightEnabled(vehicle, 0, not neonsOn)
	SetVehicleNeonLightEnabled(vehicle, 1, not neonsOn)
	SetVehicleNeonLightEnabled(vehicle, 2, not neonsOn)
	SetVehicleNeonLightEnabled(vehicle, 3, not neonsOn)
  VehiclesWithNeons[vehicle] = not neonsOn
end

RegisterCommand("toggleneons", function()
	if antiSpam then return end
		
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	if not vehicle or not IsPedInAnyVehicle(playerPed, false) or GetPedInVehicleSeat(vehicle, -1) ~= playerPed then return end

	LightLogic()
	antiSpam = true

	Wait(1250)
	antiSpam = false
end, false)

RegisterKeyMapping("toggleneons", 'Toggle Underglow', 'keyboard', 'G')

local function CheckVehicles()
  for k,v in pairs(VehiclesWithNeons) do
    local valid = DoesEntityExist(k)

    if (not valid) then
      VehiclesWithNeons[k] = nil
      return
    end
  end

  Wait(300000)
  CheckVehicles()
end

Citizen.CreateThread(function()
  CheckVehicles()
end)

-- Remove Props At a certain coord --
local PropInfo = {
  { -- pd targets
    Coords = vector3(478.07559204102, -1005.5838623047, 30.689582824707),
    Props = {
      {Hash = `gabz_mrpd_shooting_target`, Range = 12.0},
    }
  },
  { -- legion ammunation targets
    Coords = vector3(18.08592, -1088.539, 29.79719),
    Props = {
      {Hash = `gr_prop_gr_target_05c`, Range = 12.0},
    }
  },
  { -- legion ammunation target arms
    Coords = vector3(18.08592, -1088.539, 29.79719),
    Props = {
      {Hash = `prop_target_arm_b`, Range = 12.0},
    }
  },
  { -- docks ammunation targets
    Coords = vector3(820.2431, -2173.661, 29.61917),
    Props = {
      {Hash = `gr_prop_gr_target_05c`, Range = 12.0},
    }
  },
  { -- docks ammunation target arms
    Coords = vector3(820.2431, -2173.661, 29.61917),
    Props = {
      {Hash = `prop_target_arm_b`, Range = 12.0},
    }
  },
}

Citizen.CreateThread(function()
  for k,v in ipairs(PropInfo) do
    for k2,v2 in ipairs(v.Props) do
      CreateModelHideExcludingScriptObjects(v.Coords, v2.Range or 0.0, v2.Hash, true)
    end
  end
end)

-- prevent auto shuffle in vehicle
Citizen.CreateThread(function()
  local lastPedWeSetConfigFor = 0
  while true do
    local me = PlayerPedId()
    if me ~= lastPedWeSetConfigFor then
        SetPedConfigFlag(me, 184, true)
        lastPedWeSetConfigFor = me
    end
    Wait(1)
  end
end)

-- Remove Legacy Tavern Peds --
Citizen.CreateThread(function()
  while true do
    ClearAreaOfPeds(-556.6475, 286.6953, 82.17631, 25.0, 1)
    Citizen.Wait(10000)
  end
end)

-- Remove Legacy Tavern Music --
Citizen.CreateThread(function()
  while true do
    SetStaticEmitterEnabled("collision_9qv4ecm", false)
    Citizen.Wait(10000)
  end
end)