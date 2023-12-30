local locked = false
local lastScan = { plate = "N/A", speed = 0.00, vehicle = nil }
local showText = true

local drawTextX = 0.515
local drawTextY = 1.220

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local ped = PlayerPedId()
		local car = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		if IsControlPressed(1, 36) and IsControlJustPressed(0, 182, true) and GetVehicleClass(car) == 18 and GetLastInputMethod(0)  then
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			locked = not locked
		end
		if not IsVehicleBlacklisted(car) and (GetPedInVehicleSeat(car, -1) == ped or GetPedInVehicleSeat(car, 0) == ped) and showText then
			if locked then
				DrawTxt(drawTextX, drawTextY, 1.0, 1.0, 0.40, '~r~[LOCKED] ~w~Plate: '..lastScan.plate..' | MPH: '..math.ceil(lastScan.speed), 255, 255, 255, 255)
			else
				DrawTxt(drawTextX, drawTextY, 1.0, 1.0, 0.40, 'Plate: '..lastScan.plate..' | MPH: '..math.ceil(lastScan.speed), 255, 255, 255, 255)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		local car = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		if DoesEntityExist(car) and not locked and GetVehicleClass(car) == 18 then
			lastScan.vehicle = GetCurrentTargetCar()
			local tempPlate = GetVehicleNumberPlateText(lastScan.vehicle)
			tempPlate = exports.globals:trim(tempPlate)
			if lastScan.vehicle and tempPlate then
				if lastScan.plate ~= tempPlate then
					TriggerServerEvent('mdt:checkFlags', tempPlate, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(lastScan.vehicle))))
				end
				lastScan.plate = tempPlate
				lastScan.speed = GetEntitySpeed(lastScan.vehicle) * 2.236936
			end
		end
	end
end)

AddEventHandler('hud:client:LoadMap', function(mapType)
	if mapType == "square" then
		drawTextY = 1.22
	else
		drawTextY = 1.17
	end
end)

RegisterNetEvent('speedcam:lockCam')
AddEventHandler('speedcam:lockCam', function()
	PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
	locked = true
end)

AddEventHandler('usa:toggleImmersion', function(toggleOn)
	showText = toggleOn
end)

function GetCurrentTargetCar()
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)

    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 50.0, 0.0)
    local rayHandle = CastRayPointToPoint(coords.x, coords.y, coords.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
    local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

	-- DrawMarker(4, entityWorld.x, entityWorld.y, entityWorld.z+0.5, 0, 0, 0, 0, 0.0, 0, 1.5, 1.0, 1.25, 255, 255, 255, 200, 0, GetEntityHeading(GetPlayerPed(-1)), 0, 0)

    return vehicleHandle
end

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

function IsVehicleBlacklisted(veh)
	local model = GetEntityModel(veh)
	if GetVehicleClass(veh) ~= 18 then
		return true
	elseif model == GetHashKey("ambulance") then
		return true
	elseif model == GetHashKey("firetruk") then
		return true
	else
		return false
	end
end
