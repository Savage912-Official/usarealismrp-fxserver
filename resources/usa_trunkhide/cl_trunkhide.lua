local inTrunk = false
local vehicle = nil

Citizen.CreateThread(function()
  	while true do
	    Citizen.Wait(0)
		if DoesEntityExist(vehicle) and inTrunk then
   			DisableAllControlActions(0)
   			DisableAllControlActions(1)
   			DisableAllControlActions(2)
   			EnableControlAction(0, 0, true) --- V - camera
   			EnableControlAction(0, 249, true) --- N - push to talk
   			EnableControlAction(2, 1, true) --- camera moving
   			EnableControlAction(2, 2, true) --- camera moving
   			EnableControlAction(0, 177, true) --- BACKSPACE
   			EnableControlAction(0, 200, true) --- ESC
   			EnableControlAction(0, 245, true)
   			EnableControlAction(0, 289, true) --- F2 - Change voice from whisper / normal / yell
   			if not IsEntityPlayingAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 3) then
		  		TaskPlayAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)
		  	end
		end
  	end
end)

RegisterNetEvent('trunkhide:hideInNearestTrunk')
AddEventHandler('trunkhide:hideInNearestTrunk', function()
	if not inTrunk then
		local vehicleInFront = VehicleInFront()
		if vehicleInFront and vehicleInFront ~= 0 then
			TriggerEvent('trunkhide:enterTrunk', vehicleInFront)
			exports.globals:notify("Type /hidetrunk to exit", "INFO: Type /hidetrunk to exit the trunk")
		end
	else
		TriggerEvent('trunkhide:exitTrunk')
	end
end)

RegisterNetEvent('trunkhide:enterTrunk')
AddEventHandler('trunkhide:enterTrunk', function(targetVehicle)
	local playerPed = PlayerPedId()
	RequestAnimDict('timetable@floyd@cryingonbed@base')
	while not HasAnimDictLoaded('timetable@floyd@cryingonbed@base') do Citizen.Wait(10) end
	if not inTrunk and GetVehicleDoorLockStatus(targetVehicle) ~= 2 then
		if (GetPedInVehicleSeat(targetVehicle, -1) ~= 0 and IsPedAPlayer(GetPedInVehicleSeat(targetVehicle, -1))) or GetPedInVehicleSeat(targetVehicle, -1) == 0 then
			SetVehicleDoorOpen(targetVehicle, 5, false, false)
	    	AttachEntityToEntity(playerPed, targetVehicle, -1, 0.0, -2.2, 0.35, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
	   		RaiseConvertibleRoof(targetVehicle, false)
	   		if IsEntityAttached(playerPed) then
				ClearPedTasksImmediately(playerPed)
				TaskPlayAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)
	        end
			inTrunk = true
			vehicle = targetVehicle
			Citizen.Wait(2000)
			if GetVehicleClass(vehicle) ~= 9 and GetVehicleClass(vehicle) ~= 0 and GetVehicleClass(vehicle) ~= 10 then
				SendNUIMessage({
					type = "enableui",
					enable = true,
					inTrunk = true
				})
			end
		    SetVehicleDoorShut(targetVehicle, 5, false)
	   	end
	end
end)

RegisterNetEvent('trunkhide:exitTrunk')
AddEventHandler('trunkhide:exitTrunk', function(allowExitWhenTied)
	local playerPed = PlayerPedId()
	local _vehicle = vehicle
	if inTrunk and _vehicle then
        if IsPedCuffed(playerPed) and not allowExitWhenTied then
            TriggerEvent('usa:notify', 'Your hands are tied together!')
            return
        end
		SetVehicleDoorOpen(vehicle, 5, false, false)
		Citizen.Wait(500)
		DetachEntity(playerPed, true, false)
		local offset = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -3.0, 0.0)
		SetEntityCoords(playerPed, offset)
		ClearPedTasks(playerPed)
		SetEntityCollision(vehicle, true, true)
		inTrunk = false
		vehicle = nil
		SendNUIMessage({
			type = "enableui",
			enable = false,
			inTrunk = false
		})
	    SetVehicleDoorShut(_vehicle, 5, false)
	end
end)

function VehicleInFront()
	local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local entityWorld = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 6.0, 0.0)
    local rayHandle = CastRayPointToPoint(playerCoords, entityWorld, 2, playerPed, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

function IsInTrunk()
    return inTrunk
end
