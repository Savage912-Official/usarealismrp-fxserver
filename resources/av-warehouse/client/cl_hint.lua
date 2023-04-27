-- truck coords: x = 5067.7109375, y = -5597.2739257813, z = 33.963249206543, heading = 70

local NPC_SPAWN_DISTANCE = 100.0
local DRAW_3D_TEXT_DIST = 5

local TRUCK_COORDS = vector3(5067.7, -5597.3, 33.9)
local TRUCK_HEADING = 20.0
local TRUCK_MODEL = GetHashKey("bison")

local PED_MODEL = "a_m_o_acult_02"
local PED_COORDS = vector3(5071.2470703125, -5599.5297851563, 34.549381256104)
local PED_HEADING = 320.0

local HINT_KEY = 38 -- e

local BLIP_ERASE_DELAY_MINUTES = 45

local isWithin3dTextDist = false
hintBlipHandle = nil

Citizen.CreateThread(function()
    local spawnedTruckHandle = nil
    local spawnedPedHandle = nil
    while true do
        local mycoords = GetEntityCoords(PlayerPedId())
        local dist = #(mycoords - TRUCK_COORDS)
        if dist < NPC_SPAWN_DISTANCE then
            if dist < DRAW_3D_TEXT_DIST then
                isWithin3dTextDist = true
            else
                isWithin3dTextDist = false
            end
            if not spawnedTruckHandle then
                RequestModel(TRUCK_MODEL)
                while not HasModelLoaded(TRUCK_MODEL) do
                    Wait(1)
                end
                spawnedTruckHandle = CreateVehicle(TRUCK_MODEL, TRUCK_COORDS.x, TRUCK_COORDS.y, TRUCK_COORDS.z, TRUCK_HEADING, false, true)
                makeQuestVehicle(spawnedTruckHandle)
            end
            if not spawnedPedHandle then
                RequestModel(GetHashKey(PED_MODEL))
                while not HasModelLoaded(PED_MODEL) do
                    Wait(1)
                end
                spawnedPedHandle = CreatePed(0, PED_MODEL, PED_COORDS.x, PED_COORDS.y, PED_COORDS.z, PED_HEADING, false, true)
                makeQuestNPC(spawnedPedHandle)
            end
        else
            if spawnedTruckHandle then
                DeleteVehicle(spawnedTruckHandle)
                spawnedTruckHandle = nil
            end
            if spawnedPedHandle then
                DeletePed(spawnedPedHandle)
                spawnedPedHandle = nil
            end
            isWithin3dTextDist = false
        end
        Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        if isWithin3dTextDist then
            DrawText3D(PED_COORDS.x, PED_COORDS.y, PED_COORDS.z, "[E] - Hint")
            if IsControlJustPressed(0, HINT_KEY) then
                TriggerServerEvent("av_warehouse:hint")
            end
        end
        Wait(1)
    end
end)

function makeQuestNPC(handle)
    SetEntityCanBeDamaged(handle,false)
    SetPedCanRagdollFromPlayerImpact(handle,false)
    SetBlockingOfNonTemporaryEvents(handle,true)
    SetPedFleeAttributes(handle,0,0)
    SetPedCombatAttributes(handle,17,1)
    Wait(1500)
    FreezeEntityPosition(handle, true)
    TaskStartScenarioInPlace(handle, "WORLD_HUMAN_AA_SMOKE", 0, true)
end

function makeQuestVehicle(handle)
    SetVehicleDoorsLocked(handle, 2)
    SetEntityInvincible(handle, true)
    FreezeEntityPosition(handle, true)
end

RegisterNetEvent("av_warehouse:addHintBlip")
AddEventHandler("av_warehouse:addHintBlip", function(x, y, z, radius)
    if not hintBlipHandle then
        hintBlipHandle = AddBlipForRadius(x, y, z, radius)
        SetBlipSprite(hintBlipHandle, 9)
        SetBlipColour(hintBlipHandle, 33)
        SetBlipAlpha(hintBlipHandle, 75)
        SetTimeout(BLIP_ERASE_DELAY_MINUTES * 60 * 1000, function()
            RemoveBlip(hintBlipHandle)
            hintBlipHandle = nil
        end)
    end
end)