function RenderCamOverlay(camGroupId, nowSeconds, maxSeconds, playbackStatus)
    local lineWidth = 0.15
    local lineWidthHorizontal = 0.3
    local lineHeight = 0.005

    local offset = 0.03

    local aspectRatio = GetAspectRatio()

    -- TOP LEFT
    DrawRect(
        offset + lineWidthHorizontal/2, (offset + lineHeight/2) * aspectRatio, 
        lineWidthHorizontal, lineHeight * aspectRatio, 
        255, 255, 255, 255
    )
    
    DrawRect(
        offset + lineHeight/2, (offset + lineWidth/2) * aspectRatio, 
        lineHeight, lineWidth * aspectRatio, 
        255, 255, 255, 255
    )
    

    -- BOTTOM RIGHT
    DrawRect(
        1.0 - (offset + lineWidthHorizontal/2), 1.0 - (offset + lineHeight/2) * aspectRatio, 
        lineWidthHorizontal, lineHeight * aspectRatio, 
        255, 255, 255, 255
    )

    DrawRect(
        1.0 - (offset + lineHeight/2), 1.0 - (offset + lineWidth/2) * aspectRatio, 
        lineHeight, lineWidth * aspectRatio, 
        255, 255, 255, 255
    )

    
    -- TOP RIGHT
    DrawRect(
        1.0 - (offset + lineWidthHorizontal/2), (offset + lineHeight/2) * aspectRatio, 
        lineWidthHorizontal, lineHeight * aspectRatio, 
        255, 255, 255, 255
    )
    
    DrawRect(
        1.0 - (offset + lineHeight/2), (offset + lineWidth/2) * aspectRatio, 
        lineHeight, lineWidth * aspectRatio, 
        255, 255, 255, 255
    )

    -- BOTTOM LEFT
    DrawRect(
        offset + lineWidthHorizontal/2, 1.0 - (offset + lineHeight/2) * aspectRatio, 
        lineWidthHorizontal, lineHeight * aspectRatio, 
        255, 255, 255, 255
    )

    DrawRect(
        offset + lineHeight/2, 1.0 - (offset + lineWidth/2) * aspectRatio, 
        lineHeight, lineWidth * aspectRatio, 
        255, 255, 255, 255
    )

    RenderOverlayText(2, 0.038, 0.058, 1.0, 'Cam Network ' .. camGroupId .. '~n~Cam ' .. CurrentCamIndex)
    RenderOverlayText(7, 0.5, 0.88, 1.0, FormatTime(math.min(nowSeconds, maxSeconds)) .. '/' .. FormatTime(maxSeconds), true)

    RequestStreamedTextureDict('rcore_cam_icons', false)

    if playbackStatus == 'play' then
        DrawSprite(
            'rcore_cam_icons', 'btn_play', 
            0.911, 0.095 * aspectRatio, 
            0.1, 0.1 * aspectRatio, 
            0.0, 
            255, 255, 255, 255
        )
    elseif playbackStatus == 'pause' then
        DrawSprite(
            'rcore_cam_icons', 'btn_pause', 
            0.911, 0.095 * aspectRatio, 
            0.1, 0.1 * aspectRatio, 
            0.0, 
            255, 255, 255, 255
        )
    elseif playbackStatus == 'rewind' then
        DrawSprite(
            'rcore_cam_icons', 'btn_fast_forward', 
            0.911, 0.095 * aspectRatio, 
            0.1, 0.1 * aspectRatio, 
            180.0, 
            255, 255, 255, 255
        )
    elseif playbackStatus == 'fast-forward' then
        DrawSprite(
            'rcore_cam_icons', 'btn_fast_forward', 
            0.911, 0.095 * aspectRatio, 
            0.1, 0.1 * aspectRatio, 
            0.0, 
            255, 255, 255, 255
        )
    end
end

function RenderOverlayText(fontId, x, y, size, text, center)
    SetTextFont(fontId)
    SetTextScale(size, size)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 150)
    SetTextDropshadow()
    SetTextOutline()

    if center then
        SetTextCentre(1)
    end

    SetTextEntry("String")
    AddTextComponentString(text)
    DrawText( x, y )
end

function FormatTime(seconds)
    seconds = math.floor(seconds)
    local hoursLeft = math.floor(seconds/60/60)
    local minutesLeft = math.floor((seconds-(hoursLeft*60*60))/60)
    local secondsLeft = seconds - minutesLeft * 60 - hoursLeft*60*60
 
    local textHours = tostring(hoursLeft)
    local textMinutes = tostring(minutesLeft)
    local textSeconds = tostring(secondsLeft)
 
    if hoursLeft < 10 then
       textHours = "0" .. textHours
    end
 
    if minutesLeft < 10 then
       textMinutes = "0" .. textMinutes
    end
 
    if secondsLeft < 10 then
       textSeconds = "0" .. textSeconds
    end
 
    local formattedHours = ''
 
    if hoursLeft > 0 then
       formattedHours = textHours .. ':'
    end
 
    return formattedHours .. textMinutes .. ':' .. textSeconds
 end
 