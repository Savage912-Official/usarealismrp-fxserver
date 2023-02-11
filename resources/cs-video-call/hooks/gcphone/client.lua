return function(resource)
    local originalSendNUIMessage = _G.SendNUIMessage
    local originalSetNuiFocusKeepInput = _G.SetNuiFocusKeepInput
    local originalIsEntityPlayingAnim = _G.IsEntityPlayingAnim
    local callWaiting = false
    local callAccepted = false
    local callRejected = false
    local phoneOpen = false
    local lastNuiFocusKeepInputState = false
    local hasAnimFns = PhonePlayIn and PhonePlayCall and PhonePlayText and PhonePlayOut and true or false

    _G.SendNUIMessage = function(data)
        if (data.show ~= nil) then
            phoneOpen = data.show == true
        end

        originalSendNUIMessage(data)
    end

    _G.SetNuiFocusKeepInput = function(state)
        lastNuiFocusKeepInputState = state

        if (not CS_VIDEO_CALL.ACTIVE) then
            originalSetNuiFocusKeepInput(state)
        end
    end

    if (not hasAnimFns) then
        _G.IsEntityPlayingAnim = function(entity, dict, name, flag)
            if (CS_VIDEO_CALL.ACTIVE and dict == 'cellphone@' and name == 'cellphone_call_listen_base') then
                return true
            else
                return originalIsEntityPlayingAnim(entity, dict, name, flag)
            end
        end
    end

    AddEventHandler('cs-video-call:onVideoOn', function()
        -- Triggered when the player has opened the video call camera.

        if (hasAnimFns) then
            PhonePlayIn()
        end

        originalSetNuiFocusKeepInput(true) -- Allow control to pass through NUI.

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

        if (hasAnimFns) then
            if (phoneOpen) then
                if (callRejected) then
                    PhonePlayCall()
                    PhonePlayText()
                else
                    PhonePlayText()
                    PhonePlayCall()
                end
            else
                PhonePlayText()
                PhonePlayOut()
            end
        end

        originalSetNuiFocusKeepInput(lastNuiFocusKeepInputState)
    end)

    AddEventHandler('cs-video-call:onTransmissionRejectedFromExhaustion', function()
        -- Triggered when a transmission of video is rejected by the proxy server because of exhaustion (maximum active transmissions reached).
    end)

    AddEventHandler('cs-video-call:onTransmissionRejectedFromExport', function()
        -- Triggered when a transmission of video is rejected because the client cannot transmit as set by the SetCanTransmitVideo export.
    end)

    local waitingCallFn = function(data, initiator)
        if (callWaiting) then
            return
        end

        callWaiting = true
        callAccepted = false
        callRejected = false

        CS_VIDEO_CALL.SetCallState(initiator or data.transmitter_src == GetPlayerServerId(PlayerId()))
    end

    local acceptCallFn = function(data, initiator)
        if (callAccepted) then
            return
        end

        callAccepted = true
        callWaiting = false
        callRejected = false

        CS_VIDEO_CALL.SetCallState(true)
        
        if (initiator or GetPlayerServerId(PlayerId()) == data.transmitter_src) then
            CS_VIDEO_CALL.SetCallee(data.receiver_src)
        else
            CS_VIDEO_CALL.SetCallee(data.transmitter_src)
        end
    end

    local rejectCallFn = function(data, initiator)
        if (callRejected) then
            return
        end

        callRejected = true
        callAccepted = false
        callWaiting = false

        CS_VIDEO_CALL.SetCallState(false)
        CS_VIDEO_CALL.ClearCallee()
    end

    -- Trying to support a variety of phones that are based on gcphone.

    RegisterNetEvent('gcPhone:waitingCall', waitingCallFn)
    RegisterNetEvent('gcPhone:acceptCall', acceptCallFn)
    RegisterNetEvent('gcPhone:rejectCall', rejectCallFn)
    RegisterNetEvent('gksphone:waitingCall', waitingCallFn)
    RegisterNetEvent('gksphone:acceptCall', acceptCallFn)
    RegisterNetEvent('gksphone:rejectCall', rejectCallFn)
    RegisterNetEvent('gksphone:gks:waitingCall', waitingCallFn)
    RegisterNetEvent('gksphone:gksc:acceptCall', acceptCallFn)
    RegisterNetEvent('gksphone:gksc:rejectCall', rejectCallFn)
    RegisterNetEvent('gcphone:233223waitingCall', waitingCallFn)
    RegisterNetEvent('gcphone:233223233223acceptCall', acceptCallFn)
    RegisterNetEvent('gcphone:233223233223rejectCall', rejectCallFn)
    RegisterNetEvent('xenknight:waitingCall', waitingCallFn)
    RegisterNetEvent('xenknight:acceptCall', acceptCallFn)
    RegisterNetEvent('xenknight:rejectCall', rejectCallFn)

    CreateThread(function()
        CS_VIDEO_CALL.SetKeyLabels(true) -- Setting this to true will label all the buttons with their respective keys.
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
