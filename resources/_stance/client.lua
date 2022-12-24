local crouched = false
local proned = false
local standing = true
local crouchKey = 26
local l_alt_key = 19
local w_key = 32
local s_key = 33

Citizen.CreateThread( function()
	while true do
		Citizen.Wait( 1 )
		local ped = GetPlayerPed( -1 )
		if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
			ProneMovement()
			--DisableControlAction( 0, proneKey, true )
			--DisableControlAction( 0, crouchKey, true )
			if ( not IsPauseMenuActive() ) then
				if IsControlPressed(0, l_alt_key) and IsControlJustPressed(0, w_key)  and not IsPedInAnyVehicle(ped, true) then
				--if IsDisabledControlJustPressed(0, crouchKey) and not IsPedInAnyVehicle(ped, true) then
					if standing then
						RequestAnimSet( "move_ped_crouched" )

						while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do
							Citizen.Wait( 100 )
						end

							SetPedMovementClipset( ped, "move_ped_crouched", 0.55 )
							SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
							crouched = true
							standing = false
							
					elseif crouched and not IsPedInAnyVehicle(ped, true) and not IsPedFalling(ped) and not IsPedDiving(ped) and not IsPedInCover(ped, false) and not IsPedInParachuteFreeFall(ped) and (GetPedParachuteState(ped) == 0 or GetPedParachuteState(ped) == -1)  then
						RequestAnimSet( "move_crawl" )
						while ( not HasAnimSetLoaded( "move_crawl" ) ) do
							Citizen.Wait( 100 )
						end
						ClearPedTasksImmediately(ped)
						proned = true
						crouched = false
						if IsPedSprinting(ped) or IsPedRunning(ped) or GetEntitySpeed(ped) > 5 then
							TaskPlayAnim(ped, "move_jump", "dive_start_run", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
							Wait(1000)
						end
						SetProned()
					elseif proned then
						ClearPedTasksImmediately(ped)
						ResetPedMovementClipset(ped)
						ResetPedStrafeClipset(ped)
						TriggerEvent('civ:resetWalkStyle')
						proned = false
						standing = true
					end
				end
			end
		else
			proned = false
			crouched = false
			standing = true
		end
	end
end)

RegisterNetEvent("stance:resetToStand")
AddEventHandler("stance:resetToStand", function()
	if crouched then
		ClearPedTasksImmediately(ped)
		ResetPedMovementClipset(ped)
		ResetPedStrafeClipset(ped)
		TriggerEvent('civ:resetWalkStyle')
		proned = false
		crouched = false
		standing = true
	end
end)

function SetProned()
	ped = PlayerPedId()
	ClearPedTasksImmediately(ped)
	TaskPlayAnim(ped,"move_crawl","onfront_bwd",0.0,0.0,0,0,0.0,false,false,false)
	--TaskPlayAnim(ped, animDictionary, animationName, speed, speedMultiplier, duration, flag, playbackRate, lockX, lockY, lockZ)
end

local poll_delay = 750
local pressed_time = 0
function ProneMovement()
	if proned then
		ped = PlayerPedId()
		if IsControlPressed(0, 34) then 
			SetEntityHeading(ped, GetEntityHeading(ped)+2.0 )
		elseif IsControlPressed(0, 35) then
			SetEntityHeading(ped, GetEntityHeading(ped)-2.0 )
		elseif IsControlPressed(0, 32) and not IsEntityPlayingAnim(ped, "move_crawl", "onfront_fwd", 3) or (GetGameTimer() > pressed_time + poll_delay and IsControlPressed(0, 32)) then
			pressed_time = GetGameTimer()
			TaskPlayAnim(ped,"move_crawl","onfront_fwd",8.0,-4.0,-1, 10,0.0,false,false,false)
		elseif IsControlPressed(0, 33) and not IsEntityPlayingAnim(ped, "move_crawl", "onfront_bwd", 3) or (GetGameTimer() > pressed_time + poll_delay and IsControlPressed(0, 33)) then
			pressed_time = GetGameTimer()
			TaskPlayAnim(ped,"move_crawl","onfront_bwd",8.0,-4.0,-1, 10,0.0,false,false,false)
		end
		
	end
end
