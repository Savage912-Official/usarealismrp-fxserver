--
-- MADE BY DISTRITIC / MINIPUNCH
-- A player will get close to a designated blip on the map within this script, press "E", and begin gathering.
-- This same concept within the script will handle all aspects of a job from getting supplies, processing, to selling, etc.
--

local INPUT_KEY = 38 -- E

local meth = {
    peds = {
        {x = 705.34, y = 4185.25, z = 40.7858, name = "meth_supplies_ped", model = "U_M_O_TAPHILLBILLY"},
        {x = -1149.1988525391, y = 4938.3979492188, z = 222.26870727539, name = "meth_supplies_ped_quality", model = 'A_M_M_HILLBILLY_01'}
    },
    suppliesProduce = "Pseudoephedrine",
    suppliesProduceQuality = 'Red Phosphorus',
    suppliesProcess = "Meth Rock",
    suppliesProcessQuality = "Blue Meth Rock",
    pedIsBusy = false,
    processingMeth = false,
    producingMeth = false,
    methToProcess = nil,
    methIngredients = {}
}

local peds = {}

-- /gotoc 1149.1988525391 4938.3979492188 222.26870727539,
-- /gotoc 738.85601806641 -773.63940429688 25.093187332153
local BUY_RED_PHOS_COORDS = {x = -1149.1988525391, y = 4938.3979492188, z = 222.26870727539}
local BUY_PSEUDOPHEDRINE_COORDS = {x = 704.62, y = 4185.3, z = 40.70}
local PACKAGE_COORDS = {x = 2434.78, y = 4964.29, z = 42.34}
local COOK_COORDS = {x = 738.85601806641, y = -773.63940429688, z = 25.093187332153}

local methRank = nil

local blowChances = {0.13, 0.10, 0.07, 0.04, 0.01}
local produceTimes = {23000, 19000, 15000, 12000, 10000}
local packageTimes = {7500,6500,5500,4500,3500}

math.randomseed(GetGameTimer())

-- JOB HANDLING
Citizen.CreateThread(function()
    local cooldown = GetGameTimer()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        --DrawText3D(996.50, -3200.201, -36.19, 5, '[E] - Exit')
        --DrawText3D(138.18, 2295.25, 94.09, 4, '[E] - Enter')
        DrawText3D(BUY_PSEUDOPHEDRINE_COORDS.x, BUY_PSEUDOPHEDRINE_COORDS.y, BUY_PSEUDOPHEDRINE_COORDS.z, 5, '[E] - Buy Pseudoephedrine (~g~$175.00~w~) | [Hold E] - Hint')
        DrawText3D(BUY_RED_PHOS_COORDS.x, BUY_RED_PHOS_COORDS.y, BUY_RED_PHOS_COORDS.z, 3, '[E] - Buy Red Phosphorus (~g~$150.00~w~) | [Hold E] - Hint')
        DrawText3D(COOK_COORDS.x, COOK_COORDS.y, COOK_COORDS.z, 5, '[E] - Cook Meth | [Hold E] - Hint')
        DrawText3D(PACKAGE_COORDS.x, PACKAGE_COORDS.y, PACKAGE_COORDS.z, 5, '[E] - Package Meth')
        if IsControlJustPressed(0, INPUT_KEY) then
            -- if GetDistanceBetweenCoords(playerCoords, 996.90, -3200.701, -36.39, true) < 0.7 then
            --     DoorTransition(playerPed, 138.18, 2295.25, 94.09, 78.12)
            -- elseif GetDistanceBetweenCoords(playerCoords, 138.18, 2295.25, 94.09, true) < 0.7 then
            --     DoorTransition(playerPed, 996.90, -3200.701, -36.39, 270.0)
            if GetDistanceBetweenCoords(playerCoords, BUY_PSEUDOPHEDRINE_COORDS.x, BUY_PSEUDOPHEDRINE_COORDS.y, BUY_PSEUDOPHEDRINE_COORDS.z, true) < 3 and not meth.pedIsBusy and GetGameTimer() - cooldown > 2000 then -- purchase supplies
                Wait(500)
                if not IsControlPressed(0, INPUT_KEY) then
                  TriggerServerEvent("methJob:checkUserMoney", meth.suppliesProduce)
                  cooldown = GetGameTimer()
                else
                  TriggerEvent("chatMessage", "", {}, "^3Chemical Dealer:^0 You can take these chemicals to my bud's lab in Los Santos. It's just east of the canal and just North of San Andreas Ave. If you look you should see a door to get into the building to process the chemicals in an alley behind some buildings.")
                end
            elseif GetDistanceBetweenCoords(playerCoords, COOK_COORDS.x, COOK_COORDS.y, COOK_COORDS.z, true) < 3 and not meth.producingMeth and GetGameTimer() - cooldown > 2000 and not IsPedDeadOrDying(playerPed, true) then -- produce meth rocks
                Wait(500)
                if not IsControlPressed(0, INPUT_KEY) then
                  TriggerServerEvent("methJob:checkUserJobSupplies", meth.suppliesProduce, meth.suppliesProduceQuality, methRank)
                  cooldown = GetGameTimer()
                else
                  TriggerEvent("chatMessage", "", {}, "^3HINT: ^0You can take cooked meth to get packaged at the O'Neill's Ranch in Grapeseed.")
                end
            elseif GetDistanceBetweenCoords(playerCoords, PACKAGE_COORDS.x, PACKAGE_COORDS.y, PACKAGE_COORDS.z, true) < 3 and not meth.processingMeth and GetGameTimer() - cooldown > 2000 and not IsPedDeadOrDying(playerPed, true) then -- process/package meth rocks
                TriggerServerEvent("methJob:checkUserJobSupplies", meth.suppliesProcess, meth.suppliesProcessQuality, methRank)
                cooldown = GetGameTimer()
            elseif GetDistanceBetweenCoords(playerCoords, BUY_RED_PHOS_COORDS.x, BUY_RED_PHOS_COORDS.y, BUY_RED_PHOS_COORDS.z, true) < 3 and not meth.pedIsBusy and GetGameTimer() - cooldown > 2000 then -- purchase quality supplies
              Wait(500)
              if not IsControlPressed(0, INPUT_KEY) then
                TriggerServerEvent("methJob:checkUserMoney", meth.suppliesProduceQuality)
                cooldown = GetGameTimer()
              else
                  TriggerEvent("chatMessage", "", {}, "^3Chemical Dealer:^0 You can take these chemicals to my bud's lab in Los Santos. It's just east of the canal and just North of San Andreas Ave. If you look you should see a door to get into the building to process the chemicals in an alley behind some buildings.")
              end
            end
        end
        if meth.producingMeth and GetDistanceBetweenCoords(playerCoords, COOK_COORDS.x, COOK_COORDS.y, COOK_COORDS.z, true) > 6 then -- too far from being able to process
            TriggerEvent("usa:notify", "You went ~y~out of range~w~.")
            if meth.producingMeth then
                for k = 1, #meth.methIngredients do
                    while securityToken == nil do
                        Wait(1)
                    end
                    TriggerServerEvent("methJob:giveChemicals", meth.methIngredients[k], securityToken)
                end
                meth.methIngredients = {}
            end
            meth.producingMeth = false
        elseif meth.processingMeth and GetDistanceBetweenCoords(playerCoords, PACKAGE_COORDS.x, PACKAGE_COORDS.y, PACKAGE_COORDS.z, true) > 6 then
            TriggerEvent("usa:notify", "You went ~y~out of range~w~.")
            meth.methToProcess = nil
            meth.processingMeth = false
        end
    end
end)

-- thread code stuff below was taken from an example on the wiki
-- Create a thread so that we don't 'wait' the entire game
Citizen.CreateThread(function()
    -- Spawn the peds
    for j = 1, #meth.peds do
        local hash = GetHashKey(meth.peds[j].model)
        -- Request the model so that it can be spawned
        RequestModel(hash)
        -- Check if it's loaded, if not then wait and re-request it.
        while not HasModelLoaded(hash) do
	        Citizen.Wait(100)
        end
         -- Model loaded, continue
        local x = meth.peds[j].x
        local y = meth.peds[j].y
        local z = meth.peds[j].z

        --Citizen.Trace("spawned in ped # " .. i)
        local ped = CreatePed(4, hash, x, y, z, 333.82864379883 --[[Heading]], false --[[Networked, set to false if you just want to be visible by the one that spawned it]], false --[[Dynamic]])
        SetEntityCanBeDamaged(ped,false)
        SetPedCanRagdollFromPlayerImpact(ped,false)
        TaskSetBlockingOfNonTemporaryEvents(ped,true)
        SetPedFleeAttributes(ped,0,0)
        SetPedCombatAttributes(ped,17,1)
        -- add to peds collection
        table.insert(peds, {name = meth.peds[j].name, handle = ped})
    end
end)

RegisterNetEvent("methJob:returnPedToStartPosition")
AddEventHandler("methJob:returnPedToStartPosition", function(pedType)
    for i =1, #peds do
        if pedType == peds[i].name then
            TaskGoStraightToCoord(peds[i].handle, meth.peds[i].x, meth.peds[i].y, meth.peds[i].z, 2, -1)
            SetBlockingOfNonTemporaryEvents(peds[i].handle, false)
            meth.pedIsBusy = false
        end
    end
end)

RegisterNetEvent("methJob:doesUserHaveJobSupply")
AddEventHandler("methJob:doesUserHaveJobSupply", function(hasJobSupply, supplyName, supplyName2)
    if hasJobSupply then
        if supplyName == meth.suppliesProduce or supplyName == meth.suppliesProduceQuality then
            table.insert(meth.methIngredients, supplyName)
            print('inserted item: '..supplyName)
            meth.producingMeth = true
        elseif supplyName == meth.suppliesProcess or supplyName == meth.suppliesProcessQuality then
            meth.processingMeth = true
            meth.methToProcess = supplyName
        end
    else
        if supplyName == meth.suppliesProduce then
            for i = 1, #meth.methIngredients do
                if meth.methIngredients[i] == meth.suppliesProduce then
                    return
                end
            end
            TriggerEvent('usa:notify', 'You do not have any ~y~Pseudoephedrine~s~!')
        elseif supplyName == meth.suppliesProcess or supplyName == meth.suppliesProcessQuality and supplyName2 == meth.suppliesProcess or supplyName2 == meth.suppliesProcessQuality then
            TriggerEvent('usa:notify', 'You do not have any ~y~Meth Rocks~s~!')
        end
    end
end)

RegisterNetEvent("methJob:getSupplies")
AddEventHandler("methJob:getSupplies", function(supplyType)
    if supplyType == meth.suppliesProduce then
        for i = 1, #peds do
            if peds[i].name == "meth_supplies_ped" then
                meth.pedIsBusy = true
                TaskGoStraightToCoord(peds[i].handle, 711.15, 4185.45, 41.08, 2, -1) -- pier by Grapeseed
                SetBlockingOfNonTemporaryEvents(peds[i].handle, false)
                TriggerServerEvent("methJob:startTimer", "meth_supplies_ped")
                local sounds = {
                  {sound = "Shout_Threaten_Ped", param = "Speech_Params_Force_Shouted_Critical"},
                  {sound = "Shout_Threaten_Gang", param = "Speech_Params_Force_Shouted_Critical"},
                  {sound = "Generic_Hi", param = "Speech_Params_Force"}
                }
                local random_sound = sounds[math.random(1, tonumber(#sounds))]
                PlayAmbientSpeech1(peds[i].handle, random_sound.sound, random_sound.param)
            end
        end
    elseif supplyType == meth.suppliesProduceQuality then
        for i = 1, #peds do
            if peds[i].name == "meth_supplies_ped_quality" then
                meth.pedIsBusy = true
                TaskGoStraightToCoord(peds[i].handle, -1150.1939697266, 4940.9306640625, 222.26870727539, 2, -1)
                SetBlockingOfNonTemporaryEvents(peds[i].handle, false)
                TriggerServerEvent("methJob:startTimer", "meth_supplies_ped_quality")
                local sounds = {
                  {sound = "Shout_Threaten_Ped", param = "Speech_Params_Force_Shouted_Critical"},
                  {sound = "Shout_Threaten_Gang", param = "Speech_Params_Force_Shouted_Critical"},
                  {sound = "Generic_Hi", param = "Speech_Params_Force"}
                }
                local random_sound = sounds[math.random(1, tonumber(#sounds))]
                PlayAmbientSpeech1(peds[i].handle, random_sound.sound, random_sound.param)
            end
        end
    end
end)

RegisterNetEvent("methJob:setRank")
AddEventHandler("methJob:setRank", function(rank)
    if methRank == nil then
        methRank = rank
    else
        if rank ~= methRank then
            methRank = rank
            TriggerEvent("usa:notify", "Level Up! Your meth rank is now "..methRank)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if meth.producingMeth then
            beginTime = GetGameTimer()
            animDict = "timetable@jimmy@ig_1@idle_a"
            animName = "hydrotropic_bud_or_something"
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(100)
            end
            TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
            while GetGameTimer() - beginTime < produceTimes[methRank] do
                Citizen.Wait(0)
                if meth.producingMeth then
                    DrawTimer(beginTime, produceTimes[methRank], 1.42, 1.475, 'COOKING')
                    if not IsEntityPlayingAnim(GetPlayerPed(-1), animDict, animName, 3) then
                        TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                    end
                else
                    print("player stopped gathering! breaking from for loop!")
                    break
                end
            end
            local randomNum = math.random()
            if randomNum <= blowChances[methRank] then
                AddExplosion(GetEntityCoords(PlayerPedId()), 9, 1.0, true, false, 1.0)
                meth.producingMeth = false
                ClearPedTasksImmediately(GetPlayerPed(-1))
                StopAnimTask(PlayerPedId(), animDict,animName, false)
                local coords = GetEntityCoords(PlayerPedId())
                local lastStreetHASH = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
                local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
                TriggerServerEvent('911:MethExplosion', coords.x, coords.y, coords.z, lastStreetNAME)
            else
                ClearPedTasksImmediately(GetPlayerPed(-1))
                StopAnimTask(GetPlayerPed(-1), animDict,animName, false)
                local methProduced = "Meth Rock"
                if meth.producingMeth then
                    meth.producingMeth = false
                    for i = 1, #meth.methIngredients do
                        if meth.methIngredients[i] == 'Red Phosphorus' then
                            methProduced = "Blue Meth Rock"
                        end
                    end
                    meth.methIngredients = {}
                    while securityToken == nil do
                        Wait(1)
                    end
                    TriggerServerEvent("methJob:methProduced", methProduced, securityToken)
                end
            end
        elseif meth.processingMeth then
            beginTime = GetGameTimer()
            animDict = "timetable@jimmy@ig_1@idle_a"
            animName = "hydrotropic_bud_or_something"
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(100)
            end
            TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
            local failed = false
            while GetGameTimer() - beginTime < packageTimes[methRank] do
                Citizen.Wait(0)
                DrawTimer(beginTime, packageTimes[methRank], 1.42, 1.475, 'PACKAGING')
                if meth.processingMeth then
                    if not IsEntityPlayingAnim(GetPlayerPed(-1), animDict, animName, 3) then
                        TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8, -1, 49 , 0, 0, 0, 0)
                    end
                else
                    -- something happened while processing the meth to fail it (like going too far)
                    failed = true
                    break
                end
            end
            ClearPedTasksImmediately(GetPlayerPed(-1))
            StopAnimTask(GetPlayerPed(-1), animDict, animName, false)
            local processedMeth = 'Packaged Meth'
            if meth.methToProcess == 'Blue Meth Rock' then
                processedMeth = 'Packaged Blue Meth'
                meth.methToProcess = nil
            end
            meth.processingMeth = false
            if not failed then
                while securityToken == nil do
                    Wait(1)
                end
                TriggerServerEvent("methJob:methProcessed", processedMeth, securityToken)
            end
        end
    Citizen.Wait(0)
    end
end)

function DrawText3D(x, y, z, distance, text)
    if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) < distance then
        local onScreen,_x,_y=World3dToScreen2d(x,y,z)
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 470
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
