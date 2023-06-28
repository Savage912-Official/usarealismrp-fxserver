
local location = false
local attach = false
local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

Vank17a['functions'] = {
    OpenNui = function(bool)
        display = bool
        SetNuiFocus(bool, bool)
        SendNUIMessage({
            type = "ui",
            status = bool
        })
    end,
}