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
    Delay = 1200,--In Seconds (20 Minutes)
    Locations = {
        ["ALL"] = {
            [1] = {
                position = vector3(122.14, -223.04, 54.56),--Clothes shop
                location = "Clothes Shop",
                flames = 20,
                spread = 15,
                type = "normal",
                timeout = 300--In Seconds
            },
            [2] = {
                position = vector3(-41.45, -1097.81, 26.42),--Dealership
                location = "Dealer Ship",
                flames = 20,
                spread = 15,
                type = "electrical",
                timeout = 300--In Seconds
            },
            [3] = {
                position = vector3(265.09, -1259.29, 29.14),--Gas Station
                location = "Gas Station",
                flames = 20,
                spread = 15,
                type = "chemical",
                timeout = 300--In Seconds
            },
            [4] = {
                position = vector3(855.61, -285.82, 65.52),--Skate Park
                location = "Skate Park",
                flames = 20,
                spread = 20,
                type = "bonfire",
                timeout = 300--In Seconds
            },
            [5] = {
                position = vector3(1963.77, 3744.05, 32.34),--24/7
                location = "24/7",
                flames = 10,
                spread = 5,
                type = "normal2",
                timeout = 300--In Seconds
            },
            [6] = {
                position = vector3(-92.22, 6415.5, 31.47),--Gas Station
                location = "Gas Station",
                flames = 20,
                spread = 10,
                type = "normal2",
                timeout = 300--In Seconds
            },
            [7] = {
                position = vector3(1516.6372, -2132.9355, 76.5944),-- Oil Field Warehouse 1
                location = "Oil Field Warehouse",
                flames = 30,
                spread = 50,
                type = "chemical",
                timeout = 300--In Seconds
            },
            [8] = {
                position = vector3(456.7436, -706.7481, 27.3591),-- Market near bus depot
                location = "Market",
                flames = 30,
                spread = 50,
                type = "normal",
                timeout = 300--In Seconds
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
