local uber_duty_locations = {
	["Los Santos"] = {
			duty = {
				x = 894.74,
				y = -180.43,
				z = 73.8,
				heading = 260.0
			}
	}
}

local NPC_REQUESTS_ENABLED = true

local JOB = {
	isOnJob = false,
	start = nil,
	destination = nil,
	customer_ped = nil,
	end_time = nil
}

local keypressOnHold = false

local NPC_CALL_WAIT_MIN = 20

local hasMissionPedSpawned = false

local onDuty = false

--------------------
-- list of models --
--------------------
local PED_MODELS = {
	"mp_m_freemode_01","mp_f_freemode_01","csb_abigail", "ig_abigail", "u_m_y_abner", "a_m_m_afriamer_01", "csb_agent", "ig_agent", "csb_mp_agent14", "ig_mp_agent14", "s_f_y_airhostess_01", "s_m_y_airworker", "u_m_m_aldinapoli", "s_m_m_movalien_01", "a_m_m_acult_01", "a_m_o_acult_01", "a_m_o_acult_02", "a_m_y_acult_01", "a_m_y_acult_02", "cs_amandatownley", "ig_amandatownley", "s_m_y_ammucity_01", "s_m_m_ammucountry", "csb_anita", "csb_anton", "u_m_y_antonb", "g_m_m_armboss_01", "g_m_m_armgoon_01", "g_m_y_armgoon_02", "g_m_m_armlieut_01", "mp_s_m_armoured_01", "s_m_m_armoured_01", "s_m_m_armoured_02", "s_m_y_armymech_01", "cs_ashley", "ig_ashley", "s_m_y_autopsy_01", "s_m_m_autoshop_01", "s_m_m_autoshop_02", "g_m_y_azteca_01", "u_m_y_babyd", "g_m_y_ballaeast_01", "g_f_y_ballas_01", "csb_ballasog", "ig_ballasog", "g_m_y_ballaorig_01", "g_m_y_ballasout_01", "cs_bankman", "ig_bankman", "u_m_m_bankman", "s_f_m_fembarber", "s_m_y_barman_01", "cs_barry", "ig_barry", "s_f_y_bartender_01", "s_m_m_cntrybar_01", "s_f_y_baywatch_01", "s_m_y_baywatch_01", "a_f_m_beach_01", "a_m_m_beach_01", "a_m_m_beach_02", "a_m_y_musclbeac_01", "a_m_y_musclbeac_02", "a_m_o_beach_01", "a_f_m_trampbeac_01", "a_m_m_trampbeac_01", "a_f_y_beach_01", "a_m_y_beach_01", "a_m_y_beach_02", "a_m_y_beach_03", "ig_benny", "ig_bestmen", "cs_beverly", "ig_beverly", "a_f_m_bevhills_01", "a_f_m_bevhills_02", "a_m_m_bevhills_01", "a_m_m_bevhills_02", "a_f_y_bevhills_01", "a_f_y_bevhills_02", "a_f_y_bevhills_03", "a_f_y_bevhills_04", "a_m_y_bevhills_01", "a_m_y_bevhills_02", "cs_orleans", "ig_orleans", "u_m_m_bikehire_01", "u_f_y_bikerchic", "a_m_y_stbla_01", "a_m_y_stbla_02", "a_f_m_bodybuild_01", "s_m_m_bouncer_01", "cs_brad", "ig_brad", "cs_bradcadaver", "a_m_y_breakdance_01", "csb_bride", "ig_bride", "csb_burgerdrug", "u_m_y_burgerdrug_01", "s_m_y_busboy_01", "a_m_y_busicas_01", "a_f_m_business_02", "a_m_m_business_01", "a_f_y_business_01", "a_f_y_business_02", "a_f_y_business_03", "a_f_y_business_04", "a_m_y_business_01", "a_m_y_business_02", "a_m_y_business_03", "s_m_o_busker_01", "csb_car3guy1", "ig_car3guy1", "csb_car3guy2", "ig_car3guy2", "cs_carbuyer", "cs_casey", "ig_casey", "s_m_y_chef_01", "csb_chef", "csb_chef2", "ig_chef", "ig_chef2", "s_m_m_chemsec_01-REMOVE", "g_m_m_chemwork_01", "g_m_m_chiboss_01", "g_m_m_chigoon_01", "csb_chin_goon", "g_m_m_chigoon_02", "g_m_m_chicold_01", "u_m_y_chip", "mp_m_claude_01", "ig_claypain", "cs_clay", "ig_clay", "csb_cletus", "ig_cletus", "s_m_y_clown_01", "s_m_y_construct_01", "s_m_y_construct_02", "u_f_m_corpse_01", "u_f_y_corpse_01", "u_f_y_corpse_02", "s_m_m_ccrew_01", "cs_chrisformage", "ig_chrisformage", "csb_customer", "a_m_y_cyclist_01", "u_m_y_cyclist_01", "cs_dale", "ig_dale", "cs_davenorton", "ig_davenorton", "mp_f_deadhooker", "s_m_y_dealer_01", "cs_debra", "cs_denise", "ig_denise", "csb_denise_friend", "cs_devin", "ig_devin", "s_m_y_devinsec_01", "csb_popov", "ig_popov", "u_m_m_doa_01", "s_m_m_dockwork_01", "s_m_y_dockwork_01", "s_m_m_doctor_01", "cs_dom", "ig_dom", "s_m_y_doorman_01", "a_m_y_dhill_01", "a_f_m_downtown_01", "a_m_y_downtown_01", "cs_drfriedlander", "ig_drfriedlander", "a_f_y_scdressy_01", "s_m_y_dwservice_01", "s_m_y_dwservice_02", "a_f_m_eastsa_01", "a_f_m_eastsa_02", "a_m_m_eastsa_01", "a_m_m_eastsa_02", "a_f_y_eastsa_01", "a_f_y_eastsa_02", "a_f_y_eastsa_03", "a_m_y_eastsa_01", "a_m_y_eastsa_02", "u_m_m_edtoh", "a_f_y_epsilon_01", "a_m_y_epsilon_01", "a_m_y_epsilon_02", "cs_tomepsilon", "ig_tomepsilon", "mp_m_exarmy_01", "u_m_y_militarybum", "cs_fabien", "ig_fabien", "s_f_y_factory_01", "s_m_y_factory_01", "g_m_y_famca_01", "mp_m_famdd_01", "g_m_y_famdnf_01", "g_f_y_families_01", "g_m_y_famfor_01", "csb_ramp_gang", "ig_ramp_gang", "a_m_m_farmer_01", "a_f_m_fatbla_01", "a_f_m_fatcult_01", "a_m_m_fatlatin_01", "a_f_m_fatwhite_01", "a_f_y_femaleagent", "cs_mrk", "ig_mrk", "u_m_o_finguru_01", "a_f_y_fitness_01", "a_f_y_fitness_02", "cs_floyd", "ig_floyd", "csb_fos_rep", "s_m_m_gaffer_01", "s_m_y_garbage", "s_m_m_gardener_01", "a_m_y_gay_01", "a_m_y_gay_02", "a_m_m_genfat_01", "a_m_m_genfat_02", "a_f_y_genhot_01", "a_f_o_genstreet_01", "a_m_o_genstreet_01", "a_m_y_genstreet_01", "a_m_y_genstreet_02", "csb_g", "u_m_m_glenstank_01", "a_m_m_golfer_01", "a_f_y_golfer_01", "a_m_y_golfer_01", "u_m_m_griff_01", "s_m_y_grip_01", "csb_groom", "ig_groom", "csb_grove_str_dlr", "cs_guadalope", "u_m_y_guido_01", "u_m_y_gunvend_01", "cs_gurk", "s_m_m_hairdress_01", "csb_hao", "ig_hao", "a_m_m_hasjew_01", "a_m_y_hasjew_01", "csb_ramp_hic", "ig_ramp_hic", "s_m_m_highsec_01", "s_m_m_highsec_02", "a_f_y_hiker_01", "a_m_y_hiker_01", "a_m_m_hillbilly_01", "a_m_m_hillbilly_02", "a_f_y_hippie_01", "u_m_y_hippie_01", "a_m_y_hippy_01", "csb_ramp_hipster", "ig_ramp_hipster", "a_f_y_hipster_01", "a_f_y_hipster_02", "a_f_y_hipster_03", "a_f_y_hipster_04", "a_m_y_hipster_01", "a_m_y_hipster_02", "a_m_y_hipster_03", "s_f_y_hooker_01", "s_f_y_hooker_02", "s_f_y_hooker_03", "u_f_y_hotposh_01", "csb_hugh", "cs_hunter", "ig_hunter", "u_m_y_imporage", "csb_imran", "a_m_m_indian_01", "a_f_o_indian_01", "a_f_y_indian_01", "a_m_y_indian_01", "u_f_y_comjane", "cs_janet", "ig_janet", "csb_janitor", "s_m_m_janitor", "ig_jay_norris", "u_m_o_taphillbilly", "u_m_m_jesus_01", "a_m_y_jetski_01", "hc_driver", "hc_gunman", "hc_hacker", "u_m_m_jewelthief", "u_f_y_jewelass_01", "cs_jewelass", "ig_jewelass", "u_m_m_jewelsec_01", "cs_jimmyboston", "ig_jimmyboston", "cs_jimmydisanto", "ig_jimmydisanto", "a_f_y_runner_01", "a_m_y_runner_01", "a_m_y_runner_02", "mp_m_marston_01", "cs_johnnyklebitz", "ig_johnnyklebitz", "cs_josef", "ig_josef", "cs_josh", "ig_josh", "a_f_y_juggalo_01", "a_m_y_juggalo_01", "u_m_y_justin", "ig_kerrymcintosh", "u_m_y_baygor", "g_m_m_korboss_01", "a_f_m_ktown_01", "a_f_m_ktown_02", "g_m_y_korlieut_01", "a_m_m_ktown_01", "a_f_o_ktown_01", "a_m_o_ktown_01", "g_m_y_korean_01", "a_m_y_ktown_01", "g_m_y_korean_02", "a_m_y_ktown_02", "cs_lamardavis", "ig_lamardavis", "s_m_m_lathandy_01", "a_m_m_stlat_02", "a_m_y_stlat_01", "a_m_y_latino_01", "cs_lazlow", "ig_lazlow", "cs_lestercrest", "ig_lestercrest", "cs_lifeinvad_01", "ig_lifeinvad_01", "ig_lifeinvad_02", "s_m_m_lifeinvad_01", "s_m_m_linecook", "u_m_m_willyfist", "s_m_m_lsmetro_01", "cs_magenta", "ig_magenta", "s_f_m_maid_01", "a_m_m_malibu_01", "u_m_y_mani", "cs_manuel", "ig_manuel", "s_m_m_mariachi_01", "u_m_m_markfost", "cs_marnie", "ig_marnie", "cs_martinmadrazo", "cs_maryann", "ig_maryann", "csb_maude", "ig_maude", "csb_rashcosvki", "ig_rashcosvki", "s_m_y_xmech_01", "s_m_y_xmech_02", "csb_mweather", "a_m_y_methhead_01", "csb_ramp_mex", "ig_ramp_mex", "g_m_m_mexboss_01", "g_m_m_mexboss_02", "g_m_y_mexgang_01", "g_m_y_mexgoon_01", "g_m_y_mexgoon_02", "g_m_y_mexgoon_03", "a_m_m_mexlabor_01", "a_m_m_mexcntry_01", "a_m_y_mexthug_01", "cs_michelle", "ig_michelle", "s_f_y_migrant_01", "s_m_m_migrant_01", "cs_milton", "ig_milton", "s_m_y_mime", "cs_joeminuteman", "ig_joeminuteman", "u_f_m_miranda", "u_f_y_mistress", "mp_f_misty_01", "cs_molly", "ig_molly", "csb_money", "ig_money", "a_m_y_motox_01", "a_m_y_motox_02", "s_m_m_movspace_01", "u_m_m_filmdirector", "s_f_y_movprem_01", "cs_movpremf_01", "s_m_m_movprem_01", "cs_movpremmale", "u_f_o_moviestar", "cs_mrsphillips", "ig_mrsphillips", "cs_mrs_thornhill", "ig_mrs_thornhill", "cs_natalia", "ig_natalia", "cs_nervousron", "ig_nervousron", "cs_nigel", "ig_nigel", "mp_m_niko_01", "a_m_m_og_boss_01", "cs_old_man1a", "ig_old_man1a", "cs_old_man2", "ig_old_man2", "cs_omega", "ig_omega", "ig_oneil", "csb_ortega", "ig_ortega", "csb_oscar", "csb_paige", "ig_paige", "a_m_m_paparazzi_01", "u_m_y_paparazzi", "u_m_m_partytarget", "u_m_y_party_01", "cs_patricia", "ig_patricia", "s_m_y_pestcont_01", "cs_dreyfuss", "ig_dreyfuss", "s_m_m_pilot_01", "s_m_y_pilot_01", "u_m_y_pogo_01", "a_m_m_polynesian_01", "g_m_y_pologoon_01", "g_m_y_pologoon_02", "a_m_y_polynesian_01", "u_f_y_poppymich", "csb_porndudes", "s_m_m_postal_01", "s_m_m_postal_02", "cs_priest", "ig_priest", "u_f_y_princess", "u_m_y_proldriver_01", "csb_prologuedriver", "a_f_m_prolhost_01", "a_m_m_prolhost_01", "u_f_o_prolhost_01", "u_f_m_promourn_01", "u_m_m_promourn_01", "csb_prolsec", "u_m_m_prolsec_01", "cs_prolsec_02", "ig_prolsec_02", "mp_g_m_pros_01", "csb_reporter", "u_m_y_rsranger_01", "u_m_m_rivalpap", "a_m_y_roadcyc_01", "s_m_y_robber_01", "csb_roccopelosi", "ig_roccopelosi", "a_f_y_rurmeth_01", "a_m_m_rurmeth_01", "cs_russiandrunk", "ig_russiandrunk", "s_f_m_shop_high", "s_f_y_shop_low", "s_m_y_shop_mask", "s_f_y_shop_mid", "a_f_m_salton_01", "a_m_m_salton_01", "a_m_m_salton_02", "a_m_m_salton_03", "a_m_m_salton_04", "a_f_o_salton_01", "a_m_o_salton_01", "a_m_y_salton_01", "g_m_y_salvaboss_01", "g_m_y_salvagoon_01", "g_m_y_salvagoon_02", "g_m_y_salvagoon_03", "s_m_m_scientist_01", "csb_screen_writer", "ig_screen_writer", "s_m_m_security_01", "mp_m_shopkeep_01", "cs_siemonyetarian", "ig_siemonyetarian", "a_f_y_skater_01", "a_m_m_skater_01", "a_m_y_skater_01", "a_m_y_skater_02", "a_f_m_skidrow_01", "a_m_m_skidrow_01", "cs_solomon", "ig_solomon", "a_f_m_soucent_01", "a_f_m_soucent_02", "a_m_m_socenlat_01", "a_m_m_soucent_01", "a_m_m_soucent_02", "a_m_m_soucent_03", "a_m_m_soucent_04", "a_f_m_soucentmc_01", "a_f_o_soucent_01", "a_f_o_soucent_02", "a_m_o_soucent_01", "a_m_o_soucent_02", "a_m_o_soucent_03", "a_f_y_soucent_01", "a_f_y_soucent_02", "a_f_y_soucent_03", "a_m_y_soucent_01", "a_m_y_soucent_02", "a_m_y_soucent_03", "a_m_y_soucent_04", "u_m_y_sbike", "u_m_m_spyactor", "u_f_y_spyactress", "u_m_y_staggrm_01", "s_m_m_strperf_01", "s_m_m_strpreach_01", "g_m_y_strpunk_01", "g_m_y_strpunk_02", "s_m_m_strvend_01", "s_m_y_strvend_01", "cs_stretch", "ig_stretch", "csb_stripper_01", "s_f_y_stripper_01", "csb_stripper_02", "s_f_y_stripper_02", "s_f_y_stripperlite", "mp_f_stripperlite", "a_m_y_sunbathe_01", "a_m_y_surfer_01", "s_f_m_sweatshop_01", "s_f_y_sweatshop_01", "ig_talina", "cs_tanisha", "ig_tanisha", "cs_taocheng", "ig_taocheng", "cs_taostranslator", "ig_taostranslator", "u_m_y_tattoo_01", "cs_tenniscoach", "ig_tenniscoach", "a_f_y_tennis_01", "a_m_m_tennis_01", "cs_terry", "ig_terry", "g_f_y_lost_01", "g_m_y_lost_01", "g_m_y_lost_02", "g_m_y_lost_03", "cs_tom", "csb_tonya", "ig_tonya", "a_f_y_topless_01", "a_f_m_tourist_01", "a_m_m_tourist_01", "a_f_y_tourist_01", "a_f_y_tourist_02", "cs_tracydisanto", "ig_tracydisanto", "a_f_m_tramp_01", "a_m_m_tramp_01", "u_m_o_tramp_01", "a_m_o_tramp_01", "s_m_m_gentransport", "a_m_m_tranvest_01", "a_m_m_tranvest_02", "s_m_m_trucker_01", "ig_tylerdix", "csb_undercover", "cs_paper", "ig_paper", "s_m_m_ups_01", "s_m_m_ups_02", "s_m_y_uscg_01", "g_f_y_vagos_01", "csb_vagspeak", "ig_vagspeak", "mp_m_g_vagfun_01", "s_m_y_valet_01", "a_m_y_beachvesp_01", "a_m_y_beachvesp_02", "a_m_y_vindouche_01", "a_f_y_vinewood_01", "a_f_y_vinewood_02", "a_f_y_vinewood_03", "a_f_y_vinewood_04", "a_m_y_vinewood_01", "a_m_y_vinewood_02", "a_m_y_vinewood_03", "a_m_y_vinewood_04", "cs_wade", "ig_wade", "s_m_y_waiter_01", "cs_chengsr", "ig_chengsr", "a_m_y_stwhi_01", "a_m_y_stwhi_02", "s_m_y_winclean_01", "a_f_y_yoga_01", "a_m_y_yoga_01", "cs_zimbor", "ig_zimbor", "u_m_y_zombie_01"}


local LOCATIONS = {
	{x = -423.45, y = 5971.05, z = 31.49, name = "Sheriff's Office - Paleto"},
	{x = 184.412, y = 6633.04,  z = 31.56, name = "Paleto Blvd / Pyrite Ave."},
	{x = -256.11, y = 6265.68, z = 31.42, name = "Hen House - Paleto"},
	--{x = -221.63, y = 6325.18, z = 31.46, name = "UNKNOWN"},
	--{x = -170.38, y = 6379.18, z = 31.47, name = "UNKNOWN"},
	{x = 56.25, y = 6607.67, z = 31.42, name = "Paleto Blvd."},
	--{x = 914.06, y = 6478.74, z = 21.27, name = "UNKNOWN"},
	--{x = 1725.16, y = 6409.43, z = 34.26, name = "UNKNOWN"},
	{x = 2751.39, y = 4405.67, z = 48.69, name = "East Joshua Rd."},
	{x = 934.95, y = 3546.02, z = 33.99, name = "Marina Dr. / E. Joshua"},
	{x = -1292.26, y = 2545.11, z = 18.01, name = "Fort Zancudo - Route 68"},
	{x = -859.79, y = 5422.63, z = 34.91, name = "Lumber Yard - GOH"},
	{x = -391.85, y = 6051.66, z = 31.5, name = "Paleto Blvd. / GOH"},
	{x = -426.28, y = 6029.36, z = 31.5, name = "Paleto Blvd. / GOH"},
	{x = -686.5, y = 5838.5, z = 17.3, name = "Bayview Lodge"},
	{x = -710.08, y = 5787.66, z = 17.4, name = "Bayview Lodge"},
	{x = -767.45, y = 5556.3, z = 33.6, name = "Bike Shop"},
	{x = -776.6, y = 5592.9, z = 33.6, name = "Bike Shop"},
	{x = -1583.6, y = 5170.87, z = 19.56, name = "Fishing Dock"},
	{x = -2203.84, y = 4274.9, z = 48.3, name = "Hookies Restaruant"},
	{x = -2205.6, y = 4283.4, z = 48.5, name = "Hookies Restaruant"},
	{x = -2508.6, y = 3620.6, z = 13.7, name = "Great Ocean Highway"},
	{x = -2561.1, y = 2316.8, z = 33.2, name = "Ron Gas Station"},
	{x = -2536.4, y = 2318.6, z = 33.2, name = "Ron Gas Station"},
	{x = 1720.6, y = 6416.8, z = 33.7, name = "24/7 Paleto"},
	{x = 1684.0, y = 6421.3, z = 32.3, name = "24/7 Paleto"},
	{x = 1593.5, y = 6447.5, z = 25.3, name = "Up N' Atom"},
	{x = 1515.0, y = 6332.8, z = 24.1, name = "Great Ocean Highway"},
	{x = 2174.3, y = 4760.6, z = 41.1, name = "Grapeseed Airfield"},
	{x = 1778.1, y = 4587.0, z = 37.7, name = "Seaview Rd."},
	{x = 1705.13, y = 4692.9, z = 42.7, name = "Grapeseed Main St."},
	{x = 1680.8, y = 4827.9, z = 42.0, name = "Grapeseed Clothing"},
	{x = 1658.6, y = 4869.8, z = 42.1, name = "Grapeseed Main St."},
	{x = 1704.4, y = 4940.8, z = 42.1, name = "Grapeseed Garage"},
	{x = 1687.6, y = 4912.1, z = 42.1, name = "Grapeseed Garage"},
	{x = 1923.5, y = 5152.5, z = 44.6, name = "Grapeseed Main St."},
	{x = 1983.0, y = 3064.6, z = 47.2, name = "Yellow Jack"},
	{x = 2010.2, y = 3051.9, z = 47.2, name = "Yellow Jack"},
	{x = 1770.1, y = 3338.7, z = 41.4, name = "Sandy Shores Airport"},
	{x = 1817.8, y = 3659.8, z = 34.3, name = "Alhambra Dr."},
	{x = 1853.0, y = 3706.5, z = 33.2, name = "Zancudo Ave."},
	{x = 1863.9, y = 3741.9, z = 33.1, name = "Zancudo Ave."},
	{x = 1696.9, y = 3771.3, z = 34.7, name = "Algonquin Blvd."},
	{x = 1513.0, y = 3766.3, z = 34.2, name = "Sandy Shores Garage"},
	{x = 1992.7, y = 3759.2, z = 32.2, name = "Alhambra Dr."},
	{x = 1853.4, y = 2582.1, z = 45.7, name = "Bolingbroke Prison"},
	{x = 1853.3, y = 2592.5, z = 45.7, name = "Bolingbroke Prison"},
	{x = 1852.5, y = 2615.1, z = 45.7, name = "Bolingbroke Prison"},
	{x = 77.2, y = -972.4, z = 29.4, name = "Vespucci Blvd. / Elgin Ave."},
	{x = 197.5, y = -1066.3, z = 29.3, name = "Strawberry Ave. / Vespucci Blvd."},
	{x = 90.6, y = -1076.7, z = 29.3, name = "Elgin Ave."},
	{x = 5.6, y = -1124.3, z = 28.4, name = "Adam's Apple Blvd."},
	{x = -191.9, y = -1295.3, z = 31.3, name = "Benny's / Power St."},
	{x = -171.5, y = -1415.2, z = 31.1, name = "Innocence Blvd."},
	{x = 5.3, y = -1594.8, z = 29.3, name = "Strawberry Ave."},
	{x = 104.3, y = -1429.4, z = 29.3, name = "Strawberry Ave."},
	{x = 112.0, y = -1344.6, z = 29.3, name = "Vanilla Unicorn"},
	{x = 162.4, y = -891.2, z = 30.5, name = "Legion Square"},
	{x = 224.8, y = -857.7, z = 30.11, name = "Legion Square"},
	{x = 216.2, y = -817.9, z = 30.6, name = "Legion Square"},
	{x = 282.1, y = -610.7, z = 43.3, name = "Pillbox Hill Hospital"},
	{x = 315.7, y = 167.9, z = 103.8, name = "Vinewood Blvd."},
	{x = 280.1, y = 180.9, z = 104.5, name = "Vinewood Blvd."},
	{x = -429.0, y = 255.7, z = 83.1, name = "Eclipse Blvd."},
	{x = -558.2, y = 269.7, z = 83.02, name = "Tequilala"},
	{x = -576.5, y = 271.4, z = 82.8, name = "Tequilala"},
	{x = -610.5, y = -167.5, z = 37.8, name = "Eastbourne Way"},
	{x = -1013.4, y = -690.7, z = 21.3, name = "San Andreas Ave."},
	{x = -1069.9, y = -795.9, z = 19.3, name = "South Rockford Dr."},
	{x = -190.9, y = -1610.9, z = 33.9, name = "Forum Dr."},
	{x = -102.7, y = -1775.7, z = 29.5, name = "Grove St."},
	{x = -773.54333496094, y = -72.531997680664, z = 37.771766662598, name = "Blvd Del Perro"},
	{x = -789.80706787109, y = -99.32349395752, z = 37.699066162109, name = "Blvd Del Perro"},
	{x = -1594.9387207031, y = -932.15966796875, z = 14.686369895935, name = "LS Pier"},
	{x = -1658.5628662109, y = -947.64642333984, z = 7.7187242507935, name = "LS Pier"},
	{x = -1585.1470947266, y = -858.49151611328, z = 10.127608299255, name = "LS Pier"},
	{x = -1597.2512207031, y = -1013.8643188477, z = 13.021708488464, name = "LS Pier"},
	{x = -2105.9208984375, y = -345.12982177734, z = 13.067786216736, name = "Great Ocean Highway / West Eclipse Blvd"},
	{x = -1100.8135986328, y = -1965.7258300781, z = 13.14351272583, name = "Greenwich Pkwy"},
	{x = -1037.6057128906, y = -2730.650390625, z = 20.169271469116, name = "LSIA"},
	{x = -1026.8984375, y = -2737.3166503906, z = 20.169271469116, name = "LSIA"},
	{x = -1004.0098876953, y = -2747.9875488281, z = 20.173109054565, name = "LSIA"},
	{x = -977.40301513672, y = -2749.798828125, z = 13.756634712219, name = "LSIA"},
	{x = -1046.2393798828, y = -2718.9233398438, z = 13.756636619568, name = "LSIA"},
	{x = 62.28258895874, y = 6.7169995307922, z = 69.078895568848, name = "Spanish Ave"},
	{x = 52.901660919189, y = 104.72672271729, z = 79.089767456055, name = "Las Lagunas Blvd"},
	{x = -96.532295227051, y = 50.743602752686, z = 71.653823852539, name = "Spanish Ave"},
	{x = -489.6962890625, y = 408.20489501953, z = 99.128761291504, name = "Cox Ave"},
	{x = 249.50717163086, y = -571.95764160156, z = 43.278659820557, name = "Elgin Ave"},
	{x = 278.80123901367, y = -585.77239990234, z = 43.311336517334, name = "Elgin Ave"},
	{x = 222.3493347168, y = -856.20599365234, z = 30.184255599976, name = "Legion Square"},
	{x = 427.8879699707, y = -817.63208007813, z = 28.933910369873, name = "Sinner St"},
	{x = 1114.4884033203, y = -766.87255859375, z = 57.733703613281, name = "Mirror Park"},
	{x = 939.05999755859, y = -572.86224365234, z = 58.089939117432, name = "Mirror Park"},
	{x = 910.59692382813, y = 25.660533905029, z = 80.041297912598, name = "Casino"},
	{x = 1174.6300048828, y = -3121.3645019531, z = 6.0280232429504, name = "LS Docks"},
	{x = 179.78440856934, y = -3002.2470703125, z = 5.7553157806396, name = "LS Docks"},
	{x = 1139.2293701172, y = -1484.8413085938, z = 34.843647003174, name = "Capital Blvd"},
	{x = 1341.0140380859, y = -1637.7999267578, z = 52.217491149902, name = "Sustancia Rd"},
	{x = -1992.3309326172, y = 451.70986938477, z = 101.79264068604, name = "North Rockford Dr"},
}

RegisterNetEvent("uber:toggleNPCRequests")
AddEventHandler("uber:toggleNPCRequests", function()
	if NPC_REQUESTS_ENABLED and JOB.isOnJob then
		JOB.isOnJob = false
		JOB.end_time = GetGameTimer()
		TriggerEvent("swayam:RemoveWayPoint")
	end
	NPC_REQUESTS_ENABLED = not NPC_REQUESTS_ENABLED
	if NPC_REQUESTS_ENABLED then
		exports.globals:notify('You are now ~g~accepting~s~ taxi requests from locals!')
	else
		exports.globals:notify('Ride requests from locals have been temporarily ~y~muted~s~!')
	end
end)


RegisterNetEvent("uber:onDuty")
AddEventHandler("uber:onDuty", function()
	keypressOnHold = true
	TriggerEvent("chatMessage", "", {}, "Welcome! Use your own vehicle to pickup people who request a ride through the 'services' app! Charge them what you want!")
	Wait(3000)
	TriggerEvent("chatMessage", "", {}, "Locals can also randomly call you while you are on duty. Use ^3/togglerequests^0 to stop or start receiving requests from locals.")
	Wait(3000)
	TriggerEvent("chatMessage", "", {}, "Use your cell phone to communicate with customers and/or type ^3/ping [id]^0 to request a person\'s location.")
	Wait(3000)
	TriggerEvent("chatMessage", "", {}, "You can have people use ^3/payuber^0 to give you money so you don't need to share your contact info.")
	DrawCoolLookingNotificationWithTaxiPic("Have a good shift!")
	keypressOnHold = false
	onDuty = true
end)

RegisterNetEvent("uber:offDuty")
AddEventHandler("uber:offDuty", function()
	DrawCoolLookingNotificationWithTaxiPic("You have clocked out! Have a good one!")
	if JOB.isOnJob then
		TaskLeaveVehicle(JOB.customer_ped, GetVehiclePedIsIn(PlayerPedId(), true), 1)
		JOB.isOnJob = false
		JOB.end_time = GetGameTimer()
		TriggerEvent("swayam:RemoveWayPoint")
	end
	onDuty = false
end)

--------------------------------------
-- GENERATE RANDOM NPC JOB PICK UPS --
--------------------------------------
Citizen.CreateThread(function()

	local AUTO_JOB_TIME_DELAY = 120000 -- in milliseconds

	function GenerateNPCJob()
		hasMissionPedSpawned = false

		local start_location = LOCATIONS[math.random(#LOCATIONS)]
		local end_location = LOCATIONS[math.random(#LOCATIONS)]
		while end_location == start_location or #(exports.globals:tableToVector3(end_location) - exports.globals:tableToVector3(start_location)) <= 500 do
			end_location = LOCATIONS[math.random(#LOCATIONS)]
		end
		TriggerEvent("chatMessage", "", {}, "^3^*[DISPATCH] ^r^7A pickup has been requested at ^3" .. start_location.name .. "^7, please respond as soon as possible!")
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'demo', 0.1)
		TriggerEvent("swayam:SetWayPointWithAutoDisable", start_location.x, start_location.y, start_location.z, 280, 60, "Ride Request")

		-- set as on job
		JOB.isOnJob = true
		JOB.start = start_location
		JOB.destination = end_location
		JOB.destination.arrived = false
		JOB.start.arrived = false
		JOB.pickupDist = #(vector3(JOB.start.x, JOB.start.y, JOB.start.z) - GetEntityCoords(PlayerPedId()))

		-- spawn ped and start job when close to pick up point since there are problems with the ped despawning and ending the job prematurely, hopeful fix
		Citizen.CreateThread(function()
			local myped = PlayerPedId()
			local startedWaitingTime = GetGameTimer()
			while true do
				if JOB.isOnJob then
					local mycoords = GetEntityCoords(myped)
					if Vdist(mycoords, start_location.x, start_location.y, start_location.z) < 100 then
						local model = GetHashKey(PED_MODELS[math.random(#PED_MODELS)])
						RequestModel(model)
						while not HasModelLoaded(model) do
							Wait(100)
						end
						JOB.customer_ped = CreatePed(4, model, start_location.x, start_location.y, start_location.z, 0.0, true, false)
						SetEntityAsMissionEntity(JOB.customer_ped, true, true)
						hasMissionPedSpawned = true
						return
					elseif GetGameTimer() - startedWaitingTime >= NPC_CALL_WAIT_MIN * 60 * 1000 then
						exports.globals:notify("Call canceled!", "^3INFO: ^0Ride cancelled!")
						JOB.isOnJob = false
						return
					end
				else 
					return
				end
				Wait(1)
			end
		end)
	end

	while true do
		local playerPed = PlayerPedId()
		------------------------------------------------
		-- unlock the door just in case it was locked --
		------------------------------------------------
		if JOB.customer_ped then
			local npcs_target_vehicle = GetVehiclePedIsTryingToEnter(JOB.customer_ped)
			if GetVehicleDoorLockStatus(npcs_target_vehicle) ~= 1 then
				SetVehicleDoorsLocked(npcs_target_vehicle, 1)
			end
		end
		----------------
		-- NOT ON JOB --
		----------------
		if NPC_REQUESTS_ENABLED and onDuty then
			if not JOB.isOnJob then
				if JOB.end_time then -- had previous job
					if GetGameTimer() - JOB.end_time >= AUTO_JOB_TIME_DELAY then
						GenerateNPCJob()
					end
				else -- this will be first job
					Wait(math.random(30000, 90000))
					GenerateNPCJob()
				end
			end
		end
		----------------------
		-- ON JOB -- PICKUP --
		----------------------
		if JOB.isOnJob then
			local playerCoords = GetEntityCoords(playerPed)
			if Vdist(playerCoords, JOB.start.x, JOB.start.y, JOB.start.z) < 8.5 and not JOB.start.arrived then
				local curVeh = GetVehiclePedIsIn(playerPed)
				for i = 2, 0, -1 do
					if IsVehicleSeatFree(curVeh, i) then
						TaskEnterVehicle(JOB.customer_ped, curVeh, 10000, i, 1.0, 1, 0)
						break
					end
				end
				JOB.start.arrived = true
				--ClearGpsPlayerWaypoint()
				--SetNewWaypoint(JOB.destination.x, JOB.destination.y)
				TriggerEvent("swayam:SetWayPointWithAutoDisable", JOB.destination.x, JOB.destination.y, JOB.destination.z, 1, 60, "Ride Destination")
				TriggerEvent("usa:notify", "Take the customer safely to ~y~" .. JOB.destination.name .. '~s~.')
			end
		end
		---------------------
		-- ON JOB -- ROUTE --
		---------------------
		if JOB.isOnJob then
			local playerCoords = GetEntityCoords(playerPed)
			if Vdist(playerCoords, JOB.destination.x, JOB.destination.y, JOB.destination.z) < 8 and not JOB.destination.arrived then
				TaskLeaveVehicle(JOB.customer_ped, GetVehiclePedIsIn(PlayerPedId(), true), 0)
				TaskWanderStandard(JOB.customer_ped, 10.0, 10)
				JOB.destination.arrived = true
				JOB.isOnJob = false
				JOB.end_time = GetGameTimer()
				JOB.customer_ped = nil
				TriggerServerEvent("uber:payDriver", Vdist(JOB.start.x, JOB.start.y, JOB.start.z, JOB.destination.x, JOB.destination.y, JOB.destination.z), JOB.pickupDist)
				Wait(3000)
				for i = 0, 4 do
					SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), true), i, true)
				end
			end
		end
		---------------------------------
		-- CHECK FOR JOB ENDING EVENTS --
		---------------------------------
		if JOB.isOnJob and not IsMissionPedWell(JOB) then
			JOB.isOnJob = false
			JOB.end_time = GetGameTimer()
			TriggerEvent("swayam:RemoveWayPoint")
			TriggerEvent("usa:notify", "Your current taxi request has been ended.")
		end
		------------------
		-- DRAW MARKERS --
		------------------
		if JOB.isOnJob then
			if not JOB.start.arrived then
				DrawText3D(JOB.start.x, JOB.start.y, JOB.start.z, 30, 'Customer')
			elseif not JOB.destination.arrived and JOB.start.arrived then
				DrawText3D(JOB.destination.x, JOB.destination.y, JOB.destination.z, 30, 'Destination')
			end
		end
		Wait(1)
	end
end)

local closest_location = {}

Citizen.CreateThread(function()
	EnumerateBlips()
	local timeout = 0
	while true do
		for name, data in pairs(uber_duty_locations) do
			DrawText3D(data.duty.x, data.duty.y, (data.duty.z + 1.0), 20, '[E] - On/Off Duty (~y~Uber~s~) | [L] - Leaderboard')
		end
		if IsControlJustPressed(0, 38) and not keypressOnHold then
			for name, data in pairs(uber_duty_locations) do
		        local playerCoords = GetEntityCoords(PlayerPedId(), false)
			    if GetDistanceBetweenCoords(playerCoords, data.duty.x, data.duty.y, data.duty.z, true) < 3 then
			    	if timeout > 3 then
						TriggerEvent('usa:notify', "You have clocked in and out too much recently, ~y~please wait~s~.")
					else
						timeout = timeout + 1
						if timeout > 3 then
							Citizen.CreateThread(function()
								local beginTime = GetGameTimer()
								while GetGameTimer() - beginTime < 10000 do
									Citizen.Wait(100)
								end
								timeout = 0
							end)
						end
						TriggerServerEvent("uber:setJob")
						JOB.isOnJob = false
						JOB.end_time = GetGameTimer()
						TriggerEvent("swayam:RemoveWayPoint")
						closest_location = data
					end
				end
			end
		end
		Wait(1)
	end
end)

RegisterNetEvent('character:setCharacter')
AddEventHandler('character:setCharacter', function()
	JOB.isOnJob = false
	JOB.end_time = GetGameTimer()
	TriggerEvent("swayam:RemoveWayPoint")
end)

function DrawCoolLookingNotificationWithTaxiPic(name, msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	SetNotificationMessage("CHAR_TAXI", "CHAR_TAXI", true, 1, name, "", msg)
	DrawNotification(0,1)
end

function DrawText3D(x, y, z, distance, text)
  if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) < distance then
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 470
    DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
  end
end

function EnumerateBlips()
	for name, data in pairs(uber_duty_locations) do
      	local blip = AddBlipForCoord(data.duty.x, data.duty.y, data.duty.z)
		SetBlipSprite(blip, 198)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.75)
		SetBlipAsShortRange(blip, true)
		SetBlipColour(blip, 39)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Uber HQ')
		EndTextCommandSetBlipName(blip)
    end
end

function IsMissionPedWell(JOB)
	if DoesEntityExist(JOB.customer_ped) then 
		if IsPedDeadOrDying(JOB.customer_ped, 1) then
			return false
		end
	else
		if hasMissionPedSpawned then
			return false
		end
	end
	return true
end

RegisterCommand('showLeaderboard', function()
	local mycoords = GetEntityCoords(PlayerPedId())
	for locName, info in pairs(uber_duty_locations) do
		if #(mycoords - vector3(info.duty.x, info.duty.y, info.duty.z)) < 3 then
			print("fetching leaderboard")
			TriggerServerEvent("uber:fetchLeaderboard")
			break
		end
	end
end, false)

RegisterKeyMapping('showLeaderboard', 'Show Leaderboard', 'keyboard', 'l')

RegisterClientCallback {
	eventName = "uber:isNearDropOff",
	eventCallback = function()
		if JOB.destination and JOB.destination.arrived then
				return true
		end
		return false
	end
}