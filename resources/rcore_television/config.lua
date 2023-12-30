Config = {}

-- 0 standalone
-- 1 ESX
-- 2 QBCore
Config.FrameWork = 0

-- 1 = raycast (whitedot in center of the screen)
-- 2 = E click on keyboard only.
Config.DetectorType = 1

-- i will leave this function open, just in case you had anticheat.
Config.SetPlayerInvisible = function()
    --local ped = PlayerPedId()
    --SetEntityLocallyInvisible(ped)
end

Config.QBCoreObject = "QBCore:GetObject"

-- is the script es_extended based?
Config.ESX_Object = "esx:getSharedObject"

-- event for player loaded
Config.EsxPlayerLoaded = "esx:playerLoaded"

-- event for setJob
Config.EsxSetJob = "esx:setJob"

-- event for player loaded
Config.OnPlayerLoaded = "QBCore:Client:OnPlayerLoaded"

-- event for setJob
Config.OnJobUpdate = "QBCore:Client:OnJobUpdate"

-- will enable debug print and stuff
Config.Debug = false

-- will type start and end of events + nui callbacks
Config.FunctionsDebug = false

-- Will print in what type of thing error has happened.. Example CreateThread, RegisterNetEvent, RegisterCommand, etc.
Config.GeneralDebug = false

-- a command to set volume for TV
Config.volumeCommand = "tvvolume"

-- a command to change TV channel
Config.playUrl = "playlink"

-- a key to open television
Config.keyOpenTV = "E"

-- a key to select program in TV menu
Config.keyToSelectProgram = "RETURN" -- is enter

-- a keys to leave TV menu
Config.keyToLeaveMenu = "BACK"
Config.secondKeyToLeaveMenu = "escape"

-- a keys to stop current TV program
Config.keyToStopChannel = "SPACE"

-- Default youtube playing volume
-- Only goes for youtube...
Config.defaultVolume = 40

-- i dont recommend to change this number
-- how far away TV can be visible
Config.visibleDistance = 10

-- if you want have whitelist to prevent troll links keep this on true.
-- i dont recommend turning this option off, people just can use
-- shortcut url and the system wont know that it is on blacklist etc.
Config.useWhitelist = true

-- Message list
-- the command for this is /streamertelevision
Config.Messages = {
    ["streamer_on"] = "Streamer mode is on. From now you will not hear any music/sound from any TV.",
    ["streamer_off"] = "Streamer mode is off. From now you will be able to watch any TV.",
}

-- list of scaleform to use to televison
-- the more there is = the more television can be active on single place
-- the hard limit should be 15? i think?
-- keep the value on false.
Config.ScaleFormLists = {
    ["television_scaleform_1"] = false,
    ["television_scaleform_2"] = false,
    ["television_scaleform_3"] = false,
    ["television_scaleform_4"] = false,
    ["television_scaleform_5"] = false,
    ["television_scaleform_6"] = false,
    ["television_scaleform_7"] = false,
}

-- what website are allowed to put on tv ?
Config.whitelisted = {
    "youtube",
    "youtu.be",
    "twitch",
    ".mp3",
    "wav",
    "mp4",
    "webm",
    "ogg",
    "ogv",
}

-- Black list urls
Config.blackListed = {
    "pornhub",
    "sex-slave",
    "cryzysek"
}

function split(text, sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    text:gsub(pattern, function(c)
        fields[#fields + 1] = c
    end)
    return fields
end

-- if you need complet redirect for some reason then you can do it here
Config.CompletRedirect = {
    -- i have not found other solution how to play twitch from this, so redirect is one option for me now.
    ["twitch"] = function(url, time, volume)
        local newUrl = split(url, "/")
        newUrl = "https://player.twitch.tv/?channel=" .. newUrl[#newUrl] .. "&parent=localhost&volume=" .. ((volume or 30) / 100)
        return newUrl
    end,
    ["youtube"] = function(url, time, volume)
        return "https://proxy.rcore.cz/v2.html?url=" .. url .. "&volume=" .. (volume or 30) .. "&time=" .. (time or 0)
    end,
    ["youtu.be"] = function(url, time, volume)
        return "https://proxy.rcore.cz/v2.html?url=" .. url .. "&volume=" .. (volume or 30) .. "&time=" .. (time or 0)
    end,
}

-- will get called each second because I have not found better way.
Config.ClickOnScreen = {
    ["twitch"] = function(duiObj)
        -- will accept the "i am over 18 hell yeah"
        SendDuiMouseMove(duiObj, 870, 605)
        SendDuiMouseDown(duiObj, "left")
        SendDuiMouseUp(duiObj, "left")
    end,
}

-- if the pasted URL contains one of the words bellow it will redirect it to
-- html/support/DEFINED VALUE/index.html so you can make your own support
-- to another website.
Config.CustomSupport = {
    -- youtube
    ["youtube"] = "youtube",
    ["youtu.be"] = "youtube",

    -- sound
    -- i do not recommend using .ogg there atleast small amout of video format that can be played.
    -- also who uses ogg for music ? right ?
    [".mp3"] = "music",
    [".wav"] = "music",

    -- videos
    [".mp4"] = "video",
    [".webm"] = "video",
    [".ogg"] = "video",
    [".ogv"] = "video",
}

-- you can blacklist here the SendDUIMessage about player position for example
-- if you're streaming picture so there isnt any reason to send the DUI message about position right?
Config.IgnorePositionUpdateCustomSupport = {
    ["youtube"] = true,
    ["menu"] = true,
    ["other"] = true,
}

-- this will disable forever poping  the scaleform at some point fivem update broke this
-- but to make sure I am leaving the option here just in case it wasnt working
-- for now it will ne enabled
-- false value = enabled poping
-- true value = disabled
Config.ScaleformPop = true

-- this will allow networked objects to be streamed on (possible that they can move)
-- this feature is in work-in-progress it can have some unwanted bugs!
Config.AllowNetworkedObjects = false

-- list of default videos for TV.. you have to manualy change it in html/menu.html aswell
Config.listVideos = {
    [1] = {
        name = "Flute Tune",
        icon = "fa fa-newspaper-o",
        url = "https://www.youtube.com/watch?v=X2cl6_DVpFI"
    },
    [2] = {
        name = "MP3",
        icon = "fas fa-cat",
        url = "https://cdn.discordapp.com/attachments/764626395526856734/820803615949848576/Initial_D_-_Deja_Vu.mp3"
    },
    [3] = {
        name = "Video 3",
        icon = "fas fa-city",
        url = ""
    },
    [4] = {
        name = "Video 4",
        icon = "fas fa-hourglass-half",
        url = ""
    },
    [5] = {
        name = "Video 5",
        icon = "fas fa-grin-beam",
        url = ""
    },
    [6] = {
        name = "Video 6",
        icon = "fas fa-skull-crossbones",
        url = ""
    },
}

function PlayWearAnimation()
    local ped = PlayerPedId()
    local dict, anim = "gestures@m@standing@casual", "gesture_damn"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(33)
    end

    TaskPlayAnim(ped, dict, anim, 8.0, 1.0, -1, 48, 0.0, false, false, false)
end

-- this will create television at defined coords with default URL.
Config.PlayingTelevisionOnLocation = {
    --["random_uniqid"] = {
    --    ModelHash = GetHashKey("prop_tv_flat_michael"),
    --    Position = vector3(0, 0, 0),
    --    Heading = 180.0,
    --
    --    URL = "https://www.youtube.com/watch?v=oqwKTKbsINY", -- will ignore the whitelist / blacklist since only a dev can add this.
    --
    --    -- There is variable "time" which getting called in NUI / complet redirect, so should it count?
    --    -- true = wont
    --    -- false = will count
    --    DisableCountTime = false,
    --    DisableInteraction = true,
    --},

    ["some_tv_uniq_id"] = {
        ModelHash = GetHashKey("prop_tv_flat_michael"),
        Position = vector3(459.02, -983.5, 31.2),
        Heading = 180.0,

        URL = "nui://rcore_television/html/custom/menu/index.html", -- will ignore the whitelist / blacklist since only a dev can add this.

        Job = {
            ["police"] = { "*" },
            ["ambulance"] = { "grade1", "grade2", "grade3" }
        },

        -- this table will get send to the DUI message, which mean you can build your custom html menu or whatever you would love to.
        Items = {
            [0] = {
                Label = "Wear bulletproof vest",
                CallBack = function()
                    SetPedArmour(PlayerPedId(), 100)
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        skin.bproof_1 = 20
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)

                    PlayWearAnimation()
                end,

                CloseAfterUse = true,
            },
            [1] = {
                Label = "Take it off",
                CallBack = function()
                    SetPedArmour(PlayerPedId(), 0)
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        skin.bproof_1 = -1
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)

                    PlayWearAnimation()
                end,

                CloseAfterUse = true,
            },
        },

        -- There is variable "time" which getting called in NUI / complet redirect, so should it count?
        -- true = wont
        -- false = will count
        DisableCountTime = true,
    },
}

Config.ReplaceObjects = {
    {
        pos = vector3(-54.47, -1087.27, 27.27),
        radius = 2.0,
        originalModelHash = 1036195894,
        newModelHash = GetHashKey("prop_tv_flat_01"),
    }
}

-- this will create television on coords that can be used by other folks
Config.CreateTelevisionModelOnCoords = {
    {
        ModelHash = GetHashKey("prop_tv_flat_01"),
        Position = vector3(-921.48, -1181.22, -0.38),
        Heading = 300.00,
    },
}

-- if this is set to true it will preload one scaleform of television if some users experiencing bad loading
Config.UsePreloaded = true

-- Do not switch to true use command /tveditor
Config.Editor = false

-- default open distance from the model
Config.DefaultOpenDistance = 1.5

-- i wouldn't recommend to change anything there unless you know what you're doing
Config.resolution = {
    [1036195894] = {
        ['ScreenSize'] = vec3(0.000000, 0.000000, 0.000000),
        ['Job'] = nil,
        ['CameraOffSet'] = {
            ['y'] = -3.0,
            ['z'] = 0.35,
            ['rotationOffset'] = vec3(0.000000, 0.000000, 0.000000),
            ['x'] = 0.0
        },
        ['distance'] = 10,
        ['distanceToOpen'] = 1.5,
        ['ScreenOffSet'] = vec3(-1.045570, -0.069395, 1.058675),
        ['ItemToOpen'] = nil
    },

    [1522819744] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(7.036000, 0.572270, 3.442090),
        ScreenSize = vector3(0.767885, 0.027010, 0.0),
        rotationOffset = vector3(0, 0, 0),

        distanceToOpen = 10.0,
        distance = 30.0,
        CameraOffSet = {
            x = 0.0,
            y = 12.0,
            z = 0.2,
            rotationOffset = vector3(0, 0, 180),
        },
    },

    [GetHashKey("ch_prop_ch_tv_rt_01a")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.090645, 1.413200, 0.885070),
        ScreenSize = vector3(0.894370, 0.503975, 0.0),
        rotationOffset = vector3(0, 0, 90), -- rotation of scaleform

        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = -3.0,
            y = 0.0,
            z = 0.2,
            rotationOffset = vector3(0, 0, 90), -- rotation of camera
        },
    },

    [GetHashKey("prop_monitor_w_large")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(0.373000, -0.076500, 0.622000),
        ScreenSize = vector3(-0.000685, -0.001575, 0),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.0,
            y = -1.0,
            z = 0.4,
        },
    },
    [GetHashKey("apa_mp_h_str_avunitl_04")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.291720, -0.407225, 2.083020),
        ScreenSize = vector3(0.081970, 0.046270, 0.0),

        --ScreenOffSet = vector3(-0.335, -0.409, 2.074),
        --ScreenSize = vector3(0.081, 0.047, 0.090),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.6,
            y = -2.7,
            z = 1.2,
        },
    },
    [GetHashKey("prop_monitor_01b")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.240, -0.084, 0.449),
        ScreenSize = vector3(0, 0, 0),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.1,
            rotationOffset = vector3(0, 0, 0),
        },
    },

    [GetHashKey("apa_mp_h_str_avunitl_01_b")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.471, -0.130, 1.941),
        ScreenSize = vector3(0.075, 0.042, 0.038),
        distanceToOpen = 3.0,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.5,
            y = -3.0,
            z = 1.20,
        },
    },
    [GetHashKey("ex_prop_ex_tv_flat_01")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-1.049, -0.062, 1.072),
        ScreenSize = vector3(-0.0, -0.0, -0.025),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.0,
            y = -2.0,
            z = 0.40,
        },
    },
    [-1833573429] = {
        ['CameraOffSet'] = {
            ['rotationOffset'] = vec3(0.000000, 0.000000, 0.000000),
            ['x'] = 0.0,
            ['y'] = -5.0,
            ['z'] = -1.0
        },
        ['distance'] = 10,
        ['distanceToOpen'] = 4.0,
        ['ScreenSize'] = vec3(0.020170, 0.024115, 0.000000),
        ['ScreenOffSet'] = vec3(-1.994405, -0.056000, 0.000000),
        ['Job'] = nil,
        ['ItemToOpen'] = nil
    },
    [GetHashKey("prop_huge_display_01")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-5.110, -0.105, 3.640),
        ScreenSize = vector3(0.04, 0.025, 0.0),
        distanceToOpen = 15.0,
        distance = 30.0,
        CameraOffSet = {
            x = -0.6,
            y = -15.9,
            z = 1.0,
            rotation = vector3(0, 0, 0),
        },
    },
    [GetHashKey("prop_cs_tv_stand")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.552, -0.080, 1.553),
        ScreenSize = vector3(0.0045, 0.004, 0.001),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.0,
            y = -1.0,
            z = 1.23,
        },
    },
    [GetHashKey("v_ilev_cin_screen")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-6.967, -0.535, 2.821),
        ScreenSize = vector3(-0.009, 0.057, 0),
        distanceToOpen = 15.0,
        distance = 30.0,
        CameraOffSet = {
            x = 0.15,
            y = -10.7,
            z = 0.5,
        },
    },
    [GetHashKey("sm_prop_smug_tv_flat_01")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.682, -0.043, 0.978),
        ScreenSize = vector3(-0.0045, -0.0025, -0.006),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.15,
            y = -2.7,
            z = 0.5,
        },
    },
    [GetHashKey("prop_trev_tv_01")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.26, -0.01, 0.28),
        ScreenSize = vector3(0.0035, 0.002, 0.0135),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.0,
            y = -1.0,
            z = 0.1,
        },
    },
    [GetHashKey("prop_tv_02")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.20, -0.10, 0.19),
        ScreenSize = vector3(0.005, 0.0, 0.0135),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    [GetHashKey("prop_tv_03")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.35, -0.11, 0.22),
        ScreenSize = vector3(0.008, 0.003, 0.0355),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    [GetHashKey("prop_tv_03_overlay")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.36, -0.11, 0.21),
        ScreenSize = vector3(0.0009, 0.0005, 0.036),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    [GetHashKey("prop_tv_04")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(0, 0, 0),
        ScreenSize = vector3(0, 0, 0),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    [GetHashKey("prop_tv_06")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.34, -0.09, 0.25),
        ScreenSize = vector3(0.0055, 0.0025, 0.0385),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    [GetHashKey("prop_tv_flat_01_screen")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-1.04, -0.06, 1.06),
        ScreenSize = vector3(-0.0055, -0.0035, 0.0735),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.15,
            y = -2.7,
            z = 0.5,
        },
    },
    [GetHashKey("prop_tv_flat_02")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.55, -0.01, 0.57),
        ScreenSize = vector3(0.00049, -0.0005, 0.073),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.5,
            z = 0.25,
        },
    },
    [GetHashKey("prop_tv_flat_02b")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.55, -0.01, 0.57),
        ScreenSize = vector3(0.00049, -0.0005, 0.073),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.5,
            z = 0.25,
        },
    },
    [GetHashKey("prop_tv_flat_03")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.335, -0.008, 0.412),
        ScreenSize = vector3(-0.0005, 0.0, 0.0745),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.2,
        },
    },
    [GetHashKey("prop_tv_flat_03b")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.335, -0.065, 0.211),
        ScreenSize = vector3(0.003, 0.002, 0.002),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    [GetHashKey("apa_mp_h_str_avunits_01")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-1.012, -0.302, 2.085),
        ScreenSize = vector3(0.023, 0.014, 0.004),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = -0.1,
            y = -2.7,
            z = 1.2,
        },
    },
    [GetHashKey("hei_heist_str_avunitl_03")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-1.197, -0.372, 2.089),
        ScreenSize = vector3(0.071, 0.037, 0.094),
        distanceToOpen = Config.DefaultOpenDistance + 1.0,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = -0.1,
            y = -2.7,
            z = 1.2,
        },
    },
    [GetHashKey("prop_tv_flat_michael")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-0.711, -0.067, 0.441),
        ScreenSize = vector3(0.0056, 0.0036, 0.0),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.15,
            y = -2.7,
            z = 0.1,
        },
    },
    [GetHashKey("prop_tv_test")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(0, 0, 0),
        ScreenSize = vector3(0, 0, 0),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.1,
        },
    },

    [GetHashKey("xm_prop_x17_tv_flat_02")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-1.049, -0.049, 1.068),
        ScreenSize = vector3(0, 0, 0),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -3.0,
            z = 0.4,
        },
    },

    -- i dont recommend using this.. i have no idea if this TV is on more location
    -- than Michael house.. if there is just one TV then go ahead enable it.
    [GetHashKey("des_tvsmash_start")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(0.096, -1.010, 0.940),
        ScreenSize = vector3(0.009, 0.004, 0.004),
        rotationOffset = vector3(0, 0, -90),

        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 2.7,
            y = 0.1,
            z = 0.4,
            rotationOffset = vector3(0, 0, -90),
        },
    },

    -- i dont recommend to enable this.. you need to swap model to get this working.
    -- if you know what you're doing.. swap this model: v_ilev_mm_scre_off to this one v_ilev_mm_screen2
    -- with function "CreateModelSwap"
    [GetHashKey("v_ilev_mm_screen2")] = {
        --Job = { ["police"] = {"*"},  },
        --ItemToOpen = { "remote", "dogecoin" },

        ScreenOffSet = vector3(-1.544, 0.006, -0.098),
        ScreenSize = vector3(0.040, 0.023, 0.002),
        distanceToOpen = Config.DefaultOpenDistance,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.15,
            y = -2.7,
            z = -1.0,
        },
    },
    [-240931727] = { -- davis fire station
        ['ScreenSize'] = vec3(0.003945, -0.000000, 0.000000),
        ['CameraOffSet'] = {
            ['rotationOffset'] = vec3(0.000000, 0.000000, 0.000000),
            ['x'] = 0.0,
            ['y'] = -3.0,
            ['z'] = 0.35
        },
        ['Job'] = nil,
        ['distance'] = 10,
        ['ScreenOffSet'] = vec3(-1.513180, -0.050570, 0.902235),
        ['ItemToOpen'] = nil,
        ['distanceToOpen'] = 1.5
    },
}

-- Because many mappers like to resize television... There is the option for custom size...
Config.CustomScreenSizes = {
    [GetHashKey("prop_tv_flat_01")] = {--        {
        --            pos = vector3(-54.51, -1087.36, 27.26),
        --            ScreenSize = vector3(0.10, 0.0, 0),
        --            distanceToOpen = Config.DefaultOpenDistance,
        --        },
    },
    [GetHashKey("prop_huge_display_01")] = {--        {
        --            pos = vector3(-54.51, -1087.36, 27.26),
        --            ScreenSize = vector3(0.0, 0.0, 0),
        --        }
    },
}

-- permission map
Config.PermissionGroup = {
    ESX = {
        -- group system that used to work on numbers only
        [1] = {
            1, 2, 3, 4, 5
        },
        -- group system that works on name
        [2] = {
            "helper", "mod", "admin", "superadmin",
        },
    },

    QBCore = {
        -- group system that works on ACE
        [1] = {
            "god", "admin", "mod",
        },
    }
}

Config.CommandPermissions = {
    ["tveditor"] = { 3, 4, 5, "admin", "superadmin", "god" },
    ["tvpermission"] = { 3, 4, 5, "admin", "superadmin", "god" },
}