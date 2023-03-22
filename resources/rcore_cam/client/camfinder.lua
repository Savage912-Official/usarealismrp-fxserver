ActiveCameraGroups = {}
NearCameraGroups = {}

Citizen.CreateThread(function()
    -- find near camera groups
    Citizen.CreateThread(function()
        while true do
            Wait(1000)

            local newNears = {}

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)

            local timeout = 5

            for groupId, groupCams in pairs(AllCameras) do
                
                timeout = timeout - 1

                if timeout <= 0 then
                    Wait(50)
                    timeout = 5
                end

                if #(groupCams[1].centerPos - coords) < 500.0 then
                    table.insert(newNears, groupId)
                end
            end

            NearCameraGroups = newNears
        end
    end)

    -- find active camera groups
    Citizen.CreateThread(function()
        while true do
            Wait(300)

            local newActive = {}

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)

            local timeout = 10

            for _, groupId in pairs(NearCameraGroups) do
                
                timeout = timeout - 1

                if timeout <= 0 then
                    Wait(50)
                    timeout = 10
                end

                local center = AllCameras[groupId][1]

                if #(center.centerPos - coords) < 140.0 then
                    table.insert(newActive, groupId)
                end
            end

            ActiveCameraGroups = newActive
        end
    end)
end)
