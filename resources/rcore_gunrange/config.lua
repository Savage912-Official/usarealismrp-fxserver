Config = {}
Config.Locale = 'en' --html locale you can change at client/html/script.js
-- Only debug function
Config.Debug = false
Config.DebugLevel = {
    'CRITICAL',
    'ERROR',
}
Config.DiscordLogs = false

-- Standalone = 1
-- ESX = 2
-- QBCore = 3
Config.FrameWork = "1"

Config.GetQBCoreObject = function()
    -- Choose your objectType or made here your own.
    local objectType = "1"

    if objectType == "1" then
        return exports['qb-core']:GetCoreObject()
    end

    if objectType == "2" then
        return exports['qb-core']:GetSharedObject()
    end

    if objectType == "3" then
        local QBCore = nil
        local breakPoint = 0
        while not QBCore do
            Wait(100)
            TriggerEvent("QBCore:GetObject", function(obj)
                QBCore = obj
            end)

            breakPoint = breakPoint + 1
            if breakPoint == 25 then
                print(string.format("^1[%s]^7 Could not load the sharedobject, are you sure it is called ^1˙QBCore:GetObject˙^7?", GetCurrentResourceName()))
                break
            end
        end

        return QBCore
    end
end

Config.DebugDraw = false
Config.DebugDrawOnlyShots = false
--
Config.Payment = 250 --Global payment price
--If you have different calls
--Rcore notification can be found at our discord free to download
Config.UseRcoreNotification = false --You have to install script rcore_notification first

---IF YOU DONT USE OWN SOLUTION USE THIS (check server/framework/events.lua)
Config.RemoveAndReturnWeapon = true --Will remove weapons and add rented weapons, after leaving line it will return player guns

--Marker setup
Config.NearObjectDistance = 50.0
Config.CheckPlayerPosition = 500

Config.InRadius = 0.7 --In marker radius
Config.RenderDistance = 5.0 --Marker render

--Do not change this if you dont know what are u doing
Config.DefaultBlipOptions = {
    scale = 1.0,
    shortRange = true,
    type = 4,
    color = 55,
}
Config.Offsets = {
    center = {
        x = 0,
        y = 0,
        z = 0.52
    },
    head = {
        x = 0,
        y = 0,
        z = 1.05
    }
}

local guns = { --You can use guns variable for all guns or you can setup specifically every target line
    {
        hash = 'WEAPON_COMBATPISTOL',
        label = 'Glock',
        ammo = 16,
        rentPrice = 500,  
    },
    {
        hash = 'WEAPON_CERAMICPISTOL',
        label = 'Ceramic Pistol',
        ammo = 16,
        rentPrice = 500,
    },
    {
        hash = 'WEAPON_SNSPISTOL',
        label = 'SNS Pistol',
        ammo = 12,
        rentPrice = 500,
    },
    {
        hash = 'WEAPON_SNSPISTOL_MK2',
        label = 'SNS Pistol Mk2',
        ammo = 12,
        rentPrice = 500,  
    },
    {
        hash = 'WEAPON_PISTOL',
        label = 'Pistol',
        ammo = 16,
        rentPrice = 500,
    },
    {
        hash = 'WEAPON_VINTAGEPISTOL',
        label = 'Vintage Pistol',
        ammo = 14,
        rentPrice = 500,
    },
    {
        hash = 'WEAPON_HEAVYPISTOL',
        label = 'Heavy Pistol',
        ammo = 18,
        rentPrice = 500,  
    },
    {
        hash = 'WEAPON_PISTOL50',
        label = 'Pistol .50',
        ammo = 12,
        rentPrice = 500,
    },
    {
        hash = 'WEAPON_APPISTOL',
        label = 'AP Pistol',
        ammo = 18,
        rentPrice = 500,  
    },
    {
        hash = 'WEAPON_MICROSMG',
        label = 'Micro SMG',
        ammo = 30,
        rentPrice = 500,
    },
    {
        hash = 'WEAPON_SMG',
        label = 'SMG',
        ammo = 30,
        rentPrice = 500,
    },
    {
        hash = 'WEAPON_COMBATPDW',
        label = 'Combat PDW',
        ammo = 20,
        rentPrice = 500,  
    },
    {
        hash = 'WEAPON_GUSENBERG',
        label = 'Tommy Gun',
        ammo = 30,
        rentPrice = 500,
    },
    {
        hash = 'WEAPON_ASSAULTRIFLE',
        label = 'AK-47',
        ammo = 30,
        rentPrice = 500,
    },
    {
        hash = 'WEAPON_CARBINERIFLE',
        label = 'Carbine Rifle',
        ammo = 30,
        rentPrice = 500,  
    },
    {
        hash = 'WEAPON_TACTICALRIFLE',
        label = 'Tactical Carbine',
        ammo = 30,
        rentPrice = 500,
    },
    {
        hash = 'WEAPON_MILITARYRIFLE',
        label = 'Military Rifle',
        ammo = 30,
        rentPrice = 500,
    },
    {
        hash = 'WEAPON_COMPACTRIFLE',
        label = 'Compact Rifle',
        ammo = 30,
        rentPrice = 500,  
    },
    {
        hash = 'WEAPON_MACHINEPISTOL',
        label = 'Machine Pistol',
        ammo = 20,
        rentPrice = 500,
    },
}

local pdguns = {
    {
        hash = 'WEAPON_COMBATPISTOL',
        label = 'Glock',
        ammo = 18,
        rentPrice = 250,  
    },
    {
        hash = 'WEAPON_HEAVYPISTOL',
        label = 'Heavy Pistol',
        ammo = 18,
        rentPrice = 250,
    },
    {
        hash = 'WEAPON_SMG',
        label = 'SMG',
        ammo = 30,
        rentPrice = 250,
    },
    {
        hash = 'WEAPON_SMG_MK2',
        label = "MK2",
        ammo = 30,
        rentPrice = 250,
    },
    {
        hash = 'WEAPON_CARBINERIFLE_MK2',
        label = "MK2 Carbine Rifle",
        ammo = 30,
        rentPrice = 250,
    },
    {
        hash = 'WEAPON_CARBINERIFLE',
        label = "Carbine Rifle",
        ammo = 30,
        rentPrice = 250,
    },
}

Config.Gunranges = {
    { -- MRPD --
        menu = {
            {
                valueIndex = 1,
                label = '<span style="font-size: 20px;">Distance 7m</span><div style="color:green;">Renting price: ' .. Config.Payment .. '$</div>',
            },
            {
                valueIndex = 2,
                label = '<span style="font-size: 20px;">Distance 9m</span><div style="color:green;">Renting price: ' .. Config.Payment .. '$</div>',
            },
            {
                valueIndex = 3,
                label = '<span style="font-size: 20px;">Distance 11m</span><div style="color:green;">Renting price: ' .. Config.Payment .. '$</div>',
            },
        },
        targets = {
            [1] = {
                guns = pdguns,
                marker = {
                    type = 29,

                    scale = {
                        x = 0.5,
                        y = 0.5,
                        z = 0.5
                    },

                    color = {
                        r = 50,
                        g = 255,
                        b = 50,
                        a = 255
                    },

                    rotation = false,
                    faceCamera = false,
                    bobUpAndDown = false,

                    pos = vector3(484.5746, -1009.0498, 30.7099),
                },
                targets = {
                    { --Target menu index 1
                        pos = vector3(477.9978, -1009.0498, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                    { --Target menu index 2
                        pos = vector3(475.9978, -1009.0498, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                    { --Target menu index 3
                        pos = vector3(473.9978, -1009.0498, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                }
            },
            [2] = {
                guns = pdguns,
                marker = {
                    type = 29,

                    scale = {
                        x = 0.5,
                        y = 0.5,
                        z = 0.5
                    },

                    color = {
                        r = 50,
                        g = 255,
                        b = 50,
                        a = 255
                    },

                    rotation = false,
                    faceCamera = false,
                    bobUpAndDown = false,

                    pos = vector3(484.5746, -1010.7385, 30.7099),
                },
                targets = {
                    { --Target menu index 1
                        pos = vector3(477.9978, -1010.7385, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                    { --Target menu index 2
                        pos = vector3(475.9978, -1010.7385, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                    { --Target menu index 3
                        pos = vector3(473.9978, -1010.7385, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                }
            },
            [3] = {
                guns = pdguns,
                marker = {
                    type = 29,

                    scale = {
                        x = 0.5,
                        y = 0.5,
                        z = 0.5
                    },

                    color = {
                        r = 50,
                        g = 255,
                        b = 50,
                        a = 255
                    },

                    rotation = false,
                    faceCamera = false,
                    bobUpAndDown = false,

                    pos = vector3(484.5746, -1012.5067, 30.7099),
                },
                targets = {
                    { --Target menu index 1
                        pos = vector3(477.9978, -1012.5067, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                    { --Target menu index 2
                        pos = vector3(475.9978, -1012.5067, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                    { --Target menu index 3
                        pos = vector3(473.9978, -1012.5067, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                }
            },
            [4] = {
                guns = pdguns,
                marker = {
                    type = 29,

                    scale = {
                        x = 0.5,
                        y = 0.5,
                        z = 0.5
                    },

                    color = {
                        r = 50,
                        g = 255,
                        b = 50,
                        a = 255
                    },

                    rotation = false,
                    faceCamera = false,
                    bobUpAndDown = false,

                    pos = vector3(484.5746, -1014.2407, 30.7099),
                },
                targets = {
                    { --Target menu index 1
                        pos = vector3(477.9978, -1014.2407, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                    { --Target menu index 2
                        pos = vector3(475.9978, -1014.2407, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                    { --Target menu index 3
                        pos = vector3(473.9978, -1014.2407, 30.6896),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 90.00,

                        -- if the shooting points dont go upwards/side ways
                        -- 1 = y, z are used
                        -- 2 = x, z are used
                        -- 3 = z, y are used as a render coords.
                        SwitchAxis = "1",

                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.08,

                        -- if you shoot lets say 7 on right side and it will
                        -- display it on left side. Switch one of these
                        -- Axis to true so it will correct the position of point.
                        ReverseAxisX = false,
                        ReverseAxisY = true,
                        ReverseAxisZ = false,
                    },
                }
            },
        }
    },
    {
        menu = {
            {
                valueIndex = 1,
                label = '<span style="font-size: 20px;">Distance 7m</span><div style="color:green;">Renting price: ' .. Config.Payment .. '$</div>',
            },
            {
                valueIndex = 2,
                label = '<span style="font-size: 20px;">Distance 9m</span><div style="color:green;">Renting price: ' .. Config.Payment .. '$</div>',
            },
            {
                valueIndex = 3,
                label = '<span style="font-size: 20px;">Distance 12m</span><div style="color:green;">Renting price: ' .. Config.Payment .. '$</div>',
            },
        },
        targets = {
            [5] = {
                guns = guns,
                marker = {
                    type = 29,
                    color = {
                        r = 50,
                        g = 255,
                        b = 50, a = 255
                    },
                    pos = vector3(821.6096, -2164.2034, 29.66)
                },
                targets = {
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(821.6096, -2171.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(821.6096, -2173.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(821.6096, -2176.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                }
            },
            [6] = {
                guns = guns,
                marker = {
                    type = 29,
                    color = {
                        r = 50,
                        g = 255,
                        b = 50, a = 255
                    },
                    pos = vector3(820.2265, -2164.2034, 29.66)
                },
                targets = {
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(820.2265, -2171.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(820.2265, -2173.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(820.2265, -2176.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                }
            },
            [7] = {
                guns = guns,
                marker = {
                    type = 29,
                    color = {
                        r = 50,
                        g = 255,
                        b = 50, a = 255
                    },
                    pos = vector3(818.8344, -2164.2034, 29.66)
                },
                targets = {
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(818.8344, -2171.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(818.8344, -2173.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(818.8344, -2176.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                }
            },
            [8] = {
                guns = guns,
                marker = {
                    type = 29,
                    color = {
                        r = 50,
                        g = 255,
                        b = 50, a = 255
                    },
                    pos = vector3(817.4525, -2164.2034, 29.66)
                },
                targets = {
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(817.4525, -2171.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(818.02, -2173.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(818.08, -2176.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                }
            },
            [9] = {
                guns = guns,
                marker = {
                    type = 29,
                    color = {
                        r = 50,
                        g = 255,
                        b = 50, a = 255
                    },
                    pos = vector3(816.0714, -2164.2034, 29.66)
                },
                targets = {
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(816.06, -2171.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(817.02, -2173.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(817.08, -2176.2034, 29.67),
                        model = GetHashKey('prop_range_target_01'),
                        heading = 7.36,
                    },
                }
            },
        }
    },
    {
        menu = {
            {
                valueIndex = 1,
                label = '<span style="font-size: 20px;">Distance 7m</span><div style="color:green;">Renting price: ' .. Config.Payment .. '$</div>',
            },
            {
                valueIndex = 2,
                label = '<span style="font-size: 20px;">Distance 9m</span><div style="color:green;">Renting price: ' .. Config.Payment .. '$</div>',
            },
            {
                valueIndex = 3,
                label = '<span style="font-size: 20px;">Distance 12m</span><div style="color:green;">Renting price: ' .. Config.Payment .. '$</div>',
            },
        },
        targets = {
            [10] = {
                guns = guns,
                marker = {
                    type = 29,
                    color = {
                        r = 50,
                        g = 255,
                        b = 50, a = 255
                    },
                    pos = vector3(13.6283, -1096.748, 29.80036),
                },
                targets = {
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(15.93468, -1090.455, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(16.73954, -1088.26, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(17.79073, -1085.348, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                }
            },
            [11] = {
                guns = guns,
                marker = {
                    type = 29,
                    color = {
                        r = 50,
                        g = 255,
                        b = 50, a = 255
                    },
                    pos = vector3(15.03241, -1097.252, 29.80036),
                },
                targets = {
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(17.3861, -1090.551, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(18.1564, -1088.485, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(19.19889, -1085.580, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                }
            },
            [12] = {
                guns = guns,
                marker = {
                    type = 29,
                    color = {
                        r = 50,
                        g = 255,
                        b = 50, a = 255
                    },
                    pos = vector3(16.31607, -1097.765, 29.80036),
                },
                targets = {
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(18.74015, -1090.900, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(19.65335, -1088.400, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(20.64152, -1085.700, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                }
            },
            [13] = {
                guns = guns,
                marker = {
                    type = 29,
                    color = {
                        r = 50,
                        g = 255,
                        b = 50, a = 255
                    },
                    pos = vector3(17.63347, -1098.196, 29.80036),
                },
                targets = {
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(20.09898, -1091.215, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(21.07357, -1088.549, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(21.99289, -1085.995, 29.79718),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                }
            },
            [14] = {
                guns = guns,
                marker = {
                    type = 29,
                    color = {
                        r = 50,
                        g = 255,
                        b = 50, a = 255
                    },
                    pos = vector3(18.91319, -1098.669, 29.80037),
                },
                targets = {
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(21.34501, -1091.879, 29.79719),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(22.46708, -1088.800, 29.79717),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                    {
                        -- if the position of point need correction. Make it here
                        VectorXoffset = 0.0,
                        VectorYoffset = -0.07,

                        pos = vector3(23.1801, -1086.815, 29.79718),
                        model = GetHashKey('prop_range_target_01'),
                        heading = -18.0,

                        ReverseAxisX = true,
                        ReverseAxisY = false,
                        ReverseAxisZ = false,
                    },
                }
            },
        }
    },
}