Config = {}

Config.Debug = false

Config.Models = { -- for all of these make sure to add a seat table below
	TrainEngines = {"streakcoaster", "freight"}, -- add any models for passanger train engines
	TrainCarriges = {"streakcoasterc"}, -- add any models you want to use for passanger carriges (DO NOT ADD FREIGHT CARRIAGES)
	Metros = {"metrotrain"} -- add any models for metro carriges
}

Config.TimeStoppedAtStation = 20 -- amount of seconds a driver has to be stopped at a station for before they can leave without being penalized
Config.PayPerGoodStation = true -- if set to true the player will get payed an amount if they stay at a station for the required length as a bonus
Config.PayPerGoodStationAmount = 350 -- amount of money the player will get payed
Config.MaxStrikes = 3 -- Amount of strikes a player can get before getting sacked

Config.TrainLayouts = {
	-- ["TableKey"] = { -- Example Layout
	-- 	name = "Name of Train Layout",
	-- 	description = "Small Description of Train Layout",
	-- 	spawnID = 0, -- id of train within trains.xml file starts at 0
	-- 	models = {}, -- table of models used by the train
	-- 	type = "", -- either metro or passangerTrain
	-- 	spawnCoords = vector3(0,0,0), -- where to spawn train at
	-- },
	["SmallPassanger"] = {
		name = "Small Passanger Train",
		description = "Small Passanger Train with one engine and one carriage",
		spawnID = 0,
		models = {"streakcoaster","streakcoasterc"},
		type = "passangerTrain",
		spawnCoords = vector3(217.3837, -2509.7693, 6.4603),
		startingPlatformID = 7,
	},
	["MediumPassanger"] = {
		name = "Medium Passanger Train",
		description = "Medium Passanger Train with one engine and two carriages",
		spawnID = 1,
		models = {"streakcoaster","streakcoasterc"},
		type = "passangerTrain",
		spawnCoords = vector3(217.3837, -2509.7693, 6.4603),
		startingPlatformID = 7,
	},
	["BigPassanger"] = {
		name = "Big Passanger Train",
		description = "Big Passanger Train with one engine and three carriages",
		spawnID = 2,
		models = {"streakcoaster","streakcoasterc"},
		type = "passangerTrain",
		spawnCoords = vector3(217.3837, -2509.7693, 6.4603),
		startingPlatformID = 7,
	},
	["SmallFreight"] = {
		name = "Small Freight Train",
		description = "Small Freight Train with one engine and two carriages",
		spawnID = 3,
		models = {"freight","freightcar"},
		type = "freightTrain",
		spawnCoords = vector3(217.3837, -2509.7693, 6.4603),
		startingPlatformID = 7,
	},
	["MediumFreight"] = {
		name = "Medium Freight Train",
		description = "Medium Freight Train with one engine and three carriages",
		spawnID = 4,
		models = {"freight","freightcar"},
		type = "freightTrain",
		spawnCoords = vector3(217.3837, -2509.7693, 6.4603),
		startingPlatformID = 7,
	},
	["BigFreight"] = {
		name = "Big Freight Train",
		description = "Big Freight Train with one engine and four carriages",
		spawnID = 5,
		models = {"freight","freightcar"},
		type = "freightTrain",
		spawnCoords = vector3(217.3837, -2509.7693, 6.4603),
		startingPlatformID = 7,
	},
	["SmallMetro"] = {
		name = "Small Metro",
		description = "Small Metro with a single 2-part carriage",
		spawnID = 6,
		models = {"metrotrain"},
		type = "metro",
		spawnCoords = vector3(-898.7032, -2339.0503, -11.6807),
		startingPlatformID = 1,
	},
	["MediumMetro"] = {
		name = "Medium Metro",
		description = "Medium Metro with two 2-part carriages",
		spawnID = 7,
		models = {"metrotrain"},
		type = "metro",
		spawnCoords = vector3(-898.7032, -2339.0503, -11.6807),
		startingPlatformID = 1,
	},
	["BigMetro"] = {
		name = "Big Metro",
		description = "Big Metro with three 2-part carriages",
		spawnID = 8,
		models = {"metrotrain"},
		type = "metro",
		spawnCoords = vector3(-898.7032, -2339.0503, -11.6807),
		startingPlatformID = 1,
	},
}

Config.SeatTables = { -- Offsets for seat possitions from model, used to attach player to entity
	["streakcoasterc"] = {
		seat1 = {taken = nil, x = 1.0, y = 1.5, z = -0.65, rotate = 0.0, number = 1, npc = false},
		seat2 = {taken = nil, x = -1.0, y = 1.5, z = -0.65, rotate = 0.0, number = 2, npc = false},
		seat3 = {taken = nil, x = 1.0, y = 3.0, z = -0.65, rotate = 180.0, number = 3, npc = false},
		seat4 = {taken = nil, x = -1.0, y = 3.0, z = -0.65, rotate = 180.0, number = 4, npc = false},
		seat5 = {taken = nil, x = 1.0, y = 6.75, z = 0.35, rotate = 180.0, number = 5, npc = false},
		seat6 = {taken = nil, x = 1.0, y = 7.5, z = 0.35, rotate = 0.0, number = 6, npc = false},
		seat7 = {taken = nil, x = 1.0, y = 8.95, z = 0.35, rotate = 180.0, number = 7, npc = false},
		seat8 = {taken = nil, x = -1.0, y = 6.75, z = 0.35, rotate = 180.0, number = 8, npc = false},
		seat9 = {taken = nil, x = -1.0, y = 7.5, z = 0.35, rotate = 0.0, number = 9, npc = false},
		seat10 = {taken = nil, x = -1.0, y = 8.95, z = 0.35, rotate = 180.0, number = 10, npc = false},
		seat11 = {taken = nil, x = 1.0, y = -1.5, z = -0.65, rotate = 180.0, number = 11, npc = false},
		seat12 = {taken = nil, x = -1.0, y = -1.5, z = -0.65, rotate = 180.0, number = 12, npc = false},
		seat13 = {taken = nil, x = 1.0, y = -3.0, z = -0.65, rotate = 0.0, number = 13, npc = false},
		seat14 = {taken = nil, x = -1.0, y = -3.0, z = -0.65, rotate = 0.0, number = 14, npc = false},
		seat15 = {taken = nil, x = 1.0, y = -6.75, z = 0.35, rotate = 0.0, number = 15, npc = false},
		seat16 = {taken = nil, x = 1.0, y = -7.5, z = 0.35, rotate = 180.0, number = 16, npc = false},
		seat17 = {taken = nil, x = 1.0, y = -8.95, z = 0.35, rotate = 0.0, number = 17, npc = false},
		seat18 = {taken = nil, x = -1.0, y = -6.75, z = 0.35, rotate = 0.0, number = 18, npc = false},
		seat19 = {taken = nil, x = -1.0, y = -7.5, z = 0.35, rotate = 180.0, number = 19, npc = false},
		seat20 = {taken = nil, x = -1.0, y = -8.95, z = 0.35, rotate = 0.0, number = 20, npc = false},
		seat21 = {taken = nil, x = 1.0, y = 3.325, z = 1.35, rotate = 0.0, number = 21, npc = false},
		seat22 = {taken = nil, x = 1.0, y = 1.85, z = 1.35, rotate = 0.0, number = 22, npc = false},
		seat23 = {taken = nil, x = 1.0, y = 0.375, z = 1.35, rotate = 0.0, number = 23, npc = false},
		seat24 = {taken = nil, x = 1.0, y = -1.05, z = 1.35, rotate = 0.0, number = 24, npc = false},
		seat25 = {taken = nil, x = 1.0, y = -2.565, z = 1.35, rotate = 0.0, number = 25, npc = false},
		seat26 = {taken = nil, x = 1.0, y = -4.05, z = 1.35, rotate = 0.0, number = 26, npc = false},
		seat27 = {taken = nil, x = -1.0, y = 3.325, z = 1.35, rotate = 0.0, number = 27, npc = false},
		seat28 = {taken = nil, x = -1.0, y = 1.85, z = 1.35, rotate = 0.0, number = 28, npc = false},
		seat29 = {taken = nil, x = -1.0, y = 0.375, z = 1.35, rotate = 0.0, number = 29, npc = false},
		seat30 = {taken = nil, x = -1.0, y = -1.05, z = 1.35, rotate = 0.0, number = 30, npc = false},
		seat31 = {taken = nil, x = -1.0, y = -2.565, z = 1.35, rotate = 0.0, number = 31, npc = false},
		seat32 = {taken = nil, x = -1.0, y = -4.05, z = 1.35, rotate = 0.0, number = 32, npc = false},
	},
	["metrotrain"] = {
		seat1 = {taken = nil, x = 1.0, y = 2.2, z = 1.0, rotate = 90.0, number = 1, npc = false},
		seat2 = {taken = nil, x = 1.0, y = 1.45, z = 1.0, rotate = 90.0, number = 2, npc = false},
		seat3 = {taken = nil, x = 1.0, y = 0.65, z = 1.0, rotate = 90.0, number = 3, npc = false},
		seat4 = {taken = nil, x = 1.0, y = -0.05, z = 1.0, rotate = 90.0, number = 4, npc = false},
		seat5 = {taken = nil, x = 1.0, y = -0.85, z = 1.0, rotate = 90.0, number = 5, npc = false},
		seat6 = {taken = nil, x = 1.0, y = -1.55, z = 1.0, rotate = 90.0, number = 6, npc = false},
		seat7 = {taken = nil, x = 1.0, y = -3.9, z = 1.0, rotate = 90.0, number = 7, npc = false},
		seat8 = {taken = nil, x = 1.0, y = -4.7, z = 1.0, rotate = 90.0, number = 8, npc = false},
		-- other side
		seat9 = {taken = nil, x = -1.0, y = 2.2, z = 1.0, rotate = 270.0, number = 9, npc = false},
		seat10 = {taken = nil, x = -1.0, y = 1.45, z = 1.0, rotate = 270.0, number = 10, npc = false},
		seat11 = {taken = nil, x = -1.0, y = 0.65, z = 1.0, rotate = 270.0, number = 11, npc = false},
		seat12 = {taken = nil, x = -1.0, y = -0.05, z = 1.0, rotate = 270.0, number = 12, npc = false},
		seat13 = {taken = nil, x = -1.0, y = -0.85, z = 1.0, rotate = 270.0, number = 13, npc = false},
		seat14 = {taken = nil, x = -1.0, y = -1.55, z = 1.0, rotate = 270.0, number = 14, npc = false},
		seat15 = {taken = nil, x = -1.0, y = -3.9, z = 1.0, rotate = 270.0, number = 15, npc = false},
		seat16 = {taken = nil, x = -1.0, y = -4.7, z = 1.0, rotate = 270.0, number = 16, npc = false},
	}
}

Config.MetroDoorIndexes = {0, 2}