
carWashes = {
	{x = 26.5906, y = -1392.0261, z = 29.3634},
	{x = 167.1034, y = -1719.4704, z = 29.2916},
	{x = -74.5693, y = 6427.8715, z = 31.4400},
	{x = -699.6325, y = -932.7043, z = 19.0139}
}


----------------------
---- Set up blips ----
----------------------
for i = 1, #carWashes do
  local blip = AddBlipForCoord(carWashes[i].x, carWashes[i].y, carWashes[i].z)
  SetBlipSprite(blip, 100)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.8)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Car Wash')
  EndTextCommandSetBlipName(blip)
end
-----------------
-----------------
-----------------


Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerVehicle = GetVehiclePedIsIn(playerPed, false)
		for i = 1, #carWashes do
			DrawText3D(carWashes[i].x, carWashes[i].y, carWashes[i].z, 15, '[E] - Carwash (~g~$50.00~s~)') 
		end
		if IsControlJustPressed(1, 38) and IsPedSittingInAnyVehicle(playerPed) then
			for i = 1, #carWashes do
				if Vdist(GetEntityCoords(playerPed), carWashes[i].x, carWashes[i].y, carWashes[i].z) < 5 then
					if GetIsVehicleEngineRunning(playerVehicle) then
						TriggerEvent('usa:notify', '~y~Vehicle engine must be off!')
					else
						TriggerServerEvent('carwash:checkmoney')
					end	
				end
			end
		end
	end
end)

RegisterNetEvent('carwash:success')
AddEventHandler('carwash:success', function()
	local playerPed = PlayerPedId()
	local playerVeh = GetVehiclePedIsIn(playerPed, false)
	local beginTime = GetGameTimer()
	Citizen.CreateThread(function()
		while GetGameTimer() - beginTime < 5000 do
			Citizen.Wait(0)
			SetVehicleEngineOn(playerVeh, false, true, false)
		end
	end)
	while GetGameTimer() - beginTime < 5000 do
		Citizen.Wait(0)
		DrawTimer(beginTime, 5000, 1.42, 1.475, 'WASHING')
	end
	SetVehicleDirtLevel(playerVeh, 0.0)
end)

function DrawTimer(beginTime, duration, x, y, text)
    if not HasStreamedTextureDictLoaded('timerbars') then
        RequestStreamedTextureDict('timerbars')
        while not HasStreamedTextureDictLoaded('timerbars') do
            Citizen.Wait(0)
        end
    end

    if GetTimeDifference(GetGameTimer(), beginTime) < duration then
        w = (GetTimeDifference(GetGameTimer(), beginTime) * (0.085 / duration))
    end

    local correction = ((1.0 - math.floor(GetSafeZoneSize(), 2)) * 100) * 0.005
    x, y = x - correction, y - correction

    Set_2dLayer(0)
    DrawSprite('timerbars', 'all_black_bg', x, y, 0.15, 0.0325, 0.0, 255, 255, 255, 180)

    Set_2dLayer(1)
    DrawRect(x + 0.0275, y, 0.085, 0.0125, 100, 0, 0, 180)

    Set_2dLayer(2)
    DrawRect(x - 0.015 + (w / 2), y, w, 0.0125, 150, 0, 0, 180)

    SetTextColour(255, 255, 255, 180)
    SetTextFont(0)
    SetTextScale(0.3, 0.3)
    SetTextCentre(true)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    Set_2dLayer(3)
    DrawText(x - 0.06, y - 0.012)
end

function DrawText3D(x, y, z, distance, text)
  if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) < distance then
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 470
    DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
  end
end