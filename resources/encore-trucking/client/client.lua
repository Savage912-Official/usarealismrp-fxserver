local truckId      	        = nil
local jobStatus    		    = CONST_NOTWORKING
local currentRoute          = nil
local currentDestination    = nil
local currentPickup			= nil
local routeBlip             = nil
local trailerId             = nil
local lastDropCoordinates   = nil

--
-- Threads
--

Citizen.CreateThread(function()
	EncoreHelper.CreateBlip(Config.JobStart.Coordinates, 'Trucking', Config.Blip.SpriteID, Config.Blip.ColorID, Config.Blip.Scale)

	while true do
		Citizen.Wait(0)

		local playerId             = PlayerPedId()
		local playerCoordinates    = GetEntityCoords(playerId)
		local distanceFromJobStart = GetDistanceBetweenCoords(playerCoordinates, Config.JobStart.Coordinates, false)
		local sleep                = 1000

		if distanceFromJobStart < Config.Marker.DrawDistance then
			sleep = 0
		
			DrawMarker(Config.Marker.Type, Config.JobStart.Coordinates, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.Size,  Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, 100, false, true, 2, false, nil, nil, false)

			if distanceFromJobStart < Config.Marker.Size.x then

				if truckId and GetVehiclePedIsIn(playerId, false) == truckId and GetPedInVehicleSeat(truckId, -1) == playerId then
					EncoreHelper.ShowAlert('Press ~INPUT_PICKUP~ to return your truck.', true)

					if IsControlJustReleased(0, 38) then
						TriggerServerEvent('encore_trucking:returnTruck')

						abortJob("Truck returned!")

						if truckId and DoesEntityExist(truckId) then
							DeleteVehicle(truckId)
							truckId = nil
						end
					end
				elseif not IsPedInAnyVehicle(playerId, false) then
					if not currentRoute then
						EncoreHelper.ShowAlert('Press ~INPUT_PICKUP~ to retrieve semi truck for $' .. Config.TruckRentalPrice .. '.', true)
						if IsControlJustReleased(0, 38) then
							TriggerServerEvent('encore_trucking:rentTruck')
						end
					else 
						EncoreHelper.ShowAlert('Bring your truck back here when you finish!', true)
					end
				end
			end
		end

		if jobStatus ~= CONST_NOTWORKING then
			sleep = 0

			if jobStatus == CONST_WAITINGFORTASK then
				assignTask()
			elseif jobStatus == CONST_PICKINGUP then
				pickingUpThread(playerId, playerCoordinates)
			elseif jobStatus == CONST_DELIVERING then
				deliveringThread(playerId, playerCoordinates)
			end
		
			-- Abort Hotkey
			--[[
			if IsControlJustReleased(0, Config.AbortKey) then
				abortJob()
			end
			--]]
		end

		if sleep > 0 then
			Citizen.Wait(sleep)
		end
	end
end)

function pickingUpThread(playerId, playerCoordinates)
	if currentRoute then
		if not trailerId and GetDistanceBetweenCoords(playerCoordinates, currentPickup.coords, true) < 175.0 then
			trailerId = EncoreHelper.SpawnVehicle(currentRoute.TrailerModel, currentPickup.coords, currentPickup.heading, currentRoute.TrailerLivery)
			Wait(1000)
		end

		if trailerId and IsEntityAttachedToEntity(trailerId, truckId) then
			RemoveBlip(routeBlip)
			routeBlip = EncoreHelper.CreateRouteBlip(currentDestination)

			EncoreHelper.ShowNotification('Take the delivery to the ~y~drop off point~s~.')

			jobStatus = CONST_DELIVERING
		end

		if trailerId then
			if GetVehicleEngineHealth(trailerId) < 300 or GetVehicleBodyHealth(trailerId) <= 0 or not DoesEntityExist(trailerId) then
				abortJob("Trucking route ended! Return your semi truck!")
			end
		end

		if truckId then
			if GetVehicleEngineHealth(truckId) < 100 or GetVehicleBodyHealth(truckId) < 100 or not DoesEntityExist(truckId) then
				abortJob("Trucking route ended!")
			end
		end
	end
end

function deliveringThread(playerId, playerCoordinates)
	if currentDestination then
		local distanceFromDelivery = GetDistanceBetweenCoords(playerCoordinates, currentDestination, true)

		if distanceFromDelivery < Config.Marker.DrawDistance then
			DrawMarker(Config.Marker.Type, currentDestination, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.Size,  Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, 100, false, true, 2, false, nil, nil, false)	
		
			if distanceFromDelivery < Config.Marker.Size.x then
				EncoreHelper.ShowAlert('Press ~INPUT_PICKUP~ to deliver the load.', true)

				if IsControlJustReleased(0, 38) then
					while securityToken == nil do
						Wait(1)
					end
					TriggerServerEvent('encore_trucking:loadDelivered', securityToken)
					cleanupTask()
				end
			end
		end

		if trailerId and (not DoesEntityExist(trailerId) or not IsEntityAttachedToEntity(trailerId, truckId) or #(GetEntityCoords(trailerId) - GetEntityCoords(truckId)) > 300) then
			Wait(3000) -- wait and try again, Hopeful fix for a job ending bug that has been reported
			if trailerId and (not DoesEntityExist(trailerId) or not IsEntityAttachedToEntity(trailerId, truckId) or #(GetEntityCoords(trailerId) - GetEntityCoords(truckId)) > 300) then
				if DoesEntityExist(trailerId) then
					DeleteVehicle(trailerId)
					trailerId = nil
				end

				RemoveBlip(routeBlip)

				currentRoute        = nil
				currentPickup		= nil
				currentDestination  = nil
				routeBlip			= nil
				lastDropCoordinates = playerCoordinates

				EncoreHelper.ShowNotification('You lost your load. A new route will be assigned.')

				jobStatus = CONST_WAITINGFORTASK
			end
		end

		if truckId then
			if GetVehicleEngineHealth(truckId) < 100 or GetVehicleBodyHealth(truckId) < 100 or not DoesEntityExist(truckId) then
				abortJob("Route ended! Truck is too damaged!")
				print("[trucking] GetVehicleBodyHealth(truckId): " .. GetVehicleBodyHealth(truckId))
				print("[trucking] GetVehicleEngineHealth(truckId): " .. GetVehicleEngineHealth(truckId))
			end
		end
	end
end

--
-- Functions
--

function cleanupTask()
	if DoesEntityExist(trailerId) then
		DeleteVehicle(trailerId)
	end

	RemoveBlip(routeBlip)

	trailerId          = nil
	routeBlip          = nil
	currentDestination = nil
	currentPickup	   = nil
	currentRoute       = nil

	jobStatus = CONST_WAITINGFORTASK
end

function abortJob(msg)
	if routeBlip then
		RemoveBlip(routeBlip)
	end

	routeBlip			= nil
	currentDestination  = nil
	currentPickup		= nil
	currentRoute        = nil
	lastDropCoordinates = nil

	jobStatus = CONST_NOTWORKING

	exports.globals:notify(msg, "^3INFO: ^0" .. msg)
	
	local lastTrailerId = trailerId
	trailerId = nil

	Citizen.CreateThread(function()
		Wait(90000) -- delay deletion of trailer object for a little
		if lastTrailerId and DoesEntityExist(lastTrailerId) then
			DeleteVehicle(lastTrailerId)
		end
	end)
end

function assignTask()
	currentRoute       = Config.Routes[math.random(1, #Config.Routes)]
	currentDestination = currentRoute.Destinations[math.random(1, #currentRoute.Destinations)]
	currentPickup	   = currentRoute.PickupLocations[math.random(1, #currentRoute.PickupLocations)]
	routeBlip          = EncoreHelper.CreateRouteBlip(currentPickup.coords)

	local distanceToPickup   = GetDistanceBetweenCoords(lastDropCoordinates, currentPickup.coords)
	local distanceToDelivery = GetDistanceBetweenCoords(currentPickup.coords, currentDestination)

	lastDropCoordinates = currentDestination

	EncoreHelper.ShowNotification('Head to the ~y~pickup~s~ on your GPS. Here are the keys!')

	jobStatus = CONST_PICKINGUP

	TriggerServerEvent("encore_trucking:registerTrucker", distanceToPickup, distanceToDelivery)
end

--
-- Events
--

RegisterNetEvent('encore_trucking:startJob')
AddEventHandler('encore_trucking:startJob', function()
	local playerId = PlayerPedId()

	if truckId then
		if DoesEntityExist(truckId) then
			DeleteVehicle(truckId)
			truckId = nil
		end
	end

	-- spawn semi truck
	truckId = EncoreHelper.SpawnVehicle(Config.TruckModel, Config.JobStart.VehicleSpawn.Coordinates, Config.JobStart.VehicleSpawn.Heading)

	-- give keys
	local vehPlate = GetVehicleNumberPlateText(truckId)
	vehPlate = exports.globals:trim(vehPlate)
	TriggerServerEvent("encore_trucking:putKeysInTruck", vehPlate)
	TriggerServerEvent("fuel:setFuelAmount", vehPlate, 100)

	-- other stuff
	lastDropCoordinates = Config.JobStart.Coordinates
	jobStatus = CONST_WAITINGFORTASK
end)