--
-- MADE BY DISTRITIC / minipunch
-- A player will get close to a designated blip on the map within this script, press "E", and begin gathering.
-- This same concept within the script will handle all aspects of a job from getting supplies, processing, to selling, etc.
--

--[[TriggerEvent('cocaineJob:setDelivery') DEBUGGING

 local cocaineProduced = {
    name = cocaine.cocaineProduct,
    type = "drug",
    legality = "illegal",
    quantity = 1,
    weight = 6
  }
TriggerServerEvent("cocaineJob:giveItem", cocaineProduced)]]

local COORDS = {
    PROCESSING = {
        { X = 1954.3068847656, Y = 5179.9643554688, Z = 47.858142852783 },
        { X = 1332.2707519531, Y = -1647.9100341797, Z = 44.252521514893 }
    }
}

local SUPPLY_PICKUP_COORDS = vector3(2832.9826660156, 4571.947265625, 46.952602386475)

local COKE_SUPPLY_WAIT_TIME = 45000
local COCAINE_PROCESS_WAIT_TIME = 55000

local UNCUT_PRICE = 200

local INPUT_KEY = 38 -- E

local cocaine = {
    peds = {
        {x = 2832.9826660156, y = 4571.947265625, z = 46.952602386475, heading = 189.7925567627, name = 'coke_supplies_ped', model = "IG_LESTERCREST"}
    },
    requiredItem = "Razor Blade",
    requiredSupplies = 'Uncut Cocaine',
    pedIsBusy = false,
    processingCocaine = false,
    activeJob = false,
    blip = nil,
    deliveryIndex = nil,
    buyerHandle = nil
}

local peds = {}
local deliveryCoords = {
    {x = 387.1991, y = 0.4811, z = 90.414, heading = 35.64, model = 'IG_JIMMYBOSTON', message = 'Alright, cheers pal. Here\'s the money.'},
    {x = -386.68, y = 504.38, z = 119.41, heading = 320.0, model = 'IG_BANKMAN', message = 'Woah, Ricky G. gonna have a good time today!'},
    {x = -80.573, y = 906.252, z = 234.72, heading = 145.0, model = 'IG_NATALIA', message = 'Heck yeah! Just don\'t tell my dad. Have this.'},
    {x = -1570.94, y = 250.01, z = 58.01, heading = 331.0, model = 'IG_NIGEL', message = 'Thanks, better get back to teaching these idiots!'},
    {x = -1595.512, y = 168.4717, z = 58.18, heading = 172.0, model = 'U_M_M_ALDINAPOLI', message = 'Ohh, I\'m gonna get so fucking tight. Cheers dawg.'},
    {x = 221.94, y = 674.11, z = 188.25, heading = 60.0, model = 'U_M_M_BANKMAN', message = 'You sir, are a very reckless delinquent. There you go.'},
    {x = -3053.79, y = 434.44, z = 5.33, heading = 227.0, model = 'A_M_Y_SURFER_01', message = 'Dawwwg. That\'s fucking pure. Thanks dude!'},
    {x = -1466.96, y = -130.17, z = 49.78, heading = 330.61, model = 'G_M_M_CHILBOSS_01', message = 'Yahhh. Good, good. Your award...'},
    {x = -1544.18, y = -30.78, z = 56.86, heading = 288.20, model = 'IG_MANUEL', message = 'Cabron, you smell of pig. Take this and leave.'},
    {x = -954.35, y = 177.32, z = 64.36, heading = 178.93, model = 'S_M_O_BUSKER_01', message = 'Shiiieeet playa. Skedaddle away now.'},
    {x = -937.052, y = 784.54, z = 180.76, heading = 7.2, model = 'IG_PRIEST', message = 'Praise the lord! You shall be cleansed of sin, have this young fellow.'},
    {x = 328.92, y = 473.36, z = 149.55, heading = 297.76, model = 'U_M_Y_IMPORAGE', message = 'Justice for all, Impotent Kubane will save our souls!'},
    {x = -1955.508, y = 352.66, z = 89.95, heading = 108.0, model = 'U_M_Y_ANTONB', message = 'Looking good. Standards high as always. Here you go.'},
    {x = -1360.05, y = 581.48, z = 130.41, heading = 209.0, model = 'U_M_M_RIVALPAP', message = 'Took you long enough. I\'m late for work, just leave.'},
    {x = 390.18, y = -1886.33, z = 24.47, heading = 223.0, model = 'G_M_M_ARMGOON_01', message = 'This the hood, be careful out there homie. Peace.'},
    {x = 538.78, y = -1785.06, z = 27.81, heading = 90.0, model = 'CSB_BALLASOG', message = 'You askin\' for trouble round here. Here\'s all you\'ll get.'},
    {x = 334.22, y = -2023.53, z = 20.72, heading = 139.75, model = 'G_F_Y_VAGOS_01', message = 'Si, si. Very nice, I see you later.'},
    {x = -1105.17, y = -1173.85, z = 1.14, heading = 130.0, model = 'CSB_HUGH', message = 'Wife just divorced and I need to relax. You\'re a life saver.'},
    {x = -915.007, y = -959.50, z = 1.15, heading = 297.0, model = 'CSB_IMRAN', message = 'Thank you!'},
    {x = -928.67, y = -1078.06, z = 1.15, heading = 12.0, model = 'A_M_Y_VINEWOOD_01', message = 'Thanks!'},
    {x = -174.06, y = 215.0, z = 88.08, heading = 155.0, model = 'A_M_Y_STBLA_02', message = 'Appreciated homie!'},
    {x = -1803.34, y = 402.01, z = 111.82, heading = 226.0, model = 'A_M_Y_BUSINESS_03', message = 'Pleasure doing business. Stay out of trouble!'},
    {x = -135.77, y = 597.91, z = 203.94, heading = 334.0, model = 'A_M_Y_BEVHILLS_01', message = 'Thanks!'},
    {x = 1550.29, y = 2199.79, z = 77.78, heading = 40.0, model = 'IG_OLD_MAN2', message = 'Thank you!'},
    {x = -1798.47, y = -683.87, z = 9.46, heading = 144.0, model = 'CSB_ROCCOPELOSI', message = 'If you need red phosphorus, there\'s a place off-road East Joshua in Sandy.'},
    {x = -1982.99, y = -526.67, z = 10.84, heading = 147.0, model = 'A_F_M_BEACH_01', message = 'Ohhh my goddddd. Why did it take so long asshole?!'},
    {x = -599.44, y = 399.96, z = 100.68, heading = 51.7, model = 'A_F_M_BODYBUILD_01', message = 'Privyet! Ahh yes, these are my steroids. Here wise man, have this.'},
    {x = -917.29, y = 374.57, z = 78.66, heading = 285.13, model = 'A_M_M_BEVHILLS_02', message = 'Be careful, Mr. Crews might be lurking around here somewhere...'},
    {x = -1704.36, y = -440.94, z = 40.67, heading = 272.0, model = 'A_M_M_HASJEW_01', message = 'These damn cops, feels like we\'re in Nazi Germany. Get outta here quick.'},
    --{x = -1129.23, y = 1605.27, z = 3.39, heading = 216.0, model = 'CSB_CAR3GUY2', message = 'Ya yeet! That\'s lit my man! You ever thought about vaping my bro?'},
    {x = 50.57, y = -108.04, z = 55.01, heading = 336.0, model = 'CSB_JANITOR', message = 'Call an ambulance if I don\'t make it after this HIIIGHHH!'},
    {x = -59.04, y = -921.85, z = 28.32, heading = 140.0, model = 'G_M_Y_POLOGOON_01', message = 'Ever thought about running? You need to lose some weight.'},
    {x = -664.11, y = -1217.79, z = 10.81, heading = 30.0, model = 'CSB_BRIDE', message = "Don't ask, thanks!"},
    {x = 793.64, y = -905.96, z = 24.22, heading = 90.0, model = 'CSB_PORNDUDES', message = 'Ever thought about getting a real job? I\'m addicted cause of YOU!'},
    {x = 892.85, y = -540.72, z = 57.50, heading = 90.0, model = 'IG_CHENGSR', message = 'I\'m a mess, have the damn money.'},
    {x = 1011.23, y = -567.26, z = 59.19, heading = 300.0, model = 'IG_MAGENTA', message = 'I appreciate it, here\'s what you deserve.'},
    {x = 26.40, y = -1409.84, z = 28.33, heading = 185.0, model = 'S_M_Y_WINCLEAN_01', message ='I should probably stop taking this, it\'s eating a hole in my pocket.'},
    {x = -262.33, y = -1413.34, z = 30.22, heading = 140.0, model = 'S_M_Y_XMECH_02', message = 'Heard of that annoying cop? Len-, Lennos? I think...'},
    {x = 485.89, y = -1477.54, z = 28.28, heading = 180.0, model = 'U_M_Y_SBIKE', message = 'Dope, just make sure not to get caught. It\'s tough out there.'},
    {x = 602.56, y = 142.05, z = 97.04, heading = 60.0, model = 'U_M_Y_MILITARYBUM', message = 'Living on these streets ain\'t nothin\' easy. This is all I got.'},
    {x = -583.88, y = 195.30, z = 70.44, heading = 100.0, model = 'U_M_Y_PAPARAZZI', message = "Have you seen that new biker mag? It's dope bruhhh!"}
}

RegisterNetEvent('character:setCharacter')
AddEventHandler('character:setCharacter', function()
    RemoveBlip(cocaine.blip)
    SetEntityAsNoLongerNeeded(cocaine.buyerHandle)
    cocaine.deliveryIndex = nil
    cocaine.buyerHandle = nil
    cocaine.blip = nil
    cocaine.activeJob = false
    for i = 1, #peds do
        if peds[i].name == 'delivery_ped' then
            SetEntityAsNoLongerNeeded(peds[i].handle)
            table.remove(peds, i)
        end
    end
end)

function IsNearAnyCokeProcessingSpot(coords, range)
    for i = 1, #COORDS.PROCESSING do
        if GetDistanceBetweenCoords(coords, COORDS.PROCESSING[i].X, COORDS.PROCESSING[i].Y, COORDS.PROCESSING[i].Z, true) < (range or 3) then
            return true
        end
    end
    return false
end

-- JOB HANDLING
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        DrawText3D(1088.18, -3187.18, -38.85, 5, '[E] - Exit')
        DrawText3D(1181.63, -3113.83, 6.03, 3, '[E] - Enter')
        DrawText3D(2832.9826660156, 4571.947265625, 46.952602386475, 5, '[E] - Buy Uncut Cocaine (~g~$' .. UNCUT_PRICE .. '.00~w~)')
        for i = 1, #COORDS.PROCESSING do
            DrawText3D(COORDS.PROCESSING[i].X, COORDS.PROCESSING[i].Y, COORDS.PROCESSING[i].Z, 5, '[E] - Process Cocaine')
        end
        if IsControlJustPressed(0, INPUT_KEY) then
            if GetDistanceBetweenCoords(playerCoords, 1181.63, -3113.83, 6.03, true) < 0.7 then -- enter coke location
                DoorTransition(playerPed, 1088.68, -3187.58, -38.99, 180.0)
            elseif GetDistanceBetweenCoords(playerCoords, 1088.68, -3187.58, -38.99, true) < 0.7 then -- leave coke location
                DoorTransition(playerPed, 1181.63, -3113.83, 6.03, 89.15)
            elseif GetDistanceBetweenCoords(playerCoords, 2832.9826660156, 4571.947265625, 46.952602386475, true) < 2 and not cocaine.pedIsBusy then -- purchase supplies  
                if not cocaine.activeJob then
                    TriggerServerEvent("cocaineJob:checkUserMoney", cocaine.requiredSupplies)
                    Wait(500)
                else
                    TriggerEvent('usa:notify', 'Process and deliver the current batch first!')
                end
            elseif IsNearAnyCokeProcessingSpot(playerCoords) and not cocaine.processingCocaine then -- process/package cocaine rocks
                TriggerServerEvent("cocaineJob:checkUserJobSupplies", cocaine.requiredItem, cocaine.requiredSupplies)
            end
        end
        if cocaine.processingCocaine and not IsNearAnyCokeProcessingSpot(playerCoords, 6) then -- too far from being able to process
            TriggerEvent("usa:notify", "You went ~y~out of range~w~.")
            while securityToken == nil do
                Wait(1)
            end
            TriggerServerEvent("cocaineJob:giveUncut", securityToken)
            cocaine.processingCocaine = false
        elseif cocaine.activeJob then
            local location = deliveryCoords[cocaine.deliveryIndex]
            if location then
                local distToLocation = GetDistanceBetweenCoords(playerCoords, location.x, location.y, location.z, true)
                if distToLocation < 10.0 then
                    DrawText3D(location.x, location.y, location.z + 0.5, 10, 'Press [E] to sell packaged cocaine')
                    if distToLocation < 2.0 then
                        if IsControlJustPressed(0, INPUT_KEY) then
                            TriggerServerEvent('cocaineJob:doesUserHaveProductToSell')
                        end
                    end
                end
            end
        end
    end
end)

-- thread code stuff below was taken from an example on the wiki
-- Create a thread so that we don't 'wait' the entire game
Citizen.CreateThread(function()
    -- Spawn the peds
    for j = 1, #cocaine.peds do
        local hash = GetHashKey(cocaine.peds[j].model)
        -- Request the model so that it can be spawned
        RequestModel(hash)
        -- Check if it's loaded, if not then wait and re-request it.
        while not HasModelLoaded(hash) do
	        Citizen.Wait(100)
        end
         -- Model loaded, continue
        local x = cocaine.peds[j].x
        local y = cocaine.peds[j].y
        local z = cocaine.peds[j].z

        --Citizen.Trace("spawned in ped # " .. i)
        local ped = CreatePed(4, hash, x, y, z, 175.189 --[[Heading]], false --[[Networked, set to false if you just want to be visible by the one that spawned it]], false --[[Dynamic]])
        SetEntityCanBeDamaged(ped,false)
        SetPedCanRagdollFromPlayerImpact(ped,false)
        TaskSetBlockingOfNonTemporaryEvents(ped,true)
        SetPedFleeAttributes(ped,0,0)
        SetPedCombatAttributes(ped,17,1)
        -- add to peds collection
        table.insert(peds, {name = cocaine.peds[j].name, handle = ped})
    end
end)

RegisterNetEvent("cocaineJob:returnPedToStartPosition")
AddEventHandler("cocaineJob:returnPedToStartPosition", function(pedType)
    for i =1, #peds do
        if pedType == peds[i].name then
            TaskGoStraightToCoord(peds[i].handle, cocaine.peds[i].x, cocaine.peds[i].y, cocaine.peds[i].z, 2, -1)
            SetBlockingOfNonTemporaryEvents(peds[i].handle, false)
            cocaine.pedIsBusy = false
        end
    end
end)

RegisterNetEvent('cocaineJob:doesUserHaveProductToSell')
AddEventHandler('cocaineJob:doesUserHaveProductToSell', function(hasProduct) -- action of selling to the ped spawned
    if hasProduct then
        local beginTime = GetGameTimer()
        local playerPed = PlayerPedId()
        cocaine.activeJob = false
        Citizen.CreateThread(function()
            while GetGameTimer() - beginTime < 5000 do
                Citizen.Wait(0)
                DrawTimer(beginTime, 5000, 1.42, 1.475, 'SELLING')
                DisableControlAction(0, 244, true) -- 244 = M key (interaction menu / inventory)
                DisableControlAction(0, INPUT_KEY, true) -- prevent spam clicking
            end
        end)
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
        local cokeBag = CreateObject(GetHashKey('prop_coke_block_01'), 0.0, 0.0, 0.0, true, false, true)
        AttachEntityToEntity(cokeBag, playerPed, GetPedBoneIndex(playerPed, 57005), 0.0, 0.0, -0.1, 0, 90.0, 60.0, true, true, false, true, 1, true)
        ClearPedTasksImmediately(cocaine.buyerHandle)
        TaskPlayAnim(playerPed,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
        Wait(4000)
        StopAnimTask(playerPed, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
        DeleteEntity(cokeBag)
        Citizen.Wait(1000)
        local location = deliveryCoords[cocaine.deliveryIndex]
        TriggerEvent('usa:notify', location.message)
        RemoveBlip(cocaine.blip)
        TriggerServerEvent('cocaineJob:completeDelivery')
        SetEntityAsNoLongerNeeded(cocaine.buyerHandle)
        for i = 1, #peds do
            if peds[i].name == 'delivery_ped' then
                SetEntityAsNoLongerNeeded(peds[i].handle)
                table.remove(peds, i)
            end
        end
    else
        TriggerEvent('usa:notify', 'You do not have any ~y~Packaged Cocaine~s~!')
    end
end)

RegisterNetEvent("cocaineJob:setDelivery") --begins the delivery job, however the player must process the cocaine first still
AddEventHandler("cocaineJob:setDelivery", function()
    if not cocaine.activeJob then
        cocaine.activeJob = true
        local time = GetGameTimer()
        local index = math.random(1, tonumber(#deliveryCoords))
        local location = deliveryCoords[index]
        cocaine.deliveryIndex = index
        cocaine.blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(cocaine.blip, 51)
        SetBlipDisplay(cocaine.blip, 4)
        SetBlipScale(cocaine.blip, 0.8)
        SetBlipColour(cocaine.blip, 1)
        SetBlipAsShortRange(cocaine.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Cocaine Delivery')
        EndTextCommandSetBlipName(cocaine.blip)
        local hash = GetHashKey(location.model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(100)
        end
        local ped = CreatePed(4, hash, location.x, location.y, location.z, location.heading, true, false)
        cocaine.buyerHandle = ped
        SetEntityCanBeDamaged(ped,false)
        SetPedCanRagdollFromPlayerImpact(ped,false)
        TaskSetBlockingOfNonTemporaryEvents(ped,true)
        SetPedFleeAttributes(ped,0,0)
        SetPedCombatAttributes(ped,17,1)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true);
        -- add to peds collection
        table.insert(peds, {name = 'delivery_ped', handle = ped})
        if math.random() > 0.95 then
            local lastStreetHASH = GetStreetNameAtCoord(location.x, location.y, location.z)
            local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
            local isMale = true
            local playerPed = PlayerPedId()
            if GetEntityModel(playerPed) == GetHashKey("mp_f_freemode_01") then
              isMale = false
            elseif GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01") then 
              isMale = true
            else
              isMale = IsPedMale(playerPed)
            end
            TriggerServerEvent('911:CocaineSting', location.x, location.y, location.z, lastStreetNAME, isMale)
        end
    end
end)

RegisterNetEvent("cocaineJob:doesUserHaveJobSupply")
AddEventHandler("cocaineJob:doesUserHaveJobSupply", function(hasJobItem, hasJobSupply)
    --print(hasJobItem, hasJobSupply)
    if hasJobSupply and hasJobItem then
        cocaine.processingCocaine = true
    else
        if hasJobSupply then
            TriggerEvent('usa:notify', 'You do not have a ~y~Razor Blade~s~!')
        elseif hasJobItem then
            TriggerEvent('usa:notify', 'You do not have any ~y~Uncut Cocaine~s~!')
        else
            TriggerEvent('usa:notify', 'You do not have any ~y~Uncut Cocaine~s~ or a ~y~Razor Blade~s~!')
        end
    end
end)

RegisterNetEvent("cocaineJob:getSupplies")
AddEventHandler("cocaineJob:getSupplies", function(supplyType)
    for i = 1, #peds do
        if peds[i].name == "coke_supplies_ped" then
            cocaine.pedIsBusy = true
            TaskGoStraightToCoord(peds[i].handle, 2840.2087402344, 4571.0146484375, 46.701831817627, 2, -1, 294.20455932617)
            SetBlockingOfNonTemporaryEvents(peds[i].handle, false)
            local beginTime = GetGameTimer()
            local sounds = {
              {sound = "Shout_Threaten_Ped", param = "Speech_Params_Force_Shouted_Critical"},
              {sound = "Shout_Threaten_Gang", param = "Speech_Params_Force_Shouted_Critical"},
              {sound = "Generic_Hi", param = "Speech_Params_Force"}
            }
            local random_sound = sounds[math.random(1, tonumber(#sounds))]
            PlayAmbientSpeech1(peds[i].handle, random_sound.sound, random_sound.param)
            
            local isCancelled = false

            while GetGameTimer() - beginTime < COKE_SUPPLY_WAIT_TIME do
                Citizen.Wait(0)
                DrawTimer(beginTime, COKE_SUPPLY_WAIT_TIME, 1.42, 1.475, 'WAITING')
                local playerPedCoords = GetEntityCoords(PlayerPedId(), false)
                if Vdist(SUPPLY_PICKUP_COORDS, playerPedCoords) >= 10.0 then
                    isCancelled = true
                    break
                end
            end

            if not isCancelled then
                local messages = {
                    "Hurdle on friend, just wait up here...",
                    "In the market for this junk? Interesting, wait here.",
                    "Lester, the molester. Be right back.",
                    "This'll kill you before your genes do, but I don't judge. Be right back.",
                    "Perfect, we're on our heads. Just wait here."
                }
                exports.globals:notify(messages[math.random(1, tonumber(#messages))], "^3Lester:^0 Alright, let me know if you need more. Go and cut this first at that barn in the Northern part of Grapeseed (make sure you have a Razor Blade) and then look for the red pill on your map to deliver the final product.")
                while securityToken == nil do
                    Wait(1)
                end
                TriggerServerEvent("cocaineJob:giveUncut", securityToken)
                TriggerEvent('cocaineJob:setDelivery')
            else
                exports.globals:notify("You went too far")
            end

            TriggerEvent("cocaineJob:returnPedToStartPosition", "coke_supplies_ped")
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        if cocaine.processingCocaine then
            local beginTime = GetGameTimer()
            local animDict = "timetable@jimmy@ig_1@idle_a"
            local animName = "hydrotropic_bud_or_something"
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(100)
            end
            TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
            while GetGameTimer() - beginTime < COCAINE_PROCESS_WAIT_TIME and IsNearAnyCokeProcessingSpot(GetEntityCoords(PlayerPedId()), 6) do
                Citizen.Wait(0)
                if cocaine.processingCocaine then
                    DrawTimer(beginTime, COCAINE_PROCESS_WAIT_TIME, 1.42, 1.475, 'PROCESSING')
                    if not IsEntityPlayingAnim(GetPlayerPed(-1), animDict, animName, 3) then
                        TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                    end
                    DisableControlAction(0, 244, true) -- 244 = M key (interaction menu / inventory)
                else
                    break
                end
            end
            ClearPedTasksImmediately(GetPlayerPed(-1))
            StopAnimTask(GetPlayerPed(-1), animDict,animName, false)
            if cocaine.processingCocaine then
                cocaine.processingCocaine = false
                cocaine.activeJob = true
                while securityToken == nil do
                    Wait(1)
                end
                TriggerServerEvent("cocaineJob:givePackaged", securityToken)
                TriggerServerEvent('cocaineJob:residueRazor')
                exports.globals:notify("Now take this to get delivered! Check your map for the red pill.")
            end
        end
    Citizen.Wait(0)
    end
end)

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

RegisterNetEvent('cocaine:validateDelivery')
AddEventHandler('cocaine:validateDelivery', function()
    if cocaine.deliveryIndex then
        local me = PlayerPedId()
        local mycoords = GetEntityCoords(me)
        local location = deliveryCoords[cocaine.deliveryIndex]
        local dist = Vdist(mycoords.x, mycoords.y, mycoords.z, location.x, location.y, location.z)
        if dist < 40 then
            TriggerServerEvent("cocaine:locationValidated")
        end
    end
end)

RegisterNetEvent('cocaine:exploitDetected')
AddEventHandler('cocaine:exploitDetected', function() -- give cocaine
    TriggerServerEvent("cocaine:exploitDetected")
end)

function DoorTransition(playerPed, x, y, z, heading)
  PlayDoorAnimation()
  DoScreenFadeOut(500)
  Wait(500)
  RequestCollisionAtCoord(x, y, z)
  SetEntityCoordsNoOffset(playerPed, x, y, z, false, false, false, true)
  SetEntityHeading(playerPed, heading)
  while not HasCollisionLoadedAroundEntity(playerPed) do
      Wait(100)
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

function ShowHelp(text, bleep)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, bleep, -1)
end
