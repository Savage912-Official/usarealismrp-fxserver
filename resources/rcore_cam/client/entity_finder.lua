TrackedVehicles = {}
TrackedNPCs = {}

Citizen.CreateThread(function()
    while true do
        Wait(200)

        ProcessTrackVehicles()
        ProcessTrackPeds()
    end
end)

function ProcessTrackVehicles()
    local newTrackedVehicles = {}
    local timeout = 5
    
    local playerPedCoords = GetEntityCoords(PlayerPedId())

    for _, entity in pairs(GetGamePool('CVehicle')) do
        timeout = timeout - 1

        if timeout <= 0 then
            timeout = 5
            Wait(0)
        end

        local coords = GetEntityCoords(entity)

        local shouldEntityBeRecorded = false

        if currentRecordingCamera then
            shouldEntityBeRecorded = CanAnyCameraSeeCoord(coords)
        else
            shouldEntityBeRecorded = #(coords - playerPedCoords) < 30.0
        end

        if shouldEntityBeRecorded then
            table.insert(newTrackedVehicles, entity)
        end
    end

    TrackedVehicles = newTrackedVehicles
end

function ProcessTrackPeds()
    local newTrackedNPCs = {}
    local timeout = 5

    local playerPedCoords = GetEntityCoords(PlayerPedId())

    for _, entity in pairs(GetGamePool('CPed')) do
        timeout = timeout - 1

        if timeout <= 0 then
            timeout = 5
            Wait(0)
        end

        local coords = GetEntityCoords(entity)
        local shouldEntityBeRecorded = false

        if currentRecordingCamera then
            shouldEntityBeRecorded = CanAnyCameraSeeCoord(coords)
        else
            shouldEntityBeRecorded = #(coords - playerPedCoords) < 30.0
        end

        if shouldEntityBeRecorded and not IsPedAPlayer(entity) and NetworkGetEntityIsNetworked(entity) then
            table.insert(newTrackedNPCs, entity)
        end
    end

    TrackedNPCs = newTrackedNPCs
end