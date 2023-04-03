mapBlips = {}

RegisterNetEvent("usa_map_blips:addMapBlip")
AddEventHandler("usa_map_blips:addMapBlip", function(coords, sprite, display, scale, color, shortRange, name, groupName)
	local b = AddBlipForCoord(coords[1], coords[2], coords[3])
	SetBlipSprite(b, sprite)
	SetBlipDisplay(b, display)
	SetBlipScale(b, scale)
	SetBlipColour(b, color)
	SetBlipAsShortRange(b, shortRange)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(name)
	EndTextCommandSetBlipName(b)
	if mapBlips[groupName] == nil then
		mapBlips[groupName] = {}
		table.insert(mapBlips[groupName], {blip = b, group = groupName, display = display})
	else
		table.insert(mapBlips[groupName], {blip = b, group = groupName, display = display})
	end
	TriggerServerEvent("usa_map_blips:addGroup", groupName)
end)

RegisterNetEvent("usa_map_blips:hideBlipGroup")
AddEventHandler("usa_map_blips:hideBlipGroup", function(groupName)
	for index,blip in ipairs(mapBlips[groupName]) do
		SetBlipDisplay(blip.blip, 0)
	end
end)

RegisterNetEvent("usa_map_blips:showBlipGroup")
AddEventHandler("usa_map_blips:showBlipGroup", function(groupName)
	for index,blip in ipairs(mapBlips[groupName]) do
		SetBlipDisplay(blip.blip, blip.display)
	end
end)

RegisterNetEvent("usa_map_blips:hideAllBips")
AddEventHandler("usa_map_blips:hideAllBips", function()
	for key,group in pairs(mapBlips) do
		for index,blip in ipairs(group) do
			SetBlipDisplay(blip.blip, 0)
		end
	end
end)

RegisterNetEvent("usa_map_blips:showAllBips")
AddEventHandler("usa_map_blips:showAllBips", function()
	for key,group in pairs(mapBlips) do
		for index,blip in ipairs(group) do
			SetBlipDisplay(blip.blip, blip.display)
		end
	end
end)

RegisterNetEvent("usa_map_blips:listBlipGroups")
AddEventHandler("usa_map_blips:listBlipGroups", function(groups)
	TriggerEvent("chatMessage", "", {}, "You can hide/show the following groups with /hideblips and /showblips:")
	TriggerEvent("chatMessage", "", {}, groups)
end)

RegisterNetEvent("usa_map_blips:loadBlipSettings")
AddEventHandler("usa_map_blips:loadBlipSettings", function(settings)
	for key,group in pairs(mapBlips) do
		for i,v in ipairs(settings.hidden) do
			if v == key then
				for index,blip in ipairs(group) do
					SetBlipDisplay(blip.blip, 0)
				end
			end
		end
	end
end)

-- Old Blip Stuff

local blips = {
	{title="DMV", colour=4, id=355, scale = 0.65, x = -552.64324951172, y = -190.99810791016, z = 38.21964263916, group = "gov_buildings"},
	{ title="State Police Department", colour = 38 , id = 60, scale = 0.7, x=451.255, y=-992.41, z=30.6896 , group = "police_stations"}, -- LOS SANTOS
	{ title="State Police Department", colour = 38 , id = 60, scale = 0.7, x = 638.9, y = 1.9, z = 81.8, group = "police_stations" }, -- LOS SANTOS, vinewood, elgin ave.
	{ title="State Police Department", colour = 38 , id = 60, scale = 0.7, x = 370.3, y = -1608.4, z = 28.3, group = "police_stations" }, -- LOS SANTOS, davis PD
	{ title="State Police Department", colour = 38 , id = 60, scale = 0.7, x = -1107.5, y = -847.5, z = 19.3, group = "police_stations" }, -- LOS SANTOS, vespucci PD
	{ title="Sheriff's Office", colour = 38 , id = 60, scale = 0.7, x=1853.2, y=3687.74, z=34.267, group = "police_stations" }, -- SANDY
	{ title="Sheriff's Office", colour = 38 , id = 60, scale = 0.7, x=-447.041, y=6012.97, z=31.7164, group = "police_stations" }, -- PALETO
	{ title="Sheriff's Office", colour = 38 , id = 60, scale = 0.7, x = 833.89385986328, y = -1289.7882080078, z = 28.244937896729, group = "police_stations" }, -- La Mesa PD / SO
	{ title="Fire Department", colour = 1, id = 60, scale = 0.7, x=207.106, y=-1641.45, z=28.5, group = "fire_stations" }, -- LOS SANTOS
	{ title="Fire Department", colour = 1, id = 60, scale = 0.7, x=-375.435, y=6114.61, z=35.4397, group = "fire_stations" }, -- PALETO
	{ title="Fire Department", colour = 1, id = 60, scale = 0.7, x=1694.01, y=3589.87, z=40.3212, group = "fire_stations" }, -- SANDY
	{ title="Fire Department", colour = 1, id = 60, scale = 0.7, x = 1200.6988525391, y = -1472.1934814453, z = 34.857078552246, group = "fire_stations"},
	{ title="Hospital", colour = 51, id = 61, scale = 0.7, x = -240.10, y = 6324.22, z = 32.43, group = "hospitals"}, -- paleto
	{ title="Hospital", colour = 51, id = 61, scale = 0.7, x = 1832.5958, y = 3676.7114,  z = 34.2749, group = "hospitals" }, -- sandy
	{ title="Hospital", colour = 51, id = 61, scale = 0.7, x = -817.61511230469, y = -1236.6121826172, z = 7.3374252319336, group = "hospitals" }, -- viceroy medical
	{ title="Hospital", colour = 51, id = 61, scale = 0.7, x = 360.5, y = -584.7, z = 28.8, group = "hospitals" }, -- pillbox medical
	{ title="Vanilla Unicorn", colour = 50, id = 121, scale = 0.7, x=129.607, y=-1299.83, z=29.2327, group = "entertainment"},
	{ title="Tequilala", colour = 15, id = 93, scale = 0.7, x=-564.778, y=274.195, z=83.0197, group = "entertainment"},
	{ title="Bahama Mamas", colour = 15, id = 93, scale = 0.7, x=-1388.94, y=-585.919, z=29.2195, group = "entertainment" },
	{ title="Comedy Club", colour = 4, id = 362, scale = 0.7, x = -429.9, y = 261.6, z = 83.0, group = "entertainment" },
	{ title="Yellow Jack", colour = 15, id = 93, scale = 0.7, x = 1986.1, y = 3050.57, z = 47.2151, group = "entertainment" },
	{ title="Nightclub", colour = 83, id = 136, x = -337.23, y = 207.189, z = 88.57, scale = 0.95, group = "entertainment"},
	{ title="Jail", colour = 4, id = 238, x=1686.668, y=2581.715, z=51.6, group = "gov_buildings"},
	{ title="Courthouse", colour = 84, id = 475, scale = 0.7, x = -572.38031005859, y = -207.75842285156, z = 38.227031707764, group = "gov_buildings" }, -- Cityhall Courtroom
	{ title="Weazel News", colour = 4, id = 184, x = -249.6443, y = 6235.7524, z = 30.4893, group = "jobs" },
	{ title="Weazel News", colour = 4, id = 184, x = -599.5, y = -931.9, z = 23.9, group = "jobs" },
	{ title="Cluckin' Bell", colour = 4, id = 89, x = -69.9295, y = 6251.2900, z = 30.4893, scale = 0.7, group = "jobs" },
	{ title="Vangelico", colour = 81, id = 478, x = -623.4, y = -233.1, z = 38.1, scale = 0.65 },
	{title = "Hunting", x = -1508.83, y = 4978.63, id = 442, colour = 0},
	{ title = "Burger Shot", x = -1189.22, y = -888.43, id = 106, colour = 1, scale = 0.7, group = "jobs"},
	{ title = "Mining", x = -596.51, y = 2090.44, id = 78, colour = 59, scale = 0.5, group = "jobs"},
	{ title = "Mining", x = 1797.88, y = -2831.8, id = 78, colour = 59, scale = 0.5, group = "jobs"},
	{ title = "Casino", x = 923.79486083984,y = 49.580528259277, id = 89, colour = 73, scale = 0.62, group = "entertainment"},
	{ title = "Vishnu's Go-Karts", x = -58.797729492188, y = -1839.8370361328, id = 488, colour = 0, scale = 0.7, group = "entertainment"},
	{ title = "PDM - Rockford Hills", x = -1259.8367919922, y = -361.47216796875, id = 225, colour = 57, scale = 0.8},
	--{ title = "Best Buds", colour = 2, id = 140, x = 377.75665283203, y = -829.908203125, z = 29.302627563477, scale = 0.6 },
	{ title = "White Widow", colour = 2, id = 140, x = 186.72137451172, y = -249.99935913086, z = 54.070400238037, scale = 0.6 },
	{ title = "Underground Track", x = 784.30633544922, y = -1868.2249755859, id = 38, colour = 62, scale = 0.8, group = "entertainment"},
	{ title = "Untamed Autos", x = 1149.8494, y =  -781.1504, id = 402, colour = 5, scale = 0.9},
	--{ title = "Fight Club", x = 1059.5687255859, y = -2409.5798339844, id = 210, colour = 0, scale = 0.4, group = "entertainment"},
	{ title = "RPG", x = -795.98742675781, y = -219.36700439453, id = 402, colour = 5, scale = 0.9},
	{ title = "Dock Container Job", x = 1192.2296142578, y = -3254.0080566406, id = 371, colour = 62, scale = 0.7, group = "jobs"},
	{ title = "Cat Cafe", x = -582.01025390625, y = -1060.6533203125, id = 214, colour = 82, scale = 0.8, group = "entertainment"},
	{ title = "Hayes Auto", x = -1419.1739501953, y = -445.88775634766, id = 402, colour = 5, scale = 0.9},
	{ title = "Autocare Garage", x = 945.94091796875, y = -986.71118164063, id = 402, colour = 5, scale = 0.9},
	{ title = "Apartments", x = -914.08343505859, y = -1306.4748535156, id = 40, colour = 0, scale = 0.7},
	{ title = "Apartments", x = 325.38638305664, y = -209.88813781738, id = 40, colour = 0, scale = 0.7},
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
    	if info.group ~= nil then
    		TriggerEvent("usa_map_blips:addMapBlip", {info.x, info.y, info.z}, info.id, 4, info.scale or 0.8, info.colour, true, info.title, info.group) --coords, sprite, display, scale, color, shortRange, name, groupName)
    	else
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, info.scale or 0.8)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
    end
end)


function GetPlayers()
    local players = {}
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, GetPlayerServerId(i))
        end
    end
    return players
end
