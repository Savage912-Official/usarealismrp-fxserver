Config.UseCustomClientSync = true -- mostly for multi char things
Config.CustomClientSyncEvent = "max_trains:loaded" -- client side event that gets run when a character is loaded
Config.AllowedJobNames = {"sheriff", "corrections", "ems"} -- Table of names of jobs that are allowed into metro without ticket
Config.Functions = {
	send911 = function(reason, coords)
		-- Client Side function to trigger 911 calls
        -- reason is either noTicket, noTicketUpdate or noTicketEnd
        if reason == "noTicket" then
        	TriggerServerEvent("911:NoTicket", coords)
        elseif reason == "noTicketUpdate" then
        	TriggerServerEvent("911:NoTicketUpdate", coords)
        elseif reason == "noTicketEnd" then
        	TriggerServerEvent("911:NoTicketEnd", coords)
        end
	end,
}

Config.Keys = { -- https://docs.fivem.net/docs/game-references/controls/
	doors = {
		index = 47,
		name = "INPUT_DETONATE",
	}
}

Config.Menus = "ox_lib" -- NativeUI or ox_lib

Config.UseOxTarget = false -- If false use 3dText for the clockin points, if true it will be a ox_target point
Config.TargetPed = "ig_trafficwarden" -- If you use Ox Target you can specify the ped model of the clock in point here

Config.Blips = {
	trains = true,
	metros = true,
	trainStations = false,
	frightStations = false,
	metroStations = false,
	trainClockIn = true,
	metroClockIn = true
}

Config.NamedStationBlips = false -- true: Each blip will include the station name e.g. "LSIA Terminal 4 Metro Station" and will not be grouped, false: all station blips will be named e.g. "Metro Station and will be grouped"

Config.EnableNPCPassangers = true -- enables NPCs that will spawn at stations and get on trains

Config.MetroClockInCoords = vector3(-918.1724, -2345.6904, -3.5075) -- Location to clock in as Metro Driver
Config.TrainClockInCoords = vector3(235.8775, -2506.5186, 6.4852) -- Location to clock in as Train Driver

Config.TicketMachineModels = { -- Models that count as ticket machines
	'prop_train_ticket_02',
	'prop_train_ticket_02_tu'
}

Config.TicketMachineCoords = { -- Locations here where you want ticket machines to appear additionally to the models you have set above!
	vector3(656.5287, -1216.6416, 24.7288),
	vector3(656.5995, -1215.4160, 24.7288),
	vector3(656.6309, -1214.1396, 24.7288),
	vector3(656.5386, -1212.8849, 24.7288),
	vector3(654.2658, -1212.8998, 24.7287),
	vector3(654.2506, -1214.1533, 24.7287),
	vector3(654.2059, -1215.4633, 24.7287),
	vector3(654.1624, -1216.6091, 24.7287),
	vector3(675.1742, -968.1018, 23.4772),
	vector3(675.1564, -966.8605, 23.4772),
	vector3(675.2309, -965.5681, 23.4772),
	vector3(675.1404, -964.4034, 23.4772),
	vector3(672.9257, -964.4099, 23.4773),
	vector3(672.8621, -965.6062, 23.4773),
	vector3(672.8605, -966.7598, 23.4773),
	vector3(672.8602, -968.1181, 23.4773),
	vector3(2328.3696, 2676.4756, 45.5602),
	vector3(2327.2871, 2676.0879, 45.5602),
	vector3(2326.1616, 2675.5554, 45.5602),
	vector3(2325.0371, 2675.0825, 45.5602),
	vector3(2328.4436, 2676.4978, 45.5601),
	vector3(2327.3330, 2676.0420, 45.5601),
	vector3(2326.0913, 2675.5286, 45.5602),
	vector3(2324.9307, 2675.0571, 45.5602),
	vector3(1769.5721, 3490.7168, 39.4500),
	vector3(1768.5219, 3490.0818, 39.4500),
	vector3(1767.4751, 3489.5032, 39.4500),
	vector3(1766.2870, 3488.8232, 39.4500),
	vector3(1765.2615, 3490.9688, 39.4500),
	vector3(1766.2001, 3491.3999, 39.4500),
	vector3(1767.2905, 3492.0210, 39.4500),
	vector3(1768.3812, 3492.6616, 39.4500),
	vector3(-238.9935, 6037.0249, 34.7139),
	vector3(-238.3404, 6037.6743, 34.7139),
	vector3(-237.4695, 6038.5732, 34.7139),
	vector3(-236.5120, 6039.5522, 34.7139),
	vector3(-234.7809, 6038.0498, 34.7139),
	vector3(-235.6033, 6037.0967, 34.7139),
	vector3(-236.5086, 6036.1626, 34.7139),
	vector3(-237.4038, 6035.2373, 34.7139),
	vector3(2887.8413, 4851.2563, 63.8540),
	vector3(2888.5701, 4850.1069, 63.8540),
	vector3(2889.1328, 4849.1807, 63.8540),
	vector3(2889.7324, 4848.0474, 63.8540),
	vector3(2887.7844, 4846.8423, 63.8541),
	vector3(2887.2178, 4847.7417, 63.8540),
	vector3(2886.5317, 4848.8760, 63.8540),
	vector3(2885.9768, 4849.9365, 63.8540),
	vector3(2619.0161, 1690.5801, 27.5985),
	vector3(298.9805, -1205.5347, 38.8926),
	vector3(299.0714, -1203.0671, 38.8926),
	vector3(281.8425, -1203.0641, 38.9000),
	vector3(278.9162, -1203.0573, 38.8945),
	vector3(276.9263, -1203.0562, 38.8943),
	vector3(276.9967, -1205.5442, 38.8942),
	vector3(278.7496, -1205.5029, 38.8941),
	vector3(281.9468, -1205.4637, 38.9001),
	vector3(251.5182, -1208.0530, 29.2894),
	vector3(253.4942, -1208.0487, 29.2893),
	vector3(253.6056, -1200.2748, 29.2905),
	vector3(251.4944, -1200.2795, 29.2907),
	vector3(-538.9167, -1281.6249, 26.8978),
	vector3(-539.3651, -1282.7717, 26.9016),
	vector3(-539.8860, -1283.9149, 26.9016),
	vector3(-540.4699, -1284.9905, 26.9016),
	vector3(-542.5540, -1284.0881, 26.9016),
	vector3(-542.1733, -1282.9955, 26.9016),
	vector3(-541.5959, -1281.7271, 26.9016),
	vector3(-541.1106, -1280.7523, 26.9016),
	vector3(114.8817, -1723.8153, 30.1127),
	vector3(115.874, -1724.5706, 30.1125),
	vector3(116.7617, -1725.3156, 30.1124),
	vector3(117.7211, -1726.1691, 30.1122),
	vector3(116.1228, -1728.0105, 30.111),
	vector3(115.3784, -1727.4043, 30.111),
	vector3(114.3982, -1726.5631, 30.111),
	vector3(113.3179, -1725.6561, 30.111),
	vector3(-215.3572, -1035.4037, 30.1402),
	vector3(-214.9624, -1034.0469, 30.1403),
	vector3(-214.5096, -1032.8025, 30.1404),
	vector3(-214.2056, -1031.8635, 30.1404),
	vector3(-211.788, -1032.613, 30.1393),
	vector3(-212.2858, -1033.9766, 30.1394),
	vector3(-212.7909, -1035.1025, 30.1394),
	vector3(-213.042, -1036.1014, 30.1395),
}

Config.TurnstylesLocations = { -- Location Table of Turn Styles objects to freeze if no ticket is held
	[1] = {
		loc = vector3(-1020.3160, -2757.8701, 0.8004),
		turns = {
			vector3(-1022.2480, -2756.2490, 0.8004),
			vector3(-1021.2727, -2757.0674, 0.8004),
			vector3(-1020.3160, -2757.8701, 0.8004),
			vector3(-1019.2583, -2758.9009, 0.8004),
			vector3(-1018.2509, -2759.6030, 0.8004),
			vector3(-1017.1321, -2760.3723, 0.8004),
		}
	},
	[2] = {
		loc = vector3(-912.0556, -2344.9514, -3.5075),
		turns = {
			vector3(-914.3019, -2344.0649, -3.5075),
			vector3(-912.9307, -2344.3442, -3.5075),
			vector3(-911.7369, -2344.6340, -3.5075),
			vector3(-910.5648, -2344.9932, -3.5075),
		}
	},
	[3] = {
		loc = vector3(-254.3792, -300.0914, 22.7021),
		turns = {
			vector3(-252.7600, -298.8625, 21.6264),
			vector3(-253.7731, -299.5502, 21.6264),
			vector3(-255.0815, -300.0813, 21.6264),
			vector3(-256.4116, -300.3788, 21.6264),
			vector3(-257.5578, -301.0357, 21.6264),
		}
	},
	[4] = {
		loc = vector3(-848.0947, -127.0109, 28.1850),
		turns = {
			vector3(-849.2919, -127.6018, 28.1850),
			vector3(-848.0947, -127.0109, 28.1850),
			vector3(-846.8268, -126.3374, 28.1850),
			vector3(-845.8637, -125.6419, 28.1850),
		}
	},
	[5] = {
		loc = vector3(-1350.0304, -505.4706, 23.2694),
		turns = {
			vector3(-1351.2556, -506.0207, 23.2694),
			vector3(-1350.4050, -505.1778, 23.2694),
			vector3(-1348.9192, -504.7301, 23.2694),
			vector3(-1347.8159, -504.1477, 23.2694),
		}
	},
	[6] = {
		loc = vector3(-468.8262, -709.1548, 20.0318),
		turns = {
			vector3(-468.7133, -708.9543, 20.0318),
			vector3(-467.4447, -709.0997, 20.0318),
			vector3(-470.0827, -709.2374, 20.0319),
			vector3(-471.2856, -709.2271, 20.0319),
		}
	} -- Locations of turnstyles
}

Config.Metrostations = { -- Locations of Metro Station (Do not change keys of trackNodes)
	[1] = {
		id = 1,
		name = "LSIA Terminal 4",
		blipCoords = vector3(-1042.2565, -2745.7266, 15.9190),
		platformCoords = vector3(-1084.5409, -2719.6482, -7.4101),
		trackNodes = {
			toDaviesPlatform = {
				id = 3,
				announce = 482,
				entrance = 527,
				exit = 531,
			},
			toLSIAPlatform = {
				id = 2,
				announce = 404,
				entrance = 426,
				exit = 436,
			}
		},
		npc_spawns = {
			vector4(-1062.4326, -2690.6887, -7.4101, 230.0212),
			vector4(-1067.1393, -2696.6462, -7.4101, 321.5453),
			vector4(-1069.2924, -2701.5647, -7.3539, 229.8863),
			vector4(-1078.575, -2710.24, -7.4101, 219.9619),
			vector4(-1083.7942, -2717.479, -7.4101, 206.8496),
			vector4(-1090.1899, -2721.3579, -7.4101, 52.46),
			vector4(-1100.0002, -2735.6082, -7.4101, 136.9564),
			vector4(-1092.0283, -2730.801, -7.4101, 48.5905),
		},
		npc_exit = vector3(-1037.4563, -2734.8599, 13.7566)
	},
	[2] = {
		id = 2,
		name = "LSIA Parking",
		blipCoords = vector3(-946.0543, -2340.5015, 6.5338),
		platformCoords = vector3(-883.6993, -2315.2178, -11.7328),
		trackNodes = {
			toDaviesPlatform = {
				id = 4,
				announce = 552,
				entrance = 574,
				exit = 578,
			},
			toLSIAPlatform = {
				id = 1,
				announce = 360,
				entrance = 382,
				exit = 389,
			}
		},
		npc_spawns = {
			vector4(-872.3915, -2292.6086, -11.7328, 248.1187),
			vector4(-896.6879, -2351.7761, -11.7327, 67.8747),
			vector4(-891.3614, -2348.6392, -11.7327, 292.4834),
			vector4(-888.5789, -2340.0505, -11.7327, 238.139),
			vector4(-892.1348, -2337.7151, -11.7327, 74.3519),
			vector4(-886.0245, -2320.5737, -11.7327, 60.704),
			vector4(-882.3046, -2319.9912, -11.7327, 256.9256),
			vector4(-877.5103, -2308.821, -11.7328, 43.5704),
			vector4(-880.9233, -2302.7654, -11.7328, 142.8136),
		},
		npc_exit = vector3(-950.0262, -2337.5574, 5.0128)
	},
	[3] = {
		id = 3,
		name = "Puerto del Sol",
		blipCoords = vector3(-540.6730, -1282.5905, 33.4663),
		platformCoords = vector3(-540.7547, -1282.7534, 29.4656),
		trackNodes = {
			toDaviesPlatform = {
				id = 5,
				announce = 647,
				entrance = 685,
				exit = 696,
			},
			toLSIAPlatform = {
				id = 20,
				announce = 220,
				entrance = 264,
				exit = 275,
			}
		},
		npc_spawns = {
			vector4(-542.7839, -1288.5205, 26.9016, 239.0267),
			vector4(-548.678, -1303.6011, 26.9016, 302.3071),
			vector4(-547.7557, -1298.4998, 26.9016, 146.818),
			vector4(-542.5885, -1289.5184, 26.9016, 221.2125),
			vector4(-544.6168, -1289.0775, 26.8991, 59.0628),
			vector4(-543.6476, -1285.2479, 26.9016, 146.3993),
			vector4(-541.4348, -1286.3827, 26.8972, 272.0837),
			vector4(-537.0546, -1277.0739, 26.9016, 255.3959),
			vector4(-539.7273, -1278.4873, 26.9016, 58.0844),
			vector4(-533.1506, -1262.5923, 26.9016, 236.6943),
			vector4(-531.136, -1265.9357, 26.9016, 142.8176),
		},
		npc_exit = vector3(-560.3966, -1242.5780, 14.9225)
	},
	[4] = {
		id = 4,
		name = "Strawberry",
		blipCoords = vector3(271.1004, -1204.2211, 38.9169),
		platformCoords = vector3(263.8945, -1204.2205, 42.4809),
		trackNodes = {
			toDaviesPlatform = {
				id = 6,
				announce = 750,
				entrance = 775,
				exit = 787,
			},
			toLSIAPlatform = {
				id = 19,
				announce = 95,
				entrance = 164,
				exit = 185,
			}
		},
		npc_spawns = {
			vector4(284.0793, -1205.9843, 38.9203, 181.9953),
			vector4(232.9268, -1206.5759, 38.8965, 175.5234),
			vector4(234.812, -1201.9337, 38.8941, 4.9832),
			vector4(244.4566, -1202.1565, 38.9259, 272.5989),
			vector4(259.8692, -1202.3156, 38.896, 358.8003),
			vector4(272.9237, -1204.2477, 38.9011, 86.1093),
			vector4(289.7028, -1202.3594, 38.91, 329.8098),
			vector4(286.4898, -1205.855, 38.9335, 182.8125),
			vector4(300.0627, -1206.5439, 38.8958, 138.2482),
			vector4(300.4841, -1202.6538, 38.8932, 358.1403),
			vector4(296.242, -1201.9861, 38.8991, 88.032),
		},
		npc_exit = vector3(289.2064, -1203.9829, 29.2916)
	},
	[5] = {
		id = 5,
		name = "Burton",
		blipCoords = vector3(-246.2736, -330.3786, 31.9112),
		platformCoords = vector3(-292.9330, -332.3137, 10.0631),
		trackNodes = {
			toDaviesPlatform = {
				id = 7,
				announce = 1036,
				entrance = 1070,
				exit = 1083,
			},
			toLSIAPlatform = {
				id = 18,
				announce = 2095,
				entrance = 2147,
				exit = 2156,
			}
		},
		npc_spawns = {
			vector4(-291.6056, -296.1888, 10.0632, 239.2614),
			vector4(-296.0325, -295.8782, 10.0632, 81.1503),
			vector4(-296.8486, -307.4198, 10.0632, 260.4874),
			vector4(-293.4311, -309.7793, 10.0632, 298.6333),
			vector4(-291.615, -318.7206, 10.0632, 99.4431),
			vector4(-295.851, -319.2151, 10.0632, 72.1445),
			vector4(-296.3601, -323.7913, 10.0632, 266.3021),
			vector4(-292.5851, -340.2958, 10.0631, 253.2403),
			vector4(-295.5543, -337.3961, 10.0631, 65.2326),
			vector4(-297.9943, -347.5827, 10.0631, 58.831),
			vector4(-292.9268, -354.8846, 10.0631, 269.7274),
		},
		npc_exit = vector3(-239.32, -326.69, 30.0217),
	},
	[6] = {
		id = 6,
		name = "Portola Drive",
		blipCoords = vector3(-824.7607, -112.1072, 31.0874),
		platformCoords = vector3(-815.2302, -135.4008, 19.9070),
		trackNodes = {
			toDaviesPlatform = {
				id = 8,
				announce = 1130,
				entrance = 1157,
				exit = 1162,
			},
			toLSIAPlatform = {
				id = 17,
				announce = 2027,
				entrance = 2063,
				exit = 2066,
			}
		},
		npc_spawns = {
			vector4(-815.3879, -135.0947, 19.9503, 26.1193),
			vector4(-813.1476, -139.2236, 19.9503, 214.0766),
			vector4(-805.7755, -134.2978, 19.9503, 0.9116),
			vector4(-801.291, -133.0352, 19.9503, 2.8596),
			vector4(-792.6765, -127.9522, 19.9503, 223.3072),
			vector4(-793.8799, -122.5772, 19.9503, 36.3768),
			vector4(-804.3557, -127.7548, 19.9503, 170.9787),
			vector4(-808.5464, -131.6577, 19.9503, 30.5973),
			vector4(-826.9089, -140.6917, 19.9504, 178.3111),
			vector4(-822.7858, -143.9571, 19.9504, 179.7525),
			vector4(-834.3937, -150.8165, 19.9504, 206.0755),
			vector4(-836.5225, -147.4118, 19.9504, 11.9553),
			vector4(-839.7401, -151.8549, 19.9504, 118.9368),
		},
		npc_exit = vector3(-825.9507, -112.6923, 27.958),
	},
	[7] = {
		id = 7,
		name = "Del Perro",
		blipCoords = vector3(-1363.5077, -524.0391, 29.8416),
		platformCoords = vector3(-1353.9834, -464.0378, 15.0453),
		trackNodes = {
			toDaviesPlatform = {
				id = 9,
				announce = 1196,
				entrance = 1230,
				exit = 1234,
			},
			toLSIAPlatform = {
				id = 16,
				announce = 1918,
				entrance = 1971,
				exit = 1979,
			}
		},
		npc_spawns = {
			vector4(-1354.571, -464.3095, 15.0453, 120.9721),
			vector4(-1350.424, -471.204, 15.0454, 147.4697),
			vector4(-1346.1456, -481.2209, 15.0454, 208.3644),
			vector4(-1337.7515, -488.644, 15.0454, 205.7327),
			vector4(-1334.1238, -495.3616, 15.0454, 70.3203),
			vector4(-1338.739, -483.5101, 15.0454, 314.1833),
			vector4(-1343.4827, -473.2703, 15.0454, 120.2966),
			vector4(-1349.781, -462.743, 15.0453, 297.6242),
			vector4(-1356.129, -450.9299, 15.0453, 128.069),
			vector4(-1367.3077, -437.92, 15.0453, 206.4279),
			vector4(-1361.7427, -453.3603, 15.0453, 277.064),
			vector4(-1357.6558, -459.5988, 15.0453, 222.2512),
		},
		npc_exit = vector3(-1367.9949, -518.6791, 30.8591),
	},
	[8] = {
		id = 8,
		name = "Little Seoul",
		blipCoords = vector3(-490.6987, -695.5313, 35.5731),
		platformCoords = vector3(-502.5693, -674.7533, 11.8090),
		trackNodes = {
			toDaviesPlatform = {
				id = 10,
				announce = 1303,
				entrance = 1327,
				exit = 1332,
			},
			toLSIAPlatform = {
				id = 15,
				announce = 1816,
				entrance = 1860,
				exit = 1870,
			}
		},
		npc_spawns = {
			vector4(-502.6447, -675.6484, 11.809, 180.0603),
			vector4(-495.1579, -675.3068, 11.809, 167.9221),
			vector4(-489.8788, -676.1215, 11.809, 344.123),
			vector4(-473.4078, -673.2281, 11.809, 267.5135),
			vector4(-469.6644, -676.6896, 11.809, 233.6277),
			vector4(-467.1315, -671.3517, 11.809, 359.4613),
			vector4(-479.7603, -669.9582, 11.809, 60.829),
			vector4(-489.546, -670.3154, 11.809, 180.1448),
			vector4(-494.4127, -671.4504, 11.809, 179.4449),
			vector4(-504.0944, -670.7741, 11.809, 89.3369),
			vector4(-516.158, -670.0962, 11.809, 173.45),
			vector4(-528.2404, -671.0755, 11.809, 130.7798),
		},
		npc_exit = vector3(-483.5039, -706.4333, 33.2103),
	},
	[9] = {
		id = 9,
		name = "Pillbox South",
		blipCoords = vector3(-220.9811, -1036.7648, 34.3784),
		platformCoords = vector3(-214.0222, -1035.3766, 32.0866),
		trackNodes = {
			toDaviesPlatform = {
				id = 11,
				announce = 1365,
				entrance = 1392,
				exit = 1399,
			},
			toLSIAPlatform = {
				id = 14,
				announce = 1714,
				entrance = 1785,
				exit = 1792,
			}
		},
		npc_spawns = {
			vector4(-214.6268, -1040.0902, 30.1398, 247.6808),
			vector4(-216.4975, -1039.1741, 30.1401, 65.2157),
			vector4(-222.01, -1050.4619, 30.1406, 249.1259),
			vector4(-219.2441, -1054.0571, 30.1404, 60.6455),
			vector4(-216.9668, -1047.4965, 30.1408, 53.5643),
			vector4(-210.9297, -1030.0414, 30.1391, 272.9458),
			vector4(-211.6967, -1026.2367, 30.1404, 17.3246),
			vector4(-208.3455, -1018.4807, 30.1384, 304.1086),
			vector4(-208.3388, -1012.7552, 30.1394, 235.224),
			vector4(-205.1005, -1017.6339, 30.139, 64.715),
		},
		npc_exit = vector3(-219.9794, -1079.0917, 29.2925),
	},
	[10] = {
		id = 10,
		name = "Davis",
		blipCoords = vector3(112.1726, -1723.6456, 33.1850),
		platformCoords = vector3(115.4997, -1725.8308, 32.2810),
		trackNodes = {
			toDaviesPlatform = {
				id = 12,
				announce = 1457,
				entrance = 1515,
				exit = 1526,
			},
			toLSIAPlatform = {
				id = 13,
				announce = 1600,
				entrance = 1640,
				exit = 1652,
			}
		},
		npc_spawns = {
			vector4(100.279, -1712.923, 30.1126, 230.9561),
			vector4(108.3165, -1720.8649, 30.1115, 159.3586),
			vector4(112.4326, -1722.3903, 30.1131, 314.1846),
			vector4(119.5363, -1727.4845, 30.1119, 338.8954),
			vector4(121.4202, -1732.4196, 30.1067, 171.5152),
			vector4(129.8525, -1739.9148, 30.1098, 322.8767),
			vector4(130.2828, -1737.2478, 30.11, 46.7356),
		},
		npc_exit = vector3(121.7709, -1754.5076, 29.1344),
	},
}

Config.Trainstations = { -- Locations of Train Station
	[1] = {
		id = 1,
		name = "La Mesa Northbound",
		blipCoords = vector3(655.3147, -1215.3457, 27.1136),
		trackNodes = {
			announce = 2750,
			entrance = 2833,
			exit = 2842,
		},
		npc_spawns = {
			vector4(654.4934, -1237.4087, 24.9, 354.8235),
			vector4(656.6368, -1233.8131, 24.9, 329.9128),
			vector4(656.4943, -1220.9169, 24.9, 262.9753),
			vector4(656.8945, -1216.415, 24.9, 30.6701),
			vector4(656.063, -1210.0135, 24.9, 269.0206),
			vector4(656.3471, -1202.015, 24.9, 275.8854),
			vector4(656.2825, -1195.6235, 24.9, 225.9602),
		},
		npc_exit = vector3(650.2557, -1250.6451, 22.0224),
	},
	[2] = {
		id = 2,
		name = "Grand Senora Desert",
		blipCoords = vector3(2325.4028, 2676.2734, 48.2334),
		trackNodes = {
			announce = 3675,
			entrance = 3814,
			exit = 3827,
		},
		npc_spawns = {
			vector4(2310.2366, 2669.5994, 45.8, 282.3888),
			vector4(2321.7419, 2674.0718, 45.9, 240.2256),
			vector4(2331.2793, 2678.1841, 45.9, 222.7537),
			vector4(2336.3477, 2679.3513, 45.9, 214.4715),
			vector4(2343.1702, 2682.1121, 45.9, 93.4303),
			vector4(2317.2617, 2671.3994, 45.9, 213.9419),
		},
		npc_exit = vector3(2332.3169, 2633.3008, 46.673),
	},
	[3] = {
		id = 3,
		name = "Sandy Shores",
		blipCoords = vector3(1768.6127, 3491.1086, 42.0864),
		trackNodes = {
			announce = 4100,
			entrance = 4157,
			exit = 4162,
		},
		npc_spawns = {
			vector4(1749.3188, 3480.6577, 39.75, 271.9073),
			vector4(1752.0287, 3480.9353, 39.75, 275.9349),
			vector4(1756.354, 3483.0178, 39.75, 198.2101),
			vector4(1763.4041, 3486.4531, 39.75, 229.4576),
			vector4(1770.2419, 3490.8896, 39.75, 308.4456),
			vector4(1776.4431, 3494.2747, 39.75, 250.1453),
			vector4(1783.5596, 3499.0796, 39.75, 164.1722),
		},
		npc_exit = vector3(1786.8433, 3519.2463, 37.2169),
	},
	[4] = {
		id = 4,
		name = "Paleto Bay",
		blipCoords = vector3(-235.7802, 6037.5923, 37.3782),
		trackNodes = {
			announce = 465,
			entrance = 571,
			exit = 582,
		},
		npc_spawns = {
			vector4(-223.062, 6051.9751, 34.9, 110.5426),
			vector4(-228.6118, 6047.7642, 34.9, 30.6716),
			vector4(-229.8928, 6046.9102, 34.9, 127.1842),
			vector4(-234.2298, 6042.0908, 34.9, 113.8031),
			vector4(-240.4688, 6036.1055, 34.9, 82.305),
			vector4(-242.091, 6034.3706, 34.9, 93.9495),
			vector4(-244.5713, 6031.9341, 34.9, 94.203),
			vector4(-246.9692, 6028.9575, 34.9, 99.2826),
			vector4(-249.3959, 6024.6777, 34.9, 3.7292),
		},
		npc_exit = vector3(-236.8799, 6058.0938, 31.9658),
	},
	[5] = {
		id = 5,
		name = "Grapeseed",
		blipCoords = vector3(2886.9177, 4850.3159, 66.7778),
		trackNodes = {
			announce = 1090,
			entrance = 1161,
			exit = 1177,
		},
		npc_spawns = {
			vector4(2876.5698, 4867.7104, 64.1, 205.7096),
			vector4(2878.8853, 4864.8521, 64.1, 219.8997),
			vector4(2881.6243, 4861.7905, 64.1, 258.3907),
			vector4(2883.3416, 4858.9688, 64.1, 283.4689),
			vector4(2885.4409, 4854.5249, 64.1, 287.638),
			vector4(2891.5952, 4845.3374, 64.1, 287.0369),
			vector4(2895.085, 4839.6968, 64.1, 180.8612),
			vector4(2896.3936, 4838.0317, 64.1, 289.4783),
			vector4(2898.4685, 4833.0791, 64.1, 21.1308),
			
		},
		npc_exit = vector3(2908.5542, 4802.2773, 61.3073),
	},
	[6] = {
		id = 6,
		name = "Palmer Taylor Power Station",
		blipCoords = vector3(2616.0828, 1679.5931, 29.3498),
		trackNodes = {
			announce = 1570,
			entrance = 1682,
			exit = 1697,
		},
		npc_spawns = {
			vector4(2616.0173, 1661.0238, 27.8, 102.7271),
			vector4(2617.4192, 1666.2755, 27.8, 353.6575),
			vector4(2616.7366, 1670.0565, 27.8, 71.6126),
			vector4(2617.5244, 1676.4817, 27.8, 73.1591),
			vector4(2615.7969, 1683.9385, 27.8, 11.1583),
			vector4(2615.2395, 1690.5846, 27.8, 75.8533),
			vector4(2617.0605, 1700.3599, 27.8, 89.2961),
		},
		npc_exit = vector3(2647.282, 1647.6238, 25.3053),
	},
	[7] = {
		id = 7,
		name = "La Mesa Southbound",
		blipCoords = vector3(674.3034, -966.7263, 26.5136),
		trackNodes = {
			announce = 2323,
			entrance = 2396,
			exit = 2407,
		},
		npc_spawns = {
			vector4(674.8596, -944.1766, 23.8, 134.4245),
			vector4(675.0479, -948.3568, 23.8, 123.7513),
			vector4(672.2946, -952.8797, 23.8, 143.3581),
			vector4(673.1016, -962.5244, 23.8, 41.4506),
			vector4(673.2733, -972.2892, 23.8, 107.2801),
			vector4(672.9597, -978.4117, 23.8, 98.9231),
			vector4(674.3782, -985.6774, 23.8, 68.3205),
		},
		npc_exit = vector3(691.0467, -993.3947, 23.5989),
	},
}

Config.Freightstations = { -- Locations of Freight Station
	[1] = {blipCoords = vector3(2198.7576, 1370.5172, 80.4136)},
	[2] = {blipCoords = vector3(-461.6186, 5302.9126, 85.1555)},
	[3] = {blipCoords = vector3(-103.9750, 6173.7231, 32.3536)},
	[4] = {blipCoords = vector3(3026.1238, 4252.7388, 61.0190)},
	[5] = {blipCoords = vector3(2625.2561, 2937.1685, 40.4228)},
	[6] = {blipCoords = vector3(2617.8208, 1660.0692, 27.6023)},
}

Config.NPCPassangerModels = { -- add any ped models you want the NPC passangers to be
	"a_f_o_soucent_02",
	"a_f_y_business_03",
	"a_f_y_tourist_01",
	"a_m_m_afriamer_01",
	"a_m_m_soucent_03",
	"a_m_y_beachvesp_01",
	"a_m_y_business_02",
	"a_m_y_hippy_01",
	"a_m_y_soucent_01",
	"g_f_y_ballas_01",
	"a_f_m_salton_01",
	"a_f_m_soucent_01"
}

Config.SpawnTimeTable = { -- Max amount of NPC to spawn at a station per in game hour
	3, -- 0100
	3, -- 0200
	2, -- 0300
	2, -- 0400
	2, -- 0500
	4, -- 0600
	6, -- 0700
	8, -- 0800
	8, -- 0900
	6, -- 1000
	5, -- 1100
	5, -- 1200
	5, -- 1300
	4, -- 1400
	4, -- 1500
	7, -- 1600
	8, -- 1700
	6, -- 1800
	5, -- 1900
	5, -- 2000
	4, -- 2100
	4, -- 2200
	2, -- 2300
	2, -- 2400
}

-- When a passanger gets in or out of a seat on a train the client side event "max_trains:setExportPassager" gets called with an argument that is either true or false depending if the person is sitting down or not, use this to disable emote's and such which will break stuff while sitting down on trains