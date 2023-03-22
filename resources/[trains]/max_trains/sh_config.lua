Config = {}

Config.Debug = false

Config.Models = { -- for all of these make sure to add a seat table below
	TrainEngines = {"streakcoaster", "freight"}, -- add any models for passanger train engines
	TrainCarriges = {"streakcoasterc"}, -- add any models you want to use for passanger carriges (DO NOT ADD FREIGHT CARRIAGES)
	Metros = {"metrotrain"} -- add any models for metro carriges
}

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
	},
	["MediumPassanger"] = {
		name = "Medium Passanger Train",
		description = "Medium Passanger Train with one engine and two carriages",
		spawnID = 1,
		models = {"streakcoaster","streakcoasterc"},
		type = "passangerTrain",
		spawnCoords = vector3(217.3837, -2509.7693, 6.4603),
	},
	["BigPassanger"] = {
		name = "Big Passanger Train",
		description = "Big Passanger Train with one engine and three carriages",
		spawnID = 2,
		models = {"streakcoaster","streakcoasterc"},
		type = "passangerTrain",
		spawnCoords = vector3(217.3837, -2509.7693, 6.4603),
	},
	["SmallFreight"] = {
		name = "Small Freight Train",
		description = "Small Freight Train with one engine and two carriages",
		spawnID = 3,
		models = {"freight","freightcar"},
		type = "freightTrain",
		spawnCoords = vector3(217.3837, -2509.7693, 6.4603),
	},
	["MediumFreight"] = {
		name = "Medium Freight Train",
		description = "Medium Freight Train with one engine and three carriages",
		spawnID = 4,
		models = {"freight","freightcar"},
		type = "freightTrain",
		spawnCoords = vector3(217.3837, -2509.7693, 6.4603),
	},
	["BigFreight"] = {
		name = "Big Freight Train",
		description = "Big Freight Train with one engine and four carriages",
		spawnID = 5,
		models = {"freight","freightcar"},
		type = "freightTrain",
		spawnCoords = vector3(217.3837, -2509.7693, 6.4603),
	},
	["SmallMetro"] = {
		name = "Small Metro",
		description = "Small Metro with a single 2-part carriage",
		spawnID = 6,
		models = {"metrotrain"},
		type = "metro",
		spawnCoords = vector3(-898.7032, -2339.0503, -11.6807),
	},
	["MediumMetro"] = {
		name = "Medium Metro",
		description = "Medium Metro with two 2-part carriages",
		spawnID = 7,
		models = {"metrotrain"},
		type = "metro",
		spawnCoords = vector3(-898.7032, -2339.0503, -11.6807),
	},
	["BigMetro"] = {
		name = "Big Metro",
		description = "Big Metro with three 2-part carriages",
		spawnID = 8,
		models = {"metrotrain"},
		type = "metro",
		spawnCoords = vector3(-898.7032, -2339.0503, -11.6807),
	},
}

Config.SeatTables = { -- Offsets for seat possitions from model, used to attach player to entity
	["streakcoasterc"] = {
		seat1 = {taken = nil, x = 1.0, y = 1.5, z = -0.65, rotate = 0.0, number = 1},
		seat2 = {taken = nil, x = -1.0, y = 1.5, z = -0.65, rotate = 0.0, number = 2},
		seat3 = {taken = nil, x = 1.0, y = 3.0, z = -0.65, rotate = 180.0, number = 3},
		seat4 = {taken = nil, x = -1.0, y = 3.0, z = -0.65, rotate = 180.0, number = 4},
		seat5 = {taken = nil, x = 1.0, y = 6.75, z = 0.35, rotate = 180.0, number = 5},
		seat6 = {taken = nil, x = 1.0, y = 7.5, z = 0.35, rotate = 0.0, number = 6},
		seat7 = {taken = nil, x = 1.0, y = 8.95, z = 0.35, rotate = 180.0, number = 7},
		seat8 = {taken = nil, x = -1.0, y = 6.75, z = 0.35, rotate = 180.0, number = 8},
		seat9 = {taken = nil, x = -1.0, y = 7.5, z = 0.35, rotate = 0.0, number = 9},
		seat10 = {taken = nil, x = -1.0, y = 8.95, z = 0.35, rotate = 180.0, number = 10},
		seat11 = {taken = nil, x = 1.0, y = -1.5, z = -0.65, rotate = 180.0, number = 11},
		seat12 = {taken = nil, x = -1.0, y = -1.5, z = -0.65, rotate = 180.0, number = 12},
		seat13 = {taken = nil, x = 1.0, y = -3.0, z = -0.65, rotate = 0.0, number = 13},
		seat14 = {taken = nil, x = -1.0, y = -3.0, z = -0.65, rotate = 0.0, number = 14},
		seat15 = {taken = nil, x = 1.0, y = -6.75, z = 0.35, rotate = 0.0, number = 15},
		seat16 = {taken = nil, x = 1.0, y = -7.5, z = 0.35, rotate = 180.0, number = 16},
		seat17 = {taken = nil, x = 1.0, y = -8.95, z = 0.35, rotate = 0.0, number = 17},
		seat18 = {taken = nil, x = -1.0, y = -6.75, z = 0.35, rotate = 0.0, number = 18},
		seat19 = {taken = nil, x = -1.0, y = -7.5, z = 0.35, rotate = 180.0, number = 19},
		seat20 = {taken = nil, x = -1.0, y = -8.95, z = 0.35, rotate = 0.0, number = 20},
		seat21 = {taken = nil, x = 1.0, y = 3.325, z = 1.35, rotate = 0.0, number = 21},
		seat22 = {taken = nil, x = 1.0, y = 1.85, z = 1.35, rotate = 0.0, number = 22},
		seat23 = {taken = nil, x = 1.0, y = 0.375, z = 1.35, rotate = 0.0, number = 23},
		seat24 = {taken = nil, x = 1.0, y = -1.05, z = 1.35, rotate = 0.0, number = 24},
		seat25 = {taken = nil, x = 1.0, y = -2.565, z = 1.35, rotate = 0.0, number = 25},
		seat26 = {taken = nil, x = 1.0, y = -4.05, z = 1.35, rotate = 0.0, number = 26},
		seat27 = {taken = nil, x = -1.0, y = 3.325, z = 1.35, rotate = 0.0, number = 27},
		seat28 = {taken = nil, x = -1.0, y = 1.85, z = 1.35, rotate = 0.0, number = 28},
		seat29 = {taken = nil, x = -1.0, y = 0.375, z = 1.35, rotate = 0.0, number = 29},
		seat30 = {taken = nil, x = -1.0, y = -1.05, z = 1.35, rotate = 0.0, number = 30},
		seat31 = {taken = nil, x = -1.0, y = -2.565, z = 1.35, rotate = 0.0, number = 31},
		seat32 = {taken = nil, x = -1.0, y = -4.05, z = 1.35, rotate = 0.0, number = 32},
	},
	["metrotrain"] = {
		seat1 = {taken = nil, x = 1.0, y = 2.2, z = 1.0, rotate = 90.0, number = 1},
		seat2 = {taken = nil, x = 1.0, y = 1.45, z = 1.0, rotate = 90.0, number = 2},
		seat3 = {taken = nil, x = 1.0, y = 0.65, z = 1.0, rotate = 90.0, number = 3},
		seat4 = {taken = nil, x = 1.0, y = -0.05, z = 1.0, rotate = 90.0, number = 4},
		seat5 = {taken = nil, x = 1.0, y = -0.85, z = 1.0, rotate = 90.0, number = 5},
		seat6 = {taken = nil, x = 1.0, y = -1.55, z = 1.0, rotate = 90.0, number = 6},
		seat7 = {taken = nil, x = 1.0, y = -3.9, z = 1.0, rotate = 90.0, number = 7},
		seat8 = {taken = nil, x = 1.0, y = -4.7, z = 1.0, rotate = 90.0, number = 8},
		-- other side
		seat9 = {taken = nil, x = -1.0, y = 2.2, z = 1.0, rotate = 270.0, number = 9},
		seat10 = {taken = nil, x = -1.0, y = 1.45, z = 1.0, rotate = 270.0, number = 10},
		seat11 = {taken = nil, x = -1.0, y = 0.65, z = 1.0, rotate = 270.0, number = 11},
		seat12 = {taken = nil, x = -1.0, y = -0.05, z = 1.0, rotate = 270.0, number = 12},
		seat13 = {taken = nil, x = -1.0, y = -0.85, z = 1.0, rotate = 270.0, number = 13},
		seat14 = {taken = nil, x = -1.0, y = -1.55, z = 1.0, rotate = 270.0, number = 14},
		seat15 = {taken = nil, x = -1.0, y = -3.9, z = 1.0, rotate = 270.0, number = 15},
		seat16 = {taken = nil, x = -1.0, y = -4.7, z = 1.0, rotate = 270.0, number = 16},
	}
}

Config.MetroDoorIndexes = {0, 2}