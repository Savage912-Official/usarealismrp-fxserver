-- This collection is to prevent this script from detecting our custom warp points that teleport far distances (like the paleto jail cells into mission row pd) --
local COORDS_TO_ALLOW_TELEPORTATION_FROM = {
	{ x = -299.48, y = 6255.23, z = 30.53 }, -- Hen house entrance
	{ x = -1387.47, y = -588.195, z = 29.3195 }, -- Hen house exit
	{ x = -447.414, y = 6000.88, z = 30.7 }, -- jail interior
	{ x = 450.957, y = -986.462, z = 25.9 }, -- jail exit
	{ x = 317.283, y = -1631.1505, z = 31.59 }, -- courthouse entrance
	{ x = 234.547, y = -413.567, z = -119.365 }, -- courthouse exit
	{ x = -240.81, y = 6325.3, z = 32.43 },
	{ x = 1819.9, y = 3688.5, z = 34.22 },
	{ x  = 353.5, y = -588.9, z = 43.3 },
	{ x = 177.6, y = 6646.2, z = 31.6 }, -- LS Customs parking lot spawn point
	{ x = 751.3, y = 6454.3, z = 31.9}, -- character selection menu (prevent /swap from triggering)
	{ x = 1714.893, y = 2542.678, z = 45.565 }, -- jail 1
	{ x = 1847.086, y = 2585.990, z = 45.672 }, -- jail 2
	{ x = 1723.7, y = 2630.4, z = 45.6 }, -- jail 3
	{ x = 1738.3, y = 2644.7, z = 45.6 },  -- jail 4
	{ x = -145.09, y = 6304.72, z = 31.55 },  -- Movies entrance
	{ x = 320.21, y = 263.80, z = 82.97 },  -- Movie room
	{ x = 256.459, y = -1347.748, z = 24.538 },  -- Morgue
	{ x = 1770.7, y = 2515.5, z = 45.6 }, -- prison entrance
	{ x = 1617.3, y = 2530.5, z = 45.7 }, -- prison yard exit 1
	{ x = 1636.6, y = 2564.2, z = 45.6 }, -- hallway entrance 1
	{ x = 1633.4, y = 2576.5 , z = 45.6 }, -- hallway, inside 1
	{ x = 1655.9, y = 2576.6, z = 45.5 }, -- laundry room entrance
	{ x = 1775.4, y = 2509.1, z = 45.6 }, -- prison yard entrance 1
	{ x = 1658.8, y = 2575.9, z = 45.6 }, -- hallway exit 1
	{ x = 1725.2, y = 2584.3, z = 45.6 }, -- meal room entrance from hallway
	{ x = 1729.1, y = 2591.4, z = 45.6 }, -- meal room entrance to cell block
	{ x = 1748.0, y = 2581.8, z = 45.6 }, -- visitor area entrance from meal room
	{ x = 1835.4, y = 2570.9, z = 45.8 }, -- visitor area exit to meal room
	{ x = 1840.5, y = 2578.9, z = 45.8 }, -- visitory area exit to front
	{ x = 1725.6, y = 2566.9, z = 49.6 }, -- prison office entrance
	{ x = 1691.1, y = 2539.2, z = 50.0 }, -- prison office exit
	{ x = 1745.5, y = 2625.3, z = 45.6 }, -- prison cell block exit to meal room
	-- begin tunnels --
	{ x = 496.30267333984, y = -3222.6359863282, z = 6.0695104599 },
	{ x = 514.29266357422, y = 4885.8706054688, z = -62.589862823486 },
	{ x = 2482.9174804688, y = -405.25631713868, z = 93.735389709472 },
	{ x = 2158.1184082032, y = 2920.9382324218, z = -81.075386047364 },
	{ x = 2053.8020019532, y = 2953.4047851562, z = 47.664855957032 },
	{ x = 2151.1369628906, y = 2921.3303222656, z = -61.901874542236 },
	{ x = 1267.4091796875, y = 2830.9741210938, z = 48.444499969482 },
	{ x = 483.2006225586, y = 4810.5405273438, z = -58.919288635254 },
	{ x = 602.27032470704, y = 5546.9267578125, z = 716.38928222656},
	{ x = -355.9, y = 4823.3, z = 142.9 },
	{ x = 1259.5418701172, y = 4812.1196289062, z = -39.77448272705},
	-- end tunnels --
	{ x = 0.0, y = 0.0, z = 0.8}, -- hospital
	{ x = 360.3, y = -548.89, z = 28.74}, -- respawn in Pillbox
	{ x = 1508.97, y = 3769.1, z = 34.14}, -- spawn in sandy
	{ x = 307.48, y = -1435.36, z = 29.81}, -- respawn in Davis
	{ x = 354.03, y = -589.41, z = 43.42}, -- hospital
	{ x = 1181.63, y = -3113.83, z = 6.03}, -- cocaine enter
	{ x = 614.69, y = 2784.20, z = 43.48}, -- cocaine processing exit
	{ x = 1066.4, y = -3183.47, z = -39.16}, -- weed exit
	{ x = 2856.12, y = 4458.76, z = 48.5}, -- weed enter
	{ x = 996.50, y = -3200.201, z = -36.19}, -- meth exit
	{ x = 138.18, y = 2295.25, z = 94.09}, -- meth enter
	{ x = -1569.64, y = -3013.94, z = -74.41 }, -- night club interior
	{ x = -337.22, y = 207.74, z = 88.57 }, -- night club entrance
	{x = 300.96530151367, y = -585.62915039063, z = 43.283988952637}, -- pillbox entrance
	{x = 783.46, y = -1868.02, z = 29.27}, -- enter LS Car Meet
	{x = -2219.15, y = 1155.85, z = -23.26} -- leave LS Car Meet
}

local PROPERTY_COORDS = {
	{-1493.75, -668.33, 29.02},
	{-1498.18, -664.69, 29.02},
	{-1495.33, -661.57, 29.02},
	{-1490.72, -658.23, 29.02},
	{-1486.77, -655.44, 29.58},
	{-1482.22, -652.07, 29.58},
	{-1478.19, -649.10, 29.58},
	{-1473.60, -645.81, 29.58},
	{-1469.73, -642.97, 29.58},
	{-1465.07, -639.59, 29.58},
	{-1461.23, -640.87, 29.58},
	{-1452.40, -653.21, 29.58},
	{-1454.44, -655.91, 29.58},
	{-1458.95, -659.32, 29.58},
	{-1462.92, -662.17, 29.58},
	{-1467.47, -665.49, 29.58},
	{-1471.44, -668.38, 29.58},
	{-1461.31, -640.84, 33.38},
	{-1457.87, -645.48, 33.38},
	{-1455.66, -648.52, 33.38},
	{-1452.40, -653.20, 33.38},
	{-1454.36, -655.97, 33.38},
	{-1458.90, -659.26, 33.38},
	{-1462.92, -662.20, 33.38},
	{-1467.55, -665.52, 33.38},
	{-1471.48, -668.40, 33.38},
	{-1476.09, -671.77, 33.38},
	{-1465.08, -639.60, 33.38},
	{-1469.66, -642.91, 33.38},
	{-1473.55, -645.79, 33.38},
	{-1478.26, -649.15, 33.38},
	{-1482.22, -652.06, 33.38},
	{1142.40, 2654.65, 38.15},
	{1142.38, 2651.04, 38.14},
	{1142.34, 2643.60, 38.14},
	{1141.15, 2641.64, 38.14},
	{1136.34, 2641.68, 38.14},
	{1132.73, 2641.65, 38.14},
	{1125.22, 2641.66, 38.14},
	{1121.45, 2641.64, 38.14},
	{1114.75, 2641.64, 38.14},
	{1107.21, 2641.68, 38.14},
	{1106.01, 2649.09, 38.14},
	{1106.02, 2652.88, 38.14},
	{341.70, 2614.93, 44.67},
	{347.02, 2618.11, 44.67},
	{354.42, 2619.79, 44.67},
	{359.80, 2622.86, 44.67},
	{367.12, 2624.55, 44.67},
	{372.48, 2627.60, 44.67},
	{379.91, 2629.26, 44.67},
	{385.31, 2632.37, 44.67},
	{392.59, 2634.10, 44.67},
	{397.98, 2637.14, 44.67},
	{-85.95, -281.97, 45.55},
	{-617.00, 37.94, 43.59},
	{-775.05, 313.14, 85.69},
	{151.39, -1007.74, -99.0},
	{266.14, -1007.61, -101.00},
	{346.47, -1013.05, -99.19},
	{-781.77, 322.00, 211.99}

}

local COORDS_THAT_ALLOW_INVISIBILITY = {
	{ x = 288.62399291992, y = 6229.2231445312, z = 32.454002380372 }, -- not sure but apparently it triggers lots of false alarms
	{ x = -391.07147216797, y = 6216.5712890625, z = 31.4739818573 }, -- default spawnmanager spawn point
	{x = -337.3863,y = -136.9247,z = 38.5737},  -- LSC 1
	{x = 733.69,y = -1088.74, z = 21.733},  -- LSC 2
	{x = -1155.077,y = -2006.61, z = 12.465},  -- LSC 3
	{x = 1174.823,y = 2637.807, z = 37.045},  -- LSC 4
	{x = 108.842,y = 6628.447, z = 31.072},  -- LSC 5
	{x = -212.368,y = -1325.486, z = 30.176},  -- LSC 6
	{x= 0.0, y= 0.0, z = 1.0}, -- unsure why, but this spot was flagging
	{x = 306.6242980957, y = -590.22576904297, z = 43.283988952637}, -- pillbox entrance
	{x = -288.62399291992, y = 6229.2231445312, z = 32.454002380372}, -- was flagging when people spawn in
	{x = 178.345993042, y = 6636.7797851562, z = 32.599998474122}, -- was flagging when people spawn in
	{x = -4.214126586914, y = 6.2402596473694, z = -195.0}, -- was flagging when people spawn in
}

local BlacklistedWeapons = { -- weapons that will get people banned
	GetHashKey("WEAPON_RAILGUN"),
	 -1420407917, -- prox. mine
	 -1568386805, -- grenade launcher
	 -1312131151, -- RPG
	 1119849093, -- minigun
	 1834241177, -- railgun
	 1672152130, -- homing launcher
	 1305664598, -- smoke grenade launcher
	 125959754, -- compact launcher
	 205991906, -- heavy sniper
	 -952879014, -- marksman sniper rifle
	 -1660422300, -- heavy machine gun
	 GetHashKey("WEAPON_BALL"),
}

local enableStatus = {
	speedOrTPHack = true,
	invisibility = true,
	health = true
}

local BlacklistedObjectsList = {
	"hei_prop_carrier_radar_1_l1",
	"v_res_mexball",
	"prop_rock_1_a",
	"prop_rock_1_b",
	"prop_rock_1_c",
	"prop_rock_1_d",
	"prop_player_gasmask",
	"prop_rock_1_e",
	"prop_rock_1_f",
	"prop_rock_1_g",
	"prop_rock_1_h",
	"prop_test_boulder_01",
	"prop_test_boulder_02",
	"prop_test_boulder_03",
	"prop_test_boulder_04",
	"apa_mp_apa_crashed_usaf_01a",
	"ex_prop_exec_crashdp",
	"apa_mp_apa_yacht_o1_rail_a",
	"apa_mp_apa_yacht_o1_rail_b",
	"apa_mp_h_yacht_armchair_01",
	"apa_mp_h_yacht_armchair_03",
	"apa_mp_h_yacht_armchair_04",
	"apa_mp_h_yacht_barstool_01",
	"apa_mp_h_yacht_bed_01",
	"apa_mp_h_yacht_bed_02",
	"apa_mp_h_yacht_coffee_table_01",
	"apa_mp_h_yacht_coffee_table_02",
	"apa_mp_h_yacht_floor_lamp_01",
	"apa_mp_h_yacht_side_table_01",
	"apa_mp_h_yacht_side_table_02",
	"apa_mp_h_yacht_sofa_01",
	"apa_mp_h_yacht_sofa_02",
	"apa_mp_h_yacht_stool_01",
	"apa_mp_h_yacht_strip_chair_01",
	"apa_mp_h_yacht_table_lamp_01",
	"apa_mp_h_yacht_table_lamp_02",
	"apa_mp_h_yacht_table_lamp_03",
	"prop_flag_columbia",
	"apa_mp_apa_yacht_o2_rail_a",
	"apa_mp_apa_yacht_o2_rail_b",
	"apa_mp_apa_yacht_o3_rail_a",
	"apa_mp_apa_yacht_o3_rail_b",
	"apa_mp_apa_yacht_option1",
	"proc_searock_01",
	"apa_mp_h_yacht_",
	"apa_mp_apa_yacht_option1_cola",
	"apa_mp_apa_yacht_option2",
	"apa_mp_apa_yacht_option2_cola",
	"apa_mp_apa_yacht_option2_colb",
	"apa_mp_apa_yacht_option3",
	"apa_mp_apa_yacht_option3_cola",
	"apa_mp_apa_yacht_option3_colb",
	"apa_mp_apa_yacht_option3_colc",
	"apa_mp_apa_yacht_option3_cold",
	"apa_mp_apa_yacht_option3_cole",
	"apa_mp_apa_yacht_jacuzzi_cam",
	"apa_mp_apa_yacht_jacuzzi_ripple003",
	"apa_mp_apa_yacht_jacuzzi_ripple1",
	"apa_mp_apa_yacht_jacuzzi_ripple2",
	"apa_mp_apa_yacht_radar_01a",
	"apa_mp_apa_yacht_win",
	"prop_crashed_heli",
	"apa_mp_apa_yacht_door",
	"prop_shamal_crash",
	"xm_prop_x17_shamal_crash",
	"apa_mp_apa_yacht_door2",
	"apa_mp_apa_yacht",
	"prop_flagpole_2b",
	"prop_flagpole_2c",
	"prop_flag_canada",
	"apa_prop_yacht_float_1a",
	"apa_prop_yacht_float_1b",
	"apa_prop_yacht_glass_01",
	"apa_prop_yacht_glass_02",
	"apa_prop_yacht_glass_03",
	"apa_prop_yacht_glass_04",
	"apa_prop_yacht_glass_05",
	"apa_prop_yacht_glass_06",
	"apa_prop_yacht_glass_07",
	"apa_prop_yacht_glass_08",
	"apa_prop_yacht_glass_09",
	"apa_prop_yacht_glass_10",
	"prop_flag_canada_s",
	"prop_flag_eu",
	"prop_flag_eu_s",
	"prop_target_blue_arrow",
	"prop_target_orange_arrow",
	"prop_target_purp_arrow",
	"prop_target_red_arrow",
	"apa_prop_flag_argentina",
	"apa_prop_flag_australia",
	"apa_prop_flag_austria",
	"apa_prop_flag_belgium",
	"apa_prop_flag_brazil",
	"apa_prop_flag_canadat_yt",
	"apa_prop_flag_china",
	"apa_prop_flag_columbia",
	"apa_prop_flag_croatia",
	"apa_prop_flag_czechrep",
	"apa_prop_flag_denmark",
	"apa_prop_flag_england",
	"apa_prop_flag_eu_yt",
	"apa_prop_flag_finland",
	"apa_prop_flag_france",
	"apa_prop_flag_german_yt",
	"apa_prop_flag_hungary",
	"apa_prop_flag_ireland",
	"apa_prop_flag_israel",
	"apa_prop_flag_italy",
	"apa_prop_flag_jamaica",
	"apa_prop_flag_japan_yt",
	"apa_prop_flag_canada_yt",
	"apa_prop_flag_lstein",
	"apa_prop_flag_malta",
	"apa_prop_flag_mexico_yt",
	"apa_prop_flag_netherlands",
	"apa_prop_flag_newzealand",
	"apa_prop_flag_nigeria",
	"apa_prop_flag_norway",
	"apa_prop_flag_palestine",
	"apa_prop_flag_poland",
	"apa_prop_flag_portugal",
	"apa_prop_flag_puertorico",
	"apa_prop_flag_russia_yt",
	"apa_prop_flag_scotland_yt",
	"apa_prop_flag_script",
	"apa_prop_flag_slovakia",
	"apa_prop_flag_slovenia",
	"apa_prop_flag_southafrica",
	"apa_prop_flag_southkorea",
	"apa_prop_flag_spain",
	"apa_prop_flag_sweden",
	"apa_prop_flag_switzerland",
	"apa_prop_flag_turkey",
	"apa_prop_flag_uk_yt",
	"apa_prop_flag_us_yt",
	"apa_prop_flag_wales",
	"prop_flag_uk",
	"prop_flag_uk_s",
	"prop_flag_us",
	"prop_flag_usboat",
	"prop_flag_us_r",
	"prop_flag_us_s",
	"prop_flag_france",
	"prop_flag_france_s",
	"prop_flag_german",
	"prop_flag_german_s",
	"prop_flag_ireland",
	"prop_flag_ireland_s",
	"prop_flag_japan",
	"prop_flag_japan_s",
	"prop_flag_ls",
	"prop_flag_lsfd",
	"prop_flag_lsfd_s",
	"prop_flag_lsservices",
	"prop_flag_lsservices_s",
	"prop_flag_ls_s",
	"prop_flag_mexico",
	"prop_flag_mexico_s",
	"prop_flag_russia",
	"prop_flag_russia_s",
	"prop_flag_s",
	"prop_flag_sa",
	"prop_flag_sapd",
	"prop_flag_sapd_s",
	"prop_flag_sa_s",
	"prop_flag_scotland",
	"prop_flag_scotland_s",
	"prop_flag_sheriff",
	"prop_flag_sheriff_s",
	"prop_flag_uk",
	"prop_flag_uk_s",
	"prop_flag_us",
	"prop_flag_usboat",
	"prop_flag_us_r",
	"prop_flag_us_s",
	"prop_flamingo",
	"prop_swiss_ball_01",
	"prop_air_bigradar_l1",
	"prop_air_bigradar_l2",
	"prop_air_bigradar_slod",
	"p_fib_rubble_s",
	"prop_money_bag_01",
	"p_cs_mp_jet_01_s",
	"prop_poly_bag_money",
	"prop_air_radar_01",
	"hei_prop_carrier_radar_1",
	"prop_air_bigradar",
	"prop_carrier_radar_1_l1",
	"prop_asteroid_01",
	"prop_xmas_ext",
	"p_oil_pjack_01_amo",
	"p_oil_pjack_01_s",
	"p_oil_pjack_02_amo",
	"p_oil_pjack_03_amo",
	"p_oil_pjack_02_s",
	"p_oil_pjack_03_s",
	"prop_aircon_l_03",
	"prop_med_jet_01",
	"p_med_jet_01_s",
	"hei_prop_carrier_jet",
	"bkr_prop_biker_bblock_huge_01",
	"bkr_prop_biker_bblock_huge_02",
	"bkr_prop_biker_bblock_huge_04",
	"bkr_prop_biker_bblock_huge_05",
	"hei_prop_heist_emp",
	"prop_weed_01",
	"prop_air_bigradar",
	"prop_juicestand",
	"prop_lev_des_barge_02",
	"hei_prop_carrier_defense_01",
	"prop_aircon_m_04",
	"prop_mp_ramp_03",
	"ch3_12_animplane1_lod",
	"ch3_12_animplane2_lod",
	"hei_prop_hei_pic_pb_plane",
	"light_plane_rig",
	"prop_cs_plane_int_01",
	"prop_dummy_plane",
	"prop_mk_plane",
	"v_44_planeticket",
	"prop_planer_01",
	"ch3_03_cliffrocks03b_lod",
	"ch3_04_rock_lod_02",
	"csx_coastsmalrock_01_",
	"csx_coastsmalrock_02_",
	"csx_coastsmalrock_03_",
	"csx_coastsmalrock_04_",
	"mp_player_introck",
	"Heist_Yacht",
	"csx_coastsmalrock_05_",
	"mp_player_int_rock",
	"mp_player_introck",
	"prop_flagpole_1a",
	"prop_flagpole_2a",
	"prop_flagpole_3a",
	"prop_a4_pile_01",
	"cs2_10_sea_rocks_lod",
	"cs2_11_sea_marina_xr_rocks_03_lod",
	"prop_gold_cont_01",
	"prop_hydro_platform",
	"ch3_04_viewplatform_slod",
	"ch2_03c_rnchstones_lod",
	"proc_mntn_stone01",
	"prop_beachflag_le",
	"proc_mntn_stone02",
	"cs2_10_sea_shipwreck_lod",
	"des_shipsink_02",
	"prop_dock_shippad",
	"des_shipsink_03",
	"des_shipsink_04",
	"prop_mk_flag",
	"prop_mk_flag_2",
	"proc_mntn_stone03",
	"FreeModeMale01",
	"rsn_os_specialfloatymetal_n",
	"rsn_os_specialfloatymetal",
	"cs1_09_sea_ufo",
	"rsn_os_specialfloaty2_light2",
	"rsn_os_specialfloaty2_light",
	"rsn_os_specialfloaty2",
	"rsn_os_specialfloatymetal_n",
	"rsn_os_specialfloatymetal",
	"P_Spinning_Anus_S_Main",
	"P_Spinning_Anus_S_Root",
	"cs3_08b_rsn_db_aliencover_0001cs3_08b_rsn_db_aliencover_0001_a",
	"sc1_04_rnmo_paintoverlaysc1_04_rnmo_paintoverlay_a",
	"rnbj_wallsigns_0001",
	"proc_sml_stones01",
	"proc_sml_stones02",
	"maverick",
	"Miljet",
	"proc_sml_stones03",
	"proc_stones_01",
	"proc_stones_02",
	"proc_stones_03",
	"proc_stones_04",
	"proc_stones_05",
	"proc_stones_06",
	"prop_coral_stone_03",
	"prop_coral_stone_04",
	"prop_gravestones_01a",
	"prop_gravestones_02a",
	"prop_gravestones_03a",
	"prop_gravestones_04a",
	"prop_gravestones_05a",
	"prop_gravestones_06a",
	"prop_gravestones_07a",
	"prop_gravestones_08a",
	"prop_gravestones_09a",
	"prop_gravestones_10a",
	"prop_prlg_gravestone_05a_l1",
	"prop_prlg_gravestone_06a",
	"test_prop_gravestones_04a",
	"test_prop_gravestones_05a",
	"test_prop_gravestones_07a",
	"test_prop_gravestones_08a",
	"test_prop_gravestones_09a",
	"prop_prlg_gravestone_01a",
	"prop_prlg_gravestone_02a",
	"prop_prlg_gravestone_03a",
	"prop_prlg_gravestone_04a",
	"prop_stoneshroom1",
	"prop_stoneshroom2",
	"v_res_fa_stones01",
	"test_prop_gravestones_01a",
	"test_prop_gravestones_02a",
	"prop_prlg_gravestone_05a",
	"FreemodeFemale01",
	"p_cablecar_s",
	"stt_prop_stunt_tube_l",
	"stt_prop_stunt_track_dwuturn",
	"p_spinning_anus_s",
	--"prop_windmill_01",
	"hei_prop_heist_tug",
	"prop_air_bigradar",
	"p_oil_slick_01",
	"prop_dummy_01",
	"hei_prop_heist_emp",
	"p_tram_cash_s",
	"hw1_blimp_ce2",
	"prop_fire_exting_1a",
	"prop_fire_exting_1b",
	"prop_fire_exting_2a",
	"prop_fire_exting_3a",
	"hw1_blimp_ce2_lod",
	"hw1_blimp_ce_lod",
	"hw1_blimp_cpr003",
	"hw1_blimp_cpr_null",
	"hw1_blimp_cpr_null2",
	"prop_lev_des_barage_02",
	"hei_prop_carrier_defense_01",
	"prop_juicestand",
	"S_M_M_MovAlien_01",
	"s_m_m_movalien_01",
	"s_m_m_movallien_01",
	"u_m_y_babyd",
	"CS_Orleans",
	"A_M_Y_ACult_01",
	"S_M_M_MovSpace_01",
	"U_M_Y_Zombie_01",
	"s_m_y_blackops_01",
	"a_f_y_topless_01",
	"a_c_boar",
	"a_c_cat_01",
	"a_c_chickenhawk",
	"a_c_chimp",
	"s_f_y_hooker_03",
	"a_c_chop",
	"a_c_cormorant",
	"a_c_cow",
	"a_c_coyote",
	"v_ilev_found_cranebucket",
	"p_cs_sub_hook_01_s",
	"a_c_crow",
	"a_c_dolphin",
	"a_c_fish",
	"hei_prop_heist_hook_01",
	"prop_rope_hook_01",
	"prop_sub_crane_hook",
	"s_f_y_hooker_01",
	"prop_vehicle_hook",
	"prop_v_hook_s",
	"prop_dock_crane_02_hook",
	"prop_winch_hook_long",
	"a_c_hen",
	"a_c_humpback",
	"a_c_husky",
	"a_c_killerwhale",
	"a_c_mtlion",
	"a_c_pigeon",
	"a_c_poodle",
	"prop_coathook_01",
	"prop_cs_sub_hook_01",
	"a_c_pug",
	"a_c_rabbit_01",
	"a_c_rat",
	"a_c_retriever",
	"a_c_rhesus",
	"a_c_rottweiler",
	"a_c_sharkhammer",
	"a_c_sharktiger",
	"a_c_shepherd",
	"a_c_stingray",
	"a_c_westy",
	"CS_Orleans",
	--"prop_windmill_01",
	"prop_Ld_ferris_wheel",
	"p_tram_crash_s",
	"p_oil_slick_01",
	"p_ld_stinger_s",
	"p_ld_soc_ball_01",
	"p_parachute1_s",
	"prop_beach_fire",
	"prop_lev_des_barge_02",
	"prop_lev_des_barge_01",
	"prop_sculpt_fix",
	"prop_flagpole_2b",
	"prop_flagpole_2c",
	"prop_winch_hook_short",
	"prop_flag_canada",
	"prop_flag_canada_s",
	"prop_flag_eu",
	"prop_flag_eu_s",
	"prop_flag_france",
	"prop_flag_france_s",
	"prop_flag_german",
	"prop_ld_hook",
	"prop_flag_german_s",
	"prop_flag_ireland",
	"prop_flag_ireland_s",
	"prop_flag_japan",
	"prop_flag_japan_s",
	"prop_flag_ls",
	"prop_flag_lsfd",
	"prop_flag_lsfd_s",
	"prop_cable_hook_01",
	"prop_flag_lsservices",
	"prop_flag_lsservices_s",
	"prop_flag_ls_s",
	"prop_flag_mexico",
	"prop_flag_mexico_s",
	"csx_coastboulder_00",
	"des_tankercrash_01",
	"des_tankerexplosion_01",
	"des_tankerexplosion_02",
	"des_trailerparka_02",
	"des_trailerparkb_02",
	"des_trailerparkc_02",
	"des_trailerparkd_02",
	"des_traincrash_root2",
	"des_traincrash_root3",
	"des_traincrash_root4",
	"des_traincrash_root5",
	"des_finale_vault_end",
	"des_finale_vault_root001",
	"des_finale_vault_root002",
	"des_finale_vault_root003",
	"des_finale_vault_root004",
	"des_finale_vault_start",
	"des_vaultdoor001_root001",
	"des_vaultdoor001_root002",
	"des_vaultdoor001_root003",
	"des_vaultdoor001_root004",
	"des_vaultdoor001_root005",
	"des_vaultdoor001_root006",
	"des_vaultdoor001_skin001",
	"des_vaultdoor001_start",
	"des_traincrash_root6",
	"prop_ld_vault_door",
	"prop_vault_door_scene",
	"prop_vault_door_scene",
	"prop_vault_shutter",
	"p_fin_vaultdoor_s",
	"v_ilev_bk_vaultdoor",
	"prop_gold_vault_fence_l",
	"prop_gold_vault_fence_r",
	"prop_gold_vault_gate_01",
	"prop_bank_vaultdoor",
	"des_traincrash_root7",
	"prop_flag_russia",
	"prop_flag_russia_s",
	"prop_flag_s",
	"ch2_03c_props_rrlwindmill_lod",
	"prop_flag_sa",
	"prop_flag_sapd",
	"prop_flag_sapd_s",
	"prop_flag_sa_s",
	"prop_flag_scotland",
	"prop_flag_scotland_s",
	"prop_flag_sheriff",
	"prop_flag_sheriff_s",
	"prop_flag_uk",
	"prop_yacht_lounger",
	"prop_yacht_seat_01",
	"prop_yacht_seat_02",
	"prop_yacht_seat_03",
	"marina_xr_rocks_02",
	"marina_xr_rocks_03",
	"prop_test_rocks01",
	"prop_test_rocks02",
	"prop_test_rocks03",
	"prop_test_rocks04",
	"marina_xr_rocks_04",
	"marina_xr_rocks_05",
	"marina_xr_rocks_06",
	"prop_yacht_table_01",
	"csx_searocks_02",
	"csx_searocks_03",
	"csx_searocks_04",
	"csx_searocks_05",
	"csx_searocks_06",
	"p_yacht_chair_01_s",
	"p_yacht_sofa_01_s",
	"prop_yacht_table_02",
	"csx_coastboulder_00",
	"csx_coastboulder_01",
	"csx_coastboulder_02",
	"csx_coastboulder_03",
	"csx_coastboulder_04",
	"csx_coastboulder_05",
	"csx_coastboulder_06",
	"csx_coastboulder_07",
	"csx_coastrok1",
	"csx_coastrok2",
	"csx_coastrok3",
	"csx_coastrok4",
	"csx_coastsmalrock_01",
	"csx_coastsmalrock_02",
	"csx_coastsmalrock_03",
	"csx_coastsmalrock_04",
	"csx_coastsmalrock_05",
	"prop_yacht_table_03",
	"prop_flag_uk_s",
	"prop_flag_us",
	"prop_flag_usboat",
	"prop_flag_us_r",
	"prop_flag_us_s",
	"p_gasmask_s",
	"prop_flamingo"
}

local BlacklistedObjects = {}

for i = 1, #BlacklistedObjectsList do
	local modelName = BlacklistedObjectsList[i]
	BlacklistedObjects[modelName] = true
end

--[[ DISABLED FOR NOW UNTIL SPEEDHACK BECOMES A MORE NOTICABLE PROBLEM
Citizen.CreateThread(function()
	while true do
		Wait(30000)
		TriggerServerEvent("anticheese:timer")
	end
end)
--]]

-- speed / TP hack detection
Citizen.CreateThread(function()
	local Seconds = 7
	local MaxRunSpeed = 10
	local MaxVehSpeed = 135
	local MaxFlySpeed = 150
	local MinTriggerDistance = 300

	Citizen.Wait(60000)
	while true do
		local ped = PlayerPedId()
		local posx, posy, posz = table.unpack(GetEntityCoords(ped,true))

		local veh = IsPedInAnyVehicle(ped, true)
		local para = GetPedParachuteState(ped)
		local flyveh = IsPedInFlyingVehicle(ped)
		local rag = IsPedRagdoll(ped)
		local fall = IsPedFalling(ped)
		local parafall = IsPedInParachuteFreeFall(ped)

		Citizen.Wait(Seconds * 1000) -- wait X seconds and check again

		local newx, newy, newz = table.unpack(GetEntityCoords(ped,true))
		local newPed = PlayerPedId() -- used to make sure the peds are still the same, otherwise the player probably respawned
		local speedhack = false
		if ped == newPed and (para == -1 or para == 0) and not fall and not parafall and not rag then
			local dist = GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz, true)

			if not isAtAWarpPoint(newx, newy, newz) then
				if GetEntitySpeed(GetPlayerPed(-1)) == 0 then -- noclipping
					if dist > (MaxRunSpeed * Seconds) and dist > MinTriggerDistance then
						if not exports["usa_trunkhide"]:IsInTrunk() and not exports["usa_stretcher"]:IsInStretcher() and enableStatus.speedOrTPHack == true then
							TriggerServerEvent("AntiCheese:NoclipFlag", dist, posx,posy,posz, newx,newy,newz)
						end
					end
				else -- doing something other than no clipping
					if flyveh then
						if dist > MaxFlySpeed * Seconds then
							state = "in an aircraft"
							speedhack = true
						end
					elseif veh then
						if dist > MaxVehSpeed * Seconds then
							state = "in a vehicle"
							speedhack = true
						end
					elseif dist > MaxRunSpeed * Seconds then
						state = "on foot"
						speedhack = true
					end

					if speedhack and dist > MinTriggerDistance then
						if not exports["usa_trunkhide"]:IsInTrunk() and enableStatus.speedOrTPHack == true then
							TriggerServerEvent("AntiCheese:SpeedFlag", state, dist, posx,posy,posz, newx,newy,newz)
						end
					end
				end
			end
		end
	end
end)

local warehousecoords

function isAtAWarpPoint(x, y, z)
	for i = 1, #COORDS_TO_ALLOW_TELEPORTATION_FROM do
		local warp_to_check_against = COORDS_TO_ALLOW_TELEPORTATION_FROM[i]
		if Vdist(x, y, z, warp_to_check_against.x, warp_to_check_against.y, warp_to_check_against.z) < 15.0 then
			return true
		end
	end
	for i = 1, #PROPERTY_COORDS do
		local warp = PROPERTY_COORDS[i]
		local _x, _y, _z = table.unpack(warp)
		if Vdist(x, y, z, _x, _y, _z) < 15.0 then
			return true
		end
	end
	if warehousecoords == nil then 
		warehousecoords = exports["av-warehouse"]:getWarehouseLocations()
	else
		for i = 1, #warehousecoords do
			if Vdist(x, y, z, warehousecoords[i].x, warehousecoords[i].y, warehousecoords[i].z) < 15.0 then
				return true
			end
		end
	end
	return false
end

function isAtAnLSC()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(),true))
	for i = 1, #COORDS_THAT_ALLOW_INVISIBILITY do
		local warp_to_check_against = COORDS_THAT_ALLOW_INVISIBILITY[i]
		if Vdist(x, y, z, warp_to_check_against.x, warp_to_check_against.y, warp_to_check_against.z) < 20.0 then
			return true
		end
	end
	return false
end

-- health hack / invincibility detection
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(40000)
		local curPed = PlayerPedId()
		local curHealth = GetEntityHealth( curPed )
		TriggerEvent('injuries:triggerGrace', function()
			if enableStatus.health then
				local curWait = math.random(10,150)
				SetEntityHealth(curPed, curHealth - 2)
				-- this will substract 2hp from the current player, wait between 10 & 150ms and then add it back, this is to check for hacks that force HP at 200
				Citizen.Wait(curWait)

				if not IsPlayerDead(PlayerId()) then
					if PlayerPedId() == curPed and GetEntityHealth(curPed) == curHealth and GetEntityHealth(curPed) ~= 0 then
						TriggerServerEvent("AntiCheese:HealthFlag", false, curHealth - 2, GetEntityHealth(curPed), curWait)
					elseif GetEntityHealth(curPed) == curHealth - 2 then
						SetEntityHealth(curPed, GetEntityHealth(curPed) + 2)
					end
				end
				if GetEntityHealth(curPed) > 400 then
					TriggerServerEvent("AntiCheese:HealthFlag", false, GetEntityHealth(curPed) - 200, GetEntityHealth(curPed), curWait)
				end

				if GetPlayerInvincible(PlayerId()) and not isAtAnLSC() then  -- if the player is invincible, flag him as a cheater and then disable their invincibility
					TriggerServerEvent("AntiCheese:HealthFlag", true, curHealth - 2, GetEntityHealth(curPed), curWait)
					SetPlayerInvincible(PlayerId(), false)
				end
			end
		end)
	end
end)

-- prevent infinite ammo, godmode, and ped speed hacks
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		SetPedInfiniteAmmoClip(PlayerPedId(), false)
		SetEntityInvincible(PlayerPedId(), false)
		SetEntityCanBeDamaged(PlayerPedId(), true)
		local fallin = IsPedFalling(PlayerPedId())
		local ragg = IsPedRagdoll(PlayerPedId())
		local parac = GetPedParachuteState(PlayerPedId())
		if parac >= 0 or ragg or fallin then
			SetEntityMaxSpeed(PlayerPedId(), 80.0)
		else
			SetEntityMaxSpeed(PlayerPedId(), 7.1)
		end
	end
end)

-- invisibility detection
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if enableStatus.invisibility then
			local myped = PlayerPedId()
			if not IsEntityVisible(myped) then
				if not isAtAnLSC() then
					local veh = GetVehiclePedIsIn(myped, false)
					if veh and DoesEntityExist(veh) then
						if GetEntityModel(veh) ~= GetHashKey("rcbandito") and GetEntityModel(veh) ~= GetHashKey("GODzC6FD_RC") then
							TriggerServerEvent("AntiCheese:InvisibilityFlag", GetEntityCoords(myped)) -- when not in an rcbandito, but in vehicle
							SetEntityVisible(myped, true, 0)
						end
					else 	
						TriggerServerEvent("AntiCheese:InvisibilityFlag", GetEntityCoords(myped)) -- when not in any vehicle
						SetEntityVisible(myped, true, 0)
					end
				end
			end
		end
	end
end)

-- black listed weapons check
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(8000)
		for _, theWeapon in ipairs(BlacklistedWeapons) do
			Wait(1)
			if HasPedGotWeapon(PlayerPedId(), theWeapon, false) == 1 then
				TriggerServerEvent("AntiCheese:WeaponFlag", theWeapon)
				RemoveAllPedWeapons(PlayerPedId(), false)
			end
		end
	end
end)

--[[ black listed objects check --
function ReqAndDelete(object, detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		while not NetworkHasControlOfEntity(object) do
			Citizen.Wait(1)
		end
		if detach then
			DetachEntity(object, 0, false)
		end
		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(5000)
		local ped = PlayerPedId()
		for object in exports.globals:EnumerateObjects() do
			if DoesEntityExist(object) then
				if BlacklistedObjects[GetEntityModel(object)] then
					ReqAndDelete(object, false)
				end
			end
			Wait(15)
		end
	end
end)
--]]

-- super jump detection --
Citizen.CreateThread(function()
	while true do
		Wait(1)
		if IsPedJumping(PlayerPedId()) then
			local jumplength = 0
			repeat
				Wait(0)
				jumplength=jumplength+1
				local isStillJumping = IsPedJumping(PlayerPedId())
			until not isStillJumping
			if jumplength > 250 then
				TriggerServerEvent("AntiCheese:JumpFlag", jumplength )
			end
		end
	end
end)

--[[
Citizen.CreateThread(function()
	while true do
		TriggerServerEvent("AntiCheese:LifeCheck")
		Citizen.Wait(30000)
	end
end)
--]]

-- anti resource stopping
AddEventHandler("onResourceStop", function(resourceName)
	while securityToken == nil do 
		Wait(1)
	end
	TriggerServerEvent("anticheese:ViolationDetected", "\240\159\144\134 Anti-Resource-Stop Detection: " .. resourceName, securityToken)
end)

RegisterNetEvent("makepedskillable")
AddEventHandler("makepedskillable", function()
    Citizen.CreateThread(function()
        for ped in exports.globals:EnumeratePeds() do
            SetEntityCanBeDamaged(ped, true)
            Wait(5)
        end
        print("Made all peds killable!")
    end)
end)

RegisterNetEvent("deletenearestobjects")
AddEventHandler("deletenearestobjects", function()
    Citizen.CreateThread(function()
        for object in exports.globals:EnumerateObjects() do
    		local objcoords = GetEntityCoords(object)
			local mycoords = GetEntityCoords(GetPlayerPed(-1))
			if Vdist(mycoords.x, mycoords.y, mycoords.z, objcoords.x, objcoords.y, objcoords.z) < 50 then
				SetEntityAsMissionEntity(object, true, true)
				DeleteObject(object)
			end
            Wait(0)
        end
		print('deleted all objects')
    end)
end)

RegisterNetEvent("deletenearestvehicles")
AddEventHandler("deletenearestvehicles", function()
    Citizen.CreateThread(function()
        for veh in exports.globals:EnumerateVehicles() do
    		local vehcoords = GetEntityCoords(veh)
			local mycoords = GetEntityCoords(GetPlayerPed(-1))
			if Vdist(mycoords.x, mycoords.y, mycoords.z, vehcoords.x, vehcoords.y, vehcoords.z) < 50 then
				SetEntityAsMissionEntity(veh, true, true)
				DeleteVehicle(veh)
			end
            Wait(0)
        end
        print("** Deleted all vehicles! **")
    end)
end)

--[[ disabled because it breaks with event name scrambler (since an event name is a parameter)
RegisterNetEvent("anticheese:runAfterDisabling")
AddEventHandler("anticheese:runAfterDisabling", function(type, event, args)
	-- Disable
	Disable()
	-- Continue action
	if type == "client" then
		TriggerEvent(event, table.unpack((args or {})))
	else
		TriggerServerEvent(event, table.unpack((args or {})))
	end
	-- Enable after small delay (hopefully action completes by then)
	Wait(15000)
	Enable()
end)
--]]

RegisterNetEvent("anticheese:exitPropertyAfterDisabling")
AddEventHandler("anticheese:exitPropertyAfterDisabling", function(args)
	Disable()
	TriggerEvent("properties:exitProperty", table.unpack((args or {})))
	Wait(15000)
	Enable()
end)

function Enable(type)
	if type then
		enableStatus[type] = true
	else 
		for k, v in pairs(enableStatus) do 
			enableStatus[k] = true
		end
	end
end

function Disable(type)
	if type then
		enableStatus[type] = false
	else 
		for k, v in pairs(enableStatus) do 
			enableStatus[k] = false
		end
	end
end

--[[
Citizen.CreateThread(function()
	Wait(30000)
	while true do
		TriggerServerEvent('usa:ConfirmSession', GetNumberOfPlayers())
		Wait(60000)
	end
end)
--]]
