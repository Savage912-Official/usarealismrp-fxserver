-------------------------
--Global Variables --
-------------------------
local CLOTHING_STORE_LOCATIONS = {
	{x = 1.27486, y = 6511.89, z = 30.8778}, -- paleto bay
	{x = 1692.24, y = 4819.79, z = 41.0631}, -- grape seed
	{x = 1199.09, y = 2707.86, z = 37.0226}, -- sandy shores 1
	{x = -1097.71, y = 2711.18, z = 18.5079}, -- route 68
	{x = 423.474, y = -808.135, z = 29.4911}, -- vinewood 6
	{x = -818.509, y = -1074.14, z = 11.0281}, -- vinewood 7
	{x = 77.7774, y = -1389.87, z = 29.0761}, -- vinewood
	{x = 105.8, y = -1302.9, z = 27.7, noblip = true}, -- vanilla unicorn
	{x = -82.16, y = -809.99, z = 243.38, noblip = true},
	{x = -454.08, y = 282.46, z = 83.06, noblip = true}, -- Comedy Club
	{x = -524.64996337891, y = -597.74438476563, z = 41.430221557617}, -- Upper Mall Store
	{x = -566.6748046875, y = -586.27526855469, z = 34.681793212891, noblip = true}, -- Lower Mall Store
	{x = -161.46296691895, y = -296.46438598633, z = 39.733383178711}, -- Las Lagunas (Ponsonbys)
	{x = 122.68245697021, y = -218.48484802246, z = 54.557693481445}, -- Hawick (Suburban)
	{x = -1193.4808349609, y = -774.20666503906, z = 17.327322006226}, -- Prosperity Street (Suburban)
	{x = -706.51391601563, y = -158.24365234375, z = 37.415245056152}, -- Portola Drive (Ponsonbys)
	{x = -1454.8980712891, y = -242.80195617676, z = 49.811031341553}, -- Cougar Ave (Ponsonbys)
	{x = -3173.408203125, y = 1049.2631835938, z = 20.86333656311}, -- Chumash (Suburban)
	{x = 619.32312011719, y = 2759.2216796875, z = 42.088272094727}, -- Route 68 (Suburban)

}
local me = nil
local mycoords = nil

local MENU_KEY = 51
_menuPool = NativeUI.CreatePool()
MainMenu = NativeUI.CreateMenu("Clothing Store", "~b~Welcome!", 0 --[[X COORD]], 320 --[[Y COORD]])
ComponentValuesMenu = NativeUI.CreateMenu("Alter Values", "~b~Change the component and component texture values.", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(MainMenu)
_menuPool:Add(ComponentValuesMenu)

local previous_menu = nil

local COMPONENTS = {"Face","Head","Hair","Arms/Hands","Legs","Back","Feet","Ties","Torso 1","Vests","Textures","Torso 2"}
local PROPS = { "Head", "Glasses", "Ear Acessories"}

local BLACKLISTED_MENU_ITEMS = {
	COMPONENTS = {
		[1] = true, -- Face
		[3] = true -- Hair
	}
}

local BLACKLISTED_ITEMS = {
	["male"] = {
		["components"] = {
			[7] = {1, 2, 3, 5, 6, 8, 16, 17, 24, 34, 35, 40, 41, 51, 71, 82, 83, 84, 151, 152, 160, 161, 162, 163, 166, 167, 168, 169}, -- ties
			[8] = {16, 17, 22, 23, 24, 25, 58, 59, 60, 63, 65, 70, 74, 76, 77, 78, 79, 86, 87, 92, 93, 118, 133, 134, 135, 136, 137, 143, 151}, -- torso 1
			[9] = {5, 7, 10, 11, 12, 14, 15, 16, 18, 20, 21, 22, 23, 24, 26, 27, 28, 31, 32, 33, 36, 37, 38, 39, 42, 43, 44, 45, 46, 47, 48, 49, 51}, -- vests
			[11] = {16, 24, 25, 34, 35, 36, 37, 38, 39, 46, 47, 57, 58, 59, 61, 131, 145, 146, 149, 150, 153, 155, 162, 165, 169, 187, 188, 189, 191, 194, 195, 207, 208, 211, 212, 213, 214, 215, 216, 217, 225, 232, 237, 266, 268, 269, 270, 280, 297, 304, 307, 314, 322, 363, 429,} -- torso 2
		},
		["props"] = {
			[0] = {8, 10, 13, 16, 17, 20, 43, 54, 56} -- head
		}
	},
	["female"] = {
		["components"] = {
			[7] = {1, 2, 3, 4, 5, 6, 8, 10, 11, 14, 23, 27, 28, 58, 62, 63, 114, 115, 121, 122, 128, 131}, -- ties
			[8] = {2, 3, 6, 8, 17, 18, 22, 23, 24, 43, 51, 54, 55, 56, 57, 58, 59, 69, 70, 72, 73, 75, 76, 77, 89, 90, 91, 102, 103, 104, 105, 129, 166, 167, 168, 173, 176, 183, 184, 185}, -- torso 1
			[9] = {7, 8, 9, 11, 12, 14, 16, 17, 18, 19, 21, 22, 24, 31, 32, 33, 40, 41, 43, 44, 47, 49, 50, 51, 56}, -- vests
			[11] = {16, 26, 34, 39, 40, 41, 42, 43, 55, 58, 59, 70, 71, 74, 116, 123, 126, 130, 131, 136, 138, 143, 145, 147, 149, 153, 189, 190, 193, 194, 195, 196, 197, 198, 199, 208, 224, 256, 258, 268, 273, 277, 284, 290, 297, 300, 307, 329, 362} -- torso 2
		},
		["props"] = {
			[0] = {8, 10, 13, 16, 17, 20, 42, 53}
		}
	}
}

------------------------------------------------------------------------------------------------------
-- Swayam's way of setting up data structures with skins, basically 3 parallel arrays --
------------------------------------------------------------------------------------------------------
local arrSkinGeneralCaptions = {
	"Abigail Mathers (CS)", "Abigail Mathers (IG)", "Abner", "African American Male", "Agent (CS)", "Agent (IG)", "Agent 14 (CS)", "Agent 14 (IG)", "Air Hostess", "Air Worker Male", "Al Di Napoli Male", "Alien", "Altruist Cult Mid-Age Male", "Altruist Cult Old Male", "Altruist Cult Old Male 2", "Altruist Cult Young Male", "Altruist Cult Young Male 2", "Amanda De Santa (CS)", "Amanda De Santa (IG)", "Ammu-Nation City Clerk", "Ammu-Nation Rural Clerk", "Anita Mendoza", "Anton Beaudelaire", "Anton Beaudelaire", "Armenian Boss", "Armenian Goon", "Armenian Goon 2", "Armenian Lieutenant", "Armoured Van Security", "Armoured Van Security", "Armoured Van Security 2", "Army Mechanic", "Ashley Butler (CS)", "Ashley Butler (IG)", "Autopsy Tech", "Autoshop Worker", "Autoshop Worker 2", "Azteca", "Baby D", "Ballas East Male", "Ballas Female", "Ballas OG", "Ballas OG (IG)", "Ballas Original Male (IG)", "Ballas South Male", "Bank Manager (CS)", "Bank Manager (IG)", "Bank Manager Male", "Barber Female", "Barman", "Barry (CS)", "Barry (IG)", "Bartender", "Bartender (Rural)", "Baywatch Female", "Baywatch Male", "Beach Female", "Beach Male", "Beach Male 2", "Beach Muscle Male", "Beach Muscle Male 2", "Beach Old Male", "Beach Tramp Female", "Beach Tramp Male", "Beach Young Female", "Beach Young Male", "Beach Young Male 2", "Beach Young Male 3", "Benny", "Best Man (IG)", "Beverly Felton (CS)", "Beverly Felton (IG)", "Beverly Hills Female", "Beverly Hills Female 2", "Beverly Hills Male", "Beverly Hills Male 2", "Beverly Hills Young Female", "Beverly Hills Young Female 2", "Beverly Hills Young Female 3", "Beverly Hills Young Female 4", "Beverly Hills Young Male", "Beverly Hills Young Male 2", "Bigfoot (CS)", "Bigfoot (IG)", "Bike Hire Guy", "Biker Chic Female", "Black Street Male", "Black Street Male 2", "Bodybuilder Female", "Bouncer", "Brad (CS)", "Brad (IG)", "Brad's Cadaver (CS)", "Breakdancer Male", "Bride", "Bride (IG)", "Burger Drug Worker", "Burger Drug Worker", "Busboy", "Business Casual", "Business Female 2", "Business Male", "Business Young Female", "Business Young Female 2", "Business Young Female 3", "Business Young Female 4", "Business Young Male", "Business Young Male 2", "Business Young Male 3", "Busker", "Car 3 Guy 1", "Car 3 Guy 1 (IG)", "Car 3 Guy 2", "Car 3 Guy 2 (IG)", "Car Buyer (CS)", "Casey (CS)", "Casey (IG)", "Chef", "Chef", "Chef (CS)", "Chef (IG)", "Chef (IG)", "Chemical Plant Security", "Chemical Plant Worker", "Chinese Boss", "Chinese Goon", "Chinese Goon", "Chinese Goon 2", "Chinese Goon Older", "Chip", "Claude Speed", "Clay Jackson (The Pain Giver) (IG)", "Clay Simons (The Lost) (CS)", "Clay Simons (The Lost) (IG)", "Cletus", "Cletus (IG)", "Clown", "Construction Worker", "Construction Worker 2", "Corpse Female", "Corpse Young Female", "Corpse Young Female 2", "Crew Member", "Cris Formage (CS)", "Cris Formage (IG)", "Customer", "Cyclist Male", "Cyclist Male", "Dale (CS)", "Dale (IG)", "Dave Norton (CS)", "Dave Norton (IG)", "Dead Hooker", "Dealer", "Debra (CS)", "Denise (CS)", "Denise (IG)", "Denise's Friend", "Devin (CS)", "Devin (IG)", "Devin's Security", "Dima Popov (CS)", "Dima Popov (IG)", "DOA Man", "Dock Worker", "Dock Worker", "Doctor", "Dom Beasley (CS)", "Dom Beasley (IG)", "Doorman", "Downhill Cyclist", "Downtown Female", "Downtown Male", "Dr. Friedlander (CS)", "Dr. Friedlander (IG)", "Dressy Female", "DW Airport Worker", "DW Airport Worker 2", "East SA Female", "East SA Female 2", "East SA Male", "East SA Male 2", "East SA Young Female", "East SA Young Female 2", "East SA Young Female 3", "East SA Young Male", "East SA Young Male 2", "Ed Toh", "Epsilon Female", "Epsilon Male", "Epsilon Male 2", "Epsilon Tom (CS)", "Epsilon Tom (IG)", "Ex-Army Male", "Ex-Mil Bum", "Fabien (CS)", "Fabien (IG)", "Factory Worker Female", "Factory Worker Male", "Families CA Male", "Families DD Male", "Families DNF Male", "Families Female", "Families FOR Male", "Families Gang Member?", "Families Gang Member? (IG)", "Farmer", "Fat Black Female", "Fat Cult Female", "Fat Latino Male", "Fat White Female", "Female Agent", "Ferdinand Kerimov (Mr. K) (CS)", "Ferdinand Kerimov (Mr. K) (IG)", "Financial Guru", "Fitness Female", "Fitness Female 2", "Floyd Hebert (CS)", "Floyd Hebert (IG)", "FOS Rep?", "Gaffer", "Garbage Worker", "Gardener", "Gay Male", "Gay Male 2", "General Fat Male", "General Fat Male 2", "General Hot Young Female", "General Street Old Female", "General Street Old Male", "General Street Young Male", "General Street Young Male 2", "Gerald", "GLENSTANK? Male", "Golfer Male", "Golfer Young Female", "Golfer Young Male", "Griff", "Grip", "Groom", "Groom (IG)", "Grove Street Dealer", "Guadalope (CS)", "Guido", "Gun Vendor", "GURK? (CS)", "Hairdresser Male", "Hao", "Hao (IG)", "Hasidic Jew Male", "Hasidic Jew Young Male", "Hick", "Hick (IG)", "High Security", "High Security 2", "Hiker Female", "Hiker Male", "Hillbilly Male", "Hillbilly Male 2", "Hippie Female", "Hippie Male", "Hippie Male", "Hipster", "Hipster (IG)", "Hipster Female", "Hipster Female 2", "Hipster Female 3", "Hipster Female 4", "Hipster Male", "Hipster Male 2", "Hipster Male 3", "Hooker", "Hooker 2", "Hooker 3", "Hot Posh Female", "Hugh Welsh", "Hunter (CS)", "Hunter (IG)", "Impotent Rage", "Imran Shinowa", "Indian Male", "Indian Old Female", "Indian Young Female", "Indian Young Male", "Jane", "Janet (CS)", "Janet (IG)", "Janitor", "Janitor", "Jay Norris (IG)", "Jesco White (Tapdancing Hillbilly)", "Jesus", "Jetskier", "Jewel Heist Driver", "Jewel Heist Gunman", "Jewel Heist Hacker", "Jewel Thief", "Jeweller Assistant", "Jeweller Assistant (CS)", "Jeweller Assistant (IG)", "Jeweller Security", "Jimmy Boston (CS)", "Jimmy Boston (IG)", "Jimmy De Santa (CS)", "Jimmy De Santa (IG)", "Jogger Female", "Jogger Male", "Jogger Male 2", "John Marston", "Johnny Klebitz (CS)", "Johnny Klebitz (IG)", "Josef (CS)", "Josef (IG)", "Josh (CS)", "Josh (IG)", "Juggalo Female", "Juggalo Male", "Justin", "Kerry McIntosh (IG)", "Kifflom Guy", "Korean Boss", "Korean Female", "Korean Female 2", "Korean Lieutenant", "Korean Male", "Korean Old Female", "Korean Old Male", "Korean Young Male", "Korean Young Male", "Korean Young Male 2", "Korean Young Male 2", "Lamar Davis (CS)", "Lamar Davis (IG)", "Latino Handyman Male", "Latino Street Male 2", "Latino Street Young Male", "Latino Young Male", "Lazlow (CS)", "Lazlow (IG)", "Lester Crest (CS)", "Lester Crest (IG)", "Life Invader (CS)", "Life Invader (IG)", "Life Invader 2 (IG)", "Life Invader Male", "Line Cook", "Love Fist Willy", "LS Metro Worker Male", "Magenta (CS)", "Magenta (IG)", "Maid", "Malibu Male", "Mani", "Manuel (CS)", "Manuel (IG)", "Mariachi", "Mark Fostenburg", "Marnie Allen (CS)", "Marnie Allen (IG)", "Martin Madrazo (CS)", "Mary-Ann Quinn (CS)", "Mary-Ann Quinn (IG)", "Maude", "Maude (IG)", "Maxim Rashkovsky (CS)", "Maxim Rashkovsky (IG)", "Mechanic", "Mechanic 2", "Merryweather Merc", "Meth Addict", "Mexican", "Mexican (IG)", "Mexican Boss", "Mexican Boss 2", "Mexican Gang Member", "Mexican Goon", "Mexican Goon 2", "Mexican Goon 3", "Mexican Labourer", "Mexican Rural", "Mexican Thug", "Michelle (CS)", "Michelle (IG)", "Migrant Female", "Migrant Male", "Milton McIlroy (CS)", "Milton McIlroy (IG)", "Mime Artist", "Minuteman Joe (CS)", "Minuteman Joe (IG)", "Miranda", "Mistress", "Misty", "Molly (CS)", "Molly (IG)", "Money Man (CS)", "Money Man (IG)", "Motocross Biker", "Motocross Biker 2", "Movie Astronaut", "Movie Director", "Movie Premiere Female", "Movie Premiere Female (CS)", "Movie Premiere Male", "Movie Premiere Male (CS)", "Movie Star Female", "Mrs. Phillips (CS)", "Mrs. Phillips (IG)", "Mrs. Thornhill (CS)", "Mrs. Thornhill (IG)", "Natalia (CS)", "Natalia (IG)", "Nervous Ron (CS)", "Nervous Ron (IG)", "Nigel (CS)", "Nigel (IG)", "Niko Bellic", "OG Boss", "Old Man 1 (CS)", "Old Man 1 (IG)", "Old Man 2 (CS)", "Old Man 2 (IG)", "Omega (CS)", "Omega (IG)", "O'Neil Brothers (IG)", "Ortega", "Ortega (IG)", "Oscar", "Paige Harris (CS)", "Paige Harris (IG)", "Paparazzi Male", "Paparazzi Young Male", "Party Target", "Partygoer", "Patricia (CS)", "Patricia (IG)", "Pest Control", "Peter Dreyfuss (CS)", "Peter Dreyfuss (IG)", "Pilot", "Pilot 2", "Pogo the Monkey", "Polynesian", "Polynesian Goon", "Polynesian Goon 2", "Polynesian Young", "Poppy Mitchell", "Porn Dude", "Postal Worker Male", "Postal Worker Male 2", "Priest (CS)", "Priest (IG)", "Princess", "Prologue Driver", "Prologue Driver", "Prologue Host Female", "Prologue Host Male", "Prologue Host Old Female", "Prologue Mourner Female", "Prologue Mourner Male", "Prologue Security", "Prologue Security", "Prologue Security 2 (CS)", "Prologue Security 2 (IG)", "PROS?", "Reporter", "Republican Space Ranger", "Rival Paparazzo", "Road Cyclist", "Robber", "Rocco Pelosi", "Rocco Pelosi (IG)", "Rural Meth Addict Female", "Rural Meth Addict Male", "Russian Drunk (CS)", "Russian Drunk (IG)", "Sales Assistant (High-End)", "Sales Assistant (Low-End)", "Sales Assistant (Mask Stall)", "Sales Assistant (Mid-Price)", "Salton Female", "Salton Male", "Salton Male 2", "Salton Male 3", "Salton Male 4", "Salton Old Female", "Salton Old Male", "Salton Young Male", "Salvadoran Boss", "Salvadoran Goon", "Salvadoran Goon 2", "Salvadoran Goon 3", "Scientist", "Screenwriter", "Screenwriter (IG)", "Security Guard", "Shopkeeper", "Simeon Yetarian (CS)", "Simeon Yetarian (IG)", "Skater Female", "Skater Male", "Skater Young Male", "Skater Young Male 2", "Skid Row Female", "Skid Row Male", "Solomon Richards (CS)", "Solomon Richards (IG)", "South Central Female", "South Central Female 2", "South Central Latino Male", "South Central Male", "South Central Male 2", "South Central Male 3", "South Central Male 4", "South Central MC Female", "South Central Old Female", "South Central Old Female 2", "South Central Old Male", "South Central Old Male 2", "South Central Old Male 3", "South Central Young Female", "South Central Young Female 2", "South Central Young Female 3", "South Central Young Male", "South Central Young Male 2", "South Central Young Male 3", "South Central Young Male 4", "Sports Biker", "Spy Actor", "Spy Actress", "Stag Party Groom", "Street Performer", "Street Preacher", "Street Punk", "Street Punk 2", "Street Vendor", "Street Vendor Young", "Stretch (CS)", "Stretch (IG)", "Stripper", "Stripper", "Stripper 2", "Stripper 2", "Stripper Lite", "Stripper Lite", "Sunbather Male", "Surfer", "Sweatshop Worker", "Sweatshop Worker Young", "Talina (IG)", "Tanisha (CS)", "Tanisha (IG)", "Tao Cheng (CS)", "Tao Cheng (IG)", "Tao's Translator (CS)", "Tao's Translator (IG)", "Tattoo Artist", "Tennis Coach (CS)", "Tennis Coach (IG)", "Tennis Player Female", "Tennis Player Male", "Terry (CS)", "Terry (IG)", "The Lost MC Female", "The Lost MC Male", "The Lost MC Male 2", "The Lost MC Male 3", "Tom (CS)", "Tonya", "Tonya (IG)", "Topless", "Tourist Female", "Tourist Male", "Tourist Young Female", "Tourist Young Female 2", "Tracey De Santa (CS)", "Tracey De Santa (IG)", "Tramp Female", "Tramp Male", "Tramp Old Male", "Tramp Old Male", "Transport Worker Male", "Transvestite Male", "Transvestite Male 2", "Trucker Male", "Tyler Dixon (IG)", "Undercover Cop", "United Paper Man (CS)", "United Paper Man (IG)", "UPS Driver", "UPS Driver 2", "US Coastguard", "Vagos Female", "Vagos Male (CS)", "Vagos Male (IG)", "Vagos Male 2", "Valet", "Vespucci Beach Male", "Vespucci Beach Male 2", "Vinewood Douche", "Vinewood Female", "Vinewood Female 2", "Vinewood Female 3", "Vinewood Female 4", "Vinewood Male", "Vinewood Male 2", "Vinewood Male 3", "Vinewood Male 4", "Wade(CS)", "Wade(IG)", "Waiter", "Wei Cheng(CS)", "Wei Cheng(IG)", "White Street Male", "White Street Male 2", "Window Cleaner", "Yoga Female", "Yoga Male", "Zimbor(CS)", "Zimbor(IG)", "Zombie", "Owgee", "Kid1", "Kid2", "Kid3"}
local arrSkinGeneralValues = {
		"csb_abigail", "ig_abigail", "u_m_y_abner", "a_m_m_afriamer_01", "csb_agent", "ig_agent", "csb_mp_agent14", "ig_mp_agent14", "s_f_y_airhostess_01", "s_m_y_airworker", "u_m_m_aldinapoli", "s_m_m_movalien_01", "a_m_m_acult_01", "a_m_o_acult_01", "a_m_o_acult_02", "a_m_y_acult_01", "a_m_y_acult_02", "cs_amandatownley", "ig_amandatownley", "s_m_y_ammucity_01", "s_m_m_ammucountry", "csb_anita", "csb_anton", "u_m_y_antonb", "g_m_m_armboss_01", "g_m_m_armgoon_01", "g_m_y_armgoon_02", "g_m_m_armlieut_01", "mp_s_m_armoured_01", "s_m_m_armoured_01", "s_m_m_armoured_02", "s_m_y_armymech_01", "cs_ashley", "ig_ashley", "s_m_y_autopsy_01", "s_m_m_autoshop_01", "s_m_m_autoshop_02", "g_m_y_azteca_01", "u_m_y_babyd", "g_m_y_ballaeast_01", "g_f_y_ballas_01", "csb_ballasog", "ig_ballasog", "g_m_y_ballaorig_01", "g_m_y_ballasout_01", "cs_bankman", "ig_bankman", "u_m_m_bankman", "s_f_m_fembarber", "s_m_y_barman_01", "cs_barry", "ig_barry", "s_f_y_bartender_01", "s_m_m_cntrybar_01", "s_f_y_baywatch_01", "s_m_y_baywatch_01", "a_f_m_beach_01", "a_m_m_beach_01", "a_m_m_beach_02", "a_m_y_musclbeac_01", "a_m_y_musclbeac_02", "a_m_o_beach_01", "a_f_m_trampbeac_01", "a_m_m_trampbeac_01", "a_f_y_beach_01", "a_m_y_beach_01", "a_m_y_beach_02", "a_m_y_beach_03", "ig_benny", "ig_bestmen", "cs_beverly", "ig_beverly", "a_f_m_bevhills_01", "a_f_m_bevhills_02", "a_m_m_bevhills_01", "a_m_m_bevhills_02", "a_f_y_bevhills_01", "a_f_y_bevhills_02", "a_f_y_bevhills_03", "a_f_y_bevhills_04", "a_m_y_bevhills_01", "a_m_y_bevhills_02", "cs_orleans", "ig_orleans", "u_m_m_bikehire_01", "u_f_y_bikerchic", "a_m_y_stbla_01", "a_m_y_stbla_02", "a_f_m_bodybuild_01", "s_m_m_bouncer_01", "cs_brad", "ig_brad", "cs_bradcadaver", "a_m_y_breakdance_01", "csb_bride", "ig_bride", "csb_burgerdrug", "u_m_y_burgerdrug_01", "s_m_y_busboy_01", "a_m_y_busicas_01", "a_f_m_business_02", "a_m_m_business_01", "a_f_y_business_01", "a_f_y_business_02", "a_f_y_business_03", "a_f_y_business_04", "a_m_y_business_01", "a_m_y_business_02", "a_m_y_business_03", "s_m_o_busker_01", "csb_car3guy1", "ig_car3guy1", "csb_car3guy2", "ig_car3guy2", "cs_carbuyer", "cs_casey", "ig_casey", "s_m_y_chef_01", "csb_chef", "csb_chef2", "ig_chef", "ig_chef2", "s_m_m_chemsec_01-REMOVE", "g_m_m_chemwork_01", "g_m_m_chiboss_01", "g_m_m_chigoon_01", "csb_chin_goon", "g_m_m_chigoon_02", "g_m_m_chicold_01", "u_m_y_chip", "mp_m_claude_01", "ig_claypain", "cs_clay", "ig_clay", "csb_cletus", "ig_cletus", "s_m_y_clown_01", "s_m_y_construct_01", "s_m_y_construct_02", "u_f_m_corpse_01", "u_f_y_corpse_01", "u_f_y_corpse_02", "s_m_m_ccrew_01", "cs_chrisformage", "ig_chrisformage", "csb_customer", "a_m_y_cyclist_01", "u_m_y_cyclist_01", "cs_dale", "ig_dale", "cs_davenorton", "ig_davenorton", "mp_f_deadhooker", "s_m_y_dealer_01", "cs_debra", "cs_denise", "ig_denise", "csb_denise_friend", "cs_devin", "ig_devin", "s_m_y_devinsec_01", "csb_popov", "ig_popov", "u_m_m_doa_01", "s_m_m_dockwork_01", "s_m_y_dockwork_01", "s_m_m_doctor_01", "cs_dom", "ig_dom", "s_m_y_doorman_01", "a_m_y_dhill_01", "a_f_m_downtown_01", "a_m_y_downtown_01", "cs_drfriedlander", "ig_drfriedlander", "a_f_y_scdressy_01", "s_m_y_dwservice_01", "s_m_y_dwservice_02", "a_f_m_eastsa_01", "a_f_m_eastsa_02", "a_m_m_eastsa_01", "a_m_m_eastsa_02", "a_f_y_eastsa_01", "a_f_y_eastsa_02", "a_f_y_eastsa_03", "a_m_y_eastsa_01", "a_m_y_eastsa_02", "u_m_m_edtoh", "a_f_y_epsilon_01", "a_m_y_epsilon_01", "a_m_y_epsilon_02", "cs_tomepsilon", "ig_tomepsilon", "mp_m_exarmy_01", "u_m_y_militarybum", "cs_fabien", "ig_fabien", "s_f_y_factory_01", "s_m_y_factory_01", "g_m_y_famca_01", "mp_m_famdd_01", "g_m_y_famdnf_01", "g_f_y_families_01", "g_m_y_famfor_01", "csb_ramp_gang", "ig_ramp_gang", "a_m_m_farmer_01", "a_f_m_fatbla_01", "a_f_m_fatcult_01", "a_m_m_fatlatin_01", "a_f_m_fatwhite_01", "a_f_y_femaleagent", "cs_mrk", "ig_mrk", "u_m_o_finguru_01", "a_f_y_fitness_01", "a_f_y_fitness_02", "cs_floyd", "ig_floyd", "csb_fos_rep", "s_m_m_gaffer_01", "s_m_y_garbage", "s_m_m_gardener_01", "a_m_y_gay_01", "a_m_y_gay_02", "a_m_m_genfat_01", "a_m_m_genfat_02", "a_f_y_genhot_01", "a_f_o_genstreet_01", "a_m_o_genstreet_01", "a_m_y_genstreet_01", "a_m_y_genstreet_02", "csb_g", "u_m_m_glenstank_01", "a_m_m_golfer_01", "a_f_y_golfer_01", "a_m_y_golfer_01", "u_m_m_griff_01", "s_m_y_grip_01", "csb_groom", "ig_groom", "csb_grove_str_dlr", "cs_guadalope", "u_m_y_guido_01", "u_m_y_gunvend_01", "cs_gurk", "s_m_m_hairdress_01", "csb_hao", "ig_hao", "a_m_m_hasjew_01", "a_m_y_hasjew_01", "csb_ramp_hic", "ig_ramp_hic", "s_m_m_highsec_01", "s_m_m_highsec_02", "a_f_y_hiker_01", "a_m_y_hiker_01", "a_m_m_hillbilly_01", "a_m_m_hillbilly_02", "a_f_y_hippie_01", "u_m_y_hippie_01", "a_m_y_hippy_01", "csb_ramp_hipster", "ig_ramp_hipster", "a_f_y_hipster_01", "a_f_y_hipster_02", "a_f_y_hipster_03", "a_f_y_hipster_04", "a_m_y_hipster_01", "a_m_y_hipster_02", "a_m_y_hipster_03", "s_f_y_hooker_01", "s_f_y_hooker_02", "s_f_y_hooker_03", "u_f_y_hotposh_01", "csb_hugh", "cs_hunter", "ig_hunter", "u_m_y_imporage", "csb_imran", "a_m_m_indian_01", "a_f_o_indian_01", "a_f_y_indian_01", "a_m_y_indian_01", "u_f_y_comjane", "cs_janet", "ig_janet", "csb_janitor", "s_m_m_janitor", "ig_jay_norris", "u_m_o_taphillbilly", "u_m_m_jesus_01", "a_m_y_jetski_01", "hc_driver", "hc_gunman", "hc_hacker", "u_m_m_jewelthief", "u_f_y_jewelass_01", "cs_jewelass", "ig_jewelass", "u_m_m_jewelsec_01", "cs_jimmyboston", "ig_jimmyboston", "cs_jimmydisanto", "ig_jimmydisanto", "a_f_y_runner_01", "a_m_y_runner_01", "a_m_y_runner_02", "mp_m_marston_01", "cs_johnnyklebitz", "ig_johnnyklebitz", "cs_josef", "ig_josef", "cs_josh", "ig_josh", "a_f_y_juggalo_01", "a_m_y_juggalo_01", "u_m_y_justin", "ig_kerrymcintosh", "u_m_y_baygor", "g_m_m_korboss_01", "a_f_m_ktown_01", "a_f_m_ktown_02", "g_m_y_korlieut_01", "a_m_m_ktown_01", "a_f_o_ktown_01", "a_m_o_ktown_01", "g_m_y_korean_01", "a_m_y_ktown_01", "g_m_y_korean_02", "a_m_y_ktown_02", "cs_lamardavis", "ig_lamardavis", "s_m_m_lathandy_01", "a_m_m_stlat_02", "a_m_y_stlat_01", "a_m_y_latino_01", "cs_lazlow", "ig_lazlow", "cs_lestercrest", "ig_lestercrest", "cs_lifeinvad_01", "ig_lifeinvad_01", "ig_lifeinvad_02", "s_m_m_lifeinvad_01", "s_m_m_linecook", "u_m_m_willyfist", "s_m_m_lsmetro_01", "cs_magenta", "ig_magenta", "s_f_m_maid_01", "a_m_m_malibu_01", "u_m_y_mani", "cs_manuel", "ig_manuel", "s_m_m_mariachi_01", "u_m_m_markfost", "cs_marnie", "ig_marnie", "cs_martinmadrazo", "cs_maryann", "ig_maryann", "csb_maude", "ig_maude", "csb_rashcosvki", "ig_rashcosvki", "s_m_y_xmech_01", "s_m_y_xmech_02", "csb_mweather", "a_m_y_methhead_01", "csb_ramp_mex", "ig_ramp_mex", "g_m_m_mexboss_01", "g_m_m_mexboss_02", "g_m_y_mexgang_01", "g_m_y_mexgoon_01", "g_m_y_mexgoon_02", "g_m_y_mexgoon_03", "a_m_m_mexlabor_01", "a_m_m_mexcntry_01", "a_m_y_mexthug_01", "cs_michelle", "ig_michelle", "s_f_y_migrant_01", "s_m_m_migrant_01", "cs_milton", "ig_milton", "s_m_y_mime", "cs_joeminuteman", "ig_joeminuteman", "u_f_m_miranda", "u_f_y_mistress", "mp_f_misty_01", "cs_molly", "ig_molly", "csb_money", "ig_money", "a_m_y_motox_01", "a_m_y_motox_02", "s_m_m_movspace_01", "u_m_m_filmdirector", "s_f_y_movprem_01", "cs_movpremf_01", "s_m_m_movprem_01", "cs_movpremmale", "u_f_o_moviestar", "cs_mrsphillips", "ig_mrsphillips", "cs_mrs_thornhill", "ig_mrs_thornhill", "cs_natalia", "ig_natalia", "cs_nervousron", "ig_nervousron", "cs_nigel", "ig_nigel", "mp_m_niko_01", "a_m_m_og_boss_01", "cs_old_man1a", "ig_old_man1a", "cs_old_man2", "ig_old_man2", "cs_omega", "ig_omega", "ig_oneil", "csb_ortega", "ig_ortega", "csb_oscar", "csb_paige", "ig_paige", "a_m_m_paparazzi_01", "u_m_y_paparazzi", "u_m_m_partytarget", "u_m_y_party_01", "cs_patricia", "ig_patricia", "s_m_y_pestcont_01", "cs_dreyfuss", "ig_dreyfuss", "s_m_m_pilot_01", "s_m_y_pilot_01", "u_m_y_pogo_01", "a_m_m_polynesian_01", "g_m_y_pologoon_01", "g_m_y_pologoon_02", "a_m_y_polynesian_01", "u_f_y_poppymich", "csb_porndudes", "s_m_m_postal_01", "s_m_m_postal_02", "cs_priest", "ig_priest", "u_f_y_princess", "u_m_y_proldriver_01", "csb_prologuedriver", "a_f_m_prolhost_01", "a_m_m_prolhost_01", "u_f_o_prolhost_01", "u_f_m_promourn_01", "u_m_m_promourn_01", "csb_prolsec", "u_m_m_prolsec_01", "cs_prolsec_02", "ig_prolsec_02", "mp_g_m_pros_01", "csb_reporter", "u_m_y_rsranger_01", "u_m_m_rivalpap", "a_m_y_roadcyc_01", "s_m_y_robber_01", "csb_roccopelosi", "ig_roccopelosi", "a_f_y_rurmeth_01", "a_m_m_rurmeth_01", "cs_russiandrunk", "ig_russiandrunk", "s_f_m_shop_high", "s_f_y_shop_low", "s_m_y_shop_mask", "s_f_y_shop_mid", "a_f_m_salton_01", "a_m_m_salton_01", "a_m_m_salton_02", "a_m_m_salton_03", "a_m_m_salton_04", "a_f_o_salton_01", "a_m_o_salton_01", "a_m_y_salton_01", "g_m_y_salvaboss_01", "g_m_y_salvagoon_01", "g_m_y_salvagoon_02", "g_m_y_salvagoon_03", "s_m_m_scientist_01", "csb_screen_writer", "ig_screen_writer", "s_m_m_security_01", "mp_m_shopkeep_01", "cs_siemonyetarian", "ig_siemonyetarian", "a_f_y_skater_01", "a_m_m_skater_01", "a_m_y_skater_01", "a_m_y_skater_02", "a_f_m_skidrow_01", "a_m_m_skidrow_01", "cs_solomon", "ig_solomon", "a_f_m_soucent_01", "a_f_m_soucent_02", "a_m_m_socenlat_01", "a_m_m_soucent_01", "a_m_m_soucent_02", "a_m_m_soucent_03", "a_m_m_soucent_04", "a_f_m_soucentmc_01", "a_f_o_soucent_01", "a_f_o_soucent_02", "a_m_o_soucent_01", "a_m_o_soucent_02", "a_m_o_soucent_03", "a_f_y_soucent_01", "a_f_y_soucent_02", "a_f_y_soucent_03", "a_m_y_soucent_01", "a_m_y_soucent_02", "a_m_y_soucent_03", "a_m_y_soucent_04", "u_m_y_sbike", "u_m_m_spyactor", "u_f_y_spyactress", "u_m_y_staggrm_01", "s_m_m_strperf_01", "s_m_m_strpreach_01", "g_m_y_strpunk_01", "g_m_y_strpunk_02", "s_m_m_strvend_01", "s_m_y_strvend_01", "cs_stretch", "ig_stretch", "csb_stripper_01", "s_f_y_stripper_01", "csb_stripper_02", "s_f_y_stripper_02", "s_f_y_stripperlite", "mp_f_stripperlite", "a_m_y_sunbathe_01", "a_m_y_surfer_01", "s_f_m_sweatshop_01", "s_f_y_sweatshop_01", "ig_talina", "cs_tanisha", "ig_tanisha", "cs_taocheng", "ig_taocheng", "cs_taostranslator", "ig_taostranslator", "u_m_y_tattoo_01", "cs_tenniscoach", "ig_tenniscoach", "a_f_y_tennis_01", "a_m_m_tennis_01", "cs_terry", "ig_terry", "g_f_y_lost_01", "g_m_y_lost_01", "g_m_y_lost_02", "g_m_y_lost_03", "cs_tom", "csb_tonya", "ig_tonya", "a_f_y_topless_01", "a_f_m_tourist_01", "a_m_m_tourist_01", "a_f_y_tourist_01", "a_f_y_tourist_02", "cs_tracydisanto", "ig_tracydisanto", "a_f_m_tramp_01", "a_m_m_tramp_01", "u_m_o_tramp_01", "a_m_o_tramp_01", "s_m_m_gentransport", "a_m_m_tranvest_01", "a_m_m_tranvest_02", "s_m_m_trucker_01", "ig_tylerdix", "csb_undercover", "cs_paper", "ig_paper", "s_m_m_ups_01", "s_m_m_ups_02", "s_m_y_uscg_01", "g_f_y_vagos_01", "csb_vagspeak", "ig_vagspeak", "mp_m_g_vagfun_01", "s_m_y_valet_01", "a_m_y_beachvesp_01", "a_m_y_beachvesp_02", "a_m_y_vindouche_01", "a_f_y_vinewood_01", "a_f_y_vinewood_02", "a_f_y_vinewood_03", "a_f_y_vinewood_04", "a_m_y_vinewood_01", "a_m_y_vinewood_02", "a_m_y_vinewood_03", "a_m_y_vinewood_04", "cs_wade", "ig_wade", "s_m_y_waiter_01", "cs_chengsr", "ig_chengsr", "a_m_y_stwhi_01", "a_m_y_stwhi_02", "s_m_y_winclean_01", "a_f_y_yoga_01", "a_m_y_yoga_01", "cs_zimbor", "ig_zimbor", "u_m_y_zombie_01", "og_boss", "m62", "mb01","mk19"}
local customPedsCaptions = {
	"Skellyy 2135's Ped",
	"Ricky Garcia's Ped"
}
local customPeds = {
	"mb59", -- Skellyy 2135
	"mk15" -- Ricky Garcia
}

local custom_peds_whitelist = {
	"steam:1100001171c5736", -- Skellyy 2135
	"steam:1100001007a8797",
	"steam:11000010e47ec63", -- Chang
	"steam:110000136d76906" -- Ricky Garcia
}

local arrSkinHashes = {}
for i=1,#arrSkinGeneralValues do
	arrSkinHashes[i] = GetHashKey(arrSkinGeneralValues[i])
end

local customPedsHashes = {}
for i=1, #customPeds do
	customPedsHashes[i] = GetHashKey(customPeds[i])
end

----------------------
---- Set up blips ----
----------------------
for i = 1, #CLOTHING_STORE_LOCATIONS do
	if not CLOTHING_STORE_LOCATIONS[i].noblip then
		TriggerEvent("usa_map_blips:addMapBlip", {CLOTHING_STORE_LOCATIONS[i].x, CLOTHING_STORE_LOCATIONS[i].y, CLOTHING_STORE_LOCATIONS[i].z}, 73, 4, 0.8, 43, true, 'Clothes Store', 'clothing_stores') --coords, sprite, display, scale, color, shortRange, name, groupName)
	end
end
-----------------
-----------------
-----------------

local lastShop = nil

RegisterNetEvent("clothing-store:openMenu")
AddEventHandler("clothing-store:openMenu", function()
	--------------------
	-- Open Menu --
	--------------------
	MainMenu:Visible(true)
end)

local nearbyClothingStores = {}

-- thread to record nearby clothing store locations as an optimization:
Citizen.CreateThread(function()
	while true do
		local mycoords = GetEntityCoords(PlayerPedId())
		for i = 1, #CLOTHING_STORE_LOCATIONS do
			if Vdist(mycoords, CLOTHING_STORE_LOCATIONS[i].x, CLOTHING_STORE_LOCATIONS[i].y, CLOTHING_STORE_LOCATIONS[i].z) < 5 then
				nearbyClothingStores[i] = true
			else
				nearbyClothingStores[i] = nil
			end
		end
		Wait(1000)
	end
end)

-- menu processing / opening --
Citizen.CreateThread(function()

	local didAskToSave = nil

	while true do
		me = GetPlayerPed(-1)
		mycoords = GetEntityCoords(me)

		-- see if close enough to open menu and handle opening --
		if  IsNearStore() then
			if not _menuPool:IsAnyMenuOpen() then
				if not previous_menu then
					if IsControlJustPressed(1, MENU_KEY)  then
						if not IsEntityDead(me) then

							------------------------------------------------------------
							-- give money to owner, subtract from customer --
							local business = exports["usa-businesses"]:GetClosestStore(15)
							TriggerServerEvent("clothing-store:chargeCustomer", business)
						else
							TriggerEvent("usa:notify", "Can't use the clothing store when dead!")
						end
					end
				else
					previous_menu:Visible(true)
					previous_menu = nil
				end
			end
		elseif _menuPool:IsAnyMenuOpen() then
			_menuPool:CloseAllMenus()
		end

		-- draw 3d text
		for i, isNearby in pairs(nearbyClothingStores) do
			DrawText3D(CLOTHING_STORE_LOCATIONS[i].x, CLOTHING_STORE_LOCATIONS[i].y, CLOTHING_STORE_LOCATIONS[i].z, '[E] - Clothes Store (~g~$60.00~s~)')
		end

		-- process menus --
		if _menuPool:IsAnyMenuOpen() then
			_menuPool:MouseControlsEnabled(false)
			_menuPool:ControlDisablingEnabled(false)
			_menuPool:ProcessMenus()
			if didAskToSave or didAskToSave == nil then
				didAskToSave = false
			end
		else
			if didAskToSave ~= nil and not didAskToSave then
				didAskToSave = true
				TriggerEvent("clothing:openSavePopup")
			end
		end
		Wait(1)
	end
end)

RegisterNetEvent("CS:giveWeapons")
AddEventHandler("CS:giveWeapons", function(weapons)
	local myped = PlayerPedId()
	for i = 1, #weapons do
		local weapon = weapons[i]
		local currentWeaponAmmo = ((weapon.magazine and weapon.magazine.currentCapacity) or 0)
		TriggerEvent("interaction:equipWeapon", weapon, true, currentWeaponAmmo, false)
	end
end)

function ChangeIntoMPModel(skin, isMale)
			Citizen.CreateThread(function()
				local modelhashed = GetHashKey(skin)
				RequestModel(modelhashed)
				while not HasModelLoaded(modelhashed) do
					Citizen.Wait(100)
				end
				SetPlayerModel(PlayerId(), modelhashed)
				local ply = GetPlayerPed(-1)
				if isMale then
					SetPedComponentVariation(ply, 0, 1, 0, 2)
				else
					SetPedComponentVariation(ply, 0, 33, 0, 2)
				end
				SetModelAsNoLongerNeeded(modelhashed)
			end)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
			SetTextFont(font)
			SetTextProportional(0)
			SetTextScale(scale, scale)
			SetTextColour(r, g, b, a)
			SetTextDropShadow(0, 0, 0, 0,255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextCentre(centre)
			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(x , y)
end

function IsNearStore()
	local index = 0
	for _, item in pairs(CLOTHING_STORE_LOCATIONS) do
		index = index + 1
		local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  mycoords.x, mycoords.y, mycoords.z, true)
		if distance <= 2.0 then
			lastShop = index
			return true
		end
	end
end

function IsBlacklisted(gender, type, adjusted_index, val)
	if gender then -- only MP male/female will have gender, see 'getGenderFromModel'
		if BLACKLISTED_ITEMS[gender] then
			if BLACKLISTED_ITEMS[gender][type][adjusted_index] then
				for x = 1, #BLACKLISTED_ITEMS[gender][type][adjusted_index] do
					if val == BLACKLISTED_ITEMS[gender][type][adjusted_index][x] then
						return true
					end
				end
			end
			return false
		end
	else
		return false
	end
end

function getGenderFromModel(model)
	local maleHash = GetHashKey("mp_m_freemode_01")
	local femaleHash = GetHashKey("mp_f_freemode_01")
	if model == femaleHash or model == maleHash then
		if model == maleHash then
			return "male"
		else 
			return "female"
		end
	else 
		return nil
	end
end

function canUseCustomPeds()
    local SteamHex = TriggerServerCallback {
		eventName = "usa_clothingstore:GetSteamHex",
		args = {}
	}
    for i = 1, #custom_peds_whitelist do
        if SteamHex == custom_peds_whitelist[i] then
            return true
        end
    end
    return false
end

function CreateMenu()
	Citizen.CreateThread(function()
		--------------------
		-- Main Menu --
		--------------------
		local item = NativeUI.CreateItem("Default Male", "Change into the default male model.")
		item.Activated = function(parentmenu, selected)
			ChangeIntoMPModel("mp_m_freemode_01", true)
		end
		MainMenu:AddItem(item)

		local item = NativeUI.CreateItem("Default Female", "Change into the default female model.")
		item.Activated = function(parentmenu, selected)
			ChangeIntoMPModel("mp_f_freemode_01", false)
		end
		MainMenu:AddItem(item)

		local newitem = NativeUI.CreateListItem("Ped:", arrSkinGeneralCaptions, 1)
		newitem.OnListSelected = function(sender, item, index)
			if item == newitem then
				Citizen.CreateThread(function()
					local model = arrSkinHashes[index]
					RequestModel(model)
					while not HasModelLoaded(model) do
						Wait(100)
					end
					SetPlayerModel(PlayerId(), model)
					SetPedRandomComponentVariation(GetPlayerPed(-1), false)
					SetModelAsNoLongerNeeded(model)
				end)
			end
		end
		MainMenu:AddItem(newitem)
		
		if canUseCustomPeds(source) then
			local newitem = NativeUI.CreateListItem("Custom Ped:", customPedsCaptions, 1)
			newitem.OnListSelected = function(sender, item, index)
				if item == newitem then
					Citizen.CreateThread(function()
						local model = customPedsHashes[index]
						RequestModel(model)
						while not HasModelLoaded(model) do
							Wait(100)
						end
						SetPlayerModel(PlayerId(), model)
						SetPedRandomComponentVariation(GetPlayerPed(-1), false)
						SetModelAsNoLongerNeeded(model)
					end)
				end
			end
			MainMenu:AddItem(newitem)
		end

		-- components --
		local components_submenu = _menuPool:AddSubMenu(MainMenu, "Components", "Change things like your shirt, jacket, pants, and more. Go to a barber shop for more face customization.", true)

		for i = 1, #COMPONENTS do
			if not BLACKLISTED_MENU_ITEMS.COMPONENTS[i] then
				local adjusted_index = i - 1
				local item = NativeUI.CreateItem(COMPONENTS[i], "Change your " .. COMPONENTS[i])
				item.Activated = function(parentmenu, selected)
					previous_menu = parentmenu
					_menuPool:CloseAllMenus()
					ComponentValuesMenu:Clear()
					local component_variations_total = {} for i = 1, GetNumberOfPedDrawableVariations(me, adjusted_index) - 1 do table.insert(component_variations_total, i) end
					local texture_variations_total = {} for i = 1, GetNumberOfPedTextureVariations(me, adjusted_index, GetPedDrawableVariation(me, adjusted_index)) - 1 do table.insert(texture_variations_total, i) end
					local component_changer = NativeUI.CreateListItem("Component Value", component_variations_total, GetPedDrawableVariation(me, adjusted_index))
					local texture_changer = NativeUI.CreateListItem("Texture Value", texture_variations_total, 1)
					ComponentValuesMenu:AddItem(component_changer)
					if #texture_variations_total > 0 then
						ComponentValuesMenu:AddItem(texture_changer)
					end
					ComponentValuesMenu.OnListChange = function(sender, item, index)
						if item == component_changer then
							local val = item:IndexToItem(index)
							if (not IsBlacklisted(getGenderFromModel(GetEntityModel(PlayerPedId())), "components", adjusted_index, val)) then
								--print("setting adjusted index " .. adjusted_index .. " to val " .. val)
								SetPedComponentVariation(me, adjusted_index, val, 0, 0)
								UpdateValueChangerMenu(me, adjusted_index, val, false)
							end
						elseif item == texture_changer then
							local val = item:IndexToItem(index)
							SetPedComponentVariation(me, adjusted_index, GetPedDrawableVariation(me, adjusted_index), val, 0)
						end
					end
					local clearbtn = NativeUI.CreateItem("Clear", "Clear this component")
					clearbtn.Activated = function(parentmenu, selected)
						SetPedComponentVariation(me, adjusted_index, 0, 0, 0)
					end
					ComponentValuesMenu:AddItem(clearbtn)
					ComponentValuesMenu:Visible(true)
				end
				components_submenu.SubMenu:AddItem(item)
			end
		end

		-- props --
		local props_submenu = _menuPool:AddSubMenu(MainMenu, "Props", "Change things like your hat, glasses, and earrings. Go to a barber shop for more face customization.", true)

		for i = 1, #PROPS do
			local adjusted_index = i - 1
			local item = NativeUI.CreateItem(PROPS[i], "Change your " .. PROPS[i])
			item.Activated = function(parentmenu, selected)
				previous_menu = parentmenu
				_menuPool:CloseAllMenus()
				ComponentValuesMenu:Clear()
				local prop_variations_total = {} for i = 1, GetNumberOfPedPropTextureVariations(me, adjusted_index, GetPedPropIndex(me, adjusted_index)) - 1 do table.insert(prop_variations_total, i) end
				local prop_texture_variations_total = {} for i = 1, GetNumberOfPedPropDrawableVariations(me, adjusted_index) - 1 do table.insert(prop_texture_variations_total, i) end
				local prop_changer = NativeUI.CreateListItem("Prop Value", prop_variations_total, GetPedPropIndex(me, adjusted_index))
				local prop_texture_changer = NativeUI.CreateListItem("Texture Value", prop_texture_variations_total, 1)
				ComponentValuesMenu:AddItem(prop_changer)
				if #prop_texture_variations_total > 0 then
					ComponentValuesMenu:AddItem(prop_texture_changer)
				end
				ComponentValuesMenu.OnListChange = function(sender, item, index)
 					if item == prop_changer then
						 local val = item:IndexToItem(index)
						 ClearPedProp(me, adjusted_index)
						 if val then
							 if not IsBlacklisted(getGenderFromModel(GetEntityModel(PlayerPedId())), "props", adjusted_index, val) then
								 --print("adjusted index: " .. adjusted_index .. ", val: " .. val)
								 SetPedPropIndex(me, adjusted_index, val, 0, true)
								 UpdateValueChangerMenu(me, adjusted_index, val, true)
							 end
						 else
							 SetPedPropIndex(me, adjusted_index, 0, 0, true)
							 UpdateValueChangerMenu(me, adjusted_index, 0, true)
							 val = 0
						 end
					elseif item == prop_texture_changer then
						local val = item:IndexToItem(index)
						ClearPedProp(me, adjusted_index)
						SetPedPropIndex(me, adjusted_index, GetPedPropIndex(me, adjusted_index), val, true)
					end
				end
				ComponentValuesMenu:Visible(true)
			end
			props_submenu.SubMenu:AddItem(item)
		end

		local item = NativeUI.CreateItem("Clear Props", "Remove all props")
		item.Activated = function(parentmenu, selected)
			ClearPedProp(me, 0)
			ClearPedProp(me, 1)
			ClearPedProp(me, 2)
		end
		props_submenu.SubMenu:AddItem(item)

		_menuPool:RefreshIndex()
	end)
end

CreateMenu()

function UpdateValueChangerMenu(me, adjusted_index, oldval, isProp)
	me = GetPlayerPed(-1)
	ComponentValuesMenu:Clear()
	if not isProp then
		local component_variations_total = {} for i = 1, GetNumberOfPedDrawableVariations(me, adjusted_index) - 1 do table.insert(component_variations_total, i) end
		local texture_variations_total = {} for i = 1, GetNumberOfPedTextureVariations(me, adjusted_index, GetPedDrawableVariation(me, adjusted_index)) - 1 do table.insert(texture_variations_total, i) end
		local component_changer = NativeUI.CreateListItem("Component Value", component_variations_total, oldval)
		local texture_changer = NativeUI.CreateListItem("Texture Value", texture_variations_total, 1)
		ComponentValuesMenu:AddItem(component_changer)
		if #texture_variations_total > 0 then
			ComponentValuesMenu:AddItem(texture_changer)
			ComponentValuesMenu:GoUp()
		end
		ComponentValuesMenu.OnListChange = function(sender, item, index)
			if item == component_changer then
				 local val2 = item:IndexToItem(index)
				 if not IsBlacklisted(getGenderFromModel(GetEntityModel(PlayerPedId())), "components", adjusted_index, val2) then
					 --print("setting adjusted index " .. adjusted_index .. " to val2 " .. val2)
					 SetPedComponentVariation(me, adjusted_index, val2, 0, 0)
					 UpdateValueChangerMenu(me, adjusted_index, val2)
				 end
			elseif item == texture_changer then
				local val2 = item:IndexToItem(index)
				SetPedComponentVariation(me, adjusted_index, GetPedDrawableVariation(me, adjusted_index), val2, 0)
			end
		end
		local clearbtn = NativeUI.CreateItem("Clear", "Clear this component")
		clearbtn.Activated = function(parentmenu, selected)
			SetPedComponentVariation(me, adjusted_index, 0, 0, 0)
		end
		ComponentValuesMenu:AddItem(clearbtn)
	else
		local prop_texture_variations_total = {} for i = 1, GetNumberOfPedPropTextureVariations(me, adjusted_index, GetPedPropIndex(me, adjusted_index)) - 1 do table.insert(prop_texture_variations_total, i) end
		local prop_variations_total = {} for i = 1, GetNumberOfPedPropDrawableVariations(me, adjusted_index) - 1 do table.insert(prop_variations_total, i) end
		local prop_changer = NativeUI.CreateListItem("Prop Value", prop_variations_total, oldval)
		local prop_texture_changer = NativeUI.CreateListItem("Texture Value", prop_texture_variations_total, 1)
		ComponentValuesMenu:AddItem(prop_changer)
		if #prop_texture_variations_total > 0 then
			ComponentValuesMenu:AddItem(prop_texture_changer)
		end
		ComponentValuesMenu.OnListChange = function(sender, item, index)
			if item == prop_changer then
				 local val2 = item:IndexToItem(index)
				 ClearPedProp(me, adjusted_index)
				 if val2 then
					 if not IsBlacklisted(getGenderFromModel(GetEntityModel(PlayerPedId())), "props", adjusted_index, val2) then
						 --print("adjusted index: " .. adjusted_index .. ", val2: " .. val2)
						 SetPedPropIndex(me, adjusted_index, val2, 0, true)
						 UpdateValueChangerMenu(me, adjusted_index, val2, true)
					 end
				 else
					 SetPedPropIndex(me, adjusted_index, 0, 0, true)
					 UpdateValueChangerMenu(me, adjusted_index, 0, true)
					 val2 = 0
				 end
			elseif item == prop_texture_changer then
				local val2 = item:IndexToItem(index)
				local saved = GetPedPropIndex(me, adjusted_index)
				ClearPedProp(me, adjusted_index)
				SetPedPropIndex(me, adjusted_index, saved, val2, true)
			end
		end
	end
	ComponentValuesMenu:GoUp()
end

-----------------------------
-- clothing store menu --
-----------------------------
-- main menu --
-- Male MP -- (button)
-- Female MP -- (button)
-- Peds -- (submenu)
-- List of Peds by Name -- (button)
-- Click -> Change Skin
-- Primary Components -- (submenu)
-- List of Primary Components -- (buttons)
-- Click -> SliderMenu
-- Secondary Components -- (submenu)
-- List of Secondary Components -- (buttons)
-- Click -> SliderMenu
-- Props -- (submenu)
-- List of Props -- (buttons)
-- Click -> SliderMenu
-- Save -- (button)


-- SliderMenu --
-- Component Value -- (slider)
-- Texture Value-- (slider)

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
end
