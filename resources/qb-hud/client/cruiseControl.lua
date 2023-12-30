local hud = {
    maxSpeed = false,
    maxSpeedVehicle = nil,
    enabled = true,
}

RegisterNetEvent('hud:client:ToggleCinematic', function()
	hud.enabled = not hud.enabled
end)

CreateThread(function()
	while true do
		Wait(0)
		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if vehicle and GetPedInVehicleSeat(vehicle, -1) == playerPed and GetVehicleClass(vehicle) ~= 13 and GetVehicleClass(vehicle) ~= 21 then
			if hud.maxSpeed and hud.maxSpeedVehicle == vehicle and hud.enabled then
				DrawTxt(0.683, 1.45, 1.0, 1.0, 0.40, "Cruise", 255, 255, 255, 255)
			end
			if IsControlJustPressed(0, 20) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
				if not hud.maxSpeed then
					if (GetEntitySpeed(vehicle) * 2.236936) >= 5 then
						PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						local maxSpeed = GetEntitySpeed(vehicle)
						SetEntityMaxSpeed(vehicle, maxSpeed)
						hud.maxSpeed = math.floor(maxSpeed * 2.236936)
						hud.maxSpeedVehicle = vehicle
					else
						TriggerEvent('usa:notify', 'Must be over ~y~0 mph~s~!')
					end
				else
					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
					local maxSpeed = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
					SetEntityMaxSpeed(vehicle, maxSpeed)
					hud.maxSpeedVehicle = nil
					hud.maxSpeed = false
				end
			end
		end
	end
end)

function DrawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end