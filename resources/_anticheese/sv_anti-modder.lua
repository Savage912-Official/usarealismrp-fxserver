local LOG_ENTITY_CREATION = true
local LOG_EXPLOSIONS = false

local BLACKLISTED_MODELS = {
    ["prop_fnclink_05crnr1"] = true,
	["xs_prop_hamburgher_wl"] = true,
	["xs_prop_plastic_bottle_wl"] = true,
	--["prop_windmill_01"] = true,
	["p_spinning_anus_s"] = true,
	["stt_prop_ramp_adj_flip_m"] = true,
	["stt_prop_ramp_adj_flip_mb"] = true,
	["stt_prop_ramp_adj_flip_s"] = true,
	["stt_prop_ramp_adj_flip_sb"] = true,
	["stt_prop_ramp_adj_hloop"] = true,
	["stt_prop_ramp_adj_loop"] = true,
	["stt_prop_ramp_jump_l"] = true,
	["stt_prop_ramp_jump_m"] = true,
	["stt_prop_ramp_jump_s"] = true,
	["stt_prop_ramp_jump_xl"] = true,
	["stt_prop_ramp_jump_xs"] = true,
	["stt_prop_ramp_jump_xxl"] = true,
	["stt_prop_ramp_multi_loop_rb"] = true,
	["stt_prop_ramp_spiral_l"] = true,
	["stt_prop_ramp_spiral_l_l"] = true,
	["stt_prop_ramp_spiral_l_m"] = true,
	["stt_prop_ramp_spiral_l_s"] = true,
	["stt_prop_ramp_spiral_l_xxl"] = true,
	["stt_prop_ramp_spiral_m"] = true,
	["stt_prop_ramp_spiral_s"] = true,
    ["stt_prop_ramp_spiral_xxl"] = true,
    ["stt_prop_stunt_jump_loop"] = true,
    ["stt_prop_stunt_jump30"] = true,
    ["stt_prop_stunt_jump45"] = true,
    ["stt_prop_stunt_jump15"] = true,
    ["stt_prop_stunt_track_bumps"] = true,
    ["stt_prop_stunt_track_dwlink_02"] = true,
    ["stt_prop_stunt_track_cutout"] = true,
    ["stt_prop_stunt_track_dwlink"] = true,
    ["stt_prop_stunt_track_dwslope15"] = true,
    ["stt_prop_stunt_track_dwshort"] = true,
    ["stt_prop_stunt_track_dwsh15"] = true,
    ["stt_prop_stunt_track_dwslope30"] = true,
    ["stt_prop_stunt_track_dwslope45"] = true,
    ["stt_prop_stunt_track_dwturn"] = true,
    ["stt_prop_stunt_track_dwuturn"] = true,
    ["stt_prop_stunt_track_exshort"] = true,
    ["stt_prop_stunt_track_fork"] = true,
    ["stt_prop_stunt_track_funlng"] = true,
    ["stt_prop_stunt_track_funnel"] = true,
    ["stt_prop_stunt_track_hill"] = true,
    ["stt_prop_stunt_track_hill2"] = true,
    ["stt_prop_stunt_track_jump"] = true,
    ["stt_prop_stunt_track_link"] = true,
    ["stt_prop_stunt_track_otake"] = true,
    ["stt_prop_stunt_track_sh15"] = true,
    ["stt_prop_stunt_track_sh30"] = true,
    ["stt_prop_stunt_track_sh45"] = true,
    ["stt_prop_stunt_track_sh45_a"] = true,
    ["stt_prop_stunt_track_short"] = true,
    ["stt_prop_stunt_track_slope15"] = true,
    ["stt_prop_stunt_track_slope30"] = true,
    ["stt_prop_stunt_track_slope45"] = true,
    ["stt_prop_stunt_track_st_01"] = true,
    ["stt_prop_stunt_track_st_02"] = true,
    ["stt_prop_stunt_track_start"] = true,
    ["stt_prop_stunt_track_start_02"] = true,
    ["stt_prop_stunt_track_straight"] = true,
    ["stt_prop_stunt_track_straightice"] = true,
    ["stt_prop_stunt_track_turn"] = true,
    ["stt_prop_stunt_track_turnice"] = true,
    ["stt_prop_stunt_track_uturn"] = true,
    ["stt_prop_stunt_tube_crn"] = true,
    ["stt_prop_stunt_tube_crn_15d"] = true,
    ["cargoplane"] = true,
    --["jet"] = true,
    -- buildings
    ["dt1_02_w01"] = true,
    ["dt1_02_ground"] = true,
    ["dt1_02_groundb"] = true,
    ["dt1_02_ground_ns"] = true,
    ["dt1_03_build1x"] = true,
    ["dt1_03_build1_ns"] = true,
    ["dt1_03_build2"] = true,
    ["dt1_03_build2top"] = true,
    ["dt1_03_shadow"] = true,
    ["dt1_04_build"] = true,
    ["dt1_05_build1_damage"] = true,
    ["dt1_05_build1_damage_lod"] = true,
    ["dt1_05_build1_h"] = true,
    ["dt1_05_build1_repair"] = true,
    ["dt1_05_build1_repair_slod"] = true,
    ["dt1_05_build2_h"] = true,
    ["dt1_05_carparkshell"] = true,
    ["dt1_05_carpark_details"] = true,
    ["dt1_05_carpark_reflect"] = true,
    ["dt1_05_ground"] = true,
    ["dt1_05_rubble"] = true,
    ["dt1_06_build1_1"] = true,
    ["dt1_06_build1b_1"] = true,
    ["dt1_06_build2_1"] = true,
    ["dt1_06_build3_1"] = true,
    ["dt1_07_building2"] = true,
    ["dt1_07_grounda"] = true,
    ["dt1_07_groundb"] = true,
    ["dt1_08_ground2"] = true,
    ["dt1_09_building_01"] = true,
    ["dt1_09_building_03"] = true,
    ["dt1_09_carpark"] = true,
    ["dt1_10_build1"] = true,
    ["dt1_10_build2"] = true,
    ["dt1_10_build3"] = true,
    ["dt1_11_dt1_tower"] = true,
    ["dt1_11_build_logo"] = true,
    ["dt1_11_dt1_planter"] = true,
    ["dt1_11_dt1_planter_lod"] = true,
    ["dt1_11_dt1_plaza"] = true,
    ["dt1_11_dt1_plaza_gr"] = true,
    ["dt1_12_build1"] = true,
    ["dt1_12_build2"] = true,
    ["dt1_12_build3"] = true,
    ["dt1_12_build6"] = true,
    ["dt1_13_build1"] = true,
    ["dt1_13_build2"] = true,
    ["dt1_14_build2"] = true,
    ["dt1_14_build3"] = true,
    ["dt1_14_build4"] = true,
    ["dt1_15_build1"] = true,
    ["dt1_17_build1"] = true,
    ["dt1_17_build2"] = true,
    ["dt1_18_build0"] = true,
    ["dt1_18_build1"] = true,
    ["dt1_18_build2"] = true,
    ["dt1_18_build3"] = true,
    ["dt1_18_build4"] = true,
    ["dt1_20_build1"] = true,
    ["dt1_20_build2"] = true,
    ["dt1_20_build2b"] = true,
    ["dt1_20_ground"] = true,
    ["dt1_20_ground2"] = true,
    ["dt1_20_sc1"] = true,
    ["dt1_20_sc2"] = true,
    ["dt1_20_sc3"] = true,
    ["dt1_21_b1d_y1"] = true,
    ["dt1_21_b1_dx10"] = true,
    ["dt1_21_b1_dx11"] = true,
    ["dt1_21_b1_dx12"] = true,
    ["dt1_21_b1_dx13"] = true,
    ["dt1_21_b1_dx14"] = true,
    ["dt1_21_b1_dx3"] = true,
    ["dt1_21_b1_dx4"] = true,
    ["dt1_21_b1_dx5"] = true,
    ["dt1_21_b1_dx6"] = true,
    ["dt1_21_b9_d1"] = true,
    ["dt1_21_beams"] = true,
    ["dt1_21_beamx"] = true,
    ["dt1_21_build09"] = true,
    ["dt1_21_build09d"] = true,
    ["dt1_21_build1"] = true,
    ["dt1_21_build1z"] = true,
    ["dt1_21_gd1_d002"] = true,
    ["dt1_21_gd1_d002_d"] = true,
    ["dt1_21_gd1_dz1"] = true,
    ["dt1_21_gd1_dz2"] = true,
    ["dt1_21_gd1_dz3"] = true,
    ["dt1_21_gd1_dz4"] = true,
    ["dt1_21_gd1_dz5"] = true,
    ["dt1_21_ground1"] = true,
    ["dt1_21_ground2"] = true,
    ["dt1_21_sbar1"] = true,
    ["dt1_21_sbar2"] = true,
    ["dt1_21_scafa"] = true,
    ["dt1_21_scafc"] = true,
    ["dt1_21_scafd"] = true,
    ["dt1_21_scaffold_01"] = true,
    ["dt1_21_scaffold_02"] = true,
    ["dt1_21_scaffold_03"] = true,
    ["dt1_21_scaffold_05"] = true,
    ["dt1_21_scaffold_06"] = true,
    ["dt1_21_scaffold_07"] = true,
    ["dt1_21_scaffold_08"] = true,
    ["dt1_21_scaffold_09"] = true,
    ["dt1_21_scaffold_10"] = true,
    ["dt1_21_scaffold_11"] = true,
    ["dt1_21_scaffold_44"] = true,
    ["dt1_21_station"] = true,
    ["dt1_21_top_shell"] = true,
    ["dt1_21_unf"] = true,
    ["dt1_22_bldg1"] = true,
    ["dt1_22_bldg1b"] = true
}

local BLACKLISTED_HASHES = {}

for model, isBlacklisted in pairs(BLACKLISTED_MODELS) do
    BLACKLISTED_HASHES[GetHashKey(model)] = true
end

-- log explosions for now --
AddEventHandler('explosionEvent', function(sender, ev)
    if LOG_EXPLOSIONS then
        print("explosion detected!")
        print(exports.globals:dump(ev))
        --CancelEvent()
    end
end)

-- log entity creations on toggle for now --
AddEventHandler('entityCreating', function(entity)
    if LOG_ENTITY_CREATION then
        local src = NetworkGetEntityOwner(entity)
        local createdEntityModel = GetEntityModel(entity)
        if BLACKLISTED_HASHES[createdEntityModel] then
            print("[anticheese] blacklisted entity with model of " .. createdEntityModel .. " was created by src: " .. src)
            local reason = "Spawning Entities [model: " .. createdEntityModel .. "]"
            local minipunchDiscordID = "<@178016707292561409>"
            local WEBHOOK_URL = GetConvar("ban-log-webhook", "")
            local msg = 'Player id [' .. src .. ' / ' .. (GetPlayerIdentifiers(src)[1] or 'N/A') .. '] was banned for anticheese violation!'
            exports.globals:SendDiscordLog(WEBHOOK_URL, msg)
            exports["es_admin"]:BanPlayer(src, "Modding (" .. reason .. "). If you feel this was a mistake please let a staff member know.")
            CancelEvent()
        end
    end
end)


AddEventHandler('rconCommand', function(cmd, args)
    if cmd == 'logentities' then
        LOG_ENTITY_CREATION = not LOG_ENTITY_CREATION
        print("Logging Entities: " .. tostring(LOG_ENTITY_CREATION))
    elseif cmd == 'logexplosions' then 
        LOG_EXPLOSIONS = not LOG_EXPLOSIONS
        print("Logging Entities: " .. tostring(LOG_EXPLOSIONS))
    end
end)