parts = {
    [52301] = 'Right Foot',
    [14201] = 'Left Foot',
    [57005] = 'Right Hand',
    [18905] = 'Left Hand',
    [36864] = 'Right Knee',
    [63931] = 'Left Knee',
    [31086] = 'Head',
    [39317] = 'Neck',
    [28252] = 'Right Arm',
    [61163] = 'Left Arm',
    [24818] = 'Chest',
    [11816] = 'Pelvis',
    [40269] = 'Right Shoulder',
    [45509] = 'Left Shoulder',
    [28422] = 'Right Wrist',
    [60309] = 'Left Wrist',
    [47495] = 'Tounge',
    [20178] = 'Upper Lip',
    [17188] = 'Lower Lip',
    [51826] = 'Right Thigh',
    [58271] = 'Left Thigh',
    [23553] = 'Center Spine',
    [24816] = 'Lower Spine',
    [24817] = 'Spine',
    [24818] = 'Upper Spine',
    [57597] = 'Spine Root',
    [2108] = 'Left Toe',
    [20781] = 'Right Toe',
    [10706] = 'Right Clavicle',
    [64729] = 'Left Clavicle',
    [2992] = 'Right Elbow',
    [22711] = 'Left Elbow',
    [0] = 'Neck' -- body center mass
}

bone_effects = { -- ORDER MATTERS - each index is subject to each stage
    [52301] = {'shake', 'injuredwalk', 'norun'},
    [14201] = {'shake', 'injuredwalk', 'norun'},
    [57005] = {'shake', 'shake', 'noaim'},
    [18905] = {'shake', 'shake', 'noaim'},
    [36864] = {'shake', 'injuredwalk', 'norun'},
    [63931] = {'shake', 'injuredwalk', 'norun'},
    [31086] = {'shake', 'norun', 'noaim'},
    [39317] = {'shake', 'norun', 'noaim'},
    [28252] = {'shake', 'shake', 'noaim'},
    [61163] = {'shake', 'shake', 'noaim'},
    [24818] = {'shake', 'injuredwalk', 'norun'},
    [11816] = {'shake', 'injuredwalk', 'norun'},
    [40269] = {'shake', 'shake', 'noaim'},
    [45509] = {'shake', 'shake', 'noaim'},
    [28422] = {'shake', 'shake', 'noaim'},
    [60309] = {'shake', 'shake', 'noaim'},
    [47495] = {'shake', 'shake'},
    [20178] = {'shake', 'shake'},
    [17188] = {'shake', 'none', 'shake'},
    [51826] = {'shake', 'injuredwalk', 'norun'},
    [58271] = {'shake', 'injuredwalk', 'norun'},
    [23553] = {'shake', 'injuredwalk', 'norun'},
    [24816] = {'shake', 'injuredwalk', 'norun'},
    [24817] = {'shake', 'injuredwalk', 'norun'},
    [24818] = {'shake', 'injuredwalk', 'norun'},
    [57597] = {'shake', 'injuredwalk', 'norun'},
    [2108] = {'shake', 'injuredwalk', 'norun'},
    [20781] = {'shake', 'injuredwalk', 'norun'},
    [10706] = {'shake', 'shake', 'noaim'},
    [64729] = {'shake', 'shake', 'noaim'},
    [2992] = {'shake', 'shake', 'noaim'},
    [22711] = {'shake', 'shake', 'noaim'},
    [0] = {'shake', 'injuredwalk', 'norun'}
}

injuries = { -- ensure this is the same as sv_injury.lua
    --[GetHashKey("WEAPON_UNARMED")] = {type = 'blunt', bleed = 7200, string = 'Fists', treatableWithBandage = true, treatmentPrice = 50, dropEvidence = 0.5}, -- WEAPON_UNARMED
    [GetHashKey("WEAPON_ANIMAL")] = {type = 'laceration', bleed = 1500, string = 'Animal Attack', treatableWithBandage = true, treatmentPrice = 80, dropEvidence = 0.9}, -- WEAPON_ANIMAL
    [GetHashKey("WEAPON_COUGAR")] = {type = 'laceration', bleed = 900, string = 'Animal Attack', treatableWithBandage = false, treatmentPrice = 90, dropEvidence = 0.9}, -- WEAPON_COUGAR
    [GetHashKey("WEAPON_KNIFE")] = {type = 'laceration', bleed = 480, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 90, dropEvidence = 1.0}, -- WEAPON_KNIFE
    [GetHashKey("WEAPON_SHIV")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0}, -- WEAPON_SHIV
    [GetHashKey("WEAPON_THROWINGKNIFE")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0},
    [GetHashKey("WEAPON_NINJASTAR")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0},
    [GetHashKey("WEAPON_NINJASTAR2")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0},
    [GetHashKey("WEAPON_KATANAS")] = {type = 'laceration', bleed = 1750, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 150, dropEvidence = 1.0}, -- WEAPON_KATANA
    [GetHashKey("WEAPON_NIGHTSTICK")] = {type = 'blunt', bleed = 2400, string = 'Blunt Object', treatableWithBandage = true, treatmentPrice = 30, dropEvidence = 0.8}, -- WEAPON_NIGHTSTICK
    [GetHashKey("WEAPON_HAMMER")] = {type = 'blunt', bleed = 1200, string = 'Concentrated Blunt Object', treatableWithBandage = true, treatmentPrice = 30, dropEvidence = 0.9}, -- WEAPON_HAMMER
    [GetHashKey("WEAPON_BAT")] = {type = 'blunt', bleed = 900, string = 'Large Blunt Object', treatableWithBandage = false, treatmentPrice = 70, dropEvidence = 0.9}, -- WEAPON_BAT
    [GetHashKey("WEAPON_GOLFCLUB")] = {type = 'blunt', bleed = 1200, string = 'Large Blunt Object', treatableWithBandage = false, treatmentPrice = 10, dropEvidence = 0.6}, -- WEAPON_GOLFCLUB
    [GetHashKey("WEAPON_CROWBAR")] = {type = 'blunt', bleed = 900, string = 'Blunt Object', treatableWithBandage = false, treatmentPrice = 45, dropEvidence = 0.8}, -- WEAPON_CROWBAR
    [GetHashKey("WEAPON_MACHINEPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_APPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_PISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PISTOL
    [GetHashKey("WEAPON_COMBATPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_COMBATPISTOL
    [GetHashKey("WEAPON_CERAMICPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_CERAMICPISTOL
    [GetHashKey("WEAPON_PISTOL50")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PISTOL50
    [GetHashKey("WEAPON_GUSENBERG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_SMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_SMG
    [GetHashKey("WEAPON_SCARSC")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_COMBATPDW")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_COMBATPDW
    [GetHashKey("WEAPON_ASSAULTSMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_SMG_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_MICROSMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_MINISMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_ASSAULTRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_AKORUS")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_TACTICALRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_MILITARYRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_CARBINERIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_CARBINERIFLE
    [GetHashKey("WEAPON_PUMPSHOTGUN")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PUMPSHOTGUN
    [GetHashKey("WEAPON_SAWNOFFSHOTGUN")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_DBSHOTGUN")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_DBSHOTGUN
    [GetHashKey("WEAPON_BULLPUPSHOTGUN")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_BULLPUPSHOTGUN
    [GetHashKey("WEAPON_STUNGUN")] = {type = 'penetrating', bleed = 3600, string = 'Prongs', treatableWithBandage = true, treatmentPrice = 25, dropEvidence = 0.0}, -- WEAPON_STUNGUN
    [GetHashKey("WEAPON_SNIPERRIFLE")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_SNIPERRIFLE
    [GetHashKey("WEAPON_REMOTESNIPER")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_REMOTESNIPER
    [GetHashKey("WEAPON_GRENADE")] = {type = 'penetrating', bleed = 120, string = 'Shrapnel Wound', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_GRENADE
    [GetHashKey("WEAPON_MOLOTOV")] = {type = 'burn', bleed = 600, string = 'Molotov Residue', treatableWithBandage = false, treatmentPrice = 80, dropEvidence = 1.0}, -- WEAPON_MOLOTOV
    [GetHashKey("WEAPON_PETROLCAN")] = {type = 'burn', bleed = 600, string = 'Gasoline Residue', treatableWithBandage = false, treatmentPrice = 90, dropEvidence = 1.0}, -- WEAPON_PETROLCAN
    [GetHashKey("WEAPON_FLARE")] = {type = 'burn', bleed = 1800, string = 'Concentrated Heat', treatableWithBandage = true, treatmentPrice = 65, dropEvidence = 0.7}, -- WEAPON_FLARE
    [GetHashKey("WEAPON_EXPLOSION")] = {type = 'burn', bleed = 120, string = 'Explosion', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_EXPLOSION
    --[GetHashKey("WEAPON_FALL")] = {type = 'blunt', bleed = 2700, string = 'Fall', treatableWithBandage = true, treatmentPrice = 30, dropEvidence = 0.2}, -- WEAPON_FALL
    --[GetHashKey("WEAPON_RAMMED_BY_CAR")] = {type = 'blunt', bleed = 1800, string = 'Vehicle Accident', treatableWithBandage = true, treatmentPrice = 50, dropEvidence = 0.0}, -- WEAPON_RAMMED_BY_CAR
    --[GetHashKey("WEAPON_RUN_OVER_BY_CAR")] = {type = 'blunt', bleed = 1500, string = 'Vehicle Accident', treatableWithBandage = true, treatmentPrice = 50, dropEvidence = 0.4}, -- WEAPON_RUN_OVER_BY_CAR
    [GetHashKey("WEAPON_FIRE")] = {type = 'burn', bleed = 600, string = 'Fire', treatableWithBandage = false, treatmentPrice = 50, dropEvidence = 1.0}, -- WEAPON_FIRE
    [GetHashKey("WEAPON_SNSPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_SNSPISTOL
    [GetHashKey("WEAPON_SNSPISTOL_MK2")] = {type = 'penetrating', bleed = 310, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_SNSPISTOL_MK2
    [GetHashKey("WEAPON_BOTTLE")] = {type = 'laceration', bleed = 600, string = 'Sharp Glass', treatableWithBandage = false, treatmentPrice = 40, dropEvidence = 1.0}, -- WEAPON_BOTTLE
    [GetHashKey("WEAPON_HEAVYPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_HEAVYPISTOL
    [GetHashKey("WEAPON_DAGGER")] = {type = 'laceration', bleed = 480, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 90, dropEvidence = 1.0}, -- WEAPON_DAGGER
    [GetHashKey("WEAPON_VINTAGEPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_VINTAGEPISTOL
    [GetHashKey("WEAPON_MUSKET")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_MUSKET
    [GetHashKey("WEAPON_MARKSMANRIFLE")] = {type = 'penetrating', bleed = 240, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_MARKSMANRIFLE
    [GetHashKey("WEAPON_FLAREGUN")] = {type = 'burn', bleed = 1200, string = 'Concentrated Heat', treatableWithBandage = true, treatmentPrice = 80, dropEvidence = 1.0}, -- WEAPON_FLAREGUN
    [GetHashKey("WEAPON_MARKSMANPISTOL")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_MARKSMANPISTOL
    [GetHashKey("WEAPON_KNUCKLE")] = {type = 'blunt', bleed = 1200, string = 'Blunt Object', treatableWithBandage = true, treatmentPrice = 70, dropEvidence = 1.0}, -- WEAPON_KNUCKLE
    [GetHashKey("WEAPON_HATCHET")] = {type = 'laceration', bleed = 360, string = 'Large Sharp Object', treatableWithBandage = false, treatmentPrice = 300, dropEvidence = 1.0}, -- WEAPON_HATCHET
    [GetHashKey("WEAPON_MACHETE")] = {type = 'laceration', bleed = 360, string = 'Large Sharp Object', treatableWithBandage = false, treatmentPrice = 300, dropEvidence = 1.0}, -- WEAPON_MACHETE
    [GetHashKey("WEAPON_SWITCHBLADE")] = {type = 'laceration', bleed = 480, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 70, dropEvidence = 1.0}, -- WEAPON_SWITCHBLADE
    [GetHashKey("WEAPON_REVOLVER")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_REVOLVER
    [GetHashKey("WEAPON_REVOLVERULTRA")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
    [GetHashKey("WEAPON_NAVYREVOLVER")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_NAVYREVOLVER
    [GetHashKey("WEAPON_DOUBLEACTION")] = {type = 'penetrating', bleed = 120, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_DOUBLEACTION
    [GetHashKey("WEAPON_REVOLVER_MK2")] = {type = 'penetrating', bleed = 125, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_REVOLVER_MK2
    [GetHashKey("WEAPON_BATTLEAXE")] = {type = 'laceration', bleed = 240, string = 'Large Sharp Object', treatableWithBandage = false, treatmentPrice = 300, dropEvidence = 1.0}, -- WEAPON_BATTLEAXE
    [GetHashKey("WEAPON_POOLCUE")] = {type = 'blunt', bleed = 1800, string = 'Large Blunt Object', treatableWithBandage = false, treatmentPrice = 65, dropEvidence = 1.0}, -- WEAPON_POOLCUE
    [GetHashKey("WEAPON_WRENCH")] = {type = 'blunt', bleed = 900, string = 'Concentrated Blunt Object', treatableWithBandage = false, treatmentPrice = 80, dropEvidence = 1.0}, -- WEAPON_WRENCH
    [GetHashKey("WEAPON_FLASHLIGHT")] = {type = 'blunt', bleed = 2700, string = 'Blunt Object', treatableWithBandage = true, treatmentPrice = 40, dropEvidence = 0.6}, -- WEAPON_FLASHLIGHT
    [GetHashKey("WEAPON_PISTOL_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PISTOL_MK2
    [GetHashKey("WEAPON_CARBINERIFLE_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_CARBINERIFLE_MK2
    [GetHashKey("WEAPON_PUMPSHOTGUN_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PUMPSHOTGUN_MK2
    [GetHashKey("WEAPON_ASSAULTRIFLE_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, 
    [GetHashKey("WEAPON_COMPACTRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_COMPACTRIFLE
    [GetHashKey("WEAPON_M4GOLDBEAST")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
}

hospitalLocations = {
    {307.10046386719, -595.07073974609, 43.284019470215}, -- upper PB
    {350.97692871094, -587.77874755859, 28.796844482422}, -- lower PB
    {-817.61511230469, -1236.6121826172, 7.3374252319336}, -- viceroy medical
    {1782.0440673828, 2556.306640625, 45.797794342041}, -- prison
    {1832.7521, 3677.0686, 34.2749}, -- sandy
    {-251.8987, 6334.1558, 32.4272} -- Paleto Clinic
}


effects = {} -- when you take damage for a specific reason, you may be put into an effect
injuredParts = {} -- injured body parts, and their wounds as the value

------ NOTIFY PLAYER OF INJURIES ------

RegisterNetEvent('injuries:showMyInjuries')
AddEventHandler('injuries:showMyInjuries', function()
    local hadInjury = false
    for bone, injuries in pairs(injuredParts) do
        local boneName = parts[bone]
        for injury, data in pairs(injuredParts[bone]) do
            local stage = injuredParts[bone][injury].stage
            local cause = injuredParts[bone][injury].string
            exports.globals:notify("Your " .. boneName .. " has a stage " .. stage .. " injury from a " .. cause .. ".")
            hadInjury = true
        end
    end
    if not hadInjury then 
        exports.globals:notify("You have no injuries.")
    end
end)

local isEpi = false
local epiTimer = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isEpi == true then
            local beginTime = GetGameTimer()
            while GetGameTimer() - beginTime < epiTimer * 1000 do
                -- print((GetGameTimer() - beginTime))
                Citizen.Wait(0)
            end
            if IsEntityDead(PlayerPedId()) then
                TriggerEvent('usa:notify', 'The effect of the epinephrine has worn off you fall back unconscious')
            end
            TriggerEvent("usa_death:epi", false)
            isEpi = false
            epiTimer = nil
        end
    end
end)

RegisterNetEvent("usa_injury:epi")
AddEventHandler("usa_injury:epi", function(bool)
    if bool then
        if IsEntityDead(PlayerPedId()) then
            TriggerEvent('usa:notify', 'You have been injected with epinephrine, you are temporarily conscious and can talk')
            TriggerEvent("usa_death:epi", true)
            isEpi = true
            epiTimer = 300 -- Five Minutes
        end
    else
        TriggerEvent("usa_death:epi", false)
        isEpi = false
        epiTimer = 0
    end
end)

function isConscious()
    if IsEntityDead(PlayerPedId()) and not isEpi then
        local seriousInjuries = 0
        for bone, injuries in pairs(injuredParts) do
            local boneName = parts[bone]
            for injury, data in pairs(injuredParts[bone]) do
                local injuryType = injuredParts[bone][injury].type
                local cause = injuredParts[bone][injury].string
                if injuryType == 'penetrating' or injuryType == 'laceration' or injuryType == 'burn' then
                    if boneName == 'Head' or cause == "Explosion" then
                        seriousInjuries = seriousInjuries + 3
                    else
                        seriousInjuries = seriousInjuries + 1
                    end
                end
            end
        end
        if seriousInjuries >= 3 then
            return false
        else
            return true
        end
    else
        return true
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(120000)
        NotifyPlayerOfInjuries()
    end
end)

------ DEVELOP INJURY SEVERITY & ADD EFFECTS ------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerPed = PlayerPedId()
        for bone, injuries in pairs(injuredParts) do
            for injury, data in pairs(injuredParts[bone]) do
                if data.bandagedTime <= 0 then -- wounds are not bandaged for five mins, or five mins has passed since
                    if not injuredParts[bone][injury].timer then -- start a timer of bleeding if doesn't already exist
                        injuredParts[bone][injury].timer = data.bleed
                    end
                    if injuredParts[bone][injury].timer > 0 then
                        UpdateEffects(injuredParts[bone][injury].stage, bone)
                        injuredParts[bone][injury].timer = injuredParts[bone][injury].timer - 1 -- continue decrementing timer every second
                        local secondsPerStage = math.ceil(data.bleed / 3) -- 3 stages, defines how many seconds there is per stage
                        local secondsBeforeNextStage = data.bleed - (secondsPerStage * injuredParts[bone][injury].stage)
                        if injuredParts[bone][injury].timer == secondsBeforeNextStage and injuredParts[bone][injury].stage < 3 then
                            injuredParts[bone][injury].stage = injuredParts[bone][injury].stage + 1
                            NotifyPlayerOfInjuries()
                        end
                    elseif not IsEntityDead(playerPed) then
                        if not GetScreenEffectIsActive('Rampage') then
                            StartScreenEffect('Rampage', 0, true)
                            exports.globals:Draw3DTextForOthers("is losing a severe amount of blood")
                        end
                        if math.random() > 0.6 then
                            ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.1)
                        end
                        TriggerEvent('usa:notify', 'Your body feels cold with blood...')
                        local playerHealth = GetEntityHealth(playerPed)
                        SetEntityHealth(playerPed, ((playerHealth) - 3))
                        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
                    elseif IsEntityDead(playerPed) then
                        StopScreenEffect('Rampage')
                    end
                end
            end
        end
    end
end)

------ PLAYER EFFECTS ------
Citizen.CreateThread(function()
    local injuredWalk = false
    while true do
        Citizen.Wait(10)
        for effect, enabled in pairs(effects) do
            if effect == 'shake' then
                if math.random() > 0.999 and not IsEntityDead(PlayerPedId()) then
                    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.1)
                end
            elseif effect == 'noaim' then
                DisableControlAction(0, 25, true)
            elseif effect == 'injuredwalk' then
                TriggerEvent('civ:forceWalkStyle', "move_injured_generic")
                DisableControlAction(0, 21, true)
                DisableControlAction(0, 22, true)
            end
        end
    end
end)

------ LISTENING FOR DAMAGE ------

local lastDamage = 0
RegisterNetEvent('DamageEvents:EntityDamaged')
AddEventHandler('DamageEvents:EntityDamaged', function(entity, attacker, weaponHash, isMeleeDamage, boneOverride)
    if GetGameTimer() - lastDamage > 2000 and entity == PlayerPedId() then
        if GetGameTimer() - lastDamage > 8000 then
            if injuries[weaponHash] then
                if injuries[weaponHash].dropEvidence then
                    if math.random() < injuries[weaponHash].dropEvidence then
                        TriggerServerEvent('evidence:newDNA', GetEntityCoords(PlayerPedId()))
                    end
                else
                    TriggerServerEvent('evidence:newDNA', GetEntityCoords(PlayerPedId()))
                end
            end
        end
        lastDamage = GetGameTimer()
        local playerPed = PlayerPedId()
        local _, damagedBone = GetPedLastDamageBone(playerPed)
        if boneOverride then
            damagedBone = boneOverride
        end
        for hash, name in pairs(parts) do
            if hash == damagedBone then
                ApplyPedBlood(playerPed, GetPedBoneIndex(playerPed, damagedBone), 0.0, 0.0, 0.0, "wound_sheet")
                if type(injuredParts[damagedBone]) ~= 'table' then
                    injuredParts[damagedBone] = {}
                end
                if type(injuredParts[damagedBone][weaponHash]) ~= 'table' then
                    --print(weaponHash .. ' has damaged '.. damagedBone)
					if injuries[weaponHash] then
						injuredParts[damagedBone][weaponHash] = {
							type = injuries[weaponHash].type,
							bleed = injuries[weaponHash].bleed,
							string = injuries[weaponHash].string,
							treatableWithBandage = injuries[weaponHash].treatableWithBandage,
							treatmentPrice = injuries[weaponHash].treatmentPrice,
							stage = 1, -- add the stage to the injury
							bandagedTime = 0 -- add when the injury was last bandaged
						}
						--print('added injuredParts['.. damagedBone..']['..weaponHash..']')
						TriggerServerEvent('injuries:saveData', injuredParts)
						Citizen.Wait(2000)
						NotifyPlayerOfInjuries()
					end
                end
                return
            end
        end
        print('INJURIES: Add me to injury bone list: ' ..damagedBone)
    end
end)

RegisterNetEvent('DamageEvents:PedDied')
AddEventHandler('DamageEvents:PedDied', function(entity, attacker, weaponHash, isMeleeDamage)
    RegisterInjuries(entity, weaponHash)
end)

RegisterNetEvent('DamageEvents:PedKilledByPlayer')
AddEventHandler('DamageEvents:PedKilledByPlayer', function(entity, attacker, weaponHash, isMeleeDamage)
    if entity == PlayerPedId() then
      if injuries[weaponHash] then
        if injuries[weaponHash].dropEvidence then
            if injuries[weaponHash].dropEvidence > 0.0 and entity == PlayerPedId() then
                TriggerServerEvent('evidence:newDNA', GetEntityCoords(PlayerPedId()))
            end
            RegisterInjuries(entity, weaponHash)
        else
            TriggerServerEvent('evidence:newDNA', GetEntityCoords(PlayerPedId()))
        end
      end
    end
end)

RegisterNetEvent('DamageEvents:PedKilledByVehicle')
AddEventHandler('DamageEvents:PedKilledByVehicle', function(entity, attacker, weaponHash, isMeleeDamage)
    RegisterInjuries(entity, weaponHash)
end)

RegisterNetEvent('DamageEvents:PedKilledByPed')
AddEventHandler('DamageEvents:PedKilledByPed', function(entity, attacker, weaponHash, isMeleeDamage)
    RegisterInjuries(entity, weaponHash)
end)

RegisterNetEvent('injuries:triggerGrace')
AddEventHandler('injuries:triggerGrace', function(callback)
    lastDamage = GetGameTimer()
    callback()
end)

function RegisterInjuries(entity, weaponHash)
    if injuries[weaponHash] then
        if entity == PlayerPedId() then
            local playerPed = PlayerPedId()
            local _, damagedBone = GetPedLastDamageBone(playerPed)
            for hash, name in pairs(parts) do
                if hash == damagedBone then
                    ApplyPedBlood(playerPed, GetPedBoneIndex(playerPed, damagedBone), 0.0, 0.0, 0.0, "wound_sheet")
                    if type(injuredParts[damagedBone]) ~= 'table' then
                        injuredParts[damagedBone] = {}
                    end
                    if type(injuredParts[damagedBone][weaponHash]) ~= 'table' then
                        --print(weaponHash .. ' has damaged '.. damagedBone)
                        injuredParts[damagedBone][weaponHash] = {
                            type = injuries[weaponHash].type,
                            bleed = injuries[weaponHash].bleed,
                            string = injuries[weaponHash].string,
                            treatableWithBandage = injuries[weaponHash].treatableWithBandage,
                            treatmentPrice = injuries[weaponHash].treatmentPrice,
                            stage = 1, -- add the stage to the injury
                            bandagedTime = 0 -- add when the injury was last bandaged
                        }
                        --print('added injuredParts['.. damagedBone..']['..weaponHash..']')
                        TriggerServerEvent('injuries:saveData', injuredParts)
                        Citizen.Wait(2000)
                        NotifyPlayerOfInjuries()
                    end
                    return
                end
            end
            print('INJURIES: Add me to injury bone list: ' ..damagedBone)
        end
    end
end

------ INSPECTING PLAYERS ------

RegisterNetEvent('injuries:inspectNearestPed') -- get the nearest ped to inspect when command is executed
AddEventHandler('injuries:inspectNearestPed', function(playerSource)
    local playerCoords = GetEntityCoords(PlayerPedId())
    for ped in exports.globals:EnumeratePeds() do
        local pedCoords = GetEntityCoords(ped)
        if Vdist(pedCoords, playerCoords) < 3.0 and IsPedAPlayer(ped) and ped ~= PlayerPedId() then
            local pedSource = GetPlayerServerId(GetPlayerFromPed(ped))
            TriggerServerEvent('injuries:getPlayerInjuries', pedSource, playerSource)
            return
        end
    end
    TriggerEvent('usa:notify', 'No player found nearby!')
end)

RegisterNetEvent('injuries:returnInjuries') -- return the patient's injuries to the responder so they can be displayed
AddEventHandler('injuries:returnInjuries', function(sourceReturnedTo)
    local ped = PedToNet(PlayerPedId())
    TriggerServerEvent('injuries:inspectMyInjuries', sourceReturnedTo, injuredParts, ped)
end)

local displayingInjuries = false
RegisterNetEvent('injuries:displayInspectedInjuries') -- display the injuries of ped in front to person who executed command
AddEventHandler('injuries:displayInspectedInjuries', function(injuriesInspected, displayName, ped)
    TriggerEvent('chatMessage', '^6^*[INJURIES]^r^7 Inspection of '..displayName..':')
    local ped = NetToPed(ped)
    for bone, injuries in pairs(injuriesInspected) do
        local boneName = parts[bone]
        for injury, data in pairs(injuriesInspected[bone]) do
            local injuryType = ''
            local bandaged = 'an open '
            if data.type == 'blunt' then
                injuryType = 'Blunt Force Wound'
            elseif data.type == 'penetrating' then
                injuryType = 'Penetrated Wound'
            elseif data.type == 'burn' then
                injuryType = 'Burn Wound'
            elseif data.type == 'laceration' then
                injuryType = 'Laceration Wound'
            end
            if data.bandagedTime > 0 then
                bandaged = 'a bandaged '
            end
            TriggerEvent('chatMessage', ' ⠀^6^* > ^r^7 '..boneName..' has '..bandaged..''..injuryType..' at stage '.. tostring(data.stage) ..', caused by '..data.string..'.')
        end
    end

    local beginTime = GetGameTimer() -- draw 3d text of patient's injuries on the body
    if not displayingInjuries then
        displayingInjuries = true
        while GetGameTimer() - beginTime < 15000 do
            Citizen.Wait(0)
            for bone, injuries in pairs(injuriesInspected) do
                local boneName = parts[bone]
                local x, y, z = table.unpack(GetPedBoneCoords(ped, bone, 0.0, 0.0, 0.0))
                if Vdist(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped)) < 3 and not IsPedRagdoll(ped) then
                    DrawText3Ds(x, y, z, boneName)
                end
            end
        end
        displayingInjuries = false
    end
end)

------ TREATING PLAYERS ------

RegisterNetEvent('injuries:treatNearestPed') -- get the nearest ped to treat when command is executed
AddEventHandler('injuries:treatNearestPed', function(boneToTreat)
    local playerCoords = GetEntityCoords(PlayerPedId())
    for ped in exports.globals:EnumeratePeds() do
        local pedCoords = GetEntityCoords(ped)
        if Vdist(pedCoords, playerCoords) < 3.0 and IsPedAPlayer(ped) and ped ~= PlayerPedId() then
            local pedSource = GetPlayerServerId(GetPlayerFromPed(ped))
            TriggerServerEvent('injuries:treatPlayer', pedSource, boneToTreat)
            return
        end
    end
    TriggerEvent('usa:notify', 'No player found nearby!')
end)

RegisterNetEvent('injuries:treatMyInjuries') -- treat the patient's injuries when the command is executed
AddEventHandler('injuries:treatMyInjuries', function(boneToTreat, sourceTreating)
    for bone, injuries in pairs(injuredParts) do
        local boneName = parts[bone]
        if string.lower(boneName) == string.lower(boneToTreat) then
            effects = {}
            injuredParts[bone] = nil
            StopScreenEffect('Rampage')
            TriggerEvent('usa:notify', parts[bone]..' has been treated.')
            TriggerServerEvent('injuries:notify', sourceTreating, parts[bone] .. ' of patient has been treated.')
            TriggerEvent('civ:resetWalkStyle')
            TriggerServerEvent('injuries:saveData', injuredParts)
            return
        end
    end
end)

------ BANDAGING PLAYERS ------

RegisterNetEvent('injuries:bandageNearestPed') -- get the nearest ped to bandage when command is executed
AddEventHandler('injuries:bandageNearestPed', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    for ped in exports.globals:EnumeratePeds() do
        local pedCoords = GetEntityCoords(ped)
        if Vdist(pedCoords, playerCoords) < 3.0 and IsPedAPlayer(ped) and ped ~= PlayerPedId() then
            local pedSource = GetPlayerServerId(GetPlayerFromPed(ped))
            TriggerServerEvent('injuries:bandagePlayer', pedSource)
            TriggerServerEvent('display:shareDisplay', 'bandages person', 2, 370, 10, 3000)
            return
        end
    end
    TriggerEvent('usa:notify', 'No player found nearby!')
end)

RegisterNetEvent('injuries:bandageMyInjuries') -- temporarily stop bleeding & treat some injuries
AddEventHandler('injuries:bandageMyInjuries', function()
    local injuriesBandaged = false
    TriggerEvent('civ:resetWalkStyle')
    for bone, injuries in pairs(injuredParts) do
        for injury, data in pairs(injuredParts[bone]) do
            if data.treatableWithBandage then -- if treatable with bandage, treat injury for each treatable bone
                if table.getIndex(injuredParts[bone]) > 1 then
                    injuredParts[bone][injury] = nil
                else
                    injuredParts[bone] = nil
                end
                effects = {}
                StopScreenEffect('Rampage')
                TriggerEvent('usa:notify', 'Some of your injuries have been treated with a bandage.')
                TriggerServerEvent('injuries:saveData', injuredParts)
            else -- if the wound is not treatable with just a bandage, prevent it from bleeding for a few mins
                injuredParts[bone][injury].bandagedTime = 300
                injuriesBandaged = true
            end
        end
    end
    if injuriesBandaged then
        TriggerEvent('usa:showHelp', true, 'Some of your injuries have been temporarily bandaged.')
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for bone, injuries in pairs(injuredParts) do
            for injury, data in pairs(injuredParts[bone]) do
                if injuredParts[bone][injury].bandagedTime > 0 then
                    if not exports["usa_stretcher"]:IsInStretcher() then
                        injuredParts[bone][injury].bandagedTime = injuredParts[bone][injury].bandagedTime - 1
                    end
                end
            end
        end
    end
end)

------ CHECK-IN HOSPITAL AND DOCTOR JOB ------

local BASE_CHECKIN_PRICE = 25

Citizen.CreateThread(function()
    local checkingIn = false
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for i = 1, #hospitalLocations do
            local x, y, z = table.unpack(hospitalLocations[i])
            if Vdist(playerCoords, x, y, z) < 10 then
                local totalPrice = BASE_CHECKIN_PRICE
                for bone, injuries in pairs(injuredParts) do
                    for injury, data in pairs(injuredParts[bone]) do
                        totalPrice = totalPrice + data.treatmentPrice
                    end
                end
                DrawText3Ds(x, y, z, '[E] - Check In (~g~$'..totalPrice..'~s~)')
                if IsControlJustPressed(0, 38) and Vdist(playerCoords, x, y, z) < 1.5 and not checkingIn then
                    PlayDoorAnimation()
                    checkingIn = true
                    local beginTime = GetGameTimer()
                    while GetGameTimer() - beginTime < 3000 do
                        Citizen.Wait(0)
                        DrawTimer(beginTime, 3000, 1.42, 1.475, 'CHECKING IN')
                    end
                    checkingIn = false
                    playerCoords = GetEntityCoords(playerPed)
                    if Vdist(playerCoords, x, y, z) < 3 then
                        local x, y, z = table.unpack(playerCoords)
                        TriggerServerEvent('injuries:validateCheckin', injuredParts, IsPedDeadOrDying(playerPed), x, y, z, IsPedMale(playerPed))
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('injuries:checkin')
AddEventHandler('injuries:checkin', function()
    local overview = '0. Base Fee: $'..BASE_CHECKIN_PRICE..'\n'
    local payment = BASE_CHECKIN_PRICE
    local log = '\n⠀• Base Fee **-** $50'
    local index = 0
    for bone, _injuries in pairs(injuredParts) do
        for injury, data in pairs(injuredParts[bone]) do
            index = index + 1
            payment = payment + data.treatmentPrice
            overview = overview .. index .. '.  Bone: ' ..parts[bone] .. ' | Injury: ' .. data.string .. ' | Price: $' .. data.treatmentPrice .. '\n'
            log = log .. '\n⠀• '..parts[bone]..' **-** '..data.string..' **-** Stage '..data.stage
        end
    end
    TriggerEvent('chatMessage', '', {255, 255, 255}, 'Overview: \n ' .. overview)
    injuredParts = {}
    effects = {}
    StopScreenEffect('Rampage')
    TriggerEvent('death:allowRevive')
    TriggerEvent('civ:resetWalkStyle')
    TriggerEvent('usa:showHelp', true, 'You are currently being treated, please wait.')
    TriggerServerEvent('injuries:saveData', injuredParts)
    TriggerServerEvent('injuries:sendLog', log, payment)
end)

RegisterNetEvent('ems:admitMe')
AddEventHandler('ems:admitMe', function()
    TriggerServerEvent('injuries:chargeForInjuries', injuredParts, 1.0, false)
end)

RegisterNetEvent('death:injuryPayment')
AddEventHandler('death:injuryPayment', function()
    TriggerServerEvent('injuries:chargeForInjuries', injuredParts, 1.5, true)
end)

RegisterNetEvent('injuries:updateInjuries')
AddEventHandler('injuries:updateInjuries', function(_injuries)
    local playerPed = PlayerPedId()
    local __injuries = {}
    for bone, injuries in pairs(_injuries) do
        ApplyPedBlood(playerPed, GetPedBoneIndex(playerPed, bone), 0.0, 0.0, 0.0, "wound_sheet")
        __injuries[tonumber(bone)] = injuries
    end
    injuredParts = __injuries
    effects = {}
    StopScreenEffect('Rampage')
    SetEntityHealth(PlayerPedId(), 200)
    TriggerEvent('civ:resetWalkStyle')
    NotifyPlayerOfInjuries()
end)

RegisterNetEvent('injuries:removeInjuries')
AddEventHandler('injuries:removeInjuries', function()
  injuredParts = {}
  effects = {}
  StopScreenEffect('Rampage')
  SetEntityHealth(PlayerPedId(), 200)
  TriggerEvent('civ:resetWalkStyle')
end)

RegisterNetEvent('character:setCharacter')
AddEventHandler('character:setCharacter', function()
    TriggerServerEvent('injuries:requestData')
end)

------ UTILITIES ------

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 470
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function NotifyPlayerOfInjuries()
    local string = ''
    for bone, injuries in pairs(injuredParts) do
        local boneName = parts[bone]
        for injury, data in pairs(injuredParts[bone]) do
            string = string .. boneName .. ' '
            if data.type == 'blunt' then
                string = string .. 'is bruised'
            elseif data.type == 'laceration' then
                string = string .. 'is cut'
            elseif data.type == 'penetrating' then
                string = string .. 'is punctured'
            elseif data.type == 'burn' then
                string = string .. 'is burnt'
            end
            if data.bandagedTime > 0 then
                string = string .. ', bandaged.'
            else
                if data.stage == 1 then
                    string = string .. ', bleeding.'
                elseif data.stage == 2 then
                    string = string .. ', bleeding & numb.'
                elseif data.stage == 3 then
                    string = string .. ', rapidly bleeding & numb.'
                end
            end
            TriggerEvent('usa:notify', string)
            string = ''
        end
    end
end

function UpdateEffects(stage, bone)
    for i = 1, #bone_effects[bone] do
        if stage >= i then
            local effectToApply = bone_effects[bone][i]
            effects[effectToApply] = true
        end
    end
end

function GetPlayerFromPed(ped)
    for a = 0, 255 do
        if GetPlayerPed(a) == ped then
            return a
        end
    end
    return -1
end

function table.getIndex(table)
    local index = 0
    for key, value in pairs(table) do
        index = index + 1
    end
    return index
end

function PlayDoorAnimation()
    while ( not HasAnimDictLoaded( 'anim@mp_player_intmenu@key_fob@' ) ) do
        RequestAnimDict( 'anim@mp_player_intmenu@key_fob@' )
        Citizen.Wait( 0 )
  end
    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, 1.0, -1, 48)
end

function DrawTimer(beginTime, duration, x, y, text)
    if not HasStreamedTextureDictLoaded('timerbars') then
        RequestStreamedTextureDict('timerbars')
        while not HasStreamedTextureDictLoaded('timerbars') do
            Citizen.Wait(0)
        end
    end

    if GetTimeDifference(GetGameTimer(), beginTime) < duration then
        w = (GetTimeDifference(GetGameTimer(), beginTime) * (0.085 / duration))
    end

    local correction = ((1.0 - math.floor(GetSafeZoneSize(), 2)) * 100) * 0.005
    x, y = x - correction, y - correction

    Set_2dLayer(0)
    DrawSprite('timerbars', 'all_black_bg', x, y, 0.15, 0.0325, 0.0, 255, 255, 255, 180)

    Set_2dLayer(1)
    DrawRect(x + 0.0275, y, 0.085, 0.0125, 100, 0, 0, 180)

    Set_2dLayer(2)
    DrawRect(x - 0.015 + (w / 2), y, w, 0.0125, 150, 0, 0, 180)

    SetTextColour(255, 255, 255, 180)
    SetTextFont(0)
    SetTextScale(0.3, 0.3)
    SetTextCentre(true)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    Set_2dLayer(3)
    DrawText(x - 0.06, y - 0.012)
end

function getPlayerInjuries()
    return injuredParts
end