DP = {}

DP.Expressions = {
   ["Angry"] = {"Expression", "mood_angry_1"},
   ["Drunk"] = {"Expression", "mood_drunk_1"},
   ["Dumb"] = {"Expression", "pose_injured_1"},
   ["Electrocuted"] = {"Expression", "electrocuted_1"},
   ["Grumpy"] = {"Expression", "effort_1"},
   ["Grumpy2"] = {"Expression", "mood_drivefast_1"},
   ["Grumpy3"] = {"Expression", "pose_angry_1"},
   ["Happy"] = {"Expression", "mood_happy_1"},
   ["Injured"] = {"Expression", "mood_injured_1"},
   ["Joyful"] = {"Expression", "mood_dancing_low_1"},
   ["Mouthbreather"] = {"Expression", "smoking_hold_1"},
   ["Never Blink"] = {"Expression", "pose_normal_1"},
   ["One Eye"] = {"Expression", "pose_aiming_1"},
   ["Shocked"] = {"Expression", "shocked_1"},
   ["Shocked2"] = {"Expression", "shocked_2"},
   ["Sleeping"] = {"Expression", "mood_sleeping_1"},
   ["Sleeping2"] = {"Expression", "dead_1"},
   ["Sleeping3"] = {"Expression", "dead_2"},
   ["Smug"] = {"Expression", "mood_smug_1"},
   ["Speculative"] = {"Expression", "mood_aiming_1"},
   ["Stressed"] = {"Expression", "mood_stressed_1"},
   ["Sulking"] = {"Expression", "mood_sulk_1"},
   ["Weird"] = {"Expression", "effort_2"},
   ["Weird2"] = {"Expression", "effort_3"},
}

DP.Walks = {
  ["Alien"] = {"move_m@alien"},
  ["Armored"] = {"anim_group_move_ballistic"},
  ["Arrogant"] = {"move_f@arrogant@a"},
  ["Brave"] = {"move_m@brave"},
  ["Casual"] = {"move_m@casual@a"},
  ["Casual2"] = {"move_m@casual@b"},
  ["Casual3"] = {"move_m@casual@c"},
  ["Casual4"] = {"move_m@casual@d"},
  ["Casual5"] = {"move_m@casual@e"},
  ["Casual6"] = {"move_m@casual@f"},
  ["Chichi"] = {"move_f@chichi"},
  ["Confident"] = {"move_m@confident"},
  ["Cop"] = {"move_m@business@a"},
  ["Cop2"] = {"move_m@business@b"},
  ["Cop3"] = {"move_m@business@c"},
  ["Default Female"] = {"move_f@multiplayer"},
  ["Default Male"] = {"move_m@multiplayer"},
  ["Drunk"] = {"move_m@drunk@a"},
  ["Drunk"] = {"move_m@drunk@slightlydrunk"},
  ["Drunk2"] = {"move_m@buzzed"},
  ["Drunk3"] = {"move_m@drunk@verydrunk"},
  ["Femme"] = {"move_f@femme@"},
  ["Fire"] = {"move_characters@franklin@fire"},
  ["Fire2"] = {"move_characters@michael@fire"},
  ["Fire3"] = {"move_m@fire"},
--   ["Flee"] = {"move_f@flee@a"},
  ["Franklin"] = {"move_p_m_one"},
  ["Gangster"] = {"move_m@gangster@generic"},
  ["Gangster2"] = {"move_m@gangster@ng"},
  ["Gangster3"] = {"move_m@gangster@var_e"},
  ["Gangster4"] = {"move_m@gangster@var_f"},
  ["Gangster5"] = {"move_m@gangster@var_i"},
  ["Grooving"] = {"anim@move_m@grooving@"},
  ["Guard"] = {"move_m@prison_gaurd"},
  ["Handcuffs"] = {"move_m@prisoner_cuffed"},
  ["Heels"] = {"move_f@heels@c"},
  ["Heels2"] = {"move_f@heels@d"},
  ["Hiking"] = {"move_m@hiking"},
  ["Hipster"] = {"move_m@hipster@a"},
  ["Hobo"] = {"move_m@hobo@a"},
  ["Hurry"] = {"move_f@hurry@a"},
  ["Injured"] = {"move_injured_generic"},
  ["Janitor"] = {"move_p_m_zero_janitor"},
  ["Janitor2"] = {"move_p_m_zero_slow"},
  ["Jog"] = {"move_m@jog@"},
  ["Lemar"] = {"anim_group_move_lemar_alley"},
  ["Lester"] = {"move_heist_lester"},
  ["Lester2"] = {"move_lester_caneup"},
  ["Maneater"] = {"move_f@maneater"},
  ["Michael"] = {"move_ped_bucket"},
  ["Money"] = {"move_m@money"},
  ["Muscle"] = {"move_m@muscle@a"},
  ["Posh"] = {"move_m@posh@"},
  ["Posh2"] = {"move_f@posh@"},
  ["Quick"] = {"move_m@quick"},
  ["Runner"] = {"female_fast_runner"},
  ["Sad"] = {"move_m@sad@a"},
  ["Sassy"] = {"move_m@sassy"},
  ["Sassy2"] = {"move_f@sassy"},
  ["Scared"] = {"move_f@scared"},
  ["Sexy"] = {"move_f@sexy@a"},
  ["Shady"] = {"move_m@shadyped@a"},
  ["Slow"] = {"move_characters@jimmy@slow@"},
  ["Swagger"] = {"move_m@swagger"},
  ["Tough"] = {"move_m@tough_guy@"},
  ["Tough2"] = {"move_f@tough_guy@"},
  ["Trash"] = {"clipset@move@trash_fast_turn"},
  ["Trash2"] = {"missfbi4prepp1_garbageman"},
  ["Trevor"] = {"move_p_m_two"},
  ["Wide"] = {"move_m@bag"},
  ["Lean Forward"] = {"move_characters@franklin@fire"}
  -- I cant get these to work for some reason, if anyone knows a fix lmk
  --["Caution"] = {"move_m@caution"},
  --["Chubby"] = {"anim@move_m@chubby@a"},
  --["Crazy"] = {"move_m@crazy"},
  --["Joy"] = {"move_m@joy@a"},
  --["Power"] = {"move_m@power"},
  --["Sad2"] = {"anim@move_m@depression@a"},
  --["Sad3"] = {"move_m@depression@b"},
  --["Sad4"] = {"move_m@depression@d"},
  --["Wading"] = {"move_m@wading"},
}

DP.Shared = {
   --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
   -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
   -- targetemote is used for animations that have a corresponding animation to the other player.
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", "handshake2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
       SyncOffsetFront = 0.9
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", "handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Hug", "hug2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.05,
   }},
   ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Hug 2", "hug", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.13
   }},
   ["bro"] = {"mp_ped_interaction", "hugs_guy_a", "Bro", "bro2", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Bro 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["give"] = {"mp_common", "givetake1_a", "Give", "give2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["give2"] = {"mp_common", "givetake1_b", "Give 2", "give", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Baseball", "baseballthrow"},
   ["baseballthrow"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Baseball Throw", "baseball"},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Up", "stickupscared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stickupscared"] = {"missminuteman_1ig_2", "handsup_base", "Stickup Scared", "stickup", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["punch"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Punch", "punched"},
   ["punched"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Punched", "punch"},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Headbutt", "headbutted"},
   ["headbutted"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Headbutted", "headbutt"},
   ["slap2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Slap 2", "slapped2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", "slapped", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slapped"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Slapped", "slap"},
   ["slapped2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Slapped 2", "slap2"},
}

DP.Dances = {
   ["dancef"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Dance F", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Dance F2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Dance F4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Dance F5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Dance Slow 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Dance Slow 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Dance Slow 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Dance", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Dance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Dance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Dance 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceupper"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Upper", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceupper2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Dance Upper 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Dance Shy", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceshy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Dance Shy 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Dance Slow", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Dance Silly 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance6"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Dance 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Dance 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance8"] = {"missfbi3_sniping", "dance_m_default", "Dance 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Dance Silly", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Dance Silly 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Dance Silly 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Dance Silly 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Dance Silly 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Dance Silly 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Dance 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Dance Silly 8", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dancesilly7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Silly 7", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dance5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Dance 5", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["danceglowstick"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Dance Glowsticks", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceglowstick2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Dance Glowsticks 2", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["danceglowstick3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Glowsticks 3", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["dancehorse"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Dance Horse", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dancehorse2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Dance Horse 2", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["dancehorse3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Dance Horse 3", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["ashton"] = {"div@gdances@test", "ashton", "Ashton", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["charleston"] = {"div@gdances@test", "charleston", "Charleston", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["doggystrut"] = {"div@gdances@test", "doggystrut", "Strut", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dreamfeet"] = {"div@gdances@test", "dreamfeet", "Dream Feet", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["eerie"] = {"div@gdances@test", "eerie", "Eerie", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["fancyfeet"] = {"div@gdances@test", "fancyfeet", "Fancy Feet", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["festivus"] = {"div@gdances@test", "festivus", "Rave Dance", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["flamingo"] = {"div@gdances@test", "flamingo", "Flamingo", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["fresh"] = {"div@gdances@test", "fresh", "Fresh", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["getgriddy"] = {"div@gdances@test", "getgriddy", "Get Griddy", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["handstand"] = {"div@gdances@test", "handstand", "Handstand", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["imsmooth"] = {"div@gdances@test", "imsmooth", "Smooth", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["keepdance"] = {"div@gdances@test", "keepdance", "Goof Off", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["montecarlo"] = {"div@gdances@test", "montecarlo", "Monte Carlo", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["octopus"] = {"div@gdances@test", "octopus", "Octopus", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["pointydance"] = {"div@gdances@test", "pointydance", "Pointy", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["ridingdance"] = {"div@gdances@test", "ridingdance", "Riding Cowboy", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["skeldance"] = {"div@gdances@test", "skeldance", "Skeleton Dance", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["spinny"] = {"div@gdances@test", "spinny", "Spinny", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["zombiewalk"] = {"div@gdances@test", "zombiewalk", "Zombie Walk", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["woowalkinx"] = {"divined@drpack@new", "woowalkinx", "Woo Walk", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["bloodwalk"] = {"divined@drpack@new", "bloodwalk", "Blood Walk", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["cripwalk3"] = {"divined@drpack@new", "cripwalk3", "Crip Walk", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["shootit"] = {"divined@drpack@new", "shootit", "Shoot Dance", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["millyrocks"] = {"divined@drpack@new", "millyrocks", "Milly Rock", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["shmoney"] = {"divined@drpack@new", "shmoney", "Shmoney Dance", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dougie"] = {"divined@drpack@new", "dougie", "Dougie", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["haiphuthon"] = {"divined@drpack@new", "haiphuthon", "Haiphuthon", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["curvette"] = {"divined@drpack@new", "curvette", "Curvette", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["tokyochall"] = {"divined@drpack@new", "tokyochall", "Tokyo Challenge", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["thotiana"] = {"divined@drpack@new", "thotiana", "Thotiana", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["moodswings"] = {"divined@drpack@new", "moodswings", "Moodswings Dance", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["whatyouknowboutlove"] = {"divined@drpack@new", "whatyouknowboutlove", "Pop Love", AnimationOptions =
   {
       EmoteLoop = true
   }},
}

DP.Emotes = {
   ["drink"] = {"mp_player_inteat@pnq", "loop", "Drink", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["beast"] = {"anim@mp_fm_event@intro", "beast_transform", "Beast", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000,
   }},
   ["chill"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Chill", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cloudgaze"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Cloudgaze", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cloudgaze2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Cloudgaze 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["prone"] = {"missfbi3_sniping", "prone_dave", "Prone", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pullover"] = {"misscarsteal3pullover", "pull_over_right", "Pullover", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["idle"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Idle", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Idle 8"},
   ["idle9"] = {"friends@fra@ig_1", "base_idle", "Idle 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle10"] = {"mp_move@prostitute@m@french", "idle", "Idle 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["idle11"] = {"random@countrysiderobbery", "idle_a", "Idle 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle2"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "Idle 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle3"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Idle 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle4"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Idle 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle5"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Idle 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle6"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Idle 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle7"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Idle 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait3"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Wait 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Idle Drunk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Idle Drunk 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk3"] = {"missarmenian2", "standing_idle_loop_drunk", "Idle Drunk 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["airguitar"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "Air Guitar"},
   ["airsynth"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "Air Synth"},
   ["argue"] = {"misscarsteal4@actor", "actor_berating_loop", "Argue", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["argue2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Argue 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bartender"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "Bartender", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["blowkiss"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Blow Kiss"},
   ["blowkiss2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Blow Kiss 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000

   }},
   ["curtsy"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Curtsy"},
   ["bringiton"] = {"misscommon@response", "bring_it_on", "Bring It On", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["comeatmebro"] = {"mini@triathlon", "want_some_of_this", "Come at me bro", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["cop2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Cop 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cop3"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "Cop 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["crossarms"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Crossarms", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Crossarms 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["crossarms3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Crossarms 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms4"] = {"random@street_race", "_car_b_lookout", "Crossarms 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Crossarms 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["foldarms2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Fold Arms 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms6"] = {"random@shop_gunstore", "_idle", "Crossarms 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["foldarms"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "Fold Arms", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarmsside"] = {"rcmnigel1a_band_groupies", "base_m2", "Crossarms Side", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["damn"] = {"gestures@m@standing@casual", "gesture_damn", "Damn", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["damn2"] = {"anim@am_hold_up@male", "shoplift_mid", "Damn 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["pointdown"] = {"gestures@f@standing@casual", "gesture_hand_down", "Point Down", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["surrender"] = {"random@arrests@busted", "idle_a", "Surrender", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["facepalm2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "Facepalm 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Facepalm", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm3"] = {"missminuteman_1ig_2", "tasered_2", "Facepalm 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Facepalm 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["fallover"] = {"random@drunk_driver_1", "drunk_fall_over", "Fall Over"},
   ["fallover2"] = {"mp_suicide", "pistol", "Fall Over 2"},
   ["fallover3"] = {"mp_suicide", "pill", "Fall Over 3"},
   ["fallover4"] = {"friends@frf@ig_2", "knockout_plyr", "Fall Over 4"},
   ["fallover5"] = {"anim@gangops@hostage@", "victim_fail", "Fall Over 5"},
   ["fallasleep"] = {"mp_sleep", "sleep_loop", "Fall Asleep", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["fightme"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Fight Me"},
   ["fightme2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Fight Me 2"},
   ["finger"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Finger", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["finger2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Finger 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["wait4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Wait 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait5"] = {"missclothing", "idle_storeclerk", "Wait 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Wait 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait7"] = {"rcmnigel1cnmt_1c", "base", "Wait 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait8"] = {"rcmjosh1", "idle", "Wait 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait9"] = {"rcmjosh2", "josh_2_intp1_base", "Wait 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Wait 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait11"] = {"misshair_shop@hair_dressers", "keeper_base", "Wait 11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hiking"] = {"move_m@hiking", "idle", "Hiking", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Hug"},
   ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Hug 2"},
   ["hug3"] = {"mp_ped_interaction", "hugs_guy_a", "Hug 3"},
   ["inspect"] = {"random@train_tracks", "idle_e", "Inspect"},
   ["jazzhands"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "Jazzhands", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["jog2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Jog 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Jog 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Jog 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog5"] = {"move_m@joy@a", "walk", "Jog 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jumpingjacks"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "Jumping Jacks", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel2"] = {"rcmextreme3", "idle", "Kneel 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "Kneel 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knock"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "Knock", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["knock2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Knock 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knucklecrunch"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Knuckle Crunch", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance"] = {"mp_safehouse", "lap_dance_girl", "Lapdance"},
   ["lean2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Lean 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Lean 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Lean 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Lean 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanflirt"] = {"random@street_race", "_car_a_flirt_girl", "Lean Flirt", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar2"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "Lean Bar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar3"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "Lean Bar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar4"] = {"anim@heists@prison_heist", "ped_b_loop_a", "Lean Bar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanhigh"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Lean High", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanhigh2"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Lean High 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside"] = {"timetable@mime@01_gc", "idle_a", "Leanside", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside2"] = {"misscarstealfinale", "packer_idle_1_trevor", "Leanside 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leanside 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leanside 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["leanside5"] = {"rcmjosh2", "josh_2_intp1_base", "Leanside 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["me"] = {"gestures@f@standing@casual", "gesture_me_hard", "Me", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["mechanic"] = {"mini@repair", "fixing_a_ped", "Mechanic", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mechanic2"] = {"amb@world_human_vehicle_mechanic@male@base", "base", "Mechanic 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mechanic3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanic 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mechanic4"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanic 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["medic2"] = {"amb@medic@standing@tendtodead@base", "base", "Medic 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["meditate"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Meditiate", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Meditiate 2", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate3"] = {"rcmepsilonism3", "base_loop", "Meditiate 3", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["metal"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "Metal", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no"] = {"anim@heists@ornate_bank@chat_manager", "fail", "No", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "No 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nosepick"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Nose Pick", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["noway"] = {"gestures@m@standing@casual", "gesture_no_way", "No Way", AnimationOptions =
   {
       EmoteDuration = 1500,
       EmoteMoving = true,
   }},
   ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "OK", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["outofbreath"] = {"re@construction", "out_of_breath", "Out of Breath", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pickup"] = {"random@domestic", "pickup_low", "Pickup"},
   ["push"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "Push", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["push2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "Push 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["point"] = {"gestures@f@standing@casual", "gesture_point", "Point", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pushup"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Pushup", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["countdown"] = {"random@street_race", "grid_girl_race_start", "Countdown", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pointright"] = {"mp_gun_shop_tut", "indicate_right", "Point Right", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Salute", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Salute 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute3"] = {"anim@mp_player_intuppersalute", "idle_a", "Salute 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared"] = {"random@domestic", "f_distressed_loop", "Scared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared2"] = {"random@homelandsecurity", "knees_loop_girl", "Scared 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["screwyou"] = {"misscommon@response", "screw_you", "Screw You", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["shakeoff"] = {"move_m@_idles@shake_off", "shakeoff_1", "Shake Off", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3500,
   }},
   ["shot"] = {"random@dealgonewrong", "idle_a", "Shot", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sleep"] = {"timetable@tracy@sleep@", "idle_c", "Sleep", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["shrug"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "Shrug", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["shrug2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "Shrug 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["sit"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "Sit", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit2"] = {"rcm_barry3", "barry_3_sit_loop", "Sit 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "Sit 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "Sit 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "Sit 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "Sit 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "Sit 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "Sit 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "Sit 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitlean"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "Sit Lean", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitsad"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Sit Sad", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "Sit Scared", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "Sit Scared 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "Sit Scared 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitdrunk"] = {"timetable@amanda@drunk@base", "base", "Sit Drunk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "Sit Chair 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair3"] = {"timetable@reunited@ig_10", "base_amanda", "Sit Chair 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair4"] = {"timetable@ron@ig_3_couch", "base", "Sit Chair 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "Sit Chair 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair6"] = {"timetable@maid@couch@", "base", "Sit Chair 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchairside"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "Sit Chair Side", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["situp"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Sit Up", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clapangry"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Clap Angry", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slowclap3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Slow Clap 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clap"] = {"amb@world_human_cheering@male_a", "base", "Clap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Slow Clap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap2"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Slow Clap 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["shag"] = {"misscarsteal2pimpsex", "shagloop_pimp", "Shag", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smell"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Smell", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Up", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stumble"] = {"misscarsteal4@actor", "stumble", "Stumble", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stunned"] = {"stungun@standing", "damage", "Stunned", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sunbathe"] = {"amb@world_human_sunbathe@male@back@base", "base", "Sunbathe", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sunbathe2"] = {"amb@world_human_sunbathe@female@back@base", "base", "Sunbathe 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["t"] = {"missfam5_yoga", "a2_pose", "T", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["t2"] = {"mp_sleep", "bind_pose_180", "T 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["think5"] = {"mp_cp_welcome_tutthink", "b_think", "Think 5", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["think"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Think", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["think3"] = {"timetable@tracy@ig_8@base", "base", "Think 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["think2"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Think 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["thumbsup3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Thumbs Up 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["thumbsup2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Thumbs Up 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["thumbsup"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Thumbs Up", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "Type", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "Type 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type3"] = {"mp_prison_break", "hack_loop", "Type 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type4"] = {"mp_fbi_heist", "loop", "Type 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["warmth"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Warmth", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave4"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "Wave 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["wave2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "Wave 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave3"] = {"friends@fra@ig_1", "over_here_idle_a", "Wave 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave"] = {"friends@frj@ig_1", "wave_a", "Wave", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave5"] = {"friends@frj@ig_1", "wave_b", "Wave 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave6"] = {"friends@frj@ig_1", "wave_c", "Wave 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave7"] = {"friends@frj@ig_1", "wave_d", "Wave 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave8"] = {"friends@frj@ig_1", "wave_e", "Wave 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave9"] = {"gestures@m@standing@casual", "gesture_hello", "Wave 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whistle"] = {"taxi_hail", "hail_taxi", "Whistle", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["whistle2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Whistle 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Yeah", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lift"] = {"random@hitch_lift", "idle_f", "Lift", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "LOL", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "LOL 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["statue2"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Statue 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["statue3"] = {"club_intro2-0", "csb_englishdave_dual-0", "Statue 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gangsign"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "Gang Sign", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gangsign2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "Gang Sign 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["passout"] = {"missarmenian2", "drunk_loop", "Passout", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout2"] = {"missarmenian2", "corpse_search_exit_ped", "Passout 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout3"] = {"anim@gangops@morgue@table@", "body_search", "Passout 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "Passout 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "Passout 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["petting"] = {"creatures@rottweiler@tricks@", "petting_franklin", "Petting", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["crawl"] = {"move_injured_ground", "front_loop", "Crawl", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["flip2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Flip 2"},
   ["flip"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Flip"},
   ["slide"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Slide"},
   ["slide2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "Slide 2"},
   ["slide3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "Slide 3"},
   ["slugger"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Slugger"},
   ["flipoff"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Flip Off", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["flipoff2"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Flip Off 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["bow"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Bow", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bow2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Bow 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["keyfob"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Key Fob", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["eat"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Eat", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["reaching"] = {"move_m@intimidation@cop@unarmed", "idle", "Reaching", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait"] = {"random@shop_tattoo", "_idle_a", "Wait", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait2"] = {"missbigscore2aig_3", "wait_for_van_c", "Wait 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait12"] = {"rcmjosh1", "idle", "Wait 12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait13"] = {"rcmnigel1a", "base", "Wait 13", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Lapdance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Headbutt"},
   ["fishdance"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "Fish Dance", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Peace", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace2"] = {"anim@mp_player_intupperpeace", "idle_a", "Peace 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cpr"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cpr2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ledge"] = {"missfbi1", "ledge_loop", "Ledge", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["airplane"] = {"missfbi1", "ledge_loop", "Air Plane", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peek"] = {"random@paparazzi@peek", "left_peek_a", "Peek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cough"] = {"timetable@gardener@smoking_joint", "idle_cough", "Cough", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stretch"] = {"mini@triathlon", "idle_e", "Stretch", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch2"] = {"mini@triathlon", "idle_f", "Stretch 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch3"] = {"mini@triathlon", "idle_d", "Stretch 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "Stretch 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["celebrate"] = {"rcmfanatic1celebrate", "celebrate", "Celebrate", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["punching"] = {"rcmextreme2", "loop_punching", "Punching", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["superhero"] = {"rcmbarry", "base", "Superhero", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["superhero2"] = {"rcmbarry", "base", "Superhero 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mindcontrol"] = {"rcmbarry", "mind_control_b_loop", "Mind Control", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mindcontrol2"] = {"rcmbarry", "bar_1_attack_idle_aln", "Mind Control 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown"] = {"rcm_barry2", "clown_idle_0", "Clown", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown2"] = {"rcm_barry2", "clown_idle_1", "Clown 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown3"] = {"rcm_barry2", "clown_idle_2", "Clown 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown4"] = {"rcm_barry2", "clown_idle_3", "Clown 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tryclothes"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Try Clothes", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Try Clothes 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Try Clothes 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nervous2"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "Nervous 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "Nervous", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous3"] = {"rcmme_tracey1", "nervous_loop", "Nervous 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["uncuff"] = {"mp_arresting", "a_uncuff", "Uncuff", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["namaste"] = {"timetable@amanda@ig_4", "ig_4_base", "Namaste", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["threaten"] = {"random@atmrobberygen", "b_atm_mugging", "Threaten", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["radio"] = {"random@arrests", "generic_radio_chatter", "Radio", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pull"] = {"random@mugging4", "struggle_loop_b_thief", "Pull", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bird"] = {"random@peyote@bird", "wakeup", "Bird"},
   ["chicken"] = {"random@peyote@chicken", "wakeup", "Chicken", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bark"] = {"random@peyote@dog", "wakeup", "Bark"},
   ["rabbit"] = {"random@peyote@rabbit", "wakeup", "Rabbit"},
   ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "Spider-Man", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boi"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "BOI", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 3000,
   }},
   ["adjust"] = {"missmic4", "michael_tux_fidget", "Adjust", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 4000,
   }},
   ["handsup"] = {"missminuteman_1ig_2", "handsup_base", "Hands Up", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["gs1"] = {"mogangsign1@animation", "mogangsign1_clip", "Gang Sign 1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["cp1"] = {"mopose1@animation", "mopose1_clip", "Chill Pose 1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["cp2"] = {"mopose2@animation", "mopose2_clip", "Chill Pose 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["cp3"] = {"mopose3@animation", "mopose3_anim", "Chill Pose 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["cp4"] = {"mopose4@animation", "mopose4_clip", "Chill Pose 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["cp5"] = {"mopose5@animation", "mopose5_clip", "Chill Pose 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["pee"] = {"misscarsteal2peeing", "peeing_loop", "Pee", AnimationOptions =
   {
       EmoteStuck = true,
       PtfxAsset = "scr_amb_chop",
       PtfxName = "ent_anim_dog_peeing",
       PtfxNoProp = true,
       PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
       PtfxWait = 3000,
   }},
    -- Custom Added Emotes = Thanks to Chango
    --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
   ["peeposhy"] = {"nikez@peepo", "shy", "Peepo Shy", AnimationOptions =
   {
        PtfxPlacement = {8.0, 8.0, -1, 49, 0, false, false, false},
        EmoteMoving = true,
        EmoteLoop = true
   }},

    ["orangejustice"] = {"div@justice@new", "orangejustice", "Cringe Justice", AnimationOptions =
    {
        PtfxPlacement = {8.0, 8.0, -1, 1, 0, false, false, false},
        EmoteLoop = true
    }},

    ["loser"] = {"nikez@taunts@loser", "loser", "L bozo", AnimationOptions =
    {
        PtfxPlacement = {8.0, 8.0, -1, 54, 0, false, false, false},
        EmoteStuck = true
    }},

    ["sheesh"] = {"clear@custom_anim", "sheesh_clip", "Sheeeeeesh", AnimationOptions =
    {
        PtfxPlacement = {8.0, 8.0, -1, 48, 0, false, false, false},
        EmoteDuration = 2500,
        EmoteMoving = true
    }},

    ["animerun"] = {"nikez@anime", "run", "Rush area 51", AnimationOptions =
    {
        PtfxPlacement = {8.0, 8.0, -1, 49, 0, false, false, false},
        EmoteMoving = true,
        EmoteLoop = true
    }},

    ["pumping"] = {"pumping@custom_anim@pumping", "pumping", "Pumping air", AnimationOptions =
    {
        PtfxPlacement = {2.0, 2.0, -1, 1, 0, false, false, false}
    }},
    ["handsbehind"] = {"tigerle@custom@jobs@handsonback", "tigerle_custom_handsonback", "Put your hands behind your back", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["holdvest2"] = {"tigerle@custom@jobs@vest2", "tigerle_custom_holdvest2", "Hold your vest like a popo", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["holdvest"] = {"tigerle@custom@jobs@vest", "tigerle_custom_holdvest", "Hold your vest like a popo", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["modelselfie"] = {"anim@model_car_fancy", "car_fancy_clip", "Model Insta Selfie 3 (Smos)", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["modelselfie2"] = {"anim@model_stretched_leg", "stretched_leg_clip", "Model Insta Selfie 4 (Smos)", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["carpose"] = {"anim@car_sitting_fuckyou", "sitting_fuckyou_clip", "Car Pose 3 (Smos)", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["carpose2"] = {"anim@car_sitting_cute", "sitting_cute_clip", "Car Pose 4 (Smos)", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["modelmoto1"] = {"anim@model_bike", "bike_clip", "Motorbike Modeling Pose 1 (Smos)", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["modelmoto2"] = {"anim@model_bike_two", "bike_two_clip", "Motorbike Modeling Pose 2 (Smos)", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["riflerelax"] = {"anim@fog_rifle_relaxed", "rifle_relaxed_clip", "Relaxed With Rifle (Smos)", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["takel"] = {"custom@take_l", "take_l", "Take the L", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["hitit"] = {"custom@hitit", "hitit", "Hit It", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["floss"] = {"custom@floss", "floss", "Floss", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["flex2"] = {"frabi@malepose@solo@firstsport", "pose_sport_002", "Flex 2", AnimationOptions = 
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
	["gympose"] = {"frabi@malepose@solo@firstsport", "pose_sport_001", "Gym Pose", AnimationOptions = 
    {
		EmoteLoop = true,
    }},
    ["gympose2"] = {"frabi@malepose@solo@firstsport", "pose_sport_005", "Gym Pose 2 - One Handed Push Up", AnimationOptions = 
    {
        EmoteLoop = true,
    }},
    ["gympose3"] = {"frabi@femalepose@solo@firstsport", "fem_pose_sport_004", "Gym Pose 3 - Planking Pose", AnimationOptions = 
    {
		EmoteLoop = true,
    }},
    ["gympose4"] = {"frabi@femalepose@solo@firstsport", "fem_pose_sport_005", "Gym Pose 4 - Sit Ups Pose", AnimationOptions = 
    {
        EmoteLoop = true,
    }},
    ["relax"] = {"lying@on_grass", "base", "Relax", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["relax2"] = {"lying@on_couch_legs_crossed", "base", "Relax 2", AnimationOptions = 
    {
        EmoteLoop = true,
    }},
    ["uwu"] = {"uwu@egirl", "base", "uWu", AnimationOptions = 
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["kneelthot"] = {"anim@model_kylie_insta", "kylie_insta_clip", "Kneel Thot Instagram", AnimationOptions = 
    {
        EmoteLoop = true,
    }},
    ["tslide"] = {"custom@toosie_slide", "toosie_slide", "Toosie Slide", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["renegade"] = {"custom@renegade", "renegade", "Renegade", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["fpose1"] = {"nhyza@pose7", "pose7_clip", "Female Pose 1", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = false,
    }},
    ["fpose2"] = {"nhyza@pose8", "pose8_clip", "Female Pose 2", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = false,
    }},
    ["fpose3"] = {"nhyza@pose9", "pose9_clip", "Female Pose 3", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = false,
    }},
    ["fpose4"] = {"nhyza@pose10", "pose10_clip", "Female Pose 4", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = false,
    }},
    ["fpose5"] = {"nhyza@pose11", "pose11_clip", "Female Pose 5", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = false,
    }},
    ["fpose6"] = {"pose1@nhyza", "pose1_clip", "Female Pose 6", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = false,
    }},
    ["fpose7"] = {"nhyza@pose3", "pose3_clip", "Female Pose 7", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = false,
    }},
    ["fpose8"] = {"nhyza2@animation", "nhyza2_clip", "Female Pose 8", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = false,
    }},
    ["fpose9"] = {"nhyza@stairs", "stairs_clip", "Female Pose 9 Stairs", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = false,
    }},
    ["fpose10"] = {"nhyza@sit", "sit_clip", "Female Pose 10 Sit", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = false,
    }},
-----------------------------------------------------------------------------------------------------------
------ These are Scenarios, some of these dont work on women and some other issues, but still good to have.
-----------------------------------------------------------------------------------------------------------
   ["atm"] = {"Scenario", "PROP_HUMAN_ATM", "ATM"},
   ["bbq"] = {"MaleScenario", "PROP_HUMAN_BBQ", "BBQ"},
   ["bumbin"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Bum Bin"},
   ["bumsleep"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Bum Sleep"},
   ["cheer"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Cheer"},
   ["chinup"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Chinup"},
   ["clipboard2"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "Clipboard 2"},
   ["cop"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Cop"},
   ["filmshocking"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Film Shocking"},
   ["flex"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Flex"},
   ["guard"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "Guard"},
   ["hammer"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Hammer"},
   ["hangout"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Hangout"},
   ["impatient"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Impatient"},
   ["janitor"] = {"Scenario", "WORLD_HUMAN_JANITOR", "Janitor"},
   ["jog"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "Jog"},
   ["kneel"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "Kneel"},
   ["lean"] = {"Scenario", "WORLD_HUMAN_LEANING", "Lean"},
   ["leanbar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Lean Bar"},
   ["lookout"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Lookout"},
   ["maid"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Maid"},
   ["medic"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Medic"},
   ["musician"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Musician"},
   ["notepad2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Notepad 2"},
   ["parkingmeter"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Parking Meter"},
   ["party"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Party"},
   ["texting"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Texting"},
   ["prosthigh"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Prostitue High"},
   ["prostlow"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Prostitue Low"},
   ["puddle"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Puddle"},
   ["record"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Record"},
   -- Sitchair is a litte special, since you want the player to be seated correctly.
   -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
   ["sitchair"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "Sit Chair"},
   ["smoke"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Smoke"},
   ["smokeweed"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "Smoke Weed"},
   ["statue"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "Statue"},
   ["sunbathe3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "Sunbathe 3"},
   --["sunbatheback"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "Sunbathe Back"}, -- Removed due to general glitching abuse
   ["weld"] = {"Scenario", "WORLD_HUMAN_WELDING", "Weld"},
   ["windowshop"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Window Shop"},
   ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Yoga"},
   -- CASINO DLC EMOTES (STREAMED)
   ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Karate"},
   ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Karate 2"},
   ["cutthroat"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Cut Throat"},
   ["cutthroat2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Cut Throat 2"},
   ["mindblown"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "Mind Blown", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["mindblown2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "Mind Blown 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boxing", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boxing 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["stink"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Stink", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["think4"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Think 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["adjusttie"] = {"clothingtie", "try_tie_positive_a", "Adjust Tie", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000
   }},
   ["gs2"] = {"gang_2@ierrorr", "gang_2_clip", "Gang Sign 2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true
   }},
   ["gs3"] = {"bwcsign@leucos", "bwcsign_clip", "Gang Sign 3", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true
   }},
   ["gs4"] = {"npksign@leucos", "npksign_clip", "Gang Sign 4", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true
   }},
   ["gs5"] = {"ofbsign@leucos", "ofbsign_clip", "Gang Sign 5", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true
   }},
   ["gs6"] = {"zone2sign@leucos", "zone2sign_clip", "Gang Sign 6", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true
   }},
   ["gs7"] = {"n15sign@leucos", "n15sign_clip", "Gang Sign 7", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true
   }},
   ["gs8"] = {"arves@killer", "killer_clip", "Gang Sign 8", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = false
   }},
}

DP.PropEmotes = {
   ["umbrella"] = {"amb@world_human_drinking@coffee@male@base", "base", "Umbrella", AnimationOptions =
   {
       Prop = "p_amb_brolly_01",
       PropBone = 57005,
       PropPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
       --
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["golfswing"] = { "rcmnigel1d", "swing_a_mark", "Golf Swing", AnimationOptions = {
        EmoteLoop = true,
        Prop = "prop_golf_wood_01",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
    }},
    ["copbeacon"] = { "amb@world_human_car_park_attendant@male@base", "base", "Cop Beacon", AnimationOptions = {
        Prop = "prop_parking_wand_01",
        PropBone = 57005,
        PropPlacement = { 0.12, 0.05, 0.0, 80.0, -20.0, 180.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["guncase"] = { "move_weapon@jerrycan@generic", "idle", "Guncase", AnimationOptions = {
        Prop = "prop_gun_case_01",
        PropBone = 57005,
        PropPlacement = { 0.10, 0.02, -0.02, 40.0, 145.0, 115.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leanphone"] = { "amb@world_human_leaning@male@wall@back@mobile@base", "base", "Leaning With Phone", AnimationOptions = {
        EmoteMoving = false,
        EmoteLoop = true,
        Prop = "prop_phone_ing",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
    }},
    ["gbin"] = { "anim@heists@box_carry@", "idle", "Garbage Bin", AnimationOptions = {
        Prop = "prop_bin_08open",
        PropBone = 28422,
        PropPlacement = { 0.00, -0.420, -1.290, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["gbin2"] = { "anim@heists@box_carry@", "idle", "Garbage Bin 2", AnimationOptions = {
        Prop = "prop_cs_bin_01",
        PropBone = 28422,
        PropPlacement = { 0.00, -0.420, -1.290, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["gbin3"] = { "anim@heists@box_carry@", "idle", "Garbage Bin 3", AnimationOptions = {
        Prop = "prop_cs_bin_03",
        PropBone = 28422,
        PropPlacement = { 0.00, -0.420, -1.290, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["gbin4"] = { "anim@heists@box_carry@", "idle", "Garbage Bin 4", AnimationOptions = {
        Prop = "prop_bin_08a",
        PropBone = 28422,
        PropPlacement = { 0.00, -0.420, -1.290, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["gbin5"] = { "anim@heists@box_carry@", "idle", "Garbage Bin 5", AnimationOptions = {
        Prop = "prop_bin_07d",
        PropBone = 28422,
        PropPlacement = { -0.0100, -0.2200, -0.8600, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["cbbox"] = { "anim@heists@box_carry@", "idle", "Carry Beer Box", AnimationOptions = {
        Prop = "v_ret_ml_beerben1",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["cbbox2"] = { "anim@heists@box_carry@", "idle", "Carry Beer Box 2", AnimationOptions = {
        Prop = "v_ret_ml_beerbla1",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["cbbox3"] = { "anim@heists@box_carry@", "idle", "Carry Beer Box 3", AnimationOptions = {
        Prop = "v_ret_ml_beerjak1",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["cbbox4"] = { "anim@heists@box_carry@", "idle", "Carry Beer Box 4", AnimationOptions = {
        Prop = "v_ret_ml_beerlog1",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["cbbox5"] = { "anim@heists@box_carry@", "idle", "Carry Beer Box 5", AnimationOptions = {
        Prop = "v_ret_ml_beerpis1",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["cbbox6"] = { "anim@heists@box_carry@", "idle", "Carry Beer Box 6", AnimationOptions = {
        Prop = "prop_beer_box_01",
        PropBone = 28422,
        PropPlacement = { 0.0200, -0.0600, -0.1200, -180.00, -180.00, 1.99 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["lawnchair"] = { "timetable@ron@ig_5_p3", "ig_5_p3_base", "Lawnchair", AnimationOptions = {
        Prop = "prop_skid_chair_02",
        PropBone = 0,
        PropPlacement = { 0.025, -0.2, -0.1, 45.0, -5.0, 180.0 },
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["lawnchair2"] = { "timetable@reunited@ig_10", "base_amanda", "Lawnchair 2", AnimationOptions = {
        Prop = "prop_skid_chair_02",
        PropBone = 0,
        PropPlacement = { 0.025, -0.15, -0.1, 45.0, 5.0, 180.0 },
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["lawnchair3"] = { "timetable@ron@ig_3_couch", "base", "Lawnchair 3", AnimationOptions = {
        Prop = "prop_skid_chair_02",
        PropBone = 0,
        PropPlacement = { -0.05, 0.0, -0.2, 5.0, 0.0, 180.0 },
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["potplant"] = { "anim@heists@box_carry@", "idle", "Pot Plant (Small)", AnimationOptions = {
        Prop = "bkr_prop_weed_01_small_01c",
        PropBone = 60309,
        PropPlacement = { 0.138, -0.05, 0.23, -50.0, 290.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["potplant2"] = { "anim@heists@box_carry@", "idle", "Pot Plant (Medium)", AnimationOptions = {
        Prop = "bkr_prop_weed_01_small_01b",
        PropBone = 60309,
        PropPlacement = { 0.138, -0.05, 0.23, -50.0, 290.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["potplant3"] = { "anim@heists@box_carry@", "idle", "Pot Plant (Large)", AnimationOptions = {
        Prop = "bkr_prop_weed_lrg_01b",
        PropBone = 60309,
        PropPlacement = { 0.138, -0.05, 0.23, -50.0, 290.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["weedbrick"] = { "impexp_int-0", "mp_m_waremech_01_dual-0", "Weed Brick", AnimationOptions = {
        Prop = "prop_weed_block_01",
        PropBone = 60309,
        PropPlacement = { 0.1, 0.1, 0.05, 0.0, -90.0, 90.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["weedbrick2"] = { "anim@heists@box_carry@", "idle", "Weed Brick BIG", AnimationOptions = {
        Prop = "bkr_prop_weed_bigbag_01a",
        PropBone = 60309,
        PropPlacement = { 0.158, -0.05, 0.23, -50.0, 290.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["register"] = { "anim@heists@box_carry@", "idle", "Register", AnimationOptions = {
        Prop = "v_ret_gc_cashreg",
        PropBone = 60309,
        PropPlacement = { 0.138, 0.2, 0.2, -50.0, 290.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["tire"] = { "anim@heists@box_carry@", "idle", "Tire", AnimationOptions = {
        Prop = "prop_wheel_tyre",
        PropBone = 60309,
        PropPlacement = { -0.05, 0.16, 0.32, -130.0, -55.0, 150.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["shopbag"] = { "move_weapon@jerrycan@generic", "idle", "Shopping Bag", AnimationOptions = {
        Prop = "vw_prop_casino_shopping_bag_01a",
        PropBone = 28422,
        PropPlacement = { 0.24, 0.03, -0.04, 0.00, -90.00, 10.00 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["shopbag2"] = { "move_weapon@jerrycan@generic", "idle", "Shopping Bag 2", AnimationOptions = {
        Prop = "prop_shopping_bags02",
        PropBone = 28422,
        PropPlacement = { 0.05, 0.02, 0.00, 178.80, 91.19, 9.97 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["shopbag3"] = { "move_weapon@jerrycan@generic", "idle", "Shopping Bag 3", AnimationOptions = {
        Prop = "prop_cs_shopping_bag",
        PropBone = 28422,
        PropPlacement = { 0.24, 0.03, -0.04, 0.00, -90.00, 10.00 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["dufbag"] = { "move_weapon@jerrycan@generic", "idle", "Duffel Bag", AnimationOptions = {
        Prop = "bkr_prop_duffel_bag_01a",
        PropBone = 28422,
        PropPlacement = { 0.2600, 0.0400, 0.00, 90.00, 0.00, -78.99 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["medbag"] = { "move_weapon@jerrycan@generic", "idle", "Medic Bag", AnimationOptions = {
        Prop = "xm_prop_x17_bag_med_01a",
        PropBone = 57005,
        PropPlacement = { 0.3900, -0.0600, -0.0600, -100.00, -180.00, -78.00 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["dig"] = { "random@burial", "a_burial", "Dig", AnimationOptions = {
        Prop = "prop_tool_shovel",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.24, 0, 0, 0.0, 0.0 },
        SecondProp = 'prop_ld_shovel_dirt',
        SecondPropBone = 28422,
        SecondPropPlacement = { 0.0, 0.0, 0.24, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["bongos"] = { "amb@world_human_musician@bongos@male@base", "base", "Bongo Drums", AnimationOptions = {
        Prop = "prop_bongos_01",
        PropBone = 60309,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["sittv"] = { "anim@heists@heist_safehouse_intro@variations@male@tv", "tv_part_one_loop", "Sit TV", AnimationOptions = {
        Prop = "v_res_tre_remote",
        PropBone = 57005,
        PropPlacement = { 0.0990, 0.0170, -0.0300, -64.760, -109.544, 18.717 },
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["champw"] = { "anim@move_f@waitress", "idle", "Champagne Waiter", AnimationOptions = {
        Prop = "vw_prop_vw_tray_01a",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0100, 0.0, 0.0, 0.0 },
        SecondProp = 'prop_champ_cool',
        SecondPropBone = 28422,
        SecondPropPlacement = { 0.0, 0.0, 0.010, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["rake"] = { "anim@amb@drug_field_workers@rake@male_a@base", "base", "Rake", AnimationOptions = {
        Prop = "prop_tool_rake",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, -0.0300, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
    }},
    ["rake2"] = { "anim@amb@drug_field_workers@rake@male_a@idles", "idle_b", "Rake 2", AnimationOptions = {
        Prop = "prop_tool_rake",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, -0.0300, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
    }},
    ["rake3"] = { "anim@amb@drug_field_workers@rake@male_b@base", "base", "Rake 3", AnimationOptions = {
        Prop = "prop_tool_rake",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, -0.0300, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
    }},
    ["rake4"] = { "anim@amb@drug_field_workers@rake@male_b@idles", "idle_d", "Rake 4", AnimationOptions = {
        Prop = "prop_tool_rake",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, -0.0300, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
    }},
    ["broom"] = { "anim@amb@drug_field_workers@rake@male_a@base", "base", "Broom", AnimationOptions = {
        Prop = "prop_tool_broom",
        PropBone = 28422,
        PropPlacement = { -0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
    }},
    ["broom2"] = { "anim@amb@drug_field_workers@rake@male_a@idles", "idle_b", "Broom 2", AnimationOptions = {
        Prop = "prop_tool_broom",
        PropBone = 28422,
        PropPlacement = { -0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
    }},
    ["broom3"] = { "anim@amb@drug_field_workers@rake@male_b@base", "base", "Broom 3", AnimationOptions = {
        Prop = "prop_tool_broom",
        PropBone = 28422,
        PropPlacement = { -0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
    }},
    ["broom4"] = { "anim@amb@drug_field_workers@rake@male_b@idles", "idle_d", "Broom 4", AnimationOptions = {
        Prop = "prop_tool_broom",
        PropBone = 28422,
        PropPlacement = { -0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
    }},
    ["pump"] = { "missfbi4prepp1", "idle", "Pumpkin", AnimationOptions = {
        Prop = "prop_veg_crop_03_pump",
        PropBone = 28422,
        PropPlacement = { 0.0200, 0.0600, -0.1200, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["pump2"] = { "anim@heists@box_carry@", "idle", "Pumpkin 2", AnimationOptions = {
        Prop = "prop_veg_crop_03_pump",
        PropBone = 28422,
        PropPlacement = { 0.0100, -0.16000, -0.2100, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["mop"] = { "missfbi4prepp1", "idle", "Mop", AnimationOptions = {
        Prop = "prop_cs_mop_s",
        PropBone = 28422,
        PropPlacement = { -0.0200, -0.0600, -0.2000, -13.377, 10.3568, 17.9681 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["mop2"] = { "move_mop", "idle_scrub_small_player", "Mop 2", AnimationOptions = {
        Prop = "prop_cs_mop_s",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.1200, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["newscam"] = { "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", "News Camera", AnimationOptions = {
        Prop = "prop_v_cam_01",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0300, 0.0100, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["newsmic"] = { "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "News Microphone", AnimationOptions = {
        Prop = "p_ing_microphonel_01",
        PropBone = 4154,
        PropPlacement = { -0.00, -0.0200, 0.1100, 0.00, 0.0, 60.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["newsbmic"] = { "missfra1", "mcs2_crew_idle_m_boom", "News Boom Microphone", AnimationOptions = {
        Prop = "prop_v_bmike_01",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leafblower"] = { "amb@world_human_gardener_leaf_blower@base", "base", "Leaf Blower", AnimationOptions = {
        Prop = "prop_leaf_blower_01",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["bbqf"] = { "amb@prop_human_bbq@male@idle_a", "idle_b", "BBQ (Female)", AnimationOptions = {
        Prop = "prop_fish_slice_01",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["beans"] = { "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", "base_idle", "Beans", AnimationOptions = {
        Prop = "h4_prop_h4_caviar_tin_01a",
        PropBone = 60309,
        PropPlacement = { 0.0, 0.0300, 0.0100, 0.0, 0.0, 0.0 },
        SecondProp = 'h4_prop_h4_caviar_spoon_01a',
        SecondPropBone = 28422,
        SecondPropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    ["foodtray1"] = { "anim@heists@box_carry@", "idle", "Food Tray 1", AnimationOptions = {
        Prop = "prop_food_bs_tray_03",
        PropBone = 28422,
        PropPlacement = { 0.0100, -0.0400, -0.1390, 20.0000007, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray2"] = { "anim@heists@box_carry@", "idle", "Food Tray 2", AnimationOptions = {
        Prop = "prop_food_bs_tray_02",
        PropBone = 28422,
        PropPlacement = { 0.0100, -0.0400, -0.1390, 20.0000007, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray3"] = { "anim@heists@box_carry@", "idle", "Food Tray 3", AnimationOptions = {
        Prop = "prop_food_cb_tray_02",
        PropBone = 28422,
        PropPlacement = { 0.0100, -0.0400, -0.1390, 20.0000007, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray4"] = { "anim@heists@box_carry@", "idle", "Food Tray 4", AnimationOptions = {
        Prop = "prop_food_tray_02",
        PropBone = 28422,
        PropPlacement = { 0.0100, -0.0400, -0.1390, 20.0000007, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray5"] = { "anim@heists@box_carry@", "idle", "Food Tray 5", AnimationOptions = {
        Prop = "prop_food_tray_03",
        PropBone = 28422,
        PropPlacement = { 0.0100, -0.0400, -0.1390, 20.0000007, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray6"] = { "anim@heists@box_carry@", "idle", "Food Tray 6", AnimationOptions = {
        Prop = "prop_food_bs_tray_02",
        PropBone = 57005,
        PropPlacement = { 0.2500, 0.1000, 0.0700, -110.5483936, 73.3529273, -16.338362 },
        SecondProp = 'prop_food_bs_tray_03',
        SecondPropBone = 18905,
        SecondPropPlacement = { 0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray7"] = { "anim@heists@box_carry@", "idle", "Food Tray 7", AnimationOptions = {
        Prop = "prop_food_cb_tray_02",
        PropBone = 57005,
        PropPlacement = { 0.2500, 0.1000, 0.0700, -110.5483936, 73.3529273, -16.338362 },
        SecondProp = 'prop_food_cb_tray_02',
        SecondPropBone = 18905,
        SecondPropPlacement = { 0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray8"] = { "anim@heists@box_carry@", "idle", "Food Tray 8", AnimationOptions = {
        Prop = "prop_food_tray_02",
        PropBone = 57005,
        PropPlacement = { 0.2500, 0.1000, 0.0700, -110.5483936, 73.3529273, -16.338362 },
        SecondProp = 'prop_food_tray_03',
        SecondPropBone = 18905,
        SecondPropPlacement = { 0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray9"] = { "anim@heists@box_carry@", "idle", "Food Tray 9", AnimationOptions = {
        Prop = "prop_food_tray_02",
        PropBone = 57005,
        PropPlacement = { 0.2500, 0.1000, 0.0700, -110.5483936, 73.3529273, -16.338362 },
        SecondProp = 'prop_food_tray_02',
        SecondPropBone = 18905,
        SecondPropPlacement = { 0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray10"] = { "anim@move_f@waitress", "idle", "Food Tray 10", AnimationOptions = {
        Prop = "prop_food_bs_tray_02",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0200, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray11"] = { "anim@move_f@waitress", "idle", "Food Tray 11", AnimationOptions = {
        Prop = "prop_food_bs_tray_02",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0200, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray12"] = { "anim@move_f@waitress", "idle", "Food Tray 12", AnimationOptions = {
        Prop = "prop_food_bs_tray_03",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0200, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray13"] = { "anim@move_f@waitress", "idle", "Food Tray 13", AnimationOptions = {
        Prop = "prop_food_cb_tray_02",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0200, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray14"] = { "anim@move_f@waitress", "idle", "Food Tray 14", AnimationOptions = {
        Prop = "prop_food_tray_02",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0200, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foodtray15"] = { "anim@move_f@waitress", "idle", "Food Tray 15", AnimationOptions = {
        Prop = "prop_food_tray_02",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0, 0.0200, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["carrypizza"] = { "anim@heists@box_carry@", "idle", "Carry Pizza Box", AnimationOptions = {
        Prop = "prop_pizza_box_02",
        PropBone = 28422,
        PropPlacement = { 0.0100, -0.1000, -0.1590, 20.0000007, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["carryfoodbag"] = { "move_weapon@jerrycan@generic", "idle", "Carry Food Bag", AnimationOptions = {
        Prop = "prop_food_bs_bag_01",
        PropBone = 57005,
        PropPlacement = { 0.3300, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["carryfoodbag2"] = { "move_weapon@jerrycan@generic", "idle", "Carry Food Bag 2", AnimationOptions = {
        Prop = "prop_food_cb_bag_01",
        PropBone = 57005,
        PropPlacement = { 0.3800, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["carryfoodbag3"] = { "move_weapon@jerrycan@generic", "idle", "Carry Food Bag 3", AnimationOptions = {
        Prop = "prop_food_bag1",
        PropBone = 57005,
        PropPlacement = { 0.3800, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["conehead"] = { "move_m@drunk@verydrunk_idles@", "fidget_07", "Cone Head ", AnimationOptions = {
        Prop = "prop_roadcone02b",
        PropBone = 31086,
        PropPlacement = { 0.0500, 0.0200, -0.000, 30.0000004, 90.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["ssign"] = { "rcmnigel1d", "base_club_shoulder", "Steal Stop Sign ", AnimationOptions = {
        Prop = "prop_sign_road_01a",
        PropBone = 60309,
        PropPlacement = { -0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["ssign2"] = { "rcmnigel1d", "base_club_shoulder", "Steal Yield Sign ", AnimationOptions = {
        Prop = "prop_sign_road_02a",
        PropBone = 60309,
        PropPlacement = { -0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["ssign3"] = { "rcmnigel1d", "base_club_shoulder", "Steal Hospital Sign ", AnimationOptions = {
        Prop = "prop_sign_road_03d",
        PropBone = 60309,
        PropPlacement = { -0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["ssign4"] = { "rcmnigel1d", "base_club_shoulder", "Steal Parking Sign ", AnimationOptions = {
        Prop = "prop_sign_road_04a",
        PropBone = 60309,
        PropPlacement = { -0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["ssign5"] = { "rcmnigel1d", "base_club_shoulder", "Steal Parking Sign 2 ", AnimationOptions = {
        Prop = "prop_sign_road_04w",
        PropBone = 60309,
        PropPlacement = { -0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["ssign6"] = { "rcmnigel1d", "base_club_shoulder", "Steal Pedestrian Sign ", AnimationOptions = {
        Prop = "prop_sign_road_05a",
        PropBone = 60309,
        PropPlacement = { -0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["ssign7"] = { "rcmnigel1d", "base_club_shoulder", "Steal Street Sign ", AnimationOptions = {
        Prop = "prop_sign_road_05t",
        PropBone = 60309,
        PropPlacement = { -0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["ssign8"] = { "rcmnigel1d", "base_club_shoulder", "Steal Freeway Sign ", AnimationOptions = {
        Prop = "prop_sign_freewayentrance",
        PropBone = 60309,
        PropPlacement = { -0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["ssign9"] = { "rcmnigel1d", "base_club_shoulder", "Steal Stop Sign Snow ", AnimationOptions = {
        Prop = "prop_snow_sign_road_01a",
        PropBone = 60309,
        PropPlacement = { -0.1390, -0.9870, 0.4300, -67.3315314, 145.0627869, -4.4318885 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["fuel"] = { "weapons@misc@jerrycan@", "fire", "Fuel", AnimationOptions = {
        Prop = "w_am_jerrycan",
        PropBone = 57005,
        PropPlacement = { 0.1800, 0.1300, -0.2400, -165.8693883, -11.2122753, -32.9453021 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["fuel2"] = { "weapons@misc@jerrycan@franklin", "idle", "Fuel 2 (Carry)", AnimationOptions = {
        Prop = "w_am_jerrycan",
        PropBone = 28422,
        PropPlacement = { 0.26, 0.050, 0.0300, 80.00, 180.000, 79.99 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["toolbox"] = { "move_weapon@jerrycan@generic", "idle", "Toolbox", AnimationOptions = {
        Prop = "prop_tool_box_04",
        PropBone = 28422,
        PropPlacement = { 0.3960, 0.0410, -0.0030, -90.00, 0.0, 90.00 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["toolbox2"] = { "move_weapon@jerrycan@generic", "idle", "Toolbox 2", AnimationOptions = {
        Prop = "imp_prop_tool_box_01a",
        PropBone = 28422,
        PropPlacement = { 0.3700, 0.0200, 0.0, 90.00, 0.0, -90.00 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["gbag"] = { "missfbi4prepp1", "_idle_garbage_man", "Garbage Bag", AnimationOptions = {
        Prop = "prop_cs_street_binbag_01",
        PropBone = 28422,
        PropPlacement = { 0.0, 0.0400, -0.0200, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["fishing1"] = { "amb@world_human_stand_fishing@idle_a", "idle_a", "Fishing 1", AnimationOptions = {
        Prop = 'prop_fishing_rod_01',
        PropBone = 60309,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["fishing2"] = { "amb@world_human_stand_fishing@idle_a", "idle_b", "Fishing 2", AnimationOptions = {
        Prop = 'prop_fishing_rod_01',
        PropBone = 60309,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["fishing3"] = { "amb@world_human_stand_fishing@idle_a", "idle_c", "Fishing 3", AnimationOptions = {
        Prop = 'prop_fishing_rod_01',
        PropBone = 60309,
        PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["megaphone"] = {"molly@megaphone", "megaphone_clip", "Megaphone", AnimationOptions = 
    {
        Prop = "prop_megaphone_01",
        PropBone = 28422,
        PropPlacement = {0.0500, 0.0540, -0.0060, -71.8855, -13.0889, -16.0242},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["megaphone2"] = {"molly@megaphone2", "megaphone_clip", "Megaphone 2", AnimationOptions = 
    {
        Prop = "prop_megaphone_01",
        PropBone = 28422,
        PropPlacement = {0.0500, 0.0540, -0.0060, -71.8855, -13.0889, -16.0242},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["suitcase3"] = {"anim@heists@narcotics@trash", "idle", "Airport Bag", AnimationOptions = 
     {
        Prop = "prop_suitcase_01c",
        PropBone = 28422,
        PropPlacement = {0.1100, -0.2100, -0.4300, -11.8999, 0.0, 30.0000},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["guitarcarry"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Case Carry", AnimationOptions = 
     {
        Prop = "sf_prop_sf_guitar_case_01a",
        PropBone = 28422,
        PropPlacement = {0.2800, -0.2000, -0.0600, 0.0, 0.0, 15.0000},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["guitarcarry2"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Accoustic", AnimationOptions = 
     {
        Prop = "prop_acc_guitar_01",
        PropBone = 28422,
        PropPlacement = {0.1500, -0.1400, -0.0200, -101.5083, 5.7251, 29.4987},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["guitarcarry3"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Electric ", AnimationOptions = 
     {
        Prop = "prop_el_guitar_01",
        PropBone = 28422,
        PropPlacement = {0.1100, -0.1200, -0.0500, -80.0000, 0.0, 21.9999},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["guitarcarry4"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Electric 2 ", AnimationOptions = 
     {
        Prop = "prop_el_guitar_02",
        PropBone = 28422,
        PropPlacement = {0.1100, -0.1200, -0.0500, -80.0000, 0.0, 21.9999},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["guitarcarry5"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Electric 3 ", AnimationOptions = 
     {
        Prop = "prop_el_guitar_03",
        PropBone = 28422,
        PropPlacement = {0.1100, -0.1200, -0.0500, -80.0000, 0.0, 21.9999},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["guitarcarry6"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Electric 4 ", AnimationOptions = 
     {
        Prop = "vw_prop_casino_art_guitar_01a",
        PropBone = 28422,
        PropPlacement = {0.1100, -0.1200, -0.0500, -80.0000, 0.0, 21.9999},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["guitarcarry7"] = {"move_weapon@jerrycan@generic", "idle", "Guitar Carry Electric 5 ", AnimationOptions = 
     {
        Prop = "sf_prop_sf_el_guitar_02a",
        PropBone = 28422,
        PropPlacement = {0.1100, -0.1200, -0.0500, -80.0000, 0.0, 21.9999},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["cashcase"] = {"move_weapon@jerrycan@generic", "idle", "Cash Briefcase", AnimationOptions = 
     {
        Prop = "bkr_prop_biker_case_shut",
        PropBone = 28422,
        PropPlacement = {0.1000, 0.0100, 0.0040, 0.0, 0.0, -90.00},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["cashcase2"] = {"anim@heists@box_carry@", "idle", "Cash Briefcase 2", AnimationOptions = 
     {
        Prop = "prop_cash_case_01",
        PropBone = 28422,
        PropPlacement = { -0.0050, -0.1870, -0.1400, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["cashcase3"] = { "anim@heists@box_carry@", "idle", "Cash Briefcase 3", AnimationOptions = 
     {
        Prop = "prop_cash_case_02",
        PropBone = 28422,
        PropPlacement = {0.0050, -0.1170, -0.1400, 14.000, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["cashcase4"] = {"anim@heists@box_carry@", "idle", "Cash Briefcase 4 - Diamonds", AnimationOptions = 
     {
        Prop = "ch_prop_ch_security_case_01a",
        PropBone = 28422,
        PropPlacement = {0.0, -0.0900, -0.1800, 14.4000, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["stealtv"] = {"beachanims@molly", "beachanim_surf_clip", "Steal TV", AnimationOptions =
     {
        Prop = "xs_prop_arena_screen_tv_01",
        PropBone = 28252,
        PropPlacement = {0.2600, 0.1100, -0.1400, 96.1620, 168.9069, 84.2402},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["beachring"] = {"beachanims@free", "beachanim_clip", "Beach Floatie", AnimationOptions = 
     {
        Prop = "prop_beach_ring_01",
        PropBone = 0,
        PropPlacement = {0.0, 0.0, 0.0100, -12.0, 0.0, -2.0},
        EmoteLoop = true,
         EmoteMoving = true,
     }},
     ["surfboard"] = {"beachanims@molly", "beachanim_surf_clip", "Surf Board", AnimationOptions =
     {
        Prop = "prop_surf_board_01",
        PropBone = 28252,
        PropPlacement = {0.1020, -0.1460, -0.1160, -85.5416, 176.1446, -2.1500},
        EmoteLoop = true,
        EmoteMoving = true,
     }},
     ["boombox"] = {"move_weapon@jerrycan@generic", "idle", "Boombox", AnimationOptions = 
     {
       Prop = "prop_boombox_01",
       PropBone = 57005,
       PropPlacement = {0.27, 0.0, 0.0, 0.0, 263.0, 58.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["sms"] = {"cellphone@", "cellphone_text_read_base", "SMS", AnimationOptions = 
    {
      Prop = "prop_phone_ing",
      PropBone = 28422,
      PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
    }},
    ["sms2"] = {"cellphone@female", "cellphone_text_read_base", "SMS 2", AnimationOptions = 
    {
       Prop = "prop_phone_ing",
       PropBone = 28422,
       PropPlacement = {0.00, 0.00, 0.0301, 0.000, 00.00, 00.00},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["sms3"] = {"cellphone@female", "cellphone_email_read_base", "SMS 3", AnimationOptions = 
    {
       Prop = "prop_phone_ing",
       PropBone = 28422,
       PropPlacement = {-0.0190, -0.0240, 0.0300, 18.99, -72.07, 6.39},
       EmoteLoop = false,
       EmoteMoving = true,
    }},
    ["sms4"] = {"amb@code_human_wander_texting_fat@male@base", "static", "SMS 4", AnimationOptions = 
    {
       Prop = "prop_phone_ing",
       PropBone = 28422,
       PropPlacement = {-0.0200, -0.0100, 0.00, 2.309, 88.845, 29.979},
       EmoteLoop = false,
       EmoteMoving = true,
    }},

-----------------------------------------------------------------------------------------------------
------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
-----------------------------------------------------------------------------------------------------

   ['old'] = { 'missbigscore2aleadinout@bs_2a_2b_int', 'lester_base_idle', 'Old Man Walking Stick', AnimationOptions = {
       Prop = 'prop_cs_walking_stick',
       PropBone = 28422,
       PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
       SecondProp = 'prop_phone_ing',
       SecondPropBone = 60309,
       SecondPropPlacement = { 0.0800, 0.0300, 0.0100, -107.9999, 0.0, -4.6003 },
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["notepad"] = {"missheistdockssetup1clipboard@base", "base", "Notepad", AnimationOptions =
   {
       Prop = 'prop_notepad_01',
       PropBone = 18905,
       PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
       -- EmoteLoop is used for emotes that should loop, its as simple as that.
       -- Then EmoteMoving is used for emotes that should only play on the upperbody.
       -- The code then checks both values and sets the MovementType to the correct one
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["box"] = {"anim@heists@box_carry@", "idle", "Box", AnimationOptions =
   {
       Prop = "hei_prop_heist_box",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rose"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Rose", AnimationOptions =
   {
       Prop = "prop_single_rose",
       PropBone = 18905,
       PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Smoke 2", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Smoke 3", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Smoke 4", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bong"] = {"anim@safehouse@bong", "bong_stage3", "Bong", AnimationOptions =
   {
       Prop = 'hei_heist_sh_bong_01',
       PropBone = 18905,
       PropPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
   }},
   ["suitcase"] = {"missheistdocksprep1hold_cellphone", "static", "Suitcase", AnimationOptions =
   {
       Prop = "prop_ld_suitcase_01",
       PropBone = 57005,
       PropPlacement = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["suitcase2"] = {"missheistdocksprep1hold_cellphone", "static", "Suitcase 2", AnimationOptions =
   {
       Prop = "prop_security_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mugshot"] = {"mp_character_creation@customise@male_a", "loop", "Mugshot", AnimationOptions =
   {
       Prop = 'prop_police_id_board',
       PropBone = 58868,
       PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee", AnimationOptions =
   {
       Prop = 'p_amb_coffeecup_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey", AnimationOptions =
   {
       Prop = 'prop_drink_whisky',
       PropBone = 28422,
       PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["beer"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Beer", AnimationOptions =
   {
       Prop = 'prop_amb_beer_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cup"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Cup", AnimationOptions =
   {
       Prop = 'prop_plastic_cup_02',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", AnimationOptions =
   {
       Prop = 'prop_amb_donut',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["burger"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger", AnimationOptions =
   {
       Prop = 'prop_cs_burger_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich", AnimationOptions =
   {
       Prop = 'prop_sandwich_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Soda", AnimationOptions =
   {
       Prop = 'prop_ecola_can',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["egobar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Ego Bar", AnimationOptions =
   {
       Prop = 'prop_choc_ego',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
   }},
   ["wine"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Wine", AnimationOptions =
   {
       Prop = 'prop_drink_redwine',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["flute"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Flute", AnimationOptions =
   {
       Prop = 'prop_champ_flute',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["champagne"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Champagne", AnimationOptions =
   {
       Prop = 'prop_drink_champ',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["cigar"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar", AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cigar2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar 2", AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["guitar"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitar2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Guitar 2", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar Electric", AnimationOptions =
   {
       Prop = 'prop_el_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric2"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar Electric 2", AnimationOptions =
   {
       Prop = 'prop_el_guitar_03',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["book"] = {"cellphone@", "cellphone_text_read_base", "Book", AnimationOptions =
   {
       Prop = 'prop_novel_01',
       PropBone = 6286,
       PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["bouquet"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Bouquet", AnimationOptions =
   {
       Prop = 'prop_snow_flower_02',
       PropBone = 24817,
       PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["teddy"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Teddy", AnimationOptions =
   {
       Prop = 'v_ilev_mr_rasberryclean',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["backpack"] = {"move_p_m_zero_rucksack", "idle", "Backpack", AnimationOptions =
   {
       Prop = 'p_michael_backpack_s',
       PropBone = 24818,
       PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["clipboard"] = {"missfam4", "base", "Clipboard", AnimationOptions =
   {
       Prop = 'p_amb_clipboard_01',
       PropBone = 36029,
       PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["map"] = {"amb@world_human_tourist_map@male@base", "base", "Map", AnimationOptions =
   {
       Prop = 'prop_tourist_map_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["beg"] = {"amb@world_human_bum_freeway@male@base", "base", "Beg", AnimationOptions =
   {
       Prop = 'prop_beggers_sign_03',
       PropBone = 58868,
       PropPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["makeitrain"] = {"anim@mp_player_intupperraining_cash", "idle_a", "Make It Rain", AnimationOptions =
   {
       Prop = 'prop_anim_cash_pile_01',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_xs_celebration",
       PtfxName = "scr_xs_money_rain",
       PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
       PtfxWait = 500,
   }},
   ["camera"] = {"amb@world_human_paparazzi@male@base", "base", "Camera", AnimationOptions =
   {
       Prop = 'prop_pap_camera_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       PtfxAsset = "scr_bike_business",
       PtfxName = "scr_bike_cfid_camera_flash",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
       PtfxWait = 200,
   }},
   ["champagnespray"] = {"anim@mp_player_intupperspray_champagne", "idle_a", "Champagne Spray", AnimationOptions =
   {
       Prop = 'ba_prop_battle_champ_open',
       PropBone = 28422,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_ba_club",
       PtfxName = "scr_ba_club_champagne_spray",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['spraychamp'],
       PtfxWait = 500,
   }},
   ["joint"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Joint", AnimationOptions =
   {
       Prop = 'p_cs_joint_02',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cig"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cig", AnimationOptions =
   {
       Prop = 'prop_amb_ciggy_01',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["brief3"] = {"missheistdocksprep1hold_cellphone", "static", "Brief 3", AnimationOptions =
   {
       Prop = "prop_ld_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet"] = {"amb@world_human_tourist_map@male@base", "base", "Tablet", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Tablet 2", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phonecall"] = {"cellphone@", "cellphone_call_listen_base", "Phone Call", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phone"] = {"cellphone@", "cellphone_text_read_base", "Phone", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clean"] = {"timetable@floyd@clean_kitchen@base", "base", "Clean", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clean2"] = {"amb@world_human_maid_clean@", "base", "Clean 2", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["boombox2"] = {"molly@boombox1", "boombox1_clip", "Boombox 2", AnimationOptions = 
   {
       Prop = "prop_cs_sol_glasses",
       PropBone = 31086,
       PropPlacement = {0.0440, 0.0740, 0.0000, -160.9843, -88.7288, -0.6197},
       SecondProp = 'prop_ghettoblast_02',
       SecondPropBone = 10706,
       SecondPropPlacement = {-0.2310, -0.0770, 0.2410, -179.7256, 176.7406, 23.0190},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["candyapple"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Candy Apple", AnimationOptions = 
    {
        Prop = "apple_1",
        PropBone = 18905,
        PropPlacement = {0.12, 0.15, 0.0, -100.0, 0.0, -12.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["vape"] = {"amb@world_human_smoking@male@male_b@base", "base", "Vape", AnimationOptions = 
    {
        Prop = 'ba_prop_battle_vape_01',
        PropBone = 28422,
        PropPlacement = {-0.0290, 0.0070, -0.0050, 91.0, 270.0, -360.0},
        EmoteMoving = true,
        EmoteLoop = true,
        PtfxAsset = "core",
        PtfxName = "exp_grd_bzgas_smoke",
        PtfxNoProp = true,
        PtfxPlacement = {-0.0100, 0.0600, 0.6600, 0.0, 0.0, 0.0, 2.0},
        PtfxInfo = Config.Languages[Config.MenuLanguage]['vape'],
        PtfxWait = 0,
    }},
    ["weedbucket"] = {"anim@heists@box_carry@", "idle", "Weed Bucket", AnimationOptions = 
    {
        Prop = "bkr_prop_weed_bucket_open_01a",
        PropBone = 28422,
        PropPlacement = {0.0, -0.1000, -0.1800, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["pump3"] = {"missfbi4prepp1", "idle", "Pumpkin 3", AnimationOptions = 
    {
        Prop = "reh_prop_reh_lantern_pk_01a",
        PropBone = 28422,
        PropPlacement = {0.0010, 0.0660, -0.0120, 171.9169, 179.8707,-39.9860},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["pump4"] = {"missfbi4prepp1", "idle", "Pumpkin 4", AnimationOptions = 
    {
        Prop = "reh_prop_reh_lantern_pk_01b",
        PropBone = 28422,
        PropPlacement = {0.0010, 0.0660, -0.0120, 171.9169, 179.8707, -39.9860},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["pump5"] = {"missfbi4prepp1", "idle", "Pumpkin 5", AnimationOptions = 
    {
        Prop = "reh_prop_reh_lantern_pk_01c",
        PropBone = 28422,
        PropPlacement = {0.0010, 0.0660, -0.0120, 171.9169, 179.8707, -39.9860},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["apple"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Apple", AnimationOptions = 
    {
        Prop = 'sf_prop_sf_apple_01b',
        PropBone = 60309,
        PropPlacement = {0.0, 0.0150, -0.0200, -124.6964, -166.5760, 8.4572},
        EmoteMoving = true,
    }},
    ["taco"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Taco", AnimationOptions = 
    {
        Prop = 'prop_taco_01',
        PropBone = 60309,
        PropPlacement = {-0.0170, 0.0070, -0.0210, 107.9846, -105.0251, 55.7779},
        EmoteMoving = true,
    }},
    ["hotdog"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Hotdog", AnimationOptions = 
    {
        Prop = 'prop_cs_hotdog_02',
        PropBone = 60309,
        PropPlacement = {-0.0300, 0.0100, -0.0100, 95.1071, 94.7001, -66.9179},
        EmoteMoving = true,
    }},
    ["newspaper"] = {"amb@world_human_clipboard@male@idle_a", "idle_a", "Newspaper", AnimationOptions = 
    {
        Prop = 'prop_cliff_paper',
        PropBone = 60309,
        PropPlacement = {0.0970, -0.0280, -0.0170, 107.4008, 3.2712, -10.5080},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["newspaper2"] = {"amb@world_human_clipboard@male@idle_a", "idle_a", "Newspaper 2", AnimationOptions = 
    {
        Prop = 'ng_proc_paper_news_quik',
        PropBone = 60309,
        PropPlacement = {0.1590, 0.0290, -0.0100, 90.9998, 0.0087, 0.5000},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["newspaper3"] = {"amb@world_human_clipboard@male@idle_a", "idle_a", "Newspaper 3", AnimationOptions = 
    {
        Prop = 'ng_proc_paper_news_rag',
        PropBone = 60309,
        PropPlacement = {0.1760, -0.00070, 0.0200, 99.8306, 3.2841, -4.7185},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["pornmag"] = {"amb@world_human_clipboard@male@base", "base", "Porn Magazine", AnimationOptions = 
    {
        Prop = 'prop_porn_mag_02',
        PropBone = 60309,
        PropPlacement = {0.1000, -0.0360, -0.0300, -86.9096, 179.2527, 13.8804},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["pornmag2"] = {"amb@world_human_clipboard@male@base", "base", "Porn Magazine 2", AnimationOptions = 
    {
        Prop = 'prop_cs_magazine',
        PropBone = 60309,
        PropPlacement = {0.0800, -0.0490, -0.0500, 87.9369, -0.4292, -14.3925},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["pornmag3"] = {"amb@world_human_clipboard@male@base", "base", "Porn Magazine 3", AnimationOptions = 
    {
        Prop = 'prop_porn_mag_03',
        PropBone = 60309,
        PropPlacement = {0.1000, -0.0700, -0.0200, -90.0000, -180.0000, 22.7007},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["pornmag4"] = {"amb@world_human_clipboard@male@base", "base", "Porn Magazine 4", AnimationOptions = 
    {
        Prop = 'v_res_tt_pornmag01',
        PropBone = 60309,
        PropPlacement = {-0.0200, -0.0300, 0.0000, 88.9862, 0.2032, -20.0016},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["pornmag5"] = {"amb@world_human_clipboard@male@base", "base", "Porn Magazine 5", AnimationOptions = 
    {
        Prop = 'v_res_tt_pornmag02',
        PropBone = 60309,
        PropPlacement = {-0.0200, -0.0300, 0.0000, 88.9862, 0.2032, -20.0016},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["pornmag6"] = {"amb@world_human_clipboard@male@base", "base", "Porn Magazine 6", AnimationOptions = 
    {
        Prop = 'v_res_tt_pornmag03',
        PropBone = 60309,
        PropPlacement = {-0.0200, -0.0300, 0.0000, 88.9862, 0.2032, -20.0016},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["pornmag7"] = {"amb@world_human_clipboard@male@base", "base", "Porn Magazine 7", AnimationOptions = 
    {
        Prop = 'v_res_tt_pornmag04',
        PropBone = 60309,
        PropPlacement = {-0.0200, -0.0300, 0.0000, 88.9862, 0.2032, -20.0016},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["donut2"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut Chocolate", AnimationOptions = 
    {
        Prop = 'bzzz_foodpack_donut002',
        PropBone = 60309,
        PropPlacement = {0.0000, -0.0300, -0.0100, 10.0000, 0.0000, -1.0000},
        EmoteMoving = true,
    }},
    ["donut3"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut Raspberry", AnimationOptions = 
    {
        Prop = 'bzzz_foodpack_donut001',
        PropBone = 60309,
        PropPlacement = {0.0000, -0.0300, -0.0100, 10.0000, 0.0000, -1.0000},
        EmoteMoving = true,
    }},
    ["croissant"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Croissant", AnimationOptions = 
    {
        Prop = 'bzzz_foodpack_croissant001',
        PropBone = 60309,
        PropPlacement = {0.0000, 0.0000, -0.0100, 0.0000, 0.0000, 90.0000},
        EmoteMoving = true,
    }},
    ["lollipop1"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Lollipop Spiral Red", AnimationOptions = 
    {
        Prop = 'natty_lollipop_spiral01',
        PropBone = 60309,
        PropPlacement = {-0.0100, 0.0200, -0.0100, -175.1935, 97.6975, 20.9598},
        EmoteMoving = true,
    }},
    ["lollipop1b"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Lollipop Spiral Pink", AnimationOptions = 
    {
        Prop = 'natty_lollipop_spiral02',
        PropBone = 60309,
        PropPlacement = {-0.0100, 0.0200, -0.0100, -175.1935, 97.6975, 20.9598},
        EmoteMoving = true,
    }},
    ["lollipop1c"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Lollipop Spiral Green", AnimationOptions = 
    {
        Prop = 'natty_lollipop_spiral03',
        PropBone = 60309,
        PropPlacement = {-0.0100, 0.0200, -0.0100, -175.1935, 97.6975, 20.9598},
        EmoteMoving = true,
    }},
    ["lollipop1d"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Lollipop Spiral Blue", AnimationOptions = 
    {
        Prop = 'natty_lollipop_spiral04',
        PropBone = 60309,
        PropPlacement = {-0.0100, 0.0200, -0.0100, -175.1935, 97.6975, 20.9598},
        EmoteMoving = true,
    }},
    ["lollipop1e"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Lollipop Spiral Yellow", AnimationOptions = 
    {
        Prop = 'natty_lollipop_spiral05',
        PropBone = 60309,
        PropPlacement = {-0.0100, 0.0200, -0.0100, -175.1935, 97.6975, 20.9598},
        EmoteMoving = true,
    }},
    ["lollipop1f"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Lollipop Spiral Purple", AnimationOptions = 
    {
        Prop = 'natty_lollipop_spiral06',
        PropBone = 60309,
        PropPlacement = {-0.0100, 0.0200, -0.0100, -175.1935, 97.6975, 20.9598},
        EmoteMoving = true,
    }},
    ["lollipop2a"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Lollipop Spin Red", AnimationOptions = 
    {
        Prop = "natty_lollipop_spin01",
        PropBone = 60309,
        PropPlacement = {-0.0300, -0.0500, 0.0500, 112.4227, -128.8559, 15.6107},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["lollipop2b"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Lollipop Spin Yellow And Pink", AnimationOptions = 
    {
        Prop = "natty_lollipop_spin02",
        PropBone = 60309,
        PropPlacement = {-0.0300, -0.0500, 0.0500, 112.4227, -128.8559, 15.6107},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["lollipop2c"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Lollipop Spin Yellow And Green", AnimationOptions = 
    {
        Prop = "natty_lollipop_spin03",
        PropBone = 60309,
        PropPlacement = {-0.0300, -0.0500, 0.0500, 112.4227, -128.8559, 15.6107},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["lollipop2d"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Lollipop Spin Yellow And White", AnimationOptions = 
    {
        Prop = "natty_lollipop_spin04",
        PropBone = 60309,
        PropPlacement = {-0.0300, -0.0500, 0.0500, 112.4227, -128.8559, 15.6107},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["lollipop2e"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Lollipop Spin Pink And White", AnimationOptions = 
    {
        Prop = "natty_lollipop_spin05",
        PropBone = 60309,
        PropPlacement = {-0.0300, -0.0500, 0.0500, 112.4227, -128.8559, 15.6107},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["lollipop3a"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Lollipop Suck", AnimationOptions = 
    {
        Prop = 'natty_lollipop01',
        PropBone = 47419,
        PropPlacement = {0.0100, 0.0300, 0.0100, -90.0000, 10.0000, -10.0000},
        EmoteMoving = true,
        EmoteDuration = 2600
    }},
    ["shaka"] = {"sign@hang_loose", "base", "Shaka 'Hang Loose'", AnimationOptions = 
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["shaka2"] = {"sign@hang_loose_casual", "base", "Shaka 'Hang Loose Casual'", AnimationOptions = 
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["selfiecrouch"] = {"crouching@taking_selfie", "base", "Selfie Crouching", AnimationOptions = 
    {
        Prop = "prop_phone_ing",
        PropBone = 18905,
        PropPlacement = {0.1580, 0.0180, 0.0300, -150.4798, -67.8240, -46.0417},
        EmoteLoop = true,
        EmoteMoving = false,
        PtfxAsset = "scr_tn_meet",
        PtfxName = "scr_tn_meet_phone_camera_flash",
        PtfxPlacement = {-0.015, 0.0, 0.041, 0.0, 0.0, 0.0, 1.0},
        PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
        PtfxWait = 200,
    }},
    ["selfiecrouch2"] = {"eagle@girlphonepose13", "girl", "Selfie Crouching 2", AnimationOptions = 
    {
        Prop = "prop_phone_ing",
        PropBone = 60309,
        PropPlacement = {0.0670, 0.0300, 0.0300, -90.0000, 0.0000, -25.9000},
        EmoteLoop = true,
        EmoteMoving = false,
        PtfxAsset = "scr_tn_meet",
        PtfxName = "scr_tn_meet_phone_camera_flash",
        PtfxPlacement = {-0.015, 0.0, 0.041, 0.0, 0.0, 0.0, 1.0},
        PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
        PtfxWait = 200,
    }},
    ["selfiecrouch3"] = {"anim@male_insta_selfie", "insta_selfie_clip", "Selfie Crouching 3", AnimationOptions = 
    {
        Prop = "prop_phone_ing",
        PropBone = 60309,
        PropPlacement = {0.0700, 0.0100, 0.0690, 0.0, 0.0, -150.0000},
        EmoteLoop = true,
        EmoteMoving = false,
        PtfxAsset = "scr_tn_meet",
        PtfxName = "scr_tn_meet_phone_camera_flash",
        PtfxPlacement = {-0.015, 0.0, 0.041, 0.0, 0.0, 0.0, 1.0},
        PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
        PtfxWait = 200,
    }},
    ["selfiefu"] = {"anim@fuck_you_selfie", "fuck_you_selfie_clip", "Selfie Middle Finger", AnimationOptions = 
    {
        Prop = "prop_phone_ing",
        PropBone = 28422,
        PropPlacement = {0.1200, 0.0220, -0.0210, 98.6822, -4.9809, 109.6216},
        EmoteLoop = true,
        EmoteMoving = false,
        PtfxAsset = "scr_tn_meet",
        PtfxName = "scr_tn_meet_phone_camera_flash",
        PtfxPlacement = {-0.015, 0.0, 0.041, 0.0, 0.0, 0.0, 1.0},
        PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
        PtfxWait = 200,
    }},
    ["selfiethot"] = {"anim@sitting_thot", "sitting_thot_clip", "Selfie Thot Instagram", AnimationOptions = 
    {
        Prop = "prop_phone_ing",
        PropBone = 28422,
        PropPlacement = {0.1030, 0.0440, -0.0270, -160.2802, -99.4080, -3.4048},
        EmoteLoop = true,
        EmoteMoving = false,
        PtfxAsset = "scr_tn_meet",
        PtfxName = "scr_tn_meet_phone_camera_flash",
        PtfxPlacement = {-0.015, 0.0, 0.041, 0.0, 0.0, 0.0, 1.0},
        PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
        PtfxWait = 200,
    }},
    ["bball"] = {"anim@male_bskball_hold", "bskball_hold_clip", "Basketball Hold", AnimationOptions = 
    {
        Prop = "prop_bskball_01",
        PropBone = 28422,
        PropPlacement = {0.0600, 0.0400, -0.1200, 0.0, 0.0, 40.00},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["bball2"] = {"anim@male_bskball_photo_pose", "photo_pose_clip", "Basketball Pose", AnimationOptions = 
    {
        Prop = "prop_bskball_01",
        PropBone = 60309,
        PropPlacement = {-0.0100, 0.0200, 0.1300, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["selfiepeace"] = {"mirror_selfie@peace_sign", "base", "Selfie Peace", AnimationOptions = 
    {
        Prop = "prop_phone_ing",
        PropBone = 57005,
        PropPlacement = {0.1700, 0.0299, -0.0159, -126.2687, -139.9058, 35.6203},
        EmoteLoop = true,
        EmoteMoving = true,
        PtfxAsset = "scr_tn_meet",
        PtfxName = "scr_tn_meet_phone_camera_flash",
        PtfxPlacement = {-0.015, 0.0, 0.041, 0.0, 0.0, 0.0, 1.0},
        PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
        PtfxWait = 200,
    }},
    ["beer2"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Beer", AnimationOptions =
   {
       Prop = 'prop_cs_beer_bot_40oz',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["spray"] = {"switch@franklin@lamar_tagging_wall", "lamar_tagging_exit_loop_lamar", "Spray", AnimationOptions =
   {
        Prop = 'prop_cs_spray_can',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = false,
        PtfxAsset = "scr_playerlamgraff",
        PtfxName = "scr_lamgraff_paint_spray",
        PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        PtfxInfo = Config.Languages[Config.MenuLanguage]['spray'],
        PtfxWait = 5000,
   }},
   ["spray2"] = {"switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar", "Spray 2", AnimationOptions =
   {
        Prop = 'prop_cs_spray_can',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
        EmoteLoop = true,
        EmoteMoving = true,
   }},
   ["ftorch"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Fire Torch", AnimationOptions = 
   {
        Prop = "bzzz_prop_torch_fire001",
        PropBone = 18905,
        PropPlacement = {0.14, 0.21, -0.08, -110.0, -1.0, -10.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ['ftorch2'] = {"rcmnigel1d", "base_club_shoulder", "Fire Torch 2", AnimationOptions = 
    {
        Prop = "bzzz_prop_torch_fire001",
        PropBone = 28422,
        PropPlacement = {-0.0800, -0.0300, -0.1700, 11.4181, -159.1026, 15.0338},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["gamer"] = {"playing@with_controller", "base", "Gamer", AnimationOptions = 
    {
        Prop = 'prop_controller_01',
        PropBone = 24818,
        PropPlacement = {0.2890, 0.4110, 0.0020, -44.0174, 88.6103, -1.4385},
        EmoteLoop = true,
    }},
}