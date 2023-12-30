--# by: minipunch
-- for USA REALISM RP
-- This script adds a realistic food and water requirement for players to stay alive while playing. Also tacked on in game time due to not wanting to create a separate script for it ;o

-----------------------
-- SETTINGS / PERSON --
-----------------------
local settings = {
	hud = {
		["hunger"] = {text = "Full", x = 0.698, y = 1.62, r = 9, g = 179, b = 9, a = 255},
		["thirst"] = {text = "Thirsty", x = 0.698, y = 1.645, r = 255, g = 128, b = 0, a = 255},
		-- ["clock"] = {text = "0:00", x = 0.75, y = 1.645, r = 255, g = 255, b = 255, a = 255}
		["clock"] = {text = "0:00", x = 0.698, y = 1.595, r = 224, g = 227, b = 218, a = 255}
	},
	thirst_global_mult = 0.000115,
	hunger_global_mult = 0.000085,
	walking_mult = 0.000090,
	running_mult = 0.000095,
	sprinting_mult = 0.000145,
	biking_mult = 0.00025,
	--sound_params = {-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 0},
	sound_params = {-1, "FocusIn", "HintCamSounds", 1},
	debug = false
}

local person = {
	hunger_level = 100.0,
	thirst_level = 100.0
}
local showText = true

local HUD_ENABLED = false

---------------
-- API FUNCS --
---------------

function RemoveRagdoll()
	SetPedToRagdoll(myPed, 0, 0, 0, true, true, false)
end

RegisterNetEvent("hungerAndThirst:replenish")
AddEventHandler("hungerAndThirst:replenish", function(type, item)
	if type == "hunger" then
		-- revive if passed out --
		if person.hunger_level <= 10.0 then
			RemoveRagdoll()
		end
		local animation = {
			dict = "amb@code_human_wander_eating_donut@male@idle_a",
			name = "idle_c",
			duration = 18
		}
		local new_hunger_level = person.hunger_level + item.substance
		-- adjust level, notify and remove item
		if new_hunger_level <= 100.0 then
			person.hunger_level = new_hunger_level
			TriggerEvent("usa:notify", "Consumed: ~y~" .. item.name)
		else
			local diff = new_hunger_level - 100.0
			--print("went over by: " .. diff)
			person.hunger_level = 100.0
			TriggerEvent("usa:notify", "You are now totally full!")
		end
		--print("playing food animation!")
		-- play animation:
		--TriggerEvent("usa:playAnimation", animation.name, animation.dict, animation.duration)
		--TriggerEvent("usa:playAnimation", animation.dict, animation.name, 5, 1, animation.duration * 1000, 31, 0, 0, 0, 0)
		TriggerEvent("usa:playAnimation", animation.dict, animation.name, -8, 1, -1, 53, 0, 0, 0, 0,  animation.duration)
	elseif type == "drink" then
		-- revive if passed out --
		if person.thirst_level <= 10.0 then
			RemoveRagdoll()
		end
		local animation = {
			dict = "amb@code_human_wander_drinking_fat@male@idle_a",
			name = "idle_c",
			duration = 12
		}
		local new_thirst_level = person.thirst_level + item.substance
		-- adjust level, notify and remove item
		if new_thirst_level <= 100.0 then
			person.thirst_level = new_thirst_level
			TriggerEvent("usa:notify", "Consumed: ~y~" .. item.name)
		else
			local diff = new_thirst_level - 100.0
			--print("went over by: " .. diff)
			person.thirst_level = 100.0
			TriggerEvent("usa:notify", "You are now totally hydrated!")
		end
		--print("playing drink animation!")
		-- play animation:
		--TriggerEvent("usa:playAnimation", animation.name, animation.dict, animation.duration)
		--TriggerEvent("usa:playAnimation", animation.dict, animation.name, 5, 1, animation.duration * 1000, 31, 0, 0, 0, 0)
		TriggerEvent("usa:playAnimation", animation.dict, animation.name, -8, 1, -1, 53, 0, 0, 0, 0,  animation.duration)
	else
		print("error: no item type specified!")
	end
	TriggerEvent("hud:client:UpdateNeeds", person.hunger_level, person.thirst_level)
end)

AddEventHandler('usa:toggleImmersion', function(toggleOn)
	showText = toggleOn
end)

RegisterNetEvent("foodwater:save")
AddEventHandler("foodwater:save", function()
	TriggerServerEvent("foodwater:save", person)
end)

RegisterNetEvent("foodwater:loaded")
AddEventHandler("foodwater:loaded", function(h, t)
	person.hunger_level = h
	person.thirst_level = t
end)

---------------
-- MAIN LOOP --
---------------
Citizen.CreateThread(function()
	local notified = false

	while true do
		Wait(1)
		local myPed = GetPlayerPed(-1)
		--------------------
		-- debug messages --
		--------------------
		if settings.debug and not IsPedRagdoll(myPed) then
			print("thirst_level: " .. person.thirst_level)
			print("hunger_level: " .. person.hunger_level)
		end
		-------------------------------------
		-- draw hunger & thirst indicators --
		-------------------------------------
		if showText and HUD_ENABLED then
			drawHud(person)
		end
		-----------------------------------------------------------------------
		-- Tick down hunger & thirst levels until death (if not replenished) --
		-----------------------------------------------------------------------
		if not IsPedRagdoll(myPed) then
			if person.thirst_level > 0.0 and person.hunger_level > 0.0 then
				if IsPedWalking(myPed) then
					if settings.debug then print("walking!") end
					person.thirst_level = person.thirst_level - (settings.thirst_global_mult + settings.walking_mult)
					person.hunger_level = person.hunger_level - (settings.hunger_global_mult + settings.walking_mult)
				elseif IsPedRunning(myPed) then
					if settings.debug then print("running!") end
					person.thirst_level = person.thirst_level - (settings.thirst_global_mult + settings.running_mult)
					person.hunger_level = person.hunger_level - (settings.hunger_global_mult + settings.running_mult)
				elseif IsPedSprinting(myPed) then
					if settings.debug then print("sprinting!") end
					person.thirst_level = person.thirst_level - (settings.thirst_global_mult + settings.sprinting_mult)
					person.hunger_level = person.hunger_level - (settings.hunger_global_mult + settings.sprinting_mult)
				elseif GetVehicleClass(GetVehiclePedIsIn(myPed, false)) == 13 then -- bicycles
					if settings.debug then print("bicycling!") end
					person.thirst_level = person.thirst_level - (settings.thirst_global_mult + settings.biking_mult)
					person.hunger_level = person.hunger_level - (settings.hunger_global_mult + settings.biking_mult)
				else
					if settings.debug then print("still!") end
					person.thirst_level = person.thirst_level - settings.thirst_global_mult
					person.hunger_level = person.hunger_level - settings.hunger_global_mult
				end
				-------------------------------------------------------------
				-- send notification when close to dying / LOWER PLAYER HP --
				-------------------------------------------------------------
				if not notified then
					if person.thirst_level < 10.0 then
						TriggerEvent("usa:notify", "~y~You are going to pass out from thirst soon!")
						PlaySoundFrontend(table.unpack(settings.sound_params))
						notified = true
					elseif person.hunger_level < 10.0 then
						TriggerEvent("usa:notify", "~y~You are going to pass out from hunger soon!")
						PlaySoundFrontend(table.unpack(settings.sound_params))
						notified = true
					else
						notified = false
					end
				end
			else
				local cause = "Undefined"
				if person.hunger_level <= 0.0 then cause = "Hunger" end
				if person.thirst_level <= 0.0 then cause = "Thirst" end
				if settings.debug then
					print("person died from hunger or thirst!")
					print("Hunger Level: " .. person.hunger_level)
					print("Thirst Level: " .. person.thirst_level)
					print("ragdolling...")
					print("cause: " .. cause)
				end
				--SetEntityHealth(myPed, 0.0)
				TriggerEvent("usa:notify", "You have passed out from: ~y~" .. cause, "^3INFO: ^0You have passed out from " .. cause .. ". Eat, drink, call for help, or respawn in a few minutes when prompted.")
				local time_until_death = 140000
				local passed_out_time = GetGameTimer()
				while person.hunger_level <= 0.0 or person.thirst_level <= 0.0 do
					Wait(10)
					SetPedToRagdoll(myPed, 5500, 5500, 0, true, true, false)
					if GetGameTimer() - passed_out_time >= time_until_death then
						SetEntityHealth(myPed, 0.0)
						person.hunger_level = 100.0
						person.thirst_level = 100.0
					end
				end
			end
		else
			if settings.debug then
				print("person is passed out!")
			end
		end
	end
end)

-------------------
-- HUD FUNCTIONS --
-------------------
function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
	SetTextFont(6)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end

---------------------------------
-- HUNGER & THIRST HUD DISPLAY --
---------------------------------
function drawHud(person)
	------------
	-- Hunger Settings --
	------------
	if person.hunger_level < 100.0 and person.hunger_level >= 60.0 then
		settings.hud["hunger"].text = "Full"
		-- make green
		settings.hud["hunger"].r = 0
		settings.hud["hunger"].g = 179
		settings.hud["hunger"].b = 0
	elseif person.hunger_level < 60.0 and person.hunger_level >= 30.0 then
		settings.hud["hunger"].text = "Hungry"
		-- make orange
		settings.hud["hunger"].r = 255
		settings.hud["hunger"].g = 128
		settings.hud["hunger"].b = 0
	elseif person.hunger_level < 30.0 then
		-- make red
		settings.hud["hunger"].text = "Starving"
		settings.hud["hunger"].r = 255
		settings.hud["hunger"].g = 0
		settings.hud["hunger"].b = 0
	end
	------------
	-- Thirst Settings --
	------------
	if person.thirst_level < 100.0 and person.thirst_level >= 50.0 then
		settings.hud["thirst"].text = "Hydrated"
		-- make green
		settings.hud["thirst"].r = 9
		settings.hud["thirst"].g = 179
		settings.hud["thirst"].b = 0
	elseif person.thirst_level < 50.0 and person.thirst_level > 25.0 then
		settings.hud["thirst"].text = "Thirsty"
		-- make orange
		settings.hud["thirst"].r = 255
		settings.hud["thirst"].g = 128
		settings.hud["thirst"].b = 0
	elseif person.thirst_level < 25.0 then
		settings.hud["thirst"].text = "Parched"
		-- make red
		settings.hud["thirst"].r = 255
		settings.hud["thirst"].g = 0
		settings.hud["thirst"].b = 0
	end

	-- Background
	DrawRect(0.08555, 0.992, 0.14, 0.0149999999999998, 0, 0, 0, 140)

	-- Left Hunger
	Hunger = (person.hunger_level / 100) * 0.069
	DrawRect(0.0155 + (Hunger / 2), 0.991, Hunger, 0.00833, 221, 173, 122, 230)
	DrawRect(0.0504, 0.991, 0.07, 0.00833, 221, 173, 122, 130)

	-- Right Thirst
	Thirst = (person.thirst_level / 100) * 0.0685
	DrawRect(0.087 + (Thirst / 2), 0.991, Thirst, 0.00833, 188, 152, 206, 230)
	DrawRect(0.1214, 0.991, 0.069, 0.00833, 188, 152, 206, 130)
end

-- publish change event every so often for HUDs and other scripts to subscribe to --
Citizen.CreateThread(function()
	local lastPublish = GetGameTimer()
	while true do
		if GetGameTimer() - lastPublish >= 10 * 1000 then
			lastPublish = GetGameTimer()
			TriggerEvent("hud:client:UpdateNeeds", person.hunger_level, person.thirst_level)
		end
		Wait(1)
	end
end)