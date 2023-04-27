isRobbingStore = false

RegisterNetEvent('business:robStore')
AddEventHandler('business:robStore', function(storeName)
	local x, y, z = table.unpack(BUSINESSES[storeName].position)
	local playerPed = PlayerPedId()
	local beginTime = GetGameTimer()
	isRobbingStore = true
  Citizen.CreateThread(function()
    local randomizedRobDuration = BASE_ROB_DURATION + math.random(10000, 50000) -- base duration + (10 or 50 seconds)
		while GetGameTimer() - beginTime < randomizedRobDuration and isRobbingStore do
			Citizen.Wait(0)
			local playerCoords = GetEntityCoords(playerPed)
			if #(vector3(x, y, z) - playerCoords) > 10 then
				TriggerEvent('usa:notify', 'You have left the store before receiving money, robbery has been ~y~cancelled~s~!')
				TriggerServerEvent('business:cancelRobbery', storeName)
				isRobbingStore = false
			end
			DrawTimer(beginTime, randomizedRobDuration, 1.42, 1.475, 'ROBBING')
		end
		if isRobbingStore then
			isRobbingStore = false
			TriggerServerEvent('business:finishRobbery', storeName)
		end
	end)
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