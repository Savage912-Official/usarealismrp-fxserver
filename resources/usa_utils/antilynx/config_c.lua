-- LCAC 8 config
--Rememeber to configure your config.lua, if it give errors , lags or problems is your fault!!
Config = {}
LXC = {}
Config.Version=8 -- DO NOT TOUCH!
LXC.Eula="pufuleti"
LXC.Configurated=true
LXC.SW = true -- Master Switch (Set it to false to disable LCAC Client Sided protection...)


----LOGS----
LXC.CLogger = true -- LOG on CONSOLE when someone get detected / kicked / banned (recommended)
LXC.DLogger = true -- LOG on DISCORD when someone get detected / kicked / banned (recommended)
LXC.CLogger = false -- LOG on INGAME CHAT when someone get detected / kicked / banned (optional)
LXC.ViolationDetectedMSG = "YOU WERE BANNED\nNICE"
LXC.BanOnKick = true -- AUTOMATICALLY BAN A DETECTED USER (optional, for lazy people) #can be unstable
LXC.AdminMenuKey = 178 -- INSERT

----Godmode----
LXC.AGod = false -- DO NOT USE ON VRP
LXC.MaxPlayerHealth = 200 -- Set the max health on your server (default is 200)
LXC.GodCheckTimer = 30000 -- Every 30s the player get a full godmode check

----General----
LXC.ACheat = false -- General shit, "AntiInvincible, AntiInfiniteAmmo, etc."
LXC.ASpectate = true -- HIGHLY RECOMMENDED
LXC.ABlips = false  -- HIGHLY RECOMMENDED
LXC.PlayerProtection = true -- FIRE AND EXPLOSIONS (this only protect your players from being damaged by explosions or fire)

LXC.ASpeedHack = false -- On foot (not falling) anti speed hack (optional)
LXC.SpeedHackValue = 10.0 -- MAX SPEED ALLOWED FOR WALKING/RUNNING/SWIMMING from 0.0 to 99.0

LXC.TriggerKick = false -- Use this only if you windows.bat/replace.py your files, HIGHLY RECOMMENDED
LXC.ChatKick = true -- Kick a player if says something blacklisted (cheat stuff,links,etc.) HIGHLY RECOMMENDED

--Explosion Event-- Thanks to YourMumXD for helping me
LXC.ExplosionsList = {
    [0] = { name = "Grenade", log = false, ban = false },
    [1] = { name = "GrenadeLauncher", log = true, ban = false },
    [3] = { name = "Molotov", log = true, ban = false },
    [4] = { name = "Rocket", log = true, ban = false },
    [5] = { name = "TankShell", log = true, ban = false},
    [6] = { name = "Hi_Octane", log = true, ban = false },
    [7] = { name = "Car", log = true, ban = false },
    [8] = { name = "Plance", log = true, ban = false },
    [9] = { name = "PetrolPump", log = true, ban = false },
    [10] = { name = "Bike", log = true, ban = false },
    [11] = { name = "Dir_Steam", log = true, ban = false },
    [12] = { name = "Dir_Flame", log = true, ban = false },
    [13] = { name = "Dir_Water_Hydrant", log = false, ban = false },
    [14] = { name = "Dir_Gas_Canister", log = true, ban = false },
    [15] = { name = "Boat", log = true, ban = false },
    [16] = { name = "Ship_Destroy", log = true, ban = false },
    [17] = { name = "Truck", log = true, ban = false },
    [18] = { name = "Bullet", log = true, ban = true },
    [19] = { name = "SmokeGrenadeLauncher", log = true, ban = false },
    [20] = { name = "SmokeGrenade", log = true, ban = false },
    [21] = { name = "BZGAS", log = false, ban = false },
    [22] = { name = "Flare", log = false, ban = false },
    [23] = { name = "Gas_Canister", log = true, ban = false },
    [24] = { name = "Extinguisher", log = true, ban = false },
    [25] = { name = "Programmablear", ban = false },
    [26] = { name = "Train", log = true, ban = false },
    [27] = { name = "Barrel", log = true, ban = false },
    [28] = { name = "PROPANE", log = true, ban = false },
    [29] = { name = "Blimp", log = true, ban = false },
    [30] = { name = "Dir_Flame_Explode", log = true, ban = false },
    [31] = { name = "Tanker", log = true, ban = false },
    [32] = { name = "PlaneRocket", log = true, ban = false },
    [33] = { name = "VehicleBullet", ban = false },
    [34] = { name = "Gas_Tank", log = true, ban = false },
    [35] = { name = "FireWork", log = true, ban = false },
    [36] = { name = "SnowBall", log = true, ban = false },
    [37] = { name = "ProxMine", log = true, ban = false },
    [38] = { name = "Valkyrie_Cannon", log = true, ban = false }
}

LXC.DetectExplosions = true -- ONESYNC ONLY!! Detects explosions and cancel them.

---Injection methods BE CAREFUL---

LXC.NRCMethod = true -- Resource counter
LXC.RSIMethod = true -- Detects any random string resource injection
LXC.ARRMethod = false -- Anti-Resource-Restart , this detect any resource restart/start , good for shit executors... (use as your own risk)
LXC.ARSMethod = true -- Anti-Resource-Stop, this detect any resource stop, good to stop cheaters from blocking anticheats or scripts... (use as your own risk)
LXC.AVHCMethod = true -- Detects Cheat Engine Vehicle Hash Changer

---------------Blacklisted Commands------------------------

LXC.ABCmds = false -- Detects less cheats but works on all servers
LXC.ABCmdsGlobal = false -- Detects more cheats but not working on all servers

---------------Blacklisted Weapons-----------------
--Thanks to YourMumXD for helping me
LXC.WeaponDamages = {
    [-1357824103] = 34, -- AdvancedRifle
    [453432689] = 26, -- Pistol
    [1593441988] = 27, -- CombatPistol
    [584646201] = 25, -- APPistol
    [-1716589765] = 51, -- Pistol50
    [-1045183535] = 160, -- Revolver
    [-1076751822] = 28, -- SNSPistol
    [-771403250] = 40, -- HeavyPistol
    [137902532] = 34, -- VintagePistol
    [324215364] = 21, -- MicroSMG
    [736523883] = 22, -- SMG
    [-270015777] = 23, -- AssaultSMG
    [-1121678507] = 22, -- MiniSMG
    [-619010992] = 27, -- MachinePistol
    [171789620] = 28, -- CombatPDW
    [487013001] = 29, -- PumpShotgun
    [2017895192] = 40, -- SawnoffShotgun
    [-494615257] = 32, -- AssaultShotgun
    [-1654528753] = 14, -- BullpupShotgun
    [984333226] = 117, -- HeavyShotgun
    [-1074790547] = 30, -- AssaultRifle
    [-2084633992] = 32, -- CarbineRifle
    [-1063057011] = 32, -- SpecialCarbine
    [2132975508] = 32, -- BullpupRifle
    [1649403952] = 34, -- CompactRifle
    [-1660422300] = 40, -- MG
    [2144741730] = 45, -- CombatMG
    [1627465347] = 34, -- Gusenberg
    [100416529] = 101, -- SniperRifle
    [205991906] = 216, -- HeavySniper
    [-952879014] = 65, -- MarksmanRifle
    [1119849093] = 30, -- Minigun
    [-1466123874] = 165, -- Musket
    [911657153] = 1, -- StunGun
    [1198879012] = 10, -- FlareGun
    [-598887786] = 220, -- MarksmanPistol
    [1834241177] = 30, -- Railgun
    [-275439685] = 30, -- DoubleBarrelShotgun
    [-1746263880] = 81, -- Double Action Revolver
    [-2009644972] = 30, -- SNS Pistol Mk II
    [-879347409] = 200, -- Heavy Revolver Mk II
    [-1768145561] = 32, -- Special Carbine Mk II
    [-2066285827] = 33, -- Bullpup Rifle Mk II
    [1432025498] = 32, -- Pump Shotgun Mk II
    [1785463520] = 75, -- Marksman Rifle Mk II
    [961495388] = 40, -- Assault Rifle Mk II
    [-86904375] = 33, -- Carbine Rifle Mk II
    [-608341376] = 47, -- Combat MG Mk II
    [177293209] = 230, -- Heavy Sniper Mk II
    [-1075685676] = 32, -- Pistol Mk II
    [2024373456] = 25, -- SMG Mk II
}

-- https://forum.fivem.net/t/list-of-weapon-spawn-names-after-hours/90750
LXC.ABWeps = {
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_STINGER",
	"WEAPON_MINIGUN",
	"WEAPON_GRENADE",
	"WEAPON_FIREWORK",
	"WEAPON_BALL",
	"WEAPON_BOTTLE",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_APPISTOL",
	"WEAPON_MG",
	"WEAPON_MARKSMANRIFLE",
	--"WEAPON_FLAREGUN",
	"WEAPON_GARBAGEBAG",
	--"WEAPON_COMBATPDW",
	--"WEAPON_KNUCKLE",
	--"WEAPON_HATCHET",
	"WEAPON_RAILPISTOL",
	"WEAPON_RAILGUN",
	"WEAPON_RAYPISTOL",
	"WEAPON_RAYCARBINE",
	"WEAPON_RAYMINIGUN",
	"WEAPON_DIGISCANNER",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_SMG_MK2"
}

LXC.WeaponManipulation = true -- Masterswitch for weapon manipulation / damage etc.
LXC.ADamageChanger = true -- Detects if a user changed his weapon damage (Cheat Engine)
LXC.AExplosiveWeapons = true -- Detects if a user is using explosive ammo, or explosive melee
LXC.ABWeapons = false -- Detect and log if someone is holding a blacklisted weapon
LXC.ABWeaponsKick = false -- if the player get detected, kick him (NOT RECOMMENDED)

---------------Blacklisted Models-------------------------

LXC.AVD = false -- This bool deletes automatically blacklisted vehicles (may cause lag!! use as your risk)
LXC.AED = false -- This bool deletes automatically blacklisted entities (may cause lag!! use as your risk)
LXC.APD = false -- This bool deletes automatically blacklisted peds (may cause lag!! use as your risk)
LXC.AutomaticDeleteTimeout = 10000 -- This timeout is how often the server checks for blacklisted stuff! (1000 = 1s) (Lower = lag)

-- For string models use "" example : "cargoplane","adder","lol"
-- For Hash models DON'T USE "" example : -12345,-98712,13371337
-- DONT FORGET TO PUT , if you add more models!! USE YOUR BRAIN!

-- https://wiki.gtanet.work/index.php?title=Vehicle_Models


LXC.ANuke = true -- Detects if a player spawn a Model or Entity below (LXC.BModels, LXC.BEntities )
LXC.AModelChanger = false -- Detects if the player is using any of these models below (LXC.BPeds)

LXC.BModels = {
	"cargoplane"
}

LXC.BEntities = {
	"prop_fnclink_05crnr1",
	"xs_prop_hamburgher_wl",
	"xs_prop_plastic_bottle_wl",
	"prop_windmill_01",
	"p_spinning_anus_s",
	"stt_prop_ramp_adj_flip_m",
	"stt_prop_ramp_adj_flip_mb",
	"stt_prop_ramp_adj_flip_s",
	"stt_prop_ramp_adj_flip_sb",
	"stt_prop_ramp_adj_hloop",
	"stt_prop_ramp_adj_loop",
	"stt_prop_ramp_jump_l",
	"stt_prop_ramp_jump_m",
	"stt_prop_ramp_jump_s",
	"stt_prop_ramp_jump_xl",
	"stt_prop_ramp_jump_xs",
	"stt_prop_ramp_jump_xxl",
	"stt_prop_ramp_multi_loop_rb",
	"stt_prop_ramp_spiral_l",
	"stt_prop_ramp_spiral_l_l",
	"stt_prop_ramp_spiral_l_m",
	"stt_prop_ramp_spiral_l_s",
	"stt_prop_ramp_spiral_l_xxl",
	"stt_prop_ramp_spiral_m",
	"stt_prop_ramp_spiral_s",
    	"misc_ufo2",
	"stt_prop_ramp_spiral_xxl",
	-145066854
}

LXC.BPeds = {
	"a_m_y_mexthug_01",
	"a_c_husky",
	"a_c_cat_01",
	"a_c_boar",
	"a_c_sharkhammer",
	"a_c_coyote",
	"a_c_chimp",
	"a_c_chop",
	"a_c_cow",
	"a_c_deer",
	"a_c_dolphin",
	"a_c_fish",
	"a_c_hen",
	"a_c_humpback",
	"a_c_killerwhale",
	"a_c_mtlion",
	"a_c_pig",
	"a_c_pug",
	"a_c_rabbit_01",
	"a_c_retriever",
	"a_c_rhesus",
	"a_c_rottweiler",
	"a_c_sharktiger",
	"a_c_shepherd",
	"a_c_westy",
	"u_m_y_zombie_01"
}

---------------Permissions-------------------------DO NOT TOUCH IF YOU DON'T KNOW WHAT U'RE DOING

LXC.Bypass = {"lcacadmin","lcacmod"} --GODMODE,BLIPS,BLACKLISTEDCMDS,SPEEDHACK

LXC.OpenMenuAllowed = {"lcacadmin"}
LXC.SpectateAllowed = {"lcacadmin","lcacmod"}
LXC.ClearAreaAllowed = {"lcacadmin"}
LXC.BlipsAllowed = {"lcacadmin","lcacmod","lcacpolice"} -- ADDED LCAC POLICE BYPASS
