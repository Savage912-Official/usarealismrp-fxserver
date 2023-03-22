RegisterNetEvent('rcore_cam:recalibrate', function(lastCalibratedId)
    local camData = LoadResourceFile(GetCurrentResourceName(), 'cameras.json')
    local workCamData = json.decode(camData)

    for groupId, cams in pairs(workCamData) do
        print("Processing " .. groupId .. '/' .. #workCamData)
        if groupId > lastCalibratedId then
            local resultCamData = {}

            for camId, camData in pairs(cams) do
                SetEntityCoords(PlayerPedId(), camData.pos.x, camData.pos.y, camData.pos.z - 0.5, false, false, false, false)
                Wait(200)

                for i = 1, 20 do
                    SetEntityCoords(PlayerPedId(), camData.pos.x, camData.pos.y, camData.pos.z - 0.5, false, false, false, false)

                    local ent = GetClosestObjectOfType(
                        camData.pos.x, camData.pos.y, camData.pos.z, 
                        0.1, 
                        GetHashKey(camData.model), 
                        false, 
                        false, false
                    )

                    if ent and ent > 0 then
                        local heading = GetEntityHeading(ent)

                        table.insert(resultCamData, {
                            pos = camData.pos,
                            model = camData.model,
                            heading = heading,
                        })
                        break
                    end

                    Wait(100)
                end
            end

            if #resultCamData > 0 then
                TriggerServerEvent('rcore_cam:recalibrate', resultCamData, groupId)
            end
        end
    end
    
    TriggerServerEvent('rcore_cam:recalibrateCleanup')
end)