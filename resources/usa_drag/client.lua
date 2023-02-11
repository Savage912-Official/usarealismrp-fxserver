local draggedBy = nil -- source of the PERSON the ped is 'DRAGGED BY'
local isDragged = false

local sourceDragged = nil
local isDragging = false

local carriedBy = nil
local isCarried = false

local sourceCarried = nil
local isCarrying = false

local jailed = false

RegisterNetEvent("drag:attemptToDragNearest")
AddEventHandler('drag:attemptToDragNearest', function(playerId)
	if exports["usa_rp2"]:areHandsTied() then
		exports.globals:notify("Hands are tied! Can't drag!")
		return
	end
	if not isDragging and not isDragged and not isCarrying and not isCarried and not jailed then
		if not playerId then
			TriggerEvent("usa:getClosestPlayer", 1.65, function(player)
				if player then
					local closestPed = GetPlayerPed(GetPlayerFromServerId(player.id))
					if player.id ~= 0 and not IsPedInAnyVehicle(PlayerPedId()) and IsEntityVisible(closestPed) then
						TriggerServerEvent('drag:sendDragPlayer', player.id)
						-- print('sent??')
						sourceDragged = player.id
					end
				end
			end)
		else
			--local p1 = GetPlayerPed(GetPlayerFromServerId(playerId))
			--local p1coords = GetEntityCoords(p1)
			--local mycoords = GetEntityCoords(PlayerPedId())
			--local dist = #(mycoords - p1coords)
			--if dist < 1.65 then
				TriggerServerEvent('drag:sendDragPlayer', playerId)
				sourceDragged = playerId
			--end
		end
    elseif isDragging and sourceDragged then
    	TriggerServerEvent('drag:sendDragPlayer', sourceDragged)
		sourceDragged = nil
	end
end)

RegisterNetEvent('drag:attemptToCarryNearest')
AddEventHandler('drag:attemptToCarryNearest', function()
	if exports["usa_rp2"]:areHandsTied() then
		exports.globals:notify("Hands are tied! Can't drag!")
		return
	end
	if not isDragging and not isDragged and not isCarrying and not isCarried and not jailed then
		TriggerEvent("usa:getClosestPlayer", 1.65, function(player)
			if player then
				local closestPed = GetPlayerPed(GetPlayerFromServerId(player.id))
				if player.id ~= 0 and not IsPedInAnyVehicle(PlayerPedId()) and IsEntityVisible(closestPed) then
					TriggerServerEvent('drag:sendCarryPlayer', player.id)
					sourceCarried = player.id
				end
			end
		end)
	elseif isCarrying and sourceCarried then
		TriggerServerEvent('drag:sendCarryPlayer', sourceCarried)
		sourceCarried = nil
	end
end)

RegisterNetEvent('drag:dragPlayer')
AddEventHandler('drag:dragPlayer', function(playerDraggedBy, check)
	if draggedBy ~= playerDraggedBy and not check then
		if not isDragged and not IsPedInAnyVehicle(PlayerPedId()) then
			draggedBy = playerDraggedBy
			TriggerServerEvent('drag:toggleDragAction', draggedBy, true)
			isDragged = true
			Citizen.CreateThread(function()
				while isDragged do
					AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(draggedBy)), 11816, 0.61, 0.24, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					Citizen.Wait(1000)
				end
			end)
			-- dragging
		end
	elseif draggedBy == playerDraggedBy or (check and carriedBy) then
		if isDragged then
			TriggerServerEvent('drag:toggleDragAction', draggedBy, false)
			DetachEntity(PlayerPedId(), true, false)
			draggedBy = nil
			isDragged = false
			-- undragging
		end
	end
end)

RegisterNetEvent('drag:carryPlayer')
AddEventHandler('drag:carryPlayer', function(playerCarriedBy, check)
	if carriedBy ~= playerCarriedBy and not check then
		if not isCarried and not IsPedInAnyVehicle(PlayerPedId()) then
			TriggerEvent('death:reviveMeWhileCarried', true)
			carriedBy = playerCarriedBy
			TriggerServerEvent('drag:toggleCarryAction', carriedBy, true)
			isCarried = true
			local dict = "timetable@tracy@sleep@"
			local anim = "idle_f"
			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(100)
			end
			TaskPlayAnim(GetPlayerPed(PlayerId()), dict, anim, 1.0, -1, -1, 1, 0, 0, 0, 0)
			Citizen.CreateThread(function()
				while isCarried do
					AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(carriedBy)), GetPedBoneIndex(GetPlayerPed(GetPlayerFromServerId(carriedBy)), 57005), 0.66, -0.45, 0.31, -175.5, 112.0, -43.0, false, false, false, true, 2, true)
					Citizen.Wait(1000)
				end
			end)
			-- dragging
		end
	elseif carriedBy == playerCarriedBy or (check and carriedBy) then
		if isCarried then
			TriggerEvent('death:reviveMeWhileCarried', false)
			TriggerServerEvent('drag:toggleCarryAction', carriedBy, false)
			ClearPedTasksImmediately(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			carriedBy = nil
			isCarried = false
			-- undragging
		end
	end
end)

RegisterNetEvent('drag:toggleDragAction')
AddEventHandler('drag:toggleDragAction', function(toggleOn, _source)
	--print('isDragging: '..tostring(toggleOn))
	--print('sourceDragged: '..tostring(_source))
	isDragging = toggleOn
	sourceDragged = _source
	ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent('drag:toggleCarryAction')
AddEventHandler('drag:toggleCarryAction', function(toggleOn, _source)
	--print('isCarried: '..tostring(toggleOn))
	--print('sourceCarried: '..tostring(_source))
	isCarrying = toggleOn
	sourceCarried = _source
	ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent("usa:toggleJailedStatus")
AddEventHandler("usa:toggleJailedStatus", function(toggle)
  jailed = toggle
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlPressed(0, 19) and IsControlJustPressed(0, 47) then
			if not isDragging and not isDragged and not isCarrying and not isCarried and not exports["usa_rp2"]:areHandsTied() and not jailed then
				TriggerEvent("usa:getClosestPlayer", 1.65, function(player)
		    		if player then
			        	local closestPed = GetPlayerPed(GetPlayerFromServerId(player.id))
						if player.id and not IsPedInAnyVehicle(PlayerPedId()) and IsEntityVisible(closestPed) then
							TriggerServerEvent('drag:sendDragPlayer', player.id)
							sourceDragged = player.id
						end
					end
		        end)
		    elseif isDragging and sourceDragged then
		    	TriggerServerEvent('drag:sendDragPlayer', sourceDragged)
				sourceDragged = nil
			end
		end
		if isDragged or isCarried then
        	DisablePlayerFiring(PlayerPedId(), true)
            DisableControlAction(24, 37, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 23, true)
    	elseif isDragging or isCarrying then
    		if not IsPedSwimming(PlayerPedId()) then
				DisableControlAction(0, 21, true)
			end
			DisableControlAction(0, 22, true)
			DisableControlAction(0, 44, true)
			DisableControlAction(0, 23, true)
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(PlayerPedId(), true)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local playerPed = PlayerPedId()
		if isDragging and not IsEntityDead(GetPlayerPed(GetPlayerFromServerId(sourceDragged))) and not IsPedSwimming(playerPed) then
			local dict = "weapons@projectile@"
			local anim = "aim_m"
			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 1.0, -1, 49, 0.0, 0, 0, 0)
			Citizen.Wait(1800)
		elseif isCarrying and not IsPedSwimming(PlayerPedId()) and not IsEntityPlayingAnim(playerPed, 'missfinale_c2ig_1', 'relax_idle_pedb', 3) then
			local dict = "missfinale_c2ig_1"
			local anim = "relax_idle_pedb"
			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(100)
			end
			TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, -1, 49, 0.0, 0, 0, 0)
		elseif isCarried and not IsPedSwimming(PlayerPedId()) and not IsEntityPlayingAnim(playerPed, 'timetable@tracy@sleep@', 'idle_f', 3) then
			local dict = "timetable@tracy@sleep@"
			local anim = "idle_f"
			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(100)
			end
			TaskPlayAnim(GetPlayerPed(PlayerId()), dict, anim, 1.0, -1, -1, 1, 0, 0, 0, 0)
		end
	end
end)

function GetPlayerFromPed(ped)
    for a = 0, 255 do
        if GetPlayerPed(a) == ped then
            return a
        end
    end
    return -1
end