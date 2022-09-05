local ITEMS = {
    { name = "Large Firework", type = "misc", price = 2000, legality = "legal", quantity = 5, weight = 15, objectModel = "ind_prop_firework_03" },
    { name = "Firework Gun", type = "weapon", hash = 2138347493, price = 5000, legality = "legal", quantity = 1, weight = 35, objectModel = "w_lr_firework" },
    { name = "Firework Projectile", legality = "legal", type = "ammo", price = 400, weight = 15, quantity = 1 },
    { name = "Vape", price = 400, type = "misc", quantity = 1, legality = "legal", weight = 3, objectModel = "ba_prop_battle_vape_01", blockedInPrison = true},
    { name = "Speaker", price = 5000, legality = "legal", quantity = 1, type = "misc", weight = 20, objectModel = "sm_prop_smug_speaker" },
    { name = "Katana", hash = GetHashKey("WEAPON_KATANAS"), type = "weapon", legality = "legal", price = 3000, weight = 10, quantity = 1, objectModel = "w_me_katana_lr"},
    { name = "Ninja Star", type = "weapon", hash = GetHashKey("WEAPON_NINJASTAR"), weight = 5.0, quantity = 1 },
	{ name = "Ninja Star 2", type = "weapon", hash = GetHashKey("WEAPON_NINJASTAR2"), weight = 5.0, quantity = 1 },
    { name = "Rock", type = "weapon", hash = GetHashKey("WEAPON_ROCK"), weight = 5.0, quantity = 1 },
    { name = "Bat", type = "weapon", hash = GetHashKey("WEAPON_BAT"), weight = 15.0, quantity = 1 },
    { name = "The Bleeder", price = 20, type = "food", substance = 60.0, quantity = 1, legality = "legal", weight = 2, objectModel = "prop_food_burg1" },
    { name = "Heart Stopper", price = 40, type = "food", substance = 100.0, quantity = 1, legality = "legal", weight = 4, objectModel = "prop_food_burg2" },
    { name = "Foot Long Dog", price = 25, type = "food", substance = 70.0, quantity = 1, legality = "legal", weight = 3, objectModel = "prop_cs_hotdog_02" },
    { name = "Veggie Gasm Burger", price = 35, type = "food", substance = 85.0, quantity = 1, legality = "legal", weight = 3, objectModel = "prop_food_burg2" },
    { name = "Torpedo Sandwich", price = 15, type = "food", substance = 55.0, quantity = 1, legality = "legal", weight = 3, objectModel = "prop_sandwich_01" },
    {name = "Doughnuts", price = 10, type = "food", substance = 25.0, quantity = 1, legality = "legal", weight = 2, objectModel = "prop_donut_01"},
    {name = "Chicken Nuggets", price = 8, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 3, objectModel = "prop_food_cb_nugets"},
    {name = "Fried Chicken Burger", price = 20, type = "food", substance = 40.0, quantity = 1, legality = "legal", weight = 2, objectModel = "prop_food_cb_burg01"},
    {name = "Fries", price = 10, type = "food", substance = 20.0, quantity = 1, legality = "legal", weight = 2, objectModel = "prop_food_chips"},
    {name = "Curly Fries", price = 5, type = "food", substance = 12.0, quantity = 1, legality = "legal", weight = 2, objectModel = "prop_food_chips"},
    {name = "Pepsi", price = 15, type = "drink", substance = 75.0, quantity = 1, legality = "legal", weight = 1, objectModel = "ng_proc_sodacan_01b"},
    {name = "Orange Fanta", price = 15, type = "drink", substance = 60.0, quantity = 1, legality = "legal", weight = 1, objectModel = "ng_proc_sodacan_01b"},
    {name = "Dr Pepper", price = 15, type = "drink", substance = 70.0, quantity = 1, legality = "legal", weight = 1, objectModel = "ng_proc_sodacan_01b"},
    {name = "Smoothie Special", price = 40, type = "drink", substance = 100.0, quantity = 1, legality = "legal", weight = 1, objectModel = "ng_proc_sodacan_01b"},
    {name = "Orange", price = 5, type = "food", substance = 5.0, quantity = 1, legality = "legal", weight = 2},
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
    { name = "Hugh", type = "tradingCard", src = { front = 'Hugh.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Izzy", type = "tradingCard", src = { front = 'Izzy.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Jay", type = "tradingCard", src = { front = 'jAY.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Jim", type = "tradingCard", src = { front = 'Jim.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Johnny", type = "tradingCard", src = { front = 'Johnny.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Jose", type = "tradingCard", src = { front = 'Jose.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Junior", type = "tradingCard", src = { front = 'Junior.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Kacee", type = "tradingCard", src = { front = 'Kacee.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Karen", type = "tradingCard", src = { front = 'Karen.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Knight", type = "tradingCard", src = { front = 'kNIGHT.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Leo", type = "tradingCard", src = { front = 'Leo.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Luke", type = "tradingCard", src = { front = 'Luke.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Morrigan", type = "tradingCard", src = { front = 'Morrigan.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "MPD Ricky", type = "tradingCard", src = { front = 'MPDRicky.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Murphy", type = "tradingCard", src = { front = 'Murphy.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Myst", type = "tradingCard", src = { front = 'Myst.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Nessa", type = "tradingCard", src = { front = 'NessaFinal.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Nessa Smile", type = "tradingCard", src = { front = 'NessaSmile.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Nick", type = "tradingCard", src = { front = 'Nick.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Nate", type = "tradingCard", src = { front = 'NNate.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Owgee", type = "tradingCard", src = { front = 'OWGEE_CARD_2.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Prison", type = "tradingCard", src = { front = 'Prison.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Richard", type = "tradingCard", src = { front = 'Richard.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Ricky", type = "tradingCard", src = { front = 'Ricky.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Sammie", type = "tradingCard", src = { front = 'Sammie.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Sammy", type = "tradingCard", src = { front = 'Sammy.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Sarah", type = "tradingCard", src = { front = 'Sarah.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Simon", type = "tradingCard", src = { front = 'Simon.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Snow", type = "tradingCard", src = { front = 'Snow.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Stacks", type = "tradingCard", src = { front = 'Stacks.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Tommy", type = "tradingCard", src = { front = 'Tommy.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Willy", type = "tradingCard", src = { front = 'Willy.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Zack", type = "tradingCard", src = { front = 'Zack.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Zeke", type = "tradingCard", src = { front = 'Zeke.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
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
    { name = "The Joker", type = "tradingCard", src = { front = 'joker.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Narlee", type = "tradingCard", src = { front = 'narlee.png', back = 'backcard.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Red Eyes B. Dragon", type = "tradingCard", src = { front = 'red-eyes-black-dragon.jpg', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Dark Magician", type = "tradingCard", src = { front = 'dark-magician.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Blue Eyes White Dragon", type = "tradingCard", src = { front = 'blue-eyes-white-dragon.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Dark Magician Girl", type = "tradingCard", src = { front = 'dark-magician-girl.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Exodia Head", type = "tradingCard", src = { front = 'exodia.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Shooting Magestic Star Dragon", type = "tradingCard", src = { front = 'shooting-magestic-star-dragon.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
    { name = "Toon Blue Eyes Dragon", type = "tradingCard", src = { front = 'toon-blue-eye-dragon.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
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


for i = 1, #ITEMS do
    if ITEMS[i].type and ITEMS[i].type == "weapon" then
        ITEMS[i].notStackable = true
    end
end

exports("getItem", function(name)
    for i = 1, #ITEMS do
        if ITEMS[i].name == name then
            return json.decode(json.encode(ITEMS[i]))
        end
    end
end)

exports("getItemWithFieldVal", function(name, field, val)
    for i = 1, #ITEMS do
        if ITEMS[i].name == name then
            if ITEMS[i][field] and ITEMS[i][field] == val then
                return json.decode(json.encode(ITEMS[i]))
            end
        end
    end
end)

exports("getAllItemsByFieldVal", function(field, val)
    local ret = {}
    for i = 1, #ITEMS do
        if ITEMS[i][field] and ITEMS[i][field] == val then
            local itemCopy = json.decode(json.encode(ITEMS[i]))
            table.insert(ret, itemCopy)
        end
    end
    return ret
end)