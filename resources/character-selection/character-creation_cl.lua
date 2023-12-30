local hasAlreadySpawnedOnce = false

local menuOpen = false

local spawn_coords_closed_menu = {
	x = 177.596,
	y = 6636.183,
	z = 31.638,
	angle = 168.2
}

local while_menu_open_location = nil

local swap_locations = {
	{name="Clothes Store", x = 1.27486, y = 6511.89, z = 30.8778}, -- paleto bay
	{name="Clothes Store", x = 1692.24, y = 4819.79, z = 41.0631}, -- grape seed
	{name="Clothes Store", x = 1199.09, y = 2707.86, z = 37.0226}, -- sandy shores 1
	{name="Clothes Store", x = 614.565, y = 2763.17, z = 41.0881}, -- sandy shores 2
	{name="Clothes Store", x = -1097.71, y = 2711.18, z = 18.5079}, -- route 68
	{name="Clothes Store", x = -3170.52, y = 1043.97, z = 20.0632}, -- chumash, great ocean hwy
	{name="Clothes Store", x = -1449.93, y = -236.979, z = 49.0106}, -- vinewood 1
	{name="Clothes Store", x = -710.239, y = -152.319, z = 37.0151}, -- vinewood 2
	{name="Clothes Store", x = -1192.84, y = -767.861, z = 17.0187}, -- vinewood 3
	{name="Clothes Store", x = -163.61, y = -303.987, z = 39.0333}, -- vinewood 4
	{name="Clothes Store", x = 125.403, y = -223.887, z = 54.0578}, -- vinewood 5
	{name="Clothes Store", x = 423.474, y = -809.565, z = 29.0911}, -- vinewood 6
	{name="Clothes Store", x = -818.509, y = -1074.14, z = 11.0281}, -- vinewood 7
	{name="Clothes Store", x = 77.7774, y = -1389.87, z = 29.0761}, -- vinewood 8
	{name="Morgue", x = 260.16, y = -1347.09, z = 24.00},
	{name = "Morgue 2", x = 249.3, y = -1355.5, z = 24.5}
}

local camera = nil

local CAMERA_LOCATIONS = {
	-- note: ROT order is pitch, roll, yaw (- goes right, + goes left)
	{
		COORDS = {550.49926757813, 6458.6333007813, 37.48811340332},
		ROT = {0.0, 0.0, -40.0},
		PED_COORDS = {x = 569.42376708984, y = 6443.505859375, z = 47.761920928955}
	},
	{
		COORDS = {548.78338623047, 6475.6381835938, 165.71755981445},
		ROT = {0.0, 0.0, -150.0},
		PED_COORDS = {x = 569.42376708984, y = 6443.505859375, z = 47.761920928955}
	},
	{
		COORDS = {548.78338623047, 6475.6381835938, 165.71755981445},
		ROT = {0.0, 0.0, 150.0},
		PED_COORDS = {x = 569.42376708984, y = 6443.505859375, z = 47.761920928955}
	},
	{
		COORDS = {548.78338623047, 6475.6381835938, 165.71755981445},
		ROT = {0.0, 0.0, 70.0},
		PED_COORDS = {x = 569.42376708984, y = 6443.505859375, z = 47.761920928955}
	},
	{
		COORDS = {-421.22219848633, 5952.3671875, 46.48246383667},
		ROT = {0.0, 0.0, 150.0},
		PED_COORDS = {x = -507.51861572266, y = 5959.2451171875, z = 98.814010620117}
	},
	{
		COORDS = {-803.09161376953, 6870.9780273438, 14.492477416992},
		ROT = {0.0, 0.0, -120.0},
		PED_COORDS = {x = -1186.3214111328, y = 7199.755859375, z = 208.49247741699}
	},
	{
		COORDS = {85.910736083984, 6803.1103515625, 22.514495849609},
		ROT = {0.0, 0.0, -75.0},
		PED_COORDS = {x = 116.60729217529, y = 6814.64453125, z = 101.51449584961}
	},
	{
		COORDS = {2320.044921875, 3873.7338867188, 50.840881347656},
		ROT = {0.0, 0.0, -50.0},
		PED_COORDS = {x = 2326.9506835938, y = 3795.208984375, z = 36.840881347656}
	},
	{
		COORDS = {1494.2039794922, 3901.2141113281, 39.050464630127},
		ROT = {0.0, 0.0, -30.0},
		PED_COORDS = {x = 1546.025390625, y = 3812.3876953125, z = 30.126842498779}
	},
	{
		COORDS = {-1836.6252441406, 4596.2880859375, 30.607460021973},
		ROT = {0.0, 0.0, -110.0},
		PED_COORDS = {x = -1807.9621582031, y = 4503.0913085938, z = 100.60746002197}
	},
	{
		COORDS = {3921.3442382813, 4393.05859375, 21.41202545166},
		ROT = {0.0, 0.0, -110.0},
		PED_COORDS = {x = 4064.6037597656, y = 4486.98046875, z = 5.9689440727234}
	},
	{
		COORDS = {3947.9865722656, 4376.9643554688, 10.30509185791},
		ROT = {-50.0, 0.0, -110.0},
		PED_COORDS = {x = 4115.4370117188, y = 4472.8271484375, z = 9.0813055038452}
	},
	{
		COORDS = {3947.9865722656, 4376.9643554688, 10.30509185791},
		ROT = {0.0, 0.0, -45.0}, -- pitch, roll, yaw
		PED_COORDS = {x = 4115.4370117188, y = 4472.8271484375, z = 9.0813055038452}
	},
	{
		COORDS = {3947.9865722656, 4376.9643554688, 10.30509185791},
		ROT = {-40.0, 0.0, -70.0}, -- pitch, roll, yaw
		PED_COORDS = {x = 4115.4370117188, y = 4472.8271484375, z = 9.0813055038452}
	},
	{
		COORDS = {-1758.8270263672, 2598.3557128906, 18.951589584351},
		ROT = {0.0, 0.0, 0.0}, -- pitch, roll, yaw (- goes right, + goes left)
		PED_COORDS = {x = -2120.4187011719, y = 2552.1657714844, z = 3.0172595977783}
	},
	{
		COORDS = {104.64833068848, -1006.0614624023, 51.410491943359},
		ROT = {0.0, 0.0, -60.0}, -- pitch, roll, yaw (- goes right, + goes left)
		PED_COORDS = {x = 92.386772155762, y = -969.20666503906, z = 85.287590026855}
	},
	{
		COORDS = {539.73193359375, -577.5732421875, 90.49142456055},
		ROT = {-45.0, 0.0, -10.0}, -- pitch, roll, yaw (- goes right, + goes left)
		PED_COORDS = {x = 530.17596435547, y = -453.39477539063, z = 24.799680709839}
	},
	{
		COORDS = {-239.17681884766, -857.51593017578, 211.49209594727},
		ROT = {0.0, 0.0, 45.0}, -- pitch, roll, yaw (- goes right, + goes left)
		PED_COORDS = {x = -239.0470123291, y = -829.11236572266, z = 125.25695800781}
	},
	{
		COORDS = {-239.17681884766, -825.51593017578, 211.49209594727},
		ROT = {0.0, 0.0, -60.0}, -- pitch, roll, yaw (- goes right, + goes left)
		PED_COORDS = {x = -239.0470123291, y = -829.11236572266, z = 125.25695800781}
	},
	{
		COORDS = {-1178.3681640625, -836.81439208984, 25.273780822754},
		ROT = {-35.0, 0.0, -143.0}, -- pitch, roll, yaw (- goes right, + goes left)
		PED_COORDS = {x = -1244.6948242188, y = -904.13238525391, z = 65.331062316895}
	},
	{
		COORDS = {55.317489624023, -1908.0682373047, 21.507209777832},
		ROT = {0.0, 0.0, 0.0}, -- pitch, roll, yaw (- goes right, + goes left)
		PED_COORDS = {x = 9.9323348999023, y = -1911.8826904297, z = 22.138774871826}
	},
	{
		COORDS = {56.772190093994, -1909.2546386719, 21.606565475464},
		ROT = {0.0, 0.0, -75.0}, -- pitch, roll, yaw (- goes right, + goes left)
		PED_COORDS = {x = 9.9323348999023, y = -1911.8826904297, z = 22.138774871826}
	},
	{
		COORDS = {-14.769966125488, -1405.4432373047, 32.492092132568},
		ROT = {-10.0, 0.0, 90.0}, -- pitch, roll, yaw (- goes right, + goes left)
		PED_COORDS = {x = -2.1343140602112, y = -1394.7618408203, z = 33.996654510498}
	}
	
}

RegisterNetEvent("character:swap--check-distance")
AddEventHandler("character:swap--check-distance", function()
	local mycoords = GetEntityCoords(GetPlayerPed(-1))
	for i = 1, #swap_locations do
		local location = swap_locations[i]
		if GetDistanceBetweenCoords(location.x, location.y, location.z, mycoords) < 8 or exports["usa-properties-og"]:isNearbyPropertyOwner() then
			TriggerEvent("Radio.Set", false, {})
			TriggerEvent("hotkeys:setCurrentSlotPassive", nil)
			TriggerEvent("radio:unsubscribe")
			TriggerServerEvent("character:swapChar")
			SendNUIMessage({
				type = "displayGUI"
			})
		end
	end
end)

RegisterNetEvent("character:open")
AddEventHandler("character:open", function(menu, data)
	menuOpen = true
	toggleMenu(menuOpen, menu, data)
end)

RegisterNetEvent("spawn:loadCustomizations")
AddEventHandler("spawn:loadCustomizations", function(customizations)
	exports["fivem-appearance"]:setPlayerAppearance(customizations)
end)

RegisterNetEvent("character:setCharacter")
AddEventHandler("character:setCharacter", function(appearance, weapons, hp, armor)
	Citizen.CreateThread(function()
		RemoveAllPedWeapons(GetPlayerPed(-1), true) -- remove weapons for the case where a different character is selected after choosing one with weapons initially
		if appearance then
			if appearance.hash then
				local name, model
				model = tonumber(appearance.hash)
				RequestModel(model)
				while not HasModelLoaded(model) do -- Wait for model to load
					Citizen.Wait(100)
				end
				SetPlayerModel(PlayerId(), model)
				SetModelAsNoLongerNeeded(model)
				-- ADD CUSTOMIZATIONS FROM CLOTHING STORE
				for key, value in pairs(appearance["components"]) do
					SetPedComponentVariation(GetPlayerPed(-1), tonumber(key), value, appearance["componentstexture"][key], 2)
				end
				for key, value in pairs(appearance["props"]) do
					SetPedPropIndex(GetPlayerPed(-1), tonumber(key), value, appearance["propstexture"][key], true)
				end
				-- add any barber shop and tattoo customizations if any --
				TriggerServerEvent("spawn:loadCustomizations")
			end
		end
		-- G I V E  W E A P O N S --
		for i =1, #weapons do
			local currentWeaponAmmo = ((weapons[i].magazine and weapons[i].magazine.currentCapacity) or 0)
			TriggerEvent("interaction:equipWeapon", weapons[i], true, currentWeaponAmmo)
		end
		SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
		-- player state checks  --
		TriggerServerEvent("usa_rp:checkJailedStatusOnPlayerJoin")
		TriggerServerEvent('morgue:checkToeTag')
		TriggerServerEvent("high_callback:load", GetPlayerServerId(PlayerId()))
		if IsScreenFadedOut() then
			DoScreenFadeIn(3000)
		end
		-- spawn --
		SpawnCharacter(data)
		-- rules accepted check --
		TriggerServerEvent("info:acceptedRulesCheck")
		-- set HP and armor --
		if hp then
			SetEntityHealth(PlayerPedId(), hp)
		end
		if armor then
			SetPedArmour(PlayerPedId(), armor)
		end
	end)
end)

RegisterNUICallback('new-character-submit', function(data, cb)
	TriggerServerEvent("character:new", data)
	cb('ok')
end)

RegisterNUICallback('select-character', function(data, cb)
	if data.spawn then -- default is set in JS file (currently paleto bay)
		if data.spawn:find("Paleto Bay") then
			spawn_coords_closed_menu = {
				x = -290.17190551758,
				y = 6137.1547851563,
				z = 31.494512557983,
				heading = 130.0
			}
		elseif data.spawn:find("Sandy Shores")  then
			spawn_coords_closed_menu = {
				x = 1501.02,
				y = 3776.2,
				z = 33.5,
				heading = 206.0
			}
		elseif data.spawn:find("Los Santos")  then
			spawn_coords_closed_menu = {
				x = 222.78773498535,
				y = -874.51330566406,
				z = 30.49209022522,
				heading = 335.0
			}
		elseif data.spawn:find("Property") then
			spawn_coords_closed_menu = data.charSavedSpawn
		elseif data.spawn:find("Last Location") then
			spawn_coords_closed_menu = data.charLastLocation
		end
	end
	toggleMenu(false)
	DoScreenFadeIn(3000)
	TriggerServerEvent("character:loadCharacter", data.id) -- loadout the player with the selected character appearance
	TriggerEvent("chat:setCharName", data.name) -- for chat messages
	cb('ok')
end)

RegisterNUICallback('getCharLastLocation', function(data, cb)
	TriggerServerEvent("spawn:getCharLastLocation", data.id)
end)

RegisterNUICallback('delete-character', function(data, cb)
	Citizen.Trace("deleting char with id: " .. data.id)
	TriggerServerEvent("character:delete", data)
	cb('ok')
end)

RegisterNUICallback('disconnect', function(data, cb)
	TriggerServerEvent('character:disconnect')
end)

RegisterNUICallback('list', function(data, cb)
	TriggerServerEvent("character:getCharactersAndOpenMenu", "home")
end)

RegisterNetEvent("character:send-nui-message")
AddEventHandler("character:send-nui-message", function(messageTable)
	SendNUIMessage(messageTable)
end)

AddEventHandler('playerSpawned', function(spawn)
	if not hasAlreadySpawnedOnce then
		hasAlreadySpawnedOnce = true
		-- display on spawn to prevent showing GUI before load screen finishes --
		TriggerServerEvent("character:getCharactersAndOpenMenu", "home")
	end
end)

function toggleMenu(status, menu, characters)
	local ped = GetPlayerPed(-1)
	if status then -- open
		TriggerEvent('usa:toggleHUD', false)
		SetDrawOrigin(0.0, 0.0, 0.0, 0)
		SetEntityCoords(ped, 751.31121826172, 6454.3813476563, 31.926473617554, 0.0, 0, 0, 1)
		FreezeEntityPosition(ped, true)
		SetEnableHandcuffs(ped, true)
		RemoveAllPedWeapons(ped, true)
		TriggerEvent("es:setMoneyDisplay", 0)
		MakeCamera()
	end
	SetNuiFocus(status, status)
	menuOpen = status
	SendNUIMessage({
		type = "toggleMenu",
		open = status,
		menu = menu,
		characters = characters
	})
end

function ClearScreen()
  SetCloudHatOpacity(0.01)
  HideHudAndRadarThisFrame()
  SetDrawOrigin(0.0, 0.0, 0.0, 0) -- nice hack to 'hide' HUD elements from other resources/scripts. kinda buggy though.
end

function SpawnCharacter()
	local ped = PlayerPedId()
	DoScreenFadeOut(1000)
	Wait(1000)
	RenderScriptCams(false, false, camera, 1, 0)
	DestroyCam(camera, false)
	if not IsPlayerSwitchInProgress() then
		SwitchOutPlayer(ped, 0, 1)
	end
	if spawn_coords_closed_menu then
		RequestCollisionAtCoord(spawn_coords_closed_menu.x, spawn_coords_closed_menu.y, spawn_coords_closed_menu.z)
		SetEntityCoords(ped, spawn_coords_closed_menu.x, spawn_coords_closed_menu.y, spawn_coords_closed_menu.z, 0.0, 0, 0, 1)
		if spawn_coords_closed_menu.heading then
			SetEntityHeading(ped, spawn_coords_closed_menu.heading)
		end
	end
	FreezeEntityPosition(ped, true)
	while not HasCollisionLoadedAroundEntity(ped) do
		Wait(100)
	end
	FreezeEntityPosition(ped, false)
	while GetPlayerSwitchState() ~= 5 do
		Wait(0)
		ClearScreen()
	end
	DoScreenFadeIn(500)
	while not IsScreenFadedIn() do
		Wait(0)
		ClearScreen()
	end
	WaitForSwitchToComplete(GetPlayerPed(-1))
	ClearDrawOrigin()
	-- welcome info --
	TriggerEvent('usa:toggleHUD', true)
	TriggerEvent("chatMessage", "", { 0, 0, 0 }, "^0Welcome to ^1U^0S^5A ^3REALISM RP^0!")
	TriggerEvent("chatMessage", "", { 0, 0, 0 }, "^0Type ^3'/info' ^0for more help and information!")
	TriggerEvent("chatMessage", "", { 0, 0, 0 }, "^0Press ^3M^0 to open the interaction menu.")
	TriggerEvent("chatMessage", "", { 0, 0, 0 }, "^0Hold ^3TAB^0 to interact with things around you.")
end

function MakeCamera()
	camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	local randomCam = CAMERA_LOCATIONS[math.random(#CAMERA_LOCATIONS)]
	while_menu_open_location = randomCam.PED_COORDS
	SetCamCoord(camera, table.unpack(randomCam.COORDS))
	SetCamRot(camera, randomCam.ROT[1], randomCam.ROT[2], randomCam.ROT[3], 2)
	RenderScriptCams(true, false, 0, 1, 0)
end

function WaitForSwitchToComplete(ped)
	while true do
		ClearScreen()
		Wait(0)
		-- Switch to the player.
		SwitchInPlayer(ped)
		ClearScreen()
		-- Wait for the player switch to be completed (state 12).
		while GetPlayerSwitchState() ~= 12 do
			Wait(0)
			ClearScreen()
		end
		-- Stop the infinite loop.
		break
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if menuOpen then
			SetEntityCoords(GetPlayerPed(-1), while_menu_open_location.x, while_menu_open_location.y, while_menu_open_location.z, (while_menu_open_location.angle or 0.0), 0, 0, 1)
		end
	end
end)
