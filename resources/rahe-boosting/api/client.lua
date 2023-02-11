--
--[[ Framework specific functions ]]--
--

local framework = shConfig.framework
local ESX, QBCore

CreateThread(function()
    if framework == 'ESX' then
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end

        RegisterNetEvent('esx:playerLoaded')
        AddEventHandler('esx:playerLoaded', function (xPlayer)
            ESX.PlayerData = xPlayer
        end)

        RegisterNetEvent('esx:setJob')
        AddEventHandler('esx:setJob', function (job)
            ESX.PlayerData.job = job
        end)
    elseif framework == 'QB' then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

-- Use this variable if you want to set the player as police with an event from another resource.
local isPolice = false

function isPlayerPolice()
    if isPolice then
        return true
    elseif framework == 'ESX' then
        return ESX.PlayerData.job and ESX.PlayerData.job.name == "police"
    elseif framework == 'QB' then
        local playerJob = QBCore.Functions.GetPlayerData().job
        return playerJob.name == 'police' and playerJob.onduty
    elseif framework == 'CUSTOM' then
        local isCop = TriggerServerCallback {
            eventName = "rahe-boosting:isCop",
            args = {}
        }
        if isCop then
            return true
        end
    else
        return false
    end
end

--
--[[ Boosting tablet opening ]]--
--

local isVisible = false
local tabletObject = nil

-- Tablet opening through a command
-- if clConfig.commandsEnabled then
--     RegisterCommand("boosting", function()
--         openTablet()
--     end)
-- end

-- Tablet opening through an event
RegisterNetEvent("rahe-boosting:client:openTablet")
AddEventHandler("rahe-boosting:client:openTablet", function()
    local playerPed = PlayerPedId()
    if not isVisible then
        local dict = "amb@world_human_seat_wall_tablet@female@base"
        RequestAnimDict(dict)
        if tabletObject == nil then
            tabletObject = CreateObject(GetHashKey('prop_cs_tablet'), GetEntityCoords(playerPed), 1, 1, 1)
            AttachEntityToEntity(tabletObject, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        end
        while not HasAnimDictLoaded(dict) do Citizen.Wait(100) end
        if not IsEntityPlayingAnim(playerPed, dict, 'base', 3) then
            TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
        end
    else
        DeleteEntity(tabletObject)
        ClearPedTasks(playerPed)
        tabletObject = nil
    end
    openTablet()
end)


--
--[[ Using hacking device ]]--
--

-- Hacking device using through a command
-- if clConfig.commandsEnabled then
--     RegisterCommand("usehackingdevice", function()
--         useHackingDevice()
--     end)
-- end

-- Hacking device using through an event
RegisterNetEvent("rahe-boosting:client:hackingDeviceUsed")
AddEventHandler("rahe-boosting:client:hackingDeviceUsed", function()
    useHackingDevice()
end)


--
--[[ Using GPS hacking device ]]--
--

-- GPS hacking device using function. This calls an internal encrypted function which starts the use.
-- if clConfig.commandsEnabled then
--     RegisterCommand("usegpshackingdevice", function()
--         useGpsHackingDevice()
--     end)
-- end

-- GPS hacking device using through an event
RegisterNetEvent("rahe-boosting:client:gpsHackingDeviceUsed")
AddEventHandler("rahe-boosting:client:gpsHackingDeviceUsed", function()
    useGpsHackingDevice()
end)


--
--[[ General]]--
--

RegisterNetEvent('rahe-boosting:client:notify')
AddEventHandler('rahe-boosting:client:notify',function(message, type)
	TriggerEvent("chatMessage", '', {46,204,113}, message)
    notifyPlayer(message, type)
end)

function notifyPlayer(message, type)
    lib.notify({
        title = message,
        type = type
    })
end

-- You can do some logic here when the tablet is closed. For example, if you started an animation when opening, you can end the animation here.
RegisterNetEvent('rahe-boosting:client:tabletClosed', function()
    local playerPed = PlayerPedId()
    DeleteEntity(tabletObject)
    ClearPedTasks(playerPed)
    tabletObject = nil
end)

-- The event which can be used to give vehicle keys to the player after completing the hack of a special boost (A / S class).
AddEventHandler('rahe-boosting:client:giveKeys', function(vehicleId, licensePlate)
    local key = {
		name = "Key -- " .. licensePlate,
		quantity = 1,
		type = "key",
		owner = "UNKNOWN",
		make = vehicleId,
		model = vehicleId,
		plate = licensePlate
	}
    TriggerServerEvent("garage:giveKey", key)
end)

-- The event which will be triggered when a player hacks the engine of an important boost. This marks the start of a high priority boost.
-- This event can be used to send a notification to police dispatch to alert the police.
AddEventHandler('rahe-boosting:client:importantBoostStarted', function(location, vehicleId, vehicleClass)
    local streetName, crossing = GetStreetNameAtCoord(location.x, location.y, location.z)
    streetName = GetStreetNameFromHashKey(streetName)
    local licenseplate = GetVehicleNumberPlateText(vehicleId)
    TriggerServerEvent('911:VehicleBoosting', location.x, location.y, location.z, streetName, licenseplate, vehicleClass)
end)

-- The event which will be triggered when the players fails a GPS hack.
-- This event can be used to raise player's stress level.
AddEventHandler('rahe-boosting:client:failedGpsHack', function()
    local playerCoords = GetEntityCoords(PlayerPedId())

    local streetName, crossing = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    streetName = GetStreetNameFromHashKey(streetName)

    TriggerServerEvent('911:call', playerCoords.x, playerCoords.y, playerCoords.z, "^*Vehicle Boosting in Progress:^r OnStar reports failed GPS tampering near ["..streetName.."]")
end)

-- The event which will be triggered when the players successfully completes one GPS hack.
-- This event by default is used to send a notification, but can also be used to set a circle in a bottom UI circle.
RegisterNetEvent('rahe-boosting:client:successfulGpsHack')
AddEventHandler('rahe-boosting:client:successfulGpsHack', function(hacksCompleted, hacksRequired, gainedDelay)
    notifyPlayer(translations.NOTIFICATION_GAME_HACK_SUCCESSFUL:format(gainedDelay, hacksCompleted, hacksRequired), G_NOTIFICATION_TYPE_SUCCESS)
end)

-- Create Store Ped
Citizen.CreateThread(function()
    local createdJobPed
    while true do
		local playerCoords = GetEntityCoords(PlayerPedId(), false)
        local ped = {x = 152.02969360352, y = -3013.6166992188, z = 9.703437805176, heading = 37.9}
        if Vdist(ped.x, ped.y, ped.z, playerCoords.x, playerCoords.y, playerCoords.z) < 100 then
            if not createdJobPed then
                local hash = -984709238
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    RequestModel(hash)
                    Wait(0)
                end
                local ped = CreatePed(4, hash, ped.x, ped.y, ped.z, ped.heading, false, true)
                SetEntityCanBeDamaged(ped,false)
                FreezeEntityPosition(ped, true)
                SetPedCanRagdollFromPlayerImpact(ped,false)
                TaskSetBlockingOfNonTemporaryEvents(ped,true)
                SetPedFleeAttributes(ped,0,0)
                SetPedCombatAttributes(ped,17,1)
                SetPedRandomComponentVariation(ped, true)
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
                createdJobPed = ped
            end
        else 
            if createdJobPed then 
                DeletePed(createdJobPed)
                createdJobPed = nil
            end
        end
		Wait(1)
	end
end)