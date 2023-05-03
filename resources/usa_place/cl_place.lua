function _placeIntoVehicleInternal(ped, veh, seatOption)
	if (seatOption == "any" or seatOption == "front") and IsVehicleSeatFree(veh, 0) then
		SetPedIntoVehicle(ped, veh, 0) -- place in front right seat
	elseif seatOption == "any" or seatOption == "back" then
		if IsVehicleSeatFree(veh, 1) then
			SetPedIntoVehicle(ped, veh, 1) -- place in back left seat
		elseif IsVehicleSeatFree(veh, 2) then
			SetPedIntoVehicle(ped, veh, 2) -- place in back right seat
		end
	end
end

RegisterNetEvent("place:place")
AddEventHandler("place:place", function(seatOption, placedByLEO, placerID)
	local me = PlayerPedId()
	local veh = exports.globals:getClosestVehicle(5.0)

	if DoesEntityExist(me) then
		if not IsPedDeadOrDying(me, true) then
			_placeIntoVehicleInternal(me, veh, seatOption)
		elseif IsPedDeadOrDying(me, true) then
			TriggerServerEvent("place:notifyPlacer", placerID, "Can't place yourself while downed!")
		else
			if placedByLEO then
				_placeIntoVehicleInternal(me, veh, seatOption)
			else
				local areHandsTied = exports["usa_rp2"]:areHandsTied()
				if areHandsTied then
					_placeIntoVehicleInternal(me, veh, seatOption)
				else
					TriggerServerEvent("place:notifyPlacer", placerID, "Person not downed and does not have hands up!")
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if IsControlPressed(0, 19) and IsControlJustPressed(0, 74) and not IsPedRagdoll(ped) and not IsEntityDead(ped) and DoesEntityExist(ped) and not IsPedSittingInAnyVehicle(ped) and not IsPedInMeleeCombat(ped) then
			TriggerServerEvent('cuff:checkWhitelistForPlace')
        elseif IsControlPressed(0, 19) and IsControlJustPressed(0, 182) and not IsPedRagdoll(ped) and not IsEntityDead(ped) and DoesEntityExist(ped) and not IsPedSittingInAnyVehicle(ped) and not IsPedInMeleeCombat(ped) then
			TriggerServerEvent('cuff:checkWhitelistForUnseat')
        end
    end
end)

RegisterNetEvent("place:invalidCommand")
AddEventHandler("place:invalidCommand", function(msg)

	TriggerEvent("chatMessage", "SYSTEM",  {255, 180, 0}, msg)

end)

function _unseatPedInternal(targetSource, playerPed)
	local playerCoords = GetEntityCoords(playerPed)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSource))
	local targetCoords = GetEntityCoords(targetPed)
	--local offset = GetOffsetFromEntityInWorldCoords(targetPed, 1.0, 0.0, 0.0)
	TriggerEvent('trunkhide:exitTrunk', true)
	if Vdist(playerCoords, targetCoords) < 5.0 and IsPedInAnyVehicle(playerPed) then
		RequestCollisionAtCoord(targetCoords)
		while not HasCollisionLoadedAroundEntity(playerPed) do
			RequestCollisionAtCoord(targetCoords)
			Wait(10)
		end
		SetEntityCoords(playerPed, targetCoords.x, targetCoords.y, targetCoords.z - 0.9)
	end
end

-- unseat
RegisterNetEvent('place:unseat')
AddEventHandler('place:unseat', function(targetSource, unseatedByLEO)
	local playerPed = PlayerPedId()
	if IsPedDeadOrDying(playerPed, true) then
		_unseatPedInternal(targetSource, playerPed)
	else
		if unseatedByLEO then
			_unseatPedInternal(targetSource, playerPed)
		else
			local areHandsTied = exports["usa_rp2"]:areHandsTied()
			if areHandsTied then
				_unseatPedInternal(targetSource, playerPed)
			else
				TriggerServerEvent("place:notifyPlacer", targetSource, "Person not downed and does not have hands up!")
			end
		end
	end
end)

RegisterNetEvent('place:attemptToPlaceNearest')
AddEventHandler('place:attemptToPlaceNearest', function()
	TriggerEvent("usa:getClosestPlayer", 1.65, function(player)
		if player then
			if tonumber(player.id) ~= 0 and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
				print('player found to place: '..player.id)
				TriggerServerEvent('display:shareDisplay', 'places person in vehicle', 2, 370, 10, 3000, true)
				TriggerServerEvent('place:placePerson', player.id)
			else
				TriggerEvent('usa:notify', "No target found to place!")
			end
		end
	end)
end)

RegisterNetEvent('place:attemptToUnseatNearest')
AddEventHandler('place:attemptToUnseatNearest', function()
	TriggerEvent("usa:getClosestPlayer", 1.65, function(player)
		if player then
			if tonumber(player.id) ~= 0 and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(player.id))) then
				print('player found to unseat: '..player.id)
				TriggerServerEvent('display:shareDisplay', 'removes person from vehicle', 2, 370, 10, 3000, true)
				TriggerServerEvent('place:unseatPerson', player.id)
			else
				TriggerEvent('usa:notify', "No target found to unseat!")
			end
		end
	end)
end)
