local WEBHOOK_URL = GetConvar("core-rob-truck-webhook", "")

cfg = {}

cfg.debug = false -- debug version to check some stuff [prints]
cfg.framework = "standalone" --esx,qbcore,vrp,vrpex,nunoradioman,standalone | Check server/functions.lua
cfg.interaction = "markermenu" --qbtarget,markermenu,gtav
cfg.dispatch = "standalone" --nunoradioman,ps_dispatch,cd_dispatch,core_dispatch

cfg.police = {
	groups = {"sheriff","corrections"}, -- police groups
	amount = 4, -- police amount
}
cfg.timers = {
	reset_timer = 60, -- minutes
	npc_timer = 300 -- seconds
}
cfg.notification = {
    selected = "gtav", -- gtav,qbcore,esx
    notifications = {
        noitem = "You dont have the item needed for this action.", -- message
        nopolice = "There are too many Security Personnel monitoring the network. Try again later.", -- message
    },
}
cfg.log = {
	active = true,
	logs = {
		["start"] = { -- This is the log that is used when a player starts the robbery.
			webhook = WEBHOOK_URL, -- This is the webhook that you have to set.
			title = "Truck Robbery",-- title of the embed message
			msg = "The robbery just got started.", -- message , for more control check server/functions.lua
			avatar = "https://imgur.com/jOcxS1Q.png", -- webhook avatar
			username = "Nuno Radio Man Robberies", -- webhook username
			footer = "Nuno Radio Man Robberies", -- embeded footer.
		},
		["giveitem"] = { -- This is the log that is used when a player gets a reward from the script.
			webhook = WEBHOOK_URL, -- This is the webhook that you have to set.
			title = "Truck Robbery", -- title of the embed message
			msg = "Received", -- message , for more control check server/functions.lua
			avatar = "https://imgur.com/jOcxS1Q.png", -- webhook avatar
			username = "Nuno Radio Man Robberies", -- webhook username
			footer = "Nuno Radio Man Robberies", -- embeded footer.
		},
		["removeitem"] = { -- This is the log that is used when a player removes an item .
			webhook = WEBHOOK_URL, -- This is the webhook that you have to set.
			title = "Truck Robbery", -- title of the embed message
			msg = "Removed", -- message , for more control check server/functions.lua
			avatar = "https://imgur.com/jOcxS1Q.png", -- webhook avatar
			username = "Nuno Radio Man Robberies", -- webhook username
			footer = "Nuno Radio Man Robberies", -- embeded footer.
		},
		["luaexecutors"] = { -- This is the log that is used when a player tries to trigger events to give items 100% Lua Executor.
			webhook = WEBHOOK_URL, -- This is the webhook that you have to set.
			title = "Truck Robbery", -- title of the embed message
			msg = "Cheater", -- message , for more control check server/functions.lua
			avatar = "https://imgur.com/jOcxS1Q.png", -- webhook avatar
			username = "Nuno Radio Man Robberies", -- webhook username
			footer = "Nuno Radio Man Robberies", -- embeded footer.
		},
	},
}

cfg.robbery = {
    reset = false,
    npcs = {},
    interactables = {
        { -- 1
            type = "securitypanel01", -- type of loot
            pos = {960.78088378906, 20.195, 111.28333282471 + 0.4,0.0,0.0,147.50}, -- {pos_x,pos_y,pos_z,rot_x,rot_y,rot_z}
            offset = {0.0,0.0,0.0}, -- {offset_x,offset_y,offset_z}

            hash_type = "normal", -- "normal" "rarity" "nospawn"
            hash = GetHashKey("hei_prop_hei_securitypanel"), -- hash of the model that will spawn

            net_id = 0, -- dont change
            status = false, -- dont change
            done = false, -- dont change
            spawned = false, -- dont change

            robberyspawn = true, -- If this is true , will check if robbery data exists if it does then will create the vehicle,interactables and npcs.

            polyzone = {0.3,0.5,0.0,0.0,2.0}, -- {length,width,minZextra,maxZextra,distance}
            options = {
                {
                    type = "hacksecuritypanel_01",

                    item_needed = {
                        {"Bank Laptop",1,7}, -- {item_name,item_amount,chance_to_remove} 7% chance of removal after use
                        {"Blackhat USB Drive",1,1}, -- {item_name,item_amount,chance_to_remove} 1% chance of removal after use
                    },

                    minigame = {
                        event = "CORE_ROB_MINIGAMES:HotWire_c",
                        data = {
                            remaininglifes = 1,
                            time = 1, -- minutes
                        },
                    },

					markermenu = {"[E] Hack",38}, -- {text,key}
					displayhelp = {"~INPUT_SELECT_WEAPON_UNARMED~ Hack",38}, -- {text,key}
					polyzone = {"Hack","fa-solid fa-laptop"},-- {label,targeticon}

					camera = true, -- if you want the cinematic camera system put "true" otherwise put "false".
					checkforpolice = true, -- if true when you try to interact it will check for the police before you start the animation.
					dispatch = {
						call = true, -- if you want this option to call the police set to "true" otherwise set to "false".
						delay = 60, -- Delay to call the police when you start the action, it is in "seconds".

						code = "10-91", -- Code Prefix to "title"
						message = "A Security Panel is being hacked. Investigate the area for suspicious activity.", -- Notification
						sprite = 772, -- Blip Sprite
						color = 1, -- Blip Color
						scale = 1.0, -- Blip Scale
						time = 300, -- Seconds
					},
                },
            },
        },
        { -- 2
            type = "securitypanel01", -- type of loot
            pos = {287.75985717773, -305.65, 49.864246368408 + 0.4,0.0,0.0,249.98}, -- {pos_x,pos_y,pos_z,rot_x,rot_y,rot_z}
            offset = {0.0,0.0,0.0}, -- {offset_x,offset_y,offset_z}

            hash_type = "normal", -- "normal" "rarity" "nospawn"
            hash = GetHashKey("hei_prop_hei_securitypanel"), -- hash of the model that will spawn

            net_id = 0, -- dont change
            status = false, -- dont change
            done = false, -- dont change
            spawned = false, -- dont change

            robberyspawn = true, -- If this is true , will check if robbery data exists if it does then will create the vehicle,interactables and npcs.

            polyzone = {0.3,0.5,0.0,0.0,2.0}, -- {length,width,minZextra,maxZextra,distance}
            options = {
                {
                    type = "hacksecuritypanel_01",

                    item_needed = {
                        {"Bank Laptop",1,7}, -- {item_name,item_amount,chance_to_remove} 7% chance of removal after use
                        {"Blackhat USB Drive",1,1}, -- {item_name,item_amount,chance_to_remove} 1% chance of removal after use
                    },
                    minigame = {
                        event = "CORE_ROB_MINIGAMES:TerminalMinigame_c",
                        data = {
                            background = 4, -- 0 to 6 | MUST BE INTEGER
                            lives = 7.0, -- max is 7.0 | MUST BE FLOAT
                            difficulty = "easy", -- "easy" "medium" "hard" "veryhard"
                            timer = 700, -- seconds , max is 3600 which is 1 hour.
                        },
                    },
					markermenu = {"[E] Hack",38}, -- {text,key}
					displayhelp = {"~INPUT_SELECT_WEAPON_UNARMED~ Hack",38}, -- {text,key}
					polyzone = {"Hack","fa-solid fa-laptop"},-- {label,targeticon}

					camera = true, -- if you want the cinematic camera system put "true" otherwise put "false".
					checkforpolice = true, -- if true when you try to interact it will check for the police before you start the animation.
					dispatch = {
						call = true, -- if you want this option to call the police set to "true" otherwise set to "false".
						delay = 60, -- Delay to call the police when you start the action, it is in "seconds".

						code = "10-91", -- Code Prefix to "title"
						message = "A Security Panel is being hacked. Investigate the area for suspicious activity.", -- Notification
						sprite = 772, -- Blip Sprite
						color = 1, -- Blip Color
						scale = 1.0, -- Blip Scale
						time = 300, -- Seconds
					},
                },
            },
        },
        { -- 3
            type = "securitypanel01", -- type of loot
            pos = {-2947.91, 485.52276611328, 15.458961486816 + 0.4,0.0,0.0,88.46}, -- {pos_x,pos_y,pos_z,rot_x,rot_y,rot_z}
            offset = {0.0,0.0,0.0}, -- {offset_x,offset_y,offset_z}

            hash_type = "normal", -- "normal" "rarity" "nospawn"
            hash = GetHashKey("hei_prop_hei_securitypanel"), -- hash of the model that will spawn

            net_id = 0, -- dont change
            status = false, -- dont change
            done = false, -- dont change
            spawned = false, -- dont change

            robberyspawn = true, -- If this is true , will check if robbery data exists if it does then will create the vehicle,interactables and npcs.

            polyzone = {0.3,0.5,0.0,0.0,2.0}, -- {length,width,minZextra,maxZextra,distance}
            options = {
                {
                    type = "hacksecuritypanel_01",

                    item_needed = {
                        {"Bank Laptop",1,7}, -- {item_name,item_amount,chance_to_remove} 7% chance of removal after use
                        {"Blackhat USB Drive",1,1}, -- {item_name,item_amount,chance_to_remove} 1% chance of removal after use
                    },

                    minigame = {
                        event = "CORE_ROB_MINIGAMES:HackFingerprint_c",
                        data = {
                            lives = 1, -- min is 1 max is 6
                            timer = 700, -- seconds , max is 3600 which is 1 hour.
                            scrambletimer = 2, -- seconds 
                            fingerprints = 2, -- min is 1 max is 4 , this is how much fingerprints you want
                        },
                    },

					markermenu = {"[E] Hack",38}, -- {text,key}
					displayhelp = {"~INPUT_SELECT_WEAPON_UNARMED~ Hack",38}, -- {text,key}
					polyzone = {"Hack","fa-solid fa-laptop"},-- {label,targeticon}

					camera = true, -- if you want the cinematic camera system put "true" otherwise put "false".
					checkforpolice = true, -- if true when you try to interact it will check for the police before you start the animation.
					dispatch = {
						call = true, -- if you want this option to call the police set to "true" otherwise set to "false".
						delay = 60, -- Delay to call the police when you start the action, it is in "seconds".

						code = "10-91", -- Code Prefix to "title"
						message = "A Security Panel is being hacked. Investigate the area for suspicious activity.", -- Notification
						sprite = 772, -- Blip Sprite
						color = 1, -- Blip Color
						scale = 1.0, -- Blip Scale
						time = 300, -- Seconds
					},
                },
            },
        },
    },
    robbery = {
        vehicle = {
			type = "vehicle", -- "object" or "vehicle".
			model = GetHashKey("stockade"), -- hash of the vehicle that will spawn
			freeze = false, -- freezes the vehicle

			net_id = 0, -- dont change
			spawned = false, -- dont change

			positions = { -- possible positions
				{-62.135330200195,-488.04809570313,32.037963867188,88.29}, -- {x,y,z,heading}
				{1028.7606201172,-999.56457519531,29.819650650024,189.2}, -- {x,y,z,heading}
				{778.5556640625,-1931.2908935547,29.207706451416,168.09}, -- {x,y,z,heading}
				{-117.79901885986,-2521.130859375,44.217288970947,54.83}, -- {x,y,z,heading}
				{-748.8974609375,-1773.1832275391,29.366983413696,3.33}, -- {x,y,z,heading}
				{-1818.0847167969,120.3814239502,75.563262939453,46.68}, -- {x,y,z,heading}
				{-2020.5026855469,899.17120361328,172.22328186035,185.45}, -- {x,y,z,heading}
				{-1443.5631103516,1835.9090576172,79.658889770508,332.82}, -- {x,y,z,heading}
				{-1341.16796875,2434.8979492188,27.564054489136,359.72}, -- {x,y,z,heading}
				{411.31060791016,3488.2575683594,34.632152557373,196.11}, -- {x,y,z,heading}
				{2912.25390625,3944.4963378906,51.889507293701,181.05}, -- {x,y,z,heading}
			},

			interactables = {
                { -- 1
                    type = "truck01", -- type of loot
                    pos = {0.0,0.0,0.0,0.0,0.0,0.0}, -- {pos_x,pos_y,pos_z,rot_x,rot_y,rot_z} 
                    offset = {0.0,-3.5,0.0}, -- {offset_x,offset_y,offset_z}
        
                    hash_type = "nospawn", -- "normal" "rarity" "nospawn"
                    hash = "", -- hash of the model that will spawn
        
                    net_id = 0, -- dont change
                    status = false, -- dont change
                    done = false, -- dont change
                    spawned = false, -- dont change
        
                    polyzone = {0.3,2.4,0.0,0.0,2.0}, -- {length,width,minZextra,maxZextra,distance}
                    options = {
                        {
                            type = "bombtruck_01",
        
                            item_needed = {
                                {"Armed Truck Bomb",1,100}, -- {item_name,item_amount,chance_to_remove}
                            },
        
                            explosivetimer = 60, -- seconds

                            markermenu = {"[E] Plant Bomb",51}, -- {text,key}
                            displayhelp = {"~INPUT_TALK~ Plant Bomb",51}, -- {text,key}
                            polyzone = {"Plant Bomb","fa-solid fa-burst"},-- {label,targeticon}
        
                            camera = true, -- if you want the cinematic camera system put "true" otherwise put "false".
                            checkforpolice = true, -- if true when you try to interact it will check for the police before you start the animation.
                            dispatch = {
                                call = true, -- if you want this option to call the police set to "true" otherwise set to "false".
                                delay = 0, -- Delay to call the police when you start the action, it is in "seconds".
        
                                code = "10-99C", -- Code Prefix to "title"
                                message = "A Gruppe Sechs Truck is being robbed, someone just planted a bomb. Security Personnel in distress.", -- Notification
                                sprite = 822, -- Blip Sprite
                                color = 1, -- Blip Color
                                scale = 1.0, -- Blip Scale
                                time = 300, -- Seconds
                            },
        
                            --This is responsible for spawning the money
                            cash_amount = 10, -- amount of cash that is spawned
                            cash_interactable = {
                                type = "cash01", -- type of loot
                                pos = {0.0,0.0,0.0,0.0,0.0,0.0}, -- {pos_x,pos_y,pos_z,rot_x,rot_y,rot_z} 
                                offset = {0.0,0.0,0.0},
                        
                                hash_type = "nospawn", -- "normal" "rarity" "nospawn"
                                hash = GetHashKey("prop_cash_pile_02"), -- hash of the model that will spawn
                        
                                net_id = 0, -- dont change
                                status = false, -- dont change
                                done = false, -- dont change
                                spawned = false, -- dont change
        
                                polyzone = {0.2,0.2,0.0,0.05,2.0}, -- {length,width,minZextra,maxZextra}
                                options = {
                                    {
                                        type = "grablow_01",
        
                                        item_to_give_type = "normal", -- "normal" or "random" | "normal" trys to spawn every item, "random" gets an random item, not by rarity.
                                        item_to_give = {
                                            {"money",2000,5000,100}, -- {item_name,amount_min,amount_max,item_rarity} Min: $20,000 | Max: $50,000
                                            {"Stolen Goods",1,7,15}, -- 15% chance
                                            {"Chris Cortega",1,1,1}, -- 1% chance cuz am the best
                                        },
        
                                        markermenu = {"[E] Collect",51},-- {text,key}
                                        displayhelp = {"~INPUT_TALK~ Collect",51},-- {text,key}
                                        polyzone = {"Collect","fa-solid fa-money-bill"},-- {label,targeticon,length,width,minZextra,maxZextra,offset_x,offset_y,offset_z}

                                        camera = true, -- if you want the cinematic camera system put "true" otherwise put "false".
                                        checkforpolice = true, -- if true when you try to interact it will check for the police before you start the animation.
                                        dispatch = nil,
                                    },
                                },
                            },
                        },
                    },
                },
			},
			npcs = {
				{ -- 1
					type = "vehicle", -- "position" , "vehicle" , "position" uses the pos variable bellow, "vehicle" uses the vehicle_inside variable to spawn the npc inside the vehicle.
					pos = {0.0,0.0,0.0,0.0}, -- {x,y,z,heading} 
					hash = GetHashKey("s_m_m_armoured_01"), -- npc hash

                    customization_type = "random", -- "random" | "normal"
					relationship = "agressive_ontriggered", -- "agressive_onsight","agressive_ontriggered"
					accuracy = 50, -- changes the npc accuracy
                    respawn = false, -- This variable controls if the npc respawns
                    vehicle_inside = -1, -- spawns the npc inside the vehicle seat
			
					weapon_possible = {
						GetHashKey("weapon_microsmg"),
						GetHashKey("weapon_smg"),
						GetHashKey("weapon_combatpdw"),
						GetHashKey("weapon_pumpshotgun"),
						GetHashKey("weapon_sawnoffshotgun"),
						GetHashKey("weapon_assaultshotgun"),
						GetHashKey("weapon_assaultrifle"),
						GetHashKey("weapon_carbinerifle"),
						GetHashKey("weapon_advancedrifle"),
					},
			
					net_id = 0, -- dont change
					respawning = false, -- dont change
                    weapon_current = "", -- dont change
				},
				{ -- 2
					type = "vehicle", -- "position" , "vehicle" , "position" uses the pos variable bellow, "vehicle" uses the vehicle_inside variable to spawn the npc inside the vehicle.
					pos = {0.0,0.0,0.0,0.0}, -- {x,y,z,heading}
					hash = GetHashKey("s_m_m_armoured_01"), -- npc hash

                    customization_type = "random", -- "random" | "normal"
					relationship = "agressive_onsight", -- "agressive_onsight","agressive_ontriggered"
					accuracy = 90, -- changes the npc accuracy
                    respawn = false, -- This variable controls if the npc respawns
                    vehicle_inside = 0, -- spawns the npc inside the vehicle seat

					weapon_possible = {
						GetHashKey("weapon_microsmg"),
						GetHashKey("weapon_smg"),
						GetHashKey("weapon_combatpdw"),
						GetHashKey("weapon_pumpshotgun"),
						GetHashKey("weapon_sawnoffshotgun"),
						GetHashKey("weapon_assaultshotgun"),
						GetHashKey("weapon_assaultrifle"),
						GetHashKey("weapon_carbinerifle"),
						GetHashKey("weapon_advancedrifle"),
					},
			
					net_id = 0, -- dont change
					respawning = false, -- dont change
                    weapon_current = "", -- dont change
				},
			},
		},
        blip = {
            type = "point", -- "area","point"
            color = 1, -- Blip Color
            alpha = 100, -- Blip Alpha
			flash = true, -- Blip Flash

            time = 5, -- Blip Remaining Time | Minutes

            name = "Gruppe Sechs Truck" , -- Blip Name ONLY WORKS WHEN TYPE IS "point"
            offset = {250,250}, -- {x,y} ONLY WORKS WHEN TYPE IS "area"
        },
    },
}