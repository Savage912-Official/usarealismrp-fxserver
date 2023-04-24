local pma = exports["pma-voice"]
local mumble = exports["mumble-voip"]
local toko = exports["tokovoip_script"]

function AddToCall(callId)
    if Config.Voice.System == "pma" then
        pma:addPlayerToCall(callId)
    elseif Config.Voice.System == "mumble" then
        mumble:addPlayerToCall(callId)
    elseif Config.Voice.System == "salty" then
        TriggerServerEvent("phone:voice:addToCall", callId)
    elseif Config.Voice.System == "toko" then
        toko:addPlayerToRadio(callId)
    end
end

function RemoveFromCall(callId)
    if Config.Voice.System == "pma" then
        pma:removePlayerFromCall()
    elseif Config.Voice.System == "mumble" then
        mumble:removePlayerFromCall()
    elseif Config.Voice.System == "salty" then
        TriggerServerEvent("phone:voice:removeFromCall", callId)
    elseif Config.Voice.System == "toko" then
        toko:removePlayerFromRadio(callId)
    end
end

function ToggleSpeaker(enabled)
    if Config.Voice.System == "salty" then
        TriggerServerEvent("phone:voice:toggleSpeaker", enabled)
    end
end

local MumbleIsPlayerTalking = MumbleIsPlayerTalking
local NetworkIsPlayerTalking = NetworkIsPlayerTalking
function IsTalking()
    if Config.Voice.System == "pma" or Config.Voice.System == "mumble" then
        return MumbleIsPlayerTalking(PlayerId())
    else
        return NetworkIsPlayerTalking(PlayerId())
    end
end

-- This thread is used to send the talking state to the frontend, used to record audio only when talking in-game
CreateThread(function()
    local talking = false

    RegisterNUICallback("isTalking", function(_, cb)
        cb(IsTalking())
    end)

    while true do
        Wait(100)

        if IsTalking() and not talking then
            talking = true
            SendReactMessage("camera:toggleMicrophone", talking)
        elseif not IsTalking() and talking then
            talking = false
            SendReactMessage("camera:toggleMicrophone", talking)
        end
    end
end)

-- proximity
RegisterNetEvent("phone:phone:addVoiceTarget", function(source, audio)
    if type(source) ~= "table" then
        source = {source}
    end

    for i = 1, #source do
        local id = source[i]
        MumbleAddVoiceTargetPlayerByServerId(1, id)
        MumbleSetVolumeOverrideByServerId(id, audio and 1.0 or -1.0)
        debugprint("Added voice target", id)
    end
end)

RegisterNetEvent("phone:phone:removeVoiceTarget", function(source)
    if type(source) ~= "table" then
        source = {source}
    end

    for i = 1, #source do
        local id = source[i]
        MumbleRemoveVoiceTargetPlayerByServerId(1, id)
        MumbleSetVolumeOverrideByServerId(id, -1.0)
    end
end)

-- instagram proximity
RegisterNetEvent("phone:instagram:enteredProximity", function(source, liveHost)
    if liveHost ~= watchingSource then
        return
    end

    local player = GetPlayerFromServerId(source)
    if player and player ~= -1 and #(GetEntityCoords(GetPlayerPed(player)) - GetEntityCoords(PlayerPedId())) <= 15 then
        return
    end

    debugprint("Adding live target", source)
    MumbleAddVoiceTargetPlayerByServerId(1, source)
    MumbleSetVolumeOverrideByServerId(source, 0.7)
end)

RegisterNetEvent("phone:instagram:leftProximity", function(source, liveHost)
    if liveHost ~= watchingSource then
        return
    end

    MumbleSetVolumeOverrideByServerId(source, -1.0)
end)