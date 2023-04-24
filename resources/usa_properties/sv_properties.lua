local zones = { ['golf'] = "Picture Perfect Drive", ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local properties = {
	['Perrera Beach Motel'] = {
		location = 'Bay City Avenue, Los Santos',
		interior = 'motel',
		type = 'motel',
		weightLimit = 100,
		cashLimit = 10000,
		office = {-1477.11, -674.48, 29.04},
		rooms = {
			{name = 'Room 1', coords = {-1493.75, -668.33, 29.02}, heading = 317.0, voiceChannel = 501, owner = false, instance = {}, locked = true},
			{name = 'Room 2', coords = {-1498.18, -664.69, 29.02}, heading = 317.0, voiceChannel = 502, owner = false, instance = {}, locked = true},
			{name = 'Room 3', coords = {-1495.33, -661.57, 29.02}, heading = 213.0, voiceChannel = 503, owner = false, instance = {}, locked = true},
			{name = 'Room 4', coords = {-1490.72, -658.23, 29.02}, heading = 213.0, voiceChannel = 504, owner = false, instance = {}, locked = true},
			{name = 'Room 5', coords = {-1486.77, -655.44, 29.58}, heading = 213.0, voiceChannel = 505, owner = false, instance = {}, locked = true},
			{name = 'Room 6', coords = {-1482.22, -652.07, 29.58}, heading = 213.0, voiceChannel = 506, owner = false, instance = {}, locked = true},
			{name = 'Room 7', coords = {-1478.19, -649.10, 29.58}, heading = 213.0, voiceChannel = 507, owner = false, instance = {}, locked = true},
			{name = 'Room 8', coords = {-1473.60, -645.81, 29.58}, heading = 213.0, voiceChannel = 508, owner = false, instance = {}, locked = true},
			{name = 'Room 9', coords = {-1469.73, -642.97, 29.58}, heading = 213.0, voiceChannel = 509, owner = false, instance = {}, locked = true},
			{name = 'Room 10', coords = {-1465.07, -639.59, 29.58}, heading = 213.0, voiceChannel = 510, owner = false, instance = {}, locked = true},
			{name = 'Room 11', coords = {-1461.23, -640.87, 29.58}, heading = 124.0, voiceChannel = 511, owner = false, instance = {}, locked = true},
			{name = 'Room 12', coords = {-1452.40, -653.21, 29.58}, heading = 124.0, voiceChannel = 512, owner = false, instance = {}, locked = true},
			{name = 'Room 13', coords = {-1454.44, -655.91, 29.58}, heading = 34.0, voiceChannel = 513, owner = false, instance = {}, locked = true},
			{name = 'Room 14', coords = {-1458.95, -659.32, 29.58}, heading = 34.0, voiceChannel = 514, owner = false, instance = {}, locked = true},
			{name = 'Room 15', coords = {-1462.92, -662.17, 29.58}, heading = 34.0, voiceChannel = 515, owner = false, instance = {}, locked = true},
			{name = 'Room 16', coords = {-1467.47, -665.49, 29.58}, heading = 34.0, voiceChannel = 516, owner = false, instance = {}, locked = true},
			{name = 'Room 17', coords = {-1471.44, -668.38, 29.58}, heading = 34.0, voiceChannel = 517, owner = false, instance = {}, locked = true},
			{name = 'Room 18', coords = {-1461.31, -640.84, 33.38}, heading = 130.0, voiceChannel = 518, owner = false, instance = {}, locked = true},
			{name = 'Room 19', coords = {-1457.87, -645.48, 33.38}, heading = 130.0, voiceChannel = 519, owner = false, instance = {}, locked = true},
			{name = 'Room 20', coords = {-1455.66, -648.52, 33.38}, heading = 130.0, voiceChannel = 520, owner = false, instance = {}, locked = true},
			{name = 'Room 21', coords = {-1452.40, -653.20, 33.38}, heading = 130.0, voiceChannel = 521, owner = false, instance = {}, locked = true},
			{name = 'Room 22', coords = {-1454.36, -655.97, 33.38}, heading = 34.0, voiceChannel = 522, owner = false, instance = {}, locked = true},
			{name = 'Room 23', coords = {-1458.90, -659.26, 33.38}, heading = 34.0, voiceChannel = 523, owner = false, instance = {}, locked = true},
			{name = 'Room 24', coords = {-1462.92, -662.20, 33.38}, heading = 34.0, voiceChannel = 524, owner = false, instance = {}, locked = true},
			{name = 'Room 25', coords = {-1467.55, -665.52, 33.38}, heading = 34.0, voiceChannel = 525, owner = false, instance = {}, locked = true},
			{name = 'Room 26', coords = {-1471.48, -668.40, 33.38}, heading = 34.0, voiceChannel = 526, owner = false, instance = {}, locked = true},
			{name = 'Room 27', coords = {-1476.09, -671.77, 33.38}, heading = 34.0, voiceChannel = 527, owner = false, instance = {}, locked = true},
			{name = 'Room 28', coords = {-1465.08, -639.60, 33.38}, heading = 213.0, voiceChannel = 528, owner = false, instance = {}, locked = true},
			{name = 'Room 29', coords = {-1469.66, -642.91, 33.38}, heading = 213.0, voiceChannel = 529, owner = false, instance = {}, locked = true},
			{name = 'Room 30', coords = {-1473.55, -645.79, 33.38}, heading = 213.0, voiceChannel = 530, owner = false, instance = {}, locked = true},
			{name = 'Room 31', coords = {-1478.26, -649.15, 33.38}, heading = 213.0, voiceChannel = 531, owner = false, instance = {}, locked = true},
			{name = 'Room 32', coords = {-1482.22, -652.06, 33.38}, heading = 213.0, voiceChannel = 532, owner = false, instance = {}, locked = true}
		}
	},
	['The Motor Hotel'] = {
		location = 'Route 68, Blaine County',
		interior = 'motel',
		type = 'motel',
		weightLimit = 100,
		cashLimit = 10000,
		office = {1142.32, 2663.89, 38.16},
		rooms = {
			{name = 'Room 1', coords = {1142.40, 2654.65, 38.15}, heading = 93.0, voiceChannel = 601, owner = false, instance = {}, locked = true},
			{name = 'Room 2', coords = {1142.38, 2651.04, 38.14}, heading = 93.0, voiceChannel = 602, owner = false, instance = {}, locked = true},
			{name = 'Room 3', coords = {1142.34, 2643.60, 38.14}, heading = 93.0, voiceChannel = 603, owner = false, instance = {}, locked = true},
			{name = 'Room 4', coords = {1141.15, 2641.64, 38.14}, heading = 93.0, voiceChannel = 604, owner = false, instance = {}, locked = true},
			{name = 'Room 5', coords = {1136.34, 2641.68, 38.14}, heading = 1.0, voiceChannel = 605, owner = false, instance = {}, locked = true},
			{name = 'Room 6', coords = {1132.73, 2641.65, 38.14}, heading = 1.0, voiceChannel = 606, owner = false, instance = {}, locked = true},
			{name = 'Room 7', coords = {1125.22, 2641.66, 38.14}, heading = 1.0, voiceChannel = 607, owner = false, instance = {}, locked = true},
			{name = 'Room 8', coords = {1121.45, 2641.64, 38.14}, heading = 1.0, voiceChannel = 608, owner = false, instance = {}, locked = true},
			{name = 'Room 9', coords = {1114.75, 2641.64, 38.14}, heading = 1.0, voiceChannel = 609, owner = false, instance = {}, locked = true},
			{name = 'Room 10', coords = {1107.21, 2641.68, 38.14}, heading = 1.0, voiceChannel = 610, owner = false, instance = {}, locked = true},
			{name = 'Room 11', coords = {1106.01, 2649.09, 38.14}, heading = 267.0, voiceChannel = 611, owner = false, instance = {}, locked = true},
			{name = 'Room 12', coords = {1106.02, 2652.88, 38.14}, heading = 267.0, voiceChannel = 612, owner = false, instance = {}, locked = true}
		}
	},
	['Eastern Motel'] = {
		location = 'Harmony, Blaine County',
		interior = 'motel',
		type = 'motel',
		weightLimit = 100,
		cashLimit = 10000,
		office = {316.98, 2622.9, 44.45},
		rooms = {
			{name = 'Room 1', coords = {341.70, 2614.93, 44.67}, heading = 31.0, voiceChannel = 701, owner = false, instance = {}, locked = true},
			{name = 'Room 2', coords = {347.02, 2618.11, 44.67}, heading = 31.0, voiceChannel = 702, owner = false, instance = {}, locked = true},
			{name = 'Room 3', coords = {354.42, 2619.79, 44.67}, heading = 31.0, voiceChannel = 703, owner = false, instance = {}, locked = true},
			{name = 'Room 4', coords = {359.80, 2622.86, 44.67}, heading = 31.0, voiceChannel = 704, owner = false, instance = {}, locked = true},
			{name = 'Room 5', coords = {367.12, 2624.55, 44.67}, heading = 31.0, voiceChannel = 705, owner = false, instance = {}, locked = true},
			{name = 'Room 6', coords = {372.48, 2627.60, 44.67}, heading = 31.0, voiceChannel = 706, owner = false, instance = {}, locked = true},
			{name = 'Room 7', coords = {379.91, 2629.26, 44.67}, heading = 31.0, voiceChannel = 707, owner = false, instance = {}, locked = true},
			{name = 'Room 8', coords = {385.31, 2632.37, 44.67}, heading = 31.0, voiceChannel = 708, owner = false, instance = {}, locked = true},
			{name = 'Room 9', coords = {392.59, 2634.10, 44.67}, heading = 31.0, voiceChannel = 709, owner = false, instance = {}, locked = true},
			{name = 'Room 10', coords = {397.98, 2637.14, 44.67}, heading = 31.0, voiceChannel = 710, owner = false, instance = {}, locked = true}
		}
	},
	['Burton Apartments'] = {
		location = 'Occupation Avenue, Los Santos',
		interior = 'lowapartment',
		type = 'apartment',
		payment = 1500,
		weightLimit = 250,
		cashLimit = 30000,
		office = {-83.31, -282.18, 45.5},
		rooms = {
			{name = 'Apartment 1', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 801, owner = false, instance = {}, locked = true},
			{name = 'Apartment 2', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 802, owner = false, instance = {}, locked = true},
			{name = 'Apartment 3', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 803, owner = false, instance = {}, locked = true},
			{name = 'Apartment 4', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 804, owner = false, instance = {}, locked = true},
			{name = 'Apartment 5', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 805, owner = false, instance = {}, locked = true},
			{name = 'Apartment 6', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 806, owner = false, instance = {}, locked = true},
			{name = 'Apartment 7', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 807, owner = false, instance = {}, locked = true},
			{name = 'Apartment 8', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 808, owner = false, instance = {}, locked = true},
			{name = 'Apartment 9', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 809, owner = false, instance = {}, locked = true},
			{name = 'Apartment 10', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 810, owner = false, instance = {}, locked = true},
			{name = 'Apartment 11', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 811, owner = false, instance = {}, locked = true},
			{name = 'Apartment 12', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 812, owner = false, instance = {}, locked = true},
			{name = 'Apartment 13', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 813, owner = false, instance = {}, locked = true},
			{name = 'Apartment 14', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 814, owner = false, instance = {}, locked = true},
			{name = 'Apartment 15', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 815, owner = false, instance = {}, locked = true},
			{name = 'Apartment 16', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 816, owner = false, instance = {}, locked = true},
			{name = 'Apartment 17', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 817, owner = false, instance = {}, locked = true},
			{name = 'Apartment 18', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 818, owner = false, instance = {}, locked = true},
			{name = 'Apartment 19', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 819, owner = false, instance = {}, locked = true},
			{name = 'Apartment 20', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 820, owner = false, instance = {}, locked = true},
			{name = 'Apartment 21', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 821, owner = false, instance = {}, locked = true},
			{name = 'Apartment 22', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 822, owner = false, instance = {}, locked = true},
			{name = 'Apartment 23', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 823, owner = false, instance = {}, locked = true},
			{name = 'Apartment 24', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 824, owner = false, instance = {}, locked = true},
			{name = 'Apartment 25', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 825, owner = false, instance = {}, locked = true},
			{name = 'Apartment 26', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 826, owner = false, instance = {}, locked = true},
			{name = 'Apartment 27', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 827, owner = false, instance = {}, locked = true},
			{name = 'Apartment 28', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 828, owner = false, instance = {}, locked = true},
			{name = 'Apartment 29', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 829, owner = false, instance = {}, locked = true},
			{name = 'Apartment 30', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 830, owner = false, instance = {}, locked = true},
			{name = 'Apartment 31', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 831, owner = false, instance = {}, locked = true},
			{name = 'Apartment 32', coords = {-85.95, -281.97, 45.55}, heading = 350.0, voiceChannel = 832, owner = false, instance = {}, locked = true}
		}
	},
	['Tinsel Towers'] = {
		location = 'Boulevard Del Perro, Los Santos',
		interior = 'midapartment',
		type = 'apartment',
		payment = 3000,
		weightLimit = 500,
		cashLimit = 50000,
		office = {-621.49, 37.19, 43.58},
		rooms = {
			{name = 'Apartment 1', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 901, owner = false, instance = {}, locked = true},
			{name = 'Apartment 2', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 902, owner = false, instance = {}, locked = true},
			{name = 'Apartment 3', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 903, owner = false, instance = {}, locked = true},
			{name = 'Apartment 4', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 904, owner = false, instance = {}, locked = true},
			{name = 'Apartment 5', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 905, owner = false, instance = {}, locked = true},
			{name = 'Apartment 6', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 906, owner = false, instance = {}, locked = true},
			{name = 'Apartment 7', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 907, owner = false, instance = {}, locked = true},
			{name = 'Apartment 8', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 908, owner = false, instance = {}, locked = true},
			{name = 'Apartment 9', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 909, owner = false, instance = {}, locked = true},
			{name = 'Apartment 10', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 910, owner = false, instance = {}, locked = true},
			{name = 'Apartment 11', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 911, owner = false, instance = {}, locked = true},
			{name = 'Apartment 12', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 912, owner = false, instance = {}, locked = true},
			{name = 'Apartment 13', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 913, owner = false, instance = {}, locked = true},
			{name = 'Apartment 14', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 914, owner = false, instance = {}, locked = true},
			{name = 'Apartment 15', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 915, owner = false, instance = {}, locked = true},
			{name = 'Apartment 16', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 916, owner = false, instance = {}, locked = true},
			{name = 'Apartment 17', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 917, owner = false, instance = {}, locked = true},
			{name = 'Apartment 18', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 918, owner = false, instance = {}, locked = true},
			{name = 'Apartment 19', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 919, owner = false, instance = {}, locked = true},
			{name = 'Apartment 20', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 920, owner = false, instance = {}, locked = true},
			{name = 'Apartment 21', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 921, owner = false, instance = {}, locked = true},
			{name = 'Apartment 22', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 922, owner = false, instance = {}, locked = true},
			{name = 'Apartment 23', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 923, owner = false, instance = {}, locked = true},
			{name = 'Apartment 24', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 924, owner = false, instance = {}, locked = true},
			{name = 'Apartment 25', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 925, owner = false, instance = {}, locked = true},
			{name = 'Apartment 26', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 926, owner = false, instance = {}, locked = true},
			{name = 'Apartment 27', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 927, owner = false, instance = {}, locked = true},
			{name = 'Apartment 28', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 928, owner = false, instance = {}, locked = true},
			{name = 'Apartment 29', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 929, owner = false, instance = {}, locked = true},
			{name = 'Apartment 30', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 930, owner = false, instance = {}, locked = true},
			{name = 'Apartment 31', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 931, owner = false, instance = {}, locked = true},
			{name = 'Apartment 32', coords = {-617.00, 37.94, 43.59}, heading = 170.0, voiceChannel = 932, owner = false, instance = {}, locked = true}
		}
	},
	['Eclipse Towers'] = {
		location = 'South Mo Milton Drive, Los Santos',
		interior = 'highapartment',
		type = 'apartment',
		payment = 7500,
		weightLimit = 1000,
		cashLimit = 60000,
		office = {-778.88, 313.14, 85.69},
		rooms = {
			{name = 'Apartment 1', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1001, owner = false, instance = {}, locked = true},
			{name = 'Apartment 2', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1002, owner = false, instance = {}, locked = true},
			{name = 'Apartment 3', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1003, owner = false, instance = {}, locked = true},
			{name = 'Apartment 4', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1004, owner = false, instance = {}, locked = true},
			{name = 'Apartment 5', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1005, owner = false, instance = {}, locked = true},
			{name = 'Apartment 6', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1006, owner = false, instance = {}, locked = true},
			{name = 'Apartment 7', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1007, owner = false, instance = {}, locked = true},
			{name = 'Apartment 8', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1008, owner = false, instance = {}, locked = true},
			{name = 'Apartment 9', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1009, owner = false, instance = {}, locked = true},
			{name = 'Apartment 10', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1010, owner = false, instance = {}, locked = true},
			{name = 'Apartment 11', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1011, owner = false, instance = {}, locked = true},
			{name = 'Apartment 12', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1012, owner = false, instance = {}, locked = true},
			{name = 'Apartment 13', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1013, owner = false, instance = {}, locked = true},
			{name = 'Apartment 14', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1014, owner = false, instance = {}, locked = true},
			{name = 'Apartment 15', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1015, owner = false, instance = {}, locked = true},
			{name = 'Apartment 16', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1016, owner = false, instance = {}, locked = true},
			{name = 'Apartment 17', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1017, owner = false, instance = {}, locked = true},
			{name = 'Apartment 18', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1018, owner = false, instance = {}, locked = true},
			{name = 'Apartment 19', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1019, owner = false, instance = {}, locked = true},
			{name = 'Apartment 20', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1020, owner = false, instance = {}, locked = true},
			{name = 'Apartment 21', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1021, owner = false, instance = {}, locked = true},
			{name = 'Apartment 22', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1022, owner = false, instance = {}, locked = true},
			{name = 'Apartment 23', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1023, owner = false, instance = {}, locked = true},
			{name = 'Apartment 24', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1024, owner = false, instance = {}, locked = true},
			{name = 'Apartment 25', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1025, owner = false, instance = {}, locked = true},
			{name = 'Apartment 26', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1026, owner = false, instance = {}, locked = true},
			{name = 'Apartment 27', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1027, owner = false, instance = {}, locked = true},
			{name = 'Apartment 28', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1028, owner = false, instance = {}, locked = true},
			{name = 'Apartment 29', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1029, owner = false, instance = {}, locked = true},
			{name = 'Apartment 30', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1030, owner = false, instance = {}, locked = true},
			{name = 'Apartment 31', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1031, owner = false, instance = {}, locked = true},
			{name = 'Apartment 32', coords = {-775.05, 313.14, 85.69}, heading = 170.0, voiceChannel = 1032, owner = false, instance = {}, locked = true}
		}
	},
	['Houses'] = {
		interior = 'midapartment',
		type = 'house',
		weightLimit = 3000,
		cashLimit = 500000,
		rooms = {}
	}
}

local burglaryHouses = {
	{ x = 893.24, y = -540.58, z = 58.51, heading = 122.0 },
	{ x = 850.17, y = -532.65, z = 57.93, heading = 264.0 },
	{ x = 861.49, y = -508.91, z = 57.72, heading = 225.0 },
	{ x = 878.35, y = -497.97, z = 58.09, heading = 227.0 },
	{ x = 906.33, y = -489.34, z = 59.44, heading = 202.0 },
	{ x = 921.85, y = -477.81, z = 61.08, heading = 203.0 },
	{ x = 944.53, y = -463.15, z = 61.55, heading = 126.0 },
	{ x = 967.1, y = -451.61, z = 62.79, heading = 223.0 },
	{ x = 987.34, y = -432.98, z = 64.05, heading = 220.0 },
	{ x = 1010.39, y = -423.41, z = 65.35, heading = 307.0 },
	{ x = 1028.76, y = -408.29, z = 66.34, heading = 221.0 },
	{ x = 1060.33, y = -378.24, z = 68.23, heading = 219.0 },
	{ x = 844.12, y = -562.53, z = 57.99, heading = 189.0 },
	{ x = 861.72, y = -583.65, z = 58.16, heading = 359.0 },
	{ x = 886.87, y = -608.3, z = 58.45, heading = 313.0 },
	{ x = 902.89, y = -615.54, z = 58.45, heading = 233.0 },
	{ x = 928.84, y = -639.86, z = 58.24, heading = 315.0 },
	{ x = 943.24, y = -653.31, z = 58.63, heading = 222.0 },
	{ x = 959.9, y = -669.94, z = 58.45, heading = 301.0 },
	{ x = 970.95, y = -701.54, z = 58.48, heading = 354.0 },
	{ x = 979.03, y = -716.22, z = 58.22, heading = 311.0 },
	{ x = 996.85, y = -729.68, z = 57.82, heading = 307.0 },
	{ x = 980.24, y = -627.75, z = 59.24, heading = 35.0 },
	{ x = 964.37, y = -596.25, z = 59.9, heading = 79.0 },
	{ x = 919.76, y = -569.5, z = 58.37, heading = 196.0 },
	{ x = 965.15, y = -541.88, z = 59.73, heading = 210.0 },
	{ x = 976.77, y = -580.6, z = 59.85, heading = 29.0 },
	{ x = 987.77, y = -525.8, z = 60.69, heading = 211.0 },
	{ x = 1006.55, y = -510.89, z = 60.99, heading = 120.0 },
	{ x = 1009.57, y = -572.46, z = 60.59, heading = 261.0 },
	{ x = 999.56, y = -593.79, z = 59.64, heading = 262.0 },
	{ x = 1046.24, y = -498.14, z = 64.28, heading = 351.0 },
	{ x = 1050.98, y = -470.38, z = 64.3, heading = 249.0 },
	{ x = 1090.51, y = -484.31, z = 65.66, heading = 79.0 },
	{ x = 1098.65, y = -464.46, z = 67.32, heading = 164.0 },
	{ x = 1056.12, y = -449.0, z = 66.26, heading = 347.0 },
	{ x = 1100.04, y = -450.78, z = 67.79, heading = 81.0 },
	{ x = 1099.41, y = -438.73, z = 67.79, heading = 352.0 },
	{ x = 1101.16, y = -411.38, z = 67.56, heading = 86.0 },
	{ x = 1114.43, y = -391.3, z = 68.95, heading = 60.0 },
	{ x = 1204.89, y = -557.76, z = 69.62, heading = 88.0 },
	{ x = 1200.9, y = -575.47, z = 69.14, heading = 136.0 },
	{ x = 1203.59, y = -598.37, z = 68.06, heading = 178.0 },
	{ x = 1207.44, y = -620.18, z = 66.44, heading = 93.0 },
	{ x = 1221.46, y = -669.3, z = 63.69, heading = 10.0 },
	{ x = 1220.73, y = -689.38, z = 61.1, heading = 12.0 },
	{ x = 1229.66, y = -725.42, z = 60.96, heading = 94.0 },
	{ x = 1264.66, y = -702.78, z = 64.91, heading = 237.0 },
	{ x = 1271.0, y = -683.63, z = 66.03, heading = 10.0 },
	{ x = 1265.65, y = -648.65, z = 68.12, heading = 25.0 },
	{ x = 1250.91, y = -620.82, z = 69.57, heading = 208.0 },
	{ x = 1240.61, y = -601.64, z = 69.78, heading = 273.0 },
	{ x = 1241.45, y = -566.44, z = 69.66, heading = 317.0 },
	{ x = 1250.81, y = -515.43, z = 69.35, heading = 257.0 },
	{ x = 1251.43, y = -494.1, z = 69.91, heading = 259.0 },
	{ x = 1259.52, y = -480.25, z = 70.19, heading = 304.0 },
	{ x = 1265.65, y = -458.13, z = 70.52, heading = 273.0 },
	{ x = 1262.38, y = -429.94, z = 70.01, heading = 297.0 },
	{ x = 1303.28, y = -527.41, z = 71.46, heading = 158.0 },
	{ x = 1328.69, y = -535.93, z = 72.44, heading = 69.0 },
	{ x = 1348.37, y = -546.69, z = 73.89, heading = 160.0 },
	{ x = 1373.34, y = -555.71, z = 74.69, heading = 71.0 },
	{ x = 1389.11, y = -569.5, z = 74.5, heading = 113.0 },
	{ x = 1386.33, y = -593.44, z = 74.49, heading = 55.0 },
	{ x = 1367.26, y = -606.66, z = 74.71, heading = 3.0 },
	{ x = 1341.23, y = -597.36, z = 74.7, heading = 232.0 },
	{ x = 1323.43, y = -583.18, z = 73.25, heading = 338.0 },
	{ x = 1301.04, y = -574.34, z = 71.73, heading = 344.0 },
	{ x = 952.83, y = -252.47, z = 67.96, heading = 55.0 },
	{ x = 930.58, y = -245.15, z = 69.0, heading = 237.0 },
	{ x = 921.0, y = -238.25, z = 70.39, heading = 147.0 },
	{ x = 880.49, y = -205.13, z = 71.98, heading = 143.0 },
	{ x = 840.81, y = -182.22, z = 74.59, heading = 55.0 },
	{ x = 859.01, y = -144.5, z = 78.98, heading = 59.0 },
	{ x = 808.74, y = -163.7, z = 75.88, heading = 151.0 },
	{ x = -34.28, y = -1847.08, z = 26.19, heading = 233.0 },
	{ x = -20.4, y = -1858.96, z = 25.41, heading = 53.0 },
	{ x = -4.76, y = -1872.22, z = 24.15, heading = 53.0 },
	{ x = 5.26, y = -1884.34, z = 23.7, heading = 51.0 },
	{ x = 23.06, y = -1897.01, z = 22.97, heading = 317.0 },
	{ x = 38.95, y = -1911.5, z = 21.95, heading = 229.0 },
	{ x = 56.46, y = -1922.72, z = 21.91, heading = 324.0 },
	{ x = 72.22, y = -1939.26, z = 21.37, heading = 315.0 },
	{ x = 76.27, y = -1948.06, z = 21.17, heading = 230.0 },
	{ x = 85.94, y = -1959.78, z = 21.12, heading = 49.0 },
	{ x = 114.44, y = -1961.18, z = 21.33, heading = 25.0 },
	{ x = 126.89, y = -1930.02, z = 21.38, heading = 33.0 },
	{ x = 118.48, y = -1921.05, z = 21.32, heading = 50.0 },
	{ x = 100.57, y = -1912.03, z = 21.41, heading = 157.0 },
	{ x = 54.44, y = -1873.05, z = 22.81, heading = 135.0 },
	{ x = 46.09, y = -1864.19, z = 23.28, heading = 130.0 },
	{ x = 29.99, y = -1854.77, z = 24.07, heading = 42.0 },
	{ x = 21.45, y = -1844.63, z = 24.6, heading = 50.0 },
	{ x = -42.0, y = -1792.11, z = 27.83, heading = 136.0 },
	{ x = -50.27, y = -1783.3, z = 28.3, heading = 132.0 },
	{ x = 104.09, y = -1885.36, z = 24.32, heading = 321.0 },
	{ x = 130.12, y = -1853.01, z = 25.23, heading = 150.0 },
	{ x = 150.08, y = -1864.68, z = 24.59, heading = 155.0 },
	{ x = 128.32, y = -1896.98, z = 23.67, heading = 67.0 },
	{ x = 148.37, y = -1904.41, z = 23.53, heading = 334.0 },
	{ x = 171.55, y = -1871.49, z = 24.4, heading = 65.0 },
	{ x = 191.87, y = -1883.02, z = 25.06, heading = 150.0 },
	{ x = 208.68, y = -1895.22, z = 24.81, heading = 51.0 },
	{ x = 178.82, y = -1923.48, z = 21.37, heading = 153.0 },
	{ x = 170.6, y = -1924.01, z = 21.19, heading = 146.0 },
	{ x = 165.11, y = -1945.02, z = 20.24, heading = 234.0 },
	{ x = 148.32, y = -1961.02, z = 19.46, heading = 223.0 },
	{ x = 144.33, y = -1968.95, z = 18.86, heading = 144.0 },
	{ x = 250.87, y = -1934.96, z = 24.7, heading = 50.0 },
	{ x = 258.37, y = -1927.12, z = 25.44, heading = 147.0 },
	{ x = 270.41, y = -1916.99, z = 26.18, heading = 144.0 },
	{ x = 282.66, y = -1899.43, z = 27.27, heading = 48.0 },
	{ x = 288.61, y = -1792.44, z = 28.09, heading = 331.0 },
	{ x = 300.16, y = -1783.6, z = 28.44, heading = 139.0 },
	{ x = 304.32, y = -1775.7, z = 29.1, heading = 227.0 },
	{ x = 320.63, y = -1759.77, z = 29.64, heading = 226.0 },
	{ x = 333.07, y = -1740.87, z = 29.73, heading = 146.0 },
	{ x = 348.64, y = -1820.95, z = 28.89, heading = 319.0 },
	{ x = 338.67, y = -1829.66, z = 28.34, heading = 315.0 },
	{ x = 329.47, y = -1845.89, z = 27.75, heading = 47.0 },
	{ x = 320.33, y = -1853.99, z = 27.51, heading = 47.0 },
	{ x = 443.48, y = -1707.33, z = 29.71, heading = 46.0 },
	{ x = 431.14, y = -1725.35, z = 29.6, heading = 140.0 },
	{ x = 419.28, y = -1735.54, z = 29.61, heading = 140.0 },
	{ x = 405.91, y = -1751.16, z = 29.71, heading = 139.0 },
	{ x = 500.77, y = -1697.2, z = 29.79, heading = 141.0 },
	{ x = 489.49, y = -1714.18, z = 29.71, heading = 244.0 },
	{ x = 479.63, y = -1735.64, z = 29.15, heading = 163.0 },
	{ x = 474.46, y = -1757.68, z = 29.09, heading = 251.0 },
	{ x = 472.06, y = -1775.18, z = 29.07, heading = 267.0 },
	{ x = 440.45, y = -1829.56, z = 28.36, heading = 136.0 },
	{ x = 427.12, y = -1842.08, z = 28.46, heading = 320.0 },
	{ x = 412.28, y = -1856.32, z = 27.32, heading = 318.0 },
	{ x = 399.22, y = -1864.99, z = 26.72, heading = 314.0 },
	{ x = 384.91, y = -1881.62, z = 26.03, heading = 215.0 },
	{ x = 368.78, y = -1895.72, z = 25.18, heading = 134.0 },
	{ x = 324.39, y = -1937.3, z = 25.02, heading = 138.0 },
	{ x = 311.99, y = -1956.08, z = 24.62, heading = 229.0 },
	{ x = 295.54, y = -1971.99, z = 22.9, heading = 226.0 },
	{ x = 291.58, y = -1980.11, z = 21.6, heading = 142.0 },
	{ x = 279.54, y = -1993.9, z = 20.8, heading = 323.0 },
	{ x = 256.44, y = -2023.39, z = 19.27, heading = 232.0 },
	{ x = 251.12, y = -2030.33, z = 18.71, heading = 335.0 },
	{ x = 495.43, y = -1823.51, z = 28.87, heading = 321.0 },
	{ x = 500.41, y = -1813.27, z = 28.89, heading = 319.0 },
	{ x = 512.61, y = -1790.61, z = 28.92, heading = 92.0 },
	{ x = 514.14, y = -1781.14, z = 28.91, heading = 92.0 },
	{ x = 250.04, y = -1730.86, z = 29.67, heading = 54.0 },
	{ x = 257.55, y = -1722.82, z = 29.65, heading = 140.0 },
	{ x = 269.7, y = -1712.77, z = 29.67, heading = 142.0 },
	{ x = 281.9, y = -1695.08, z = 29.65, heading = 49.0 },
	{ x = 252.98, y = -1670.77, z = 29.66, heading = 140.0 },
	{ x = 240.76, y = -1687.72, z = 29.7, heading = 229.0 },
	{ x = 222.63, y = -1702.52, z = 29.7, heading = 215.0 },
	{ x = 216.56, y = -1717.44, z = 29.68, heading = 311.0 },
	{ x = 197.57, y = -1725.67, z = 29.66, heading = 300.0 },
	{ x = 16.79, y = -1443.82, z = 30.95, heading = 152.0 },
	{ x = -2.06, y = -1442.06, z = 30.96, heading = 182.0 },
	{ x = -32.29, y = -1446.48, z = 31.89, heading = 88.0 },
	{ x = -45.5, y = -1445.55, z = 32.43, heading = 103.0 },
	{ x = -64.61, y = -1449.44, z = 32.52, heading = 276.0 },
	{ x = -884.24, y = -1072.57, z = 2.53, heading = 32.0 },
	{ x = -903.24, y = -1005.95, z = 2.15, heading = 31.0 },
	{ x = -948.13, y = -910.62, z = 2.75, heading = 300.0 },
	{ x = -951.47, y = -906.01, z = 2.75, heading = 297.0 },
	{ x = -1022.48, y = -896.9, z = 5.41, heading = 30.0 },
	{ x = -1031.22, y = -903.05, z = 3.69, heading = 23.0 },
	{ x = -1043.65, y = -923.77, z = 3.15, heading = 211.0 },
	{ x = -1053.96, y = -932.43, z = 3.36, heading = 209.0 },
	{ x = -1061.87, y = -942.73, z = 2.22, heading = 212.0 },
	{ x = -1084.34, y = -951.82, z = 2.36, heading = 123.0 },
	{ x = -1151.51, y = -990.43, z = 2.15, heading = 213.0 },
	{ x = -1750.57, y = -697.53, z = 10.18, heading = 319.0 },
	{ x = -1771.17, y = -677.47, z = 10.39, heading = 306.0 },
	{ x = -1787.87, y = -671.87, z = 10.65, heading = 52.0 },
	{ x = -1793.44, y = -663.82, z = 10.6, heading = 143.0 },
	{ x = -1803.72, y = -662.07, z = 10.73, heading = 227.0 },
	{ x = -1820.05, y = -649.8, z = 10.97, heading = 237.0 },
	{ x = -1836.48, y = -631.91, z = 10.75, heading = 52.0 },
	{ x = -1838.95, y = -629.5, z = 11.25, heading = 232.0 },
	{ x = -1874.58, y = -592.99, z = 11.89, heading = 224.0 },
	{ x = -1883.41, y = -578.94, z = 11.83, heading = 322.0 },
	{ x = -1898.51, y = -572.42, z = 11.85, heading = 232.0 },
	{ x = -1917.79, y = -558.93, z = 11.85, heading = 48.0 },
	{ x = -1919.07, y = -555.49, z = 11.76, heading = 136.0 },
	{ x = -1918.76, y = -542.58, z = 11.83, heading = 313.0 },
	{ x = -1947.05, y = -544.07, z = 11.86, heading = 235.0 },
	{ x = -1948.1, y = -531.66, z = 11.83, heading = 228.0 },
	{ x = -1964.3, y = -520.82, z = 12.18, heading = 56.0 },
}

Citizen.CreateThread(function()
	for i = 1, #burglaryHouses do
		local house = burglaryHouses[i]
		house.voiceChannel = math.random(1000000, 9999999)
		house.instance = {}
		house.cooldown = {}
	end
end)

local burglarySearchItems = {
	{name = 'Hotwiring Kit', type = 'misc', price = 250, legality = 'illegal', quantity = 1, weight = 10},
	{name = "LSD Vial", price = 6, type = "drug", quantity = 1, legality = "illegal", weight = 5.0, objectModel = "prop_cs_pour_tube"},
	{name = "Cheeseburger", price = 6, type = "food", substance = 30.0, quantity = 1, legality = "legal", weight = 10.0, objectModel = "prop_cs_burger_01"},
	{name = "Flaming Hot Cheetos", price = 2, type = "food", substance = 6.0, quantity = 1, legality = "legal", weight = 9.0, objectModel = "ng_proc_food_chips01c"},
	{name = "Water", price = 3, type = "drink", substance = 60.0, quantity = 1, legality = "legal", weight = 9.0, objectModel = "ba_prop_club_water_bottle"},
	{name = "Arizona Iced Tea", price = 1, type = "drink", substance = 60.0, quantity = 1, legality = "legal", weight = 9.0, objectModel = "ba_prop_club_water_bottle"},
	{name = "Pepsi", price = 4, type = "drink", substance = 9.0, quantity = 1, legality = "legal", weight = 9.0, objectModel = "ng_proc_sodacan_01b"},
	{name = "Everclear Vodka (90%)", price = 35, type = "alcohol", substance = 5.0, quantity = 1, legality = "legal", weight = 10.0, strength = 0.10, objectModel = "prop_vodka_bottle"},
	{name = 'Lockpick', type = 'misc', price = 400, legality = 'illegal', quantity = 1, weight = 5.0},
	{name = "First Aid Kit", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 5.0, objectModel = "v_ret_ta_firstaid"},
	{name = "Packaged Weed", quantity = 1, weight = 5.0, type = "drug", legality = "illegal", objectModel = "bkr_prop_weed_bag_01a"},
	{name = 'Packaged Meth', type = 'drug', legality = 'illegal', quantity = 1, weight = 7.0, objectModel = 'bkr_prop_meth_smallbag_01a'},
	{name = 'Pistol', type = 'weapon', hash = 453432689, price = 1000, legality = 'illegal', quantity = 1, weight = 15, objectModel = "w_pi_pistol", notStackable = true},
	{name = 'Razor Blade', type = 'misc', price = 500, legality = 'legal', quantity = 1, residue = false, weight = 3},
	{name = 'Switchblade', type = 'weapon', hash = -538741184, price = 1500, legality = 'illegal', quantity = 1, weight = 5, notStackable = true},
	{name = "Condoms", price = 5, type = "misc", quantity = 1, legality = "legal", weight = 1, objectModel = "ng_proc_candy01a"},
	{name = "KY Intense Gel", price = 10, type = "misc", quantity = 1, legality = "legal", weight = 1, objectModel = "v_res_d_lube"},
	{name = "Sturdy Rope", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 4, objectModel = "prop_devin_rope_01"},
	{name = "Bag", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 3, objectModel = "prop_paper_bag_01"},
	{name = "Fluffy Handcuffs", type = "misc", quantity = 1, legality = "legal", weight = 1, objectModel = "p_cs_cuffs_02_s"},
	{name = "Vibrator", type = "misc", quantity = 1, legality = "legal", weight = 1, objectModel = "prop_cs_marker_01"},
	{name = "French Dip Au Jus", price = 55, type = "food", substance = 60.0, quantity = 1, legality = "legal", weight = 10},
	{name = "Back Porch Strawberry Lemonade", price = 60, type = "alcohol", substance = 15.0, quantity = 4, legality = "legal", weight = 1, strength = 0.28},
	{name = 'Advanced Pick', type = 'illegal', price = 800, legality = 'illegal', quantity = 1, weight = 7.0},
	{ name = "5.56mm Bullets", type = "ammo", price = 600, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_03"  },
	{ name = "7.62mm Bullets", type = "ammo", price = 600, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_03" },
	{ name = "9mm Bullets", type = "ammo", price = 300, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_01" },
	{ name = ".45 Bullets", type = "ammo", price = 375, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_01" },
	{ name = "12 Gauge Shells", type = "ammo", price = 300, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_02" },
	{ name = "Pump Shotgun", legality = "illegal", type = "weapon", hash = 487013001, price = 4000, quantity = 1, weight = 25, objectModel = "w_sg_pumpshotgun", notStackable = true },
	{ name = "Heavy Pistol Parts", price = 5500, type = "weaponParts", weight = 15.0, quantity = 1 },
	{ name = "Pistol Parts", price = 3000, type = "weaponParts", weight = 10.0, quantity = 1 },
	{ name = "Brick", type = "weapon", hash = GetHashKey("WEAPON_BRICK"), weight = 15.0, quantity = 1 },
	{ name = "Ninja Star", type = "weapon", hash = GetHashKey("WEAPON_NINJASTAR"), weight = 5.0, quantity = 1 },
	{ name = "Ninja Star 2", type = "weapon", hash = GetHashKey("WEAPON_NINJASTAR2"), weight = 5.0, quantity = 1 },
	{ name = "Rock", type = "weapon", hash = GetHashKey("WEAPON_ROCK"), weight = 5.0, quantity = 1 },
	{ name = "Throwing Knife", type = "weapon", hash = GetHashKey("WEAPON_THROWINGKNIFE"), weight = 8.0, quantity = 1 },
	{ name = "Black Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOEBLACK"), weight = 8.0, quantity = 1 },
	{ name = "Red Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOERED"), weight = 8.0, quantity = 1 },
	{ name = "Blue Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOEBLUE"), weight = 8.0, quantity = 1 },
	{ name = "Crumpled Paper", type = "misc", quantity = 1, legality = "legal", notStackable = true, weight = 1, objectModel = "prop_paper_ball" },
}

local tradingCards = {
	{ name = "Filet", type = "tradingCard", src = { front = 'usarrp-filet.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Queen", type = "tradingCard", src = { front = 'usarrp-queen.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Emma", type = "tradingCard", src = { front = 'usarrp-emma.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
	{ name = "357", type = "tradingCard", src = { front = '357.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "AE", type = "tradingCard", src = { front = 'AE.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Amelia", type = "tradingCard", src = { front = 'Amelia.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Arthur", type = "tradingCard", src = { front = 'Arthur.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Baldy", type = "tradingCard", src = { front = 'Baldy.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Beebo", type = "tradingCard", src = { front = 'Beebo.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Bella", type = "tradingCard", src = { front = 'Bella1.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Calvin", type = "tradingCard", src = { front = 'Calvin.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Camila", type = "tradingCard", src = { front = 'Camila.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Chang", type = "tradingCard", src = { front = 'Chang2.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Chris", type = "tradingCard", src = { front = 'Chris2.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Chris Cortega", type = "tradingCard", src = { front = 'ChrisCortega.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Chris Mc", type = "tradingCard", src = { front = 'ChrisMC.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Clyde", type = "tradingCard", src = { front = 'Clyde.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Coastal", type = "tradingCard", src = { front = 'Coastal.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Colt", type = "tradingCard", src = { front = 'Colt.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Cyanide", type = "tradingCard", src = { front = 'Cyanide.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Daddy Rick", type = "tradingCard", src = { front = 'DaddyRick.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Damon", type = "tradingCard", src = { front = 'Damon.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Dave", type = "tradingCard", src = { front = 'Dave.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Davies", type = "tradingCard", src = { front = 'Davies.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Denis", type = "tradingCard", src = { front = 'Denis.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Easton", type = "tradingCard", src = { front = 'Easton.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Elliott", type = "tradingCard", src = { front = 'Elliott.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "EMS", type = "tradingCard", src = { front = 'EMS.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Faye n Flint", type = "tradingCard", src = { front = 'Faye_N_Flint.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Forum", type = "tradingCard", src = { front = 'Forum.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Frankies", type = "tradingCard", src = { front = 'Frankies.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Gary", type = "tradingCard", src = { front = 'Gary.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "HH", type = "tradingCard", src = { front = 'HH.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "The Joker", type = "tradingCard", src = { front = 'joker.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Narlee", type = "tradingCard", src = { front = 'narlee.png', back = 'backcard.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Red Eyes B. Dragon", type = "tradingCard", src = { front = 'red-eyes-black-dragon.jpg', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Dark Magician", type = "tradingCard", src = { front = 'dark-magician.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Blue Eyes White Dragon", type = "tradingCard", src = { front = 'blue-eyes-white-dragon.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Dark Magician Girl", type = "tradingCard", src = { front = 'dark-magician-girl.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Exodia Head", type = "tradingCard", src = { front = 'exodia.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Shooting Magestic Star Dragon", type = "tradingCard", src = { front = 'shooting-magestic-star-dragon.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Toon Blue Eyes Dragon", type = "tradingCard", src = { front = 'toon-blue-eye-dragon.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "SASP", type = "tradingCard", src = { front = 'sasp3.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Alex & Nessa", type = "tradingCard", src = { front = 'AlexNessa.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Phil 160p", type = "tradingCard", src = { front = 'Phil.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Snake", type = "tradingCard", src = { front = 'Snake.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Sykkuno", type = "tradingCard", src = { front = 'Sy.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Wong", type = "tradingCard", src = { front = 'Wong.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Alex", type = "tradingCard", src = { front = 'Alex.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Amaree", type = "tradingCard", src = { front = 'Amaree.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Carlos", type = "tradingCard", src = { front = 'Carlos.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Chandler", type = "tradingCard", src = { front = 'Chandler.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Cinco", type = "tradingCard", src = { front = 'Cicno.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Edna", type = "tradingCard", src = { front = 'Edna.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Edna & Chang", type = "tradingCard", src = { front = 'EdnaChang.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Gunz", type = "tradingCard", src = { front = 'Gunz.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Hunter", type = "tradingCard", src = { front = 'Hunter.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Jethro", type = "tradingCard", src = { front = 'jethro.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Justin", type = "tradingCard", src = { front = 'Justin.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Larako", type = "tradingCard", src = { front = 'Larako.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Lyssa", type = "tradingCard", src = { front = 'Lyssa.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Maxwell", type = "tradingCard", src = { front = 'Maxwell.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "N8", type = "tradingCard", src = { front = 'N8.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Olivia", type = "tradingCard", src = { front = 'Olivia.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Oscar", type = "tradingCard", src = { front = 'Oscar.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Outlaws", type = "tradingCard", src = { front = 'outlaws.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Pablo", type = "tradingCard", src = { front = 'pablo.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "PB", type = "tradingCard", src = { front = 'PB.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "The Projects", type = "tradingCard", src = { front = 'Projects.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Pusc", type = "tradingCard", src = { front = 'pusc.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Riley", type = "tradingCard", src = { front = 'Riley.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Ryder", type = "tradingCard", src = { front = 'Ryder.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Sam & Lucy", type = "tradingCard", src = { front = 'SamLucy.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Spider", type = "tradingCard", src = { front = 'Spider.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "SWAT", type = "tradingCard", src = { front = 'swat.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Tony", type = "tradingCard", src = { front = 'Tony.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Tyler", type = "tradingCard", src = { front = 'Tyler.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "William", type = "tradingCard", src = { front = 'William.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "James", type = "tradingCard", src = { front = 'James.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Tony 357", type = "tradingCard", src = { front = 'Tony357.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Alexander", type = "tradingCard", src = { front = 'Alexander.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Bobby", type = "tradingCard", src = { front = 'Bobby.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Danny", type = "tradingCard", src = { front = 'Danny.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "JHunter", type = "tradingCard", src = { front = 'JHunter.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Lenny", type = "tradingCard", src = { front = 'Lenny.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Lichtenberg", type = "tradingCard", src = { front = 'Lichtenberg.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Luci", type = "tradingCard", src = { front = 'Luci.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Mini", type = "tradingCard", src = { front = 'Mini.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Nancy", type = "tradingCard", src = { front = 'Nancy.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Richard_2", type = "tradingCard", src = { front = 'Richard_2.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "TJ", type = "tradingCard", src = { front = 'TJ.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Tony_2", type = "tradingCard", src = { front = 'Tony_2.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
}

local interiors = {
	['motel'] = {
		coords = {151.39, -1007.74, -99.0},
		heading = 359.0,
		storage = {151.24, -1003.05, -99.0},
		wardrobe = {151.70, -1001.40, -99.0},
		bathroom = {154.18, -1000.57, -99.0}
	},
	['lowapartment'] = {
		coords = {266.14, -1007.61, -101.00},
		heading = 0.0,
		storage = {265.95, -999.49, -99.0},
		wardrobe = {259.95, -1004.11, -99.0},
		bathroom = {255.60, -1000.47, -99.0}
	},
	['midapartment'] = {
		coords = {346.47, -1013.05, -99.19},
		heading = 356.0,
		storage = {351.19, -999.16, -99.19},
		wardrobe = {350.67, -993.60, -99.19},
		bathroom = {347.23, -994.11, -99.19},
		burglaryCabinets = {
			vector3(351.29, -999.80, -99.19),
			vector3(350.01, -993.19, -99.19),
			vector3(342.02, -1003.50, -99.35),
			vector3(339.21, -1003.63, -99.49),
			vector3(341.70, -996.18, -99.59),
			vector3(347.08, -994.14, -99.39),
			vector3(345.82, -1001.38, -99.19)
		}
	},
	['highapartment'] = {
		coords = {-781.77, 322.00, 211.99},
		heading = 355.0,
		storage = {-790.74, 330.53, 210.79},
		wardrobe = {-793.43, 326.53, 210.79},
		bathroom = {-798.81, 330.15, 210.79}
	}
}

local buzzedApartments = {}

local setHousePrices = {
	--["123"] = 60000
}

RegisterServerEvent('properties:saveOutfit')
AddEventHandler('properties:saveOutfit', function(outfit, slot)
	local char = exports["usa-characters"]:GetCharacter(source)
	local outfits = char.get('outfits')
	if not outfits then
		outfits = {}
	end
	outfits[tostring(slot)] = outfit
	char.set('outfits', outfits)
	TriggerClientEvent('usa:notify', source, 'Outfit has been saved!')
end)

RegisterServerEvent('properties:loadOutfit')
AddEventHandler('properties:loadOutfit', function(slot)
	local char = exports["usa-characters"]:GetCharacter(source)
	local outfits = char.get('outfits')
	if outfits then
		if outfits[tostring(slot)] then
			TriggerClientEvent('properties:loadOutfit', source, outfits[tostring(slot)])
		else
			TriggerClientEvent('usa:notify', source, 'Outfit not found!')
		end
	end
end)

TriggerEvent('es:addJobCommand', 'bbreach', {'sheriff', 'ems', "corrections"}, function(source, args, char, location)
	location = vector3(table.unpack(location))
	for i = 1, #burglaryHouses do
		if find_distance(location, burglaryHouses[i]) < 2.0 then
			table.insert(burglaryHouses[i].instance, source)
			local currentProperty = {
				owner = -1,
				index = i,
				entryHeading = interiors['midapartment'].heading,
				entryCoords = interiors['midapartment'].coords,
				instance = burglaryHouses[i].instance,
				exitCoords = {burglaryHouses[i].x, burglaryHouses[i].y, burglaryHouses[i].z},
				exitHeading = burglaryHouses[i].heading,
				voiceChannel = burglaryHouses[i].voiceChannel
			}
			TriggerClientEvent('properties:breachHouseBurglary', source, currentProperty)
			Citizen.Wait(2000)
			for k = 1, #burglaryHouses[i].instance do
				local sourceInside = burglaryHouses[i].instance[k]
				if sourceInside ~= source then
					TriggerClientEvent('InteractSound_CL:PlayOnOne', sourceInside, 'door-kick', 0.1)
					TriggerClientEvent('properties:updateInstance', sourceInside, burglaryHouses[i].instance)
				end
			end
			return
		end
	end
end, {
	help = "Breach into the nearest burglary property"
})

TriggerEvent('es:addCommand', 'bknock', function(source, args, char, location)
	location = vector3(table.unpack(location))
	for i = 1, #burglaryHouses do
		if find_distance(location, burglaryHouses[i]) < 2.0 then
			local file = 'knock1'
			if math.random() > 0.5 then file = 'knock2' end
			TriggerClientEvent('properties:playKnockAnim', source)
			Citizen.Wait(300)
			TriggerClientEvent('InteractSound_CL:PlayOnOne', source, file, 1.0)
			for k = 1, #burglaryHouses[i].instance do
				local target = burglaryHouses[i].instance[k]
				TriggerClientEvent('InteractSound_CL:PlayOnOne', target, file, 1.0)
			end
			return
		end
	end
end, {
	help = "Knock on the door of the nearest burglary property"
})

RegisterServerEvent('properties:continueHousePurchase')
AddEventHandler('properties:continueHousePurchase', function(targetSource, location, heading, street, zone)
	local char = exports["usa-characters"]:GetCharacter(source)
	if char.get('job') == 'realtor' then
		local money = char.get('money')
		local cost = setHousePrices[tostring(source)]
		if money >= cost then
			char.removeMoney(cost)
		else
			TriggerClientEvent('usa:notify', source, 'You cannot afford this, you need $' .. exports["globals"]:comma_value(cost) .. '!')
			return
		end
		local target_char = exports["usa-characters"]:GetCharacter(targetSource)
		local property = target_char.get('property')
		property['location'] = 'Houses'
		property['house'] = math.random(1000000, 9999999)
		property['houseCoords'] = location
		property['houseHeading'] = heading
		property['houseStreet'] = street..', '..zones[zone]
		_data = {
			name = 'House',
			coords = property['houseCoords'],
			garage = property['garageCoords'],
			heading = property['houseHeading'],
			owner = targetSource,
			voiceChannel = property['house'],
			instance = {},
			locked = true
		}
		table.insert(properties['Houses'].rooms, _data)
		target_char.set('property', property)
		TriggerClientEvent('usa:notify', source, 'House has been created. ~y~(~s~'..property['house']..'~y~)~s~')
		TriggerClientEvent('usa:notify', targetSource, 'You now have ownership over a house, ordered by ~y~'..char.getFullName()..'~s~. ~y~(~s~'..property['house']..'~y~)~s~')
		RefreshProperties(targetSource, false)
	end
end)

function canPropertyHoldItem(owner, location, itemToCheck)
	local maxWeight = properties[location].weightLimit
	local totalWeight = 0.0
	local char = exports["usa-characters"]:GetCharacter(owner)
	local property = char.get('property')
	for i = 1, #property['storage'] do
		local item = property['storage'][i]
		if item then
			if not item.weight and item.type == 'weapon' then item.weight = 5 else item.weight = 1 end
			totalWeight = totalWeight + (item.weight * item.quantity)
		end
	end
	if not itemToCheck.quantity then itemToCheck.quantity = 1 end
	if not itemToCheck.weight then itemToCheck.weight = 1.0 end
	if totalWeight + (itemToCheck.weight * itemToCheck.quantity) <= maxWeight then
		return true
	else
		return false
	end
end

function RefreshProperties(source, spawnAtProperty)
	-- reset owner if player owns any properties --
	for property, data in pairs(properties) do
		if data.type == 'house' then
			for i = #data.rooms, 1, -1 do
				local room = properties[property].rooms[i]
				if room.owner == source then
					table.remove(properties[property].rooms, i)
					TriggerClientEvent('properties:removeData', -1, property, i)
				end
			end
		end
		for i = 1, #data.rooms do
			local room = properties[property].rooms[i]
			if room.owner == source then
				properties[property].rooms[i].owner = false
				TriggerClientEvent('properties:updateData', -1, property, i, properties[property].rooms[i])
			end
		end
	end

	-- create property for character --
	local char = exports["usa-characters"]:GetCharacter(source)
	if not char then return end
	local property = char.get('property')
	if not property then
		property = {
			['location'] = 'Perrera Beach Motel',
			['storage'] = {},
			['money'] = 0,
			['house'] = false,
			['type'] = "motel"
		}
		char.set('property', property)
	end

	-- check fees / find open room or applicable house to spawn at --
	if not property['house'] then
		-- evict owner if time has exceeded
		if properties[property['location']].type == 'apartment' then
			local paid_time = property['paid_time']
			if paid_time == nil then
				paid_time = os.time()
				property['paid_time'] = os.time()
				char.set('property', property)
				print('PROPERTIES: Property has no paid_time, setting now!')
			end
			if GetWholeDaysFromTime(paid_time) >= 7 then
				local bank = char.get('bank')
				if bank - properties[property['location']].payment >= 0 then
					char.removeBank(properties[property['location']].payment, "Rent ("..property['location']..")")
					property['paid_time'] = os.time()
					TriggerClientEvent('usa:notify', source, 'You have paid ~y~$'..properties[property['location']].payment..'~s~ for your apartment!')
					char.set('property', property)
				else
					property['location'] = 'Perrera Beach Motel'
					property['paid_time'] = os.time
					TriggerClientEvent('usa:notify', source, 'You have been evicted from your apartment, find your room at ~y~Perrera Beach Motel~s~!')
					TriggerClientEvent("chatMessage", source, "", {}, "^3SA Real Estate:^0 You have been evicted from your apartment, find your room at ^3Perrera Beach Motel^0!")
					char.set('property', property)
				end
			end
		end

		local currentPropertyType = properties[property['location']].type
		local currentPropertyName = property['location']

		--[[ set an empty room
		for name, info in pairs(properties) do -- test
			for i = 1, #info.rooms do
				if info.type == "motel" and name == "The Motor Hotel" and i == #info.rooms then
					break
				else
					info.rooms[i].owner = true
				end
			end
		end
		--]]

		-- look for an empty room at a property with type == property['type'] and place them there
		if currentPropertyType == "motel" then
			-- first look for motel player chose to live at
			local prop = properties[currentPropertyName]
			for i = 1, #prop.rooms do
				if not prop.rooms[i].owner then
					properties[currentPropertyName].rooms[i].owner = source
					TriggerClientEvent('properties:updateData', -1, currentPropertyName, i, properties[currentPropertyName].rooms[i])
					TriggerClientEvent('properties:updateBlip', source, currentPropertyName, i)
					TriggerClientEvent('usa:notify', source, 'Your property is at ~y~'..currentPropertyName..'~s~, room '..i..'.')
					TriggerClientEvent("chatMessage", source, "", {}, "^3SA Real Estate:^0 Your property is at ^3"..currentPropertyName.."^0, room "..i..".")
					if spawnAtProperty then
						TriggerClientEvent('properties:setPosition', source, properties[currentPropertyName].rooms[i].coords, properties[currentPropertyName].rooms[i].heading)
					end
					return
				end
			end
			-- look for any open motel property
			for name, info in pairs(properties) do
				if name ~= currentPropertyName and info.type == currentPropertyType then
					for i = 1, #info.rooms do
						if not info.rooms[i].owner then
							properties[name].rooms[i].owner = source
							TriggerClientEvent('properties:updateData', -1, name, i, properties[name].rooms[i])
							TriggerClientEvent('properties:updateBlip', source, name, i)
							TriggerClientEvent('usa:notify', source, 'Your property is at ~y~'..name..'~s~, room '..i..'.')
							TriggerClientEvent("chatMessage", source, "", {}, "^3SA Real Estate:^0 Your property is at ^3"..name.."^0, room "..i..".")
							if spawnAtProperty then
								TriggerClientEvent('properties:setPosition', source, properties[name].rooms[i].coords, properties[name].rooms[i].heading)
							end
							return
						end
					end
				end
			end
			-- todo: add a fall back property here if all motels are full
		else
			-- look for empty room at player's chosen apartment
			for name, info in pairs(properties) do
				if name == currentPropertyName then
					for i = 1, #info.rooms do
						if not info.rooms[i].owner then
							properties[name].rooms[i].owner = source
							TriggerClientEvent('properties:updateData', -1, name, i, properties[name].rooms[i])
							TriggerClientEvent('properties:updateBlip', source, name, i)
							TriggerClientEvent('usa:notify', source, 'Your property is at ~y~'..name..'~s~, room '..i..'.')
							TriggerClientEvent("chatMessage", source, "", {}, "^3SA Real Estate:^0 Your property is at ^3"..name.."^0, room "..i..".")
							if spawnAtProperty then
								TriggerClientEvent('properties:setPosition', source, properties[name].rooms[i].coords, properties[name].rooms[i].heading)
							end
							return
						end
					end
				end
			end
			-- todo: add a fall back property here if no available apartment room is found
		end
	else
		_data = {
			name = 'House',
			coords = property['houseCoords'],
			garage = property['garageCoords'],
			heading = property['houseHeading'],
			owner = source,
			voiceChannel = property['house'],
			instance = {},
			locked = true
		}
		table.insert(properties['Houses'].rooms, _data)
		for i = 1, #properties['Houses'].rooms do
			local room = properties['Houses'].rooms[i]
			if room.owner == source then
				TriggerClientEvent('properties:updateData', -1, 'Houses', i, properties['Houses'].rooms[i])
				TriggerClientEvent('properties:updateBlip', source, 'Houses', i)
				if spawnAtProperty then
					TriggerClientEvent('properties:setPosition', source, room.coords, room.heading)
				end
				return
			end
		end
	end
end

function GetWholeDaysFromTime(reference_time)
	local timestamp = os.date("*t", os.time())
	local daysfrom = os.difftime(os.time(), reference_time) / (24 * 60 * 60) -- seconds in a day
	local wholedays = math.floor(daysfrom)
	print("PROPERTIES: Player has owned this property whole days: " .. wholedays) -- today it prints "1"
	return wholedays
end

AddEventHandler('playerDropped', function()
	-- remove a character's room if they already had one --
	for property, data in pairs(properties) do
		if property.type ~= 'house' then
			for i = 1, #data.rooms do
				local room = properties[property].rooms[i]
				for j = 1, #room.instance do
					if source == room.instance[j] then
						table.remove(properties[property].rooms[i].instance, j)
						print('PROPERTIES: Removing source '.. j .. ' from room '..i..' instance in '..property)
					end
				end
				if room.owner == source then
					print('PROPERTIES: Removing room '.. i .. ' from '..source .. ' at '..property..', player has left the server!')
					properties[property].rooms[i].owner = false
					TriggerClientEvent('properties:updateData', -1, property, i, properties[property].rooms[i])
				end
			end
		end
	end

	for i = 1, #properties['Houses'].rooms do
		local room = properties['Houses'].rooms[i]
		for j = 1, #room.instance do
			if source == room.instance[j] then
				table.remove(properties['Houses'].rooms[i].instance, j)
				print('PROPERTIES: Removing source '.. j .. ' from room '..i..' instance in Houses')
			end
		end
		if room.owner == source then
			print('PROPERTIES: Removing house '.. i .. ' from '..source .. ' at Houses, player has left the server!')
			table.remove(properties['Houses'].rooms, i)
			TriggerClientEvent('properties:removeData', -1, 'Houses', i)
		end
	end

	for i = #burglaryHouses, 1, -1 do
		local house = burglaryHouses[i]
		for j = #house.instance, 1, -1 do
			if source == house.instance[j] then
				--table.remove(properties['Houses'].rooms[i].instance, j)
				table.remove(burglaryHouses[i].instance, j) -- to test
				print('PROPERTIES: Removing source '.. j .. ' from room '..i..' instance in Burglaries')
			end
		end
	end

end)

RegisterServerEvent('properties:getAddress')
AddEventHandler('properties:getAddress', function(ssn, callback)
	for property, data in pairs(properties) do
		for i = 1, #data.rooms do
			local room = properties[property].rooms[i]
			if room.owner == ssn and data.type ~= 'house' then
				callback(room.name .. ', '..property..' ('..data.location..')')
				return
			end
		end
	end
	local char = exports["usa-characters"]:GetCharacter(ssn)
	if char then
		local property = char.get('property')
		if property['house'] then
			callback('House '..property['house']..', '..property['houseStreet'])
			return
		end
	end
	callback('Address not found!')
end)

RegisterServerEvent('properties:getAddressByName')
AddEventHandler('properties:getAddressByName', function(fullName, callback)
	for property, data in pairs(properties) do
		for i = 1, #data.rooms do
			local room = properties[property].rooms[i]
			local char = exports["usa-characters"]:GetCharacter(room.owner)
			if char and char.getFullName() == fullName then
				if data.type ~= 'house' then
					callback(room.name .. ', '..property..' ('..data.location..')')
					return
				else
					local property = char.get('property')
					if property['house'] then
						callback('House '..property['house']..', '..property['houseStreet'])
					end
				end
			end
		end
	end
	callback(false)
end)

RegisterServerEvent('properties:markAddress')
AddEventHandler('properties:markAddress', function(ssn, fname, lname)
	if snn then
		for property, data in pairs(properties) do
			for i = 1, #data.rooms do
				local room = properties[property].rooms[i]
				if room.owner == ssn then
					TriggerClientEvent('properties:setWaypoint', source, room.coords)
					TriggerClientEvent('usa:notify', source, 'Address set as waypoint!')
					return
				end
			end
		end
		TriggerClientEvent('usa:notify', source, 'Address not found!')
	else
		if fname and lname then
			local fullName = fname .. ' ' .. lname
			for property, data in pairs(properties) do
				for i = 1, #data.rooms do
					local room = properties[property].rooms[i]
					local char = exports["usa-characters"]:GetCharacter(room.owner)
					if char and char.getName() == fullName then
						if data.type ~= 'house' then
							TriggerClientEvent('properties:setWaypoint', source, room.coords)
							TriggerClientEvent('usa:notify', source, 'Address set as waypoint!')
							return
						else
							local property = char.get('property')
							if property['house'] then
								TriggerClientEvent('properties:setWaypoint', source, property['houseCoords'])
								TriggerClientEvent('usa:notify', source, 'Address set as waypoint!')
								return
							end
						end
					end
				end
			end
		end
	end
	TriggerClientEvent('usa:notify', source, 'Error while finding address!')
end)

RegisterServerEvent('properties:loadCharacter')
AddEventHandler('properties:loadCharacter', function(source, spawnAtProperty)
	RefreshProperties(source, spawnAtProperty)
end)

RegisterServerEvent('properties:knockOnDoor')
AddEventHandler('properties:knockOnDoor', function(location, index)
	local file = 'knock1'
	if math.random() > 0.5 then file = 'knock2' end
	TriggerClientEvent('InteractSound_CL:PlayOnOne', source, file, 1.0)
	for i = 1, #properties[location].rooms[index].instance do
		local target = properties[location].rooms[index].instance[i]
		TriggerClientEvent('InteractSound_CL:PlayOnOne', target, file, 1.0)
	end
end)

RegisterServerEvent('properties:requestEntry')
AddEventHandler('properties:requestEntry', function(location, index, _source)
	if _source then
		source = tonumber(_source)
	end
	print('PROPERTIES: '..source.. ' has requested to enter room '..index.. ' at location '..location)
	local room = properties[location].rooms[index]
	if not room.locked or room.owner == source then
		print('PROPERTIES: Entering room!')
		table.insert(properties[location].rooms[index].instance, source)
		TriggerClientEvent('properties:updateData', -1, location, index, properties[location].rooms[index])
		local currentProperty = {
			location = location,
			index = index,
			owner = room.owner,
			name = room.name,
			entryHeading = interiors[properties[location].interior].heading,
			entryCoords = interiors[properties[location].interior].coords,
			instance = room.instance,
			exitCoords = room.coords,
			exitHeading = room.heading,
			storageCoords = interiors[properties[location].interior].storage,
			wardrobeCoords = interiors[properties[location].interior].wardrobe,
			bathroomCoords = interiors[properties[location].interior].bathroom,
			voiceChannel = room.voiceChannel
		}
		TriggerClientEvent('properties:enterProperty', source, currentProperty)
		Citizen.Wait(1000)
		for i = 1, #room.instance do
			local sourceInside = properties[location].rooms[index].instance[i]
			TriggerClientEvent('properties:updateInstance', sourceInside, properties[location].rooms[index].instance)
		end
	end
end)

RegisterServerEvent('properties:forceEntry')
AddEventHandler('properties:forceEntry', function(location, index)
	local usource = source
	local job = exports["usa-characters"]:GetCharacterField(usource, "job")
	if job == 'sheriff' or job == 'corrections' or job == "ems" then
		print('PROPERTIES: '..usource.. ' has forcefully BREACHED into room '..index.. ' at location '..location)
		local room = properties[location].rooms[index]
		table.insert(properties[location].rooms[index].instance, usource)
		TriggerClientEvent('properties:updateData', -1, location, index, properties[location].rooms[index])
		local currentProperty = {
			location = location,
			index = index,
			owner = room.owner,
			name = room.name,
			entryHeading = interiors[properties[location].interior].heading,
			entryCoords = interiors[properties[location].interior].coords,
			instance = room.instance,
			exitCoords = room.coords,
			exitHeading = room.heading,
			storageCoords = interiors[properties[location].interior].storage,
			wardrobeCoords = interiors[properties[location].interior].wardrobe,
			bathroomCoords = interiors[properties[location].interior].bathroom,
			voiceChannel = room.voiceChannel
		}
		TriggerClientEvent('properties:breachProperty', usource, currentProperty)
		Citizen.Wait(1000)
		for i = 1, #room.instance do
			local sourceInside = properties[location].rooms[index].instance[i]
			TriggerClientEvent('InteractSound_CL:PlayOnOne', sourceInside, 'door-kick', 0.2)
			TriggerClientEvent('properties:updateInstance', sourceInside, properties[location].rooms[index].instance)
		end
	else
		DropPlayer(usource, "Exploiting. Your information has been logged and staff has been notified. If you feel this was by mistake, let a staff member know.")
    end
end)

RegisterServerEvent('properties:requestExit')
AddEventHandler('properties:requestExit', function(location, index, noTp)
	if not properties[location] then
		return
	end
	if not properties[location].rooms then
		return
	end
	local room = properties[location].rooms[index]
	if room then
		for i = 1, #room.instance do
			if source == room.instance[i] then
				table.remove(properties[location].rooms[index].instance, i)
			end
		end
		TriggerClientEvent('properties:updateData', -1, location, index, properties[location].rooms[index])
		TriggerEvent("anticheese:exitPropertyAfterDisabling", source, {noTp})
		Wait(1000)
		for i = 1, #room.instance do
			local sourceInside = properties[location].rooms[index].instance[i]
			TriggerClientEvent('properties:updateInstance', sourceInside, properties[location].rooms[index].instance)
		end
	end
end)

RegisterServerEvent('properties:toggleLock')
AddEventHandler('properties:toggleLock', function(location, index)
	local room = properties[location].rooms[index]
	if room.owner == source then
		room.locked = not room.locked
		if room.locked then
			TriggerClientEvent('usa:notify', source, room.name..' has been locked.')
		else
			TriggerClientEvent('usa:notify', source, room.name..' has been unlocked.')
		end
		TriggerClientEvent('properties:updateData', -1, location, index, properties[location].rooms[index])
	end
end)

RegisterServerEvent('properties:requestStorage')
AddEventHandler('properties:requestStorage', function(location, index)
	local room = properties[location].rooms[index]
	local targetSource = room.owner
	local target_char = exports["usa-characters"]:GetCharacter(targetSource)
	local char = exports["usa-characters"]:GetCharacter(source)
	local property = target_char.get("property")
	local menu_data = {
		property_items = property['storage'],
		user_items = {},
		money = property['money']
	}
	local inventory = char.get("inventory")
	for i = 0, (inventory.MAX_CAPACITY - 1) do
		if inventory.items[tostring(i)] then
			local item = inventory.items[tostring(i)]
			if item.type ~= "license" then
				table.insert(menu_data.user_items, inventory.items[tostring(i)])
			end
		end
	end
	TriggerClientEvent("properties:openStorage", source, menu_data)
end)

RegisterServerEvent("properties:storeItem")
AddEventHandler("properties:storeItem", function(location, index, item, quantity)
	local char = exports["usa-characters"]:GetCharacter(source)
	item = char.getItem(item) -- server-sided validity check, don't trust the client!
	if not item then
		print("** [usa_properties] ALERT: Client " .. char.getFullName() .. " sent an item as a parameter to a server event that failed server validation! **")
		return
	end
	local room = properties[location].rooms[index]
	if room.owner and isPlayerInInstance(location, index, source) then
	    local target_char = exports["usa-characters"]:GetCharacter(room.owner)
	    local property = target_char.get('property')
	    item.quantity = quantity
	    if canPropertyHoldItem(room.owner, location, item) then
			print("storing item " .. item.name .. ", legality: " .. (item.legality or "legal"))
			if item.notStackable then
				if item.type == "weapon" then
					TriggerClientEvent("interaction:equipWeapon", source, item, false)
					char.removeItemWithField("uuid", item.uuid)
					table.insert(property['storage'], item)
					target_char.set('property', property)
					TriggerClientEvent('usa:notify', source, '~y~'..item.name..' ~s~has been stored!')
				else
					table.insert(property['storage'], item)
					target_char.set('property', property)
					TriggerClientEvent('usa:notify', source, '~y~'..item.name..' ~s~has been stored!')
					char.removeItem(item, quantity)
				end
			else
				local hasItem = false
				for i = 1, #property['storage'] do
			    	local _item = property['storage'][i]
			        if _item.name == item.name then
		                hasItem	= true
		                _item.quantity = _item.quantity + quantity
		                target_char.set('property', property)
		                TriggerClientEvent('usa:notify', source, '~y~'..item.name..' ~s~has been stored!')
		                char.removeItem(item, quantity)
			            break
			        end
			    end
			    if not hasItem then
			        table.insert(property['storage'], item)
			        target_char.set('property', property)
			        TriggerClientEvent('usa:notify', source, '~y~'..item.name..' ~s~has been stored!')
			        char.removeItem(item, quantity)
			    end
				TriggerClientEvent("usa:playAnimation", source, "anim@move_m@trash", "pickup", -8, 1, -1, 53, 0, 0, 0, 0, 3)
			end
		else
			TriggerClientEvent('usa:notify', source, 'Property storage is full!')
		end
	end
end)

RegisterServerEvent("properties:retrieveItem")
AddEventHandler("properties:retrieveItem", function(location, index, item, quantity)
	local room = properties[location].rooms[index]
	if room.owner and isPlayerInInstance(location, index, source) then
		local char = exports["usa-characters"]:GetCharacter(source)
		local target_char = exports["usa-characters"]:GetCharacter(room.owner)
		local property = target_char.get('property')
		item.quantity = quantity
		if char.canHoldItem(item) then
			local storage = property['storage']
			for i = 1, #storage do
				if (storage[i].name == item.name and item.type ~= "weapon") or (item.type == "weapon" and storage[i].type == "weapon" and item.uuid == storage[i].uuid and storage[i].name == item.name) then
					if storage[i].quantity - quantity < 0 then
						TriggerClientEvent("usa:notify", source, "Invalid amount to retrieve!")
						return
					else
						if storage[i].quantity - quantity == 0 then
							table.remove(property['storage'], i)
							target_char.set('property', property)
							TriggerClientEvent('usa:notify', source, '~y~'..item.name..' ~s~has been retrieved!')
							char.giveItem(item, quantity)
							if item.type == "weapon" then
								TriggerClientEvent("interaction:equipWeapon", source, item, true, false, false)
							end
							TriggerClientEvent("usa:playAnimation", source, "anim@move_m@trash", "pickup", -8, 1, -1, 53, 0, 0, 0, 0, 3)
							return
						else
							property['storage'][i].quantity = property['storage'][i].quantity - quantity
							target_char.set('property', property)
							TriggerClientEvent('usa:notify', source, '~y~'..item.name..' ~s~has been retrieved!')
							char.giveItem(item, quantity)
							if item.type == "weapon" then
								TriggerClientEvent("interaction:equipWeapon", source, item, true, false, false)
							end
							TriggerClientEvent("usa:playAnimation", source, "anim@move_m@trash", "pickup", -8, 1, -1, 53, 0, 0, 0, 0, 3)
							return
						end
					end
				end
			end
			TriggerClientEvent("usa:notify", source, "Please wait a moment...")
		else
			TriggerClientEvent("usa:notify", source, "Inventory full.")
		end
	end
end)

RegisterServerEvent("properties:withdrawMoney")
AddEventHandler("properties:withdrawMoney", function(location, index, amount)
	amount = math.abs(amount)
	local room = properties[location].rooms[index]
	if room.owner and isPlayerInInstance(location, index, source) then
		local char = exports["usa-characters"]:GetCharacter(source)
		local target_char = exports["usa-characters"]:GetCharacter(room.owner)
		local property = target_char.get("property")
		if property["money"] - amount >= 0 then
			target_char.giveMoney(amount)
			property["money"] = property["money"] - amount
			target_char.set("property", property)
			TriggerClientEvent("usa:notify", source, "Withdrawn: ~y~$" .. amount)
		else
			TriggerClientEvent("usa:notify", source, "Not enough money in property!")
		end
	else
		TriggerClientEvent('usa:notify', source, "Owner not found, try again later!")
	end
end)

RegisterServerEvent("properties:storeMoney")
AddEventHandler("properties:storeMoney", function(location, index, amount)
	amount = math.abs(amount)
	local room = properties[location].rooms[index]
	if room.owner and isPlayerInInstance(location, index, source) then
		local char = exports["usa-characters"]:GetCharacter(source)
		local target_char = exports["usa-characters"]:GetCharacter(room.owner)
		local user_money = char.get("money")
		local property = target_char.get("property")
		if user_money - amount >= 0 then
			if (property["money"] + amount) > properties[location].cashLimit then
				TriggerClientEvent("usa:notify", source, "You may only store up to ~y~$"..properties[location].cashLimit..'!')
			else
				char.removeMoney(amount)
				property["money"] = property["money"] + amount
				target_char.set("property", property)
				TriggerClientEvent("usa:notify", source, "Stored: ~y~$" .. amount)
			end
		else
			TriggerClientEvent("usa:notify", source, "You don't have enough money!")
		end
	else
		TriggerClientEvent('usa:notify', source, "Owner not found, try again later!")
	end
end)

RegisterServerEvent('properties:cleanTools')
AddEventHandler('properties:cleanTools', function()
	TriggerClientEvent('evidence:updateData', source, 'gunshotResidue', false)
	local char = exports['usa-characters']:GetCharacter(source)
	local inventory = char.get("inventory")
	local itemsFound = false
	for i = 0, (inventory.MAX_CAPACITY - 1) do
		if inventory.items[tostring(i)] then
			local item = inventory.items[tostring(i)]
			if item['residue'] then
				itemsFound = true
				char.modifyItem(item, "residue", false)
			end
		end
	end
	if not itemsFound then
		TriggerClientEvent('usa:notify', source, 'You have no tools that need cleaning!')
	else
		local anim = {
			dict = "anim@move_m@trash",
			name = "pickup"
		}
		TriggerClientEvent("usa:playAnimation", source, anim.dict, anim.name, -8, 1, -1, 53, 0, 0, 0, 0, 1.5)
		TriggerClientEvent('usa:notify', source, 'Your tools have been cleaned.')
	end
end)

RegisterServerEvent('properties:requestRealEstateMenu')
AddEventHandler('properties:requestRealEstateMenu', function()
	local char = exports['usa-characters']:GetCharacter(source)
	local property = char.get('property')
	TriggerClientEvent('properties:openRealEstateMenu', source, property)
end)

RegisterServerEvent('properties:requestAllData')
AddEventHandler('properties:requestAllData', function()
	TriggerClientEvent('properties:returnAllData', source, properties)
end)

RegisterServerEvent('properties:buzzApartment')
AddEventHandler('properties:buzzApartment', function(location, index)
	local room = properties[location].rooms[index]
	if room.owner == source then
		TriggerEvent('properties:requestEntry', location, index, source)
	else
		for i = 1, #room.instance do
			TriggerClientEvent('properties:buzzMe', room.instance[i])
		end
	end
end)

RegisterServerEvent('properties:lockpickHouse')
AddEventHandler('properties:lockpickHouse', function(playerCoords, lockpickItem)
	local usource = source
	exports.globals:getNumCops(function(numCops)
		if numCops >= 0 then
			for i = 1, #burglaryHouses do
				if find_distance(playerCoords, burglaryHouses[i]) < 2.0 then
					if (burglaryHouses[i].cooldown[usource] and getMinutesFromTime(burglaryHouses[i].cooldown[usource]) > 240) or not burglaryHouses[i].cooldown[usource] then
						TriggerClientEvent('properties:lockpickHouseBurglary', usource, i, lockpickItem)
						Wait(20000)
					else
						TriggerClientEvent('usa:notify', usource, 'This house was recently robbed!')
					end
				end
			end
		else
			TriggerClientEvent('usa:notify', usource, 'You cannot access the lock.')
		end
	end)
end)

RegisterServerEvent('properties:lockpickSuccessful')
AddEventHandler('properties:lockpickSuccessful', function(i)
	table.insert(burglaryHouses[i].instance, source)
	local currentProperty = {
		owner = -1,
		index = i,
		entryHeading = interiors['midapartment'].heading,
		entryCoords = interiors['midapartment'].coords,
		cabinets = interiors['midapartment'].burglaryCabinets,
		instance = burglaryHouses[i].instance,
		exitCoords = {burglaryHouses[i].x, burglaryHouses[i].y, burglaryHouses[i].z},
		exitHeading = burglaryHouses[i].heading,
		voiceChannel = burglaryHouses[i].voiceChannel
	}
	TriggerClientEvent('properties:enterBurglaryHouse', source, currentProperty)
	for k = 1, #burglaryHouses[i].instance do
		local sourceInside = burglaryHouses[i].instance[k]
		TriggerClientEvent('properties:updateInstance', sourceInside, burglaryHouses[i].instance)
	end
end)

RegisterServerEvent('properties:requestExitFromBurglary')
AddEventHandler('properties:requestExitFromBurglary', function(index)
	local house = burglaryHouses[index]
	for i = 1, #house.instance do
		if source == house.instance[i] then
			table.remove(burglaryHouses[index].instance, i)
		end
	end
	house.cooldown[source] = os.time()
	TriggerEvent("anticheese:exitPropertyAfterDisabling", source, {})
	Citizen.Wait(1000)
	for i = 1, #house.instance do
		local sourceInside = burglaryHouses[index].instance[i]
		TriggerClientEvent('properties:updateInstance', sourceInside, burglaryHouses[index].instance)
	end
end)

RegisterServerEvent('properties:searchCabinetBurglary')
AddEventHandler('properties:searchCabinetBurglary', function(index)
	local house = burglaryHouses[index]
	for i = 1, #house.instance do
		if source == house.instance[i] then
			local char = exports['usa-characters']:GetCharacter(source)
			local char_money = char.get('money')
			if math.random() > 0.4 then
				if math.random() > 0.3 then
					local item_found
					if math.random() > 0.1 then	
						item_found = burglarySearchItems[math.random(1, #burglarySearchItems)]
					else 
						item_found = tradingCards[math.random(1, #tradingCards)]
					end
					if char.canHoldItem(item_found) then
						TriggerClientEvent('usa:notify', source, 'You have found '..item_found.name..'.')
						print('PROPERTIES: Player '..GetPlayerName(source)..'['..GetPlayerIdentifier(source)..'] has found item['..item_found.name..'] in house burglary!')
						item_found.uuid = exports.globals:generateID()
						if item_found.type == "weapon" then
					        item_found.serialNumber = item_found.uuid
							char.giveItem(item_found, 1)
							TriggerClientEvent("interaction:equipWeapon", source, item_found, true, false, false)
						else
							char.giveItem(item_found, (item_found.quantity or 1))
						end
						return
					else
						TriggerClientEvent('usa:notify', source, "Inventory is full!")
						return
					end
				else
					local money_found = math.random(10, 350)
					TriggerClientEvent('usa:notify', source, 'You have found $'..money_found..'.0!')
					print('PROPERTIES: Player '..GetPlayerName(source)..'['..GetPlayerIdentifier(source)..'] has found amount['..money_found..'] in house burglary!')
					char.giveMoney(money_found)
					return
				end
			else
				TriggerClientEvent('usa:notify', source, 'You found nothing of interest!')
			end
		end
	end
end)

function find_distance(coords1, coords2)
  xdistance =  math.abs(coords1.x - coords2.x)

  ydistance = math.abs(coords1.y - coords2.y)

  zdistance = math.abs(coords1.z - coords2.z)

  return nroot(3, (xdistance ^ 3 + ydistance ^ 3 + zdistance ^ 3))
end

function nroot(root, num)
  return num^(1/root)
end

function isPlayerInInstance(location, index, source) -- extra security measures to prevent memory editing client-side
	for i = 1, #properties[location].rooms[index].instance do
		if properties[location].rooms[index].instance[i] == source then
			return true
		end
	end
	return false
end

function getMinutesFromTime(t)
  local reference = t
  local minutesfrom = os.difftime(os.time(), reference) / 60
  local minutes = math.floor(minutesfrom)
  return minutes
end
