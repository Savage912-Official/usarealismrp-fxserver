local fov_max = 80.0
local fov_min = 10.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 2.0 -- camera zoom speed
local speed_lr = 3.0 -- speed by which the camera pans left-right 
local speed_ud = 3.0 -- speed by which the camera pans up-down
local toggle_helicam = 51 -- control id of the button by which to toggle the helicam mode. Default: INPUT_CONTEXT (E)
local toggle_vision = 25 -- control id to toggle vision mode. Default: INPUT_AIM (Right mouse btn)
local toggle_spotlight = 183 -- control id to toggle the front spotlight Default: INPUT_PhoneCameraGrid (G)
local toggle_lock_on = 22 -- control id to lock onto a vehicle with the camera. Default is INPUT_SPRINT (spacebar)
local count,hover,help,super = 0,0,0,0

function MessaggioAiuto(msg, thisFrame, beep, duration)
	AddTextEntry('KernelNotify', msg)
	if thisFrame then
		DisplayHelpTextThisFrame('KernelNotify', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('KernelNotify')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

CreateThread(function()
	local heli = GetVehiclePedIsIn(PlayerPedId())
	while true do
		Wait(5)
		if CheckVeicoloPlayer() and not CheckAltezzaElicottero(heli) then
			TriggerEvent('usa:showHelp', true, 'Press ~INPUT_CELLPHONE_CAMERA_FOCUS_LOCK~ For Help!')
		end
	end
end)

Citizen.CreateThread(function()
	RegisterKeyMapping('AttivaCam', Kernel.Translations[Kernel.Lenguage]["active_heli_cam"], 'keyboard', Kernel.ActiveCamKey)
	RegisterKeyMapping('CalatiFune', Kernel.Translations[Kernel.Lenguage]["rappel"], 'keyboard', Kernel.RappelKey)
	RegisterKeyMapping('AccendiFaro', Kernel.Translations[Kernel.Lenguage]["lights"], 'keyboard', Kernel.LightsKey)
	RegisterKeyMapping('Hover', Kernel.Translations[Kernel.Lenguage]["hover"], 'keyboard', Kernel.HoverKey)
	RegisterKeyMapping('SuperHover', Kernel.Translations[Kernel.Lenguage]["super"], 'keyboard', Kernel.SuperHoverKey)
	RegisterKeyMapping('Help', Kernel.Translations[Kernel.Lenguage]["help"], 'keyboard', Kernel.HelpKey)
end)
local Ca,Ci,Ho,So = "~r~Inactive","~r~Inactive","~r~Inactive","~r~Inactive"

RegisterCommand("Help",function()
	if CheckVeicoloPlayer() then
		if help == 1 then
			help = 0
		elseif help == 0 then
			help = 1
			while help do
				Citizen.Wait(5)
				if count == 1 then Ca = "~g~Active" else Ca = "~r~Inactive" end if hover == 1 then Ho = "~g~Active" else Ho = "~r~Inactive" end if super == 1 then So = "~g~Active" else So = "~r~Inactive" end 
				MessaggioAiuto(Kernel.Translations[Kernel.Lenguage]["cam"] .. Ca .."\n~w~".. Kernel.Translations[Kernel.Lenguage]["hovering_help"].. Ho.."\n~w~".. Kernel.Translations[Kernel.Lenguage]["superhovering_help"] .. So,false, true, 8000)
				if Kernel.ViewCommandsHelp then
					AddTextEntry('HelpText', Kernel.Translations[Kernel.Lenguage]["help_text"])
    	        	SetFloatingHelpTextWorldPosition(1, GetEntityCoords(PlayerPedId()).x + -7,GetEntityCoords(PlayerPedId()).y+5,GetEntityCoords(PlayerPedId()).z)
    	        	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    	        	BeginTextCommandDisplayHelp('HelpText')
    	        	EndTextCommandDisplayHelp(2, false, false, -1)
				end
				if help == 0 then
					break 
				end
			end
		end
	end
end)

RegisterCommand("SuperHover",function()
	if CheckVeicoloPlayer() then
		if super == 1 then
			super = 0
			MessaggioAiuto(Kernel.Translations[Kernel.Lenguage]["hover_off"], false, true, 8000)
		elseif super == 0 then
			super = 1
			Citizen.CreateThread(function()
				MessaggioAiuto(Kernel.Translations[Kernel.Lenguage]["hover_on"], false, true, 8000)
				local vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
				while super and GetHeliMainRotorHealth(vehicle) > 0 and GetHeliTailRotorHealth(vehicle) > 0 and GetVehicleEngineHealth(vehicle,true) > 300 do Citizen.Wait(0)
					local currentvelocity = GetEntityVelocity(vehicle)
					SetEntityVelocity(vehicle, 0.0, 0.0, 0.0)
					SetPlaneTurbulenceMultiplier(vehicle,0.0)
					if super == 0 then
						SetEntityVelocity(vehicle, currentvelocity.x, currentvelocity.y, currentvelocity.z)
						break
					end
				end
				MessaggioAiuto(Kernel.Translations[Kernel.Lenguage]["hover_off"], false, true, 8000)
			end)
			MessaggioAiuto(Kernel.Translations[Kernel.Lenguage]["hover_off"], false, true, 8000)
		end

	end
end)

RegisterCommand("Hover",function()
	if CheckVeicoloPlayer() then
		if hover == 1 then
			hover = 0
			MessaggioAiuto(Kernel.Translations[Kernel.Lenguage]["hover_off"], false, true, 8000)
		elseif hover == 0 then
			hover = 1
			Citizen.CreateThread(function()
				MessaggioAiuto(Kernel.Translations[Kernel.Lenguage]["hover_on"], false, true, 8000)
				local vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
				while hover and GetHeliMainRotorHealth(vehicle) > 0 and GetHeliTailRotorHealth(vehicle) > 0 and GetVehicleEngineHealth(vehicle,true) > 300 do Citizen.Wait(0)
					local currentvelocity = GetEntityVelocity(vehicle)
					SetEntityVelocity(vehicle, currentvelocity.x, currentvelocity.y, 0.0)
					SetPlaneTurbulenceMultiplier(vehicle,0.0)
					if hover == 0 then
						SetEntityVelocity(vehicle, currentvelocity.x, currentvelocity.y, currentvelocity.z)
						break
					end
				end
				MessaggioAiuto(Kernel.Translations[Kernel.Lenguage]["hover_off"], false, true, 8000)
			end)
			MessaggioAiuto(Kernel.Translations[Kernel.Lenguage]["hover_off"], false, true, 8000)
		end

	end
end)

Citizen.CreateThread(function()
	RegisterKeyMapping('AttivaCam', Kernel.Translations[Kernel.Lenguage]["active_heli_cam"], 'keyboard', Kernel.ActiveCamKey)
	RegisterKeyMapping('CalatiFune', Kernel.Translations[Kernel.Lenguage]["rappel"], 'keyboard', Kernel.RappelKey)
	RegisterKeyMapping('AccendiFaro', Kernel.Translations[Kernel.Lenguage]["lights"], 'keyboard', Kernel.LightsKey)
	RegisterKeyMapping('Hover', Kernel.Translations[Kernel.Lenguage]["hover"], 'keyboard', Kernel.HoverKey)
end)


RegisterCommand("AccendiFaro",function()
	if CheckVeicoloPlayer() then
		if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
			spotlight_state = not spotlight_state
			TriggerServerEvent("Elicottero:Accendiluce", spotlight_state)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
		end
	end
end)

RegisterCommand("CalatiFune",function()
	if CheckVeicoloPlayer() then
		Notifications(Kernel.Translations[Kernel.Lenguage]["prepare_rope"])
		if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), 1) == PlayerPedId() or GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), 2) == PlayerPedId() then
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
			TaskRappelFromHeli(PlayerPedId(), 1)
		else
			Notifications(Kernel.Translations[Kernel.Lenguage]["not_possible"])
			PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false) 
		end
	end
end)

RegisterCommand("AttivaCam",function()
	if CheckVeicoloPlayer() and CheckAltezzaElicottero(GetVehiclePedIsIn(PlayerPedId())) then
		if count == 0 then
			count = 1
			AttivaCam()
		elseif count == 1 then
			helicam = false
			count = 0
			AttivaCam()
		end
	end
end)

-- Script starts here
local helicam = false
local fov = (fov_max+fov_min)*0.5
local vision_state = 0 -- 0 is normal, 1 is nightmode, 2 is thermal vision
function AttivaCam()
	while true do
		if count == 1 and CheckVeicoloPlayer() then
        	Citizen.Wait(5)
			if CheckVeicoloPlayer() then
			local lPed = PlayerPedId()
			local heli = GetVehiclePedIsIn(lPed)
			if CheckAltezzaElicottero(heli) then
				--if IsControlJustPressed(0, toggle_helicam) then -- Toggle Helicam
					PlaySoundFrontend(-1, "SELECT", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false)
					helicam = true
				--end			
				
			end
			if IsControlJustPressed(0, toggle_spotlight)  and GetPedInVehicleSeat(heli, -1) == lPed then
				spotlight_state = not spotlight_state
				TriggerServerEvent("heli:spotlight", spotlight_state)
				PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
			end
			
			end
			if helicam then
			SetTimecycleModifier("heliGunCam")
			SetTimecycleModifierStrength(0.3)
			local scaleform = RequestScaleformMovie("HELI_CAM")
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(0)
			end
			local lPed = PlayerPedId()
			local heli = GetVehiclePedIsIn(lPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
			AttachCamToEntity(cam, heli, 0.0,0.0,-1.5, true)
			SetCamRot(cam, 0.0,0.0,GetEntityHeading(heli))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(1) -- 0 for nothing, 1 for LSPD logo
			PopScaleformMovieFunctionVoid()
			local locked_on_vehicle = nil
			while helicam and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == heli) and CheckAltezzaElicottero(heli) do
				if IsControlJustPressed(0, toggle_helicam) then -- Toggle Helicam
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					helicam = false
				end
				if Kernel.UseVision then
					if IsControlJustPressed(0, toggle_vision) then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						ChangeVision()
					end
				end
				if locked_on_vehicle then
					if DoesEntityExist(locked_on_vehicle) then
						PointCamAtEntity(cam, locked_on_vehicle, 0.0, 0.0, 0.0, true)
						RenderVehicleInfo(locked_on_vehicle)
						if IsControlJustPressed(0, toggle_lock_on) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							locked_on_vehicle = nil
							local rot = GetCamRot(cam, 2) -- All this because I can't seem to get the camera unlocked from the entity
							local fov = GetCamFov(cam)
							local old cam = cam
							DestroyCam(old_cam, false)
							cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
							AttachCamToEntity(cam, heli, 0.0,0.0,-1.5, true)
							SetCamRot(cam, rot, 2)
							SetCamFov(cam, fov)
							RenderScriptCams(true, false, 0, 1, 0)
						end
					else
						locked_on_vehicle = nil -- Cam will auto unlock when entity doesn't exist anyway
					end
				else
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam, zoomvalue)
					local vehicle_detected = GetVehicleInView(cam)
					if DoesEntityExist(vehicle_detected) then
						RenderVehicleInfo(vehicle_detected)
						if IsControlJustPressed(0, toggle_lock_on) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							locked_on_vehicle = vehicle_detected
						end
					end
				end
				HandleZoom(cam)
				HideHUDThisFrame()
				PushScaleformMovieFunction(scaleform, "SET_ALT_FOV_HEADING")
				PushScaleformMovieFunctionParameterFloat(GetEntityCoords(heli).z)
				PushScaleformMovieFunctionParameterFloat(zoomvalue)
				PushScaleformMovieFunctionParameterFloat(GetCamRot(cam, 2).z)
				PopScaleformMovieFunctionVoid()
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(0)
			end
			helicam = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5 -- reset to starting zoom level
			RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
			SetScaleformMovieAsNoLongerNeeded(scaleform) -- Cleanly release the scaleform
			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
			else
				Citizen.Wait(500)
				break
			end
		else
			break
		end
	end
end

RegisterNetEvent('Ritorno:AccendiLuci')
AddEventHandler('Ritorno:AccendiLuci', function(serverID, state)
	local heli = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(serverID)), false)
	SetVehicleSearchlight(heli, state, false)
end)

function CheckVeicoloPlayer()
	local lPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(lPed)    
		for i=1,#Kernel.Vehicles do
			if IsVehicleModel(vehicle, Kernel.Vehicles[i]) then
				 return true
			end
	end
	return false
end

function CheckAltezzaElicottero(heli)
	return GetEntityHeightAboveGround(heli) > 5
end

function ChangeVision()
	if vision_state == 0 then
		SetNightvision(true)
		vision_state = 1
	elseif vision_state == 1 then
		SetNightvision(false)
		SetSeethrough(true)
		vision_state = 2
	else
		SetSeethrough(false)
		vision_state = 0
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(19) -- weapon wheel
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) then -- Scrollup
		fov = math.max(fov - zoomspeed, fov_min)
	end
	if IsControlJustPressed(0,242) then
		fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
		fov = current_fov
	end
	SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
end

function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	--DrawLine(coords, coords+(forward_vector*100.0), 255,0,0,255) -- debug line to show LOS of cam
	local rayhandle = CastRayPointToPoint(coords, coords+(forward_vector*200.0), 10, GetVehiclePedIsIn(PlayerPedId()), 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function RenderVehicleInfo(vehicle)
	local model = GetEntityModel(vehicle)
	local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
	local licenseplate = GetVehicleNumberPlateText(vehicle)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.55)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(Kernel.Translations[Kernel.Lenguage]["plate"]..vehname.."\n"..Kernel.Translations[Kernel.Lenguage]["vehicle"]..licenseplate)
	DrawText(0.60, 0.9)
end

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end