local MENU_KEY1 = 244
local TACKLE_KEY = 101

local isLockpicking = false

local spawned_object = nil
local playing_scenario = false
local playing_anim = nil
local left_hand = 60309
local right_hand = 58868

local playerPed, targetPed
local playerPedCoords, targetPedCoords, offsetCoords
local closestPed = nil
local distanceToTargetPed = 0.0
local distanceToClosestTargetPed = 0.0
local didHit
local hitCoords, hitSurfaceCoords
local hitHandleVehicle = 0
local playerServerId = 0
local playerName = ""
local raycastResult = 0
local voipLevel = 0.0

busy = false

local menuEnabled = false

local inProperty = false

local JERRY_CAN_REFUEL_TIME = 25000

local SPIKE_STRIP_OBJ_SPAWN_OFFSET = {0.0, 2.8, 0.2}
local NORMAL_OBJ_SPAWN_OFFSET = {0.0, 0.5, 0.2}

local scenarios = {
	{name = "cancel", type = "cancel", dict = "", animname = ""},
	{name = "stop", type = "cancel", dict = "", animname = ""},
	{name = "lean", scenarioName = "WORLD_HUMAN_LEANING"},
	{name = "cop", scenarioName = "WORLD_HUMAN_COP_IDLES"},
	{name = "sit", scenarioName = "WORLD_HUMAN_PICNIC"},
	--{name = "chair", scenarioName = "PROP_HUMAN_SEAT_CHAIR"},
	{name = "cross arms", type = "emote", dict = "amb@world_human_hang_out_street@female_arms_crossed@base", animname = "base"},
	{name = "kneel", scenarioName = "CODE_HUMAN_MEDIC_KNEEL"},
	{name = "notepad", type = "emote", dict = "amb@medic@standing@timeofdeath@base", animname = "base"},
	{name = "traffic", scenarioName = "WORLD_HUMAN_CAR_PARK_ATTENDANT"},
	{name = "photo", scenarioName = "WORLD_HUMAN_PAPARAZZI"},
	{name = "clipboard", scenarioName = "WORLD_HUMAN_CLIPBOARD"},
	{name = "hangout", scenarioName = "WORLD_HUMAN_HANG_OUT_STREET"},
	{name = "pot", scenarioName = "WORLD_HUMAN_SMOKING_POT"},
	{name = "fish", scenarioName = "WORLD_HUMAN_STAND_FISHING"},
	{name = "phone", scenarioName = "WORLD_HUMAN_STAND_MOBILE"},
	{name = "yoga", scenarioName = "WORLD_HUMAN_YOGA"},
	{name = "bino", scenarioName = "WORLD_HUMAN_BINOCULARS"},
	{name = "cheer", scenarioName = "WORLD_HUMAN_CHEERING"},
	{name = "statue", scenarioName = "WORLD_HUMAN_HUMAN_STATUE"},
	{name = "jog", scenarioName = "WORLD_HUMAN_JOG_STANDING"},
	{name = "flex", scenarioName = "WORLD_HUMAN_MUSCLE_FLEX"},
	{name = "weights", scenarioName = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS"},
	{name = "sit up", scenarioName = "WORLD_HUMAN_SIT_UPS"},
	{name = "push up", scenarioName = "WORLD_HUMAN_PUSH_UPS"},
	{name = "weld", scenarioName = "WORLD_HUMAN_WELDING"},
	{name = "mechanic", scenarioName = "WORLD_HUMAN_VEHICLE_MECHANIC"},
	{name = "smoke 1", scenarioName = "WORLD_HUMAN_SMOKING"},
	{name = "smoke 2", type = "emote", dict = "amb@world_human_aa_smoke@male@idle_a", animname = "idle_c"},
	{name = "drink", scenarioName = "WORLD_HUMAN_DRINKING"},
	{name = "coffee", scenarioName = "WORLD_HUMAN_AA_COFFEE"},
	{name = "bum 1", scenarioName = "WORLD_HUMAN_BUM_FREEWAY"},
	{name = "bum 2", scenarioName = "WORLD_HUMAN_BUM_SLUMPED"},
	{name = "bum 3", scenarioName = "WORLD_HUMAN_BUM_STANDING"},
	{name = "bum 4", scenarioName = "WORLD_HUMAN_BUM_WASH"},
	{name = "guard", scenarioName = "WORLD_HUMAN_GUARD_STAND"},
	{name = "drill", scenarioName = "WORLD_HUMAN_CONST_DRILL"},
	{name = "blower", scenarioName = "WORLD_HUMAN_GARDENER_LEAF_BLOWER"},
	{name = "chillin'", scenarioName = "WORLD_HUMAN_DRUG_DEALER_HARD"},
	{name = "mobile film", scenarioName = "WORLD_HUMAN_MOBILE_FILM_SHOCKING"},
	{name = "planting", scenarioName = "WORLD_HUMAN_GARDENER_PLANT"},
	{name = "golf", scenarioName = "WORLD_HUMAN_GOLF_PLAYER"},
	{name = "hammer", scenarioName = "WORLD_HUMAN_HAMMERING"},
	{name = "clean", scenarioName = "WORLD_HUMAN_MAID_CLEAN"},
	{name = "musician", scenarioName = "WORLD_HUMAN_MUSICIAN"},
	{name = "impatient", scenarioName = "WORLD_HUMAN_STAND_IMPATIENT"},
	{name = "party", scenarioName = "WORLD_HUMAN_PARTYING"},
	{name = "sunbathe", scenarioName = "WORLD_HUMAN_SUNBATHE_BACK"},
	{name ="prone", scenarioName = "WORLD_HUMAN_SUNBATHE"},
	{name = "prostitute", scenarioName = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"},
	{name = "hug", type = "emote", dict = "mp_ped_interaction", animname = "hugs_guy_a"},
	{name = "fist bump", type = "emote", dict = "anim@mp_player_intcelebrationpaired@f_f_fist_bump", animname = "fist_bump_right"},
	{name = "high five", type = "emote", dict = "mp_ped_interaction", animname = "highfive_guy_a"},
	{name = "shag 1", type = "emote", dict = "misscarsteal2pimpsex", animname = "shagloop_pimp"},
	{name = "shag 2", type = "emote", dict = "misscarsteal2pimpsex", animname = "shagloop_hooker"},
	{name = "shag 3", type = "emote", dict = "misscarsteal2pimpsex", animname = "pimpsex_hooker"},
	{name = "wave", type = "emote", dict = "gestures@m@standing@casual", animname = "gesture_hello", cancelTime = 0.9},
	{name = "dance 1", type = "emote", dict = "mini@strip_club@private_dance@part1", animname = "priv_dance_p1"},
	{name = "dance 2", type = "emote", dict = "mini@strip_club@private_dance@part2", animname = "priv_dance_p2"},
	{name = "dance 3", type = "emote", dict = "mini@strip_club@private_dance@part3", animname = "priv_dance_p3"},
	{name = "whatup", type = "emote", dict = "friends@laf@ig_5", animname = "whatupnigga"},
	{name = "kiss", type = "emote", dict = "mp_ped_interaction", animname = "kisses_guy_a"},
	{name = "handshake", type = "emote", dict = "mp_ped_interaction", animname = "handshake_guy_a"},
	{name = "cpr", type = "emote", dict = "mini@cpr@char_a@cpr_str", animname = "cpr_pumpchest"},
	{name = "cross arms", type = "emote", dict = "amb@world_human_hang_out_street@female_arms_crossed@base", animname = "base"},
	{name = "dance 4", type = "emote", dict = "rcmnigel1bnmt_1b", animname = "dance_loop_tyler"},
	{name = "dance 5", type = "emote", dict = "missfbi3_sniping", animname =  "dance_m_default"},
	{name = 'dance 6', type = 'emote', dict = 'anim@amb@nightclub@dancers@black_madonna_entourage@', animname = 'hi_dance_facedj_09_v2_male^5'},
	{name = 'dance 7', type = 'emote', dict = 'anim@amb@nightclub@dancers@crowddance_facedj@', animname = 'mi_dance_facedj_17_v1_male^5'},
	{name = 'dance 8', type = 'emote', dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', animname  = 'hi_dance_facedj_17_v2_male^6'},
	{name = 'dance 9', type = 'emote', dict = 'anim@amb@nightclub@dancers@crowddance_facedj@med_intensity', animname  = 'mi_dance_facedj_09_v1_male^3'},
	{name = 'dance 10', type = 'emote', dict = 'anim@amb@nightclub@dancers@crowddance_groups@hi_intensity', animname = 'hi_dance_crowd_09_v1_male^6'},
	{name = 'dance 11', type = 'emote', dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', animname  = 'hi_dance_facedj_17_v2_male^3'},
	{name = 'dance 12', type = 'emote', dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', animname  = 'hi_dance_facedj_17_v2_male^2'},
	{name = 'dance 13', type = 'emote', dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', animname  = 'hi_dance_facedj_17_v2_male^4'},
	{name = 'dance 14', type = 'emote', dict = 'anim@amb@nightclub@dancers@crowddance_facedj@med_intensity', animname  = 'mi_dance_facedj_09_v1_male^4'},
	{name = 'dance 15', type = 'emote', dict = 'anim@amb@nightclub@dancers@crowddance_facedj@', animname = 'mi_dance_facedj_17_v1_male^4'},
	{name = 'celebration 1', type = 'emote', dict = 'anim@mp_player_intcelebrationmale@find_the_fish', animname = 'find_the_fish'},
	{name = 'celebration 2', type = 'emote', dict = 'anim@mp_player_intcelebrationmale@uncle_disco', animname = 'uncle_disco'},
	{name = 'celebration 3', type = 'emote', dict = 'anim@mp_player_intupperuncle_disco', animname = 'idle_a'},
	{name = 'celebration 4', type = 'emote', dict = 'anim@mp_player_intcelebrationmale@cats_cradle', animname = 'cats_cradle'},
	{name = 'celebration 5', type = 'emote', dict = 'anim@mp_player_intcelebrationmale@banging_tunes', animname	= 'banging_tunes'},
	{name = 'celebration 6', type = 'emote', dict = 'anim@mp_player_intcelebrationmale@oh_snap', animname = 'oh_snap'},
	{name = 'celebration 7', type = 'emote', dict = 'anim@mp_player_intcelebrationmale@salsa_roll', animname = 'salsa_roll'},
	{name = 'celebration 8', type = 'emote', dict = 'anim@mp_player_intcelebrationmale@raise_the_roof', animname = 'raise_the_roof'},
	{name = "peace", type = "emote", dict = "mp_player_int_upperpeace_sign", animname = "mp_player_int_peace_sign"},
	{name = "gang 1", type = "emote", dict = "mp_player_int_uppergang_sign_a", animname =  "mp_player_int_gang_sign_a"},
	{name = "gang 2", type = "emote", dict = "mp_player_int_uppergang_sign_b", animname =  "mp_player_int_gang_sign_b"},
	{name = "damn", type = "emote", dict = "gestures@m@standing@casual", animname =  "gesture_damn", cancelTime = 1.5},
	{name = "salute", type = "emote", dict = "anim@mp_player_intuppersalute", animname = "idle_a"},
	{name = "finger", type = "emote", dict = "anim@mp_player_intselfiethe_bird", animname = "idle_a"},
	{name = "palm", type = "emote", dict = "anim@mp_player_intupperface_palm", animname = "idle_a"},
	{name = "fail", type = "emote", dict = "random@car_thief@agitated@idle_a", animname = "agitated_idle_a"},
	{name = "no", type = "emote", dict = "mp_player_int_upper_nod", animname = "mp_player_int_nod_no", cancelTime = 1.3},
	{name = "aim", type = "emote", dict = "move_weapon@pistol@cope", animname = "idle"},
	{name = "typing", type = "emote", dict = "anim@amb@prop_human_seat_computer@male@base", animname = "base"},
	{name = "leanwindow", type = "emote", dict = "amb@prop_human_bum_shopping_cart@male@idle_a", animname = "idle_a"},
	--New Emotes
	{name = "dancef", type = "emote", dict = "anim@amb@nightclub@dancers@solomun_entourage@", animname = "mi_dance_facedj_17_v1_female^1"},
	{name = "dancef2", type = "emote", dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", animname = "high_center"},
	{name = "dancef3", type = "emote", dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", animname = "high_center_up"},
	{name = "dancef4", type = "emote", dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", animname = "hi_dance_facedj_09_v2_female^1"},
	{name = "dancef5", type = "emote", dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", animname = "hi_dance_facedj_09_v2_female^3"},
	{name = "dance slow", type = "emote", dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", animname = "low_center"},
	{name = "dance shy", type = "emote", dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", animname = "low_center_down"},
	{name = "dance shy 2", type = "emote", dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", animname = "low_center"},
	{name = "dance silly", type = "emote", dict = "rcmnigel1bnmt_1b", animname = "dance_loop_tyler"},
	{name = "beast", type = "emote", dict = "anim@mp_fm_event@intro", animname = "beast_transform"},
	{name = "pullover", type = "emote", dict = "misscarsteal3pullover", animname = "pull_over_right"},
	{name = "airguitar", type = "emote", dict = "anim@mp_player_intcelebrationfemale@air_guitar", animname = "air_guitar"},
	{name = "airsynth", type = "emote", dict = "anim@mp_player_intcelebrationfemale@air_synth", animname = "air_synth"},
	{name = "argue", type = "emote", dict = "oddjobs@assassinate@vice@hooker", animname = "argue_a"},
	{name = "blow kiss", type = "emote", dict = "anim@mp_player_intcelebrationfemale@blow_kiss", animname = "blow_kiss"},
	{name = "blow kiss 2", type = "emote", dict = "anim@mp_player_intselfieblow_kiss", animname = "exit"},
	{name = "curtsy", type = "emote", dict = "anim@mp_player_intcelebrationpaired@f_f_sarcastic", animname = "sarcastic_left"},
	{name = "bringiton", type = "emote", dict = "misscommon@response", animname = "bring_it_on"},
	{name = "cop3", type = "emote", dict = "amb@code_human_police_investigate@idle_a", animname = "idle_b"},
	{name = "wait", type = "emote", dict = "amb@world_human_hang_out_street@female_hold_arm@idle_a", animname = "idle_a"},
	{name = "damn2", type = "emote", dict = "anim@am_hold_up@male", animname = "shoplift_mid"},
	{name = "point down", type = "emote", dict = "gestures@f@standing@casual", animname = "gesture_hand_down"},
	{name = "fallasleep", type = "emote", dict = "mp_sleep", animname = "sleep_loop"},
	{name = "fight me", type = "emote", dict = "anim@deathmatch_intros@unarmed", animname = "intro_male_unarmed_c"},
	{name = "handshake", type = "emote", dict = "mp_ped_interaction", animname = "handshake_guy_a"},
	{name = "whistle", type = "emote", dict = "rcmnigel1c", animname = "hailing_whistle_waive_a"},
	{name = "airplane", type = "emote", dict = "missfbi1", animname = "ledge_loop"},
	{name = "corona", type = "emote", dict = "timetable@gardener@smoking_joint", animname = "idle_cough"},
	{name = "pee", type = "emote", dict = "misscarsteal2peeing", animname = "peeing_loop"},
	{name = "mind control", type = "emote", dict = "rcmbarry", animname = "mind_control_b_loop"},
}

local walkstyles = {
    {display_name = "Tough (Male)", clipset_name ="MOVE_M@TOUGH_GUY@"},
    {display_name = "Tough (Female)", clipset_name ="MOVE_F@TOUGH_GUY@"},
    {display_name = "Posh (Male)", clipset_name ="MOVE_M@POSH@"},
    {display_name = "Posh (Female)", clipset_name ="MOVE_F@POSH@"},
    {display_name = "Gangster 1 (Male)", clipset_name ="MOVE_M@GANGSTER@NG"},
    {display_name = "Gangster 1 (Female)", clipset_name ="MOVE_F@GANGSTER@NG"},
    {display_name = "Femme (Male)", clipset_name ="MOVE_M@FEMME@"},
    {display_name = "Femme (Female)", clipset_name ="MOVE_F@FEMME@"},
    {display_name = "Slow", clipset_name ="move_p_m_zero_slow"},
    {display_name = "Gangster 2", clipset_name ="move_m@gangster@var_i"},
    {display_name = "Casual", clipset_name ="move_m@casual@d"},
	{display_name = "Injured", clipset_name ="move_injured_generic"},
	-- {display_name = "Flee", clipset_name ="move_f@flee@a"},
	{display_name = "Scared", clipset_name ="move_f@scared"},
	{display_name = "Sexy", clipset_name ="move_f@sexy@a"},
	{display_name = "Slightly Drunk", clipset_name ="MOVE_M@DRUNK@SLIGHTLYDRUNK"},
	{display_name = "Moderately Drunk", clipset_name ="MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP"},
    {display_name = "Very Drunk", clipset_name ="MOVE_M@DRUNK@VERYDRUNK"},
    {display_name = "Grooving", clipset_name="ANIM@MOVE_M@GROOVING@SLOW@"}
}

local ACTIONS = {
	["Show ID"] = function()
		local ped = GetPlayerPed(-1)
		local location = GetEntityCoords(ped)
		local locationTemp = {location.x, location.y, location.z}
		TriggerServerEvent("altchat:showID", locationTemp)
	end,
	["Give cash"] = function()
		Citizen.CreateThread(function()
			if playerServerId ~= 0 then
				-- had to save closest player ID for some reason --
				local playerServerIdTemp = playerServerId
				-- Get desired amount to give from user --
				local amount = tonumber(exports.globals:GetUserInput())
				if amount then
					-- Give cash to nearest player --
					TriggerServerEvent("bank:givecash", playerServerIdTemp, amount)
				end
			else
				exports.globals:notify("Nobody nearby")
			end
		end)
	end,
	["Bank"] = function()
		TriggerServerEvent("bank:showBankBalance")
	end,
	["Roll dice"] = function()
		Citizen.CreateThread(function()
			local maxRoll = tonumber(exports.globals:GetUserInput())
			if maxRoll then
				local ped = GetPlayerPed(-1)
				local location = GetEntityCoords(ped)
				local locationTemp = {location.x, location.y, location.z}
				TriggerServerEvent("usa:rollDice", locationTemp, maxRoll)
			end
		end)
	end,
	["Glasses"] = function()
		TriggerEvent("headprops:toggleProp", 1)
	end,
	["Mask"] = function()
		TriggerEvent("headprops:toggleComponent", 1)
	end,
	["Hat"] = function()
		TriggerEvent("headprops:toggleProp", 0)
	end,
	["Tie"] = function()
		TriggerEvent("crim:attemptToTieNearestPerson", true)
	end,
	["Untie"] = function()
		TriggerEvent("crim:attemptToTieNearestPerson", false)
	end,
	["Rob"] = function()
		TriggerEvent("crim:attemptToRobNearestPerson")
	end,
	["Blindfold"] = function()
		TriggerEvent("crim:attemptToBlindfoldNearestPerson", true)
	end,
	["Remove blindfold"] = function()
		TriggerEvent("crim:attemptToBlindfoldNearestPerson", false)
	end,
	["Drag"] = function()
		TriggerEvent("drag:attemptToDragNearest")
	end,
	["Search"] = function()
		TriggerEvent("search:attemptToSearchNearestPerson")
	end,
	["Place"] = function()
		Citizen.CreateThread(function()
			local ssn = tonumber(exports.globals:GetUserInput())
			if ssn then
				TriggerServerEvent("place:placePerson", ssn) -- need to test chat message response
			end
		end)
	end,
	["Unseat"] = function()
		-- manually type target player id in since not sure how good it is with people in vehicles --
		Citizen.CreateThread(function()
			local ssn = tonumber(exports.globals:GetUserInput())
			if ssn then
				TriggerServerEvent("place:unseatPerson", ssn)
			end
		end)
	end,
	["Walkstyle"] = function()
		Citizen.CreateThread(function()
			TriggerServerEvent("usa:showWalkstyleHelp")
			local style_number = tonumber(exports.globals:GetUserInput())
			TriggerServerEvent("usa:requestWalkstyleChange", style_number)
		end)
	end
}

local VEH_ACTIONS = {
	["Roll Windows"] = function()
		TriggerEvent("RollWindow")
	end,
	["Engine"] = {
		["On"] = function()
			TriggerServerEvent("veh:checkForKey", exports.globals:trim(GetVehicleNumberPlateText(hitHandleVehicle)), true)
		end,
		["Off"] = function()
			TriggerServerEvent("veh:checkForKey", exports.globals:trim(GetVehicleNumberPlateText(hitHandleVehicle)), false)
		end
	},
	["Open"] = {
		["Hood"] = function()
			TriggerEvent("veh:openDoor", "hood")
		end,
		["Front Left"] = function()
			TriggerEvent("veh:openDoor", "fl")
		end,
		["Front Right"] = function()
			TriggerEvent("veh:openDoor", "fr")
		end,
		["Back Left"] = function()
			TriggerEvent("veh:openDoor", "bl")
		end,
		["Back Right"] = function()
			TriggerEvent("veh:openDoor", "br")
		end,
		["Trunk"] = function()
			TriggerEvent("veh:openDoor", "trunk")
		end
	},
	["Close"] = {
		["Hood"] = function()
			TriggerEvent("veh:shutDoor", "hood")
		end,
		["Front Left"] = function()
			TriggerEvent("veh:shutDoor", "fl")
		end,
		["Front Right"] = function()
			TriggerEvent("veh:shutDoor", "fr")
		end,
		["Back Left"] = function()
			TriggerEvent("veh:shutDoor", "bl")
		end,
		["Back Right"] = function()
			TriggerEvent("veh:shutDoor", "br")
		end,
		["Trunk"] = function()
			TriggerEvent("veh:shutDoor", "trunk")
		end
	},
	["Shuffle"] = function()
		TriggerEvent("usa:shuffleSeats")
	end,
	["Brakelights"] = function()
		TriggerEvent("usa:toggleBrakelight")
	end
}

local THROWABLES = {
	["Molotov"] = true,
	["Flare"] = true,
	["Tear Gas"] = true,
	["Stun Gun"] = true,
	["Sticky Bomb"] = true,
	["Flashbang"] = true,
	["Hand Grenade"] = true,
	["Brick"] = true,
	["Ninja Star"] = true,
	["Ninja Star 2"] = true,
	["Rock"] = true,
	["Throwing Knife"] = true,
	["Black Shoe"] = true,
	["Blue Shoe"] = true,
	["Red Shoe"] = true
}

RegisterNUICallback('escape', function(data, cb)
	DisableGui()
	if data.vehicle.plate then
		TriggerServerEvent("vehicle:RemovePersonFromInventory", data.vehicle.plate)
	end
	if data.secondaryInventoryType == "person" then
		TriggerServerEvent("inventory:removeInventoryAccessor", data.secondaryInventorySrc)
	end
	if data.currentPage == "Inventory" and data.secondaryInventoryType == "property" then
		TriggerServerEvent("properties-og:markAsInventoryClosed")
	end
end)

RegisterNUICallback('showPhone', function(data, cb)
	DisableGui()
	TriggerServerEvent("interaction:checkForPhone")
end)

RegisterNUICallback('loadInventory', function(data, cb)
	TransitionToBlurred(1000)
	TriggerServerEvent("interaction:loadInventoryForInteraction")
end)

RegisterNUICallback('loadVehicleInventory', function(data, cb)
	TriggerServerEvent("interaction:loadVehicleInventory", data.plate)
end)

RegisterCommand('openInventory', function()
	if not busy then
		local hitHandleVehicle, distance = getVehicleInsideOrInFrontOfUser()
		local target_veh_plate = GetVehicleNumberPlateText(hitHandleVehicle)
		local target_veh_plate = exports.globals:trim(target_veh_plate)
		TriggerServerEvent("interaction:InvLoadHotkey", target_veh_plate)
		if hitHandleVehicle ~= 0 and target_veh_plate then
			TriggerServerEvent("vehicle:AddPersonToInventory", target_veh_plate)
		end
	end
end)

RegisterKeyMapping('openInventory', 'Open Inventory', 'keyboard', 'i')

-- this is called when the player clicks "retrieve" in the interaction menu on a vehicle inventory item
RegisterNUICallback('retrieveVehicleItem', function(data, cb)
	DisableGui()
	local target_vehicle_plate = data.target_vehicle_plate
	local target_item = data.wholeItem
	local current_job = data.current_job
	local facing_vehicle = getVehicleInsideOrInFrontOfUser()
	if (facing_vehicle ~= 0 and GetVehicleDoorLockStatus(facing_vehicle) ~= 2) or current_job == "police" then
		-- If item.type == "weapon" then check if player has < 3 weapons:
		if target_item.type == "weapon" then
			TriggerServerEvent("vehicle:checkPlayerWeaponAmount", target_item, target_vehicle_plate)
		else
			-- Get quantity to transfer from user input:
			Citizen.CreateThread( function()
				TriggerEvent("hotkeys:enable", false)
				DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
				while true do
					if ( UpdateOnscreenKeyboard() == 1 ) then
						local input_amount = GetOnscreenKeyboardResult()
						if ( string.len( input_amount ) > 0 ) then
							local amount = tonumber( input_amount )
							amount = math.floor(amount, 0)
							if ( amount > 0 ) then
								-- play animation:
								local anim = {
									dict = "anim@move_m@trash",
									name = "pickup"
								}
								-- see if item is able to be removed:
								local quantity_to_transfer = amount
								if quantity_to_transfer <= target_item.quantity then
									--print("seeing if item is still in vehicle...")
									TriggerServerEvent("vehicle:isItemStillInVehicle", target_vehicle_plate, target_item, quantity_to_transfer)
									--TriggerEvent("usa:playAnimation", anim.name, anim.dict, 4)
									--TriggerEvent("usa:playAnimation", anim.dict, anim.name, 5, 1, 4000, 31, 0, 0, 0, 0)
									TriggerEvent("usa:playAnimation", anim.dict, anim.name, -8, 1, -1, 53, 0, 0, 0, 0,  4)
								else
									TriggerEvent("usa:notify", "Quantity input too high!")
								end
							else
								TriggerEvent("usa:notify", "Quantity input too low!")
							end
							break
						else
							DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
						end
					elseif ( UpdateOnscreenKeyboard() == 2 ) then
						break
					end
				Wait(0)
				end
				TriggerEvent("hotkeys:enable", true)
			end)
		end
	else
		TriggerEvent("usa:notify", "Can't retrieve item. Vehicle is locked.")
	end
end)

RegisterNUICallback('playEmote', function(data, cb)
	-----------------
	-- shut GUI --
	-----------------
	DisableGui()
	if not isLockpicking then
		local ped = GetPlayerPed(-1)
		ClearPedTasksImmediately(ped)
		playing_anim = false
		playing_scenario = false
		----------------------------------------------------------------
		-- remove any objects for animiations if applicable --
		----------------------------------------------------------------
		if spawned_object then
			RemovePedObject()
			playing_anim = nil
		end
		-------------------------------
		-- play anim / scenario  --
		-------------------------------
		local scenarioName = data.emoteName:lower()
		if scenarioName == "cancel" or scenarioName == "stop" or scenarioName == "c" then
			playing_scenario = false
			playing_anim = nil
			TriggerEvent("drugs:cancel")
			return
		elseif scenarioName == "surrender" then
			TriggerEvent("KneelHU")
			playing_scenario = true
			return
		elseif scenarioName == "mechanic" or scenarioName == "sit" or scenarioName == "drill" or scenarioName == "chillin'" or scenarioName == "golf" then
			TriggerServerEvent("interaction:checkJailedStatusBeforeEmote", scenarioName)
			playing_scenario = true
			return
		end
		for i = 1, #scenarios do
			if scenarioName == string.lower(scenarios[i].name) then
				if ped then
					if scenarios[i].type ~= "emote" then
						TaskStartScenarioInPlace(ped, scenarios[i].scenarioName, 0, true)
						playing_scenario = true
					elseif scenarios[i].type == "emote" then
						if string.find(scenarioName, "shag") or string.find(scenarioName, "dance") then
							--TriggerEvent("usa:playAnimation", scenarios[i].animname, scenarios[i].dict, false, 6.5, true, flag)
							--TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, 5, 1, 1000, 7, 0, 0, 0, 0)
							TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, -8, 1, -1, 7, 0, 0, 0, 0)
							playing_anim = {
								dict = scenarios[i].dict,
								name = scenarios[i].animname,
								flag = 7
							}
						elseif string.find(scenarioName, "cpr") or string.find(scenarioName, "salute") or string.find(scenarioName, "airplane") or string.find(scenarioName, "cross arms") or string.find(scenarioName, "typing") or string.find(scenarioName, "gang 1") or string.find(scenarioName, "gang 2") then
							--TriggerEvent("usa:playAnimation", scenarios[i].animname, scenarios[i].dict, false, 6.5, true)
							--TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, 5, 1, 1000, 31, 0, 0, 0, 0)
							TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, -8, 1, -1, 53, 0, 0, 0, 0)
							playing_anim = {
								dict = scenarios[i].dict,
								name = scenarios[i].animname,
								flag = 53
							}
						elseif string.find(scenarioName, "notepad") then
							-----------------------------
							-- give notepad object --
							-----------------------------
							GivePedObject(left_hand, "prop_notepad_01")
							---------------------------
							-- play notepad anim --
							---------------------------
							TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, -8, 1, -1, 53, 0, 0, 0, 0)
							playing_anim = {
								dict = scenarios[i].dict,
								name = scenarios[i].animname,
								flag = 53
							}
						elseif string.find(scenarioName, "smoke") then
							-------------------------------
							-- give cigarrette object --
							-------------------------------
							GivePedObject(right_hand, "prop_cs_ciggy_01", 0.05, 0.00, 0.02, -270.0, 90.0, 0.0)
							-----------------------------
							-- play smoking anim --
							-----------------------------
							TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, -8, 1, -1, 53, 0, 0, 0, 0)
							playing_anim = {
								dict = scenarios[i].dict,
								name = scenarios[i].animname,
								flag = 53
							}
						else
							TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, -8, 1, -1, 53, 0, 0, 0, 0, 4)
							if scenarios[i].cancelTime then
								Wait(scenarios[i].cancelTime * 1000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
							end
						end
					elseif scenarios[i].type =="cancel" then
						playing_scenario = false
						playing_anim = nil
						ClearPedTasksImmediately(GetPlayerPed(-1))
					end
				end
			end
		end
	else
		exports.globals:notify("Can't play emote when lockpicking!")
	end
end)

RegisterNetEvent("interaction:cancelAnimation")
AddEventHandler("interaction:cancelAnimation", function()
  playing_scenario = false
  playing_anim = nil
  ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent("drugs:use") -- see usa_drugEffects

RegisterNetEvent('properties:enterProperty')
AddEventHandler('properties:enterProperty', function()
	inProperty = true
end)

RegisterNetEvent('properties:exitProperty')
AddEventHandler('properties:exitProperty', function()
	inProperty = false
end)

RegisterNetEvent('properties:breachProperty')
AddEventHandler('properties:breachProperty', function()
	inProperty = true
end)

RegisterNetEvent('properties:lockpickHouseBurglary')
AddEventHandler('properties:lockpickHouseBurglary', function()
	Wait(20000)
	inProperty = true
end)

RegisterNetEvent('properties:breachHouseBurglary')
AddEventHandler('properties:breachHouseBurglary', function()
	Wait(20000)
	inProperty = true
end)

RegisterNetEvent("emotes:playEmote")
AddEventHandler("emotes:playEmote", function(scenarioName)
	local ped = GetPlayerPed(-1)
	if not isLockpicking and not IsPedRagdoll(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then
		scenarioName = string.lower(scenarioName)
		ClearPedTasksImmediately(ped)
		playing_anim = false
		playing_scenario = false
		----------------------------------------------------------------
		-- remove any objects for animiations if applicable --
		----------------------------------------------------------------
		if spawned_object then
			RemovePedObject()
			playing_anim = nil
		end
		-------------------------------
		-- play anim / scenario  --
		-------------------------------
			if scenarioName == "cancel" or scenarioName == "c" then
				playing_scenario = false
				playing_anim = nil
				TriggerEvent("drugs:cancel")
				return
			elseif scenarioName == "surrender" then
				TriggerEvent("KneelHU")
				playing_scenario = true
				return
			elseif scenarioName == "mechanic" or scenarioName == "sit" or scenarioName == "drill" or scenarioName == "chillin'" or scenarioName == "golf" then
				TriggerServerEvent("interaction:checkJailedStatusBeforeEmote", scenarioName)
				playing_scenario = true
				return
			end
			for i = 1, #scenarios do
				if scenarioName == string.lower(scenarios[i].name) then
					if ped then
						if scenarios[i].type ~= "emote" then
							TaskStartScenarioInPlace(ped, scenarios[i].scenarioName, 0, true)
							playing_scenario = true
						else
							if string.find(scenarioName, "shag") or string.find(scenarioName, "dance") then
								TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, -8, 1, -1, 7, 0, 0, 0, 0)
								playing_anim = {
									dict = scenarios[i].dict,
									name = scenarios[i].animname,
									flag = 7
								}
							elseif string.find(scenarioName, "cpr") or string.find(scenarioName, "salute") or string.find(scenarioName, "airplane") or string.find(scenarioName, "cross arms") or string.find(scenarioName, "leanwindow") or string.find(scenarioName, "typing") or string.find(scenarioName, "gang 1") or string.find(scenarioName, "gang 2") then
								--TriggerEvent("usa:playAnimation", scenarios[i].animname, scenarios[i].dict, false, 6.5, true)
								--TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, 5, 1, 1000, 31, 0, 0, 0, 0)
								TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, -8, 1, -1, 53, 0, 0, 0, 0)
								playing_anim = {
									dict = scenarios[i].dict,
									name = scenarios[i].animname,
									flag = 53
								}
							elseif string.find(scenarioName, "notepad") then
								-----------------------------
								-- give notepad object --
								-----------------------------
								GivePedObject(left_hand, "prop_notepad_01")
								---------------------------
								-- play notepad anim --
								---------------------------
								--TriggerEvent("usa:playAnimation", scenarios[i].animname, scenarios[i].dict, false, 6.5, true)
								--TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, 5, 1, 1000, 31, 0, 0, 0, 0)
								TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, -8, 1, -1, 53, 0, 0, 0, 0)
								playing_anim = {
									dict = scenarios[i].dict,
									name = scenarios[i].animname,
									flag = 53
								}
							elseif string.find(scenarioName, "smoke") then
								-------------------------------
								-- give cigarrette object --
								-------------------------------
								GivePedObject(right_hand, "prop_cs_ciggy_01", 0.05, 0.00, 0.02, -270.0, 90.0, 0.0)
								-----------------------------
								-- play smoking anim --
								-----------------------------
								--TriggerEvent("usa:playAnimation", scenarios[i].animname, scenarios[i].dict, false, 6.5, true)
								--TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, 5, 1, 1000, 31, 0, 0, 0, 0)
								TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, -8, 1, -1, 53, 0, 0, 0, 0)
								playing_anim = {
									dict = scenarios[i].dict,
									name = scenarios[i].animname,
									flag = 53
								}
							else
								TriggerEvent("usa:playAnimation", scenarios[i].dict, scenarios[i].animname, -8, 1, -1, 53, 0, 0, 0, 0, 4)
								if scenarios[i].cancelTime then
									Wait(scenarios[i].cancelTime * 1000)
									ClearPedTasksImmediately(GetPlayerPed(-1))
								end
							end
						end
					end
				end
			end
		else
			exports.globals:notify("Can't play emote now!")
		end
end)

RegisterNetEvent("emotes:showHelp")
AddEventHandler("emotes:showHelp", function()
	local msg = "^3Options: ^0"
	for i = 1, #scenarios do
		if i == #scenarios then
			msg = msg .. scenarios[i].name
		else
			msg = msg .. scenarios[i].name .. ", "
		end
	end
	TriggerEvent("chatMessage", "", {255, 255, 255}, msg)
end)

RegisterNetEvent("interaction:useItem")
AddEventHandler("interaction:useItem", function(index, item)
	interactionMenuUse(index, item.name, item)
end)

function GivePedObject(target_bone, object, x, y, z, rotX, rotY, rotZ)
	object = GetHashKey(object)
	local ped = GetPlayerPed(-1)
	local coords = GetEntityCoords(ped)
    local bone = GetPedBoneIndex(ped, target_bone)
  	RequestModel(object)
  	while not HasModelLoaded(object) do
  		Citizen.Wait(100)
  	end
  	spawned_object = CreateObject(object, coords.x, coords.y, coords.z, 1, 1, 0)
	if rotX and rotY and rotZ and x and y and z then
  		AttachEntityToEntity(spawned_object, ped, bone, x, y, z, rotX, rotY, rotZ, 1, 1, 0, 0, 2, 1)
	else
		AttachEntityToEntity(spawned_object, ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
	end
end

function RemovePedObject()
	DeleteObject(spawned_object)
	spawned_object = nil
end

RegisterNUICallback('reloadWeapon', function(data, cb)
	TriggerEvent("ammo:reloadFromInventoryButton", data)
end)

RegisterNUICallback('unloadWeapon', function(data, cb)
	TriggerEvent("ammo:ejectMag", data)
end)

RegisterNUICallback('notification', function(data, cb)
	exports.globals:notify(data.msg)
end)

RegisterNUICallback('setVoipLevel', function(data, cb)
	DisableGui()
	local selected = data.level:lower()
	if selected == "yell" then
		selected = 3
	elseif selected == "normal" then
		selected = 2
	elseif selected == "whisper" then
		selected = 1
	end
	exports["mumble-voip"]:SetTalkingRange(GetPlayerServerId(PlayerId()), selected)
end)

RegisterNUICallback('openVehicleDoor', function(data, cb)
	DisableGui()
	local name = string.lower(data.name)
	if name == "hood" then
		TriggerEvent("veh:openDoor", name)
	elseif name == "trunk" then
		TriggerEvent("veh:openDoor", name)
	elseif name == "f left" then
		TriggerEvent("veh:openDoor", "fl")
	elseif name == "f right" then
		TriggerEvent("veh:openDoor", "fr")
	elseif name == "b left" then
		TriggerEvent("veh:openDoor", "bl")
	elseif name == "b right" then
		TriggerEvent("veh:openDoor", "br")
	end
end)

RegisterNUICallback('closeVehicleDoor', function(data, cb)
	DisableGui()
	local name = string.lower(data.name)
	if name == "hood" then
		TriggerEvent("veh:shutDoor", name)
	elseif name == "trunk" then
		TriggerEvent("veh:shutDoor", name)
	elseif name == "f left" then
		TriggerEvent("veh:shutDoor", "fl")
	elseif name == "f right" then
		TriggerEvent("veh:shutDoor", "fr")
	elseif name == "b left" then
		TriggerEvent("veh:shutDoor", "bl")
	elseif name == "b right" then
		TriggerEvent("veh:shutDoor", "br")
	end
end)

RegisterNUICallback('doVehicleAction', function(data, cb)
	DisableGui()
	local name = string.lower(data.name)
	if name == "engine" then
		TriggerEvent("veh:toggleEngine")
	elseif name == "hood" then
		TriggerEvent("veh:toggleDoor", name)
	elseif name == "trunk" then
		TriggerEvent("veh:toggleDoor", name)
	elseif name == "f left" then
		TriggerEvent("veh:toggleDoor", "fl")
	elseif name == "f right" then
		TriggerEvent("veh:toggleDoor", "fr")
	elseif name == "b left" then
		TriggerEvent("veh:toggleDoor", "bl")
	elseif name == "b right" then
		TriggerEvent("veh:toggleDoor", "br")
	end
end)

RegisterNUICallback('performPoliceAction', function(data, cb)
	DisableGui()
	local actionIndex = data.policeActionIndex
	local actionName = string.lower(data.policeActionName)
	local unseatIndex = string.lower(data.unseatIndex)
	TriggerEvent("interaction:performPoliceAction", actionName, unseatIndex)
end)

RegisterNUICallback('inventoryActionItemClicked', function(data, cb)
	DisableGui()
  local actionName = data.actionName
	local itemName = data.itemName
	local wholeItem = data.wholeItem
	local targetPlayerId = data.playerId
	if actionName and itemName and wholeItem and targetPlayerId then
		if actionName == "use" then
			interactionMenuUse(data.index, itemName, wholeItem)
		elseif string.find(actionName, "give") then
			if targetPlayerId ~= 0 and distanceToClosestTargetPed <= exports["globals"]:MaxItemTradeDistance() then
				if not string.find(itemName, "Driver") and not string.find(itemName, "Firearm") and not string.find(itemName, 'License') and not string.find(itemName, 'Certificate') then
					TriggerServerEvent("interaction:giveItemToPlayer", wholeItem, targetPlayerId)
					if itemName:find("Radio") then
						TriggerEvent("Radio.Set", false, {})
					end
				end
			else
				exports.globals:notify("Can't find player to give to!")
			end
		elseif actionName == "store" then
			if not string.find(itemName, "Driver") and not string.find(itemName, "Firearm") and not string.find(itemName, 'License') and not string.find(itemName, 'Certificate') then
				-- Get quantity to transfer from user input:
				Citizen.CreateThread( function()
					TriggerEvent("hotkeys:enable", false)
					DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
					while true do
						if ( UpdateOnscreenKeyboard() == 1 ) then
							local input_amount = GetOnscreenKeyboardResult()
							if ( string.len( input_amount ) > 0 ) then
								local amount = tonumber( input_amount )
								amount = math.floor(amount, 0)
								if ( amount > 0 ) then
									-- trigger server event to remove money
									local quantity_to_transfer = amount
									if quantity_to_transfer <= wholeItem.quantity then
										TriggerEvent("vehicle:checkTargetVehicleForStorage", wholeItem, quantity_to_transfer)
									end
								end
								break
							else
								DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 9 )
							end
						elseif ( UpdateOnscreenKeyboard() == 2 ) then
							break
						end
						Wait( 0 )
					end
					TriggerEvent("hotkeys:enable", true)
				end )
			else
				print("can't store DL!!")
			end
		end
	end
end)

RegisterNUICallback("dropItem", function(data, cb)
	if not string.find(data.itemName, "Driver") and not string.find(data.itemName, "Firearm") and not string.find(data.itemName, "License") then
		local me = PlayerPedId()
		if IsPedInAnyVehicle(me) and IsPedCuffed(me) then
			exports.globals:notify("Can't drop items while cuffed inside a vehicle!")
			return
		end
		-- remove from inventory --
		local myped = PlayerPedId()
		local finalPos = nil
		if data.itemName:find("Spike Strips") then
			finalPos = GetOffsetFromEntityInWorldCoords(myped, table.unpack(SPIKE_STRIP_OBJ_SPAWN_OFFSET)) -- in front of player
		else
			finalPos = GetOffsetFromEntityInWorldCoords(myped, table.unpack(NORMAL_OBJ_SPAWN_OFFSET))
		end
		TriggerEvent("usa:playAnimation", "anim@move_m@trash", "pickup", -8, 1, -1, 48, 0, 0, 0, 0)
		TriggerServerEvent("inventory:dropItem", data.itemName, data.index, finalPos.x, finalPos.y, finalPos.z, GetEntityHeading(PlayerPedId()))
		if data.itemName:find("Radio") then
			TriggerEvent("Radio.Set", false, {})
		end
		if data.itemName:find("Wheelchair") then
			local handle = CreateObject(GetHashKey("prop_wheelchair_01"), finalPos.x, finalPos.y, finalPos.z, true, true, true)
			SetEntityAsMissionEntity(handle, true, true)
			SetEntityHeading(handle, GetEntityHeading(PlayerPedId()))
			PlaceObjectOnGroundProperly(handle)
		end
		if data.itemName:find("Stretcher") then
			local handle = CreateObject(GetHashKey("prop_ld_binbag_01"), finalPos.x, finalPos.y, finalPos.z - 0.33, true, true, true)
			SetEntityAsMissionEntity(handle, true, true)
			SetEntityHeading(handle, GetEntityHeading(PlayerPedId()))
		end
	else
		exports.globals:notify("Can't drop that item, sorry!")
	end
end)

RegisterNUICallback('moveItem', function(data, cb)
	if not IsPedCuffed(PlayerPedId()) then
		TriggerServerEvent("inventory:moveItem", data)
	else
		exports.globals:notify("You are cuffed! Can't move item!")
	end
end)

function interactionMenuUse(index, itemName, wholeItem)
	if wholeItem.type and wholeItem.type == "magazine" then
		if not busy then
			TriggerServerEvent("ammo:useMagazine", wholeItem)
		end
	elseif string.find(itemName, "Meth") or string.find(itemName, "Uncut Cocaine") then
		TriggerServerEvent("interaction:removeItemFromPlayer", itemName)
		TriggerEvent("interaction:notify", "You have used: (x1) " .. itemName:sub(6))
		intoxicate(true, nil)
		reality(5)
	elseif string.find(itemName, "LSD Vial") then
		TriggerServerEvent("interaction:removeItemFromPlayer", itemName)
		TriggerEvent("interaction:notify", "You have used: (x1) LSD Vial")
		Citizen.CreateThread(function()
			local drug_duration = 15 * 60 * 1000 -- 15 minutes in ms?
			Wait(8000)
			DoScreenFadeOut(1500)
			Wait(1500)
			DoScreenFadeIn(1500)
			StartScreenEffect("DrugsMichaelAliensFight", 0, false)
			local useTime = GetGameTimer()
			while GetGameTimer() - useTime <= drug_duration do
				Wait(1)
			end
			DoScreenFadeOut(1000)
			DoScreenFadeIn(1000)
			StopScreenEffect("DrugsMichaelAliensFight")
		end)
	elseif string.find(itemName, "Packaged Weed") then
		TriggerServerEvent("drugs:use", "Packaged Weed")
	elseif itemName:find("Joint") then
		TriggerServerEvent("drugs:use", "Joint")
	elseif string.find(itemName, "Mechanic Tools") then
		TriggerEvent("mechanic:repairJobCheck")
	elseif string.find(itemName, "Hotwiring Kit") then
		local ped = GetPlayerPed(-1)
		local targetVehicle = GetVehiclePedIsUsing(ped, false)
		local boostingInfo = Entity(targetVehicle).state.boostingData
		if boostingInfo ~= nil and boostingInfo.advancedSystem then
			TriggerEvent("usa:notify", 'You need a ~r~professional system~w~ to turn this vehicle on!')
			return
		end
		TriggerEvent("veh:hotwireVehicle")
	elseif string.find(itemName, "Body Armor") then
		if not busy then
			busy = true
			playHealingAnimation(PlayerPedId())
			TriggerServerEvent("interaction:bodyArmor")
			busy = false
		end
	elseif string.find(itemName, "Police Armor") then
		if not busy then
			busy = true
			playHealingAnimation(PlayerPedId())
			TriggerServerEvent("interaction:policeBodyArmor")
			busy = false
		end
	elseif string.find(itemName, "Jerry Can") then
		local JERRY_CAN_ANIMATION = {
			dict = "weapon@w_sp_jerrycan",
			name = "fire"
		}

		exports.globals:loadAnimDict(JERRY_CAN_ANIMATION.dict)

		hitHandleVehicle = getVehicleInFrontOfUser()
		if tonumber(hitHandleVehicle) ~= 0 then
			busy = true
			local ped = GetPlayerPed(-1)
			local jcan = 883325847
			GiveWeaponToPed(ped, jcan, 20, false, true) -- easiest way to remove jerry can object off back when using it (from weapons-on-back resource)
			Wait(1000)
			TriggerEvent("usa:playAnimation", JERRY_CAN_ANIMATION.dict, JERRY_CAN_ANIMATION.name, -8, 1, -1, 53, 0, 0, 0, 0, 24.5)
			local start = GetGameTimer()
			while GetGameTimer() - start < JERRY_CAN_REFUEL_TIME do
				if not IsEntityPlayingAnim(playerPed, JERRY_CAN_ANIMATION.dict, JERRY_CAN_ANIMATION.name, 3) then
					TaskPlayAnim(playerPed, JERRY_CAN_ANIMATION.dict, JERRY_CAN_ANIMATION.name, 8.0, -8, -1, 31, 0, 0, 0, 0)
				end
				if GetSelectedPedWeapon(ped) ~= jcan then
					GiveWeaponToPed(ped, jcan, 20, false, true)
				end
				DrawTimer(start, JERRY_CAN_REFUEL_TIME, 1.42, 1.475, "Refueling")
				Wait(0)
			end
			ClearPedTasksImmediately(ped)
			-- refuel --
			TriggerServerEvent("fuel:refuelWithJerryCan", exports.globals:trim(GetVehicleNumberPlateText(hitHandleVehicle)))
			-- remove jerry can weapon from inventory --
			TriggerServerEvent("usa:removeItem", wholeItem, 1)
			TriggerEvent("interaction:equipWeapon", wholeItem, false)
			busy = false
		else
			TriggerEvent("usa:notify", "No vehicle found!")
		end
	elseif string.find(itemName, "First Aid Kit") then
		if not busy then
			busy = true
			TriggerServerEvent("usa:removeItem", wholeItem, 1)
			playHealingAnimation(PlayerPedId())
			TriggerEvent("usa:heal", 35)
			TriggerEvent('injuries:bandageMyInjuries')
			busy = false
		end
	elseif string.find(itemName, "IFAK") then
	if not busy then
		busy = true
		TriggerServerEvent("usa:removeItem", wholeItem, 1)
		playHealingAnimation(PlayerPedId())
		TriggerEvent("usa:heal", 35)
		TriggerEvent('injuries:bandageMyInjuries')
		busy = false
	end
	elseif string.find(itemName, "Medical Bag") then
	if not busy then
		busy = true
		playHealingAnimation(PlayerPedId())
		TriggerEvent("usa:heal", 35)
		TriggerEvent('injuries:bandageMyInjuries')
		busy = false
	end
	elseif string.find(itemName, "Lockpick") then
		local targetVehicle = getVehicleInFrontOfUser()
		local boostingInfo = Entity(targetVehicle).state.boostingData
		if boostingInfo ~= nil and boostingInfo.advancedSystem then
			TriggerEvent("usa:notify", 'You need a ~r~professional system~w~ to access this vehicle!')
			return false
		end
		local playerPed = GetPlayerPed(-1)
		local veh = getVehicleInsideOrInFrontOfUser()
		if veh ~= 0 and GetEntityType(veh) == 2 then
			if GetVehicleDoorLockStatus(veh) ~= 1 then
				-- prevent using /e to hide animation --
				isLockpicking = true
				-- play animation:
				local anim = {
					dict = "veh@break_in@0h@p_m_one@",
					name = "low_force_entry_ds"
				}
				RequestAnimDict(anim.dict)
				while not HasAnimDictLoaded(anim.dict) do
					Wait(100)
				end
				if math.random() > 0.80 and IsAreaPopulated() then
					local x, y, z = table.unpack(GetEntityCoords(playerPed))
					local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
					local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
					local primary, secondary = GetVehicleColours(veh)
					local isMale = true
		            if GetEntityModel(playerPed) == GetHashKey("mp_f_freemode_01") then
		            	isMale = false
		            elseif GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01") then
		                isMale = true
		            else
		                isMale = IsPedMale(playerPed)
		            end
					TriggerServerEvent('911:LockpickingVehicle', x, y, z, lastStreetNAME, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))), exports.globals:trim(GetVehicleNumberPlateText(veh)), isMale, primary, secondary)
				end

				if not IsEntityPlayingAnim(playerPed, anim.dict, anim.name, 3) then
					TaskPlayAnim(playerPed, anim.dict, anim.name, 8.0, 1.0, -1, 31, 1.0, false, false, false)
				end

				local success = lib.skillCheck({'easy', 'easy', 'medium', 'medium'}, {'i', 'j', 'k', 'l'})
				if success then
					SetVehicleDoorsLocked(veh, 1)
					SetVehicleDoorsLockedForAllPlayers(veh, 0)
					if not GetIsVehicleEngineRunning(veh) then
						SetVehicleNeedsToBeHotwired(veh, true)
					end
					TriggerEvent("usa:notify", "Lockpick was ~y~successful~s~!")
				else
					TriggerEvent("usa:notify", "Lockpick has ~y~failed~s~!")
					if math.random() > 0.65 then
						TriggerEvent("usa:notify", "Lockpick has ~y~broken~s~!")
						TriggerServerEvent("usa:removeItem", wholeItem, 1)
					end
				end
				isLockpicking = false
				ClearPedTasksImmediately(playerPed)
			else
				TriggerEvent("usa:notify", "Door is already unlocked!")
			end
		else
			TriggerServerEvent('properties:lockpickHouse', GetEntityCoords(playerPed), wholeItem)
		end
	elseif string.find(itemName, 'Advanced Pick') then
		CreateThread(function()
			TriggerEvent('doormanager:advancedPick')
		end)
	elseif string.find(itemName, "Binoculars") then
		TriggerEvent("binoculars:Activate")
		-------------------
		-- Cell Phone --
		-------------------
	elseif string.find(itemName, "Cell Phone") then
		TriggerEvent("high_phone:openPhone")
		-------------------
		-- Food Item  --
		-------------------
	elseif wholeItem.type and wholeItem.type == "food" then
		--print("Player used inventory item of type: food!")
		--print("item name: " .. wholeItem.name)
		--TriggerEvent("hungerAndThirst:replenish", "hunger", wholeItem)
		TriggerServerEvent("foodwater:checkItemAge", wholeItem)
		-------------------
		-- Drink Item  --
		-------------------
	elseif wholeItem.type and wholeItem.type == "drink" then
		--print("Player used inventory item of type: drink!")
		--print("item name: " .. wholeItem.name)
		--TriggerEvent("hungerAndThirst:replenish", "drink", wholeItem)
		TriggerServerEvent("foodwater:checkItemAge", wholeItem)
		---------------------------
		-- Alcoholic Drink Item  --
		---------------------------
	elseif wholeItem.type and wholeItem.type == "alcohol" then
		TriggerEvent("hungerAndThirst:replenish", "drink", wholeItem)
		TriggerEvent('evidence:returnData', function(data)
			TriggerEvent('evidence:updateData', 'levelBAC', data['levelBAC'] + wholeItem.strength)
		end)
	elseif string.find(itemName, "Parachute") then
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("GADGET_PARACHUTE"), 150, true, true)
		SetPedComponentVariation(GetPlayerPed(-1), 5, 1, 0, 0)
		TriggerServerEvent("parachute:usedParachute")
	elseif itemName == "Tent" or itemName == "Chair" or itemName == "Wood" then
		TriggerServerEvent("camping:useItem", wholeItem)
	elseif itemName:find("Firearm Permit") then
		exports["usa_gunshop"]:ShowCCWTerms()
	elseif itemName == "Chicken" then
		TriggerEvent("chickenJob:spawnChicken", true)
	elseif itemName == "Chicken carcass" then
		TriggerEvent("chickenJob:spawnChicken", false)
	elseif itemName:find("Driver's License") then
		local ped = GetPlayerPed(-1)
		local location = GetEntityCoords(ped)
		local locationTemp = {location.x, location.y, location.z}
		TriggerServerEvent("altchat:showID", locationTemp)
	elseif itemName:find("Sturdy Rope") then
		TriggerEvent("crim:attemptToTieNearestPerson", true)
	elseif itemName:find("Small Weed Plant") then
		TriggerEvent("cultivation:plant", "cannabis", wholeItem.name)
	elseif itemName:find("Watering Can") then
		TriggerEvent("cultivation:water")
	elseif itemName:find("Fertilizer") then
		TriggerEvent("cultivation:feed")
	elseif itemName:find("Scissors") then
		TriggerEvent("cultivation:harvest")
	elseif itemName:find("Shovel") then
		TriggerEvent("cultivation:shovel")
	elseif itemName:find("Thermite") then
		TriggerServerEvent("bank:useThermite")
	elseif itemName:find("Butchered Meat") then
		TriggerServerEvent("hunting:cookMeat", wholeItem.name)
	elseif itemName:find("Vape") then
		TriggerEvent("Vape:ToggleVaping")
	elseif itemName:find("Large Firework") then
		TriggerEvent("fireworks:placeFirework")
	elseif itemName == "Spike Strips" then
		local myped = PlayerPedId()
		local pos = GetOffsetFromEntityInWorldCoords(myped, table.unpack(SPIKE_STRIP_OBJ_SPAWN_OFFSET)) -- in front of player
		TriggerEvent("usa:playAnimation", "anim@move_m@trash", "pickup", -8, 1, -1, 48, 0, 0, 0, 0)
		TriggerServerEvent("inventory:dropItem", itemName, index, pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()))
	elseif itemName == "Radio" or itemName == "EMS Radio" or itemName == "Police Radio" then
		TriggerServerEvent("rp-radio:checkForRadioItem")
	elseif itemName == "Scuba Gear" then
		TriggerEvent("scuba:useGear")
	elseif itemName == "Speaker" then
		local mycoords = GetEntityCoords(PlayerPedId())
		TriggerServerEvent("speaker:create", vector3(mycoords.x, mycoords.y, mycoords.z - 0.98))
	elseif wholeItem.type and wholeItem.type == "mechanicPart" then
		if IsPedInAnyVehicle(PlayerPedId()) then
			exports.globals:notify("Must not be inside vehicle")
			return
		end
		TriggerEvent("mechanic:usedPart", wholeItem)
	elseif itemName == "Beer Pong Kit" then
		ExecuteCommand("createbeerpong")
	elseif wholeItem.type and wholeItem.type == "tradingCard" then
		TriggerServerEvent("trading-cards:use", wholeItem)
	elseif itemName == "Hacking Device" then
		TriggerEvent("rahe-boosting:client:hackingDeviceUsed")
	elseif itemName == "GPS Removal Device" then
		TriggerEvent("rahe-boosting:client:gpsHackingDeviceUsed")
	elseif itemName == "Tablet" then
		TriggerEvent("rahe-boosting:client:openTablet")
	elseif itemName == "Racing Dongle" then
		TriggerEvent("rahe-racing:client:openTablet")
	elseif itemName == "Crumpled Paper" then
		TriggerEvent("core_rob_truck:hint")
		TriggerServerEvent("usa:removeItem", itemName, 1)
	elseif itemName == "Bank Laptop" then
		TriggerEvent("usa:notify", "Device not connected to a terminal.")
	elseif itemName == "Roller Skates" then
		TriggerEvent("skating:roller", wholeItem)
	elseif itemName == "Ice Skates" then
		TriggerEvent("skating:iceroller", wholeItem)
	elseif itemName == "Armed Truck Bomb" then
		TriggerEvent("usa:notify", "Hmm... No use here... Maybe use it on an armored truck?")
	elseif itemName == "RGB Controller" then
		ExecuteCommand("rgbcontrolleritemlol")
	elseif itemName == "Basketball Hoop" then
		ExecuteCommand("placehoop")
	elseif itemName == "Skateboard" then
		TriggerEvent('usa_skateboard:PlaceDown')
  elseif wholeItem.type == "magicPotion" then
		TriggerServerEvent("magicPotion:used", wholeItem)
	elseif itemName == "Drill" then
		TriggerEvent("banking:DrillATM")
	elseif itemName == "Christmas Present" then
		TriggerServerEvent("usa:openChristmasPresent", wholeItem)
	elseif itemName == "RC Car" then
		TriggerEvent("rc:start")
	elseif itemName == "Lottery Ticket" then
		TriggerServerEvent('usa_lottery:checkticketnumber')
	elseif itemName == "Tint Meter" then
		TriggerEvent("usa_police:checkwindowtint")
	elseif itemName == "Battering Ram" then
		TriggerServerEvent("doormanager:BatteringRam", GetEntityCoords(PlayerPedId()))
	elseif itemName == "Repair Kit" then
		TriggerEvent("mechanic:repairtools", source)
	elseif itemName == "Spray Paint" then
		TriggerServerEvent("rcore_spray:spray")
	elseif itemName == "Rag" then
		TriggerServerEvent("rcore_spray:sprayremover")
	else
		TriggerEvent("interaction:notify", "There is no use action for that item!")
	end
end

RegisterNetEvent("interaction:equipArmor")
AddEventHandler("interaction:equipArmor", function()
	SetPedArmour(PlayerPedId(), 60)
	TriggerEvent('usa:notify', "You have equipped light body armor!")
end)

RegisterNetEvent("interaction:equipPoliceArmor")
AddEventHandler("interaction:equipPoliceArmor", function()
	SetPedArmour(PlayerPedId(), 100)
	TriggerEvent('usa:notify', "You have equipped Police Body Armor!")
end)

RegisterNetEvent("interaction:ragdoll")
AddEventHandler("interaction:ragdoll", function()
	SetPedToRagdoll(GetPlayerPed(-1), 5500, 5500, 0, true, true, false);
end)

-- update players job for interaction menu
RegisterNetEvent("interaction:setPlayersJob")
AddEventHandler("interaction:setPlayersJob", function(playerJob)
	-- update interaction menu variable
	SendNUIMessage({
		type = "setPlayerJob",
		job = playerJob
	})
end)

RegisterNetEvent("interaction:sendNUIMessage")
AddEventHandler("interaction:sendNUIMessage", function(messageTable)
    SendNUIMessage(messageTable)
end)

RegisterNetEvent("interaction:openGUIAndSendNUIData")
AddEventHandler("interaction:openGUIAndSendNUIData", function(messageTable)
	EnableGui()
    SendNUIMessage(messageTable)
end)

RegisterNetEvent("interaction:notify")
AddEventHandler("interaction:notify", function(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(0,1)
end)

RegisterNetEvent("interaction:playerHadPhone")
AddEventHandler("interaction:playerHadPhone", function()
	TriggerEvent("phone:openPhone")
end)

RegisterNetEvent("interaction:inventoryLoaded")
AddEventHandler("interaction:inventoryLoaded", function(inventory)
	SendNUIMessage({
		type = "inventoryLoaded",
		inventory = inventory
	})
end)

RegisterNetEvent("interaction:vehicleInventoryLoaded")
AddEventHandler("interaction:vehicleInventoryLoaded", function(inventory, isLocked)
	SendNUIMessage({
		type = "vehicleInventoryLoaded",
		inventory = inventory,
		locked = (isLocked or false)
	})
end)

RegisterNetEvent("interaction:forceShutGUI")
AddEventHandler("interaction:forceShutGUI", function(data)
	SendNUIMessage({
		type = "enableui",
		enable = false,
	})
	SetNuiFocus(false, false)
	TransitionFromBlurred(1000)
	menuEnabled = false
	SetPedCanSwitchWeapon(GetPlayerPed(-1), not menuEnabled)
	if data.secondaryInventoryType and data.secondaryInventoryType == "property" then
		TriggerServerEvent("properties-og:markAsInventoryClosed")
	end
end)

local EMOTE_CANCEL = 32
Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(-1)
		------------------------------------------------
		-- cancel scenario when W is pressed --
		------------------------------------------------
		if IsControlPressed(1, 32) and playing_scenario then
			ClearPedTasks(ped)
			playing_scenario = false
		end
		--------------------------------------------
		-- Make sure emote stays playing  --
		--------------------------------------------
		if playing_anim and not IsEntityPlayingAnim(ped, playing_anim.dict, playing_anim.name, 3) then
			TaskPlayAnim(ped, playing_anim.dict, playing_anim.name, -8, 1, -1, playing_anim.flag, 0, 0, 0, 0)
		end
		Citizen.Wait(100)
	end
end)

-- disable auto lock when using controllers
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(100)
	  SetPlayerTargetingMode(3)
	end
  end)

-- getting drunk / high effect
function intoxicate(playScenario, clipset, intensity)
	local ped = GetPlayerPed(-1)
	if playScenario and not IsPedInAnyVehicle(ped, true) then
		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_DRUG_DEALER", 0, 1)
	end
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	if not IsPedInAnyVehicle(ped, true) then
		ClearPedTasksImmediately(ped)
	end
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(ped, true)
		if clipset then
		--print("setting movement clipset to: " .. clipset)
		ResetPedMovementClipset(ped, 0)
		RequestAnimSet( clipset )
		while ( not HasAnimSetLoaded( clipset ) ) do
			Citizen.Wait( 1 )
		end
		SetPedMovementClipset(ped, clipset, 0.25)
	end
	SetPedIsDrunk(ped, true)
	DoScreenFadeIn(1000)
	if intensity then
		ShakeGameplayCam("DRUNK_SHAKE", intensity)
	end
end

function reality(minutes)
	minutes = minutes * 60 * 1000
	Citizen.Wait(minutes)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
	StopGameplayCamShaking(true)
	-- Stop the mini mission
	--Citizen.Trace("Going back to reality\n")
end

-- end drunk / high effect
function removeQuantityFromItemName(itemName)
if string.find(itemName,"%)") then
	local i = string.find(itemName, "%)")
	i = i + 2
	itemName = string.sub(itemName, i)
	--print("new item name = " .. itemName)
end
return itemName
end

RegisterNetEvent("interaction:toggleWeapon")
AddEventHandler("interaction:toggleWeapon", function(item, skipAnim)
	local ped = PlayerPedId()
	local selectedPedWeapon = GetSelectedPedWeapon(ped)
	if IsPedArmed(ped, 1 | 2 | 4) then
		if IsPedInAnyVehicle(ped, true) then
			SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
		else
			GiveWeaponToPed(ped, `WEAPON_UNARMED`, 1000, false, true)
		end
		if not skipAnim then
			exports["usa_holster"]:handleHolsterAnim()
		end
		-- show selected weapon preview if in vehicle --
		if IsPedInAnyVehicle(ped, false) then
			SendNUIMessage({
				type = "showSelectedItemPreview",
				itemName = "Unarmed"
			})
		end
	else
		local toGiveAmmo = 0
		if item.magazine then
			toGiveAmmo = item.magazine.currentCapacity
		end
		if THROWABLES[item.name] then
			toGiveAmmo = 1
		end
		if item.name:find("Fire Extinguisher") or item.name:find("Jerry Can") or item.name:find("Noel Launcher") or item.name:find("Olaf Minigun") then
			toGiveAmmo = 1000
		end
		TriggerEvent("interaction:equipWeapon", item, true, toGiveAmmo, (not skipAnim))
		-- show selected weapon preview if in vehicle --
		if IsPedInAnyVehicle(ped, false) then
			SendNUIMessage({
				type = "showSelectedItemPreview",
				itemName = item.name,
				ammoCount = toGiveAmmo
			})
		end
	end
end)

RegisterNetEvent("interaction:equipWeapon")
AddEventHandler("interaction:equipWeapon", function(item, equip, ammoAmount, playAnim, equipNow)
	local ped = GetPlayerPed(-1)
	if equipNow == nil then
		equipNow = true
	end
	if equip then
		local currentWeaponAmmo = (ammoAmount or (item.magazine and item.magazine.currentCapacity) or 0)
		print("equipping wep with ammo count: " .. currentWeaponAmmo)
		GiveWeaponToPed(ped, item.hash, currentWeaponAmmo, false, equipNow)
		if item.components then
			if #item.components > 0 then
				for x = 1, #item.components do
					GiveWeaponComponentToPed(ped, item.hash, GetHashKey(item.components[x]))
				end
			end
		end
		if item.tint then
			SetPedWeaponTintIndex(ped, item.hash, item.tint)
		end
		if item.magazine and item.magazine.magComponent then
			GiveWeaponComponentToPed(ped, item.hash, GetHashKey(item.magazine.magComponent))
		end
		SetPedAmmo(ped, item.hash, currentWeaponAmmo)
		SetAmmoInClip(ped, item.hash, currentWeaponAmmo)
		if playAnim then
			exports["usa_holster"]:handleHolsterAnim()
		end
		if IsPedInAnyVehicle(ped, true) then
			SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
			SetCurrentPedWeapon(ped, item.hash, true)
		end
	else
		RemoveWeaponFromPed(ped, item.hash)
		SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
	end
end)

function getVehicleInsideOrInFrontOfUser()
	local ped = GetPlayerPed(-1)
	local coordA = GetEntityCoords(ped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)
	if IsPedInAnyVehicle(ped, true) then
		targetVehicle = GetVehiclePedIsIn(ped, true)
	end
	return targetVehicle
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

-- implement somehow
local draggingHelper = {
	dragging = false,
	targetId = 0
}

function EnableGui(target_vehicle_plate, goToPage)
	local me = PlayerPedId()
	SetNuiFocus(true, true)
	menuEnabled = true
	SetPedCanSwitchWeapon(me, not menuEnabled)
	local nearestPlayer = nil
	if playerName ~= "" then
		nearestPlayer = {
			name = playerName,
			id = playerServerId
		}
	end
	SendNUIMessage({
		type = "enableui",
		enable = true,
		nearestPlayer = nearestPlayer,
		voip = voipLevel,
		target_vehicle_plate = target_vehicle_plate,
		isInVehicle = IsPedInAnyVehicle(me, true),
		isCuffed = IsPedCuffed(me),
		goToPage = goToPage
	})
	if target_vehicle_plate then
		TriggerServerEvent("vehicle:AddPersonToInventory", target_vehicle_plate)
	end
end

function DisableGui()
	TransitionFromBlurred(1000)
	SetNuiFocus(false, false)
	menuEnabled = false
	SetPedCanSwitchWeapon(GetPlayerPed(-1), not menuEnabled)
end

-- event handlers
RegisterNetEvent("interaction:setF1VoipLevel")
AddEventHandler("interaction:setF1VoipLevel", function(level)
	voipLevel = level
end)

--[[ Not Used Yet
RegisterNetEvent("interaction:performPoliceAction")
AddEventHandler("interaction:performPoliceAction", function(action, unseatIndex)
	if action == "cuff" then
		if playerServerId ~= 0 then
			TriggerServerEvent("cuff:Handcuff", playerServerId)
		else
			TriggerEvent("usa:notify", "No player found to cuff!")
		end
	elseif action == "drag" then
		if playerServerId ~= 0 then
			TriggerServerEvent("dr:dragPlayer", playerServerId)
			draggingHelper.dragging = not draggingHelper.dragging
			draggingHelper.targetId = playerServerId
		end
	elseif action == "search" then
		if playerServerId ~= 0 then
			local source = GetPlayerServerId(PlayerId())
			TriggerServerEvent("search:searchPlayer", source, playerServerId)
		end
	elseif action == "mdt" then
		if playerServerId ~= 0 then
			local source = GetPlayerServerId(PlayerId())
			TriggerServerEvent("license:searchForLicense", source, playerServerId)
		end
	elseif action == "place" then
		if draggingHelper.dragging then
			local source = GetPlayerServerId(PlayerId())
			TriggerServerEvent("place:placePerson", draggingHelper.targetId)
		else
			print("no player found to place, must be dragging them!")
		end
	elseif action == "unseat" then
		local driverSeatPlayerId = 0
		local passengerSeatPlayerId = 0
		local backLeftPlayerId = 0
		local backRightPlayerId = 0
		local playerIdToUnseat = 0
		-- compare against all active players
		for x = 0, 255 do
			if NetworkIsPlayerActive(x) then
				playerName = GetPlayerName(x)
				playerServerId = GetPlayerServerId(x)
				targetPed = GetPlayerPed(x)
				targetPedCoords = GetEntityCoords(targetPed, false)
				distanceToTargetPed = Vdist(playerPedCoords.x, playerPedCoords.y, playerPedCoords.z, targetPedCoords.x, targetPedCoords.y, targetPedCoords.z)
				if GetPedInVehicleSeat(hitHandleVehicle, -1) == targetPed then
					driverSeatPlayerId = playerServerId
				elseif GetPedInVehicleSeat(hitHandleVehicle, 0) == targetPed then
					passengerSeatPlayerId = playerServerId
				elseif GetPedInVehicleSeat(hitHandleVehicle, 1) == targetPed then
					backLeftPlayerId = playerServerId
				elseif GetPedInVehicleSeat(hitHandleVehicle, 2) == targetPed then
					backRightPlayerId = playerServerId
				end
			end
		end
		-- unseat proper position
		if unseatIndex == "front left" then
			TriggerServerEvent("place:unseatPerson", driverSeatPlayerId)
			playerIdToUnseat = driverSeatPlayerId
		elseif unseatIndex == "front right" then
			TriggerServerEvent("place:unseatPerson", passengerSeatPlayerId)
			playerIdToUnseat = passengerSeatPlayerId
		elseif unseatIndex == "back left" then
			TriggerServerEvent("place:unseatPerson", backLeftPlayerId)
			playerIdToUnseat = backLeftPlayerId
		elseif unseatIndex == "back right" then
			TriggerServerEvent("place:unseatPerson", backRightPlayerId)
			playerIdToUnseat = backRightPlayerId
		end
		-- drag them
		if draggingHelper.targetId ~= playerIdToUnseat then
			TriggerServerEvent("dr:dragPlayer", playerIdToUnseat)
			draggingHelper.dragging = true
			draggingHelper.targetId = playerIdToUnseat
		end
	elseif action == "impound" then
		if hitHandleVehicle ~= 0 then
			TriggerServerEvent("impound:impoundVehicle", hitHandleVehicle, GetVehicleNumberPlateText(hitHandleVehicle))
			SetEntityAsMissionEntity(hitHandleVehicle, true, true)
			DeleteEntity(hitHandleVehicle)
		else
			TriggerEvent("usa:notify", "No vehicle detected!")
		end
	elseif action == "seize veh" then
		local veh = getVehicleInsideOrInFrontOfUser()
		local plate = GetVehicleNumberPlateText(veh)
		TriggerServerEvent("vehicle:removeAllIllegalItems", plate)
	end
end)
--]]

RegisterNetEvent("interaction:seizeVehContraband")
AddEventHandler("interaction:seizeVehContraband", function()
	local veh = getVehicleInsideOrInFrontOfUser()
	local plate = GetVehicleNumberPlateText(veh)
	plate = exports.globals:trim(plate)
	TriggerServerEvent("vehicle:removeAllIllegalItems", plate)
end)

RegisterNetEvent("interaction:seizeVeh")
AddEventHandler("interaction:seizeVeh", function(arg)
	local veh = getVehicleInsideOrInFrontOfUser()
	local plate = GetVehicleNumberPlateText(veh)
	if plate then
		plate = exports.globals:trim(plate)
		TriggerServerEvent("vehicle:seizeVeh", plate, arg)
	else
		exports.globals:notify("No vehicle found")
	end
end)

local last_tackle_time = 0
local tackle_delay = 5000 -- 5 second delay
local lastClosest = nil

Citizen.CreateThread(function()
	while true do
		Wait(500)
		-- get closest player server id --
		playerServerId, playerName, distanceToClosestTargetPed = GetClosestPlayerInfo(1.5)
		-- update the GUI's nearest player info --
		if not lastClosest or lastClosest.name ~= playerName then
			lastClosest = {
				id = playerServerId,
				name = playerName
			}
			SendNUIMessage({
				type = "updateNearestPlayer",
				nearest = lastClosest
			})
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		playerPed = GetPlayerPed(-1)
		playerPedCoords = GetEntityCoords(playerPed, false)

		-- highlight closest person when menu open --
		if menuEnabled then
			if closestPed ~= nil then
				local coords = GetEntityCoords(closestPed, true)
				DrawMarker(27, coords.x, coords.y, coords.z - 0.96, 0, 0, 0, 0, 0, 0, 0.71, 0.71, 0.71, 255 --[[r]], 105 --[[g]], 180 --[[b]], 90 --[[alpha]], 0, 0, 2, 0, 0, 0, 0)
			end
		end

		-- watch for open/close menu --
		if IsControlJustPressed(0, MENU_KEY1) and GetLastInputMethod(2) and not busy then
			hitHandleVehicle, distance = getVehicleInsideOrInFrontOfUser()
			local target_veh_plate = GetVehicleNumberPlateText(hitHandleVehicle)
			target_veh_plate = exports.globals:trim(target_veh_plate)
			EnableGui(target_veh_plate)
			SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
			exports["usa_holster"]:handleHolsterAnim()
			TriggerEvent("hotkeys:setCurrentSlotPassive", nil)
		end

		-- tackling --
		if IsControlJustPressed( 0, TACKLE_KEY ) and GetLastInputMethod(2) and GetEntitySpeed(playerPed) >= 1.0 then
			if not IsEntityDead(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
				playerServerId, playerName, distanceToClosestTargetPed = GetClosestPlayerInfo(1.5)
				if playerServerId ~= 0 then
					if distanceToClosestTargetPed < exports["globals"]:MaxTackleDistance() then
						if not IsPedRagdoll(GetPlayerPed(-1)) and not IsPedCuffed(GetPlayerPed(-1)) then
							if GetGameTimer() > last_tackle_time + tackle_delay then
								local fwdvector = GetEntityForwardVector(PlayerPedId())
								TriggerServerEvent("interaction:tackle", playerServerId, fwdvector.x, fwdvector.y, fwdvector.z)
								local randomTackleTime = math.random(2000, 3000)
								SetPedToRagdollWithFall(playerPed, randomTackleTime, randomTackleTime, 0, fwdvector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
								last_tackle_time = GetGameTimer()
							else
								local seconds_left = ((last_tackle_time + tackle_delay) - GetGameTimer())/1000
								TriggerEvent("usa:notify", "Please wait " .. math.floor(seconds_left) .. " more seconds!") -- need to test tackle delay!!!
							end
						end
					else
						TriggerEvent("usa:notify", "Player too far to tackle!")
					end
				else
					TriggerEvent("usa:notify", "No player found to tackle!")
				end
			end
		end

		if IsPedRagdoll(playerPed) then
			DisableControlAction(0, 19, true)
		end

		-- menu
		if menuEnabled then
			DisableControlAction(29, 241, menuEnabled)
			DisableControlAction(29, 242, menuEnabled)
			DisableControlAction(0, 1, menuEnabled)
			DisableControlAction(0, 2, menuEnabled)
			DisableControlAction(0, 142, menuEnabled)
			DisableControlAction(0, 106, menuEnabled)
			--if IsDisabledControlJustReleased(0, 142) then
				--SendNUIMessage({
					--type = "click"
				--})
			--end
		end

		Citizen.Wait(0)
	end
end)

RegisterNetEvent('interaction:tackleMe')
AddEventHandler('interaction:tackleMe', function(fwdVectorX, fwdVectorY, fwdVectorZ)
	local randomTackleTime = math.random(2000, 3000)
	SetPedToRagdollWithFall(PlayerPedId(), randomTackleTime, randomTackleTime, 0, fwdVectorX, fwdVectorY, fwdVectorZ, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
end)

RegisterNetEvent('interaction:setBusy')
AddEventHandler('interaction:setBusy', function(isBusy)
	busy = isBusy
end)

RegisterNUICallback('performAction', function(data, cb)
	local action = data.action
	if not data.isVehicleAction then
		if ACTIONS[action] then
			ACTIONS[action]()
		else
			print("interaction-menu: ERROR - Trying to use undefined action! Tell the server owner or a developer.")
		end
	elseif data.isVehicleAction then
		local parent = data.parentMenu
		if parent and parent ~= "Vehicle Actions" then
			if VEH_ACTIONS[parent][action] then
				VEH_ACTIONS[parent][action]()
			else
				print("interaction-menu: ERROR - Trying to use undefined vehicle action! Tell the server owner or a developer. Parent.")
			end
		else
			if VEH_ACTIONS[action] then
				VEH_ACTIONS[action]()
			else
				print("interaction-menu: ERROR - Trying to use undefined vehicle action! Tell the server owner or a developer. No parent.")
			end
		end
	end
end)

function GetClosestPlayerInfo(distance)
	local closestDistance = 0
	local closestPlayerServerId = 0
	local closestName = ""
	closestPed = nil
	for x = 0, 255 do
		if NetworkIsPlayerActive(x) then
			targetPed = GetPlayerPed(x)
			targetPedCoords = GetEntityCoords(targetPed, false)
			distanceToTargetPed = Vdist(playerPedCoords.x, playerPedCoords.y, playerPedCoords.z, targetPedCoords.x, targetPedCoords.y, targetPedCoords.z)
			if targetPed ~= GetPlayerPed(-1) then
				if distanceToTargetPed < distance then
					if closestDistance == 0 then
						closestDistance = distanceToTargetPed
						closestPlayerServerId = GetPlayerServerId(x)
						closestName = GetPlayerName(x)
						closestPed = GetPlayerPed(x)
					else
						if distanceToTargetPed <= closestDistance then
							closestDistance = distanceToTargetPed
							closestPlayerServerId = GetPlayerServerId(x)
							closestName = GetPlayerName(x)
							closestPed = GetPlayerPed(x)
						end
					end
				end
			end
		end
	end
	return closestPlayerServerId, closestName, closestDistance
end

function DrawSpecialText(m_text)
  ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(250, 1)
end

function AttachEntityToPed(prop,bone_ID,x,y,z,RotX,RotY,RotZ)
		local hashed = GetHashKey(prop)

		RequestModel(hashed)
		while not HasModelLoaded(hashed) do
			Citizen.Wait(100)
		end

		local me = GetPlayerPed(-1)
		BoneID = GetPedBoneIndex(me, bone_ID)
		obj = CreateObject(hashed,  1729.73,  6403.90,  34.56,  true,  true,  false)
		Wait(1000)
		AttachEntityToEntity(obj,  me,  BoneID, x,y,z, RotX,RotY,RotZ,  1, 1, false, false, 0, true)
		return netid
end

function DrawTimer(beginTime, duration, x, y, text)
    if not HasStreamedTextureDictLoaded('timerbars') then
        RequestStreamedTextureDict('timerbars')
        while not HasStreamedTextureDictLoaded('timerbars') do
            Citizen.Wait(0)
        end
    end

    if GetTimeDifference(GetGameTimer(), beginTime) < duration then
        w = (GetTimeDifference(GetGameTimer(), beginTime) * (0.085 / duration))
    end

    local correction = ((1.0 - math.floor(GetSafeZoneSize(), 2)) * 100) * 0.005
    x, y = x - correction, y - correction

    Set_2dLayer(0)
    DrawSprite('timerbars', 'all_black_bg', x, y, 0.15, 0.0325, 0.0, 255, 255, 255, 180)

    Set_2dLayer(1)
    DrawRect(x + 0.0275, y, 0.085, 0.0125, 100, 0, 0, 180)

    Set_2dLayer(2)
    DrawRect(x - 0.015 + (w / 2), y, w, 0.0125, 150, 0, 0, 180)

    SetTextColour(255, 255, 255, 180)
    SetTextFont(0)
    SetTextScale(0.3, 0.3)
    SetTextCentre(true)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    Set_2dLayer(3)
    DrawText(x - 0.06, y - 0.012)
end

function IsAreaPopulated()
	local AREAS = {
		{x = 1491.839, y = 3112.53, z = 40.656, range = 330}, -- sandy shores airport area // 75 - 150 probably range
		{x = 151.62, y = 1038.808, z = 32.735, range = 1200}, -- los santos // 600 - 900 ish?
		{x = -3161.96, y = 790.088, z = 6.824, range = 650}, -- west coast, NW of los santos // 300 - 400 ish?
		{x = 2356.744, y = 4776.75, z = 34.613, range = 600}, -- grape seed // 350 - 450 ish?
		{x = 145.209, y = 6304.922, z = 40.277, range = 650}, -- paleto bay // 500 - 600
		{x = -1070.5, y = 5323.5, z = 46.339, range = 700}, -- S of Paleto Bay // 350 - 500 ish
		{x = -2550.21, y = 2321.747, z = 33.059, range = 350}, -- west of map, gas station // 100 - 200
		{x = 1927.374, y = 3765.77, z = 32.309, range = 350}, -- sandy shores
		{x = 895.649, y = 2697.049, z = 41.985, range = 200}, -- harmony
		{x = -1093.773, y = -2970.00, z = 13.944, range = 300}, -- LS airport
		{x = 1070.506, y = -3111.021, z = 5.9, range = 450} -- LS ship cargo area
	}
	local my_coords = GetEntityCoords(me, true)
	for k = 1, #AREAS do
		if Vdist(my_coords.x, my_coords.y, my_coords.z, AREAS[k].x, AREAS[k].y, AREAS[k].z) <= AREAS[k].range then
			--print("within range of populated area!")
			return true
		end
	end
	return false
end

function DrawTimer(beginTime, duration, x, y, text)
    if not HasStreamedTextureDictLoaded('timerbars') then
        RequestStreamedTextureDict('timerbars')
        while not HasStreamedTextureDictLoaded('timerbars') do
            Citizen.Wait(0)
        end
    end

    if GetTimeDifference(GetGameTimer(), beginTime) < duration then
        w = (GetTimeDifference(GetGameTimer(), beginTime) * (0.085 / duration))
    end

    local correction = ((1.0 - math.floor(GetSafeZoneSize(), 2)) * 100) * 0.005
    x, y = x - correction, y - correction

    Set_2dLayer(0)
    DrawSprite('timerbars', 'all_black_bg', x, y, 0.15, 0.0325, 0.0, 255, 255, 255, 180)

    Set_2dLayer(1)
    DrawRect(x + 0.0275, y, 0.085, 0.0125, 100, 0, 0, 180)

    Set_2dLayer(2)
    DrawRect(x - 0.015 + (w / 2), y, w, 0.0125, 150, 0, 0, 180)

    SetTextColour(255, 255, 255, 180)
    SetTextFont(0)
    SetTextScale(0.3, 0.3)
    SetTextCentre(true)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    Set_2dLayer(3)
    DrawText(x - 0.06, y - 0.012)
end

function playHealingAnimation(ped)
	exports.globals:loadAnimDict("combat@damage@injured_pistol@to_writhe")
	TaskPlayAnim(ped, "combat@damage@injured_pistol@to_writhe", "variation_b", 8.0, 1, -1, 49, 0, 0, 0, 0)
	Wait(5000)
	StopAnimTask(ped, "combat@damage@injured_pistol@to_writhe", "variation_b", 1.0)
end

function isMeleeWeapon(wepHash)
    local MELEE_WEPS = {
        [`WEAPON_FLASHLIGHT`] = true,
        [`WEAPON_HAMMER`] = true,
        [`WEAPON_KNIFE`] = true,
        [`WEAPON_BAT`] = true,
        [`WEAPON_CROWBAR`] = true,
        [`WEAPON_HATCHET`] = true,
        [`WEAPON_WRENCH`] = true,
        [`WEAPON_MACHETE`] = true,
        [`WEAPON_KATANAS`] = true,
        [`WEAPON_SHIV`] = true
    }
    return (MELEE_WEPS[wepHash] or false)
end

function getVehicleInFrontOfUser()
	local playerped = GetPlayerPed(-1)
	local coordA = GetEntityCoords(playerped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)
	return targetVehicle
end
