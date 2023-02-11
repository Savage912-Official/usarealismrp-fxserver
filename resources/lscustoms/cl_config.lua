--[[
Los Santos Customs V1.1
Credits - MythicalBro
/////License/////
Do not reupload/re release any part of this script without my permission
]]
local colors = {
	{name = "Black", colorindex = 0},{name = "Carbon Black", colorindex = 147},
	{name = "Hraphite", colorindex = 1},{name = "Anhracite Black", colorindex = 11},
	{name = "Black Steel", colorindex = 2},{name = "Dark Steel", colorindex = 3},
	{name = "Silver", colorindex = 4},{name = "Bluish Silver", colorindex = 5},
	{name = "Rolled Steel", colorindex = 6},{name = "Shadow Silver", colorindex = 7},
	{name = "Stone Silver", colorindex = 8},{name = "Midnight Silver", colorindex = 9},
	{name = "Cast Iron Silver", colorindex = 10},{name = "Red", colorindex = 27},
	{name = "Torino Red", colorindex = 28},{name = "Formula Red", colorindex = 29},
	{name = "Lava Red", colorindex = 150},{name = "Blaze Red", colorindex = 30},
	{name = "Grace Red", colorindex = 31},{name = "Garnet Red", colorindex = 32},
	{name = "Sunset Red", colorindex = 33},{name = "Cabernet Red", colorindex = 34},
	{name = "Wine Red", colorindex = 143},{name = "Candy Red", colorindex = 35},
	{name = "Hot Pink", colorindex = 135},{name = "Pfsiter Pink", colorindex = 137},
	{name = "Salmon Pink", colorindex = 136},{name = "Sunrise Orange", colorindex = 36},
	{name = "Orange", colorindex = 38},{name = "Bright Orange", colorindex = 138},
	{name = "Gold", colorindex = 99},{name = "Bronze", colorindex = 90},
	{name = "Yellow", colorindex = 88},{name = "Race Yellow", colorindex = 89},
	{name = "Dew Yellow", colorindex = 91},{name = "Dark Green", colorindex = 49},
	{name = "Racing Green", colorindex = 50},{name = "Sea Green", colorindex = 51},
	{name = "Olive Green", colorindex = 52},{name = "Bright Green", colorindex = 53},
	{name = "Gasoline Green", colorindex = 54},{name = "Lime Green", colorindex = 92},
	{name = "Midnight Blue", colorindex = 141},
	{name = "Galaxy Blue", colorindex = 61},{name = "Dark Blue", colorindex = 62},
	{name = "Saxon Blue", colorindex = 63},{name = "Blue", colorindex = 64},
	{name = "Mariner Blue", colorindex = 65},{name = "Harbor Blue", colorindex = 66},
	{name = "Diamond Blue", colorindex = 67},{name = "Surf Blue", colorindex = 68},
	{name = "Nautical Blue", colorindex = 69},{name = "Racing Blue", colorindex = 73},
	{name = "Ultra Blue", colorindex = 70},{name = "Light Blue", colorindex = 74},
	{name = "Chocolate Brown", colorindex = 96},{name = "Bison Brown", colorindex = 101},
	{name = "Creeen Brown", colorindex = 95},{name = "Feltzer Brown", colorindex = 94},
	{name = "Maple Brown", colorindex = 97},{name = "Beechwood Brown", colorindex = 103},
	{name = "Sienna Brown", colorindex = 104},{name = "Saddle Brown", colorindex = 98},
	{name = "Moss Brown", colorindex = 100},{name = "Woodbeech Brown", colorindex = 102},
	{name = "Straw Brown", colorindex = 99},{name = "Sandy Brown", colorindex = 105},
	{name = "Bleached Brown", colorindex = 106},{name = "Schafter Purple", colorindex = 71},
	{name = "Spinnaker Purple", colorindex = 72},{name = "Midnight Purple", colorindex = 142},
	{name = "Bright Purple", colorindex = 145},{name = "Cream", colorindex = 107},
	{name = "Ice White", colorindex = 111},{name = "Frost White", colorindex = 112}
}

local metalcolors = {
	{name = "Brushed Steel",colorindex = 117},
	{name = "Brushed Black Steel",colorindex = 118},
	{name = "Brushed Aluminum",colorindex = 119},
	{name = "Pure Gold",colorindex = 158},
	{name = "Brushed Gold",colorindex = 159}
}

local mattecolors = {
	{name = "Black", colorindex = 12},
	{name = "Gray", colorindex = 13},
	{name = "Light Gray", colorindex = 14},
	{name = "Ice White", colorindex = 131},
	{name = "Blue", colorindex = 83},
	{name = "Dark Blue", colorindex = 82},
	{name = "Midnight Blue", colorindex = 84},
	{name = "Midnight Purple", colorindex = 149},
	{name = "Schafter Purple", colorindex = 148},
	{name = "Red", colorindex = 39},
	{name = "Dark Red", colorindex = 40},
	{name = "Orange", colorindex = 41},
	{name = "Yellow", colorindex = 42},
	{name = "Lime Green", colorindex = 55},
	{name = "Green", colorindex = 128},
	{name = "Frost Green", colorindex = 151},
	{name = "Foliage Green", colorindex = 155},
	{name = "Olive Darb", colorindex = 152},
	{name = "Dark Earth", colorindex = 153},
	{name = "Desert Tan", colorindex = 154}
}



LSC_Config = {}
LSC_Config.prices = {}

--------Prices---------
LSC_Config.prices = {

	GENERIC_WHEEL = 6000,
	NICER_WHEEL = 15000,

	livery = {
		price = 2000
	},

------Window tint------
	windowtint = {
		{ name = "Pure Black", tint = 1, price = 1000},
		{ name = "Dark Smoke", tint = 2, price = 1000},
		{ name = "Light Smoke", tint = 3, price = 1000},
		{ name = "Limo", tint = 4, price = 1000},
		{ name = "Green", tint = 5, price = 1000},
	},

-------Respray--------
----Primary color---
	--Chrome
	chrome = {
		colors = {
			{name = "Chrome", colorindex = 120}
		},
		price = 3000
	},
	--Classic
	classic = {
		colors = colors,
		price = 5000
	},
	--Matte
	matte = {
		colors = mattecolors,
		price = 5000
	},
	--Metallic
	metallic = {
		colors = colors,
		price = 5000
	},
	--Metals
	metal = {
		colors = metalcolors,
		price = 5000
	},

----Secondary color---
	--Chrome
	chrome2 = {
		colors = {
			{name = "Chrome", colorindex = 120}
		},
		price = 3000
	},
	--Classic
	classic2 = {
		colors = colors,
		price = 1000
	},
	--Matte
	matte2 = {
		colors = mattecolors,
		price = 1000
	},
	--Metallic
	metallic2 = {
		colors = colors,
		price = 1000
	},
	--Metals
	metal2 = {
		colors = metalcolors,
		price = 1000
	},

------Neon layout------
	neonlayout = {
		{name = "Full Lighting", price = 5000},
	},
	--Neon color
	neoncolor = {
		{ name = "White", neon = {255,255,255}, price = 1000},
		{ name = "Blue", neon = {0,0,255}, price = 1000},
		{ name = "Electric Blue", neon = {0,150,255}, price = 1000},
		{ name = "Mint Green", neon = {50,255,155}, price = 1000},
		{ name = "Lime Green", neon = {0,255,0}, price = 1000},
		{ name = "Yellow", neon = {255,255,0}, price = 1000},
		{ name = "Golden Shower", neon = {204,204,0}, price = 1000},
		{ name = "Orange", neon = {255,128,0}, price = 1000},
		{ name = "Red", neon = {255,0,0}, price = 1000},
		{ name = "Pony Pink", neon = {255,102,255}, price = 1000},
		{ name = "Hot Pink",neon = {255,0,255}, price = 1000},
		{ name = "Purple", neon = {153,0,153}, price = 1000},
		{ name = "Brown", neon = {139,69,19}, price = 1000},
	},

--------Plates---------
	plates = {
		{ name = "Blue on White 1", plateindex = 0, price = 200},
		{ name = "Blue On White 2", plateindex = 3, price = 200},
		{ name = "Yellow on Blue", plateindex = 2, price = 300},
		{ name = "Yellow on Black", plateindex = 1, price = 600},
	},

--------Wheels--------
----Wheel accessories----
	wheelaccessories = {
		{ name = "Stock Tires", price = 1000},
		{ name = "Custom Tires", price = 1250},
		--{ name = "Low Grip Tires", price = 1250},
		--{ name = "Bulletproof Tires", price = 5000},
		{ name = "White Tire Smoke",smokecolor = {254,254,254}, price = 3000},
		{ name = "Black Tire Smoke", smokecolor = {1,1,1}, price = 3000},
		{ name = "Blue Tire Smoke", smokecolor = {0,150,255}, price = 3000},
		{ name = "Yellow Tire Smoke", smokecolor = {255,255,50}, price = 3000},
		{ name = "Orange Tire Smoke", smokecolor = {255,153,51}, price = 3000},
		{ name = "Red Tire Smoke", smokecolor = {255,10,10}, price = 3000},
		{ name = "Green Tire Smoke", smokecolor = {10,255,10}, price = 3000},
		{ name = "Purple Tire Smoke", smokecolor = {153,10,153}, price = 3000},
		{ name = "Pink Tire Smoke", smokecolor = {255,102,178}, price = 3000},
		{ name = "Gray Tire Smoke",smokecolor = {128,128,128}, price = 3000},
	},

----Wheel color----
	wheelcolor = {
		colors = colors,
		price = 1000,
	},

----Front wheel (Bikes)----
frontwheel = {
	{name = "Stock", wtype = 6, mod = -1, price = 1000},
	{name = "Speedway", wtype = 6, mod = 0, price = 1000},
	{name = "Streetspecial", wtype = 6, mod = 1, price = 1000},
	{name = "Racer", wtype = 6, mod = 2, price = 1000},
	{name = "Trackstar", wtype = 6, mod = 3, price = 1000},
	{name = "Overlord", wtype = 6, mod = 4, price = 1000},
	{name = "Trident", wtype = 6, mod = 5, price = 1000},
	{name = "Triplethreat", wtype = 6, mod = 6, price = 1000},
	{name = "Stilleto", wtype = 6, mod = 7, price = 1000},
	{name = "Wires", wtype = 6, mod = 8, price = 1000},
	{name = "Bobber", wtype = 6, mod = 9, price = 1000},
	{name = "Solidus", wtype = 6, mod = 10, price = 1000},
	{name = "Iceshield", wtype = 6, mod = 11, price = 1000},
	{name = "Loops", wtype = 6, mod = 12, price = 1000},
	{name = "Romper Racing", wtype = 6, mod = 26, price = 5000},
	{name = "Warp Drive", wtype = 6, mod = 27, price = 6000},
	{name = "Snowflake", wtype = 6, mod = 28, price = 6000},
	{name = "Holy Spoke", wtype = 6, mod = 29, price = 6500},
	{name = "Old Skool Triple", wtype = 6, mod = 30, price = 6000},
	{name = "Futura", wtype = 6, mod = 31, price = 5000},
	{name = "Quarter Mile King", wtype = 6, mod = 32, price = 6500},
	{name = "Cartwheel", wtype = 6, mod = 33, price = 5000},
	{name = "Double Five", wtype = 6, mod = 34, price = 8000},
	{name = "Shuriken", wtype = 6, mod = 35, price = 15000},
	{name = "Simple Six", wtype = 6, mod = 36, price = 13000},
	{name = "Celtic", wtype = 6, mod = 37, price = 14000},
	{name = "Razer", wtype = 6, mod = 38, price = 16000},
	{name = "Twisted", wtype = 6, mod = 39, price = 14000},
	{name = "Morning Star", wtype = 6, mod = 40, price = 16500},
	{name = "Jagged Spokes", wtype = 6, mod = 41, price = 17000},
	{name = "Eidolon", wtype = 6, mod = 42, price = 16000},
	{name = "Enigma", wtype = 6, mod = 43, price = 17000},
	{name = "Big Spokes", wtype = 6, mod = 44, price = 14000},
	{name = "Webs", wtype = 6, mod = 45, price = 18000},
	{name = "Hotplate", wtype = 6, mod = 46, price = 18000},
	{name = "Bobsta", wtype = 6, mod = 47, price = 16000},
	{name = "Grouch", wtype = 6, mod = 48, price = 17000},
},
----Back wheel (Bikes)-----
backwheel = {
	{name = "Stock", wtype = 6, mod = -1, price = 1000},
	{name = "Speedway", wtype = 6, mod = 0, price = 1000},
	{name = "Streetspecial", wtype = 6, mod = 1, price = 1000},
	{name = "Racer", wtype = 6, mod = 2, price = 1000},
	{name = "Trackstar", wtype = 6, mod = 3, price = 1000},
	{name = "Overlord", wtype = 6, mod = 4, price = 1000},
	{name = "Trident", wtype = 6, mod = 5, price = 1000},
	{name = "Triplethreat", wtype = 6, mod = 6, price = 1000},
	{name = "Stilleto", wtype = 6, mod = 7, price = 1000},
	{name = "Wires", wtype = 6, mod = 8, price = 1000},
	{name = "Bobber", wtype = 6, mod = 9, price = 1000},
	{name = "Solidus", wtype = 6, mod = 10, price = 1000},
	{name = "Iceshield", wtype = 6, mod = 11, price = 1000},
	{name = "Loops", wtype = 6, mod = 12, price = 1000},
	{name = "Romper Racing", wtype = 6, mod = 26, price = 5000},
	{name = "Warp Drive", wtype = 6, mod = 27, price = 6000},
	{name = "Snowflake", wtype = 6, mod = 28, price = 6000},
	{name = "Holy Spoke", wtype = 6, mod = 29, price = 6500},
	{name = "Old Skool Triple", wtype = 6, mod = 30, price = 6000},
	{name = "Futura", wtype = 6, mod = 31, price = 5000},
	{name = "Quarter Mile King", wtype = 6, mod = 32, price = 6500},
	{name = "Cartwheel", wtype = 6, mod = 33, price = 5000},
	{name = "Double Five", wtype = 6, mod = 34, price = 8000},
	{name = "Shuriken", wtype = 6, mod = 35, price = 15000},
	{name = "Simple Six", wtype = 6, mod = 36, price = 13000},
	{name = "Celtic", wtype = 6, mod = 37, price = 14000},
	{name = "Razer", wtype = 6, mod = 38, price = 16000},
	{name = "Twisted", wtype = 6, mod = 39, price = 14000},
	{name = "Morning Star", wtype = 6, mod = 40, price = 16500},
	{name = "Jagged Spokes", wtype = 6, mod = 41, price = 17000},
	{name = "Eidolon", wtype = 6, mod = 42, price = 16000},
	{name = "Enigma", wtype = 6, mod = 43, price = 17000},
	{name = "Big Spokes", wtype = 6, mod = 44, price = 14000},
	{name = "Webs", wtype = 6, mod = 45, price = 18000},
	{name = "Hotplate", wtype = 6, mod = 46, price = 18000},
	{name = "Bobsta", wtype = 6, mod = 47, price = 16000},
	{name = "Grouch", wtype = 6, mod = 48, price = 17000},
},
----Sport wheels-----
	sportwheels = {
		{name = "Stock", wtype = 0, mod = -1, price = 1000},
		{name = "Inferno", wtype = 0, mod = 0, price = 1000},
		{name = "Deepfive", wtype = 0, mod = 1, price = 1000},
		{name = "Lozspeed", wtype = 0, mod = 2, price = 1000},
		{name = "Diamondcut", wtype = 0, mod = 3, price = 1000},
		{name = "Chrono", wtype = 0, mod = 4, price = 1000},
		{name = "Feroccirr", wtype = 0, mod = 5, price = 1000},
		{name = "Fiftynine", wtype = 0, mod = 6, price = 1000},
		{name = "Mercie", wtype = 0, mod = 7, price = 1000},
		{name = "Syntheticz", wtype = 0, mod = 8, price = 1000},
		{name = "Organictyped", wtype = 0, mod = 9, price = 1000},
		{name = "Endov1", wtype = 0, mod = 10, price = 1000},
		{name = "Duper7", wtype = 0, mod = 11, price = 1000},
		{name = "Uzer", wtype = 0, mod = 12, price = 1000},
		{name = "Groundride", wtype = 0, mod = 13, price = 1000},
		{name = "Spacer", wtype = 0, mod = 14, price = 1000},
		{name = "Venum", wtype = 0, mod = 15, price = 1000},
		{name = "Cosmo", wtype = 0, mod = 16, price = 1000},
		{name = "Dashvip", wtype = 0, mod = 17, price = 1000},
		{name = "Icekid", wtype = 0, mod = 18, price = 1000},
		{name = "Ruffeld", wtype = 0, mod = 19, price = 1000},
		{name = "Wangenmaster", wtype = 0, mod = 20, price = 1000},
		{name = "Superfive", wtype = 0, mod = 21, price = 1000},
		{name = "Endov2", wtype = 0, mod = 22, price = 1000},
		{name = "Slitsix", wtype = 0, mod = 23, price = 1000},
	},
-----Suv wheels------
	suvwheels = {
		{name = "Stock", wtype = 3, mod = -1, price = 1000},
		{name = "Vip", wtype = 3, mod = 0, price = 1000},
		{name = "Benefactor", wtype = 3, mod = 1, price = 1000},
		{name = "Cosmo", wtype = 3, mod = 2, price = 1000},
		{name = "Bippu", wtype = 3, mod = 3, price = 1000},
		{name = "Royalsix", wtype = 3, mod = 4, price = 1000},
		{name = "Fagorme", wtype = 3, mod = 5, price = 1000},
		{name = "Deluxe", wtype = 3, mod = 6, price = 1000},
		{name = "Icedout", wtype = 3, mod = 7, price = 1000},
		{name = "Cognscenti", wtype = 3, mod = 8, price = 1000},
		{name = "Lozspeedten", wtype = 3, mod = 9, price = 1000},
		{name = "Supernova", wtype = 3, mod = 10, price = 1000},
		{name = "Obeyrs", wtype = 3, mod = 11, price = 1000},
		{name = "Lozspeedballer", wtype = 3, mod = 12, price = 1000},
		{name = "Extra vaganzo", wtype = 3, mod = 13, price = 1000},
		{name = "Splitsix", wtype = 3, mod = 14, price = 1000},
		{name = "Empowered", wtype = 3, mod = 15, price = 1000},
		{name = "Sunrise", wtype = 3, mod = 16, price = 1000},
		{name = "Dashvip", wtype = 3, mod = 17, price = 1000},
		{name = "Cutter", wtype = 3, mod = 18, price = 1000},
	},
-----Offroad wheels-----
	offroadwheels = {
		{name = "Stock", wtype = 4, mod = -1, price = 1000},
		{name = "Raider", wtype = 4, mod = 0, price = 1000},
		{name = "Mudslinger", wtype = 4, modtype = 23, mod = 1, price = 1000},
		{name = "Nevis", wtype = 4, mod = 2, price = 1000},
		{name = "Cairngorm", wtype = 4, mod = 3, price = 1000},
		{name = "Amazon", wtype = 4, mod = 4, price = 1000},
		{name = "Challenger", wtype = 4, mod = 5, price = 1000},
		{name = "Dunebasher", wtype = 4, mod = 6, price = 1000},
		{name = "Fivestar", wtype = 4, mod = 7, price = 2000},
		{name = "Rockcrawler", wtype = 4, mod = 8, price = 2000},
		{name = "Milspecsteelie", wtype = 4, mod = 9, price = 2000},
		{name = "Retro Steelie", wtype = 4, mod = 10, price = 2000},
		{name = "Heavy Duty Steelie", wtype = 4, mod = 11, price = 3000},
		{name = "Concave Steelie", wtype = 4, mod = 12, price = 3000},
		{name = "Police Issue Steelie", wtype = 4, mod = 13, price = 3000},
		{name = "Lightweight Steelie", wtype = 4, mod = 14, price = 3000},
		{name = "Dukes", wtype = 4, mod = 15, price = 3000},
		{name = "Avalanche", wtype = 4, mod = 16, price = 5000},
		{name = "Mountain Man", wtype = 4, mod = 17, price = 5000},
		{name = "Ridge Climber", wtype = 4, mod = 18, price = 5000},
		{name = "Concave 5", wtype = 4, mod = 19, price = 5000},
		{name = "Flat Six", wtype = 4, mod = 20, price = 5000},
		{name = "All Terrain Monster", wtype = 4, mod = 21, price = 6000},
		{name = "Drag SPL", wtype = 4, mod = 22, price = 6000},
		{name = "Concave Rally Master", wtype = 4, mod = 23, price = 6000},
		{name = "Rugged Snowflake", wtype = 4, mod = 24, price = 6000},
	},
-----Tuner wheels------
	tunerwheels = {
		{name = "Stock", wtype = 5, mod = -1, price = 1000},
		{name = "Cosmo", wtype = 5, mod = 0, price = 1000},
		{name = "Supermesh", wtype = 5, mod = 1, price = 1000},
		{name = "Outsider", wtype = 5, mod = 2, price = 1000},
		{name = "Rollas", wtype = 5, mod = 3, price = 1000},
		{name = "Driffmeister", wtype = 5, mod = 4, price = 1000},
		{name = "Slicer", wtype = 5, mod = 5, price = 1000},
		{name = "Elquatro", wtype = 5, mod = 6, price = 1000},
		{name = "Dubbed", wtype = 5, mod = 7, price = 1000},
		{name = "Fivestar", wtype = 5, mod = 8, price = 1000},
		{name = "Slideways", wtype = 5, mod = 9, price = 1000},
		{name = "Apex", wtype = 5, mod = 10, price = 1000},
		{name = "Stancedeg", wtype = 5, mod = 11, price = 1000},
		{name = "Countersteer", wtype = 5, mod = 12, price = 1000},
		{name = "Endov1", wtype = 5, mod = 13, price = 1000},
		{name = "Endov2dish", wtype = 5, mod = 14, price = 1000},
		{name = "Guppez", wtype = 5, mod = 15, price = 1000},
		{name = "Chokadori", wtype = 5, mod = 16, price = 1000},
		{name = "Chicane", wtype = 5, mod = 17, price = 1000},
		{name = "Saisoku", wtype = 5, mod = 18, price = 1000},
		{name = "Dishedeight", wtype = 5, mod = 19, price = 1000},
		{name = "Fujiwara", wtype = 5, mod = 20, price = 1000},
		{name = "Zokusha", wtype = 5, mod = 21, price = 1000},
		{name = "Battlevill", wtype = 5, mod = 22, price = 1000},
		{name = "Rallymaster", wtype = 5, mod = 23, price = 1000},
	},
-----Highend wheels------
	highendwheels = {
		{name = "Stock", wtype = 7, mod = -1, price = 1000},
		{name = "Shadow", wtype = 7, mod = 0, price = 1000},
		{name = "Hyper", wtype = 7, mod = 1, price = 1000},
		{name = "Blade", wtype = 7, mod = 2, price = 1000},
		{name = "Diamond", wtype = 7, mod = 3, price = 1000},
		{name = "Supagee", wtype = 7, mod = 4, price = 1000},
		{name = "Chromaticz", wtype = 7, mod = 5, price = 1000},
		{name = "Merciechlip", wtype = 7, mod = 6, price = 1000},
		{name = "Obeyrs", wtype = 7, mod = 7, price = 1000},
		{name = "Gtchrome", wtype = 7, mod = 8, price = 1000},
		{name = "Cheetahr", wtype = 7, mod = 9, price = 1000},
		{name = "Solar", wtype = 7, mod = 10, price = 1000},
		{name = "Splitten", wtype = 7, mod = 11, price = 1000},
		{name = "Dashvip", wtype = 7, mod = 12, price = 1000},
		{name = "Lozspeedten", wtype = 7, mod = 13, price = 1000},
		{name = "Carboninferno", wtype = 7, mod = 14, price = 1000},
		{name = "Carbonshadow", wtype = 7, mod = 15, price = 1000},
		{name = "Carbonz", wtype = 7, mod = 16, price = 1000},
		{name = "Carbonsolar", wtype = 7, mod = 17, price = 1000},
		{name = "Carboncheetahr", wtype = 7, mod = 18, price = 1000},
		{name = "Carbonsracer", wtype = 7, mod = 19, price = 1000},
	},
-----Benny's wheels------
	bennyswheels = {
		{name = "Stock", wtype = 8, mod = -1, price = 100},
		{name = "OG Hunnets", wtype = 8, mod = 0, price = 1200},
		{name = "OG Hunnets CL", wtype = 8, mod = 1, price = 1000},
		{name = "Knock-Offs", wtype = 8, mod = 2, price = 1200},
		{name = "Knock-Offs CL", wtype = 8, mod = 3, price = 1000},
		{name = "Spoked Out", wtype = 8, mod = 4, price = 1200},
		{name = "Spoked Out CL", wtype = 8, mod = 5, price = 1000},
		{name = "Vintage Wire", wtype = 8, mod = 6, price = 1200},
		{name = "Vintage Wire CL", wtype = 8, mod = 7, price = 1000},
		{name = "Smoothie", wtype = 8, mod = 8, price = 1300},
		{name = "Smoothie CL", wtype = 8, mod = 9, price = 1200},
		{name = "Smoothie SC", wtype = 8, mod = 10, price = 1100},
		{name = "Rod Me Up", wtype = 8, mod = 11, price = 1300},
		{name = "Rod Me Up CL", wtype = 8, mod = 12, price = 1200},
		{name = "Rod Me Up SC", wtype = 8, mod = 13, price = 1100},
		{name = "Clean", wtype = 8, mod = 14, price = 7000},
		{name = "Lotta Chrome", wtype = 8, mod = 15, price = 8000},
		{name = "Spindles", wtype = 8, mod = 16, price = 8100},
		{name = "Viking", wtype = 8, mod = 17, price = 8100},
		{name = "Triple Spoke", wtype = 8, mod = 18, price = 8100},
		{name = "Pharohe", wtype = 8, mod = 19, price = 8200},
		{name = "Tiger Style", wtype = 8, mod = 20, price = 8300},
		{name = "Three Wheelin", wtype = 8, mod = 21, price = 8500},
		{name = "Big Bar", wtype = 8, mod = 22, price = 8500},
		{name = "Biohazard", wtype = 8, mod = 23, price = 8600},
		{name = "Waves", wtype = 8, mod = 24, price = 8700},
		{name = "Lick Lick", wtype = 8, mod = 25, price = 8600},
		{name = "Spiralizer", wtype = 8, mod = 26, price = 8600},
		{name = "Hypnotics", wtype = 8, mod = 27, price = 8800},
		{name = "Psycho-Delic", wtype = 8, mod = 28, price = 8900},
		{name = "Half Cut", wtype = 8, mod = 29, price = 9500},
		{name = "Super Electric", wtype = 8, mod = 30, price = 9500},
	},
----- Bespoke wheels------
	bespokewheels = {
		{name = "Stock", wtype = 9, mod = -1, price = 100},
		{name = "C OG Hunnets", wtype = 9, mod = 0, price = 8000},
		{name = "G OG Hunnets", wtype = 9, mod = 1, price = 9500},
		{name = "C Wires", wtype = 9, mod = 2, price = 8000},
		{name = "G Wires", wtype = 9, mod = 3, price = 9500},
		{name = "C Spoked Out", wtype = 9, mod = 4, price = 8000},
		{name = "G Spoked Out", wtype = 9, mod = 5, price = 9500},
		{name = "C Knock-Offs", wtype = 9, mod = 6, price = 8000},
		{name = "G Knock-Offs", wtype = 9, mod = 7, price = 9500},
		{name = "C Bigger Worm", wtype = 9, mod = 8, price = 10000},
		{name = "G Bigger Worm", wtype = 9, mod = 9, price = 12000},
		{name = "C Vintage Wire", wtype = 9, mod = 10, price = 8000},
		{name = "G Vintage Wire", wtype = 9, mod = 11, price = 9500},
		{name = "C Classic Wire", wtype = 9, mod = 12, price = 8500},
		{name = "G Classic Wire", wtype = 9, mod = 13, price = 10000},
		{name = "C Smoothie", wtype = 9, mod = 14, price = 5000},
		{name = "G Smoothie", wtype = 9, mod = 15, price = 6500},
		{name = "C Classic Rod", wtype = 9, mod = 16, price = 5000},
		{name = "G Classic Rod", wtype = 9, mod = 17, price = 6500},
		{name = "C Dollar", wtype = 9, mod = 18, price = 10000},
		{name = "G Dollar", wtype = 9, mod = 19, price = 12500},
		{name = "C Mighty Star", wtype = 9, mod = 20, price = 15000},
		{name = "G Mighty Star", wtype = 9, mod = 21, price = 17000},
		{name = "C Decadent Dish", wtype = 9, mod = 22, price = 13000},
		{name = "G Decadent Dish", wtype = 9, mod = 23, price = 17000},
		{name = "C Razor Style", wtype = 9, mod = 24, price = 15000},
		{name = "G Razor Style", wtype = 9, mod = 25, price = 18000},
		{name = "C Celtic Knot", wtype = 9, mod = 26, price = 16000},
		{name = "G Celtic Knot", wtype = 9, mod = 27, price = 19000},
		{name = "C Warrior Dish", wtype = 9, mod = 28, price = 16000},
		{name = "G Warrior Dish", wtype = 9, mod = 29, price = 20000},
		{name = "G Big Dog Spikes", wtype = 9, mod = 30, price = 25000}
	},
----- Track wheels------
	trackwheels = {
		{name = "Stock", wtype = 12, mod = -1, price = 100},
		{name = "Rim 1", wtype = 12, mod = 0, price = 3000},
		{name = "Rim 2", wtype = 12, mod = 1, price = 3000},
		{name = "Rim 3", wtype = 12, mod = 2, price = 3000},
		{name = "Rim 4", wtype = 12, mod = 3, price = 3000},
		{name = "Rim 5", wtype = 12, mod = 4, price = 3000},
		{name = "Rim 6", wtype = 12, mod = 5, price = 3000},
		{name = "Rim 7", wtype = 12, mod = 6, price = 3000},
		{name = "Rim 8", wtype = 12, mod = 7, price = 3000},
		{name = "Rim 9", wtype = 12, mod = 8, price = 3000},
		{name = "Rim 10", wtype = 12, mod = 9, price = 5000},
		{name = "Rim 11", wtype = 12, mod = 10, price = 5000},
		{name = "Rim 12", wtype = 12, mod = 11, price = 5000},
		{name = "Rim 13", wtype = 12, mod = 12, price = 5000},
		{name = "Rim 14", wtype = 12, mod = 13, price = 5000},
		{name = "Rim 15", wtype = 12, mod = 14, price = 5000},
		{name = "Rim 16", wtype = 12, mod = 15, price = 5000},
		{name = "Rim 17", wtype = 12, mod = 16, price = 5000},
		{name = "Rim 18", wtype = 12, mod = 17, price = 5000},
		{name = "Rim 19", wtype = 12, mod = 18, price = 5000},
		{name = "Rim 20", wtype = 12, mod = 19, price = 5000},
		{name = "Rim 21", wtype = 12, mod = 20, price = 5000},
		{name = "Rim 22", wtype = 12, mod = 21, price = 5000},
		{name = "Rim 23", wtype = 12, mod = 22, price = 5000},
		{name = "Rim 24", wtype = 12, mod = 23, price = 5000},
		{name = "Rim 25", wtype = 12, mod = 24, price = 10000},
		{name = "Rim 26", wtype = 12, mod = 25, price = 10000},
		{name = "Rim 27", wtype = 12, mod = 26, price = 10000},
		{name = "Rim 28", wtype = 12, mod = 27, price = 10000},
		{name = "Rim 29", wtype = 12, mod = 28, price = 10000},
		{name = "Rim 30", wtype = 12, mod = 29, price = 10000},
	},
-- Street Wheels --
	streetwheels = {
		{name = "Stock", wtype = 11, mod = -1, price = 3000},
		{name = "Rim #1", wtype = 11, mod = 0, price = 3000},
		{name = "Rim #2", wtype = 11, mod = 1, price = 3000},
		{name = "Rim #3", wtype = 11, mod = 2, price = 3000},
		{name = "Rim #4", wtype = 11, mod = 3, price = 3000},
		{name = "Rim #5", wtype = 11, mod = 4, price = 3000},
		{name = "Rim #6", wtype = 11, mod = 5, price = 3000},
		{name = "Rim #7", wtype = 11, mod = 6, price = 3000},
		{name = "Rim #8", wtype = 11, mod = 7, price = 3000},
		{name = "Rim #9", wtype = 11, mod = 8, price = 5000},
		{name = "Rim #10", wtype = 11, mod = 9, price = 5000},
		{name = "Rim #11", wtype = 11, mod = 10, price = 5000},
		{name = "Rim #12", wtype = 11, mod = 11, price = 5000},
		{name = "Rim #13", wtype = 11, mod = 12, price = 5000},
		{name = "Rim #14", wtype = 11, mod = 13, price = 5000},
		{name = "Rim #15", wtype = 11, mod = 14, price = 5000},
		{name = "Rim #16", wtype = 11, mod = 15, price = 5000},
		{name = "Rim #17", wtype = 11, mod = 16, price = 5000},
		{name = "Rim #18", wtype = 11, mod = 17, price = 5000},
		{name = "Rim #19", wtype = 11, mod = 18, price = 5000},
		{name = "Rim #20", wtype = 11, mod = 19, price = 7000},
		{name = "Rim #21", wtype = 11, mod = 20, price = 7000},
		{name = "Rim #22", wtype = 11, mod = 21, price = 7000},
		{name = "Rim #23", wtype = 11, mod = 22, price = 7000},
		{name = "Rim #24", wtype = 11, mod = 23, price = 7000},
		{name = "Rim #25", wtype = 11, mod = 24, price = 7000},
		{name = "Rim #26", wtype = 11, mod = 25, price = 10000},
		{name = "Rim #27", wtype = 11, mod = 26, price = 10000},
		{name = "Rim #28", wtype = 11, mod = 27, price = 10000},
		{name = "Rim #29", wtype = 11, mod = 28, price = 10000},
		{name = "Rim #30", wtype = 11, mod = 29, price = 10000},
	},
-----Lowrider wheels------
	lowriderwheels = {
		{name = "Stock", wtype = 2, mod = -1, price = 1000},
		{name = "Flare", wtype = 2, mod = 0, price = 1000},
		{name = "Wired", wtype = 2, mod = 1, price = 1000},
		{name = "Triplegolds", wtype = 2, mod = 2, price = 1000},
		{name = "Bigworm", wtype = 2, mod = 3, price = 1000},
		{name = "Sevenfives", wtype = 2, mod = 4, price = 1000},
		{name = "Splitsix", wtype = 2, mod = 5, price = 1000},
		{name = "Freshmesh", wtype = 2, mod = 6, price = 1000},
		{name = "Leadsled", wtype = 2, mod = 7, price = 1000},
		{name = "Turbine", wtype = 2, mod = 8, price = 1000},
		{name = "Superfin", wtype = 2, mod = 9, price = 1000},
		{name = "Classicrod", wtype = 2, mod = 10, price = 1000},
		{name = "Dollar", wtype = 2, mod = 11, price = 1000},
		{name = "Dukes", wtype = 2, mod = 12, price = 1000},
		{name = "Lowfive", wtype = 2, mod = 13, price = 1000},
		{name = "Gooch", wtype = 2, mod = 14, price = 1000},
	},
-----Muscle wheels-----
	musclewheels = {
		{name = "Stock", wtype = 1, mod = -1, price = 1000},
		{name = "Classicfive", wtype = 1, mod = 0, price = 1000},
		{name = "Dukes", wtype = 1, mod = 1, price = 1000},
		{name = "Musclefreak", wtype = 1, mod = 2, price = 1000},
		{name = "Kracka", wtype = 1, mod = 3, price = 1000},
		{name = "Azrea", wtype = 1, mod = 4, price = 1000},
		{name = "Mecha", wtype = 1, mod = 5, price = 1000},
		{name = "Blacktop", wtype = 1, mod = 6, price = 1000},
		{name = "Dragspl", wtype = 1, mod = 7, price = 1000},
		{name = "Revolver", wtype = 1, mod = 8, price = 1000},
		{name = "Classicrod", wtype = 1, mod = 9, price = 1000},
		{name = "Spooner", wtype = 1, mod = 10, price = 1000},
		{name = "Fivestar", wtype = 1, mod = 11, price = 1000},
		{name = "Oldschool", wtype = 1, mod = 12, price = 1000},
		{name = "Eljefe", wtype = 1, mod = 13, price = 1000},
		{name = "Dodman", wtype = 1, mod = 14, price = 1000},
		{name = "Sixgun", wtype = 1, mod = 15, price = 1000},
		{name = "Mercenary", wtype = 1, mod = 16, price = 1000},
	},

---------Trim color--------
	trim = {
		colors = colors,
		price = 1000
	},

----------Mods-----------
	mods = {

----------Liveries--------
	[48] = {
		startprice = 6000,
		increaseby = 1000
	},

----------Windows--------
	[46] = {
 		startprice = 2000,
		increaseby = 550
	},

----------Tank--------
	[45] = {
		startprice = 3000,
		increaseby = 750
	},

----------Trim--------
	[44] = {
		startprice = 3000,
		increaseby = 750
	},

----------Aerials--------
	[43] = {
		startprice = 3000,
		increaseby = 750
	},

----------Arch cover--------
	[42] = {
		startprice = 3000,
		increaseby = 750
	},

----------Struts--------
	[41] = {
		startprice = 3000,
		increaseby = 750
	},

----------Air filter--------
	[40] = {
		startprice = 3000,
		increaseby = 750
	},

----------Engine block--------
	[39] = {
		startprice = 3000,
		increaseby = 750
	},

----------Hydraulics--------
	[38] = {
		startprice = 8000,
		increaseby = 1500
	},

----------Trunk--------
	[37] = {
		startprice = 3000,
		increaseby = 750
	},

----------Speakers--------
	[36] = {
		startprice = 3000,
		increaseby = 750
	},

----------Plaques--------
	[35] = {
		startprice = 3000,
		increaseby = 750
	},

----------Shift leavers--------
	[34] = {
		startprice = 1000,
		increaseby = 250
	},

----------Steeringwheel--------
	[33] = {
		startprice = 1500,
		increaseby = 450
	},

----------Seats--------
	[32] = {
		startprice = 2000,
		increaseby = 550
	},

----------Door speaker--------
	[31] = {
		startprice = 2000,
		increaseby = 550
	},

----------Dial--------
	[30] = {
		startprice = 3000,
		increaseby = 750
	},
----------Dashboard--------
	[29] = {
		startprice = 3000,
		increaseby = 750
	},

----------Ornaments--------
	[28] = {
		startprice = 1000,
		increaseby = 350
	},

----------Trim--------
	[27] = {
		startprice = 3000,
		increaseby = 750
	},

----------Vanity plates--------
	[26] = {
		startprice = 3000,
		increaseby = 750
	},

----------Plate holder--------
	[25] = {
		startprice = 1000,
		increaseby = 250
	},

---------Headlights---------
--[[
	[22] = {
		{name = "Stock Lights", mod = 0, price = 0},
		{name = "Xenon Lights", mod = 1, price = 1625},
	},
	--]]

----------Turbo---------
	[18] = {
		{ name = "None", mod = 0, price = 0},
		{ name = "Turbo Tuning", mod = 1, price = 10000},
	},

-----------Armor-------------
	[16] = {
		{name = "Armor Upgrade 20%",modtype = 16, mod = 0, price = 12000}
		--{name = "Armor Upgrade 40%",modtype = 16, mod = 1, price = 5000},
		--{name = "Armor Upgrade 60%",modtype = 16, mod = 2, price = 7500},
		--{name = "Armor Upgrade 80%",modtype = 16, mod = 3, price = 10000},
		--{name = "Armor Upgrade 100%",modtype = 16, mod = 4, price = 12500},
	},

---------Suspension-----------
	[15] = {
		{name = "Lowered Suspension",mod = 0, price = 1000},
		{name = "Street Suspension",mod = 1, price = 2000},
		{name = "Sport Suspension",mod = 2, price = 3000},
		{name = "Competition Suspension",mod = 3, price = 4000},
	},

-----------Horn----------
	[14] = {
		{name = "Truck Horn", mod = 0, price = 925},
		{name = "Clown Horn", mod = 2, price = 3500},
		{name = "Musical Horn 1", mod = 3, price = 1375},
		{name = "Musical Horn 2", mod = 4, price = 1375},
		{name = "Musical Horn 3", mod = 5, price = 1375},
		{name = "Musical Horn 4", mod = 6, price = 1375},
		{name = "Musical Horn 5", mod = 7, price = 1375},
		{name = "Sadtrombone Horn", mod = 8, price = 1375},
		{name = "Classical Horn 1", mod = 9, price = 1375},
		{name = "Classical Horn 2", mod = 10, price = 1375},
		{name = "Classical Horn 3", mod = 11, price = 1375},
		{name = "Classical Horn 4", mod = 12, price = 1375},
		{name = "Classical Horn 5", mod = 13, price = 1375},
		{name = "Classical Horn 6", mod = 14, price = 1375},
		{name = "Classical Horn 7", mod = 15, price = 1375},
		{name = "Scaledo Horn", mod = 16, price = 1375},
		{name = "Scalere Horn", mod = 17, price = 1375},
		{name = "Scalemi Horn", mod = 18, price = 1375},
		{name = "Scalefa Horn", mod = 19, price = 1375},
		{name = "Scalesol Horn", mod = 20, price = 1375},
		{name = "Scalela Horn", mod = 21, price = 1375},
		{name = "Scaleti Horn", mod = 22, price = 1375},
		{name = "Scaledo Horn High", mod = 23, price = 1375},
		{name = "Jazz Horn 1", mod = 25, price = 1375},
		{name = "Jazz Horn 2", mod = 26, price = 1375},
		{name = "Jazz Horn 3", mod = 27, price = 1375},
		{name = "Jazzloop Horn", mod = 28, price = 1375},
		{name = "Starspangban Horn 1", mod = 29, price = 1375},
		{name = "Starspangban Horn 2", mod = 30, price = 1375},
		{name = "Starspangban Horn 3", mod = 31, price = 1375},
		{name = "Starspangban Horn 4", mod = 32, price = 1375},
		{name = "Classicalloop Horn 1", mod = 33, price = 1375},
		{name = "Classicalloop Horn 2", mod = 34, price = 1375},
		{name = "Classicalloop Horn 3", mod = 35, price = 1375},
	},

----------Transmission---------
	[13] = {
		{name = "Street Transmission", mod = 0, price = 3500},
		{name = "Sports Transmission", mod = 1, price = 6500},
		{name = "Race Transmission", mod = 2, price = 10000},
	},

-----------Brakes-------------
	[12] = {
		{name = "Street Brakes", mod = 0, price = 1500},
		{name = "Sport Brakes", mod = 1, price = 3500},
		{name = "Race Brakes", mod = 2, price = 5500},
	},

------------Engine----------
	[11] = {
		{name = "EMS Upgrade, Level 2", mod = 0, price = 6000},
		{name = "EMS Upgrade, Level 3", mod = 1, price = 9000},
		{name = "EMS Upgrade, Level 4", mod = 2, price = 12000},
	},

-------------Roof----------
	[10] = {
		startprice = 600,
		increaseby = 400
	},

------------Fenders---------
	[8] = {
		startprice = 500,
		increaseby = 400
	},
	[9] = {
		startprice = 500,
		increaseby = 400
	},
------------Hood----------
	[7] = {
		startprice = 800,
		increaseby = 400
	},

----------Grille----------
	[6] = {
		startprice = 500,
		increaseby = 400
	},

----------Roll cage----------
	[5] = {
		startprice = 600,
		increaseby = 400
	},

----------Exhaust----------
	[4] = {
		startprice = 750,
		increaseby = 400
	},

----------Skirts----------
	[3] = {
		startprice = 300,
		increaseby = 400
	},

-----------Rear bumpers----------
	[2] = {
		startprice = 600,
		increaseby = 500
	},

----------Front bumpers----------
	[1] = {
		startprice = 600,
		increaseby = 500
	},

----------Spoiler----------
	[0] = {
		startprice = 1500,
		increaseby = 400
	},
	}

}

------Model Blacklist--------
--Does'nt allow specific vehicles to be upgraded
LSC_Config.ModelBlacklist = {
	--"police",
}

--Sets if garage will be locked if someone is inside it already
LSC_Config.lock = true

--Enable/disable old entering way
LSC_Config.oldenter = false

--Menu settings
LSC_Config.menu = {

-------Controls--------
	controls = {
		menu_up = 27,
		menu_down = 173,
		menu_left = 174,
		menu_right = 175,
		menu_select = 201,
		menu_back = 177
	},

-------Menu position-----
	--Possible positions:
	--Left
	--Right
	--Custom position, example: position = {x = 0.2, y = 0.2}
	position = "left",

-------Menu theme--------
	--Possible themes: light, darkred, bluish, greenish
	--Custom example:
	--[[theme = {
		text_color = { r = 255,g = 255, b = 255, a = 255},
		bg_color = { r = 0,g = 0, b = 0, a = 155},
		--Colors when button is selected
		stext_color = { r = 0,g = 0, b = 0, a = 255},
		sbg_color = { r = 255,g = 255, b = 0, a = 200},
	},]]
	theme = "light",

--------Max buttons------
	--Default: 10
	maxbuttons = 10,

-------Size---------
	--[[
	Default:
	width = 0.24
	height = 0.36
	]]
	width = 0.24,
	height = 0.36

}
