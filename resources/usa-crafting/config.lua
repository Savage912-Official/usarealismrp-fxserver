Config = {}

Config.craftingLocations = {
    weapons = {
        {
            coords = vector3(-505.67352294922, -1759.0928955078, 17.644302368164), -- LS
            object = {
                model = "gr_prop_gr_bench_02b",
                heading = 160.0
            }
        },
        {
            coords = vector3(-21.198345565796, 6662.040625, 30.004909515381), -- paleto
            object = {
                model = "gr_prop_gr_bench_02b",
                heading = 201.0
            }
        }
    }
}

Config.recipes = {
    weapons = {
        { 
            name = "Ninja Star",
            image = "https://i.imgur.com/4O5FjCK.png",
            requires = {
                { name = "Ninja Star Kit", quantity = 1 }
            },
            produces = {
                {
                    name = "Ninja Star",
                    hash = GetHashKey("WEAPON_NINJASTAR"),
                    quantity = 1,
                    type = "weapon",
                    weight = 5
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        { 
            name = "Ninja Star 2",
            image = "https://i.imgur.com/KjU5asW.png",
            requires = {
                { name = "Ninja Star 2 Kit", quantity = 1 }
            },
            produces = {
                {
                    name = "Ninja Star 2",
                    hash = GetHashKey("WEAPON_NINJASTAR2"),
                    quantity = 1,
                    type = "weapon",
                    weight = 5
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        { 
            name = "Glock",
            image = "https://i.imgur.com/UjZeF6e.png",
            requires = {
                { name = "Glock Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Glock",
                    hash = GetHashKey("WEAPON_COMBATPISTOL"),
                    quantity = 1,
                    type = "weapon",
                    weight = 15,
                    objectModel = "w_pi_combatpistol",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        { 
            name = "SNS Pistol",
            image = "https://vignette.wikia.nocookie.net/gtawiki/images/f/f5/SNSPistol-GTAV-SocialClub.png/revision/latest/scale-to-width-down/185?cb=20180202170333",
            requires = {
                { name = "SNS Pistol Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "SNS Pistol",
                    hash = GetHashKey("WEAPON_SNSPISTOL"),
                    quantity = 1,
                    type = "weapon",
                    weight = 8,
                    objectModel = "w_pi_sns_pistol",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        { 
            name = "Pistol",
            image = "https://steamuserimages-a.akamaihd.net/ugc/29613457985625199/0D5453A0ADC32EDBADEACF8D5CBE1EF129FCA5DC/",
            requires = {
                { name = "Pistol Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Pistol",
                    hash = GetHashKey("WEAPON_PISTOL"),
                    quantity = 1,
                    type = "weapon",
                    weight = 10,
                    objectModel = "w_pi_pistol",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        { 
            name = "Vintage Pistol",
            image = "https://i.pinimg.com/originals/3e/5b/09/3e5b09796cb124639c5f2232e5f32d9b.png",
            requires = {
                { name = "Vintage Pistol Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Vintage Pistol",
                    hash = GetHashKey("WEAPON_VINTAGEPISTOL"),
                    quantity = 1,
                    type = "weapon",
                    weight = 10,
                    objectModel = "w_pi_vintage_pistol",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        { 
            name = "Heavy Pistol",
            image = "https://i.imgur.com/weWweWG.png",
            requires = {
                { name = "Heavy Pistol Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Heavy Pistol",
                    hash = GetHashKey("WEAPON_HEAVYPISTOL"),
                    quantity = 1,
                    type = "weapon",
                    weight = 18,
                    objectModel = "w_pi_heavypistol",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        { 
            name = "Pistol .50",
            image = "https://i.imgur.com/W9sFoxi.png",
            requires = {
                { name = "Pistol .50 Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Pistol .50",
                    hash = GetHashKey("WEAPON_PISTOL50"),
                    quantity = 1,
                    type = "weapon",
                    weight = 19,
                    objectModel = "w_pi_pistol50",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        { 
            name = "Pump Shotgun",
            image = "https://steamuserimages-a.akamaihd.net/ugc/29613457985659003/1B48193086C05B7FB56FA9770E2507492F47B6DF/",
            requires = {
                { name = "Pump Shotgun Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Pump Shotgun",
                    hash = GetHashKey("WEAPON_PUMPSHOTGUN"),
                    quantity = 1,
                    type = "weapon",
                    weight = 30,
                    objectModel = "w_sg_pumpshotgun",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 2,
            type = "weapons"
        },
        { 
            name = "Sawn-off",
            image = "https://i.imgur.com/iJsQmRs.png",
            requires = {
                { name = "Sawn-off Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Sawn-off",
                    hash = GetHashKey("WEAPON_SAWNOFFSHOTGUN"),
                    quantity = 1,
                    type = "weapon",
                    weight = 20,
                    objectModel = "w_sg_sawnoffshotgun",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 2,
            type = "weapons"
        },
        { 
            name = "Heavy Shotgun",
            image = "https://i.imgur.com/JRP4gPv.png",
            requires = {
                { name = "Heavy Shotgun Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Heavy Shotgun",
                    hash = GetHashKey("WEAPON_HEAVYSHOTGUN"),
                    quantity = 1,
                    type = "weapon",
                    weight = 35,
                    objectModel = "w_sg_heavyshotgun",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 2,
            type = "weapons"
        },
        { 
            name = "AP Pistol",
            image = "https://i.pinimg.com/originals/3e/5b/09/3e5b09796cb124639c5f2232e5f32d9b.png",
            requires = {
                { name = "AP Pistol Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "AP Pistol",
                    hash = GetHashKey("WEAPON_APPISTOL"),
                    quantity = 1,
                    type = "weapon",
                    weight = 15,
                    objectModel = "w_pi_appistol",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 2,
            type = "weapons"
        },
        { 
            name = "Micro SMG",
            image = "https://i.imgur.com/yGbb2l5.png",
            requires = {
                { name = "Micro SMG Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Micro SMG",
                    hash = GetHashKey("WEAPON_MICROSMG"),
                    quantity = 1,
                    type = "weapon",
                    weight = 25,
                    objectModel = "w_sb_microsmg",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
        { 
            name = "SMG",
            image = "https://i.imgur.com/XbTVfAB.png",
            requires = {
                { name = "SMG Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "SMG",
                    hash = GetHashKey("WEAPON_SMG"),
                    quantity = 1,
                    type = "weapon",
                    weight = 35,
                    objectModel = "w_sb_smg",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
        { 
            name = "Tommy Gun",
            image = "https://www.gtabase.com/images/gta-5/weapons/machine-guns/gusenberg-sweeper.png",
            requires = {
                { name = "Tommy Gun Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Tommy Gun",
                    hash = GetHashKey("WEAPON_GUSENBERG"),
                    quantity = 1,
                    type = "weapon",
                    weight = 45,
                    objectModel = "w_sb_gusenberg",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
        { 
            name = "AK-47",
            image = "http://www.transparentpng.com/thumb/ak-47/icon-clipart-ak-47-12.png",
            requires = {
                { name = "AK-47 Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "AK47",
                    hash = GetHashKey("WEAPON_ASSAULTRIFLE"),
                    quantity = 1,
                    type = "weapon",
                    weight = 45,
                    objectModel = "w_ar_assaultrifle",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
        { 
            name = "Carbine",
            image = "http://www.gaksharpshooters.com/images/ar15.gif",
            requires = {
                { name = "Carbine Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Carbine",
                    hash = GetHashKey("WEAPON_CARBINERIFLE"),
                    quantity = 1,
                    type = "weapon",
                    weight = 45,
                    objectModel = "w_ar_carbinerifle",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
        { 
            name = "Compact Rifle",
            image = "https://i.imgur.com/38RjuhX.png",
            requires = {
                { name = "Compact Rifle Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Compact Rifle",
                    hash = GetHashKey("WEAPON_COMPACTRIFLE"),
                    quantity = 1,
                    type = "weapon",
                    weight = 45,
                    notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
        { 
            name = "Machine Pistol",
            image = "https://i.pinimg.com/originals/19/38/54/193854f15e38f4e13174e815c92de4e4.png",
            requires = {
                { name = "Machine Pistol Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Machine Pistol",
                    hash = GetHashKey("WEAPON_MACHINEPISTOL"),
                    quantity = 1,
                    type = "weapon",
                    weight = 20,
                    objectModel = "w_pi_pistol",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 2,
            type = "weapons"
        },
        { 
            name = "Hand Grenade",
            image = "https://static.wikia.nocookie.net/gtawiki/images/5/52/Grenade-GTAV.png/revision/latest?cb=20190809090848",
            requires = {
                { name = "Hand Grenade Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Hand Grenade",
                    hash = GetHashKey("WEAPON_GRENADE"),
                    quantity = 1,
                    type = "weapon",
                    weight = 10,
                    objectModel = "w_ex_grenadefrag",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 4,
            type = "weapons"
        },
    }
}

Config.CRAFT_KEY = 38

Config.CRAFT_STATION_OBJECT_DISTANCE = 100

Config.CRAFT_INTERACT_DISTANCE = 2

Config.Text = {
    CANCEL = "Cancel"
}

Config.Keys = {
    CANCEL = {code = 23, label = 'INPUT_ENTER'}
}

Config.DEFAULT_CRAFT_DURATION_SECONDS = 10 * 60

Config.MAX_FAIL_CHANCE = 0.60 -- max (and initial) chance to fail when crafting

Config.FAILURE_COEFFICIENT = 0.0058 -- the higher the number, the less chance of failing when crafting (should be < MAX_FAIL_CHANCE)

Config.LEVEL_1_MAX_CRAFT_COUNT = 50
Config.LEVEL_2_MAX_CRAFT_COUNT = 100
Config.LEVEL_3_MAX_CRAFT_COUNT = 150