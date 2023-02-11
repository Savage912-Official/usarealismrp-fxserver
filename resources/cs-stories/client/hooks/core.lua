local _CSS = {
    config = {},
    backCam = false,
    videoMode = false,
    clientReady = false,
    jsReady = false,
    handleRightClickAsBack = false,
    experimentalMode = false,
    resourceName = nil,

    keys = {
        {
            control = 22,
            code = 'spacebar'
        },
    
        {
            control = 25,
            code = 'rightClick'
        },
    
        {
            control = 172,
            code = 'arrowUp'
        },
    
        {
            control = 173,
            code = 'arrowDown'
        },
    
        {
            control = 178,
            code = 'delete'
        },
    
        {
            control = 191,
            code = 'enter'
        },
    
        {
            control = 194,
            code = 'backspace'
        }
    }
}

CS_STORIES = {
    ACTIVE = false,
    EXPERIMENTAL_MODE = false,

    SetHandleRightClickAsBack = function(state)
        _CSS.handleRightClickAsBack = state
    end,

    SetKeyLabels = function(state)
        SendNUIMessage({
            type = 'cs-stories:labels',
            state = state
        })
    end,

    Close = function()
        SendNUIMessage({
            type = 'cs-stories:close'
        })
    end,

    SetExperimentalMode = function(state)
        SendNUIMessage({
            type = 'cs-stories:experimental-mode',
            state = state
        })

        _CSS.experimentalMode = state
        CS_STORIES.EXPERIMENTAL_MODE = _CSS.experimentalMode

        if (CS_STORIES.ACTIVE) then
            if (_CSS.experimentalMode) then
                DestroyMobilePhone()
                CellCamActivate(false, false)
                exports[_CSS.resourceName]:SetExperimentalCameraFront(true)
                exports[_CSS.resourceName]:StartExperimentalCamera()
            else
                exports[_CSS.resourceName]:StopExperimentalCamera()
                DestroyMobilePhone()
                CellCamActivate(true, true)
                CellCamDisableThisFrame(true)
                CreateMobilePhone(_CSS.config.mobilePhoneType)
            end
        end
    end
}

RegisterNetEvent('cs-stories:initialize', function(serverConfig, hookFiles, resourceName, accessKey, playerLicense, entries)
    if (_CSS.clientReady or (not _CSS.jsReady)) then
        return
    end

    _CSS.clientReady = true
    _CSS.config = serverConfig
    _CSS.resourceName = resourceName
    _CSS.experimentalMode = _CSS.config.experimentalMode
    CS_STORIES.EXPERIMENTAL_MODE = _CSS.experimentalMode

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

    local baseUrl = 'http://' .. string.match(GetCurrentServerEndpoint(), '(.-):') .. ':' .. serverConfig.hostingServerPort

    if (serverConfig.hostingServerUrl) then
        baseUrl = serverConfig.hostingServerUrl
    end

    if (baseUrl:sub(-1) ~= '/') then
        baseUrl = baseUrl .. '/'
    end

    local function ParseStoryEntry(entry)
        local coords = entry.location

        if (not coords) then
            entry.location = _CSS.config.lang.unknownLocation
        else
            entry.location = CS_STORIES.GetStoryLocationName and CS_STORIES.GetStoryLocationName(coords) or _CSS.config.lang.unknownLocation
        end

        entry.timestamp = entry.timestamp * 1000
        entry.deletable = _CSS.config.allowSelfDelete and entry.license == playerLicense
        entry.thumbnail = baseUrl .. 'thumbnail/' .. entry.uuid .. '.jpg'
        entry.license = nil

        return entry
    end

    RegisterNUICallback('cs-stories:videoOn', function(data, callback)
        if (_CSS.videoMode) then
            return
        end

        CS_STORIES.ACTIVE = true

        _CSS.videoMode = true
        _CSS.backCam = false

        if (_CSS.experimentalMode) then
            exports[resourceName]:SetExperimentalCameraFront(true)
            exports[resourceName]:StartExperimentalCamera()
        else
            DestroyMobilePhone()
            CellCamActivate(true, true)
            CellCamDisableThisFrame(true)
            CreateMobilePhone(_CSS.config.mobilePhoneType)
        end

        SendNUIMessage({
            type = 'cs-stories:back-camera',
            active = _CSS.backCam
        })

        TriggerEvent('cs-stories:onVideoOn')

        callback(true)
    end)

    RegisterNUICallback('cs-stories:videoOff', function(data, callback)
        if (not _CSS.videoMode) then
            return
        end

        CS_STORIES.ACTIVE = false

        _CSS.videoMode = false

        if (_CSS.experimentalMode) then
            exports[resourceName]:StopExperimentalCamera()
        else
            DestroyMobilePhone()
            CellCamActivate(false, false)
        end

        TriggerEvent('cs-stories:onVideoOff')

        callback(true)
    end)
    
    RegisterNUICallback('cs-stories:swapCamera', function(data, callback)
        _CSS.backCam = not _CSS.backCam
    
        if (_CSS.experimentalMode) then
            exports[resourceName]:SetExperimentalCameraFront(not _CSS.backCam)
        else
            CellCamDisableThisFrame(not _CSS.backCam)
        end

        SendNUIMessage({
            type = 'cs-stories:back-camera',
            active = _CSS.backCam
        })

        callback(true)
    end)

    RegisterNUICallback('cs-stories:storyPreUpload', function(data, callback)
        local coords = GetEntityCoords(PlayerPedId())
        TriggerServerEvent('cs-stories:storyPreUpload', CS_STORIES.GetStoryLocationName and CS_STORIES.GetStoryLocationName(coords) or _CSS.config.lang.unknownLocation)
        callback(true)
    end)

    RegisterNUICallback('cs-stories:storyUpload', function(data, callback)
        TriggerServerEvent('cs-stories:storyUpload', data.uuid)
        callback(true)
    end)

    RegisterNUICallback('cs-stories:storyUploadFailed', function(data, callback)
        TriggerEvent('cs-stories:onStoryUploadFailed')
        TriggerServerEvent('cs-stories:storyUploadFailed')
        callback(true)
    end)

    RegisterNUICallback('cs-stories:delete', function(data, callback)
        TriggerServerEvent('cs-stories:deleteStory', data.tempId)
        callback(true)
    end)

    RegisterNUICallback('cs-stories:usingMouse', function(data, callback)
        CS_STORIES.SetKeyLabels(not data.state)
        callback(true)
    end)

    CreateThread(function()
        while (true) do
            if (_CSS.config.swapRecordingControl and IsDisabledControlJustReleased(0, _CSS.config.swapRecordingControl)) then
                SendNUIMessage({
                    type = 'cs-stories:swap-recording'
                })
            end

            if (_CSS.videoMode and _CSS.config.swapFilterControl and IsDisabledControlJustReleased(0, _CSS.config.swapFilterControl)) then
                SendNUIMessage({
                    type = 'cs-stories:swap-filter'
                })
            end

            if (_CSS.videoMode and _CSS.config.swapCameraControl and IsDisabledControlJustReleased(0, _CSS.config.swapCameraControl)) then
                SendNUIMessage({
                    type = 'cs-stories:swap-camera'
                })
            end

            for i = 1, #_CSS.keys do
                if (IsDisabledControlJustReleased(0, _CSS.keys[i].control)) then
                    if (_CSS.keys[i].code ~= 'rightClick' or _CSS.handleRightClickAsBack) then
                        SendNUIMessage({
                            type = 'cs-stories:key',
                            code = _CSS.keys[i].code
                        })
                    end
                end
            end

            Wait(0)
        end
    end)

    for i = 1, #entries do
        entries[i] = ParseStoryEntry(entries[i])
    end

    SendNUIMessage({
        type = 'cs-stories:initialize',

        hookFiles = {
            dom = hookFiles.dom,
            style = hookFiles.style
        },

        resourceName = resourceName,
        accessKey = accessKey,
        baseUrl = baseUrl,
        homeLimit = _CSS.config.homeLimit,
        maxDuration = _CSS.config.maxDuration,
        lang = _CSS.config.lang,
        experimentalMode = _CSS.experimentalMode,
        entries = entries
    })

    RegisterNetEvent('cs-stories:new', function(entry)
        local parsed = ParseStoryEntry(entry)

        TriggerEvent('cs-stories:onStoryAdded', parsed)

        SendNUIMessage({
            type = 'cs-stories:new',
            entry = parsed
        })
    end)

    RegisterNetEvent('cs-stories:update', function(accessKey)
        SendNUIMessage({
            type = 'cs-stories:update',
            accessKey = accessKey
        })
    end)

    RegisterNetEvent('cs-stories:storyPreUploadReady', function()
        SendNUIMessage({
            type = 'cs-stories:ready'
        })
    end)

    RegisterNetEvent('cs-stories:delete', function(entry)
        local parsed = ParseStoryEntry(entry)

        TriggerEvent('cs-stories:onStoryDeleted', parsed)

        SendNUIMessage({
            type = 'cs-stories:delete',
            entry = parsed
        })
    end)

    RegisterNetEvent('cs-stories:deleteStoryOutcome', function(tempId, outcome)
        TriggerEvent('cs-stories:onStoryDeleteOutcome', tempId, outcome)
    end)
end)

RegisterNUICallback('cs-stories:jsReady', function(data, callback)
    if (_CSS.jsReady) then
        return
    end

    _CSS.jsReady = true

    TriggerServerEvent('cs-stories:initialize')
    callback(true)
end)
