function CanVehicleUseDriftTires(vehicle)
    -- Blacklist
    local blacklist = Config.blacklist
    
    if blacklist.vehiclesEnabled then
        if ContainsVehicleModel(blacklist.vehicles, GetEntityModel(vehicle)) then
            return false
        end
    end
    
    if blacklist.classesEnabled then
        if Contains(blacklist.classes, GetVehicleClass(vehicle)) then
            return false
        end
    end
    
    -- Whitelist
    local whitelist = Config.whitelist
    
    if whitelist.vehiclesEnabled then
        if not ContainsVehicleModel(whitelist.vehicles, GetEntityModel(vehicle)) then
            return false
        end
    end
    
    if whitelist.classesEnabled then
        if not Contains(whitelist.classes, GetVehicleClass(vehicle)) then
            return false
        end
    end
    
    return true
end

function CanChangeTires()
    if not Config.jobWhitelist.enabled then
        return true
    end
    
    return Contains(Config.jobWhitelist.jobs, playerJob)
end

function CanUseTireShops()
    return CanChangeTires() or Config.tireShops.anyoneCanBuy
end


-- This function is responsible for showing notifications in top left
function ShowTooltip(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

-- This function is responsible for drawing all the 3d texts ('Press [E] to take off the wheel' e.g)
function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    local scale = (1 / dist) * 25
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = (scale * fov) * Config.fontScale
    SetTextScale(scaleX * scale, scaleY * scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentSubstringKeyboardDisplay(textInput)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


-- This function is responsible for creating the text shown on the bottom of the screen
function DrawMissionText(text, time)
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time or 30000, 1)
end

function PlayAnim(dict, anim, flag, duration)
    Citizen.CreateThread(function()
        RequestAnimDict(dict)
        local timeout = 0
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(50)
            timeout = timeout + 1
            if timeout > 100 then
                return
            end
        end
        TaskPlayAnim(PlayerPedId(), dict, anim, 1.5, 1.0, duration or -1, flag or 1, 0, false, false, false)
        RemoveAnimDict(dict)
    end)
end

function ContainsVehicleModel(tab, val)
    if not tab then
        return false
    end
    
    for index, value in ipairs(tab) do
        if GetHashKey(value) == val then
            return true
        end
    end
    
    return false
end
