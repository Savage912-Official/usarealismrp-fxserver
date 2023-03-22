
DestroyedCameras = {}
ModelHides = {}
SuspendShootEventUntil = 0

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local hasWeapon, weapon = GetCurrentPedWeapon(ped, 1)

        if hasWeapon then
            Wait(0)
            
            local hit, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
            local isShooting = IsPedShooting(ped)

            if isShooting and GetGameTimer() > SuspendShootEventUntil and not Config.CamTriggerBlacklistedWeapons[weapon] then
                SuspendShootEventUntil = GetGameTimer()
                TriggerServerEvent('rcore_cam:shotsFired')
            end

            if hit then
                if isShooting then
                    local entCoords = GetEntityCoords(entity)
                    
                    DestroySecurityCam(entCoords)
                    -- CreateModelHide(entCoords.x, entCoords.y, entCoords.z, 0.1, entModel, true)

                    -- Citizen.CreateThread(function()
                    --     Wait(5000)
                    --     RemoveModelHide(entCoords.x, entCoords.y, entCoords.z, 0.1, entModel, false)
                    -- end)
                end
            end
        

        else
            Wait(400)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local isAnyDestroyed = false
        local coords = GetEntityCoords(PlayerPedId())

        for _, camData in pairs(DestroyedCameras) do
            isAnyDestroyed = true

            ProcessDestroyedCamera(coords, camData)
        end

        if isAnyDestroyed then
            Wait(200)
        else
            Wait(1000)
        end
    end
end)

function DestroySecurityCam(entCoords)
    local groupId, camId = FindSecurityCam(entCoords)
    
    if groupId and camId then

        local relativeDestroyedAt = 0

        if CamGroupStartedAt[groupId] then
            relativeDestroyedAt = GetGameTimer() - CamGroupStartedAt[groupId]
        end

        TriggerServerEvent('rcore_cam:destroySecurityCamera', groupId, camId, relativeDestroyedAt)
    end
end

function FindSecurityCam(entCoords)
    for _, groupId in pairs(NearCameraGroups) do
        for camId, camData in pairs(AllCameras[groupId]) do
            if #(camData.pos - entCoords) < 0.1 then
                return groupId, camId
            end
        end
    end

    return nil
end

RegisterNetEvent('rcore_cam:setCameraDestroyed', function(cam)
    DestroyedCameras[cam[1] .. '_' .. cam[2]] = cam
    ProcessDestroyedCamera(GetEntityCoords(PlayerPedId()), cam)
end)

RegisterNetEvent('rcore_cam:setCamerasDestroyed', function(cams)
    DestroyedCameras = cams
end)

RegisterNetEvent('rcore_cam:undestroyCamera', function(groupId, camId)
    if groupId and camId and AllCameras[groupId] and AllCameras[groupId][camId] then
        local targetCamData = AllCameras[groupId][camId]
        local key = groupId .. '_' .. camId

        if DestroyedCameras[key] then
            DestroyedCameras[key] = nil
            
            if ModelHides[key] then
                ModelHides[key] = nil

                RemoveModelHide(
                    targetCamData.pos.x, targetCamData.pos.y, targetCamData.pos.z, 
                    0.1, 
                    GetHashKey(targetCamData.model), 
                    false
                )
            end
        end
    end
end)

function ProcessDestroyedCamera(coords, camData)
    if camData[1] and camData[2] and AllCameras[camData[1]] and AllCameras[camData[1]][camData[2]] then
        local targetCamData = AllCameras[camData[1]][camData[2]]

        local key = camData[1] .. '_' .. camData[2]

        if #(targetCamData.pos - coords) < 100.0 then
            if not ModelHides[key] then
                ModelHides[key] = true
                CreateModelHide(
                    targetCamData.pos.x, targetCamData.pos.y, targetCamData.pos.z, 
                    0.1, 
                    GetHashKey(targetCamData.model), 
                    true
                )
            end
        else
            if ModelHides[key] then
                ModelHides[key] = nil

                RemoveModelHide(
                    targetCamData.pos.x, targetCamData.pos.y, targetCamData.pos.z, 
                    0.1, 
                    GetHashKey(targetCamData.model), 
                    false
                )
            end
        end
    end
end

function HandleShotCamera(recordingTime, recordedData)
    if recordedData.destroyedCameras then
        if GetCamIsShot(recordingTime, recordedData, CurrentCamIndex) then
            DrawRect(0.5, 0.5, 1.0, 1.0, 0, 0, 0, 255)

            if GetGameTimer() % 2000 < 1000 then

                SetTextFont(0)
                SetTextScale(3.0, 3.0)
                SetTextColour(255, 255, 255, 255)
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 150)
                SetTextDropshadow()
                SetTextOutline()
            
                SetTextCentre(1)
            
                SetTextEntry("STRING")
                AddTextComponentString('NO DATA')
                DrawText( 0.5, 0.4 )
            end
        end
    end
end

function GetCamIsShot(recordingTime, recordedData, camId)
    local curCamData = recordedData.destroyedCameras[tostring(camId)]

    if not curCamData then
        curCamData = recordedData.destroyedCameras[tonumber(camId)]
    end

    return curCamData and recordingTime > curCamData
end