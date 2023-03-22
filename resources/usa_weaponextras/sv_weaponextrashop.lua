--# Weapon components & tints shop, two kinds -- illegal and legal, each at different locations.
--# for USA REALISM RP
--# by: minipunch

local ITEMS = {
    ["Tints"] = {
        legal = {
            [0] = {name = "Normal", price = 500},
            [1] = {name = "Green", price = 500},
            [2] = {name = "Gold", price = 500},
            [3] = {name = "Pink", price = 500},
            [4] = {name = "Army", price = 500},
            [5] = {name = "LSPD", price = 500},
            [6] = {name = "Orange", price = 500},
            [7] = {name = "Platinum", price = 500}
        },
        illegal = {
            [0] = {name = "Normal", price = 500},
            [1] = {name = "Green", price = 500},
            [2] = {name = "Gold", price = 500},
            [3] = {name = "Pink", price = 500},
            [4] = {name = "Army", price = 500},
            [5] = {name = "LSPD", price = 500},
            [6] = {name = "Orange", price = 500},
            [7] = {name = "Platinum", price = 500}
        }
    },
    ["Components"] = {
        legal = {
            -- pistols --
            ["Pistol"] = {
                { name = "Flashlight", value = "COMPONENT_AT_PI_FLSH", price = 200, weapon_hash = 453432689 },
                { name = "Yusuf Amir Luxury Finish", value = "COMPONENT_PISTOL_VARMOD_LUXE", price = 500, weapon_hash = 453432689 }
            },
            ["SNS Pistol"] = {
                { name = "Etched Wood Grip Finish", value = "COMPONENT_SNSPISTOL_VARMOD_LOWRIDER", price = 500, weapon_hash = -1076751822 }
            },
            ["Heavy Pistol"] = {
                { name = "Flashlight", value = "COMPONENT_AT_PI_FLSH", price = 200, weapon_hash = GetHashKey("WEAPON_HEAVYPISTOL") },
                { name = "Etched Wood Grip Finish", value = "COMPONENT_HEAVYPISTOL_VARMOD_LUXE", price = 2000, weapon_hash = -771403250 }
            },
            ["Glock"] = {
                { name = "Flashlight", value = "COMPONENT_AT_PI_FLSH", price = 200, weapon_hash = 1593441988 },
                { name = "Yusuf Amir Luxury Finish", value = "COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER", price = 1000, weapon_hash = 1593441988 }
            },
            [".50 Cal Pistol"] = {
                { name = "Flashlight", value = "COMPONENT_AT_PI_FLSH", price = 200, weapon_hash = -1716589765 },
                { name = "Platinum Pearl Deluxe Finish", value = "COMPONENT_PISTOL50_VARMOD_LUXE", price = 500, weapon_hash = -1716589765 }
            },
            ['MK2'] = {
                { name = "Flashlight", value = "COMPONENT_AT_PI_FLSH_02", price = 200, weapon_hash = -1075685676 },
            },
            ["Revolver"] = {
                { name = "Variation 1", value = "COMPONENT_REVOLVER_VARMOD_BOSS", price = 500, weapon_hash = -1045183535 },
                { name = "Variation 2", value = "COMPONENT_REVOLVER_VARMOD_GOON", price = 500, weapon_hash = -1045183535 }
            },
            -- Shotguns --
            ["Pump Shotgun"] = {
                { name = "Flashlight", value = "COMPONENT_AT_AR_FLSH", price = 200, weapon_hash = 487013001 },
                { name = "Yusuf Amir Luxury Finish", value = "COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER", price = 500, weapon_hash = 487013001 }
            },
            ["Bullpup Shotgun"] = {
                { name = "Flashlight", value = "COMPONENT_AT_AR_FLSH", price = 500, weapon_hash = -1654528753 },
                { name = "Grip", value = "COMPONENT_AT_AR_AFGRIP", price = 250, weapon_hash = -1654528753 }
            },
            ["Sniper Rifle"] = {
                { name = "Suppressor", value = "COMPONENT_AT_AR_SUPP_02", price = 250, weapon_hash = 100416529 },
                { name = "Etched Wood Grip Finish", value = "COMPONENT_SNIPERRIFLE_VARMOD_LUXE", price = 350, weapon_hash = 100416529 }
            },
            ["FN SCAR SC"] = {
                { name = "Empty FN SCAR SC Drum Mag", quantity = 1, type = "magazine", price = 1000, weight = 7, receives = "9mm", MAX_CAPACITY = 60, currentCapacity = 0, notStackable = true, magComponent = "COMPONENT_SCARSC_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_SCARSC") },
                { name = "Suppressor", value = "COMPONENT_AT_SCARSC_SUPP_02", price = 3000, weapon_hash = GetHashKey("WEAPON_SCARSC") },
                { name = "Flashlight", value = "COMPONENT_AT_SCARSC_FLSH", price = 1000, weapon_hash = GetHashKey("WEAPON_SCARSC") },
                { name = "Scope", value = "COMPONENT_AT_SCOPE_SCARSC", price = 6000, weapon_hash = GetHashKey("WEAPON_SCARSC") },
                { name = "Grip", value = "COMPONENT_AT_SCARSC_AFGRIP", price = 4000, weapon_hash = GetHashKey("WEAPON_SCARSC") },
            }
        },
        -- missing from below: Heavy shotgun
        illegal = {
            -- pistols --
            ["Pistol"] = {
                { name = "Empty Pistol Extended Mag", quantity = 1, type = "magazine", price = 300, weight = 7, receives = "9mm", MAX_CAPACITY = 16, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_PISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_PISTOL") },
                { name = "Suppressor", value = "COMPONENT_AT_PI_SUPP_02", price = 1500, weapon_hash = 453432689 }
            },
            ["Revolver Ultra"] = {
                { name = "Suppressor", value = "COMPONENT_AT_REVOLVERLEOSHOP_SUPP", price = 3500, weapon_hash = GetHashKey("WEAPON_REVOLVERULTRA") }
            },
            ["SNS Pistol"] = {
                { name = "Empty SNS Pistol Extended Mag", quantity = 1, type = "magazine", price = 200, weight = 6, receives = ".45", MAX_CAPACITY = 12, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_SNSPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_SNSPISTOL") },
            },
            ["Heavy Pistol"] = {
                { name = "Empty Heavy Pistol Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = ".45", MAX_CAPACITY = 36, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_HEAVYPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_HEAVYPISTOL") },
                { name = "Suppressor", value = "COMPONENT_AT_PI_SUPP", price = 1500, weapon_hash = GetHashKey("WEAPON_HEAVYPISTOL") }
            },
            ["Glock"] = {
                { name = "Empty Glock Extended Mag", quantity = 1, type = "magazine", price = 175, weight = 7, receives = "9mm", MAX_CAPACITY = 16, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_COMBATPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_COMBATPISTOL") },
                { name = "Suppressor", value = "COMPONENT_AT_PI_SUPP", price = 1500, weapon_hash = 1593441988 }
            },
            [".50 Cal Pistol"] = {
                { name = "Empty Pistol .50 Extended Mag", quantity = 1, type = "magazine", price = 250, weight = 7, receives = ".50 Cal", MAX_CAPACITY = 12, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_PISTOL50_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_PISTOL50") },
                { name = "Suppressor", value = "COMPONENT_AT_AR_SUPP_02", price = 1500, weapon_hash = -1716589765 }
            },
            ["Vintage Pistol"] = {
                { name = "Empty Vintage Pistol Extended Mag", quantity = 1, type = "magazine", price = 175, weight = 7, receives = "9mm", MAX_CAPACITY = 14, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_VINTAGEPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_VINTAGEPISTOL") },
                { name = "Suppressor", value = "COMPONENT_AT_PI_SUPP", price = 1500, weapon_hash = 137902532 }
            },
            ["Revolver Mk2"] = {
                { name = "Compensator", value = "COMPONENT_AT_PI_COMP_03", price = 2500, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Flashlight", value = "COMPONENT_AT_PI_FLSH", price = 1500, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Small Scope", value = "COMPONENT_AT_SCOPE_MACRO_MK2", price = 3000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Holographic Sight", value = "COMPONENT_AT_SIGHTS", price = 4000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Digital Camo", value = "COMPONENT_REVOLVER_MK2_CAMO", price = 1000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Brushstroke Camo", value = "COMPONENT_REVOLVER_MK2_CAMO_02", price = 1000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Woodland Camo", value = "COMPONENT_REVOLVER_MK2_CAMO_03", price = 1000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Skull", value = "COMPONENT_REVOLVER_MK2_CAMO_04", price = 1000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Sessanta Nove", value = "COMPONENT_REVOLVER_MK2_CAMO_05", price = 1000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Perseus", value = "COMPONENT_REVOLVER_MK2_CAMO_06", price = 1000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Leopard", value = "COMPONENT_REVOLVER_MK2_CAMO_07", price = 1000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Zebra", value = "COMPONENT_REVOLVER_MK2_CAMO_08", price = 1000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Geometric", value = "COMPONENT_REVOLVER_MK2_CAMO_09", price = 1000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Boom!", value = "COMPONENT_REVOLVER_MK2_CAMO_10", price = 1000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") },
                { name = "Patriotic", value = "COMPONENT_REVOLVER_MK2_CAMO_IND_01", price = 1000, weapon_hash = GetHashKey("WEAPON_REVOLVER_MK2") }
            },
            ['MK2'] = {
                { name = "Mounted Scope", value = "COMPONENT_AT_PI_RAIL", price = 2250, weapon_hash = -1075685676 },
                { name = "Suppressor", value = "COMPONENT_AT_PI_SUPP_02", price = 2800, weapon_hash = -1075685676 },
                { name = "Compensator", value = "COMPONENT_AT_PI_COMP", price = 3250, weapon_hash = -1075685676 },
                { name = "Digital Camo", value = "COMPONENT_PISTOL_MK2_CAMO", price = 850, weapon_hash = -1075685676 },
                { name = "Brushstroke Camo", value = "COMPONENT_PISTOL_MK2_CAMO_02", price = 850, weapon_hash = -1075685676 },
                { name = "Woodland Camo", value = "COMPONENT_PISTOL_MK2_CAMO_03", price = 850, weapon_hash = -1075685676 },
                { name = "Skull", value = "COMPONENT_PISTOL_MK2_CAMO_04", price = 850, weapon_hash = -1075685676 },
                { name = "Sessanta Nove", value = "COMPONENT_PISTOL_MK2_CAMO_05", price = 850, weapon_hash = -1075685676 },
                { name = "Perseus", value = "COMPONENT_PISTOL_MK2_CAMO_06", price = 850, weapon_hash = -1075685676 },
                { name = "Leopard", value = "COMPONENT_PISTOL_MK2_CAMO_07", price = 850, weapon_hash = -1075685676 },
                { name = "Zebra", value = "COMPONENT_PISTOL_MK2_CAMO_08", price = 850, weapon_hash = -1075685676 },
                { name = "Geometric", value = "COMPONENT_PISTOL_MK2_CAMO_09", price = 850, weapon_hash = -1075685676 },
                { name = "Boom!", value = "COMPONENT_PISTOL_MK2_CAMO_10", price = 850, weapon_hash = -1075685676 },
                { name = "Patriotic", value = "COMPONENT_PISTOL_MK2_CAMO_IND_01", price = 850, weapon_hash = -1075685676 },
                { name = "Digital Camo (Slide)", value = "COMPONENT_PISTOL_MK2_CAMO_SLIDE", price = 850, weapon_hash = -1075685676 },
                { name = "Brushstroke Camo (Slide)", value = "COMPONENT_PISTOL_MK2_CAMO_02_SLIDE", price = 850, weapon_hash = -1075685676 },
                { name = "Woodland Camo (Slide)", value = "COMPONENT_PISTOL_MK2_CAMO_03_SLIDE", price = 850, weapon_hash = -1075685676 },
                { name = "Skull (Slide)", value = "COMPONENT_PISTOL_MK2_CAMO_04_SLIDE", price = 850, weapon_hash = -1075685676 },
                { name = "Sessanta Nove (Slide)", value = "COMPONENT_PISTOL_MK2_CAMO_05_SLIDE", price = 850, weapon_hash = -1075685676 },
                { name = "Perseus (Slide)", value = "COMPONENT_PISTOL_MK2_CAMO_06_SLIDE", price = 850, weapon_hash = -1075685676 },
                { name = "Leopard (Slide)", value = "COMPONENT_PISTOL_MK2_CAMO_07_SLIDE", price = 850, weapon_hash = -1075685676 },
                { name = "Zebra (Slide)", value = "COMPONENT_PISTOL_MK2_CAMO_08_SLIDE", price = 850, weapon_hash = -1075685676 },
                { name = "Geometric (Slide)", value = "COMPONENT_PISTOL_MK2_CAMO_09_SLIDE", price = 850, weapon_hash = -1075685676 },
                { name = "Boom! (Slide)", value = "COMPONENT_PISTOL_MK2_CAMO_10_SLIDE", price = 850, weapon_hash = -1075685676 },
                { name = "Patriotic (Slide)", value = "COMPONENT_PISTOL_MK2_CAMO_IND_01_SLIDE", price = 850, weapon_hash = -1075685676 },
            },
            ["Ceramic Pistol"] = {
                { name = "Suppressor", value = "COMPONENT_CERAMICPISTOL_SUPP", price = 1500, weapon_hash = GetHashKey("WEAPON_CERAMICPISTOL") }
            },
            -- other --
            ["Switchblade"] = {
                { name = "Variation 1", value = "COMPONENT_SWITCHBLADE_VARMOD_VAR1", price = 400, weapon_hash = -538741184 },
                { name = "Variation 2", value = "COMPONENT_SWITCHBLADE_VARMOD_VAR2", price = 400, weapon_hash = -538741184 }
            },
            ["Brass Knuckles"] = {
                { name = "Stock", value = "COMPONENT_KNUCKLE_VARMOD_BASE", price = 500, weapon_hash = -656458692 },
                { name = "Pimp", value = "COMPONENT_KNUCKLE_VARMOD_PIMP", price = 500, weapon_hash = -656458692 },
                { name = "Ballas", value = "COMPONENT_KNUCKLE_VARMOD_BALLAS", price = 500, weapon_hash = -656458692 },
                { name = "Dollars", value = "COMPONENT_KNUCKLE_VARMOD_DOLLAR", price = 500, weapon_hash = -656458692 },
                { name = "Diamond", value = "COMPONENT_KNUCKLE_VARMOD_DIAMOND", price = 500, weapon_hash = -656458692 },
                { name = "Hate", value = "COMPONENT_KNUCKLE_VARMOD_HATE", price = 500, weapon_hash = -656458692} ,
                { name = "Love", value = "COMPONENT_KNUCKLE_VARMOD_LOVE", price = 500, weapon_hash = -656458692 },
                { name = "Player", value = "COMPONENT_KNUCKLE_VARMOD_PLAYER", price = 500, weapon_hash = -656458692 },
                { name = "King", value = "COMPONENT_KNUCKLE_VARMOD_KING", price = 500, weapon_hash = -656458692 },
                { name = "Vagos", value = "COMPONENT_KNUCKLE_VARMOD_VAGOS", price = 500, weapon_hash = -656458692 }
            },
            ["Pump Shotgun"] = {
                { name = "Suppressor", value = "COMPONENT_AT_SR_SUPP", price = 2000, weapon_hash = 487013001 }
            },
            ["Bullpup Shotgun"] = {
                { name = "Suppressor", value = "COMPONENT_AT_AR_SUPP_02", price = 3000, weapon_hash = -1654528753 }
            },
            ["Heavy Shotgun"] = {
                { name = "Flashlight", value = "COMPONENT_AT_AR_FLSH", price = 1000, weapon_hash = GetHashKey("WEAPON_HEAVYSHOTGUN") },
                { name = "Suppressor", value = "COMPONENT_AT_AR_SUPP_02", price = 2500, weapon_hash = GetHashKey("WEAPON_HEAVYSHOTGUN") },
                { name = "Grip", value = "COMPONENT_AT_AR_AFGRIP", price = 2000, weapon_hash = GetHashKey("WEAPON_HEAVYSHOTGUN") }
            },
            ["SMG"] = {
                { name = "Empty SMG Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "9mm", MAX_CAPACITY = 60, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_SMG_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_SMG") },
                { name = "Empty SMG Drum Mag", quantity = 1, type = "magazine", price = 700, weight = 7, receives = "9mm", MAX_CAPACITY = 100, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_SMG_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_SMG") },
                { name = "Scope", value = "COMPONENT_AT_SCOPE_MACRO_02", price = 750, weapon_hash = 736523883 },
                { name = "Suppressor", value = "COMPONENT_AT_PI_SUPP", price = 1500, weapon_hash = 736523883 },
                { name = "Flashlight", value = "COMPONENT_AT_AR_FLSH", price = 500, weapon_hash = 736523883 },
                { name = "Yusuf Amir Luxury Finish", value = "COMPONENT_SMG_VARMOD_LUXE", price = 1500, weapon_hash = 736523883 }
            },
            ["Assault SMG"] = {
                { name = "Flashlight", value = "COMPONENT_AT_AR_FLSH", price = 500, weapon_hash = GetHashKey("WEAPON_ASSAULTSMG") },
                { name = "Scope", value = "COMPONENT_AT_SCOPE_MACRO", price = 2000, weapon_hash = GetHashKey("WEAPON_ASSAULTSMG") },
                { name = "Suppressor", value = "COMPONENT_AT_AR_SUPP_02", price = 3000, weapon_hash = GetHashKey("WEAPON_ASSAULTSMG") },
                { name = "Yusuf Amir Luxury Finish", value = "COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER", price = 1250, weapon_hash = GetHashKey("WEAPON_ASSAULTSMG") }
            },
            ["Combat PDW"] = {
                { name = "Flashlight", value = "COMPONENT_AT_AR_FLSH", price = 500, weapon_hash = GetHashKey("WEAPON_COMBATPDW") },
                { name = "Grip", value = "COMPONENT_AT_AR_AFGRIP", price = 750, weapon_hash = GetHashKey("WEAPON_COMBATPDW") },
                { name = "Scope", value = "COMPONENT_AT_SCOPE_SMALL", price = 2000, weapon_hash = GetHashKey("WEAPON_COMBATPDW") }
            },
            ["Sawn Off Shotgun"] = {
                { name = "Gilded Gun Metal Finish", value = "COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE", price = 1200, weapon_hash = 2017895192 }
            },
            ["AP Pistol"] = {
                { name = "Empty AP Pistol Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "9x18mm", MAX_CAPACITY = 36, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_APPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_APPISTOL") },
                { name = "Flashlight", value = "COMPONENT_AT_PI_FLSH", price = 500, weapon_hash = 584646201 },
                { name = "Suppressor", value = "COMPONENT_AT_PI_SUPP", price = 2000, weapon_hash = 584646201 },
                { name = "Gilded Gun Metal Finish", value = "COMPONENT_APPISTOL_VARMOD_LUXE", price = 2700, weapon_hash = 584646201 }
            },
            ["Micro SMG"] = {
                { name = "Empty Micro SMG Extended Mag", quantity = 1, type = "magazine", price = 350, weight = 7, receives = ".45", MAX_CAPACITY = 30, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_MICROSMG_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_MICROSMG") },
                { name = "Scope", value = "COMPONENT_AT_SCOPE_MACRO", price = 1500, weapon_hash = 324215364 },
                { name = "Suppressor", value = "COMPONENT_AT_AR_SUPP_02", price = 2000, weapon_hash = 324215364 },
                { name = "Flashlight", value = "COMPONENT_AT_PI_FLSH", price = 600, weapon_hash = 324215364 },
                { name = "Yusuf Amir Luxury Finish", value = "COMPONENT_MICROSMG_VARMOD_LUXE", price = 3000, weapon_hash = 324215364 }
            },
            ["Tommy Gun"] = {
                { name = "Empty Gusenberg Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = ".45", MAX_CAPACITY = 50, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_GUSENBERG_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_GUSENBERG") },
            },
            ["AK47"] = {
                { name = "Empty AK47 Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "7.62mm", MAX_CAPACITY = 60, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_ASSAULTRIFLE_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_ASSAULTRIFLE") },
                { name = "Empty AK47 Drum Mag", quantity = 1, type = "magazine", price = 700, weight = 7, receives = "7.62mm", MAX_CAPACITY = 100, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_ASSAULTRIFLE_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_ASSAULTRIFLE") },
                { name = "Scope", value = "COMPONENT_AT_SCOPE_MACRO", price = 2500, weapon_hash = -1074790547 },
                { name = "Suppressor", value = "COMPONENT_AT_AR_SUPP_02", price = 4500, weapon_hash = -1074790547 },
                { name = "Grip", value = "COMPONENT_AT_AR_AFGRIP", price = 1500, weapon_hash = -1074790547 },
                { name = "Flashlight", value = "COMPONENT_AT_AR_FLSH", price = 900, weapon_hash = -1074790547 },
                { name = "Yusuf Amir Luxury Finish", value = "COMPONENT_ASSAULTRIFLE_VARMOD_LUXE", price = 6500, weapon_hash = -1074790547 }
            },
            ["Assault Rifle MK2"] = {
                { name = "Empty Assault Rifle MK2 Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "7.62mm", MAX_CAPACITY = 60, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Grip", value = "COMPONENT_AT_AR_AFGRIP_02", price = 3000, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Flashlight", value = "COMPONENT_AT_AR_FLSH", price = 2500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Holographic Sight", value = "COMPONENT_AT_SIGHTS", price = 3500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Small Scope", value = "COMPONENT_AT_SCOPE_MACRO_MK2", price = 4250, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Large Scope", value = "COMPONENT_AT_SCOPE_MEDIUM_MK2", price = 5000, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Suppressor", value = "COMPONENT_AT_AR_SUPP_02", price = 6000, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Tactical Muzzle Brake", value = "COMPONENT_AT_MUZZLE_02", price = 3450, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Fat-End Muzzle Brake", value = "COMPONENT_AT_MUZZLE_03", price = 3650, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Precision Muzzle Brake", value = "COMPONENT_AT_MUZZLE_04", price = 3850, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Heavy Duty Muzzle Brake", value = "COMPONENT_AT_MUZZLE_05", price = 4050, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Slanted Muzzle Brake", value = "COMPONENT_AT_MUZZLE_06", price = 4250, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Split-End Muzzle Brake", value = "COMPONENT_AT_MUZZLE_07", price = 4450, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Default Barrel", value = "COMPONENT_AT_AR_BARREL_01", price = 2500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Heavy Barrel", value = "COMPONENT_AT_AR_BARREL_02", price = 2850, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Digital Camo", value = "COMPONENT_ASSAULTRIFLE_MK2_CAMO", price = 1500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Brushstroke Camo", value = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_02", price = 1500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Woodland Camo", value = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_03", price = 1500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Skull", value = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_04", price = 1500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Sessanta Nove", value = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_05", price = 1500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Perseus", value = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_06", price = 1500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Leopard", value = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_07", price = 1500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Zebra", value = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_08", price = 1500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Geometric", value = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_09", price = 1500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Boom!", value = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_10", price = 1500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") },
                { name = "Patriotic", value = "COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01", price = 1500, weapon_hash = GetHashKey("WEAPON_ASSAULTRIFLE_MK2") }
            },
            ["MK2 Carbine Rifle"] = {
                { name = "Empty MK2 Carbine Rifle Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "5.56mm", MAX_CAPACITY = 60, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_CARBINERIFLE_MK2_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Grip", value = "COMPONENT_AT_AR_AFGRIP_02", price = 3000, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Flashlight", value = "COMPONENT_AT_AR_FLSH", price = 2500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Holographic Sight", value = "COMPONENT_AT_SIGHTS", price = 3500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Small Scope", value = "COMPONENT_AT_SCOPE_MACRO_MK2", price = 4250, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Large Scope", value = "COMPONENT_AT_SCOPE_MEDIUM_MK2", price = 5000, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Suppressor", value = "COMPONENT_AT_AR_SUPP", price = 6000, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Flat Muzzle Brake", value = "COMPONENT_AT_MUZZLE_01", price = 3450, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Tactical Muzzle Brake", value = "COMPONENT_AT_MUZZLE_02", price = 3450, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Fat-End Muzzle Brake", value = "COMPONENT_AT_MUZZLE_03", price = 3650, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Precision Muzzle Brake", value = "COMPONENT_AT_MUZZLE_04", price = 3850, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Heavy Duty Muzzle Brake", value = "COMPONENT_AT_MUZZLE_05", price = 4050, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Slanted Muzzle Brake", value = "COMPONENT_AT_MUZZLE_06", price = 4250, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Split-End Muzzle Brake", value = "COMPONENT_AT_MUZZLE_07", price = 4450, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Default Barrel", value = "COMPONENT_AT_CR_BARREL_01", price = 2500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Heavy Barrel", value = "COMPONENT_AT_CR_BARREL_02", price = 2850, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Digital Camo", value = "COMPONENT_CARBINERIFLE_MK2_CAMO", price = 1500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Brushstroke Camo", value = "COMPONENT_CARBINERIFLE_MK2_CAMO_02", price = 1500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Woodland Camo", value = "COMPONENT_CARBINERIFLE_MK2_CAMO_03", price = 1500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Skull", value = "COMPONENT_CARBINERIFLE_MK2_CAMO_04", price = 1500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Sessanta Nove", value = "COMPONENT_CARBINERIFLE_MK2_CAMO_05", price = 1500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Perseus", value = "COMPONENT_CARBINERIFLE_MK2_CAMO_06", price = 1500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Leopard", value = "COMPONENT_CARBINERIFLE_MK2_CAMO_07", price = 1500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Zebra", value = "COMPONENT_CARBINERIFLE_MK2_CAMO_08", price = 1500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Geometric", value = "COMPONENT_CARBINERIFLE_MK2_CAMO_09", price = 1500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Boom!", value = "COMPONENT_CARBINERIFLE_MK2_CAMO_10", price = 1500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") },
                { name = "Patriotic", value = "COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01", price = 1500, weapon_hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") }
            },
            ["Akorus"] = {
                { name = "Empty Akorus Extended Mag", quantity = 1, type = "magazine", price = 900, weight = 7, receives = "7.62mm", MAX_CAPACITY = 60, currentCapacity = 0, notStackable = true, magComponent = "COMPONENT_AKORUS_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_AKORUS") },
                { name = "Empty Akorus Box Mag", quantity = 1, type = "magazine", price = 900, weight = 12, receives = "7.62mm", MAX_CAPACITY = 140, currentCapacity = 0, notStackable = true, magComponent = "COMPONENT_AKORUS_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_AKORUS") },
                { name = "Suppressor", value = "COMPONENT_AT_AKORUS_SUPP_02", price = 5000, weapon_hash = GetHashKey("WEAPON_AKORUS") },
                { name = "Grip", value = "COMPONENT_AT_AKORUS_AFGRIP", price = 3000, weapon_hash = GetHashKey("WEAPON_AKORUS") },
            },
            ["M4 GoldBeast"] = {
                { name = "Empty M4GoldBeast Extended Mag", quantity = 1, type = "magazine", price = 1500, weight = 7, receives = "7.62mm", MAX_CAPACITY = 60, currentCapacity = 0, notStackable = true, magComponent = "COMPONENT_M4GOLDBEAST_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_M4GOLDBEAST") },
                { name = "Empty M4GoldBeast Drum Mag", quantity = 1, type = "magazine", price = 2500, weight = 7, receives = "7.62mm", MAX_CAPACITY = 120, currentCapacity = 0, notStackable = true, magComponent = "COMPONENT_M4GOLDBEAST_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_M4GOLDBEAST") },
                { name = "Suppressor", value = "COMPONENT_AT_M4GOLDBEAST_SUPP_02", price = 3500, weapon_hash = GetHashKey("WEAPON_M4GOLDBEAST") }
            },
            ["Carbine Rifle"] = {
                { name = "Empty Carbine Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "5.56mm", MAX_CAPACITY = 60, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_CARBINERIFLE_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_CARBINERIFLE") },
                { name = "Empty Carbine Box Mag", quantity = 1, type = "magazine", price = 700, weight = 7, receives = "5.56mm", MAX_CAPACITY = 100, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_CARBINERIFLE_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_CARBINERIFLE") },
                { name = "Scope", value = "COMPONENT_AT_SCOPE_MEDIUM", price = 2500, weapon_hash = -2084633992 },
                { name = "Suppressor", value = "COMPONENT_AT_AR_SUPP", price = 4500, weapon_hash = -2084633992 },
                { name = "Grip", value = "COMPONENT_AT_AR_AFGRIP", price = 1500, weapon_hash = -2084633992 },
                { name = "Flashlight", value = "COMPONENT_AT_AR_FLSH", price = 900, weapon_hash = -2084633992 },
                { name = "Rail Cover", value = "COMPONENT_AT_RAILCOVER_01", price = 900, weapon_hash = -2084633992 },
                { name = "Yusuf Amir Luxury Finish", value = "COMPONENT_CARBINERIFLE_VARMOD_LUXE", price = 6500, weapon_hash = -2084633992 }
            },
            ["Military Rifle"] = {
                { name = "Iron Sights", value = "COMPONENT_MILITARYRIFLE_SIGHT_01", price = 850, weapon_hash = GetHashKey("WEAPON_MILITARYRIFLE") },
                { name = "Scope", value = "COMPONENT_AT_SCOPE_SMALL", price = 2000, weapon_hash = GetHashKey("WEAPON_MILITARYRIFLE") },
                { name = "Flashlight", value = "COMPONENT_AT_AR_FLSH", price = 1500, weapon_hash = GetHashKey("WEAPON_MILITARYRIFLE") },
                { name = "Suppressor", value = "COMPONENT_AT_AR_SUPP", price = 3500, weapon_hash = GetHashKey("WEAPON_MILITARYRIFLE") }
            },
            ["Compact Rifle"] = {
                { name = "Empty Compact Rifle Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "7.62mm", MAX_CAPACITY = 60, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_COMPACTRIFLE_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_COMPACTRIFLE") },
                { name = "Empty Compact Rifle Drum Mag", quantity = 1, type = "magazine", price = 700, weight = 7, receives = "7.62mm", MAX_CAPACITY = 100, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_COMPACTRIFLE_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_COMPACTRIFLE") },
            },
            ["Machine Pistol"] = {
                { name = "Empty Machine Pistol Extended Mag", quantity = 1, type = "magazine", price = 300, weight = 7, receives = "9mm", MAX_CAPACITY = 20, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_MACHINEPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_MACHINEPISTOL") },
                { name = "Empty Machine Pistol Drum Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "9mm", MAX_CAPACITY = 30, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_MACHINEPISTOL_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_MACHINEPISTOL") },
                { name = "Suppressor", value = "COMPONENT_AT_PI_SUPP", price = 1500, weapon_hash = -619010992 }
            },
            ["FN SCAR SC"] = {
                { name = "Empty FN SCAR SC Drum Mag", quantity = 1, type = "magazine", price = 1000, weight = 7, receives = "9mm", MAX_CAPACITY = 60, currentCapacity = 0, notStackable = true, magComponent = "COMPONENT_SCARSC_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_SCARSC") },
                { name = "Suppressor", value = "COMPONENT_AT_SCARSC_SUPP_02", price = 3000, weapon_hash = GetHashKey("WEAPON_SCARSC") },
                { name = "Flashlight", value = "COMPONENT_AT_SCARSC_FLSH", price = 1000, weapon_hash = GetHashKey("WEAPON_SCARSC") },
                { name = "Scope", value = "COMPONENT_AT_SCOPE_SCARSC", price = 6000, weapon_hash = GetHashKey("WEAPON_SCARSC") },
                { name = "Grip", value = "COMPONENT_AT_SCARSC_AFGRIP", price = 4000, weapon_hash = GetHashKey("WEAPON_SCARSC") },
            }
        }
    }
}

RegisterServerEvent("weaponExtraShop:getItems")
AddEventHandler("weaponExtraShop:getItems", function()
    TriggerClientEvent("weaponExtraShop:getItems", source, ITEMS)
end)

RegisterServerEvent("weaponExtraShop:requestTintPurchase")
AddEventHandler("weaponExtraShop:requestTintPurchase", function(tintId, wephash, legal)
  local char = exports["usa-characters"]:GetCharacter(source)
  local tint if not legal then tint = ITEMS["Tints"].legal[tintId] else tint = ITEMS["Tints"].illegal[tintId] end
  local weapon = char.getItemWithField("hash", wephash)
  if weapon then
    if tint.price <= char.get("money") then -- see if user has enough money
      char.removeMoney(tint.price)
      TriggerClientEvent("usa:notify", source, "You have purchased a ~y~" .. tint.name .. "~w~ weapon tint.")
      TriggerClientEvent("weaponExtraShop:applyTint", source, tintId)
      char.modifyItem(weapon, "tint", tintId)
    else
      TriggerClientEvent("usa:notify", source, "Not enough money!")
    end
  end
end)

RegisterServerEvent("weaponExtraShop:requestComponentPurchase")
AddEventHandler("weaponExtraShop:requestComponentPurchase", function(weapon, componentIndex, wephash, legal)
    local char = exports["usa-characters"]:GetCharacter(source)
    local component = nil
    if legal then
        component = ITEMS["Components"].legal[weapon][componentIndex]
    else
        component = ITEMS["Components"].illegal[weapon][componentIndex]
    end
    if component.price <= char.get("money") then -- see if user has enough money
        if wephash then -- not a magazine
            local weapon = (char.getItemWithField("hash", wephash) or char.getItemWithField("hash", wephash & 0xFFFFFFFF))
            if weapon then
                char.removeMoney(component.price)
                TriggerClientEvent("usa:notify", source, "You have purchased a ~y~" .. component.name .. "~w~ weapon component.")
                TriggerClientEvent("weaponExtraShop:applyComponent", source, component)
                if not weapon.components then
                    weapon.components = {}
                end
                table.insert(weapon.components, component.value)
                char.modifyItem(weapon, "components", weapon.components)
            end
        else -- magazine component
            if char.canHoldItem(component) then
                component.uuid = exports.globals:generateID()
                -- give player magazine item
                char.giveItem(component)
                -- take money
                char.removeMoney(component.price)
                -- notify
                TriggerClientEvent("usa:notify", source, "Purchased: " .. component.name)        
            else
                TriggerClientEvent("usa:notify", source, "Inventory full!")
            end
        end
    else
        TriggerClientEvent("usa:notify", source, "Not enough money!")
    end
end)
