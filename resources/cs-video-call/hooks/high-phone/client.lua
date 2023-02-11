return function(resource)
    local originalIsEntityPlayingAnim = _G.IsEntityPlayingAnim

    _G.IsEntityPlayingAnim = function(entity, dict, name, flag)
        if (CS_VIDEO_CALL.ACTIVE and dict == 'cellphone@' and name == 'cellphone_text_to_call') then
            return true
        else
            return originalIsEntityPlayingAnim(entity, dict, name, flag)
        end
    end

    RegisterNetEvent('cs-video-call:custom:setCallee', function(target)
        CS_VIDEO_CALL.SetCallState(true)
        CS_VIDEO_CALL.SetCallee(target)
    end)

    RegisterNetEvent('cs-video-call:custom:clearCallee', function()
        CS_VIDEO_CALL.SetCallState(false)
        CS_VIDEO_CALL.ClearCallee()
    end)

    RegisterNetEvent('high_phone:endCall', function(...)
        CS_VIDEO_CALL.SetCallState(false)
        CS_VIDEO_CALL.ClearCallee()
    end)

    AddEventHandler('cs-video-call:onVideoOn', function()
        -- Triggered when the player has opened the video call camera.

        CreateThread(function()
            local renderId = GetMobilePhoneRenderId()

            while (CS_VIDEO_CALL.ACTIVE) do
                -- Hide HUD and allow mouse controls. 
                EnableControlAction(0, 1, true)
                EnableControlAction(0, 2, true)
                HideHudAndRadarThisFrame()
                SetDrawOrigin(0.0, 0.0, 0.0, 0)
                DisableControlAction(0, 199, true)
                DisableControlAction(0, 200, true)
                SetTextRenderId(renderId)
                Wait(0)
            end

            SetTextRenderId(1)
        end)
    end)
    
    AddEventHandler('cs-video-call:onVideoOff', function()
        -- Triggered when the player has closed the video call camera.
    end)

    AddEventHandler('cs-video-call:onTransmissionRejectedFromExhaustion', function()
        -- Triggered when a transmission of video is rejected by the proxy server because of exhaustion (maximum active transmissions reached).
    end)

    AddEventHandler('cs-video-call:onTransmissionRejectedFromExport', function()
        -- Triggered when a transmission of video is rejected because the client cannot transmit as set by the SetCanTransmitVideo export.
    end)

    CreateThread(function()
        CS_VIDEO_CALL.SetKeyLabels(false) -- Setting this to true will label all the buttons with their respective keys.
    end)

    -- Client Exports

    --[[
        exports['cs-video-call']:SetCanTransmitVideo(state)                           -- Set whether the current client can transmit video.
        exports['cs-video-call']:StopVideoTransmission()                              -- Stop the video transmission of the current client.
    ]]

    -- Hook Exports

    --[[
        You can use CS_VIDEO_CALL.ACTIVE within the phone cs-video-call is hooked on to determinate whether the video camera is active.
        It is a useful check especially in animation loops to prevent animation glitches.
    ]]
end
