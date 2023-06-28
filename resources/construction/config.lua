Config = {}

Config.Language = "en"

Config.RenderDistance = 200.0

Config.Debug = true

Config.Workplace = {
    duty = {
        location = vector3(-509.3856, -1001.6426, 23.5505), -- Clock-in / out
        groups = nil, -- Set to nil for all access, { ["construction"] = 0 }
        blip = { -- Set to nil for no blip.
            Label = "Construction Office",
            ID = 233,
            Scale = 0.85,
            Color = 5,
            Display = 4,
        },
    },
    store = {
        location = vector3(-508.1997, -1050.3701, 23.5023),
        items = {
            {
                label = "Construction Lift",
                item = "lift",
                price = 2000,
                weight = 30,
                type = "misc"
            },
            {
                label = "Construction Rail",
                item = "lift_rail",
                price = 100,
                weight = 10,
                type = "misc"
            },
            {
                label = "Wooden Planks",
                item = "planks",
                price = 25,
                weight = 5,
                type = "misc"
            },
            {
                label = "Nails",
                item = "nail",
                price = 5,
                weight = 1,
                type = "misc"
            },
        },
        blip = { -- Set to nil for no blip.
            Label = "Construction Store",
            ID = 233,
            Scale = 0.85,
            Color = 5,
            Display = 4,
        },
    },
    garage = {
        location = vector3(-505.7420, -966.3918, 23.5755),
        heading = 86.5400,
        vehicles = {
            {
                label = "Bulldozer",
                model = `bulldozer`,
                price = 2000,
            },
            {
                label = "Tip Truck",
                model = `tiptruck`,
                price = 100,
            },
            {
                label = "Handler",
                model = `handler`,
                price = 100,
            },
            --[[
            {
                label = "Guardian",
                model = `guardian`,
                price = 100,
            },
            --]]
            {
                label = "Utility Truck",
                model = `utillitruck`,
                price = 100,
            },
            {
                label = "Utility Truck - Model 2",
                model = `utillitruck2`,
                price = 100,
            },
        },
        blip = { -- Set to nil for no blip.
            Label = "Construction Garage",
            ID = 233,
            Scale = 0.85,
            Color = 5,
            Display = 4,
        },
    },
    outfit = {
		male = {
            ['arms'] = 2,
            ['tshirt_1'] = 89, 
            ['tshirt_2'] = 0,
            ['torso_1'] = 56, 
            ['torso_2'] = 0,
            ['bproof_1'] = 3,
            ['bproof_2'] = 1,
            ['decals_1'] = 0, 
            ['decals_2'] = 0,
            ['pants_1'] = 7, 
            ['pants_2'] = 1,
            ['shoes_1'] = 56, 
            ['shoes_2'] = 0,
            ['helmet_1'] = 25, 
            ['helmet_2'] = 2,
        },
        female = {
            ['arms'] = 2,
            ['tshirt_1'] = 89, 
            ['tshirt_2'] = 0,
            ['torso_1'] = 56, 
            ['torso_2'] = 0,
            ['bproof_1'] = 3,
            ['bproof_2'] = 1,
            ['decals_1'] = 0, 
            ['decals_2'] = 0,
            ['pants_1'] = 7, 
            ['pants_2'] = 1,
            ['shoes_1'] = 56, 
            ['shoes_2'] = 0,
            ['helmet_1'] = 25, 
            ['helmet_2'] = 2,
        }
    }
}

Config.Sites = {
    -- Mirror Park
    {
        model = `lf_house_07_`,
        location = vector3(1409.5342, -747.7588, 65.5),
        heading = 82.72,
    },
    {
        model = `db_apart_01_`,
        location = vector3(1369.6890, -776.1544, 65.4872),
        heading = 160.0,
    },
    {
        model = `prop_towercrane_01a`,
        location = vector3(1400.6859, -716.3915, 65.3338),
        heading = -30.77,
    },
    {
        model = `lf_house_09_`,
        location = vector3(1378.6565, -708.8576, 65.3),
        heading = 172.4455,
    },
    -- Wind Farm
    {
        model = `prop_windmill_01`,
        location = vector3(1368.1085, -884.5501, 95.0730),
        heading = -30.3195,
    },
    {
        model = `prop_windmill_01`,
        location = vector3(1334.4515, -864.0012, 82.2367),
        heading = -30.3195,
    },
    {
        model = `prop_windmill_01`,
        location = vector3(1468.4329, -832.5289, 109.6758),
        heading = -30.3195,
    },
    -- Airport
    {
        model = `p_cs_mp_jet_01_s`,
        location = vector3(-1275.8625, -3388.2761, 12.9401),
        heading = 147.9113,
    },
    -- Boat Dock
    {
        model = `prop_cj_big_boat`,
        location = vector3(1307.9211, -3194.7488, -4.4259),
        heading = 180.0,
    },
    -- Grove Street
    {
        model = `prop_cctv_pole_02`,
        location = vector3(-126.8294, -1704.8544, 28.5401),
        heading = 139.5437,
    },
    {
        model = `prop_billboard_01`,
        location = vector3(-90.0106, -1714.3567, 27.3416),
        heading = 139.5437,
    },
    -- Pipe Welding
    {
        model = `prop_pipe_single_01`,
        location = vector3(910.3650512695312, -378.1980895996094, 48.36),
        heading = 190.0,
    },
    {
        model = `prop_pipe_single_01`,
        location = vector3(911.6755981445312, -386.01702880859375, 48.36),
        heading = 190.0,
    },
    {
        model = `prop_pipe_single_01`,
        location = vector3(913.0271606445312, -393.87945556640625, 48.36),
        heading = 190.0,
    },
    {
        model = `prop_pipe_single_01`,
        location = vector3(914.439697265625, -401.7142639160156, 48.36),
        heading = 190.0,
    },
    {
        model = `prop_pipe_single_01`,
        location = vector3(915.8333129882812, -409.55084228515625, 48.36),
        heading = 190.0,
    },
    {
        model = `prop_pipe_single_01`,
        location = vector3(917.208984375, -417.4247131347656, 48.36),
        heading = 190.0,
    },
    {
        model = `prop_pipe_single_01`,
        location = vector3(918.6004028320312, -425.29974365234375, 48.36),
        heading = 190.0,
    },
    {
        model = `prop_pipe_single_01`,
        location = vector3(919.921142578125, -432.45068359375, 48.36),
        heading = 190.0,
    },
}

Config.Models = {
    [`lf_house_09_`] = {
        points = {
            {
                location = vector3(-6.698, -1.377, 0.267),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-4.903, -6.68, 0.119),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.282, -7.848, 0.395),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-2.856, -7.83, 0.395),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(5.419, -10.488, 0.087),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(8.147, -6.176, 0.123),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(7.808, -1.01, 0.205),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(7.817, 4.704, 0.346),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(5.183, 7.05, 0.356),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(2.611, 7.05, 0.249),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-3.889, 7.048, 0.23),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.429, 7.05, 0.198),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-6.699, 3.947, 0.229),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },       
            {
                location = vector3(0.469, 4.612, 7.844),
                action = { type = "hammerground", args = { 5000 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(5.928, 1.656, 7.727),
                action = { type = "hammerground", args = { 5000 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.671, -1.876, 7.816),
                action = { type = "hammerground", args = { 5000 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-4.571, 1.261, 7.775),
                action = { type = "hammerground", args = { 5000 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },                 
        }
    },
    [`lf_house_07_`] = {
        points = { -- Repair / Build Points.
            {
                location = vector3(-5.61, 1.63, 0.0),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-3.08, 7.63, 0.0),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(5.30, 3.81, 0.0),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(5.27, -5.58, 0.0),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.84, -4.85, 0.37),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-4.69, 3.54, 4.0),
                action = { type = "hammerground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(2.14, 8.54, 3.95),
                action = { type = "hammerground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(3.59, 1.73, 4.58),
                action = { type = "hammerground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(2.33, -7.65, 4.25),
                action = { type = "hammerground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
        },
    },
    [`db_apart_01_`] = {
        points = {
            {
                location = vector3(-8.218, -17.651, 0.138),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-1.662, -17.57, 0.617),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(1.716, -18.636, 0.527),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(8.213, -18.451, 0.527),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(8.875, -12.121, 0.7),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(4.955, -0.351, 0.005),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(6.992, -3.278, 0.005),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(4.951, 4.13, 0.005),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(9.059, 15.624, 0.91),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(7.164, 11.261, 4.2),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(5.01, 6.248, 4.205),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(6.987, 11.067, 8.2),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(5.014, 6.353, 8.2),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(6.391, -3.311, 8.205),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(6.496, -3.306, 4.205),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(5.94, 18.182, 1.327),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.939, 18.224, 1.331),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-6.364, 18.172, 0.817),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-9.0, 14.398, 1.223),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-9.004, 2.832, 0.215),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-8.898, -12.863, 0.227),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },{
                location = vector3(7.667, -17.076, 12.497),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.136, -16.949, 12.497),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-7.282, -16.442, 12.497),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-7.425, -5.117, 12.497),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.154, -4.643, 12.497),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(7.474, -4.572, 12.497),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-8.083, -2.814, 12.507),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-8.171, 6.095, 12.486),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-8.386, 16.616, 12.433),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(1.336, 17.492, 12.583),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(7.754, 17.643, 12.503),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(8.147, 14.517, 12.722),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(8.212, 12.004, 12.693),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(7.123, 11.265, 12.388),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(5.216, 11.282, 12.356),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(4.472, 6.867, 12.426),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(4.758, -3.023, 12.374),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-1.867, -1.88, 13.973),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-1.918, 4.537, 14.005),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-2.068, 13.178, 13.971),
                action = { type = "hammer", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },              
        },
    },
    [`prop_cj_big_boat`] = {
        points = {
            {
                location = vector3(5.567, -38.732, 0.544),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.32, -37.686, 0.279),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.063, -35.255, 0.279),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-5.116, -38.382, 0.544),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-4.363, -32.087, 2.388),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(3.026, -31.684, 2.388),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.366, -23.821, 2.388),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-4.761, -14.68, 2.388),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(4.761, -15.751, 2.388),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-5.279, -27.768, 2.388),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(5.185, -27.688, 2.388),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.077, -32.126, 6.26),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-5.117, 0.473, 5.49),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.616, 31.371, 4.969),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(5.204, 2.061, 5.486),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "planks", count = 2}, {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
                  
        },
    },
    [`prop_pipe_single_01`] = {
        points = {
            {
                location = vector3(0.0, 2.0, 0.0),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0, 0, 0),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.0, -2.0, 0.0),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
        },
    },
    [`prop_towercrane_01a`] = {
        points = {        
            -- Front
            {
                location = vector3(0.033, -2.305, -0.04),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.033, -2.305, 5.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.033, -2.305, 10.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.033, -2.305, 15.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.033, -2.305, 20.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.033, -2.305, 25.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.033, -2.305, 30.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.033, -2.305, 35.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.033, -2.305, 40.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            -- Back
            {
                location = vector3(-0.353, 2.617, -0.04),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.353, 2.617, 5.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.353, 2.617, 10.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.353, 2.617, 15.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.353, 2.617, 20.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.353, 2.617, 25.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.353, 2.617, 30.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.353, 2.617, 35.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.353, 2.617, 40.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            -- Bridge
            {
                location = vector3(0.894, 0.059, 54.032),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.167, 20.018, 46.08),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.258, 17.183, 46.233),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.234, 11.208, 46.072),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.134, 3.833, 46.069),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.011, -2.547, 45.991),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.033, -4.515, 45.99),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.001, -11.058, 45.99),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.033, -17.156, 45.99),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.062, -24.065, 45.99),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.029, -31.731, 45.99),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.013, -38.919, 45.99),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.03, -41.844, 45.99),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },            
        },
    },
    [`prop_windmill_01`] = {
        points = {
            {
                location = vector3(-0.269, 2.218, 1.34),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },     
            {
                location = vector3(-0.269, 2.218, 6.34),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },     
            {
                location = vector3(-0.269, 2.218, 11.34),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },     
            {
                location = vector3(-0.269, 2.218, 16.34),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },     
            {
                location = vector3(-0.269, 2.218, 21.34),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },     
            {
                location = vector3(-0.269, 2.218, 26.34),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },         
            {
                location = vector3(-0.269, 2.218, 31.34),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },     
            {
                location = vector3(-0.296, 4.086, 37.907),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.315, 1.412, 38.144),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-0.245, -0.912, 37.848),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },            
        }
    },
    [`p_cs_mp_jet_01_s`] = {
        points = {
            {
                location = vector3(-5.327, -5.019, -3.783),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-5.12, -9.35, -3.783),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(6.738, -9.18, -3.783),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(6.622, -5.321, -3.783),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(1.752, 12.915, 1.864),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.052, 12.626, 1.864),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.66, 5.42, 1.864),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.715, 0.199, 1.864),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.811, -3.763, 1.864),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.584, -7.99, 1.864),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.428, -13.328, 1.864),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0.586, -18.1, 1.864),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-16.961, 2.235, 0.896),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-12.504, -0.111, 0.336),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-5.382, -4.096, -0.557),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(4.649, -5.375, -0.692),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(8.027, -3.283, -0.289),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(15.939, 1.142, 0.694),
                action = { type = "weldground", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },            
        }
    },
    [`prop_cctv_pole_02`] = {
        points = {
            {
                location = vector3(0, 0, 0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0, 0, 2.5),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0, 0, 5.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
        }
    },
    [`prop_billboard_01`] = {
        points = {
            {
                location = vector3(0, 1.0, 3.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0, 1.0, 6.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0, 1.0, 9.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0, 1.0, 12.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(0, 1.0, 15.0),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-1.663, 2.401, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(1.128, 2.488, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(3.917, 2.595, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(6.463, 2.937, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(8.989, 3.088, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(11.807, 3.393, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(11.93, 2.075, 19.346),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(9.345, 1.715, 19.346),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(6.767, 1.287, 19.348),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(3.283, 1.277, 19.346),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(1.311, 1.011, 19.346),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-1.441, 0.705, 19.346),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-1.344, -0.634, 19.346),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(1.303, -0.932, 19.346),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(3.977, -1.224, 19.346),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(6.561, -1.157, 19.354),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(9.216, -1.521, 19.346),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(11.864, -1.825, 19.346),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },            
            {
                location = vector3(11.724, -3.232, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(9.117, -3.042, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(6.564, -3.081, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(3.949, -2.622, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(1.218, -2.472, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            {
                location = vector3(-1.499, -2.217, 17.597),
                action = { type = "weld", args = { 2500 } },
                required = { {name = "nail", count = 2}, },
                reward = { name = "money",  min = 100, max = 150 },
                durability = 120
            },
            
        }
    },
}

Config.Durability = {
    time = 1, -- The interval (in seconds) of when to remove durability from a point.
    durability = 0, -- How much durability to take per interval.
}

Config.Actions = {
    ["hammer"] = function(args)
        local ped = PlayerPedId()
        
        ClearPedTasksImmediately(ped)
        FreezeEntityPosition(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HAMMERING", -1, -1)
        
        Wait(args[1])

        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)

        ClearAreaOfObjects(GetEntityCoords(PlayerPedId()), 1.0, 0)
        return true -- Success
    end,
    ["hammerground"] = function(args)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        ClearPedTasksImmediately(ped)
        FreezeEntityPosition(ped, true)
        local obj = CreateProp(`prop_tool_sledgeham`, coords.x, coords.y, coords.z, true, true, false)
        local boneIndex = GetPedBoneIndex(ped, 0xDEAD)
        AttachEntityToEntity(obj, ped, boneIndex, 0.09, 0.0, 0.0, -90.0, 0.0, 10.0, false, false, false, true, false, 2, false)
        PlayAnim(ped, "melee@large_wpn@streamed_core", "ground_attack_on_spot", -8.0, 8.0, -1, 49, 1.0)

        Wait(args[1])

        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)

        DeleteEntity(obj)
        return true -- Success
    end,
    ["weld"] = function(args)
        local ped = PlayerPedId()
        
        ClearPedTasksImmediately(ped)
        FreezeEntityPosition(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", -1, -1)
        
        Wait(args[1])

        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)

        ClearAreaOfObjects(GetEntityCoords(PlayerPedId()), 1.0, 0)
        return true -- Success
    end,
    ["weldground"] = function(args)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        
        ClearPedTasksImmediately(ped)
        FreezeEntityPosition(ped, true)

        local obj = CreateProp(`prop_tool_blowtorch`, coords.x, coords.y, coords.z, true, true, false)
        local boneIndex = GetPedBoneIndex(ped, 0xDEAD)
        AttachEntityToEntity(obj, ped, boneIndex, 0.15, 0.0, 0.0, -90.0, 0.0, -100.0, false, false, false, true, false, 2, false)
        PlayEffect("core", "ent_anim_welder", obj, vector3(0.13, 0.0, 0.59), vector3(0.0, 0.0, 0.0), args[1], function() end)
        PlayAnim(ped, "amb@world_human_welding@male@idle_a", "idle_a", -8.0, 8.0, -1, 49, 1.0)
        PlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", -8.0, 8.0, -1, 1, 1.0)
        Wait(args[1])

        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)

        DeleteEntity(obj)
        return true -- Success
    end,
}

Config.Lift = {
    spawn = function()
        local ped = PlayerPedId()
        
        ClearPedTasksImmediately(ped)
        FreezeEntityPosition(ped, true)
        PlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", -8.0, 8.0, -1, 1, 1.0)
        
        Wait(2500)

        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        return true -- Success
    end,
    remove = function()
        local ped = PlayerPedId()
        
        ClearPedTasksImmediately(ped)
        FreezeEntityPosition(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HAMMERING", -1, -1)
        
        Wait(2500)

        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)

        ClearAreaOfObjects(GetEntityCoords(PlayerPedId()), 1.0, 0)
        return true -- Success
    end
}