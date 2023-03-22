Citizen.CreateThread(function()
    
    WarMenu.CreateMenu('admin', 'Cam Admin')
    WarMenu.CreateSubMenu('adminCamSelected', 'admin', 'Cam Admin')
    WarMenu.CreateSubMenu('adminCamConfirmDiscard', 'admin', 'Cam Admin')
end)

function FindExistingCamera(pos)
    for groupId, cams in pairs(AllCameras) do
        for camId, camData in pairs(cams) do
            if #(pos - camData.pos) < 0.1 then
                return groupId, camId
            end
        end
    end

    return false
end

RegisterNetEvent('rcore_cam:openAdminTool', function()
    local clusterColors = {}

    for i = 0, 1000 do
        clusterColors[i] = {math.random(0, 255), math.random(0, 255),math.random(0, 255) }
    end

    WarMenu.OpenMenu('admin')

    local selectedCamData = nil
    local selectedExistingCamera = nil

    while true do
        Wait(0)

        Render2DText(0.5, 0.8, 0.5, '~r~WARNING:~s~ Do not use Cam Admin Tool in production environment with players')

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if WarMenu.IsMenuOpened('admin') then
            selectedCamData = GetCameraInFinder(selectedCamData)

            if selectedCamData and WarMenu.MenuButton('Select camera', 'adminCamSelected') then
                local groupId, camId = FindExistingCamera(selectedCamData.pos)

                if groupId and camId then
                    selectedExistingCamera = {groupId, camId}
                    WarMenu.SetSubTitle('adminCamSelected', 'Existing ' .. groupId .. '/' .. camId)
                else
                    WarMenu.SetSubTitle('adminCamSelected', 'New camera')
                end
            elseif not selectedCamData and WarMenu.Button('~c~Aim at camera') then
            elseif WarMenu.Button('Save Changes') then
                for _, cams in pairs(AllCameras) do
                    for _, cd in pairs(cams) do
                        cd.centerPos = nil
                    end
                end

                TriggerServerEvent('rcore_cam:saveAdminTool', AllCameras)
                NotifyToRestart()
                return
            elseif WarMenu.MenuButton('Discard Changes', 'adminCamConfirmDiscard') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('adminCamSelected') then
            RenderTargetBall(selectedCamData.pos, selectedCamData)

            if WarMenu.Button('Create new Camera Group') then
                AssignCameraToNewGroup(selectedCamData)
                WarMenu.OpenMenu('admin')
            else
                for _, nearGroupId in pairs(NearCameraGroups) do
                    if WarMenu.Button('Assign to Camera Group #' .. nearGroupId) then
                        AssignCameraToGroup(nearGroupId, selectedCamData)
                        WarMenu.OpenMenu('admin')
                    end
                end
            end

            if selectedExistingCamera and WarMenu.Button('Unregister camera') then
                RemoveFromOldCamGroupIfExists(selectedCamData)
            elseif not selectedExistingCamera and WarMenu.Button('~c~Unregister camera') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('adminCamConfirmDiscard') then
            if WarMenu.Button('Yes, discard') then
                NotifyToRestartServerOrGame()
                return
            elseif WarMenu.Button('No, go back') then
                WarMenu.OpenMenu('admin')
            end

            WarMenu.Display()
        else
            WarMenu.OpenMenu('admin')
        end

        if AllCameras then
            for groupId, cams in pairs(AllCameras) do
                for camId, camData in pairs(cams) do
                    local distanceToCam = #(camData.pos - coords)

                    relDistanceToCam = math.min(150.0, math.max(1.0, distanceToCam)) / 150 * 3

                    if distanceToCam < 50.0 then
                        Draw3DText(coords, camData.pos, groupId .. '/' .. camId)
                    end

                    local opacity = 200
                    if selectedCamData and #(selectedCamData.pos.xy - camData.pos.xy) < 0.6 then
                        opacity = 50
                    end

                    DrawBox(
                        camData.pos - relDistanceToCam - vector3(0.0, 0.0, 30.0), 
                        camData.pos + relDistanceToCam + vector3(0.0, 0.0, 30.0), 
                        clusterColors[groupId][1], clusterColors[groupId][2], clusterColors[groupId][3], opacity
                    )
                end
            end
        end
    end
end)

function AssignCameraToNewGroup(selectedCamData)
    RemoveFromOldCamGroupIfExists(selectedCamData)

    local newCamGroup = {{
        pos = selectedCamData.pos,
        model = selectedCamData.model,
        heading = selectedCamData.heading
    }}
    RecomputeCamGroup(newCamGroup)
    table.insert(AllCameras, newCamGroup)
end

function AssignCameraToGroup(groupId, selectedCamData)
    RemoveFromOldCamGroupIfExists(selectedCamData)

    table.insert(AllCameras[groupId], {
        pos = selectedCamData.pos,
        model = selectedCamData.model,
        heading = selectedCamData.heading
    })
    RecomputeCamGroup(AllCameras[groupId])
end

function RemoveFromOldCamGroupIfExists(selectedCamData)
    local groupId, camId = FindExistingCamera(selectedCamData.pos)

    if groupId and camId then
        table.remove(AllCameras[groupId], camId)

        if #AllCameras[groupId] == 0 then
            table.remove(AllCameras, groupId)
        end
    end
end

function RenderTargetBall(endCoords, lastSelected)
    local markerColor = {255, 255, 255, 150}

    if lastSelected then
        markerColor = {100, 255, 100, 100}
    end

    DrawMarker(
        28, 
        endCoords.x, endCoords.y, endCoords.z, 
        0.0, 0.0, 0.0, 
        0.0, 0.0, 0.0, 
        0.5, 0.5, 0.5, 
        markerColor[1], markerColor[2], markerColor[3], markerColor[4], 
        false, false, nil, false, nil, nil, false
    )
end

function GetCameraInFinder(lastSelected)
    local hit, endCoords = RayCastCamFind(30.0)

    if hit then
        
        RenderTargetBall(endCoords, lastSelected)
        for hash, model in pairs(Config.CameraModels) do
            local ent = GetClosestObjectOfType(endCoords.x, endCoords.y, endCoords.z, 0.5, hash, false, true, true)

            if ent and ent > 0 then
                return {
                    pos = GetEntityCoords(ent),
                    model = model,
                    heading = GetEntityHeading(ent)
                }
            end
        end
    end

    return nil
end

function Draw3DText(pedCoords, pos, text)
	local onScreen,_x,_y=World3dToScreen2d(pos.x, pos.y, pos.z)

    local dist = #(pedCoords - pos)

	local scale = 150 / math.min(150.0, math.max(15.0, dist)) * 0.1
    
    if onScreen then
		SetTextScale(scale, scale)
		SetTextProportional(1)
		-- SetTextScale(0.0, 0.55)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

function RayCastCamFind(distance)
    local renderingCam = GetRenderingCam()

    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()

    if renderingCam > 0 then
        cameraRotation = GetCamRot(renderingCam, 2)
        cameraCoord = GetCamCoord(renderingCam)
    end

	local direction = RotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, 1 + 16, PlayerPedId(), 1))
	return b, c, e
end

function NotifyToRestartServerOrGame()
    while true do
        Wait(0)

        Render2DText(0.5, 0.5, 1.0, '~r~WARNING:~s~ Restart ' .. GetCurrentResourceName() .. ' or your game')

    end
end

function NotifyToRestart()
    while true do
        Wait(0)

        Render2DText(0.5, 0.5, 1.0, '~r~WARNING:~s~ Restart ' .. GetCurrentResourceName())

    end
end

function Render2DText(x, y, scale, text)
    SetTextScale(scale, scale)
    SetTextProportional(1)
    -- SetTextScale(0.0, 0.55)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(x, y)
end