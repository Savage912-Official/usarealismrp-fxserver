Config = {}

Config.craftingLocations = {
    {
        coords = vector3(-505.67352294922, -1759.0928955078, 17.644302368164), -- LS
        object = {
            model = "gr_prop_gr_bench_02b",
            heading = 160.0
        },
        type = "weapons"
    },
    {
        coords = vector3(-21.198345565796, 6662.040625, 30.004909515381), -- paleto
        object = {
            model = "gr_prop_gr_bench_02b",
            heading = 201.0
        },
        type = "weapons"
    },
    {
        coords = vector3(14.64, -2694.64, 5.01), -- Docks Bench
        object = {
            model = "prop_tool_bench02",
            heading = 0.0
        },
        type = "weapons"
    },
    {
        coords = vector3(2332.44, 3027.11, 47.16), -- Sandy Bench
        object = {
            model = "prop_toolchest_05",
            heading = 181.16

        },
        type = "weapons"
    },
    {
        coords = vector3(1110.321, -2006.447, 29.90479), -- refinery in LS
        type = "refineryGoods"
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
            name = "Ceramic Pistol",
            image = "https://i.imgur.com/zhZJdBq.png",
            requires = {
                { name = "Ceramic Pistol Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Ceramic Pistol",
                    hash = GetHashKey("WEAPON_CERAMICPISTOL"),
                    quantity = 1,
                    type = "weapon",
                    weight = 10,
                    objectModel = "w_pi_ceramic_pistol",
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
            name = "Hotwiring Kit",
            image = "https://i.imgur.com/JZtZKoP.png",
            requires = {
                { name = "Plastic", quantity = 2 },
                { name = "Copper Wire", quantity = 6 }
            },
            produces = {
                {
                    name = "Hotwiring Kit",
                    quantity = 1,
                    type = "misc",
                    weight = 10,
                }
            },
            requiredCraftingLevel = 1,
            type = "misc",
            craftDurationSeconds = 3 * 60
        },
        {
            name = "SNS Pistol Mk2",
            image = "https://i.imgur.com/kEiTXLt.png",
            requires = {
                { name = "SNS Pistol Parts", quantity = 2 }
            },
            produces = {
                {
                    name = "SNS Pistol Mk2",
                    hash = GetHashKey("WEAPON_SNSPISTOL_MK2"),
                    quantity = 1,
                    type = "weapon",
                    weight = 10,
                    objectModel = "w_pi_sns_pistolmk2",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 2,
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
            name = "Double Action Revolver",
            image = "https://i.imgur.com/zwIXqO3.png",
            requires = {
                { name = "Revolver Kit", quantity = 1 }
            },
            produces = {
                {
                    name = "Double Action Revolver",
                    hash = GetHashKey("WEAPON_DOUBLEACTION"),
                    quantity = 1,
                    type = "weapon",
                    weight = 18,
                    objectModel = "w_pi_wep1_gun",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        {
            name = "Navy Revolver",
            image = "https://i.imgur.com/VSqkAPp.png",
            requires = {
                { name = "Revolver Kit", quantity = 1 }
            },
            produces = {
                {
                    name = "Navy Revolver",
                    hash = GetHashKey("WEAPON_NAVYREVOLVER"),
                    quantity = 1,
                    type = "weapon",
                    weight = 15,
                    objectModel = "w_pi_wep2_gun",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        {
            name = "Revolver",
            image = "https://i.imgur.com/h1xuFdn.png",
            requires = {
                { name = "Revolver Kit", quantity = 1 }
            },
            produces = {
                {
                    name = "Revolver",
                    hash = GetHashKey("WEAPON_REVOLVER"),
                    quantity = 1,
                    type = "weapon",
                    weight = 20,
                    objectModel = "w_pi_revolver",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        {
            name = "Revolver Mk2",
            image = "https://i.imgur.com/GGjioEw.png",
            requires = {
                { name = "Revolver Kit", quantity = 2 }
            },
            produces = {
                {
                    name = "Revolver Mk2",
                    hash = GetHashKey("WEAPON_REVOLVER_MK2"),
                    quantity = 1,
                    type = "weapon",
                    weight = 22,
                    objectModel = "w_pi_revolvermk2",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 2,
            type = "weapons"
        },
        {
            name = "Marksman Pistol",
            image = "https://i.imgur.com/dIR4duM.png",
            requires = {
                { name = "Marksman Pistol Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Marksman Pistol",
                    hash = GetHashKey("WEAPON_MARKSMANPISTOL"),
                    quantity = 1,
                    type = "weapon",
                    weight = 15,
                    objectModel = "W_PI_SingleShot",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 2,
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
            name = "Double Barrel Shotgun",
            image = "https://i.imgur.com/cSRrM0R.png",
            requires = {
                { name = "Double Barrel Shotgun Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Double Barrel Shotgun",
                    hash = GetHashKey("WEAPON_DBSHOTGUN"),
                    quantity = 1,
                    type = "weapon",
                    weight = 35,
                    objectModel = "w_sg_doublebarrel",
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
            image = "https://i.imgur.com/bWKE4O6.png",
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
            name = "Assault SMG",
            image = "https://i.imgur.com/XbTVfAB.png",
            requires = {
                { name = "SMG Parts", quantity = 2 }
            },
            produces = {
                {
                    name = "Assault SMG",
                    hash = GetHashKey("WEAPON_ASSAULTSMG"),
                    quantity = 1,
                    type = "weapon",
                    weight = 40,
                    objectModel = "w_sb_assaultsmg",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
        {
            name = "Combat PDW",
            image = "https://i.imgur.com/wHbb0V4.png",
            requires = {
                { name = "Combat PDW Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Combat PDW",
                    hash = GetHashKey("WEAPON_COMBATPDW"),
                    quantity = 1,
                    type = "weapon",
                    weight = 30,
                    objectModel = "w_sb_pdw",
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
            name = "Tactical Carbine",
            image = "https://i.imgur.com/Z1OFXtU.png",
            requires = {
                { name = "Carbine Parts", quantity = 2 }
            },
            produces = {
                {
                    name = "Tactical Carbine",
                    hash = GetHashKey("WEAPON_TACTICALRIFLE"),
                    quantity = 1,
                    type = "weapon",
                    weight = 45,
                    objectModel = "w_ar_carbinerifle_reh",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
        {
            name = "Military Rifle",
            image = "https://i.imgur.com/5dInslW.png",
            requires = {
                { name = "Military Rifle Parts", quantity = 1 }
            },
            produces = {
                {
                    name = "Military Rifle",
                    hash = GetHashKey("WEAPON_MILITARYRIFLE"),
                    quantity = 1,
                    type = "weapon",
                    weight = 45,
                    objectModel = "w_ar_bullpuprifleh4",
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
                { name = "Metal Scraps", quantity = 2 },
                { name = "Black Powder", quantity = 3 }
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
        {
            name = "Mace",
            image = "https://i.imgur.com/EJoWdJ8.png",
            requires = {
                { name = "Metal Scraps", quantity = 1 },
                { name = "Metal Pipe", quantity = 1 }
            },
            produces = {
                {
                    name = "Mace",
                    hash = GetHashKey("WEAPON_MAZE"),
                    quantity = 1,
                    type = "weapon",
                    weight = 15,
                    objectModel = "w_me_bat",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 1,
            type = "weapons"
        },
        {
            name = "(10x) 7.62mm Bullets",
            image = "https://i.imgur.com/twK3t2s.png",
            requires = {
                { name = "7.62mm Shell Casing", quantity = 10 },
                { name = "Gun Powder", quantity = 1 }
            },
            produces = {
                {
                    name = "7.62mm Bullets",
                    quantity = 10,
                    type = "ammo",
                    weight = 0.25,
                    objectModel = "prop_ld_ammo_pack_03"
                }
            },
            requiredCraftingLevel = 1,
            type = "ammo",
            craftDurationSeconds = 3 * 60
        },
        {
            name = "(10x) 5.56mm Bullets",
            image = "https://i.imgur.com/ivr2Jcg.png",
            requires = {
                { name = "5.56mm Shell Casing", quantity = 10 },
                { name = "Gun Powder", quantity = 1 }
            },
            produces = {
                {
                    name = "5.56mm Bullets",
                    quantity = 10,
                    type = "ammo",
                    weight = 0.25,
                    objectModel = "prop_ld_ammo_pack_03"
                }
            },
            requiredCraftingLevel = 1,
            type = "ammo",
            craftDurationSeconds = 3 * 60
        },
        {
            name = "(10x) 9x18mm Bullets",
            image = "https://i.imgur.com/TFW3q4q.png",
            requires = {
                { name = "9x18mm Shell Casing", quantity = 10 },
                { name = "Gun Powder", quantity = 1 }
            },
            produces = {
                {
                    name = "9x18mm Bullets",
                    quantity = 10,
                    type = "ammo",
                    weight = 0.25,
                    objectModel = "prop_ld_ammo_pack_03"
                }
            },
            requiredCraftingLevel = 1,
            type = "ammo",
            craftDurationSeconds = 3 * 60
        },
        {
            name = "30 round Magazine (7.62mm)",
            image = "https://i.imgur.com/2AOnIid.png",
            requires = {
                { name = "Sheet Metal", quantity = 5 },
                { name = "Metal Spring", quantity = 1 }
            },
            produces = {
                {
                    name = "Empty 7.62mm Mag [30]",
                    quantity = 1,
                    type = "magazine",
                    weight = 5,
                    receives = "7.62mm",
                    MAX_CAPACITY = 30,
                    currentCapacity = 0,
                    objectModel = "w_ar_carbinerifle_mag1"
                }
            },
            requiredCraftingLevel = 1,
            type = "magazine",
            craftDurationSeconds = 2 * 60
        },
        {
            name = "30 round Magazine (5.56mm)",
            image = "https://i.imgur.com/9tK7cKI.png",
            requires = {
                { name = "Sheet Metal", quantity = 5 },
                { name = "Metal Spring", quantity = 1 }
            },
            produces = {
                {
                    name = "Empty 5.56mm Mag [30]",
                    quantity = 1,
                    type = "magazine",
                    weight = 5,
                    receives = "5.56mm",
                    MAX_CAPACITY = 30,
                    currentCapacity = 0,
                    objectModel = "w_ar_carbinerifle_mag1"
                }
            },
            requiredCraftingLevel = 1,
            type = "magazine",
            craftDurationSeconds = 2 * 60
        },
        {
            name = "18 round Magazine (9x18mm)",
            image = "https://i.imgur.com/brGIZW0.png",
            requires = {
                { name = "Sheet Metal", quantity = 2 },
                { name = "Metal Spring", quantity = 1 }
            },
            produces = {
                {
                    name = "Empty 9x18mm Mag [18]",
                    quantity = 1,
                    type = "magazine",
                    weight = 5,
                    receives = "9x18mm",
                    MAX_CAPACITY = 18,
                    currentCapacity = 0,
                    objectModel = "w_pi_heavypistol_mag2"
                }
            },
            requiredCraftingLevel = 1,
            type = "magazine",
            craftDurationSeconds = 1.5 * 60
        },
        {
            name = "Akorus",
            image = "https://i.imgur.com/5KYTXGp.png",
            requires = {
                { name = "Akorus Gun Cast", quantity = 1 },
                { name = "Metal Spring", quantity = 2 },
                { name = "Wood", quantity = 2 },
                { name = "Refined Gold", quantity = 2 },
                { name = "Knife", quantity = 1 }
            },
            produces = {
                {
                    name = "Akorus",
                    hash = GetHashKey("WEAPON_AKORUS"),
                    quantity = 1,
                    type = "weapon",
                    weight = 25,
                    objectModel = "w_ar_carbinerifle",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
        {
            name = "Revolver Ultra",
            image = "https://i.imgur.com/QK4SEq3.png",
            requires = {
                { name = "Revolver Ultra Gun Cast", quantity = 1 },
                { name = "Metal Spring", quantity = 1 },
                { name = "Wood", quantity = 1 },
                { name = "Refined Gold", quantity = 1 }
            },
            produces = {
                {
                    name = "Revolver Ultra",
                    hash = GetHashKey("WEAPON_REVOLVERULTRA"),
                    quantity = 1,
                    type = "weapon",
                    weight = 15,
                    objectModel = "w_pi_pistol",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
        {
          name = "FN SCAR SC",
          image = "https://i.imgur.com/m2C9Z7x.png",
          requires = {
              { name = "FN SCAR SC Gun Cast", quantity = 1 },
              { name = "Metal Spring", quantity = 3 },
              { name = "Steel", quantity = 6 },
              { name = "Aluminum", quantity = 3 },
          },
          produces = {
              {
                  name = "FN SCAR SC",
                  hash = GetHashKey("WEAPON_SCARSC"),
                  quantity = 1,
                  type = "weapon",
                  weight = 28,
                  objectModel = "w_sb_smg",
                  notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
        {
            name = "M4GoldBeast",
            image = "https://i.imgur.com/6YvspNA.png",
            requires = {
                { name = "M4GoldBeast Gun Cast", quantity = 1 },
                { name = "Metal Spring", quantity = 4 },
                { name = "Refined Gold", quantity = 7 },
                { name = "Aluminum", quantity = 2 },
            },
            produces = {
                {
                    name = "M4GoldBeast",
                    hash = GetHashKey("WEAPON_M4GOLDBEAST"),
                    quantity = 1,
                    type = "weapon",
                    weight = 30,
                    objectModel = "w_ar_m4goldbeast",
                    notStackable = true
                }
            },
            requiredCraftingLevel = 3,
            type = "weapons"
        },
    },
    refineryGoods = {
        {
            name = "Akorus Gun Cast",
            image = "https://i.imgur.com/3kvY24m.png",
            requires = {
                { name = "Steel", quantity = 3 },
                { name = "Refined Gold", quantity = 3 }
            },
            produces = {
                {
                    name = "Akorus Gun Cast",
                    quantity = 1,
                    type = "misc",
                    weight = 10
                }
            },
            requiredCraftingLevel = 1,
            type = "refineryGoods"
        },
        {
            name = "FN SCAR SC Gun Cast",
            image = "https://i.imgur.com/ICqVr4r.png",
            requires = {
                { name = "Steel", quantity = 6 }
            },
            produces = {
                {
                    name = "FN SCAR SC Gun Cast",
                    quantity = 1,
                    type = "misc",
                    weight = 10
                }
            },
            requiredCraftingLevel = 1,
            type = "refineryGoods"
        },
        {
            name = "Revolver Ultra Gun Cast",
            image = "https://i.imgur.com/l1nvTAE.png",
            requires = {
                { name = "Steel", quantity = 2 },
                { name = "Refined Gold", quantity = 1 }
            },
            produces = {
                {
                    name = "Revolver Ultra Gun Cast",
                    quantity = 1,
                    type = "misc",
                    weight = 10
                }
            },
            requiredCraftingLevel = 1,
            type = "refineryGoods"
        },
        {
            name = "M4GoldBeast Gun Cast",
            image = "https://i.imgur.com/3kvY24m.png",
            requires = {
                { name = "Steel", quantity = 5 },
                { name = "Refined Gold", quantity = 5 }
            },
            produces = {
                {
                    name = "M4GoldBeast Gun Cast",
                    quantity = 1,
                    type = "misc",
                    weight = 10
                }
            },
            requiredCraftingLevel = 1,
            type = "refineryGoods"
        },
        {
            name = "Steel",
            image = "https://i.imgur.com/o4sROlT.png",
            requires = {
                { name = "Iron", quantity = 5 },
            },
            produces = {
                {
                    name = "Steel",
                    quantity = 1,
                    type = "misc",
                    weight = 7
                }
            },
            requiredCraftingLevel = 1,
            type = "refineryGoods",
            craftDurationSeconds = 4 * 60
        },
        {
            name = "Refined Gold",
            image = "https://i.imgur.com/QYthPRN.png",
            requires = {
                { name = "Gold", quantity = 5 },
            },
            produces = {
                {
                    name = "Refined Gold",
                    quantity = 1,
                    type = "misc",
                    weight = 10
                }
            },
            requiredCraftingLevel = 1,
            type = "refineryGoods",
            craftDurationSeconds = 5 * 60
        },
        {
            name = "Plastic",
            image = "https://imgur.com/2LLDroM.png",
            requires = {
                { name = "Crude Oil", quantity = 1 },
            },
            produces = {
                {
                    name = "Plastic",
                    quantity = 2,
                    type = "misc",
                    weight = 2
                }
            },
            requiredCraftingLevel = 1,
            type = "refineryGoods",
            craftDurationSeconds = 4 * 60
        },
        {
            name = "Copper Wire",
            image = "https://i.imgur.com/aVnjUSE.png",
            requires = {
                { name = "Copper", quantity = 2 },
            },
            produces = {
                {
                    name = "Copper Wire",
                    quantity = 3,
                    type = "misc",
                    weight = 3
                }
            },
            requiredCraftingLevel = 1,
            type = "refineryGoods",
            craftDurationSeconds = 4 * 60
        },
        {
            name = "Aluminum",
            image = "https://i.imgur.com/o4sROlT.png",
            requires = {
                { name = "Bauxite", quantity = 5 },
            },
            produces = {
                {
                    name = "Aluminum",
                    quantity = 1,
                    type = "misc",
                    weight = 5
                }
            },
            requiredCraftingLevel = 1,
            type = "refineryGoods",
            craftDurationSeconds = 4 * 60
        }
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

Config.DEFAULT_CRAFT_DURATION_SECONDS = 8 * 60

Config.MAX_FAIL_CHANCE = 0.60 -- max (and initial) chance to fail when crafting

Config.FAILURE_COEFFICIENT = 0.0058 -- the higher the number, the less chance of failing when crafting (should be < MAX_FAIL_CHANCE)

Config.LEVEL_1_MAX_CRAFT_COUNT = 50
Config.LEVEL_2_MAX_CRAFT_COUNT = 150
Config.LEVEL_3_MAX_CRAFT_COUNT = 250
