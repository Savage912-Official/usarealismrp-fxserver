Config = {}

--[[ All Discord config and Entry locations are inside server/main.lua ]]--
Config.PrintCoords = 'both' -- (server | discord | both) It will print the warehouse coords on server console, Discord or both. Never on client.
Config.DefaultCoords = {1234.189, -3201.101, 5.528} -- If a player reconnects inside warehouse they will get teleported to this spot.
Config.MinCops = 4 -- Min Cops required?
Config.PoliceJobName = 'police' -- Your police job name
Config.PoliceCanRaid = true -- Police can access warehouse? They won't be able to open the crates.
Config.UseItem = true -- Use Item for Door?
Config.DoorItem = 'Cell Phone' -- item name
Config.removeDoorItem = false -- remove item?
Config.SpawnGuards = true -- It will spawn guards with weapons
Config.HackBlocks = 1 -- Number of blocks per side
Config.HackTime = 20 -- Time before hacking minigame ends
Config.CallCopsOnFail = true -- Send Police alert when failing hacking minigame?
Config.CallCopsOnSucess = true -- If hacking minigame is successful send alert?
Config.TimeBeforeAlert = 1 -- (in minutes), if CallCopsOnSucess is true we will give the player some time before calling cops
Config.CooldownTime = 60 -- (1 hour by default)
Config.Guards = {
	[1] = {
		pos = {1064.79, -3097.34, -38.99, 184.67},
		ped = 'mp_s_m_armoured_01',
		weapon = 'WEAPON_HEAVYPISTOL',
		armour = 100
	},
	[2] = {
		pos = {1055.76, -3097.55, -38.99, 176.60},
		ped = 's_m_m_armoured_02',
		weapon = 'WEAPON_PISTOL',
		armour = 100
	},
	[3] = {
		pos = {1056.69, -3107.81, -38.99, 355.67},
		ped = 'mp_s_m_armoured_01',
		weapon = 'WEAPON_PUMPSHOTGUN',
		armour = 100
	},
	[4] = {
		pos = {1064.57, -3107.53, -38.99, 358.67},
		ped = 's_m_m_armoured_02',
		weapon = 'WEAPON_PISTOL',
		armour = 100
	},
	[5] = {
		pos = {1049.6707763672, -3095.2932128906, -39.000507354736, 250.0},
		ped = 's_m_m_armoured_02',
		weapon = "WEAPON_SMG",
		armour = 100
	},
	[6] = {
		pos = {1050.3793945313, -3106.8093261719, -38.999931335449, 250.0},
		ped = "s_m_m_armoured_02",
		weapon = "WEAPON_SMG",
		armour = 100
	}
}
Config.HintBlipRadius = 350.0

-- Rewards Types = items, weapons, money
-- When player opens a crate it will randomly select one of this rewards packages
Config.Rewards = {
	[1] = {
		type = 'items',		
		reward = {
			[1] = { name = ".50 Cal Bullets", type = "ammo", price = 500, weight = 0.5, quantity = 40, legality = "legal", objectModel = "prop_ld_ammo_pack_01" },
			[2] = { name = "5.56mm Bullets", type = "ammo", price = 600, weight = 0.5, quantity = 40, legality = "legal", objectModel = "prop_ld_ammo_pack_03"  },
			[3] = { name = "7.62mm Bullets", type = "ammo", price = 600, weight = 0.5, quantity = 40, legality = "legal", objectModel = "prop_ld_ammo_pack_03" },
			[4] = { name = "9mm Bullets", type = "ammo", price = 300, weight = 0.5, quantity = 40, legality = "legal", objectModel = "prop_ld_ammo_pack_01" },
			[5] = { name = ".45 Bullets", type = "ammo", price = 375, weight = 0.5, quantity = 40, legality = "legal", objectModel = "prop_ld_ammo_pack_01" },
			[6] = { name = "Musket Ammo", type = "ammo", price = 300, weight = 0.5, quantity = 40, legality = "legal", objectModel = "prop_ld_ammo_pack_02" },
			[7] = { name = "12 Gauge Shells", type = "ammo", price = 300, weight = 0.5, quantity = 40, legality = "legal", objectModel = "prop_ld_ammo_pack_02" },
			[8] = { name = "9x18mm Bullets", type = "ammo", price = 350, weight = 0.5, quantity = 40, legality = "legal", objectModel = "prop_ld_ammo_pack_01" },
			[9] = { name = "Firework Projectile", legality = "illegal", type = "ammo", price = 400, weight = 15, quantity = 1 },
			[10] = { name = "Firework Projectile", legality = "illegal", type = "ammo", price = 400, weight = 15, quantity = 1 },
		}
	},
	[2] = {
		type = 'items',		
		reward = {
			[1] = { name = "Empty 5.56mm Mag [30]", type = "magazine", quantity = 1, price = 150, weight = 5, receives = "5.56mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
			[2] = { name = "Empty 5.56mm Mag [30]", type = "magazine", quantity = 1, price = 150, weight = 5, receives = "5.56mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
			[3] = { name = "Empty 5.56mm Mag [30]", type = "magazine", quantity = 1, price = 150, weight = 5, receives = "5.56mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
			[4] = { name = "Empty 5.56mm Mag [30]", type = "magazine", quantity = 1, price = 150, weight = 5, receives = "5.56mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
			[5] = { name = "Empty 5.56mm Mag [30]", type = "magazine", quantity = 1, price = 150, weight = 5, receives = "5.56mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
			[6] = { name = "Empty 7.62mm Mag [30]", type = "magazine", quantity = 1, price = 150, weight = 5, receives = "7.62mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
			[7] = { name = "Empty 7.62mm Mag [30]", type = "magazine", quantity = 1, price = 150, weight = 5, receives = "7.62mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
			[8] = { name = "Empty 7.62mm Mag [30]", type = "magazine", quantity = 1, price = 150, weight = 5, receives = "7.62mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
			[9] = { name = "Empty 7.62mm Mag [30]", type = "magazine", quantity = 1, price = 150, weight = 5, receives = "7.62mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
			[10] = { name = "Empty 7.62mm Mag [30]", type = "magazine", quantity = 1, price = 150, weight = 5, receives = "7.62mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
			[11] = { name = "Empty .45 Mag [30]", type = "magazine", quantity = 1, price = 150, weight = 5, receives = ".45", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_pi_heavypistol_mag2" },
			[12] = { name = "Empty 12 Gauge Shells Mag [6]", type = "magazine", quantity = 1, legality = "legal", price = 100, weight = 5, receives = "12 Gauge Shells", MAX_CAPACITY = 6, currentCapacity = 0 },
			[13] = { name = "Empty 12 Gauge Shells Mag [6]", type = "magazine", quantity = 1, legality = "legal", price = 100, weight = 5, receives = "12 Gauge Shells", MAX_CAPACITY = 6, currentCapacity = 0 },
		}
	},
	[3] = {
		type = 'items',		
		reward = {
			[1] = {name = 'Advanced Pick', type = 'illegal', price = 800, legality = 'illegal', quantity = 1, weight = 7.0},
			[2] = {name = 'Advanced Pick', type = 'illegal', price = 800, legality = 'illegal', quantity = 1, weight = 7.0},
			[3] = {name = 'Advanced Pick', type = 'illegal', price = 800, legality = 'illegal', quantity = 1, weight = 7.0},
			[4] = {name = 'Advanced Pick', type = 'illegal', price = 800, legality = 'illegal', quantity = 1, weight = 7.0},
			[5] = {name = 'Advanced Pick', type = 'illegal', price = 800, legality = 'illegal', quantity = 1, weight = 7.0},
			[6] = {name = 'Lockpick', type = 'misc', price = 150, legality = 'illegal', quantity = 1, weight = 5},
			[7] = {name = 'Lockpick', type = 'misc', price = 150, legality = 'illegal', quantity = 1, weight = 5},
			[8] = {name = 'Lockpick', type = 'misc', price = 150, legality = 'illegal', quantity = 1, weight = 5},
			[9] = {name = 'Lockpick', type = 'misc', price = 150, legality = 'illegal', quantity = 1, weight = 5},
			[10] = {name = 'Lockpick', type = 'misc', price = 150, legality = 'illegal', quantity = 1, weight = 5},
		}
	},
	[4] = {
		type = 'weapons',		
		reward = {
			[1] = { name = "Pistol Parts", type = "weaponParts", weight = 10.0, quantity = 1 },
			[2] = { name = "AP Pistol Parts", price = 20000, type = "weaponParts", weight = 15.0, quantity = 1 },
			[3] = { name = "AK-47 Parts", type = "weaponParts", weight = 45.0, quantity = 1 },
			[4] = { name = "Revolver Kit", type = "weaponParts", weight = 15.0, quantity = 1 },
			[5] = { name = "Ceramic Pistol Parts", price = 3200, type = "weaponParts", weight = 10.0, quantity = 1 },
			[6] = { name = "Marksman Pistol Parts", price = 3200, type = "weaponParts", weight = 10.0, quantity = 1 },
			[7] = { name = "Double Barrel Shotgun Parts", price = 3200, type = "weaponParts", weight = 20.0, quantity = 1 },
			[8] = { name = "Military Rifle Parts", price = 3200, type = "weaponParts", weight = 35.0, quantity = 1 },
			[9] = { name = "Combat PDW Parts", price = 3200, type = "weaponParts", weight = 25.0, quantity = 1 },
		}
	},
	[5] = {
		type = 'money',
		reward = {
			[1] = {amount = math.random(5000, 10000)}
		}
	},
	[6] = {
		type = 'items',		
		reward = {
			[1] = { name = "Empty 9mm Mag [30]", type = "magazine", quantity = 1, legality = "legal", price = 200, weight = 5, receives = "9mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_sb_gusenberg_mag1" },
			[2] = { name = "Empty .45 Mag [16]", type = "magazine", quantity = 1, legality = "legal", price = 200, weight = 5, receives = ".45", MAX_CAPACITY = 16, currentCapacity = 0, objectModel = "w_pi_heavypistol_mag2" },
			[3] = { name = "Empty 9x18mm Mag [18]", type = "magazine", quantity = 1, legality = "legal", price = 100, weight = 5, receives = "9x18mm", MAX_CAPACITY = 18, currentCapacity = 0, objectModel = "w_pi_heavypistol_mag2" },
			[4] = { name = "Empty .50 Cal Mag [9]", type = "magazine", quantity = 1, legality = "legal", price = 200, weight = 5, receives = ".50 Cal", MAX_CAPACITY = 9, currentCapacity = 0, legality = "legal", objectModel = "w_pi_combatpistol_mag1" },
			[5] = { name = "Empty 9mm Mag [12]", type = "magazine", quantity = 1, legality = "legal", price = 100, weight = 5, receives = "9mm", MAX_CAPACITY = 12, currentCapacity = 0, legality = "legal", objectModel = "w_pi_combatpistol_mag1" },
			[6] = { name = "Empty 9mm Mag [7]", type = "magazine", quantity = 1, legality = "legal", price = 100, weight = 5, receives = "9mm", MAX_CAPACITY = 7, currentCapacity = 0, legality = "legal", objectModel = "w_pi_combatpistol_mag1" },
			[7] = { name = "Empty .45 Mag [18]", type = "magazine", quantity = 1, legality = "legal", price = 200, weight = 5, receives = ".45", MAX_CAPACITY = 18, currentCapacity = 0, legality = "legal", objectModel = "w_pi_heavypistol_mag2"},
		}
	},
	[7] = {
		type = "items",
		reward = {
			[1] = { name = "Empty Glock Extended Mag", quantity = 1, type = "magazine", price = 175, weight = 7, receives = "9mm", MAX_CAPACITY = 16, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_COMBATPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_COMBATPISTOL") },
			[2] = { name = "Empty Heavy Pistol Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = ".45", MAX_CAPACITY = 36, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_HEAVYPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_HEAVYPISTOL") },
			[2] = { name = "Empty Heavy Pistol Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = ".45", MAX_CAPACITY = 36, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_HEAVYPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_HEAVYPISTOL") },
			[3] = { name = "Empty SNS Pistol Extended Mag", quantity = 1, type = "magazine", price = 200, weight = 6, receives = ".45", MAX_CAPACITY = 12, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_SNSPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_SNSPISTOL") },
			[4] = { name = "Empty Pistol Extended Mag", quantity = 1, type = "magazine", price = 300, weight = 7, receives = "9mm", MAX_CAPACITY = 16, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_PISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_PISTOL") },
			[5] = { name = "Empty Pistol .50 Extended Mag", quantity = 1, type = "magazine", price = 250, weight = 7, receives = ".50 Cal", MAX_CAPACITY = 12, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_PISTOL50_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_PISTOL50") },
			[7] = { name = "Empty SMG Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "9mm", MAX_CAPACITY = 60, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_SMG_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_SMG") },
			[8] = { name = "Empty SMG Drum Mag", quantity = 1, type = "magazine", price = 700, weight = 7, receives = "9mm", MAX_CAPACITY = 100, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_SMG_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_SMG") },
			[9] = { name = "Empty AP Pistol Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "9x18mm", MAX_CAPACITY = 36, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_APPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_APPISTOL") },
			[10] = { name = "Empty Micro SMG Extended Mag", quantity = 1, type = "magazine", price = 350, weight = 7, receives = ".45", MAX_CAPACITY = 30, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_MICROSMG_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_MICROSMG") },
			[11] = { name = "Empty Gusenberg Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = ".45", MAX_CAPACITY = 50, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_GUSENBERG_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_GUSENBERG") },
		}
	},
	[8] = {
		type = "items",
		reward = {
			[1] = { name = "Empty AK47 Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "7.62mm", MAX_CAPACITY = 60, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_ASSAULTRIFLE_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_ASSAULTRIFLE") },
            [2] = { name = "Empty AK47 Drum Mag", quantity = 1, type = "magazine", price = 700, weight = 7, receives = "7.62mm", MAX_CAPACITY = 100, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_ASSAULTRIFLE_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_ASSAULTRIFLE") },
			[3] = { name = "Empty Carbine Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "5.56mm", MAX_CAPACITY = 60, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_CARBINERIFLE_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_CARBINERIFLE") },
			[4] = { name = "Empty Carbine Box Mag", quantity = 1, type = "magazine", price = 700, weight = 7, receives = "5.56mm", MAX_CAPACITY = 100, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_CARBINERIFLE_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_CARBINERIFLE") },
			[5] = { name = "Empty Compact Rifle Extended Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "7.62mm", MAX_CAPACITY = 60, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_COMPACTRIFLE_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_COMPACTRIFLE") },
			[6] = { name = "Empty Compact Rifle Drum Mag", quantity = 1, type = "magazine", price = 700, weight = 7, receives = "7.62mm", MAX_CAPACITY = 100, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_COMPACTRIFLE_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_COMPACTRIFLE") },
			[7] = { name = "Empty Machine Pistol Extended Mag", quantity = 1, type = "magazine", price = 300, weight = 7, receives = "9mm", MAX_CAPACITY = 20, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_MACHINEPISTOL_CLIP_02", compatibleWeapon = GetHashKey("WEAPON_MACHINEPISTOL") },
			[8] = { name = "Empty Machine Pistol Drum Mag", quantity = 1, type = "magazine", price = 500, weight = 7, receives = "9mm", MAX_CAPACITY = 30, currentCapacity = 0, legality = "illegal", notStackable = true, magComponent = "COMPONENT_MACHINEPISTOL_CLIP_03", compatibleWeapon = GetHashKey("WEAPON_MACHINEPISTOL") },
		}
	},
	[9] = {
		type = 'weapons',		
		reward = {
			[1] = { name = "Assault Rifle MK2", type = "weapon", hash = `WEAPON_ASSAULTRIFLE_MK2`, quantity = 1, weight = 30, objectModel = "w_ar_assaultrifle" },
			[2] = { name = "Battle Axe", type = "weapon", hash = `WEAPON_BATTLEAXE`, quantity = 1, weight = 15, objectModel = "prop_tool_fireaxe" },
			[3] = { name = "Compact Rifle Parts", type = "weaponParts", weight = 40.0, quantity = 1 },
		}
	},
	[10] = {
		type = 'weapons',		
		reward = {
			[1] = { name = "Calvary Dagger", type = "weapon", hash = `WEAPON_DAGGER`, quantity = 1, weight = 9, objectModel = "prop_w_me_dagger" },
			[2] = { name = "Double Barrel Shotgun", type = "weapon", hash = `WEAPON_DBSHOTGUN`, quantity = 1, weight = 25, objectModel = "w_sg_bullpupshotgun" },
			[3] = { name = "Firework Gun", type = "weapon", hash = 2138347493, price = 5000, legality = "illegal", quantity = 1, weight = 50, objectModel = "w_lr_firework" },
		}
	},
	[11] = {
		type = 'weapons',		
		reward = {
			[1] = { name = "Large Firework", type = "misc", price = 2000, legality = "illegal", quantity = 1, weight = 25, objectModel = "ind_prop_firework_03" },
			[2] = { name = "Large Firework", type = "misc", price = 2000, legality = "illegal", quantity = 1, weight = 25, objectModel = "ind_prop_firework_03" },
			[3] = { name = "Large Firework", type = "misc", price = 2000, legality = "illegal", quantity = 1, weight = 25, objectModel = "ind_prop_firework_03" },
			[4] = { name = "Large Firework", type = "misc", price = 2000, legality = "illegal", quantity = 1, weight = 25, objectModel = "ind_prop_firework_03" },
			[5] = { name = "Large Firework", type = "misc", price = 2000, legality = "illegal", quantity = 1, weight = 25, objectModel = "ind_prop_firework_03" },
		}
	},
	[12] = {
		type = 'weapons',		
		reward = {
			[1] = { name = "Tommy Gun Parts", type = "weaponParts", weight = 45.0, quantity = 1 },
			[2] = { name = "Machine Pistol Parts", type = "weaponParts", weight = 20.0, quantity = 1 },
			[3] = { name = "Micro SMG Parts", type = "weaponParts", weight = 30.0, quantity = 1 },
		}
	},
	[13] = {
		type = 'weapons',		
		reward = {
			[1] = { name = "Mini SMG", type = "weapon", hash = `WEAPON_MINISMG`, quantity = 1, weight = 25, objectModel = "w_sb_microsmg" },
			[2] = { name = "SMG Parts", type = "weaponParts", weight = 35.0, quantity = 1 },
			[3] = { name = "Tear Gas", type = "weapon", hash = `WEAPON_BZGAS`, quantity = 1, weight = 7, objectModel = "w_ex_grenadesmoke" },
		}
	},
	[14] = {
		type = "items",
		reward = {
			[1] = { name = "Sticky Bomb", type = "weapon", hash = `WEAPON_STICKYBOMB`, quantity = 1, weight = 25, objectModel = "prop_bomb_01_s" },
			[2] = { name = "Sticky Bomb", type = "weapon", hash = `WEAPON_STICKYBOMB`, quantity = 1, weight = 25, objectModel = "prop_bomb_01_s" },
			[3] = { name = "Sticky Bomb", type = "weapon", hash = `WEAPON_STICKYBOMB`, quantity = 1, weight = 25, objectModel = "prop_bomb_01_s" },
		}
	},
	[15] = {
		type = "items",
		reward = {
			[1] = {name = "Iron Oxide", legality = "legal", quantity = 5, type = "misc", weight = 8},
			[2] = {name = "Iron Oxide", legality = "legal", quantity = 5, type = "misc", weight = 8},
			[3] = {name = "Thermite", legality = "illegal", quantity = 1, type = "misc", weight = 20},
			[4] = {name = "Thermite", legality = "illegal", quantity = 1, type = "misc", weight = 20},
			[5] = {name = "Thermite", legality = "illegal", quantity = 1, type = "misc", weight = 20},
			[6] = {name = "Thermite", legality = "illegal", quantity = 1, type = "misc", weight = 20},
		}
	},
	[16] = {
		type = "items",
		reward = {
			[1] = {name = 'Hotwiring Kit', type = 'misc', legality = 'illegal', quantity = 1, weight = 10},
			[2] = {name = 'Hotwiring Kit', type = 'misc', legality = 'illegal', quantity = 1, weight = 10},
			[3] = {name = 'Hotwiring Kit', type = 'misc', legality = 'illegal', quantity = 1, weight = 10},
			[4] = {name = 'Hotwiring Kit', type = 'misc', legality = 'illegal', quantity = 1, weight = 10},
			[5] = {name = 'Hotwiring Kit', type = 'misc', legality = 'illegal', quantity = 1, weight = 10},
			[6] = {name = 'Hotwiring Kit', type = 'misc', legality = 'illegal', quantity = 1, weight = 10},
		}
	},
	[17] = {
		type = "items",
		reward = {
			[1] = {name = "Grappling Hook", legality = "legal", quantity = 1, type = "misc", weight = 25},
		}
	},
	[18] = {
		type = 'items',		
		reward = {
			[1] = { name = "Ninja Star Kit", type = "weaponParts", weight = 5.0, quantity = 3 },
			[2] = { name = "Ninja Star 2 Kit", type = "weaponParts", weight = 5.0, quantity = 3 },
			[3] = { name = "Throwing Knife", type = "weapon", hash = GetHashKey("WEAPON_THROWINGKNIFE"), weight = 8.0, quantity = 3 },
			[4] = { name = "Black Shoe", type = "weapon", hash = `WEAPON_THROWINGSHOEBLACK`, quantity = 3, weight = 8 },
			[5] = { name = "Red Shoe", type = "weapon", hash = `WEAPON_THROWINGSHOERED`, quantity = 3, weight = 8 },
			[6] = { name = "Blue Shoe", type = "weapon", hash = `WEAPON_THROWINGSHOEBLUE`, quantity = 3, weight = 8 },
			[7] = { name = "Bank Laptop", type = "misc",  quantity = 1,  legality = "legal", notStackable = true,  weight = 10,  objectModel = "imp_prop_impexp_tablet" }
		}
	},
}

Config.Lang = {
	['police_enter'] = 'Press ~r~[E]~w~ to enter property',
	['hack_door'] = 'Press ~r~[E]~w~ to hack the door',
	['open_crate'] = 'Press ~r~[E]~w~ to open crate',
	['exit'] = 'Press ~r~[E]~w~ to exit',
	['cooldown'] = 'Not able to enter right now!',
	['no_cops'] = 'Not able to enter!',
	['no_item'] = 'You need a cell phone!',
	['police_notify'] = 'Warehouse alarm activated',
	['private_property'] = 'Sorry this is private property',
	['you_stole'] = 'You found ',
	['item_limit'] = "You can't carry that much",
	['enter'] = "Press ~r~[E]~w~ to enter warehouse"
}
