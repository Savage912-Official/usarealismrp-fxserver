Config = {}

--Max Amount Of Fires At Once
Config.MaxFires = 10
--Max Flames That Can Be Created Via Command
Config.MaxFlames = 30
--Max Spread That Can Be Created Via Command
Config.MaxSpread = 50

--Discord Webhooks
Config.Discord = {
    UseWebHooks = true,
    WEB_HOOK = GetConvar("fire-log-webhook", ""),
    STEAM_API = "",
    WEB_IMAGE = "http://lslrpc.weebly.com/uploads/3/8/7/8/38783037/6642822_orig.jpg",
    BOT_NAME = "Los Santos Fire Dispatch Service",
}


--This Is The Fire Blips
--Check https://docs.fivem.net/docs/game-references/blips/ For The Blip Sprites And Colors
Config.FireWarnings = {
    Ping = {
        Enabled = true,
        Radius = 40.0,
        FadeTimer = 40,
        Color = 1,--Color 1 Is Red
        StartAlpha = 255,--Alpha Is The Opacity
    },
    Blip = {
        Enabled = true,
        Name = "Active Fire",
        Sprite = 436,
        Color = 1,--Color 1 Is Red
        Alpha = 255,--Alpha Is The Opacity
    },
    Message = {
        Enabled = false,
    }
}

--Lifetime is the life of the flame, how hard it is to take out
--Some flames are considered a fire on their own which makes them not affected by water, add isFireScript = true to fix that
--The Smoke is added after or before the flame is out, and the timeout is the amount of time it stays
Config.FireTypes = {
    ["normal"] = {
        dict = "scr_trevor3", 
        part = "scr_trev3_trailer_plume", 
        scale = 0.7, 
        lifetime = 5, 
        zoffset = 0.4, 
        isFireScript = false,
        smoke = {
            dict = "core",
            part = "ent_amb_stoner_vent_smoke",
            scale = 1,
            timeout = 15,--In Seconds
            playduring = true,
            playafter = true,
            zoffset = 1.0
        }
    },
    ["normal2"] = {
        dict = "core", 
        part = "fire_wrecked_truck_vent", 
        scale = 3, 
        lifetime = 6, 
        zoffset = 0.4, 
        isFireScript = false,
        smoke = {
            dict = "core",
            part = "ent_amb_smoke_factory_white",
            scale = 1,
            timeout = 15,--In Seconds
            playduring = true,
            playafter = true,
            zoffset = 0.0
        }
    },
    ["chemical"] = {
        dict = "core", 
        part = "fire_petroltank_truck", 
        scale = 4, 
        lifetime = 8, 
        zoffset = 0.0, 
        isFireScript = false,
        smoke = {
            dict = "core",
            part = "ent_amb_smoke_general",
            scale = 1,
            timeout = 15,--In Seconds
            playduring = true,
            playafter = true,
            zoffset = 1.0
        }
    },
    ["electrical"] = {
        dict = "core", 
        part = "ent_ray_meth_fires", 
        scale = 1, 
        lifetime = 10, 
        zoffset = 0.0, 
        isFireScript = true,
        smoke = {
            dict = "core",
            part = "ent_amb_smoke_foundry",
            scale = 1,
            timeout = 15,--In Seconds
            playduring = true,
            playafter = true,
            zoffset = 1.0
        }
    },
    ["bonfire"] = {
        dict = "scr_michael2", 
        part = "scr_mich3_heli_fire", 
        scale = 1, 
        lifetime = 12, 
        zoffset = 0.0, 
        isFireScript = true,
        smoke = {
            dict = "scr_agencyheistb",
            part = "scr_env_agency3b_smoke",
            scale = 1,
            timeout = 15,--In Seconds
            playduring = true,
            playafter = true,
            zoffset = 1.0
        }
    }
}

--Random Fires Configurations
--Select The Type From The Fire Types
--Fire timeout is to set the fire off if it hasn't been taken out
Config.RandomFires = {
    Enabled = true,
    AOP = "ALL",--Current AOP
    Delay = 45 * 60,--In Seconds (20 Minutes)
    Locations = {
        ["ALL"] = {
            [1] = {
                position = vector3(122.14, -223.04, 54.56),-- Hawick Ave Clothes shop
                location = "Clothes Shop",
                flames = 20,
                spread = 15,
                type = "normal",
                timeout = 1800--In Seconds
            },
            [2] = {
                position = vector3(-41.45, -1097.81, 26.42),-- Power Street PDM
                location = "Dealer Ship",
                flames = 20,
                spread = 15,
                type = "electrical",
                timeout = 1800--In Seconds
            },
            [3] = {
                position = vector3(265.09, -1259.29, 29.14),-- Strawberry Ave Gas Station
                location = "Gas Station",
                flames = 20,
                spread = 15,
                type = "chemical",
                timeout = 1800--In Seconds
            },
            [4] = {
                position = vector3(855.61, -285.82, 65.52),-- Mirror Park Skate Park
                location = "Skate Park",
                flames = 20,
                spread = 20,
                type = "bonfire",
                timeout = 1800--In Seconds
            },
            [5] = {
                position = vector3(1963.77, 3744.05, 32.34),-- Sandy Shores 24/7
                location = "24/7",
                flames = 10,
                spread = 5,
                type = "normal2",
                timeout = 1800--In Seconds
            },
            [6] = {
                position = vector3(-92.22, 6415.5, 31.47),-- Paleto Gas Station 2
                location = "Gas Station",
                flames = 20,
                spread = 10,
                type = "normal2",
                timeout = 1800--In Seconds
            },
            [7] = {
                position = vector3(1516.6372, -2132.9355, 76.5944),-- Oil Field Warehouse 1
                location = "Oil Field Warehouse",
                flames = 30,
                spread = 50,
                type = "chemical",
                timeout = 1800--In Seconds
            },
            [8] = {
                position = vector3(456.7436, -706.7481, 27.3591),-- Market near bus depot
                location = "Market",
                flames = 30,
                spread = 50,
                type = "normal",
                timeout = 1800--In Seconds
            },
            [9] = {
                position = vector3(265.09, -1259.29, 29.14),-- Paleto Beeker's Garage
                location = "Beeker's Garage",
                flames = 12,
                spread = 12,
                type = "electrical",
                timeout = 1800--In Seconds
            },
            [10] = {
                position = vector3(108.39610290527, 6623.6181640625, 32.147254943848),-- Paleto Barn
                location = "Paleto Barn",
                flames = 20,
                spread = 15,
                type = "bonfire",
                timeout = 1800--In Seconds
            },
            [11] = {
                position = vector3(1392.1604003906, 3607.5544433594, 34.980926513672),-- Sandy Shores Ace Liquor
                location = "Ace Liquor (Sandy Shores)",
                flames = 15,
                spread = 10,
                type = "chemical",
                timeout = 1800--In Seconds
            },
            [12] = {
                position = vector3(1704.1232910156, 4928.2387695313, 42.063655853271),-- Grapeseed 24/7
                location = "24/7",
                flames = 12,
                spread = 10,
                type = "normal2",
                timeout = 1800--In Seconds
            },
            [13] = {
                position = vector3(544.46264648438, 2668.3549804688, 42.156497955322),-- Route 68 Harmony 24/7
                location = "24/7",
                flames = 12,
                spread = 10,
                type = "normal2",
                timeout = 1800--In Seconds
            },
            [14] = {
                position = vector3(-49.901699066162, -1753.2320556641, 29.421012878418),-- Grove Street 24/7
                location = "24/7",
                flames = 12,
                spread = 10,
                type = "normal2",
                timeout = 1800--In Seconds
            },
            [15] = {
                position = vector3(1208.4333496094, -1402.3386230469, 35.224136352539),-- Capital Blvd / El Rancho Gas Station
                location = "Gas Station",
                flames = 12,
                spread = 10,
                type = "chemical",
                timeout = 1800--In Seconds
            },
            [16] = {
                position = vector3(-1282.7576904297, -1117.6591796875, 7.1229777336121),-- Magellan Ave Barber Shop
                location = "Barber Shop",
                flames = 5,
                spread = 5,
                type = "normal",
                timeout = 1800--In Seconds
            },
            [17] = {
                position = vector3(-1154.1593017578, -1426.3848876953, 4.9544644355774),-- Aguja St / Magellan Ave Tattoo Shop
                location = "Tattoo Shop",
                flames = 5,
                spread = 5,
                type = "normal2",
                timeout = 1800--In Seconds
            },
            [18] = {
                position = vector3(1137.71875, -981.96752929688, 46.41580581665),-- El Rancho Blvd Market
                location = "Market",
                flames = 5,
                spread = 5,
                type = "normal2",
                timeout = 1800--In Seconds
            },
            [19] = {
                position = vector3(119.16149902344, -1287.7004394531, 28.26739692688),-- Vanilla Unicorn
                location = "Vanilla Unicorn",
                flames = 25,
                spread = 20,
                type = "electrical",
                timeout = 1800--In Seconds
            },
            [20] = {
                position = vector3(-1223.8106689453, -906.42492675781, 12.326354980469),-- San Andreas Ave Market (By Burger Shot)
                location = "Market",
                flames = 10,
                spread = 5,
                type = "normal2",
                timeout = 1800--In Seconds
            },
            [21] = {
                position = vector3(424.15344238281, -802.36499023438, 29.491140365601),-- Sinner Street Clothes Shop (By MRPD)
                location = "Clothes Shop",
                flames = 10,
                spread = 8,
                type = "electrical",
                timeout = 1800--In Seconds
            },
            [22] = {
                position = vector3(-813.43200683594, -183.6900177002, 37.568893432617),-- Mad Wayne Thunder Drive Barber Shop
                location = "Barber Shop",
                flames = 5,
                spread = 5,
                type = "electrical",
                timeout = 1800--In Seconds
            },
            [23] = {
                position = vector3(-1189.3211669922, -888.55059814453, 13.803347587585),-- Burger Shot
                location = "Burger Shot",
                flames = 15,
                spread = 10,
                type = "electrical",
                timeout = 1800--In Seconds
            },
            [24] = {
                position = vector3(284.23443603516, -587.33441162109, 43.378082275391),-- Pillbox Hospital
                location = "Pillbox Hospital",
                flames = 15,
                spread = 10,
                type = "normal",
                timeout = 1800--In Seconds
            },
        },
    }
}


--[[Smoke Particles
This is more of a spark for like an electric fire
smokedict = "core",
smokepart = "ent_amb_elec_crackle",

smokedict = "scr_agencyheistb",
smokepart = "scr_env_agency3b_smoke",

smokedict = "core",
smokepart = "ent_amb_stoner_vent_smoke",

smokedict = "core",
smokepart = "ent_amb_smoke_general",

smokedict = "core",
smokepart = "ent_amb_smoke_foundry",

smokedict = "core",
smokepart = "ent_amb_smoke_factory_white",

This is a large white fog
smokedict = "core",
smokepart = "ent_amb_fbi_smoke_fogball",

smokedict = "core",
smokepart = "ent_amb_generator_smoke",
]]--
