-- todo: more job sites

Config = {}

Config.Debug = true

Config.Language = "en" -- Language to use.

Config.RenderDistance = 100.0 -- Scenario display Radius.

Config.InteractDistance = 2.0 -- Interact Radius

Config.UseTarget = false -- When set to true, it'll use targeting instead of key-presses to interact.

Config.NoModelTargeting = true -- When set to true and using Target, it'll spawn a small invisible prop so you can third-eye when no entity is defined.

Config.Marker = { -- This will only be used if enabled, not using target, and no model is defined in the interaction.
    enabled = true,
    id = 2,
    scale = 0.25, 
    color = {255, 255, 255, 127}
}

Config.XPEnabled = false -- When set to true, this will enable Pickle's XP compatibility, and enable xp rewards.

Config.XPCategories = { -- Registered XP Types for Pickle's XP.
    ["landscaping"] = {
        label = "Landscaping", 
        xpStart = 1000, 
        xpFactor = 0.2, 
        maxLevel = 100
    },
}

Config.Default = {
    respawnTimer = 2 * 60 * 60, -- Time for respawning a scenario (put this inside a scenario to change it's timer).
    showScenarioBlip = true, -- Show scenario blip on the map so landscapers can find work.
    rewards = { -- Default rewards for completing a scenario, these are split amongst players (put this inside a scenario to change it's rewards).
        {type = "money", amount = 800}
    }
}

Config.GiveKeys = function(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local vehicle_key = {
		name = "Key -- " .. plate,
		quantity = 1,
		type = "key",
		owner = "landscaping",
		make = 'land',
		model = "scaping",
		plate = plate
	}
	TriggerServerEvent("garage:giveKey", vehicle_key)
end

Config.Lawnmower = {
    obstacleTimeout = 5, -- Disable mowing for 5 seconds when a rock is hit.
    vehicle = {
        enabled = true,
        model = `mower`,
        particle = {
            offset = vector3(0.8, 0.0, -0.4), 
            rotation = vector3(0.0, 0.0, 0.0)
        }
    },
    walking = {
        enabled = true,
        model = `prop_lawnmower_01`,
        boneID = 57005,
        offset = vector3(0.90, -0.14, -0.77),
        rotation = vector3(195.0, 210.0, -80.0),
        particle = {
            offset = vector3(0.0, 0.0, 0.0), 
            rotation = vector3(-90.0, 0.0, 0.0)
        }
    }
}

Config.Leafblower = {
    enabled = true,
    model = `prop_leaf_blower_01`,
    boneID = 57005,
    offset = vector3(0.1, 0.0, 0.0),
    rotation = vector3(-90.0, -65.0, 0.0),
    particle = {
        offset = vector3(0.9, 0.0, -0.25), 
        rotation = vector3(0.0, 0.0, 0.0)
    }
}

Config.Pitcher = {
    time = 5, -- Time to finish watering a bush.
}

Config.Workplace = { -- Where landscapers can start work, and get their required tools.
    duty = {
        coords = vector3(-1461.7710, -686.8022, 27.4666), -- Clock-in / out
        groups = nil, -- Set to nil for all access, or add a custom job like this: { ["landscaping"] = 0 }
        blip = { -- Set to nil for no blip.
            label = "Landscaping Company",
            id = 479,
            scale = 0.85,
            color = 2,
            display = 4,
        },
    },
    store = {
        coords = vector3(-1464.3055, -683.6722, 26.4667),
        items = {
            {
                label = "Lawnmower",
                item = "lawnmower",
                price = 300,
            },
            {
                label = "Leafblower",
                item = "leafblower",
                price = 200,
            },
            {
                label = "Garden Pitcher",
                item = "garden_pitcher",
                price = 100,
            },
        },
        blip = { -- Set to nil for no blip.
            label = "Landscaping Store",
            id = 479,
            scale = 0.85,
            color = 2,
            display = 4,
        },
    },
    garage = {
        coords = vector3(-1443.0516, -690.8935, 26.3128),
        spawn = {
            coords = vector3(-1450.2153, -684.7064, 26.3662),
            heading = 306.1427,
        },
        vehicles = {
            {
                label = "Pickup Truck",
                model = `bison`,
                price = 100,
            },
            {
                label = "Lawnmower",
                model = `mower`,
                price = 100,
            },
            {
                label = "Lawnmower Trailer",
                model = `boattrailer`,
                extras = {
                    [1] = 0,
                    [2] = 1,
                },
                price = 100,
            },
        },
        blip = { -- Set to nil for no blip.
            label = "Landscaping Garage",
            id = 479,
            scale = 0.85,
            color = 2,
            display = 4,
        },
    },
    outfit = {
		male = {
            ['arms'] = 19,
            ['tshirt_1'] = 15, 
            ['tshirt_2'] = 0,
            ['torso_1'] = 56, 
            ['torso_2'] = 0,
            ['bproof_1'] = 0,
            ['bproof_2'] = 0,
            ['decals_1'] = 0, 
            ['decals_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['pants_1'] = 7, 
            ['pants_2'] = 0,
            ['shoes_1'] = 56, 
            ['shoes_2'] = 0,
            ['helmet_1'] = 143, 
            ['helmet_2'] = 19,
        },
        female = {
            ['arms'] = 19,
            ['tshirt_1'] = 15, 
            ['tshirt_2'] = 0,
            ['torso_1'] = 56, 
            ['torso_2'] = 0,
            ['bproof_1'] = 0,
            ['bproof_2'] = 0,
            ['decals_1'] = 0, 
            ['decals_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['pants_1'] = 7, 
            ['pants_2'] = 0,
            ['shoes_1'] = 56, 
            ['shoes_2'] = 0,
            ['helmet_1'] = 143, 
            ['helmet_2'] = 19,
        }
    }
}

Config.ScenarioBlip = { -- Landscaping work blip when enabled.
    label = "Landscaping Work",
    id = 365,
    scale = 0.85,
    color = 2,
    display = 4,
}

Config.Scenarios = { -- This is where you'll add work for landscapers to do.
    -- Mansion
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-1604.2740, 107.1936, 61.0744), -- Center of the scenario.
        radius = 6.0, -- Area of the scenario.
        size = 1.15, -- Size of each prop inside the area.
        offset = -0.75, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-1595.6570, 99.7478, 60.7871), -- Center of the scenario.
        radius = 2.0, -- Area of the scenario.
        spread = 50, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-1599.0365, 90.3076, 60.8134), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario.
            {type = "money", amount = 650},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-1594.6431, 93.5099, 60.6486), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario.
            {type = "money", amount = 650},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "obstacle", -- When ran over by either type of lawnmower, the lawnmower is destroyed.
        model = `prop_rock_5_smash1`, -- Model of the scenario.
        coords = vector3(-1605.2738, 106.0849, 61.0947), -- Center of the scenario.
        heading = 30.0077, -- Heading of the scenario.
        offset = -0.05, -- Offset of the Z-coordinate of the prop placed.
        rewards = { -- Rewards for finishing the scenario.
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    -- Lifeinvader
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-1115.9598, -266.6743, 39.0054), -- Center of the scenario.
        radius = 2.0, -- Area of the scenario.
        spread = 20, -- Amount of leaves to place inside the area.
        offset = -0.75, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    -- Burton Intersection
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-592.4904, -29.4992, 43.6042), -- Center of the scenario.
        radius = 7.0, -- Area of the scenario.
        spread = 40, -- Amount of leaves to place inside the area.
        offset = -0.75, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-608.8917, -35.4217, 42.5946), -- Center of the scenario.
        radius = 7.0, -- Area of the scenario.
        spread = 40, -- Amount of leaves to place inside the area.
        offset = -0.75, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-631.2047, -35.7677, 41.5798), -- Center of the scenario.
        radius = 3.0, -- Area of the scenario.
        spread = 100, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    -- Vespucci Canals
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-1252.4867, -945.2944, 5.7757), -- Center of the scenario.
        radius = 7.0, -- Area of the scenario.
        spread = 40, -- Amount of leaves to place inside the area.
        offset = -0.75, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-1254.5767, -929.0537, 10.3674), -- Center of the scenario.
        radius = 2.0, -- Area of the scenario.
        spread = 50, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-1237.199, -917.9547, 10.58263), -- Center of the scenario.
        radius = 10.0, -- Area of the scenario.
        spread = 30, -- Amount of leaves to place inside the area.
        offset = -0.40, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    -- Skate Park
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-1244.8353, -963.3270, 3.3944), -- Center of the scenario.
        radius = 10.0, -- Area of the scenario.
        spread = 100, -- Amount of leaves to place inside the area.
        offset = -0.75, -- Offset of the Z-coordinate of each prop placed in the area.
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-938.9548, -767.0889, 16.5203), -- Center of the scenario.
        radius = 2.0, -- Area of the scenario.
        spread = 50, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-946.6307, -757.4492, 18.6050), -- Center of the scenario.
        radius = 3.0, -- Area of the scenario.
        spread = 20, -- Amount of leaves to place inside the area.
        offset = -0.75, -- Offset of the Z-coordinate of each prop placed in the area.
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-927.4852, -755.9402, 19.7077), -- Center of the scenario.
        radius = 6.0, -- Area of the scenario.
        spread = 40, -- Amount of leaves to place inside the area.
        offset = -0.75, -- Offset of the Z-coordinate of each prop placed in the area.
    },
    -- del perro pier
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-1494.665, -749.1664, 25.83121), -- Center of the scenario.
        radius = 10.0, -- Area of the scenario.
        spread = 20, -- Amount of leaves to place inside the area.
        offset = -0.30, -- Offset of the Z-coordinate of each prop placed in the area.
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-1527.016, -723.1259, 28.19139), -- Center of the scenario.
        radius = 10.0, -- Area of the scenario.
        spread = 10, -- Amount of leaves to place inside the area.
        offset = -0.20, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-1538.95, -703.6067, 28.81945), -- Center of the scenario.
        radius = 2.0, -- Area of the scenario.
        spread = 50, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-1544.894, -706.7044, 29.05422), -- Center of the scenario.
        radius = 2.0, -- Area of the scenario.
        spread = 50, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-1546.98, -695.7778, 29.11112), -- Center of the scenario.
        radius = 2.0, -- Area of the scenario.
        spread = 50, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-1553.379, -698.1088, 29.44084), -- Center of the scenario.
        radius = 2.0, -- Area of the scenario.
        spread = 50, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-1560.117, -686.1403, 29.22426), -- Center of the scenario.
        radius = 2.0, -- Area of the scenario.
        spread = 50, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-1600.402, -654.7513, 31.35887), -- Center of the scenario.
        radius = 2.0, -- Area of the scenario.
        spread = 60, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-1622.5, -638.3364, 32.528), -- Center of the scenario.
        radius = 5.0, -- Area of the scenario.
        spread = 10, -- Amount of leaves to place inside the area.
        offset = -0.30, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-1655.941, -607.9252, 33.82687), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-1661.866, -615.8625, 33.56454), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-1696.709, -580.5798, 35.11462), -- Center of the scenario.
        radius = 5.0, -- Area of the scenario.
        spread = 30, -- Amount of leaves to place inside the area.
        offset = -0.20, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-1685.644, -603.7141, 33.45111), -- Center of the scenario.
        radius = 5.0, -- Area of the scenario.
        spread = 30, -- Amount of leaves to place inside the area.
        offset = -0.20, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-1707.148, -580.0721, 35.60271), -- Center of the scenario.
        radius = 5.0, -- Area of the scenario.
        spread = 60, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    -- ls mall spawn
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-557.7149, -722.613, 33.17872), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-555.6787, -725.3179, 33.12593), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-554.7364, -728.958, 33.05046), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-553.0174, -732.368, 32.95206), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-540.3368, -740.4711, 32.64051), -- Center of the scenario.
        radius = 2.0, -- Area of the scenario.
        spread = 40, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-545.5501, -734.7156, 32.80013), -- Center of the scenario.
        radius = 3.0, -- Area of the scenario.
        spread = 40, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-540.1888, -753.4247, 32.28089), -- Center of the scenario.
        radius = 3.0, -- Area of the scenario.
        spread = 40, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-553.564, -754.9564, 32.34984), -- Center of the scenario.
        radius = 3.0, -- Area of the scenario.
        spread = 40, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "leaves", -- Type of scenario.
        model = `ng_proc_leaves07`, -- Model of the scenario.
        coords = vector3(-561.176, -754.3849, 32.40623), -- Center of the scenario.
        radius = 3.0, -- Area of the scenario.
        spread = 40, -- Amount of leaves to place inside the area.
        offset = 0.02, -- Offset of the Z-coordinate of each prop placed in the area.
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 650},
            {type = "xp", name = "landscaping", amount = 700},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-529.606, -771.6548, 31.0041), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-533.9992, -759.9095, 31.97828), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-521.795, -789.1541, 30.91695), -- Center of the scenario.
        radius = 5.0, -- Area of the scenario.
        spread = 30, -- Amount of leaves to place inside the area.
        offset = -0.70, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-517.5698, -801.8895, 30.8587), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-83.74387, 65.83171, 71.71427), -- Center of the scenario.
        radius = 1.7, -- Area of the scenario.
        spread = 10, -- Amount of leaves to place inside the area.
        offset = -0.70, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-78.56721, 63.03019, 71.80185), -- Center of the scenario.
        radius = 1.7, -- Area of the scenario.
        spread = 10, -- Amount of leaves to place inside the area.
        offset = -0.70, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-74.06931, 60.23745, 71.88068), -- Center of the scenario.
        radius = 1.7, -- Area of the scenario.
        spread = 10, -- Amount of leaves to place inside the area.
        offset = -0.70, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "grass", -- Type of scenario.
        model = `prop_veg_grass_01_c`, -- Model of the scenario.
        coords = vector3(-69.64925, 57.30938, 71.95911), -- Center of the scenario.
        radius = 1.7, -- Area of the scenario.
        spread = 10, -- Amount of leaves to place inside the area.
        offset = -0.70, -- Offset of the Z-coordinate of each prop placed in the area.
        
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-56.24626, 58.21318, 72.30446), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-54.17648, 60.86551, 72.39882), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-52.86421, 64.55338, 72.45886), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-51.2438, 68.85232, 72.54749), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-26.19155, 61.54264, 72.65382), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-24.24242, 66.61179, 73.17469), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-22.64692, 70.70995, 73.74212), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-20.53925, 77.35809, 74.8145), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-19.09991, 81.10116, 75.44938), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-17.66515, 84.63693, 76.10947), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-25.21083, 92.57711, 77.24603), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-24.83543, 96.17499, 78.01414), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-22.87416, 100.0545, 78.95625), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-21.32946, 104.5263, 80.01342), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
    {
        type = "bush", -- When watered, it replaces the unwatered plant with the watered plant.
        coords = vector3(-19.56641, 109.6375, 81.20807), -- Center of the scenario.
        heading = 48.5044, -- Heading of the scenario.
        unwatered = {
            model = `prop_bush_dead_02`, -- Model of the scenario when unwatered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        watered = {
            model = `prop_bush_neat_05`, -- Model of the scenario when watered.
            offset = -0.2, -- Offset of the Z-coordinate of each prop placed in the area.
        },
        rewards = { -- Rewards for finishing the scenario. Rewards are split amongst those that help clear it.
            {type = "money", amount = 500},
            {type = "xp", name = "landscaping", amount = 1000},
        }
    },
}