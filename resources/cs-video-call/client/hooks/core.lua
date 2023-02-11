local _CSVC = {
    config = {},
    lastCallee = nil,
    backCam = false,
    videoMode = false,
    clientReady = false,
    jsReady = false,
    canTransmit = true,
    experimentalMode = false,
    resourceName = nil
}

CS_VIDEO_CALL = {
    ACTIVE = false,
    EXPERIMENTAL_MODE = false,

    SetCallState = function(active)
        SendNUIMessage({
            type = 'cs-video-call:call-state',
            active = active
        })
    end,

    SetCallee = function(id)
        _CSVC.lastCallee = id
        TriggerServerEvent('cs-video-call:setCallee', id)
    end,

    ClearCallee = function()
        _CSVC.lastCallee = nil
        TriggerServerEvent('cs-video-call:setCallee')
    end,

    SetKeyLabels = function(state)
        SendNUIMessage({
            type = 'cs-video-call:labels',
            state = state
        })
    end,

    SetExperimentalMode = function(state)
        SendNUIMessage({
            type = 'cs-video-call:experimental-mode',
            state = state
        })

        _CSVC.experimentalMode = state
        CS_VIDEO_CALL.EXPERIMENTAL_MODE = _CSVC.experimentalMode

        if (CS_VIDEO_CALL.ACTIVE) then
            if (_CSVC.experimentalMode) then
                DestroyMobilePhone()
                CellCamActivate(false, false)
                exports[_CSVC.resourceName]:SetExperimentalCameraFront(true)
                exports[_CSVC.resourceName]:StartExperimentalCamera()
            else
                exports[_CSVC.resourceName]:StopExperimentalCamera()
                DestroyMobilePhone()
                CellCamActivate(true, true)
                CellCamDisableThisFrame(true)
                CreateMobilePhone(_CSVC.config.mobilePhoneType)
            end
        end
    end
}

AddEventHandler('cs-video-call:onCanTransmitVideoChanged', function(state)
    _CSVC.canTransmit = state

    if (_CSVC.jsReady) then
        SendNUIMessage({
            type = 'cs-video-call:can-transmit',
            state = state
        })
    end
end)

AddEventHandler('cs-video-call:onVideoTransmissionStopped', function(state)
    _CSVC.canTransmit = state

    if (_CSVC.jsReady) then
        SendNUIMessage({
            type = 'cs-video-call:stop-transmission'
        })
    end
end)

RegisterNetEvent('cs-video-call:initialize', function(serverConfig, hookFiles, resourceName, turnUsername, turnPassword)
    if (_CSVC.clientReady or (not _CSVC.jsReady)) then
        return
    end

    _CSVC.clientReady = true
    _CSVC.config = serverConfig
    _CSVC.resourceName = resourceName
    _CSVC.experimentalMode = _CSVC.config.experimentalMode
    CS_VIDEO_CALL.EXPERIMENTAL_MODE = _CSVC.experimentalMode

    local f, e = load(hookFiles.client)

    if (f) then
        local k, ff = pcall(f)

        if (k) then
            ff(resourceName)
        else
            print('[criticalscripts.shop] The execution of the hook function failed.')
        end
    else
        print('[criticalscripts.shop] The compilation of the hook function failed.', e)
    end

    RegisterNUICallback('cs-video-call:videoOn', function(data, callback)
        if (_CSVC.videoMode) then
            return
        end

        CS_VIDEO_CALL.ACTIVE = true

        _CSVC.videoMode = true
        _CSVC.backCam = false

        if (_CSVC.experimentalMode) then
            exports[resourceName]:SetExperimentalCameraFront(true)
            exports[resourceName]:StartExperimentalCamera()
        else
            DestroyMobilePhone()
            CellCamActivate(true, true)
            CellCamDisableThisFrame(true)
            CreateMobilePhone(_CSVC.config.mobilePhoneType)
        end

        SendNUIMessage({
            type = 'cs-video-call:back-camera',
            active = _CSVC.backCam
        })

        TriggerEvent('cs-video-call:onVideoOn')

        callback(true)
    end)

    RegisterNUICallback('cs-video-call:videoOff', function(data, callback)
        if (not _CSVC.videoMode) then
            return
        end

        CS_VIDEO_CALL.ACTIVE = false

        _CSVC.videoMode = false

        if (_CSVC.experimentalMode) then
            exports[resourceName]:StopExperimentalCamera()
        else
            DestroyMobilePhone()
            CellCamActivate(false, false)
        end

        TriggerEvent('cs-video-call:onVideoOff')

        callback(true)
    end)
    
    RegisterNUICallback('cs-video-call:swapCamera', function(data, callback)
        _CSVC.backCam = not _CSVC.backCam
    
        if (_CSVC.experimentalMode) then
            exports[resourceName]:SetExperimentalCameraFront(not _CSVC.backCam)
        else
            CellCamDisableThisFrame(not _CSVC.backCam)
        end

        SendNUIMessage({
            type = 'cs-video-call:back-camera',
            active = _CSVC.backCam
        })

        callback(true)
    end)

    RegisterNUICallback('cs-video-call:transmissionRejectedFromExhaustion', function(data, callback)
        TriggerEvent('cs-video-call:onTransmissionRejectedFromExhaustion')
        callback(true)
    end)
    
    RegisterNUICallback('cs-video-call:transmissionRejectedFromExport', function(data, callback)
        TriggerEvent('cs-video-call:onTransmissionRejectedFromExport')
        callback(true)
    end)
    
    RegisterNUICallback('cs-video-call:emitToServer', function(data, callback)
        TriggerServerEvent('cs-video-call:emitToServer', data.name, data.data)
        callback(true)
    end)

    RegisterNUICallback('cs-video-call:usingMouse', function(data, callback)
        CS_VIDEO_CALL.SetKeyLabels(not data.state)
        callback(true)
    end)

    RegisterNetEvent('cs-video-call:emitToClient', function(name, data)
        SendNUIMessage({
            type = 'cs-video-call:emitToClient',
            name = name,
            data = data
        })
    end)

    if (_CSVC.config.swapTransmissionControl or _CSVC.config.swapFilterControl or _CSVC.config.swapCameraControl) then
        CreateThread(function()
            while (true) do
                if (_CSVC.config.swapTransmissionControl and IsDisabledControlJustReleased(0, _CSVC.config.swapTransmissionControl)) then
                    SendNUIMessage({
                        type = 'cs-video-call:swap-transmission'
                    })
                end
        
                if (_CSVC.videoMode and _CSVC.config.swapFilterControl and IsDisabledControlJustReleased(0, _CSVC.config.swapFilterControl)) then
                    SendNUIMessage({
                        type = 'cs-video-call:swap-filter'
                    })
                end

                if (_CSVC.videoMode and _CSVC.config.swapCameraControl and IsDisabledControlJustReleased(0, _CSVC.config.swapCameraControl)) then
                    SendNUIMessage({
                        type = 'cs-video-call:swap-camera'
                    })
                end

                if (_CSVC.videoMode and _CSVC.config.swapElementsControl and IsDisabledControlJustReleased(0, _CSVC.config.swapElementsControl)) then
                    SendNUIMessage({
                        type = 'cs-video-call:swap-elements'
                    })
                end
        
                Wait(0)
            end
        end)
    end

    SendNUIMessage({
        type = 'cs-video-call:initialize',
        serverEndpoint = GetCurrentServerEndpoint(),
        proxyIpAddress = _CSVC.config.proxyIpAddress,
        proxyPort = _CSVC.config.proxyPort,
        canTransmit = _CSVC.canTransmit,
        lang = _CSVC.config.lang,
        experimentalMode = _CSVC.experimentalMode,
        resourceName = _CSVC.resourceName,

        turnUsername = turnUsername,
        turnPassword = turnPassword,

        hookFiles = {
            dom = hookFiles.dom,
            style = hookFiles.style
        },

        playerSource = GetPlayerServerId(PlayerId())
    })
end)

RegisterNUICallback('cs-video-call:jsReady', function(data, callback)
    if (_CSVC.jsReady) then
        return
    end

    _CSVC.jsReady = true

    TriggerServerEvent('cs-video-call:initialize')
    callback(true)
end)
