local NPC_COORDS = vector3(1762.3232421875, 2593.0949707031, 45.797840118408)
local NPC_HEADING = 280.0
local NPC_PED_MODEL = 1456041926

local currentJobLocations = nil

local currentPedCoords = vector3(0.0, 0.0, 0.0)

local MAX_CLEAN_DISTANCE = 1.5
local START_CLEANING_KEY = 38
local START_JOB_KEY = 38

local CLEAN_TIME_SECONDS = 45 -- also tightly coupled with a server sided duplicate variable rn unfortunately so don't forget to update that too if u change it

local JOB_START_DELAY_SECONDS = 10 * 60

local lastJobFinishedAt = 0

RegisterNetEvent("prison-janitor:startJobClient")
AddEventHandler("prison-janitor:startJobClient", function(cleaningLocations, taskName)
    currentJobLocations = cleaningLocations
    currentTask = taskName
end)

RegisterNetEvent("prison-janitor:removeCurrentJobLocations")
AddEventHandler("prison-janitor:removeCurrentJobLocations", function()
    currentJobLocations = nil
    lastJobFinishedAt = GetGameTimer()
end)

local function DrawText3D(x, y, z, text)
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

local function DrawTimerBar(beginTime, duration, x, y, text)
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

local function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))

    if not HasModelLoaded(prop1) then
        RequestModel(GetHashKey(prop1))
        while not HasModelLoaded(GetHashKey(prop1)) do
            Wait(10)
        end
    end

    local propHandle = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(propHandle, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded(prop1)
    return propHandle
end

local function getAnimationInfoForTask(taskName)
    if taskName == "tables" then
        return {
            dict = "timetable@floyd@clean_kitchen@base",
            name = "base"
        }
    elseif taskName == "shower" then
        return {
            dict = "amb@world_human_maid_clean@",
            name = "base"
        }
    end
end

-- thread to keep track of current ped coords:
Citizen.CreateThread(function()
    while true do
        currentPedCoords = GetEntityCoords(PlayerPedId())
        Wait(1)
    end
end)

-- job ped spawning:
local jobPedHandle = nil
Citizen.CreateThread(function()
    while true do
        if Vdist(currentPedCoords, NPC_COORDS) < 40 then
            if not jobPedHandle then
                RequestModel(GetHashKey(NPC_PED_MODEL))
                while not HasModelLoaded(NPC_PED_MODEL) do
                    RequestModel(NPC_PED_MODEL)
                    Wait(1)
                end
                jobPedHandle = CreatePed(0, NPC_PED_MODEL, NPC_COORDS.x, NPC_COORDS.y, NPC_COORDS.z, 0.1, false, false)
                SetEntityCanBeDamaged(jobPedHandle,false)
                SetPedCanRagdollFromPlayerImpact(jobPedHandle,false)
                SetBlockingOfNonTemporaryEvents(jobPedHandle,true)
                SetPedFleeAttributes(jobPedHandle,0,0)
                SetPedCombatAttributes(jobPedHandle,17,1)
                SetEntityHeading(jobPedHandle, NPC_HEADING)
            end
        else 
            if jobPedHandle then
                DeletePed(jobPedHandle)
                jobPedHandle = nil
            end
        end
        Wait(1)
    end
end)

-- job toggling:
Citizen.CreateThread(function()
    while true do
        if Vdist(currentPedCoords, NPC_COORDS) < 2 then
            DrawText3D(NPC_COORDS.x, NPC_COORDS.y, NPC_COORDS.z, "[E] - " .. ((currentJobLocations and "Stop") or "Start") .." Cleaning Job")
            if IsControlJustPressed(0, START_JOB_KEY) then
                if (not currentJobLocations and GetGameTimer() - lastJobFinishedAt > JOB_START_DELAY_SECONDS * 1000) or currentJobLocations or lastJobFinishedAt == 0 then
                    TriggerServerEvent("prison-janitor:toggleJob")
                else
                    exports.globals:notify("Wait " .. math.floor(((JOB_START_DELAY_SECONDS * 1000) - (GetGameTimer() - lastJobFinishedAt)) / (1000 * 60)) .. " minute(s)")
                end
            end
        end
        Wait(1)
    end
end)

-- handling job actions:
Citizen.CreateThread(function()
    while true do
        if currentJobLocations then
            for i = 1, #currentJobLocations do
                if not currentJobLocations[i].cleaned then
                    DrawMarker(27, vector3(currentJobLocations[i].x, currentJobLocations[i].y, currentJobLocations[i].z - 0.99), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, vector3(0.5, 0.5, 0.5), 240, 230, 140, 150, false, true, 2, false, nil, nil, false)
                    if Vdist(currentPedCoords, currentJobLocations[i].x, currentJobLocations[i].y, currentJobLocations[i].z) < MAX_CLEAN_DISTANCE then
                        DrawText3D(currentJobLocations[i].x, currentJobLocations[i].y, currentJobLocations[i].z - 0.9, "[E] - Clean")
                        if IsControlJustPressed(0, START_CLEANING_KEY) then
                            local propHandle = AddPropToPlayer("prop_sponge_01", 28422, 0.0, 0.0, -0.01, 90.0, 0.0, 0.0)
                            while securityToken == nil do
                                Wait(1)
                            end
                            TriggerServerEvent("prison-janitor:markLocationAsBeingCleaned", i, securityToken)
                            local beginTime = GetGameTimer()
                            local me = PlayerPedId()
                            while GetGameTimer() - beginTime < CLEAN_TIME_SECONDS * 1000 do
                                DrawTimerBar(beginTime, CLEAN_TIME_SECONDS * 1000, 1.42, 1.475, 'CLEANING')
                                local animInfo = getAnimationInfoForTask(currentTask)
                                if not IsEntityPlayingAnim(me, animInfo.dict, animInfo.name, 3) then
                                    exports.globals:loadAnimDict(animInfo.dict)
                                    TaskPlayAnim(me, animInfo.dict, animInfo.name, 8.0, 1.0, -1, 11, 1.0, false, false, false)
                                end
                                Wait(1)
                            end
                            ClearPedTasks(me)
                            while securityToken == nil do
                                Wait(1)
                            end
                            TriggerServerEvent("prison-janitor:markLocationAsCleaned", i, securityToken)
                            currentJobLocations[i].cleaned = true
                            DeleteObject(propHandle)
                        end
                    end
                end
            end
        end
        Wait(1)
    end
end)