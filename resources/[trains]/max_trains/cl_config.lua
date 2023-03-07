Config.UseCustomClientSync = true -- mostly for multi char things
Config.CustomClientSyncEvent = "max_trains:loaded" -- client side event that gets run when a character is loaded
Config.PoliceJobName = "sheriff" -- job name for police (will add ability for multiple jobs soon)
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
}

Config.TurnstylesLocations = {
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

Config.MetrostationCoords = {
	[1] = {coords = vector3(-1042.2565, -2745.7266, 15.9190)},
	[2] = {coords = vector3(-946.0543, -2340.5015, 6.5338)},
	[3] = {coords = vector3(-540.6730, -1282.5905, 33.4663)},
	[4] = {coords = vector3(271.1004, -1204.2211, 38.9169)},
	[5] = {coords = vector3(-246.2736, -330.3786, 31.9112)},
	[6] = {coords = vector3(-824.7607, -112.1072, 31.0874)},
	[7] = {coords = vector3(-1363.5077, -524.0391, 29.8416)},
	[8] = {coords = vector3(-490.6987, -695.5313, 35.5731)},
	[9] = {coords = vector3(-220.9811, -1036.7648, 34.3784)},
	[10] = {coords = vector3(112.1726, -1723.6456, 33.1850)}, -- Locations of Metro Stations
}

Config.TrainstationCoords = {
	[1] = {coords = vector3(655.3147, -1215.3457, 27.1136)},
	[2] = {coords = vector3(2325.4028, 2676.2734, 48.2334)},
	[3] = {coords = vector3(1768.6127, 3491.1086, 42.0864)},
	[4] = {coords = vector3(-235.7802, 6037.5923, 37.3782)},
	[5] = {coords = vector3(2886.9177, 4850.3159, 66.7778)},
	[6] = {coords = vector3(2616.0828, 1679.5931, 29.3498)},
	[7] = {coords = vector3(674.3034, -966.7263, 26.5136)}, -- Locations of Train Stations
}

-- When a passanger gets in or out of a seat on a train the client side event "max_trains:setExportPassager" gets called with an argument that is either true or false depending if the person is sitting down or not, use this to disable emote's and such which will break stuff while sitting down on trains