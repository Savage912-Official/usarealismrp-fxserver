local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local notificationParam = 1 -- 1 = LockSystem notification | 2 = chatMessage notification | 3 = nothing
local keyParam = Keys["U"] -- e.g : Keys["H"] will be change the U key to the H key for lock/unlock a vehicle
local soundEnable = false -- Set to false for disable sounds
local disableCar_NPC = true -- Set to false for enable NPC's car
local soundDistance = 4 -- Distance of sounds lock / unlock (default: 10m)

if disableCar_NPC then
	Citizen.CreateThread(function()
    	while true do
			Wait(0)

			local player = GetPlayerPed(-1)

	        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(player))) then

	            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(player))
	            local lock = GetVehicleDoorLockStatus(veh)

	            if lock == 7 or lock == 0 then
	                SetVehicleDoorsLocked(veh, 2)
	            end

	            local pedd = GetPedInVehicleSeat(veh, -1)

	            if pedd then
	                SetPedCanBeDraggedOut(pedd, false)
	            end
	        end
	    end
	end)
end

local player = GetPlayerPed(-1) -- the player trying to lock/unlock
local vehicle = nil -- vehicle to be kept locked/unlocked (either inside already or the vehicle in front of player)
local isPlayerInside = nil -- is player inside of any vehicle when trying to lock/unlock?

Citizen.CreateThread(function()
	while true do

		if IsControlJustPressed(1, keyParam) then

			player = PlayerPedId()
			vehicle = GetVehiclePedIsIn(player, false)
			isPlayerInside = IsPedInAnyVehicle(player, true)

			local coordA = GetEntityCoords(player, true)
			local coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, 3.0, 0.0)

			local targetVehicle = GetVehicleInDirection(coordA, coordB) -- performs a scan on the z-axis from coordA to coordB, (for motorcycles that have fallen over, or low vehicles)

			if targetVehicle ~= 0 or vehicle ~= 0 then

				local plate = nil
				if vehicle ~= 0 then
					plate = GetVehicleNumberPlateText(vehicle)
				else
					vehicle = targetVehicle
					plate = GetVehicleNumberPlateText(vehicle)
				end
				if type(plate) == 'string' then
					plate = exports.globals:trim(plate)
					TriggerServerEvent("lock:checkForKey", plate)
				end
			end
		end
		Wait(1)
	end
end)

RegisterNetEvent("lock:lockVehicle")
AddEventHandler("lock:lockVehicle", function()
	SetVehicleDoorsLocked(vehicle, 2)

	-- ## Notifications
		if soundEnable then TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "lock", 1.0) end
		PlayLockAnim()
		Citizen.Wait(500)
		TriggerEvent("lock:sendNotification", notificationParam, "Vehicle locked.", 0.080)
	-- ## Notifications
end)

RegisterNetEvent("lock:unlockVehicle")
AddEventHandler("lock:unlockVehicle", function()
	SetVehicleDoorsLocked(vehicle, 1)

	-- ## Notifications
		if soundEnable then	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "unlock", 1.0) end
		PlayLockAnim()
		Citizen.Wait(500)
		TriggerEvent("lock:sendNotification", notificationParam, "Vehicle unlocked.", 0.080)
	-- ## Notifications

end)

RegisterNetEvent("lock:lookForKeys")
AddEventHandler("lock:lookForKeys", function(plate)
	if isPlayerInside and IsVehicleEngineOn(vehicle) and GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1) then
		TriggerServerEvent("lock:foundKeys", true, plate)
	else
		TriggerServerEvent("lock:foundKeys", false)
	end
end)

RegisterNetEvent("lock:sendNotification")
AddEventHandler("lock:sendNotification", function(param, message, duration)
	if param == 1 then
		TriggerEvent("usa:notify", message)
	elseif param == 2 then
		TriggerEvent('chatMessage', 'LockSystem', { 255, 128, 0 }, message)
	end
end)

RegisterNetEvent("lock:notify")
AddEventHandler("lock:notify", function(text, time)
	TriggerEvent("usa:notify", text)
end)

RegisterNetEvent("lock:printLockStatus")
AddEventHandler("lock:printLockStatus", function()
	print("LOCK STATUS: " .. GetVehicleDoorLockStatus(vehicle))
end)

function GetVehicleInDirection(coordFrom, coordTo)
	local rayHandle
	--local rayHandle = StartShapeTestCapsule(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 4.0, 10, GetPlayerPed(-1), 7)
	local a, b, c, d, vehicleResult

	vehicleResult = 0

	for i = 0.0, 2.0, 0.1 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z - i, 10, GetPlayerPed(-1), 0)
		a, b, c, d, vehicleResult = GetRaycastResult(rayHandle)
		if vehicleResult ~= 0 then
			return vehicleResult
		end
	end

	return vehicleResult
end

function PlayLockAnim()
    if not IsPedCuffed(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        loadAnimDict('anim@mp_player_intmenu@key_fob@')
        ped = GetPlayerPed(-1)
        TaskPlayAnim(ped, "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, 1.0, -1, 48)
    end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end