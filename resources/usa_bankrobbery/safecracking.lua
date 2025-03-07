animsIdle = {}
animsIdle[1] = "idle_base"
animsIdle[2] = "idle_heavy_breathe"
animsIdle[3] = "idle_look_around"

animsSucceed = {}
animsSucceed[1] = "dial_turn_succeed_1"
animsSucceed[2] = "dial_turn_succeed_2"
animsSucceed[3] = "dial_turn_succeed_3"
animsSucceed[4] = "dial_turn_succeed_4"
cracking = false

RegisterNetEvent("pacific_safecracking:loop")
AddEventHandler("pacific_safecracking:loop", function(safeIndex)

	local isBusy = TriggerServerCallback {
		eventName = "bank:isSafeBusy",
		args = {safeIndex, true}
	}

	if isBusy then
		exports.globals:notify("Safe busy")
		return
	end

	cracking = true
	
	local me = PlayerPedId()

	SetCurrentPedWeapon(me, `WEAPON_UNARMED`, true)
	
	Citizen.Wait(500)

	while 
	(
	IsEntityPlayingAnim(me, "reaction@intimidation@cop@unarmed", "intro", 3) or
	IsEntityPlayingAnim(me, "reaction@intimidation@1h", "outro", 3)
	) 
	do
		Citizen.Wait(100)
	end

	loadSafeTexture()
	loadSafeAudio()
	difficultySetting = {}
	difficulty = 2
	for z = 1, difficulty do
		difficultySetting[z] = 1
	end
	curLock = 1
	factor = difficulty
	i = 0.0
	safelock = 0
	desirednum = math.floor(math.random(99))
	if desirednum == 0 then desirednum = 1 end
	openString = "lock_open"
	closedString = "lock_closed"
	cracking = true
	mybasepos = GetEntityCoords(GetPlayerPed(-1))
	checker = 1
	local pinfall = false
	while cracking do

		DisplayHelpText("Cracking")
		DisableControlAction(38, 0, true)
		DisableControlAction(44, 0, true)
		DisableControlAction(74, 0, true)

		if IsControlPressed(1, 38) then
			if checker > 1 then
				i = i + 1.8
				PlaySoundFrontend( 0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", true );

				checker = 0
				crackingsafeanim(1)
			end
		end

		if IsControlPressed(1, 23) then

			if checker > 1 then
				i = i - 1.8
				PlaySoundFrontend( 0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", true );
				checker = 0
				crackingsafeanim(1)
			end
		end

		checker = checker + 0.2
		Citizen.Wait(1)

		if i < 0.0 then i = 360.0 end
		if i > 360.0 then i = 0.0 end

		safelock = math.floor(100-(i / 3.6))

		if GetDistanceBetweenCoords(mybasepos, GetEntityCoords(GetPlayerPed(-1))) > 1 or curLock > difficulty then
			cracking = false
			safeboxing = false
			ClearPedTasks(me)
			TriggerServerEvent("bank:setSafeBusy", safeIndex, false)
		end

		if IsDisabledControlPressed(1, 74) and safelock ~= desirednum then
			Citizen.Wait(1000)
		end

		if safelock == desirednum then

			if not pinfall then
				PlaySoundFrontend( 0, "TUMBLER_PIN_FALL", "SAFE_CRACK_SOUNDSET", true );
				pinfall = true
			end

			if IsDisabledControlPressed(1, 74) then
				pinfall = false
				PlaySoundFrontend( 0, "TUMBLER_RESET", "SAFE_CRACK_SOUNDSET", true );
				factor = factor / 2
				i = 0.0
				safelock = 0
				desirednum = math.floor(math.random(99))
				crackingsafeanim(3)
				if desirednum == 0 then desirednum = 1 end
				difficultySetting[curLock] = 0
				curLock = curLock + 1
			end

		else
			pinfall = false
		end

		DrawSprite( "MPSafeCracking", "Dial_BG", 0.65, 0.5, 0.18, 0.32, 0, 255, 255, 211, 255 )
		DrawSprite( "MPSafeCracking", "Dial", 0.65, 0.5, 0.09, 0.16, i, 255, 255, 211, 255 )



		addition = 0.45
		xaddition = 0.58
		for x = 1, difficulty do

			if difficultySetting[x] ~= 1 then
				DrawSprite( "MPSafeCracking", openString, xaddition, addition, 0.012, 0.024, 0, 255, 255, 211, 255 )
			else
				DrawSprite( "MPSafeCracking", closedString, xaddition, addition, 0.012, 0.024, 0, 255, 255, 211, 255 )
			end

			addition = addition + 0.05

			if x == 10 or x == 20 or x == 30 then
				addition = 0.25
				xaddition = xaddition + 0.05
			end

		end
	end

	if curLock > difficulty then
		resetAnim()
		takeAnim()
		while securityToken == nil do
			Wait(1)
		end
		TriggerServerEvent("bank:safeLooted", safeIndex, securityToken)
	end
	Citizen.Wait(1000)
	safeboxing = false
	TriggerServerEvent("bank:setSafeBusy", safeIndex, false)
	
end)

function resetAnim()
	 local player = GetPlayerPed( -1 )
	ClearPedSecondaryTask(player)
end

function crackingsafeanim(animType)
    local player = GetPlayerPed( -1 )
  	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
        exports.globals:loadAnimDict( "mini@safe_cracking" )


        if animType == 1 then

			if IsEntityPlayingAnim(player, "mini@safe_cracking", "dial_turn_anti_fast_1", 3) then
			else
				TaskPlayAnim(player, "mini@safe_cracking", "dial_turn_anti_fast_1", 8.0, -8, -1, 49, 0, 0, 0, 0)
			end

	    end

        if animType == 2 then
	        TaskPlayAnim( player, "mini@safe_cracking", animsIdle[math.floor(math.ceil(4))], 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	    end

        if animType == 3 then
	        TaskPlayAnim( player, "mini@safe_cracking", animsSucceed[math.floor(math.ceil(4))], 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	    end

    end
end

function loadSafeTexture()
	RequestStreamedTextureDict( "MPSafeCracking", false );
	while not HasStreamedTextureDictLoaded( "MPSafeCracking" ) do
		Citizen.Wait(0)
	end
end

function loadSafeAudio()
	RequestAmbientAudioBank( "SAFE_CRACK", false )
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function takeAnim() --This function is used to do the take animation when cracking the safe
    local ped = GetPlayerPed(-1)
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Citizen.Wait(100)

    Citizen.CreateThread(function()
        while (IsEntityPlayingAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 3)) do
            DisableAllControlActions(0)
            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(2500)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
    RemoveAnimDict("amb@prop_human_bum_bin@idle_b")
end