-- will return true / false if player is looking at TV
function IsPlayerLookingAtTV()
    return IsLookingAtTV
end

-- will return true / false if player is in TV menu
function IsPlayerInTVMenu()
    return ViewingTvMenu
end

-- will return type of redirect from URL
--- @param URL string
function GetRedirectFromURL(URL)
    for key, value in pairs(Config.CustomSupport) do
        if string.match(URL, key) then
            return value
        end
    end
    return RedirectType.OTHER
end

-- will return true/false if hash is in config
--- @param hash int
function IsModelTelevision(hash)
    return Config.resolution[hash] ~= nil
end

--- Will display help notification
--- @param msg string
--- @param thisFrame boolean
--- @param beep boolean
--- @param duration int
function ShowHelpNotification(msg, thisFrame, beep, duration)
    AddTextEntry('rcore_Tv_help_msg', msg)

    if thisFrame then
        DisplayHelpTextThisFrame('rcore_Tv_help_msg', false)
    else
        if beep == nil then
            beep = false
        end
        BeginTextCommandDisplayHelp('rcore_Tv_help_msg')
        EndTextCommandDisplayHelp(0, false, beep, duration)
    end
end

--- Formated help text to prevent dup code anywhere i need to call it.
--- @param time int
function displayHelp(time)
    local text = _U("help")
    text = text .. _U("tv_help_line_2")
    text = text .. _U("tv_help_line_3")
    text = text .. _U("tv_help_line_4")
    text = text .. _U("tv_help_line_5")
    text = text .. _U("tv_help_line_6")
    if not Config.CustomNotification then
        ShowHelpNotification(text, false, false, time)
    else
        if type(Config.CustomNotification) == "function" then
            Config.CustomNotification(text)
        end
    end
end

--- Will register key action
--- @param fc function
--- @param uniqid string
--- @param description string
--- @param key string
--- @param inputDevice string
function RegisterKey(fc, uniqid, description, key, inputDevice)
    if inputDevice == nil then
        inputDevice = "keyboard"
    end
    RegisterCommand(uniqid .. key, fc, false)
    RegisterKeyMapping(uniqid .. key, description, inputDevice, key)
end

--- Will send a print when debug is enabled
--- @param ... object
function Debug(...)
    if Config.Debug then
        print(...)
    end
end

--- Will send a print when debug is enabled
--- @param ... object
function MegaDebug(...)
    if Config.FunctionsDebug then
        print("[Mega Debug]", ...)
    end
end