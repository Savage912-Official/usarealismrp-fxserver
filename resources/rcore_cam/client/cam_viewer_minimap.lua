local lastX = nil
local lastY = nil

local leftOffset = 0.1
local topOffset = 0.5

local width = 0.1
local height = 0.1

local aspectRatio

local camIconWidth = 0.007
local camIconHeight

local borderSize = 0.005

Citizen.CreateThread(function()
    while true do
        aspectRatio = GetAspectRatio()
        camIconHeight = 0.007 * aspectRatio
        
        Wait(1000)
    end
end)

function SetupMinimap(camGroupId)
    local cams = AllCameras[camGroupId]

    lastX, lastY = 0.5, 0.5

    RequestStreamedTextureDict('rcore_cam_icons', false)

    local leftmostX = GetLeftmostX(cams)
    local middleY = GetMiddlePos(cams, 'y')
    local middleZ = GetMiddlePos(cams, 'z')

    local relativePositions = {}

    local maxX = 0

    local minY = 0
    local maxY = 0

    local minZ = 0
    local maxZ = 0

    for _, cam in pairs(cams) do
        local relativePos = vector4(
            cam.pos.x - leftmostX,
            cam.pos.y - middleY,
            cam.pos.z - middleZ,
            cam.heading + Config.CameraModelOffsets[GetHashKey(cam.model)].heading
        )

        maxX = math.max(maxX, relativePos.x)

        minY = math.min(minY, relativePos.y)
        maxY = math.max(maxY, relativePos.y)

        minZ = math.min(minZ, relativePos.z)
        maxZ = math.max(maxZ, relativePos.z)

        table.insert(
            relativePositions,
            relativePos
        )
    end

    -- fix to idk what
    for i = 1, #relativePositions do
        local ySum = (math.abs(minY) + math.abs(maxY))
        local zSum = (math.abs(minZ) + math.abs(maxZ))

        if ySum == 0 then ySum = 1.0 end
        if zSum == 0 then zSum = 1.0 end

        relativePositions[i] = vector4(
            relativePositions[i].x / maxX,
            (math.abs(minY) + relativePositions[i].y) / ySum,
            (math.abs(minZ) + relativePositions[i].z) / zSum,
            relativePositions[i].w
        )
    end

    return maxX, minY, maxY, leftmostX, middleY, relativePositions
end

function RenderCamMinimap(maxX, minY, maxY, leftmostX, middleY, relativePositions, camClient, camGroupId, recordingTime, recordedData)
    DisableAllControlActions(0)

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local fixedCoords = vector3(
        (coords.x - leftmostX) / maxX,
        (math.abs(minY) + (coords.y - middleY)) / (math.abs(minY) + math.abs(maxY)),
        coords.z
    )

    -- background
    DrawRect(leftOffset, topOffset, width + camIconWidth, height * aspectRatio + camIconHeight, 0, 0, 0, 150)

    -- top border
    DrawRect(
        leftOffset,
        topOffset - height * aspectRatio / 2 - camIconHeight/2 - borderSize,
        width + camIconWidth + borderSize*2,
        borderSize * aspectRatio,
        0, 0, 0, 200
    )

    -- bottom border
    DrawRect(
        leftOffset,
        topOffset + height * aspectRatio / 2 + camIconHeight/2 + borderSize,
        width + camIconWidth + borderSize*2,
        borderSize * aspectRatio,
        0, 0, 0, 200
    )
    
    -- left border
    DrawRect(
        leftOffset - width/2 - camIconWidth/2 - borderSize/2,
        topOffset,
        borderSize,
        height * aspectRatio + camIconHeight,
        0, 0, 0, 200
    )
    
    -- right border
    DrawRect(
        leftOffset + width/2 + camIconWidth/2 + borderSize/2,
        topOffset,
        borderSize,
        height * aspectRatio + camIconHeight,
        0, 0, 0, 200
    )

    local curX, curY = GetCursorPos()

    local clickHandled = false

    for camIdx, pos in pairs(relativePositions) do
        -- cam blip

        local camIconX = pos.x * width + leftOffset - width/2
        local camIconY = pos.y * height * aspectRatio + topOffset - height/2*aspectRatio


        local topLeftX = camIconX - camIconWidth/2
        local topLeftY = camIconY - camIconHeight/2
        local bottomRightX = camIconX + camIconWidth/2
        local bottomRightY = camIconY + camIconHeight/2

        local color = {
            tonumber(math.floor(255 * (pos.z*0.5+0.5))), 
            tonumber(math.floor(255 * (pos.z*0.5+0.5))), 
            tonumber(math.floor(255 * (pos.z*0.5+0.5)))
        }

        local isCursorHovering = topLeftX < curX and topLeftY < curY and bottomRightX > curX and bottomRightY > curY
        local isCamShot = GetCamIsShot(recordingTime, recordedData, camIdx)
        
        if camIdx == CurrentCamIndex then
            color = {
                0, 
                tonumber(math.floor(255 * (pos.z*0.5+0.5))),
                0
            }
        elseif isCursorHovering then
            color = {
                tonumber(math.floor(66 * (pos.z*0.5+0.5))), 
                tonumber(math.floor(203 * (pos.z*0.5+0.5))), 
                tonumber(math.floor(245 * (pos.z*0.5+0.5)))
            }
        end

        if not isCamShot and not clickHandled and isCursorHovering and (IsControlJustPressed(0, 24) or IsDisabledControlJustPressed(0, 24)) then
            clickHandled = true
            CameraClientSetCam(camClient, camGroupId, camIdx)
        end

        if isCamShot then
            color = {
                tonumber(math.floor(255 * (pos.z*0.5+0.5))), 
                tonumber(math.floor(0 * (pos.z*0.5+0.5))), 
                tonumber(math.floor(0 * (pos.z*0.5+0.5)))
            }
        end


        DrawSprite(
            'rcore_cam_icons', 'radar_cctv',
            camIconX, 
            camIconY, 

            camIconWidth, 
            camIconHeight, 
            pos.w,
            color[1], color[2], color[3], 255
        )
    end

    -- player blip
    DrawRect(
        fixedCoords.x * width + leftOffset - width/2, 
        fixedCoords.y * height * aspectRatio + topOffset - height/2*aspectRatio, 
        camIconWidth * 0.4, camIconHeight * 0.4, 
        255, 0, 0, 255
    )
    
    RenderCursor(curX, curY)

end

function GetCursorPos()
    local pxX, pxY = GetNuiCursorPosition()
    local resX, resY = GetActiveScreenResolution()

    local x = pxX/resX
    local y = pxY/resY

    return x, y
end

function RenderCursor(x, y)
    local cursorWidth, cursorHeight = 0.01, 0.01

    DrawSprite(
        'rcore_cam_icons', 'cursor',
        x + cursorWidth/2, y + cursorHeight / 2* GetAspectRatio(), 
        cursorWidth, cursorHeight * GetAspectRatio(), 
        0.0, 
        255, 255, 255, 255
    )
end

function GetLeftmostX(cams)
    local leftmostX = cams[1].pos.x

    for i = 2, #cams do
        if cams[i].pos.x < leftmostX then
            leftmostX = cams[i].pos.x
        end
    end

    return leftmostX
end

function GetMiddlePos(cams, axis)
    local yTotal = 0

    for i = 1, #cams do
        yTotal = yTotal + cams[i].pos[axis]
    end

    return yTotal/#cams
end