effects = {} -- when you take damage for a specific reason, you may be put into an effect
injuredParts = {} -- injured body parts, and their wounds as the value

local InjuriesC = Config.Injuries

------ NOTIFY PLAYER OF INJURIES ------

RegisterNetEvent('injuries:showMyInjuries')
AddEventHandler('injuries:showMyInjuries', function()
    local hadInjury = false
    for bone, InjuriesC in pairs(injuredParts) do
        local boneName = Config.Body_Parts[bone]
        for injury, data in pairs(injuredParts[bone]) do
            local stage = injuredParts[bone][injury].stage
            local cause = injuredParts[bone][injury].string
            exports.globals:notify("Your " .. boneName .. " has a stage " .. stage .. " injury from a " .. cause .. ".")
            hadInjury = true
        end
    end
    if not hadInjury then 
        exports.globals:notify("You have no injuries.")
    end
end)

local isEpi = false
local epiTimer = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isEpi == true then
            local beginTime = GetGameTimer()
            while GetGameTimer() - beginTime < epiTimer * 1000 do
                -- print((GetGameTimer() - beginTime))
                Citizen.Wait(0)
            end
            if IsEntityDead(PlayerPedId()) then
                TriggerEvent('usa:notify', 'The effect of the epinephrine has worn off you fall back unconscious')
            end
            TriggerEvent("usa_death:epi", false)
            isEpi = false
            epiTimer = nil
        end
    end
end)

RegisterNetEvent("usa_injury:epi")
AddEventHandler("usa_injury:epi", function(bool)
    if bool then
        if IsEntityDead(PlayerPedId()) then
            TriggerEvent('usa:notify', 'You have been injected with epinephrine, you are temporarily conscious and can talk')
            TriggerEvent("usa_death:epi", true)
            isEpi = true
            epiTimer = 300 -- Five Minutes
        end
    else
        TriggerEvent("usa_death:epi", false)
        isEpi = false
        epiTimer = 0
    end
end)

function isConscious()
    if IsEntityDead(PlayerPedId()) and not isEpi then
        local seriousInjuries = 0
        for bone, InjuriesC in pairs(injuredParts) do
            local boneName = Config.Body_Parts[bone]
            for injury, data in pairs(injuredParts[bone]) do
                local injuryType = injuredParts[bone][injury].type
                local cause = injuredParts[bone][injury].string
                if injuryType == 'penetrating' or injuryType == 'laceration' or injuryType == 'burn' then
                    if boneName == 'Head' or cause == "Explosion" then
                        seriousInjuries = seriousInjuries + 3
                    else
                        seriousInjuries = seriousInjuries + 1
                    end
                end
            end
        end
        if seriousInjuries >= 3 then
            return false
        else
            return true
        end
    else
        return true
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(120000)
        NotifyPlayerOfInjuries()
    end
end)

------ DEVELOP INJURY SEVERITY & ADD EFFECTS ------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerPed = PlayerPedId()
        for bone, InjuriesC in pairs(injuredParts) do
            for injury, data in pairs(injuredParts[bone]) do
                if data.bandagedTime <= 0 then -- wounds are not bandaged for five mins, or five mins has passed since
                    if not injuredParts[bone][injury].timer then -- start a timer of bleeding if doesn't already exist
                        injuredParts[bone][injury].timer = data.bleed
                    end
                    if injuredParts[bone][injury].timer > 0 then
                        UpdateEffects(injuredParts[bone][injury].stage, bone)
                        injuredParts[bone][injury].timer = injuredParts[bone][injury].timer - 1 -- continue decrementing timer every second
                        local secondsPerStage = math.ceil(data.bleed / 3) -- 3 stages, defines how many seconds there is per stage
                        local secondsBeforeNextStage = data.bleed - (secondsPerStage * injuredParts[bone][injury].stage)
                        if injuredParts[bone][injury].timer == secondsBeforeNextStage and injuredParts[bone][injury].stage < 3 then
                            injuredParts[bone][injury].stage = injuredParts[bone][injury].stage + 1
                            NotifyPlayerOfInjuries()
                        end
                    elseif not IsEntityDead(playerPed) then
                        if not GetScreenEffectIsActive('Rampage') then
                            StartScreenEffect('Rampage', 0, true)
                            exports.globals:Draw3DTextForOthers("is losing a severe amount of blood")
                        end
                        if math.random() > 0.6 then
                            ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.1)
                        end
                        TriggerEvent('usa:notify', 'Your body feels cold with blood...')
                        local playerHealth = GetEntityHealth(playerPed)
                        SetEntityHealth(playerPed, ((playerHealth) - 3))
                        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
                    elseif IsEntityDead(playerPed) then
                        StopScreenEffect('Rampage')
                    end
                end
            end
        end
    end
end)

------ PLAYER EFFECTS ------
Citizen.CreateThread(function()
    local injuredWalk = false
    while true do
        Citizen.Wait(10)
        for effect, enabled in pairs(effects) do
            if effect == 'shake' then
                if math.random() > 0.999 and not IsEntityDead(PlayerPedId()) then
                    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.1)
                end
            elseif effect == 'noaim' then
                DisableControlAction(0, 25, true)
            elseif effect == 'injuredwalk' then
                TriggerEvent('civ:forceWalkStyle', "move_injured_generic")
                DisableControlAction(0, 21, true)
                DisableControlAction(0, 22, true)
            end
        end
    end
end)

------ LISTENING FOR DAMAGE ------

local lastDamage = 0
RegisterNetEvent('DamageEvents:EntityDamaged')
AddEventHandler('DamageEvents:EntityDamaged', function(entity, attacker, weaponHash, isMeleeDamage, boneOverride)
    if GetGameTimer() - lastDamage > 2000 and entity == PlayerPedId() then
        if GetGameTimer() - lastDamage > 8000 then
            if Config.Injuries[weaponHash] then
                if Config.Injuries[weaponHash].dropEvidence then
                    if math.random() < Config.Injuries[weaponHash].dropEvidence then
                        TriggerServerEvent('evidence:newDNA', GetEntityCoords(PlayerPedId()))
                    end
                else
                    TriggerServerEvent('evidence:newDNA', GetEntityCoords(PlayerPedId()))
                end
            end
        end
        lastDamage = GetGameTimer()
        local playerPed = PlayerPedId()
        local _, damagedBone = GetPedLastDamageBone(playerPed)
        if boneOverride then
            damagedBone = boneOverride
        end
        for hash, name in pairs(Config.Body_Parts) do
            if hash == damagedBone then
                ApplyPedBlood(playerPed, GetPedBoneIndex(playerPed, damagedBone), 0.0, 0.0, 0.0, "wound_sheet")
                if type(injuredParts[damagedBone]) ~= 'table' then
                    injuredParts[damagedBone] = {}
                end
                if type(injuredParts[damagedBone][weaponHash]) ~= 'table' then
                    --print(weaponHash .. ' has damaged '.. damagedBone)
					if Config.Injuries[weaponHash] then
						injuredParts[damagedBone][weaponHash] = {
							type = Config.Injuries[weaponHash].type,
							bleed = Config.Injuries[weaponHash].bleed,
							string = Config.Injuries[weaponHash].string,
							treatableWithBandage = Config.Injuries[weaponHash].treatableWithBandage,
							treatmentPrice = Config.Injuries[weaponHash].treatmentPrice,
							stage = 1, -- add the stage to the injury
							bandagedTime = 0 -- add when the injury was last bandaged
						}
						--print('added injuredParts['.. damagedBone..']['..weaponHash..']')
						TriggerServerEvent('injuries:saveData', injuredParts)
						Citizen.Wait(2000)
						NotifyPlayerOfInjuries()
					end
                end
                return
            end
        end
        print('INJURIES: Add me to injury bone list: ' ..damagedBone)
    end
end)

RegisterNetEvent('DamageEvents:PedDied')
AddEventHandler('DamageEvents:PedDied', function(entity, attacker, weaponHash, isMeleeDamage)
    RegisterInjuries(entity, weaponHash)
end)

RegisterNetEvent('DamageEvents:PedKilledByPlayer')
AddEventHandler('DamageEvents:PedKilledByPlayer', function(entity, attacker, weaponHash, isMeleeDamage)
    if entity == PlayerPedId() then
      if Config.Injuries[weaponHash] then
        if Config.Injuries[weaponHash].dropEvidence then
            if Config.Injuries[weaponHash].dropEvidence > 0.0 and entity == PlayerPedId() then
                TriggerServerEvent('evidence:newDNA', GetEntityCoords(PlayerPedId()))
            end
            RegisterInjuries(entity, weaponHash)
        else
            TriggerServerEvent('evidence:newDNA', GetEntityCoords(PlayerPedId()))
        end
      end
    end
end)

RegisterNetEvent('DamageEvents:PedKilledByVehicle')
AddEventHandler('DamageEvents:PedKilledByVehicle', function(entity, attacker, weaponHash, isMeleeDamage)
    RegisterInjuries(entity, weaponHash)
end)

RegisterNetEvent('DamageEvents:PedKilledByPed')
AddEventHandler('DamageEvents:PedKilledByPed', function(entity, attacker, weaponHash, isMeleeDamage)
    RegisterInjuries(entity, weaponHash)
end)

RegisterNetEvent('injuries:triggerGrace')
AddEventHandler('injuries:triggerGrace', function(callback)
    lastDamage = GetGameTimer()
    callback()
end)

function RegisterInjuries(entity, weaponHash)
    if Config.Injuries[weaponHash] then
        if entity == PlayerPedId() then
            local playerPed = PlayerPedId()
            local _, damagedBone = GetPedLastDamageBone(playerPed)
            for hash, name in pairs(Config.Body_Parts) do
                if hash == damagedBone then
                    ApplyPedBlood(playerPed, GetPedBoneIndex(playerPed, damagedBone), 0.0, 0.0, 0.0, "wound_sheet")
                    if type(injuredParts[damagedBone]) ~= 'table' then
                        injuredParts[damagedBone] = {}
                    end
                    if type(injuredParts[damagedBone][weaponHash]) ~= 'table' then
                        --print(weaponHash .. ' has damaged '.. damagedBone)
                        injuredParts[damagedBone][weaponHash] = {
                            type = Config.Injuries[weaponHash].type,
                            bleed = Config.Injuries[weaponHash].bleed,
                            string = Config.Injuries[weaponHash].string,
                            treatableWithBandage = Config.Injuries[weaponHash].treatableWithBandage,
                            treatmentPrice = Config.Injuries[weaponHash].treatmentPrice,
                            stage = 1, -- add the stage to the injury
                            bandagedTime = 0 -- add when the injury was last bandaged
                        }
                        --print('added injuredParts['.. damagedBone..']['..weaponHash..']')
                        TriggerServerEvent('injuries:saveData', injuredParts)
                        Citizen.Wait(2000)
                        NotifyPlayerOfInjuries()
                    end
                    return
                end
            end
            print('INJURIES: Add me to injury bone list: ' ..damagedBone)
        end
    end
end

------ INSPECTING PLAYERS ------

RegisterNetEvent('injuries:inspectNearestPed') -- get the nearest ped to inspect when command is executed
AddEventHandler('injuries:inspectNearestPed', function(playerSource)
    local playerCoords = GetEntityCoords(PlayerPedId())
    for ped in exports.globals:EnumeratePeds() do
        local pedCoords = GetEntityCoords(ped)
        if Vdist(pedCoords, playerCoords) < 3.0 and IsPedAPlayer(ped) and ped ~= PlayerPedId() then
            local pedSource = GetPlayerServerId(GetPlayerFromPed(ped))
            TriggerServerEvent('injuries:getPlayerInjuries', pedSource, playerSource)
            return
        end
    end
    TriggerEvent('usa:notify', 'No player found nearby!')
end)

RegisterNetEvent('injuries:returnInjuries') -- return the patient's injuries to the responder so they can be displayed
AddEventHandler('injuries:returnInjuries', function(sourceReturnedTo)
    local ped = PedToNet(PlayerPedId())
    TriggerServerEvent('injuries:inspectMyInjuries', sourceReturnedTo, injuredParts, ped)
end)

local displayingInjuries = false
RegisterNetEvent('injuries:displayInspectedInjuries') -- display the injuries of ped in front to person who executed command
AddEventHandler('injuries:displayInspectedInjuries', function(injuriesInspected, displayName, ped)
    TriggerEvent('chatMessage', '^6^*[INJURIES]^r^7 Inspection of '..displayName..':')
    local ped = NetToPed(ped)
    for bone, InjuriesC in pairs(injuriesInspected) do
        local boneName = Config.Body_Parts[bone]
        for injury, data in pairs(injuriesInspected[bone]) do
            local injuryType = ''
            local bandaged = 'an open '
            if data.type == 'blunt' then
                injuryType = 'Blunt Force Wound'
            elseif data.type == 'penetrating' then
                injuryType = 'Penetrated Wound'
            elseif data.type == 'burn' then
                injuryType = 'Burn Wound'
            elseif data.type == 'laceration' then
                injuryType = 'Laceration Wound'
            end
            if data.bandagedTime > 0 then
                bandaged = 'a bandaged '
            end
            TriggerEvent('chatMessage', ' ⠀^6^* > ^r^7 '..boneName..' has '..bandaged..''..injuryType..' at stage '.. tostring(data.stage) ..', caused by '..data.string..'.')
        end
    end

    local beginTime = GetGameTimer() -- draw 3d text of patient's injuries on the body
    if not displayingInjuries then
        displayingInjuries = true
        while GetGameTimer() - beginTime < 15000 do
            Citizen.Wait(0)
            for bone, InjuriesC in pairs(injuriesInspected) do
                local boneName = Config.Body_Parts[bone]
                local x, y, z = table.unpack(GetPedBoneCoords(ped, bone, 0.0, 0.0, 0.0))
                if Vdist(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped)) < 3 and not IsPedRagdoll(ped) then
                    DrawText3Ds(x, y, z, boneName)
                end
            end
        end
        displayingInjuries = false
    end
end)

------ TREATING PLAYERS ------

RegisterNetEvent('injuries:treatNearestPed') -- get the nearest ped to treat when command is executed
AddEventHandler('injuries:treatNearestPed', function(boneToTreat)
    local playerCoords = GetEntityCoords(PlayerPedId())
    for ped in exports.globals:EnumeratePeds() do
        local pedCoords = GetEntityCoords(ped)
        if Vdist(pedCoords, playerCoords) < 3.0 and IsPedAPlayer(ped) and ped ~= PlayerPedId() then
            local pedSource = GetPlayerServerId(GetPlayerFromPed(ped))
            TriggerServerEvent('injuries:treatPlayer', pedSource, boneToTreat)
            return
        end
    end
    TriggerEvent('usa:notify', 'No player found nearby!')
end)

RegisterNetEvent('injuries:treatMyInjuries') -- treat the patient's injuries when the command is executed
AddEventHandler('injuries:treatMyInjuries', function(boneToTreat, sourceTreating)
    for bone, InjuriesC in pairs(injuredParts) do
        local boneName = Config.Body_Parts[bone]
        if string.lower(boneName) == string.lower(boneToTreat) then
            effects = {}
            injuredParts[bone] = nil
            StopScreenEffect('Rampage')
            TriggerEvent('usa:notify', Config.Body_Parts[bone]..' has been treated.')
            TriggerServerEvent('injuries:notify', sourceTreating, Config.Body_Parts[bone] .. ' of patient has been treated.')
            TriggerEvent('civ:resetWalkStyle')
            TriggerServerEvent('injuries:saveData', injuredParts)
            return
        end
    end
end)

------ BANDAGING PLAYERS ------

RegisterNetEvent('injuries:bandageNearestPed') -- get the nearest ped to bandage when command is executed
AddEventHandler('injuries:bandageNearestPed', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    for ped in exports.globals:EnumeratePeds() do
        local pedCoords = GetEntityCoords(ped)
        if Vdist(pedCoords, playerCoords) < 3.0 and IsPedAPlayer(ped) and ped ~= PlayerPedId() then
            local pedSource = GetPlayerServerId(GetPlayerFromPed(ped))
            TriggerServerEvent('injuries:bandagePlayer', pedSource)
            TriggerServerEvent('display:shareDisplay', 'bandages person', 2, 370, 10, 3000)
            return
        end
    end
    TriggerEvent('usa:notify', 'No player found nearby!')
end)

RegisterNetEvent('injuries:bandageMyInjuries') -- temporarily stop bleeding & treat some injuries
AddEventHandler('injuries:bandageMyInjuries', function()
    local injuriesBandaged = false
    TriggerEvent('civ:resetWalkStyle')
    for bone, InjuriesC in pairs(injuredParts) do
        for injury, data in pairs(injuredParts[bone]) do
            if data.treatableWithBandage then -- if treatable with bandage, treat injury for each treatable bone
                if table.getIndex(injuredParts[bone]) > 1 then
                    injuredParts[bone][injury] = nil
                else
                    injuredParts[bone] = nil
                end
                effects = {}
                StopScreenEffect('Rampage')
                TriggerEvent('usa:notify', 'Some of your injuries have been treated with a bandage.')
                TriggerServerEvent('injuries:saveData', injuredParts)
            else -- if the wound is not treatable with just a bandage, prevent it from bleeding for a few mins
                injuredParts[bone][injury].bandagedTime = 300
                injuriesBandaged = true
            end
        end
    end
    if injuriesBandaged then
        TriggerEvent('usa:showHelp', true, 'Some of your injuries have been temporarily bandaged.')
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for bone, InjuriesC in pairs(injuredParts) do
            for injury, data in pairs(injuredParts[bone]) do
                if injuredParts[bone][injury].bandagedTime > 0 then
                    if not exports["usa_stretcher"]:IsInStretcher() then
                        injuredParts[bone][injury].bandagedTime = injuredParts[bone][injury].bandagedTime - 1
                    end
                end
            end
        end
    end
end)

------ CHECK-IN HOSPITAL AND DOCTOR JOB ------
Citizen.CreateThread(function()
    local checkingIn = false
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for i = 1, #Config.Hospital_Locations do
            local x, y, z = table.unpack(Config.Hospital_Locations[i])
            if Vdist(playerCoords, x, y, z) < 10 then
                local totalPrice = Config.BASE_CHECKIN_PRICE
                for bone, InjuriesC in pairs(injuredParts) do
                    for injury, data in pairs(injuredParts[bone]) do
                        totalPrice = totalPrice + data.treatmentPrice
                    end
                end
                DrawText3Ds(x, y, z, '[E] - Check In (~g~$'..totalPrice..'~s~)')
                if IsControlJustPressed(0, 38) and Vdist(playerCoords, x, y, z) < 1.5 and not checkingIn then
                    PlayDoorAnimation()
                    checkingIn = true
                    local beginTime = GetGameTimer()
                    while GetGameTimer() - beginTime < 3000 do
                        Citizen.Wait(0)
                        DrawTimer(beginTime, 3000, 1.42, 1.475, 'CHECKING IN')
                    end
                    checkingIn = false
                    playerCoords = GetEntityCoords(playerPed)
                    if Vdist(playerCoords, x, y, z) < 3 then
                        local x, y, z = table.unpack(playerCoords)
                        TriggerServerEvent('injuries:validateCheckin', injuredParts, IsPedDeadOrDying(playerPed), x, y, z, IsPedMale(playerPed))
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('injuries:checkin')
AddEventHandler('injuries:checkin', function()
    local overview = '0. Base Fee: $'..Config.BASE_CHECKIN_PRICE..'\n'
    local payment = Config.BASE_CHECKIN_PRICE
    local log = '\n⠀• Base Fee **-** $50'
    local index = 0
    for bone, _injuries in pairs(injuredParts) do
        for injury, data in pairs(injuredParts[bone]) do
            index = index + 1
            payment = payment + data.treatmentPrice
            overview = overview .. index .. '.  Bone: ' ..Config.Body_Parts[bone] .. ' | Injury: ' .. data.string .. ' | Price: $' .. data.treatmentPrice .. '\n'
            log = log .. '\n⠀• '..Config.Body_Parts[bone]..' **-** '..data.string..' **-** Stage '..data.stage
        end
    end
    TriggerEvent('chatMessage', '', {255, 255, 255}, 'Overview: \n ' .. overview)
    injuredParts = {}
    effects = {}
    StopScreenEffect('Rampage')
    TriggerEvent('death:allowRevive')
    TriggerEvent('civ:resetWalkStyle')
    TriggerEvent('usa:showHelp', true, 'You are currently being treated, please wait.')
    TriggerServerEvent('injuries:saveData', injuredParts)
    TriggerServerEvent('injuries:sendLog', log, payment)
end)

RegisterNetEvent('ems:admitMe')
AddEventHandler('ems:admitMe', function()
    TriggerServerEvent('injuries:chargeForInjuries', injuredParts, 1.0, false)
end)

RegisterNetEvent('death:injuryPayment')
AddEventHandler('death:injuryPayment', function()
    TriggerServerEvent('injuries:chargeForInjuries', injuredParts, 1.5, true)
end)

RegisterNetEvent('injuries:updateInjuries')
AddEventHandler('injuries:updateInjuries', function(_injuries)
    local playerPed = PlayerPedId()
    local __injuries = {}
    for bone, InjuriesC in pairs(_injuries) do
        ApplyPedBlood(playerPed, GetPedBoneIndex(playerPed, bone), 0.0, 0.0, 0.0, "wound_sheet")
        __injuries[tonumber(bone)] = Config.Injuries
    end
    injuredParts = __injuries
    effects = {}
    StopScreenEffect('Rampage')
    SetEntityHealth(PlayerPedId(), 200)
    TriggerEvent('civ:resetWalkStyle')
    NotifyPlayerOfInjuries()
end)

RegisterNetEvent('injuries:removeInjuries')
AddEventHandler('injuries:removeInjuries', function()
  injuredParts = {}
  effects = {}
  StopScreenEffect('Rampage')
  SetEntityHealth(PlayerPedId(), 200)
  TriggerEvent('civ:resetWalkStyle')
end)

RegisterNetEvent('character:setCharacter')
AddEventHandler('character:setCharacter', function()
    TriggerServerEvent('injuries:requestData')
end)

------ UTILITIES ------

function DrawText3Ds(x, y, z, text)
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
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function NotifyPlayerOfInjuries()
    local string = ''
    for bone, InjuriesC in pairs(injuredParts) do
        local boneName = Config.Body_Parts[bone]
        for injury, data in pairs(injuredParts[bone]) do
            string = string .. boneName .. ' '
            if data.type == 'blunt' then
                string = string .. 'is bruised'
            elseif data.type == 'laceration' then
                string = string .. 'is cut'
            elseif data.type == 'penetrating' then
                string = string .. 'is punctured'
            elseif data.type == 'burn' then
                string = string .. 'is burnt'
            end
            if data.bandagedTime > 0 then
                string = string .. ', bandaged.'
            else
                if data.stage == 1 then
                    string = string .. ', bleeding.'
                elseif data.stage == 2 then
                    string = string .. ', bleeding & numb.'
                elseif data.stage == 3 then
                    string = string .. ', rapidly bleeding & numb.'
                end
            end
            TriggerEvent('usa:notify', string)
            string = ''
        end
    end
end

function UpdateEffects(stage, bone)
    for i = 1, #Config.Bone_Effects[bone] do
        if stage >= i then
            local effectToApply = Config.Bone_Effects[bone][i]
            effects[effectToApply] = true
        end
    end
end

function GetPlayerFromPed(ped)
    for a = 0, 255 do
        if GetPlayerPed(a) == ped then
            return a
        end
    end
    return -1
end

function table.getIndex(table)
    local index = 0
    for key, value in pairs(table) do
        index = index + 1
    end
    return index
end

function PlayDoorAnimation()
    while ( not HasAnimDictLoaded( 'anim@mp_player_intmenu@key_fob@' ) ) do
        RequestAnimDict( 'anim@mp_player_intmenu@key_fob@' )
        Citizen.Wait( 0 )
  end
    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, 1.0, -1, 48)
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

function getPlayerInjuries()
    return injuredParts
end