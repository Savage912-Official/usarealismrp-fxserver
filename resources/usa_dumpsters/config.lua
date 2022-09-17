Config = {}

Config.WaitTime = 45 -- in minutes
Config.FindItemChance = 45 -- Chance of finding items
Config.SearchKey = 54 -- (E)

Config.DumpsterSearchItems = {
	{ name = "Pistol Parts", price = 3000, type = "weaponParts", weight = 10.0, quantity = 1 },
    { name = "Stolen Goods", price = math.random(50, 300), legality = "illegal", quantity = 1, type = "misc", weight = 2.0 },
	{ name = "Black Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOEBLACK"), weight = 8.0, quantity = 1 },
	{ name = "Red Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOERED"), weight = 8.0, quantity = 1 },
	{ name = "Blue Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOEBLUE"), weight = 8.0, quantity = 1 },
	{ name = "Rock", type = "weapon", hash = GetHashKey("WEAPON_ROCK"), weight = 5.0, quantity = 1 },
	{ name = "Brick", type = "weapon", hash = GetHashKey("WEAPON_BRICK"), weight = 15.0, quantity = 1 },
	{ name = "Condoms", price = 5, type = "misc", quantity = 1, legality = "legal", weight = 1, objectModel = "ng_proc_candy01a" },
	{ name = "Cheeseburger", price = 6, type = "food", substance = 30.0, quantity = 1, legality = "legal", weight = 10.0, objectModel = "prop_cs_burger_01" },
	{ name = "Ceramic Tubing", price = 30, type = "misc", quantity = 5, legality = "legal", weight = 5},
	{ name = "Bic Lighter", price = 10, type = "misc", quantity = 1, legality = "legal", weight = 1, objectModel = "prop_cs_pills", blockedInPrison = true},
	{ name = "Water", price = 60, type = "drink", substance = 30.0, quantity = 1, legality = "legal", weight = 5, objectModel = "ba_prop_club_water_bottle" },
	{ name = "First Aid Kit", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 15, objectModel = "v_ret_ta_firstaid"},
	{ name = "Large Scissors", price = 15, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "prop_cs_scissors"},
    { name = "Sturdy Rope", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 15, objectModel = "prop_devin_rope_01  "},
    { name = "Bag", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 15, objectModel = "prop_paper_bag_01"},
	{ name = 'Hotwiring Kit', type = 'misc', price = 250, legality = 'illegal', quantity = 1, weight = 10 },
	{ name = 'Lockpick', type = 'misc', price = 150, legality = 'illegal', quantity = 10, weight = 5 },
}