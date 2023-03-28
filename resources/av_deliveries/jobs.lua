jobs = {
	[1] = {
		jobName = 'The Lost', -- Name displayed on menu
		useCutscene = true, -- Use cutscene?
		cutscene = 'mph_nar_bik_ext', -- Cutscene name
		price = 2000, -- How much does it cost to start the job?
		account = 'black_money', -- Account used to pay the mission (only works with ESX), QBCORE uses cash
		minCops = 0, -- How many Cops online do u need to trigger this job?
		callCops = true, -- Send a notification + blip to Cops?
		cooldownTime = 45, -- 45 minutes
		rewardType = 'money', -- Reward types: 'items', 'money' or 'both'
		moneyReward = 5000, -- Only works if you have rewardType = 'money' or 'both'
		accountReward = 'black_money', -- The moneyReward account (only works with ESX), QBCORE uses cash
		vehicleModel = 'gburrito', -- The vehicle model
		vehicleLocation = {x = 55.72, y = 3711.99, z = 39.75, heading = 348.49}, -- Spawn location for the vehicle
		deliveryLocation = {x = 605.26, y = -417.72, z = 24.74}, 
		items = { -- Only works if you have rewardType = 'items' or 'both'
			{name = "Water", price = 25, type = "drink", substance = 40.0, quantity = 2, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
			{name = "Tuna Sandwich", price = 70, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_sandwich_01"},
		},
		guardsToSpawn = 10, -- How many guards will spawn? You can use math.random(min,max)
		guardsModels = { -- Available models for this mission, we will create the NPC using a random model from this list
			'g_m_y_lost_01',
			'g_m_y_lost_02',
			'g_m_y_lost_03',
			'g_f_y_lost_01',
		},
		guardsWeapons = { -- We will give one random weapon from this list to each guard
			'WEAPON_PISTOL',
			'WEAPON_HEAVYPISTOL',
			'WEAPON_MICROSMG'
		},
		guardsLocation = {
			{51.713077545166, 3725.0314941406, 39.644844055176},
			{48.436256408691, 3714.8439941406, 39.746013641357},
			{52.04239654541, 3709.5112304688, 39.754928588867},
			{57.845714569092, 3708.1235351562, 39.75513458252},
			{58.773052215576, 3710.9353027344, 39.755149841309},
			{61.662708282471, 3713.8383789062, 39.754940032959},
			{63.944995880127, 3719.3901367188, 39.743701934814},
			{58.883804321289, 3722.0913085938, 39.740375518799},
			{52.472068786621, 3721.9653320312, 39.733974456787},
			{53.610107421875, 3725.2443847656, 39.66092300415},
		},
		available = true -- DON'T CHANGE THIS, UNLESS YOU WANNA MAKE THE JOB UNAVAILABLE FOR EVERYONE
	},
	[2] = {
		jobName = 'Kuruma Job', -- Name displayed on menu
		useCutscene = true, -- Use cutscene?
		cutscene = 'mph_tut_car_ext', -- Cutscene name
		price = 2000, -- How much does it cost to start the job?
		account = 'black_money', -- Account used to pay the mission (only works with ESX), QBCORE uses cash
		minCops = 0, -- How many Cops online do u need to trigger this job?
		callCops = true, -- Send a notification + blip to Cops?
		cooldownTime = 45, -- 45 minutes
		rewardType = 'money', -- Reward types: 'items', 'money' or 'both'
		moneyReward = 5000, -- Only works if you have rewardType = 'money' or 'both'
		accountReward = 'black_money', -- The moneyReward account (only works with ESX), QBCORE uses cash
		vehicleModel = 'kuruma2', -- The vehicle model
		vehicleLocation = {x = -539.11, y = -2808.67, z = 6.110, heading = 215.49}, -- Spawn location for the vehicle
		deliveryLocation = {x = 693.11, y = -1005.30, z = 22.88}, 
		items = { -- Only works if you have rewardType = 'items' or 'both'
			{name = "Water", price = 25, type = "drink", substance = 40.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
			{name = "Tuna Sandwich", price = 70, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_sandwich_01"},
		},
		guardsToSpawn = 10, -- How many guards will spawn? You can use math.random(min,max)
		guardsModels = { -- Available models for this mission, we will create the NPC using a random model from this list
			'a_m_y_juggalo_01',
			'a_m_y_latino_01',
			'a_m_y_salton_01',
			'a_m_y_soucent_02',
		},
		guardsWeapons = { -- We will give one random weapon from this list to each guard
			'WEAPON_PISTOL',
			'WEAPON_HEAVYPISTOL',
			'WEAPON_MICROSMG'
		},
		guardsLocation = {
			{-498.04205322266, -2813.2302246094, 6.1003852844238},
			{-504.21151733398, -2830.5520019531, 6.100382900238},
			{-524.95654296875, -2837.3662109375, 6.1003833770752},
			{-549.54418945312, -2802.2958984375, 6.1003957748413},
			{-554.01538085938, -2805.6857910156, 6.1003838539124},
			{-555.09533691406, -2812.4548339844, 6.100385761261},
			{-550.72216796875, -2821.5815429688, 6.100385761261},
			{-543.98004150391, -2828.1730957031, 6.1003819465637},
			{-537.21600341797, -2827.2729492188, 6.1003838539124},
			{-531.25921630859, -2820.8464355469, 6.1003843307495},
		},
		available = true -- DON'T CHANGE THIS, UNLESS YOU WANNA MAKE THE JOB UNAVAILABLE FOR EVERYONE
	},
	[3] = {
		jobName = 'Scrapyard Job', -- Name displayed on menu
		useCutscene = true, -- Use cutscene?
		cutscene = 'mph_nar_tra_ext', -- Cutscene name
		price = 2000, -- How much does it cost to start the job?
		account = 'black_money', -- Account used to pay the mission (only works with ESX), QBCORE uses cash
		minCops = 0, -- How many Cops online do u need to trigger this job?
		callCops = true, -- Send a notification + blip to Cops?
		cooldownTime = 45, -- 45 minutes
		rewardType = 'money', -- Reward types: 'items', 'money' or 'both'
		moneyReward = 5000, -- Only works if you have rewardType = 'money' or 'both'
		accountReward = 'black_money', -- The moneyReward account (only works with ESX), QBCORE uses cash
		vehicleModel = 'trash', -- The vehicle model
		vehicleLocation = {x = -550.11, y = -1662.49, z = 19.22, heading = 216.25}, -- Spawn location for the vehicle
		deliveryLocation = {x = 605.26, y = -417.72, z = 24.74}, 
		items = { -- Only works if you have rewardType = 'items' or 'both'
			{name = "Water", price = 25, type = "drink", substance = 40.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
			{name = "Tuna Sandwich", price = 70, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_sandwich_01"},
		},
		guardsToSpawn = 10, -- How many guards will spawn? You can use math.random(min,max)
		guardsModels = { -- Available models for this mission, we will create the NPC using a random model from this list
			'g_m_y_mexgoon_01',
			'g_m_y_mexgoon_02',
			'g_m_y_mexgoon_03',
			'g_m_y_pologoon_01',
		},
		guardsWeapons = { -- We will give one random weapon from this list to each guard
			'WEAPON_PISTOL',
			'WEAPON_HEAVYPISTOL',
			'WEAPON_MICROSMG'
		},
		guardsLocation = {
			{-546.96740722656, -1658.5216064453, 19.308416366577},
			{-550.0751953125, -1649.4819335938, 19.148145675659},
			{-556.87487792969, -1648.2419433594, 19.155162811279},
			{-562.11041259766, -1651.1947021484, 19.18695640564},
			{-562.68713378906, -1657.7257080078, 19.181903839111},
			{-560.99951171875, -1666.0610351562, 19.231683731079},
			{-548.70727539062, -1672.7777099609, 19.343187332153},
			{-541.11608886719, -1668.5739746094, 19.275493621826},
			{-535.07312011719, -1678.2666015625, 19.157943725586},
			{-536.62329101562, -1679.7788085938, 19.151899337769},
		},
		available = true -- DON'T CHANGE THIS, UNLESS YOU WANNA MAKE THE JOB UNAVAILABLE FOR EVERYONE
	},
	[4] = {
		jobName = 'Airfield Truck', -- Name displayed on menu
		useCutscene = true, -- Use cutscene?
		cutscene = 'mph_nar_wee_ext', -- Cutscene name
		price = 2000, -- How much does it cost to start the job?
		account = 'black_money', -- Account used to pay the mission (only works with ESX), QBCORE uses cash
		minCops = 0, -- How many Cops online do u need to trigger this job?
		callCops = true, -- Send a notification + blip to Cops?
		cooldownTime = 45, -- 45 minutes
		rewardType = 'both', -- Reward types: 'items', 'money' or 'both'
		moneyReward = 5000, -- Only works if you have rewardType = 'money' or 'both'
		accountReward = 'black_money', -- The moneyReward account (only works with ESX), QBCORE uses cash
		vehicleModel = 'benson', -- The vehicle model
		vehicleLocation = {x = 1730.56, y = 3312.11, z = 41.22, heading = 194.81}, -- Spawn location for the vehicle
		deliveryLocation = {x = 605.26, y = -417.72, z = 24.74}, 
		items = { -- Only works if you have rewardType = 'items' or 'both'
			{name = "Water", price = 25, type = "drink", substance = 40.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
			{name = "Tuna Sandwich", price = 70, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_sandwich_01"},
		},
		guardsToSpawn = 10, -- How many guards will spawn? You can use math.random(min,max)
		guardsModels = { -- Available models for this mission, we will create the NPC using a random model from this list
			'g_f_y_families_01',
			'g_f_y_ballas_01',
			'g_f_y_vagos_01',
			'g_f_importexport_01',
			'g_m_y_ballaeast_01',
			'g_m_y_ballaorig_01',
			'g_m_y_ballasout_01',
			'g_m_y_famca_01',
			'g_m_y_famfor_01',
		},
		guardsWeapons = { -- We will give one random weapon from this list to each guard
			'WEAPON_PISTOL',
			'WEAPON_HEAVYPISTOL',
			'WEAPON_MICROSMG'
		},
		guardsLocation = {
			{1744.0444335938, 3301.8391113281, 41.223476409912},
			{1725.6616210938, 3296.2722167969, 41.223476409912},
			{1724.7637939453, 3302.2202148438, 41.223476409912},
			{1722.4420166016, 3307.787109375, 41.223476409912},
			{1722.0192871094, 3318.1042480469, 41.223476409912},
			{1726.4351806641, 3321.6657714844, 41.223480224609},
			{1742.8986816406, 3296.4345703125, 41.109355926514},
			{1727.4598388672, 3291.685546875, 41.180919647217},
			{1730.2059326172, 3299.6206054688, 41.223510742188},
			{1719.1481933594, 3317.5773925781, 41.223518371582},
		},
		available = true -- DON'T CHANGE THIS, UNLESS YOU WANNA MAKE THE JOB UNAVAILABLE FOR EVERYONE
	},
	[5] = {
		jobName = 'Ballas Truck', -- Name displayed on menu
		useCutscene = true, -- Use cutscene?
		cutscene = 'mph_nar_wee_ext', -- Cutscene name
		price = 2000, -- How much does it cost to start the job?
		account = 'black_money', -- Account used to pay the mission (only works with ESX), QBCORE uses cash
		minCops = 0, -- How many Cops online do u need to trigger this job?
		callCops = true, -- Send a notification + blip to Cops?
		cooldownTime = 45, -- 45 minutes
		rewardType = 'money', -- Reward types: 'items', 'money' or 'both'
		moneyReward = 5000, -- Only works if you have rewardType = 'money' or 'both'
		accountReward = 'black_money', -- The moneyReward account (only works with ESX), QBCORE uses cash
		vehicleModel = 'benson', -- The vehicle model
		vehicleLocation = {x = 1535.75, y = -2096.31, z = 77.09, heading = 341.69}, -- Spawn location for the vehicle
		deliveryLocation = {x = 605.26, y = -417.72, z = 24.74}, 
		items = { -- Only works if you have rewardType = 'items' or 'both'
			{name = "Water", price = 25, type = "drink", substance = 40.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
			{name = "Tuna Sandwich", price = 70, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_sandwich_01"},
		},
		guardsToSpawn = 10, -- How many guards will spawn? You can use math.random(min,max)
		guardsModels = { -- Available models for this mission, we will create the NPC using a random model from this list			
			'g_f_y_ballas_01',
			'g_m_y_ballaeast_01',
			'g_m_y_ballaorig_01',
			'g_m_y_ballasout_01',
		},
		guardsWeapons = { -- We will give one random weapon from this list to each guard
			'WEAPON_PISTOL',
			'WEAPON_HEAVYPISTOL',
			'WEAPON_MICROSMG'
		},
		guardsLocation = {
			{1529.2138671875, -2102.1364746094, 76.967712402344},
			{1531.7412109375, -2095.7685546875, 77.056213378906},
			{1531.263671875, -2087.5871582031, 77.083534240723},
			{1530.4193115234, -2072.7790527344, 77.257865905762},
			{1541.7121582031, -2065.40625, 77.193794250488},
			{1550.8677978516, -2072.0734863281, 77.13591003418},
			{1551.8957519531, -2086.1042480469, 77.105728149414},
			{1558.1588134766, -2102.13671875, 81.816581726074},
			{1552.8729248047, -2115.8227539062, 77.235870361328},
			{1534.5727539062, -2112.7561035156, 76.875045776367},
		},
		available = true -- DON'T CHANGE THIS, UNLESS YOU WANNA MAKE THE JOB UNAVAILABLE FOR EVERYONE
	},
	[6] = {
		jobName = 'Airport Job', -- Name displayed on menu
		useCutscene = false, -- Use cutscene?
		cutscene = '', -- Cutscene name
		price = 2000, -- How much does it cost to start the job?
		account = 'black_money', -- Account used to pay the mission (only works with ESX), QBCORE uses cash
		minCops = 0, -- How many Cops online do u need to trigger this job?
		callCops = false, -- Send a notification + blip to Cops?
		cooldownTime = 45, -- 45 minutes
		rewardType = 'money', -- Reward types: 'items', 'money' or 'both'
		moneyReward = 5000, -- Only works if you have rewardType = 'money' or 'both'
		accountReward = 'black_money', -- The moneyReward account (only works with ESX), QBCORE uses cash
		vehicleModel = 'velum', -- The vehicle model
		vehicleLocation = {x = -1648.55, y = -3144.89, z = 13.99, heading = 341.69}, -- Spawn location for the vehicle
		deliveryLocation = {x = 2134.78, y = 4780.46, z = 41.50}, 
		items = { -- Only works if you have rewardType = 'items' or 'both'
			{name = "Water", price = 25, type = "drink", substance = 40.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
			{name = "Tuna Sandwich", price = 70, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_sandwich_01"},
		},
		guardsToSpawn = 10, -- How many guards will spawn? You can use math.random(min,max)
		guardsModels = { -- Available models for this mission, we will create the NPC using a random model from this list			
			'mp_m_fibsec_01',
			'mp_m_securoguard_01',
		},
		guardsWeapons = { -- We will give one random weapon from this list to each guard
			'WEAPON_PISTOL',
			'WEAPON_HEAVYPISTOL',
			'WEAPON_MICROSMG'
		},
		guardsLocation = {
			{-1621.2647705078, -3140.3371582031, 13.992218017578},
			{-1627.7333984375, -3126.5563964844, 13.948254585266},
			{-1654.8673095703, -3115.8166503906, 13.992218971252},
			{-1669.7807617188, -3122.8032226562, 13.991698265076},
			{-1666.6436767578, -3131.8188476562, 13.992257118225},
			{-1647.3128662109, -3124.6811523438, 13.992219924927},
			{-1611.8549804688, -3132.6469726562, 14.356823921204},
			{-1615.6401367188, -3142.7145996094, 13.991752624512},
			{-1622.5015869141, -3147.6003417969, 13.992233276367},
			{-1629.0986328125, -3149.7951660156, 13.992231369019},
		},
		available = false -- DON'T CHANGE THIS, UNLESS YOU WANNA MAKE THE JOB UNAVAILABLE FOR EVERYONE
	},
}