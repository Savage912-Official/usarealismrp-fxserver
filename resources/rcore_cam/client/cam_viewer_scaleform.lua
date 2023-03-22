local camInstructional = nil

function RenderCamInstructional()
    if not camInstructional then
        camInstructional = setupInstructionalPlayScaleform("instructional_buttons")
    end

    DrawScaleformMovieFullscreen(camInstructional, 255, 255, 255, 255, 0)
end

function DestroyCamInstructional()
    if camInstructional then
        SetScaleformMovieAsNoLongerNeeded(camInstructional)
    end
end

function InstructionalButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function InstructionalButton(ControlButton)
    ScaleformMovieMethodAddParamPlayerNameString(ControlButton)
end

function setupInstructionalPlayScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    local keys = {
        -- Config.Control.CAM_PAUSE,
        Config.Control.CAM_BACK,
        Config.Control.CAM_PREV_CAM,
        Config.Control.CAM_NEXT_CAM,
        Config.Control.CAM_FAST_FORWARD,
        Config.Control.CAM_REWIND,
        Config.Control.CAM_PLAY,
    }

    for idx, data in ipairs(keys) do
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(idx-1)
        InstructionalButton(GetControlInstructionalButton(0, data.key, true))
        InstructionalButtonMessage(data.label)
        PopScaleformMovieFunctionVoid()
    end

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end
