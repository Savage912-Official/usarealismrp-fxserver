Config = {
    BASE_CHECKIN_PRICE = 25,

    MAX_BED_DISTANCE = 1000,

    Body_Parts = {
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
    },

    Bone_Effects = { -- ORDER MATTERS - each index is subject to each stage
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
    },
    
    Injuries = {
        --[GetHashKey("WEAPON_UNARMED")] = {type = 'blunt', bleed = 7200, string = 'Fists', treatableWithBandage = true, treatmentPrice = 50, dropEvidence = 0.5}, -- WEAPON_UNARMED
        [GetHashKey("WEAPON_ANIMAL")] = {type = 'laceration', bleed = 1500, string = 'Animal Attack', treatableWithBandage = true, treatmentPrice = 80, dropEvidence = 0.9}, -- WEAPON_ANIMAL
        [GetHashKey("WEAPON_COUGAR")] = {type = 'laceration', bleed = 900, string = 'Animal Attack', treatableWithBandage = false, treatmentPrice = 90, dropEvidence = 0.9}, -- WEAPON_COUGAR
        [GetHashKey("WEAPON_KNIFE")] = {type = 'laceration', bleed = 480, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 90, dropEvidence = 1.0}, -- WEAPON_KNIFE
        [GetHashKey("WEAPON_SHIV")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0}, -- WEAPON_SHIV
        [GetHashKey("WEAPON_THROWINGKNIFE")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0}, -- WEAPON_THROWINGKNIFE
        [GetHashKey("WEAPON_NINJASTAR")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0}, -- WEAPON_NINJASTAR
        [GetHashKey("WEAPON_NINJASTAR2")] = {type = 'laceration', bleed = 2100, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 130, dropEvidence = 1.0}, -- WEAPON_NINJASTAR2
        [GetHashKey("WEAPON_KATANAS")] = {type = 'laceration', bleed = 1750, string = 'Knife Puncture', treatableWithBandage = false, treatmentPrice = 150, dropEvidence = 1.0}, -- WEAPON_KATANA
        [GetHashKey("WEAPON_NIGHTSTICK")] = {type = 'blunt', bleed = 2400, string = 'Blunt Object', treatableWithBandage = true, treatmentPrice = 30, dropEvidence = 0.8}, -- WEAPON_NIGHTSTICK
        [GetHashKey("WEAPON_HAMMER")] = {type = 'blunt', bleed = 1200, string = 'Concentrated Blunt Object', treatableWithBandage = true, treatmentPrice = 30, dropEvidence = 0.9}, -- WEAPON_HAMMER
        [GetHashKey("WEAPON_BAT")] = {type = 'blunt', bleed = 900, string = 'Large Blunt Object', treatableWithBandage = false, treatmentPrice = 70, dropEvidence = 0.9}, -- WEAPON_BAT
        [GetHashKey("WEAPON_GOLFCLUB")] = {type = 'blunt', bleed = 1200, string = 'Large Blunt Object', treatableWithBandage = false, treatmentPrice = 10, dropEvidence = 0.6}, -- WEAPON_GOLFCLUB
        [GetHashKey("WEAPON_CROWBAR")] = {type = 'blunt', bleed = 900, string = 'Blunt Object', treatableWithBandage = false, treatmentPrice = 45, dropEvidence = 0.8}, -- WEAPON_CROWBAR
        [GetHashKey("WEAPON_MACHINEPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0},
        [GetHashKey("WEAPON_APPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_APPISTOL
        [GetHashKey("WEAPON_PISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PISTOL
        [GetHashKey("WEAPON_COMBATPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_COMBATPISTOL
        [GetHashKey("WEAPON_CERAMICPISTOL")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_CERAMICPISTOL
        [GetHashKey("WEAPON_PISTOL50")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_PISTOL50
        [GetHashKey("WEAPON_GUSENBERG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_GUSENBERG
        [GetHashKey("WEAPON_SMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_SMG
        [GetHashKey("WEAPON_SCARSC")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_SCARSC
        [GetHashKey("WEAPON_COMBATPDW")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_COMBATPDW
        [GetHashKey("WEAPON_ASSAULTSMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_ASSAULTSMG
        [GetHashKey("WEAPON_SMG_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_SMG_MK2
        [GetHashKey("WEAPON_MICROSMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_MICROSMG
        [GetHashKey("WEAPON_MINISMG")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_MINISMG
        [GetHashKey("WEAPON_ASSAULTRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_ASSAULTRIFLE
        [GetHashKey("WEAPON_AKORUS")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_AKORUS
        [GetHashKey("WEAPON_TACTICALRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_TACTICALRIFLE
        [GetHashKey("WEAPON_MILITARYRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_MILITARYRIFLE
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
        [GetHashKey("WEAPON_ASSAULTRIFLE_MK2")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_ASSAULTRIFLE_MK2
        [GetHashKey("WEAPON_COMPACTRIFLE")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0}, -- WEAPON_COMPACTRIFLE
        [GetHashKey("WEAPON_M4GOLDBEAST")] = {type = 'penetrating', bleed = 300, string = 'High-speed Projectile', treatableWithBandage = false, treatmentPrice = 500, dropEvidence = 1.0} -- WEAPON_M4GOLDBEAST
    },

    Hospital_Locations = {
        {307.10046386719, -595.07073974609, 43.284019470215}, -- upper PB
        {350.97692871094, -587.77874755859, 28.796844482422}, -- lower PB
        {-817.61511230469, -1236.6121826172, 7.3374252319336}, -- viceroy medical
        {1768.4294433594, 2570.2172851563, 45.729831695557}, -- prison
        {1832.7521, 3677.0686, 34.2749}, -- sandy
        {-251.8987, 6334.1558, 32.4272} -- Paleto Clinic
    }
}