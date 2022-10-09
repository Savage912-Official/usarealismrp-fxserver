Config = {}

Config.WaitTime = 45 -- in minutes
Config.FindItemChance = 45 -- Chance of finding items
Config.SearchKey = 54 -- (E)

Config.DumpsterSearchItems = {
	{ name = "Pistol Parts", price = 3000, type = "weaponParts", weight = 10.0, quantity = 1 },
	{ name = "Black Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOEBLACK"), weight = 8.0, quantity = 1 },
	{ name = "Red Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOERED"), weight = 8.0, quantity = 1 },
	{ name = "Blue Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOEBLUE"), weight = 8.0, quantity = 1 },
	{ name = "Rock", type = "weapon", hash = GetHashKey("WEAPON_ROCK"), weight = 5.0, quantity = 1 },
	{ name = "Brick", type = "weapon", hash = GetHashKey("WEAPON_BRICK"), weight = 15.0, quantity = 1 },
	{ name = "Condoms", price = 5, type = "misc", quantity = 1, legality = "legal", weight = 1, objectModel = "ng_proc_candy01a" },
	{ name = "Ceramic Tubing", price = 30, type = "misc", quantity = 5, legality = "legal", weight = 5},
	{ name = "Bic Lighter", price = 10, type = "misc", quantity = 1, legality = "legal", weight = 1, objectModel = "prop_cs_pills", blockedInPrison = true},
	{ name = "First Aid Kit", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "v_ret_ta_firstaid"},
	{ name = "Large Scissors", price = 15, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "prop_cs_scissors"},
    { name = "Sturdy Rope", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 15, objectModel = "prop_devin_rope_01  "},
    { name = "Bag", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 3, objectModel = "prop_paper_bag_01"},
	{ name = 'Hotwiring Kit', type = 'misc', price = 250, legality = 'illegal', quantity = 1, weight = 10 },
	{ name = 'Lockpick', type = 'misc', price = 150, legality = 'illegal', quantity = 5, weight = 5 },
	{ name = "Large Firework", type = "misc", price = 2000, legality = "illegal", quantity = 1, weight = 25, objectModel = "ind_prop_firework_03" },
	{ name = "Aluminum Powder", legality = "legal", quantity = 1, type = "misc", weight = 4.0 },
	{ name = "Iron Oxide", legality = "legal", quantity = 5, type = "misc", weight = 8 },
	{ name = "Crumpled Paper", type = "misc", quantity = 1, legality = "legal", notStackable = true, weight = 1, objectModel = "prop_paper_ball" },
	{ name = "Black Powder", legality = "legal", quantity = 1, type = "misc", weight = 4 },
	{ name = "Metal Scraps", legality = "legal", quantity = 1, type = "misc", weight = 8 }
}

Config.dumpsterObjects = {
	218085040,
	666561306,
	-58485588,
	-206690185,
	1511880420,
	682791951
}