config_cl = {
    -- Model for Manager
    NPC_PED_MODEL = "a_f_y_business_01",

    -- Coords where manager is located
    NPC_COORDS = {-597.52642822266, -1053.5493164063, 22.344202041626},
    NPC_HEADING = 356.08,

    -- Distance for text to show up to clock in
    textDistance = 1.5,

    -- Time before player gets kicked for inactivity (Paycheck Farmers)
    stationaryKickTime = 30, -- In minutes

    -- Cooldown for XP
    xpCooldown = 3, -- In minutes (Shouldn't be too high, but also not too low)

    -- Counter for how many items must be crafted before adding a bonus
    payRandomizer = math.random(9,13), -- Random number between 9 and 13

    -- Time for items to get preparred
    prepTimes = {
        ["indiv"] = {time = math.random(20,30)},        -- Individual Items
        ["combos"] = {time = math.random(25,35)},       -- Combo Items
        ["hotdrinks"] = {time = math.random(15,20)},    -- Hot Drink Items
        ["colddrinks"] = {time = math.random(10,15)}    -- Cold Drink Items
    },

    Gatos = {
        ['cat1'] = {['coords'] = vector4(-573.9, -1056.29, 22.43, 115.15),['sitting'] = true},
        ['cat2'] = {['coords'] = vector4(-574.16, -1053.91, 22.34, 146.09),['sitting'] = true},
        ['cat3'] = {['coords'] = vector4(-576.37, -1054.71, 22.43, 143.33),['sitting'] = true},
        ['cat4'] = {['coords'] = vector4(-584.91, -1052.77, 22.35, 232.57),['sitting'] = true},
        -- ['cat5'] = {['coords'] = vector4(-582.36, -1054.65, 22.43, 255.45),['sitting'] = false},
        ['cat6'] = {['coords'] = vector4(-582.18, -1056.0, 22.43, 306.29),['sitting'] = true},
        ['cat7'] = {['coords'] = vector4(-575.52, -1063.21, 22.34, 44.51),['sitting'] = true},
        ['cat8'] = {['coords'] = vector4(-581.82, -1066.43, 22.34, 287.58),['sitting'] = true},
        -- ['cat9'] = {['coords'] = vector4(-583.49, -1069.39, 22.99, 293.01) ,['sitting'] = false},
        ['cat10'] = {['coords'] = vector4(-584.27, -1065.85, 22.34, 181.7),['sitting'] = true},  
        -- ['cat11'] = {['coords'] = vector4(-581.1, -1063.61, 22.79, 219.69),['sitting'] = false},
        ['cat12'] = {['coords'] = vector4(-572.98, -1057.41, 24.5, 88.18),['sitting'] = true},
        ['cat13'] = {['coords'] = vector4(-584.21350097656, -1062.8348388672, 23.374368667603, 149.8043), ['sitting'] = true},
        ['cat14'] = {['coords'] = vector4(-583.2716, -1049.61, 22.30939, 258.2928), ['sitting'] = true},
        ['cat15'] = {['coords'] = vector4(-580.1404, -1064.758, 22.01193, 61.71033), ['sitting'] = true},
        -- ['cat16'] = {['coords'] = vector4(-583.2541, -1069.39, 22.21083, 279.8207), ['sitting'] = true},
    },

    -- Ranks =[IF YOU CHANGE SOMETHING IN HERE, MAKE SURE TO CHANGE IT IN THE SERVER CONFIG]=
    ranks = {
        ['Trainee'] = {
            PayBonus = 100,
            xpRequired = 0,
            craftAdjustmentTime = 1.5
        },
        ['Employee'] = {
            PayBonus = 250,
            xpRequired = 50,
            craftAdjustmentTime = 1
        },
        ['Trainer'] = {
            PayBonus = 300,
            xpRequired = 275,
            craftAdjustmentTime = 0.95
        },
        ['Shift Supervisor'] = {
            PayBonus = 500,
            xpRequired = 700,
            craftAdjustmentTime = 0.9
        },
        ['Shift Manager'] = {
            PayBonus = 550,
            xpRequired = 1300,
            craftAdjustmentTime = 0.85
        },
        ['Store Manager'] = {
            PayBonus = 700,
            xpRequired = 2150,
            craftAdjustmentTime = 0.5
        }
    },

    -- debug mode
    debugMode = false
}