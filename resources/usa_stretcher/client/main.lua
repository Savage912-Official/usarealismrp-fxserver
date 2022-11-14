local currentlyUsing = false
local isInStretcher = false

local PUSHABLES = {
	{ 
		prop = "prop_wheelchair_01",
		anim = {
			dict = "missfinale_c2leadinoutfin_c_int",
			name = "_leadin_loop2_lester"
		},
		usingZPos = 0.4,
		pushingZPos = -0.73,
		canSteer = true,
		itemName = "Wheelchair"
	},
	{ 
		prop = "prop_ld_binbag_01",
		anim = {
			dict = "anim@gangops@morgue@table@",
			name = "ko_front"
		},
		usingZPos = 1.0,
		pushingZPos = -0.52,
		pushingYPos = -0.9,
		itemName = "Stretcher"
	}
}

RegisterNetEvent("pushable:remove")
AddEventHandler("pushable:remove", function(pushable)
	RemovePushable(pushable)
end)

RegisterNetEvent("stretcher:togglestrincar")
AddEventHandler("stretcher:togglestrincar", function(source)
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local veh = GetClosestVehicle(pedCoords, 8.000, GetHashKey("ambulance"), 70)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if IsEntityAttachedToAnyVehicle(closestObject) then
        StretcheroutCar()
    elseif IsEntityAttachedToEntity(closestObject, veh) then 
        StretcheroutCar()
    else
        StreachertoCar()
    end
end)

Citizen.CreateThread(function()
	LoadModel('prop_ld_binbag_01')
	while true do

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		for i = 1, #PUSHABLES do
			PUSHABLES[i].closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey(PUSHABLES[i].prop), false)

			if DoesEntityExist(PUSHABLES[i].closestObject) then

				local objectCoords = GetEntityCoords(PUSHABLES[i].closestObject)
				local objectForward = GetEntityForwardVector(PUSHABLES[i].closestObject)
				local useCoords = (objectCoords + objectForward * - 0.5)
				local pickupCoords = (objectCoords + objectForward * 0.3)
				local distanceFromBeingAbleToUse = GetDistanceBetweenCoords(pedCoords, useCoords, true)
				local distanceFromBeingAbleToPickup = GetDistanceBetweenCoords(pedCoords, pickupCoords, true)

				while distanceFromBeingAbleToUse <= 1.0 or distanceFromBeingAbleToPickup <= 1.0 do
					objectCoords = GetEntityCoords(PUSHABLES[i].closestObject)
					objectForward = GetEntityForwardVector(PUSHABLES[i].closestObject)
					useCoords = (objectCoords + objectForward * - 0.5)
					pickupCoords = (objectCoords + objectForward * 0.3)
					pedCoords = GetEntityCoords(ped)
					distanceFromBeingAbleToUse = GetDistanceBetweenCoords(pedCoords, useCoords, true)
					distanceFromBeingAbleToPickup = GetDistanceBetweenCoords(pedCoords, pickupCoords, true)

					if distanceFromBeingAbleToUse <= 1.0 and not currentlyUsing then
						DrawText3Ds(useCoords, "[E] Use", 0.4)

						if IsControlJustPressed(0, 38) then
							Use(PUSHABLES[i])
						end
					elseif distanceFromBeingAbleToPickup <= 1.0 and not currentlyPickedUp then
						DrawText3Ds(pickupCoords, "[E] Push | [Hold E] Pickup", 0.4)

						if IsControlJustPressed(0, 38) then
							Wait(500)
							if IsControlPressed(0, 38) then
								TriggerEvent("usa:getClosestPlayer", 1.2, function(player)
									if player.id == 0 then
										TriggerServerEvent("hospital:pushable:pickUpIfPlayerHasRoom", PUSHABLES[i])
									else
										exports.globals:notify("Someone already in wheelchair!")
									end
								end)
							else
								Push(PUSHABLES[i])
							end
						end
					end
					Wait(0)
				end

			end
		end

		Wait(500)
	end
end)


function StreachertoCar()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local veh = GetClosestVehicle(pedCoords, 8.000, GetHashKey("ambulance"), 70)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    NetworkRequestControlOfEntity(veh)
    SetEntityAsMissionEntity(veh)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
			currentlyPickedUp = false
            DetachEntity(closestObject, true, true)
			ClearPedTasks(PlayerPedId())
            AttachEntityToEntity(closestObject, veh, 0.0, 0.0, -3.2, 1.0, 0.0, 0.0, 180.00, false, false, false, false, 2, true)
            FreezeEntityPosition(closestObject, true)
		end
    end
end

function StretcheroutCar()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local veh = GetClosestVehicle(pedCoords, 8.000, GetHashKey("ambulance"), 70)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    NetworkRequestControlOfEntity(veh)
    SetEntityAsMissionEntity(veh)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            FreezeEntityPosition(closestObject, false)
            DetachEntity(closestObject, true, true)
            SetEntityCoords(closestObject, pedCoords)

            local pedheading = GetEntityHeading(ped)

            if pedheading >= 180 then 
            	pedheading = pedheading - 180
            else
            	pedheading = pedheading + 180
            end

            SetEntityHeading(closestObject, pedheading)
        else
            TriggerClientEvent("usa:notify","There is no ambulance here")
        end
    else
        TriggerClientEvent("usa:notify","There is no stretcher here")
    end
end

Use = function(pushable)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
			ShowNotification("Somebody is already using the wheelchair!")
			return
		end
	end

	LoadAnim(pushable.anim.dict)

	if DoesEntityExist(pushable.closestObject) then

		local isInPrison = TriggerServerCallback {
			eventName = "jail:isInPrison",
			args = {}
		}

		if isInPrison then
			exports.globals:notify("Can't use that now")
			return
		end

		currentlyUsing = true
		--AttachEntityToEntity(PlayerPedId(), pushable.closestObject, 0, 0, 0.0, 0.4, 0.0, 0.0, 180.0, 0.0, false, true, false, false, 2, true)
		AttachEntityToEntity(PlayerPedId(), pushable.closestObject, 0, 0, 0.0, (pushable.usingZPos or 0.4), 0.0, 0.0, 180.0, 0.0, false, true, false, false, 2, true)
		Wait(50)
		SetEntityCollision(PlayerPedId(), false, true)

		isInStretcher = true

		local heading = GetEntityHeading(pushable.closestObject)
		while IsEntityAttachedToEntity(PlayerPedId(), pushable.closestObject) do
			Citizen.Wait(5)

			if IsPedDeadOrDying(PlayerPedId()) then
				if not (IsEntityAttachedToAnyVehicle(pushable.closestObject)) then
					SetEntityCollision(PlayerPedId(), true, true)
					DetachEntity(PlayerPedId(), true, true)
					isInStretcher = false

				end
			end

			if not IsEntityPlayingAnim(PlayerPedId(), pushable.anim.dict, pushable.anim.name, 3) then
				TaskPlayAnim(PlayerPedId(), pushable.anim.dict, pushable.anim.name, 8.0, 8.0, -1, 69, 1, false, false, false)
			end

			if pushable.canSteer then
				if IsControlPressed(0, 32) then
					local x, y, z  = table.unpack(GetEntityCoords(pushable.closestObject) + GetEntityForwardVector(pushable.closestObject) * -0.02)
					SetEntityCoords(pushable.closestObject, x,y,z)
					PlaceObjectOnGroundProperly(pushable.closestObject)
				end

				if IsControlPressed(1,  34) then
					heading = heading + 0.4

					if heading > 360 then
						heading = 0
					end

					SetEntityHeading(pushable.closestObject,  heading)
				end

				if IsControlPressed(1,  9) then
					heading = heading - 0.4

					if heading < 0 then
						heading = 360
					end

					SetEntityHeading(pushable.closestObject,  heading)
				end
			end

			if IsControlJustPressed(0, 38) then
				if not (IsEntityAttachedToAnyVehicle(pushable.closestObject)) then
					SetEntityCollision(PlayerPedId(), true, true)
					DetachEntity(PlayerPedId(), true, true)
					isInStretcher = false
					local x, y, z = table.unpack(GetEntityCoords(pushable.closestObject) + GetEntityForwardVector(pushable.closestObject) * - 0.7)
					SetEntityCoords(PlayerPedId(), x,y,z)
				end
			end
		end
		currentlyUsing = false
	end
end

Push = function(pushable)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
			ShowNotification("Somebody is already driving the wheelchair!")
			return
		end
	end

	NetworkRequestControlOfEntity(pushable.closestObject)

	LoadAnim("anim@heists@box_carry@")

	if DoesEntityExist(pushable.closestObject) then
		CreateThread(function()
			AttachEntityToEntity(pushable.closestObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.00, (pushable.pushingYPos or -0.35), (pushable.pushingZPos or -0.73), 195.0, 180.0, 180.0, 0.0, false, false, true, false, 1, true)
			currentlyPickedUp = true
			while IsEntityAttachedToEntity(pushable.closestObject, PlayerPedId()) do
				Citizen.Wait(5)

				if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) and currentlyPickedUp == true then
					TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
				end

				if IsPedDeadOrDying(PlayerPedId()) then
					DetachEntity(pushable.closestObject, true, true)
				end

				if IsControlJustPressed(0, 38) then
					DetachEntity(pushable.closestObject, true, true)
					ClearPedTasks(PlayerPedId())
				end
			end
			currentlyPickedUp = false
		end)
	end
end

DrawText3Ds = function(coords, text, scale)
	local x,y,z = coords.x, coords.y, coords.z
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 370

	DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.025, 41, 11, 41, 100)
end

GetPlayers = function()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

GetClosestPlayer = function()
	local players = GetActivePlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

LoadAnim = function(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		
		Citizen.Wait(1)
	end
end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		
		Citizen.Wait(1)
	end
end

ShowNotification = function(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end

RemovePushable = function(pushable)
	local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, GetHashKey(pushable.prop))
	local startTime = GetGameTimer()
	while DoesEntityExist(obj) and GetGameTimer() - startTime < 30000 do
		SetEntityAsMissionEntity(obj, true, true)
		DeleteObject(obj)
		DeleteEntity(obj)
		Wait(1)
	end
end

RegisterCommand("togglestr", function()
	TriggerEvent("stretcher:togglestrincar")
end)
RegisterKeyMapping('togglestr', 'EMS: Load/Unload Stretcher', 'keyboard', 'J')

function IsInStretcher()
	return isInStretcher
end