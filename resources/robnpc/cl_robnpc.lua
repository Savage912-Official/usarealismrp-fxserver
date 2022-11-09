local robbing = false
local canceled = false
local takingHostage = false
local hasHostage = false

local KEYS = {
    E = 38,
    G = 47
}

local DISTANCE_FROM_PED = 7 -- 7 pos. from X, Y, or Z
local ROB_TIME = 10000 -- 7s
local HOSTAGE_TIME = 3000
local CALL_DELAY = 7000 -- 7s

local previousPed = nil
local targetPed = nil

local emote = {
    dict = "random@mugging3",
    name = "handsup_standing_base"
}

local hostageTakerTask = {
    animDict = "anim@gangops@hostage@",
    anim = "perp_idle",
    flag = 49,
}

local hostageTask = {
    animDict = "anim@gangops@hostage@",
    anim = "victim_idle",
    attachX = -0.24,
    attachY = 0.11,
    attachZ = 0.0,
    flag = 49,
}

local prohibitedWeapons = {}
prohibitedWeapons[`WEAPON_SNOWBALL`] = true

hostagePed = nil

function ShowHelp(text, bleep)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, bleep, -1)
end

function canRobOtherPed(me, targetPed)
    -- valid other ped? --
    if not DoesEntityExist(targetPed) or not IsEntityAPed(targetPed) or IsPedInAnyVehicle(targetPed, true) or IsPedDeadOrDying(targetPed, true) or IsPedAPlayer(targetPed) then
        return false
    end
    
    -- is player robbing with a valid weapon? --
    local selectedPedWeapon = GetSelectedPedWeapon(me)
    if prohibitedWeapons[selectedPedWeapon] then
        return false
    else 
        return true
    end
end

Citizen.CreateThread(function()
    local player = PlayerId()
    while true do
        ::top::
        if IsControlPressed(0, 25) and not hasHostage then
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(player)
                local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(targetPed))
                if dist < 5.0 and canRobOtherPed(PlayerPedId(), targetPed) and previousPed ~= targetPed then
                    previousPed = targetPed
                    local fleeChance = math.random()
                    if fleeChance <= 0.15 then
                        TaskReactAndFleePed(targetPed, PlayerPedId())
                    else
                        ClearPedTasksImmediately(targetPed)
                        FreezeEntityPosition(targetPed, true)
                        TaskPlayAnim(targetPed, emote.dict, emote.name, -8, 1, -1, 13, 0, 0, 0, 0)
                        while IsPlayerFreeAiming(player) and dist < 5.0 do
                            Wait(0)
                            if not IsEntityPlayingAnim(targetPed, emote.dict, emote.name, 3) then
                                LoadAnimation(emote.dict)
                                TaskPlayAnim(targetPed, emote.dict, emote.name, -8, 1, -1, 13, 0, 0, 0, 0)
                            end
                            ShowHelp("Hold ~INPUT_CONTEXT~ Rob\nHold ~INPUT_DETONATE~ Take Hostage", true)
                            if IsControlJustPressed(0, KEYS.E) then
                                robbing = true
                                local beginTime = GetGameTimer()
                                local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
                                local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
                                local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
                                TriggerServerEvent("911:MuggingNPC", x, y, z, lastStreetNAME)
                                while GetGameTimer() - beginTime < ROB_TIME and not canceled do
                                    exports.globals:DrawTimerBar(beginTime, ROB_TIME, 1.42, 1.475, 'ROBBING')
                                    Wait(0)
                                end
                                robbing = false
                                if canceled then
                                    canceled = false
                                else
                                    while securityToken == nil do
                                        Wait(1)
                                    end
                                    TriggerServerEvent("Mugging:GiveReward", securityToken)
                                end 
                                break
                            elseif IsControlJustPressed(0, KEYS.G) then
                                takingHostage = true
                                local beginTime = GetGameTimer()
                                while GetGameTimer() - beginTime < HOSTAGE_TIME and not canceled do
                                    exports.globals:DrawTimerBar(beginTime, HOSTAGE_TIME, 1.42, 1.475, 'TAKING HOSTAGE')
                                    Wait(0)
                                end
                                takingHostage = false
                                if canceled then
                                    canceled = false
                                else
                                    -- while securityToken == nil do
                                    --     Wait(1)
                                    -- end
                                    hostagePed = targetPed
                                    LoadAnimation(hostageTask.animDict)
                                    LoadAnimation(hostageTakerTask.animDict)
                                    FreezeEntityPosition(hostagePed, false)
                                    StopAnimTask(hostagePed, emote.dict, emote.name, 1.0)
                                    TaskSetBlockingOfNonTemporaryEvents(hostagePed, true)
                                    ClearPedTasksImmediately(hostagePed)
                                    AttachEntityToEntity(hostagePed, PlayerPedId(), 0, hostageTask.attachX, hostageTask.attachY, hostageTask.attachZ, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
                                    TaskPlayAnim(PlayerPedId(), hostageTakerTask.animDict, hostageTakerTask.anim, 8.0, -8.0, 100000, hostageTakerTask.flag, 0, false, false, false)
                                    TaskPlayAnim(hostagePed, hostageTask.animDict, hostageTask.anim, 8.0, -8.0, 100000, hostageTask.flag, 0, false, false, false)
                                    hasHostage = true
                                    while hasHostage do
                                        Wait(1)
                                        if IsPedDeadOrDying(PlayerPedId(), 1) then
                                            DetachEntity(hostagePed, true, false)
                                            hasHostage = false
                                            hostagePed = nil
                                            TriggerEvent("hotkeys:enable", true)
                                        end
                                        if not IsEntityPlayingAnim(PlayerPedId(), hostageTakerTask.animDict, hostageTakerTask.anim, 3) then
                                            TaskPlayAnim(PlayerPedId(), hostageTakerTask.animDict, hostageTakerTask.anim, 8.0, -8.0, 100000, hostageTakerTask.flag, 0, false, false, false)
                                        end
                                        if not IsEntityPlayingAnim(hostagePed, hostageTask.animDict, hostageTask.anim, 3) then
                                            TaskPlayAnim(hostagePed, hostageTask.animDict, hostageTask.anim, 8.0, -8.0, 100000, hostageTask.flag, 0, false, false, false)
                                        end
                                        DisableControlAction(0,24,true) -- disable attack
                                        DisableControlAction(0,25,true) -- disable aim
                                        DisableControlAction(0,47,true) -- disable weapon
                                        DisableControlAction(0,58,true) -- disable weapon
                                        DisableControlAction(0,21,true) -- disable sprint
                                        DisableControlAction(0,23,true) -- disable vehicle enter
                                        TriggerEvent("hotkeys:enable", false)
                                        DisablePlayerFiring(PlayerPedId(),true)
                                        ShowHelp("Press ~INPUT_CONTEXT~ to Release\nPress ~INPUT_ATTACK~ to Kill", true)
                                        if IsControlJustPressed(0, KEYS.E) then
                                            LoadAnimation("reaction@shove")
                                            DetachEntity(hostagePed, true, false)
                                            TaskPlayAnim(PlayerPedId(), "reaction@shove", "shove_var_a", 8.0, -8.0, -1, 168, 0, false, false, false)
                                            TaskPlayAnim(hostagePed, "reaction@shove", "shoved_back", 8.0, -8.0, -1, 0, 0, false, false, false)
                                            Wait(1000)
                                            hasHostage = false
                                            hostagePed = nil
                                            TriggerEvent("hotkeys:enable", true)
                                        elseif IsDisabledControlJustPressed(0, 24) then
                                            local ammo = GetAmmoInPedWeapon(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()))
                                            if ammo > 0 then
                                                DetachEntity(hostagePed, true, false)
                                                FreezeEntityPosition(hostagePed, true)
                                                LoadAnimation("anim@gangops@hostage@")
                                                TaskPlayAnim(PlayerPedId(), "anim@gangops@hostage@", "perp_fail", 8.0, -8.0, -1, 168, 0, false, false, false)
                                                local head_coords = GetPedBoneCoords(hostagePed, 44921, 0, 0, 0)
                                                local hand_coords = GetPedBoneCoords(PlayerPedId(), 6286, 0, 0, 0)
                                                SetPedShootsAtCoord(PlayerPedId(), 0.0, 0.0, 0.0, 0)
                                                ShootSingleBulletBetweenCoords(head_coords.x, head_coords.y, head_coords.z, hand_coords.x, hand_coords.y, hand_coords.z, 100, false, GetSelectedPedWeapon(PlayerPedId()), PlayerPedId(), false, false)
                                                SetEntityHealth(hostagePed,0)
                                                FreezeEntityPosition(hostagePed, false)
                                                hasHostage = false
                                                hostagePed = nil
                                                TriggerEvent("hotkeys:enable", true)
                                            else
                                                TriggerEvent("usa:notify", "No Ammo!")
                                            end
                                        end
                                    end
                                    
                                end 
                                break
                            end
                            dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(targetPed))
                        end
                        FreezeEntityPosition(targetPed, false)
                        StopAnimTask(targetPed, emote.dict, emote.name, 1.0)
                        ClearPedTasksImmediately(targetPed)
                        TaskSetBlockingOfNonTemporaryEvents(targetPed, false)
                        TaskReactAndFleePed(targetPed, PlayerPedId())
                        TriggerEvent("hotkeys:enable", true)
                    end
                end
            end
        end
        Wait(1)
    end
end)

function isValidPedModel(ped)
	return GetPedType(ped) ~= 28
end

-- make sure player holds button while robbing/holding npc hostage --
Citizen.CreateThread(function()
    while true do
        if robbing then
            if not IsControlPressed(0, KEYS.E) or not IsAimCamActive() then 
                canceled = true
            end
        end
        if takingHostage then
            if not IsControlPressed(0, KEYS.G) or not IsAimCamActive() then 
                canceled = true
            end
        end
        Wait(1)
    end
end)

function LoadAnimation(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(1)
    end
end