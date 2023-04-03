-- SetEnableScuba(ped, toggle)

-- SetPedMaxTimeUnderwater(ped, value)
-- GetPlayerUnderwaterTimeRemaining
-- SetPlayerUnderwaterTimeRemaining

-- males --
-- goggles: glasses - 40
-- oxygen tank: shirt - 137
-- flippers: feet - 93

-- females --
-- goggles: glasses - 42
-- oxygen tank: shirt - 177
-- flippers: feet - 91

--SetEnableScuba(PlayerPedId(), true)
--SetPedMaxTimeUnderwater(PlayerPedId(), 1500.00)

local currentlyEnabled = false

local previousClothing = {
    components = {
        [6] = nil,
        [8] = nil
    },
    props = {
        [1] = nil
    }
}

local busy = false

RegisterNetEvent("scuba:useGear")
AddEventHandler("scuba:useGear", function()
    if not busy then
        busy = true
        local p = PlayerPedId()
        if not currentlyEnabled then
            playAnimation(10)
            SetEnableScuba(p, true)
            -- save previous clothing --
            previousClothing.components[6] = { drawable = GetPedDrawableVariation(p, 6), texture = GetPedTextureVariation(p, 6) }
            previousClothing.components[8] ={ drawable = GetPedDrawableVariation(p, 8), texture = GetPedTextureVariation(p, 8) }
            previousClothing.props[1] = { index = GetPedPropIndex(p, 1), texture = GetPedPropTextureIndex(p, 1) }
            -- give scuba gear --
            local toGive = {}
            toGive.glasses = nil
            toGive.shirt = nil
            toGive.feet = nil
            if GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` then -- male
                toGive.glasses = 40
                toGive.shirt = 144
                toGive.feet = 111
            else
                toGive.glasses = 42
                toGive.shirt = 177
                toGive.feet = 91
            end
            SetPedMaxTimeUnderwater(p, 1500.00)
            SetPedComponentVariation(p, 6, toGive.feet, 4, 1) -- flippers
            SetPedComponentVariation(p, 8, toGive.shirt, 4, 1) -- tank
            SetPedPropIndex(p, 1, toGive.glasses, 20, 1) -- mask
            currentlyEnabled = true
        else
            playAnimation(10)
            SetEnableScuba(p, false)
            SetPedMaxTimeUnderwater(p, 16.0)
            -- give back previous clothing --
            SetPedComponentVariation(p, 6, previousClothing.components[6].drawable, previousClothing.components[6].texture, 1) -- flippers
            SetPedComponentVariation(p, 8, previousClothing.components[8].drawable, previousClothing.components[8].texture, 1) -- tank
            if previousClothing.props[1].index == -1 then
                ClearPedProp(p, 1)
            else
                SetPedPropIndex(p, 1, previousClothing.props[1].index, previousClothing.props[1].texture, 1) -- mask
            end
            currentlyEnabled = false
        end
        busy = false
    end
end)

function playAnimation(durationInSeconds)

    if not HasAnimDictLoaded("anim@move_m@trash") then
        exports.globals:loadAnimDict("anim@move_m@trash")
    end

    local p = PlayerPedId()
    local start = GetGameTimer()
    while GetGameTimer() - start < durationInSeconds * 1000 do
        exports.globals:DrawTimerBar(start, durationInSeconds * 1000, 1.42, 1.475, 'Gearing up')
        if not IsEntityPlayingAnim(p, "anim@move_m@trash", "pickup", 3) then
            TaskPlayAnim(p, "anim@move_m@trash", "pickup", 8.0, 1.0, -1, 11, 1.0, false, false, false)
        end
        Wait(1)
    end
    ClearPedTasks(p)
end