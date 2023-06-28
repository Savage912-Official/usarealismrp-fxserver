QBCore = {}
Vank17a = {}

Config = Config or {
   Price = {
        paintingeSellAll = math.random(20000, 100000), -- price all
    },
    Items = {
        paintinge = "paintinge",
        paintingi = "paintingi",
        paintingh = "paintingh",
        paintingj = "paintingj",
        paintingf = "paintingf",
        paintingg = "paintingg",
    },
}
Config.CoreScriptName             = 'usa' -- name export
Config.CoreName                   = 'usa' -- name event
Config.Cooldown                   = 90 -- 60 minutes
Config.Jobs = "police" -- Jobs Cops
Config.RequiredCops = 0 -- Need a police officer. They are currently [4], you can change it
Config.DoorId = 'Artheist-door' -- name of the door in your doorlock config
Config.DoorId1 = 'Artheist-door1' -- name of the door in your doorlock config
Config.DoorId2 = 'Artheist-door2' -- name of the door in your doorlock config
Config.DoorId3 = 'Artheist-door3' -- name of the door in your doorlock config
Config.DoorId4 = 'Artheist-door4' -- name of the door in your doorlock config
Config.DoorId5 = 'Artheist-door5' -- name of the door in your doorlock config

-- QBCore
Config.system = {
    target = 'qb-target', -- 'vt-eye' or 'qb-target'  (This is a change to your resource name, namely target, the original one which is QBCore)
    menu = 'qb-menu', -- name resource
    close = 'qb-menu:closeMenu', -- name close event
    MgameUI   = 'vt-ui', -- 'vt-ui or ps-ui
 }

 --Thermite Settings
 Config.ThermiteSettings = {
    time = 60, -- time the hack displays for \\ half being showing the puzzle and the other solving
    gridsize = 5, -- (5, 6, 7, 8, 9, 10) size of grid by square units, ie. gridsize = 5 is a 5 * 5 (25) square grid
    incorrectBlocks = 10 -- incorrectBlocks = number of incorrect blocks after which the game will fail
}

--Thermite locations to open door
Config.Thermite = vector3(1392.99, 1127.4, 114.33)

Config['ArtHeist'] = {
    ['nextRob'] = 2 * 60 * 60, -- seconds for next heist
    ['startHeist'] ={ -- heist start coords
        pos = vector3(244.346, 374.012, 105.738),
        peds = {
            {pos = vector3(244.346, 374.012, 105.738), heading = 156.39, ped = 's_m_m_highsec_01'},
            {pos = vector3(243.487, 372.176, 105.738), heading = 265.63, ped = 's_m_m_highsec_02'},
            {pos = vector3(245.074, 372.730, 105.738), heading = 73.3, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['sellPainting'] ={ -- sell painting coords
        pos = vector3(287.7620, -2981.74, -34.65),
        peds = {
            {pos = vector3(288.558, -2981.1, 5.90696), heading = 135.88, ped = 's_m_m_highsec_01'},
            {pos = vector3(287.190, -2980.9, 5.72252), heading = 218.0, ped = 's_m_m_highsec_02'}

        }
    },
    ['painting'] = {
        {
            rewardItem = 'paintinge', -- u need add item to database
            paintingPrice = '6000', -- price of the reward item for sell
            scenePos = vector3(1400.486, 1164.55, 113.4136), -- animation coords
            sceneRot = vector3(0.0, 0.0, -90.0), -- animation rotation
            object = 'ch_prop_vault_painting_01e', -- object (https://mwojtasik.dev/tools/gtav/objects/search?name=ch_prop_vault_painting_01)
            objectPos = vector3(1400.946, 1164.55, 114.5336), -- object spawn coords
            objHeading = 270.0 -- object spawn heading
        },
        {
            rewardItem = 'paintingi',
            paintingPrice = '6000',
            scenePos = vector3(1408.175, 1144.014, 113.4136),
            sceneRot = vector3(0.0, 0.0, 180.0),
            object = 'ch_prop_vault_painting_01i',
            objectPos = vector3(1408.175, 1143.564, 114.5336),
            objHeading = 180.0
        },
        {
            rewardItem = 'paintingh',
            paintingPrice = '6000',
            scenePos = vector3(1407.637, 1150.74, 113.4136),
            sceneRot = vector3(0.0, 0.0, 0.0),
            object = 'ch_prop_vault_painting_01h',
            objectPos = vector3(1407.637, 1151.17, 114.5336),
            objHeading = 0.0
        },
        {
            rewardItem = 'paintingj',
            paintingPrice = '6000',
            scenePos = vector3(1408.637, 1150.74, 113.4136),
            sceneRot = vector3(0.0, 0.0, 0.0),
            object = 'ch_prop_vault_painting_01j',
            objectPos = vector3(1408.637, 1151.17, 114.5336),
            objHeading = 0.0
        },
        {
            rewardItem = 'paintingf',
            paintingPrice = '6000',
            scenePos = vector3(1397.586, 1165.579, 113.4136),
            sceneRot = vector3(0.0, 0.0, 90.0),
            object = 'ch_prop_vault_painting_01f',
            objectPos = vector3(1397.136, 1165.579, 114.5336),
            objHeading = 90.0
        },
        {
            rewardItem = 'paintingg',
            paintingPrice = '6000',
            scenePos = vector3(1397.976, 1165.679, 113.4136),
            sceneRot = vector3(0.0, 0.0, 0.0),
            object = 'ch_prop_vault_painting_01g',
            objectPos = vector3(1397.936, 1166.079, 114.5336),
            objHeading = 0.0
        },
    },
    ['objects'] = { -- dont change (required)
        'hei_p_m_bag_var22_arm_s',
        'w_me_switchblade'
    },
    ['animations'] = { -- dont change (required)
        {"top_left_enter", "top_left_enter_ch_prop_ch_sec_cabinet_02a", "top_left_enter_ch_prop_vault_painting_01a", "top_left_enter_hei_p_m_bag_var22_arm_s", "top_left_enter_w_me_switchblade"},
        {"cutting_top_left_idle", "cutting_top_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_idle_ch_prop_vault_painting_01a", "cutting_top_left_idle_hei_p_m_bag_var22_arm_s", "cutting_top_left_idle_w_me_switchblade"},
        {"cutting_top_left_to_right", "cutting_top_left_to_right_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_to_right_ch_prop_vault_painting_01a", "cutting_top_left_to_right_hei_p_m_bag_var22_arm_s", "cutting_top_left_to_right_w_me_switchblade"},
        {"cutting_top_right_idle", "_cutting_top_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_right_idle_ch_prop_vault_painting_01a", "cutting_top_right_idle_hei_p_m_bag_var22_arm_s", "cutting_top_right_idle_w_me_switchblade"},
        {"cutting_right_top_to_bottom", "cutting_right_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_right_top_to_bottom_ch_prop_vault_painting_01a", "cutting_right_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_right_top_to_bottom_w_me_switchblade"},
        {"cutting_bottom_right_idle", "cutting_bottom_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_idle_ch_prop_vault_painting_01a", "cutting_bottom_right_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_idle_w_me_switchblade"},
        {"cutting_bottom_right_to_left", "cutting_bottom_right_to_left_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_to_left_ch_prop_vault_painting_01a", "cutting_bottom_right_to_left_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_to_left_w_me_switchblade"},
        {"cutting_bottom_left_idle", "cutting_bottom_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_left_idle_ch_prop_vault_painting_01a", "cutting_bottom_left_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_left_idle_w_me_switchblade"},
        {"cutting_left_top_to_bottom", "cutting_left_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_left_top_to_bottom_ch_prop_vault_painting_01a", "cutting_left_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_left_top_to_bottom_w_me_switchblade"},
        {"with_painting_exit", "with_painting_exit_ch_prop_ch_sec_cabinet_02a", "with_painting_exit_ch_prop_vault_painting_01a", "with_painting_exit_hei_p_m_bag_var22_arm_s", "with_painting_exit_w_me_switchblade"},
    },
}

--Spawn random ped
Config.MaleNoHandshoes = {[0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true,}

--Spawn random ped
Config.FemaleNoHandshoes = {[0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true,}

Strings = {
    ['steal_blip'] = 'Painting Heist',
    ['sell_blip'] = 'Heist Art Buyer',
    ['start_stealing'] = 'Press [E] to start stealing',
    ['cute_right'] = 'Press [E] to cut right',
    ['cute_left'] = 'Press [E] to cut left',
    ['cute_down'] = 'Press [E] to cut down',
    ['go_steal'] = 'Go to the mansion marked as a white crown on your map and steal the paintings! Bring a switchblade! You need to take all six paintings! Beware of the guards!',
    ['go_sell'] = 'Go to the LS Docks and sell the paintings! Check your map! Use your third eye to interact with the buyers!',
    ['already_cuting'] = 'Already cutting',
    ['already_heist'] = 'Heist already in progress',
    ['start_heist'] = 'Press [E] to start theft',
    ['sell_painting'] = 'Selling painting',
    ['wait_nextrob'] = 'Paintings are not ready to be stolen yet',
    ['minute'] = 'One minute',
    ['police_alert'] = 'THEFT OF VALUABLE ART, CHECK GPS.',
    ["sucess_sell"] = 'Successfully sold the paintings!',
    ["access_denied"] = "You didn't sell anything!",
    ["proggbar"] = "Selling",
    ["youdont_pictures"] = "You don't have all the pictures you need!",
    ["sell_menu"] = "Sell ​​the paintings",
    ["txt_menu"] = "You must have all 6 paintings to sell!",
    ["termite"] = "Thermite failed..",
    ["mincops"] = "Not ready",
    ["someone"] = "You are missing something..",
}