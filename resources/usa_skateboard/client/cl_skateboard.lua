local Skateboard = {}
local player = nil

Attached = false

RegisterNetEvent('usa_skateboard:PlaceDown')
AddEventHandler('usa_skateboard:PlaceDown', function()
	TriggerServerEvent("usa_skateboard:RemoveItem")
	exports.globals:notify('[E] - Pickup Skateboard \n[G] - Get On Skateboard \n[Space] - Jump Skateboard \n[Arrow Keys] - Control Skateboard', "^3INFO: ^0" .. '[E] - Pickup Skateboard, [G] - Get On Skateboard, [Space] - Jump Skateboard, [Arrow Keys] - Control Skateboard')
	Skateboard.Start()
end)

AddEventHandler('usa_skateboard:clear', function()
	Skateboard.Clear()
end)

AddEventHandler('usa_skateboard:start', function()
	Skateboard.Clear()
    Skateboard.Start()
end)

Skateboard.Start = function()
	player = PlayerPedId()
	if DoesEntityExist(Skateboard.Entity) then return end

	Skateboard.Spawn()

	while DoesEntityExist(Skateboard.Entity) and DoesEntityExist(Skateboard.Driver) do
		Wait(5)

		local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),  GetEntityCoords(Skateboard.Entity), true)

		Skateboard.HandleKeys(distanceCheck)

		if distanceCheck <= Config.LoseConnectionDistance then
			if not NetworkHasControlOfEntity(Skateboard.Driver) then
				NetworkRequestControlOfEntity(Skateboard.Driver)
			elseif not NetworkHasControlOfEntity(Skateboard.Entity) then
				NetworkRequestControlOfEntity(Skateboard.Entity)
			end
		else
			TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 6, 2500)
		end

		CreateThread(function()
			Wait(50)
			StopCurrentPlayingAmbientSpeech(Skateboard.Driver)	
			if Attached then
				-- Ragdoll system
				local x = GetEntityRotation(Skateboard.Entity).x
				local y = GetEntityRotation(Skateboard.Entity).y
				
				if (-40.0 < x and x > 40.0) or (-40.0 < y and y > 40.0) then
					Skateboard.AttachPlayer(false)
					SetPedToRagdoll(player, 5000, 4000, 0, true, true, false)
				end	
			end           
		end)
	end
end

Skateboard.HandleKeys = function(distanceCheck)
	if distanceCheck <= 1.5 then
		if IsControlJustPressed(0, 38) then
			Skateboard.Attach("pick")
		end

		if IsControlJustReleased(0, 113) then
			if Attached then
				Skateboard.AttachPlayer(false)
			else
				Skateboard.AttachPlayer(true)
			end
		end
	end
	
	if distanceCheck < Config.LoseConnectionDistance then
		local overSpeed = (GetEntitySpeed(Skateboard.Entity)*2.236936) > Config.MaxSpeedmph
		
		-- prevents ped from driving away
		TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 1, 1)
		ForceVehicleEngineAudio(Skateboard.Entity, 0)
		-- Input Control usa_skateboard 
		if Attached then
			if IsControlPressed(0, 172) and not IsControlPressed(0, 173) and not overSpeed then
				TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 9, 1)
			end
		end

		if IsControlPressed(0, 22) and Attached then
			-- Jump system
			if not IsEntityInAir(Skateboard.Entity) then	
				local vel = GetEntityVelocity(Skateboard.Entity)
				TaskPlayAnim(PlayerPedId(), "move_crouch_proto", "idle_intro", 5.0, 8.0, -1, 0, 0, false, false, false)
				local duration = 0
				local boost = 0
				while IsControlPressed(0, 22) do
					Wait(10)
					duration = duration + 10.0
					ForceVehicleEngineAudio(Skateboard.Entity, 0)
				end
				boost = Config.MaxJumpHeight * duration / 250.0
				if boost > Config.MaxJumpHeight then boost = Config.MaxJumpHeight end
				StopAnimTask(PlayerPedId(), "move_crouch_proto", "idle_intro", 1.0)
				SetEntityVelocity(Skateboard.Entity, vel.x, vel.y, vel.z + boost)
				TaskPlayAnim(player, "move_strafe@stealth", "idle", 8.0, 2.0, -1, 1, 1.0, false, false, false)
			end
		end
		if Attached then
			if IsControlJustReleased(0, 172) or IsControlJustReleased(0, 173) and not overSpeed then
				TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 6, 2500)
			end

			if IsControlPressed(0, 173) and not IsControlPressed(0, 172) and not overSpeed then
				TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 22, 1)
			end

			if IsControlPressed(0, 174) and IsControlPressed(0, 173) and not overSpeed then
				TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 13, 1)
			end

			if IsControlPressed(0, 175) and IsControlPressed(0, 173) and not overSpeed then
				TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 14, 1)
			end

			if IsControlPressed(0, 172) and IsControlPressed(0, 173) and not overSpeed then
				TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 30, 100)
			end

			if IsControlPressed(0, 174) and IsControlPressed(0, 172) and not overSpeed then
				TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 7, 1)
			end

			if IsControlPressed(0, 175) and IsControlPressed(0, 172) and not overSpeed then
				TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 8, 1)
			end

			if IsControlPressed(0, 174) and not IsControlPressed(0, 172) and not IsControlPressed(0, 173) and not overSpeed then
				TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 4, 1)
			end

			if IsControlPressed(0, 175) and not IsControlPressed(0, 172) and not IsControlPressed(0, 173) and not overSpeed then
				TaskVehicleTempAction(Skateboard.Driver, Skateboard.Entity, 5, 1)
			end
		end
	end
end


Skateboard.Spawn = function()
	-- models to load
	Skateboard.LoadModels({ GetHashKey("triBike3"), 68070371, GetHashKey("p_defilied_ragdoll_01_s"), "pickup_object", "move_strafe@stealth", "move_crouch_proto"})

	local spawnCoords, spawnHeading = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId()) * 2.0, GetEntityHeading(PlayerPedId())

	Skateboard.Entity = CreateVehicle(GetHashKey("triBike3"), spawnCoords, spawnHeading, true)
	Skateboard.Skate = CreateObject(GetHashKey("p_defilied_ragdoll_01_s"), 0.0, 0.0, 0.0, true, true, true)
	
	-- load models
	while not DoesEntityExist(Skateboard.Entity) do
		Wait(5)
	end
	while not DoesEntityExist(Skateboard.Skate) do
		Wait(5)
	end

	SetHandling() -- Modify hanfling for upgrade the stability
	SetEntityNoCollisionEntity(Skateboard.Entity, player, false) -- disable collision between the player and the rc
	SetEntityCollision(Skateboard.Entity, true, true)
	SetEntityVisible(Skateboard.Entity, false)
	--SetAllVehiclesSpawn(Skateboard.Entity, true, true, true, true)
	AttachEntityToEntity(Skateboard.Skate, Skateboard.Entity, GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, -0.60, 0.0, 0.0, 90.0, false, true, true, true, 1, true)

	Skateboard.Driver = CreatePed(12	, 68070371, spawnCoords, spawnHeading, true, true)

	-- Driver properties
	SetEnableHandcuffs(Skateboard.Driver, true)
	SetEntityInvincible(Skateboard.Driver, true)
	SetEntityVisible(Skateboard.Driver, false)
	FreezeEntityPosition(Skateboard.Driver, true)
	TaskWarpPedIntoVehicle(Skateboard.Driver, Skateboard.Entity, -1)
	--SetPedAlertness(Skateboard.Driver, 0)

	while not IsPedInVehicle(Skateboard.Driver, Skateboard.Entity) do
		Wait(0)
	end

	Skateboard.Attach("place")
end

function SetHandling()
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fSteeringLock", 9.0)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fDriveInertia", 0.05)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fMass", 1800.0)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fPercentSubmerged", 105.0)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fDriveBiasFront", 0.0)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fInitialDriveForce", 0.25)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fInitialDriveMaxFlatVel", 135.0)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fTractionCurveMax", 2.2)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fTractionCurveMin", 2.12)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fTractionCurveLateral", 22.5)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fTractionSpringDeltaMax", 0.1)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fLowSpeedTractionLossMult", 0.7)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fCamberStiffnesss", 0.0)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fTractionBiasFront", 0.478)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fTractionLossMult", 0.0)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fSuspensionForce", 5.2)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fSuspensionForce", 1.2)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fSuspensionReboundDamp", 1.7)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fSuspensionUpperLimit", 0.1	)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fSuspensionLowerLimit", -0.3)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fSuspensionRaise", 0.0)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fSuspensionBiasFront", 0.5)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fAntiRollBarForce", 0.0)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fAntiRollBarBiasFront", 0.65)
	SetVehicleHandlingFloat(Skateboard.Entity, "CHandlingData", "fBrakeForce", 0.53)
end

Skateboard.Attach = function(param)
	if not DoesEntityExist(Skateboard.Entity) then
		return
	end
	
	if param == "place" then
		-- Place usa_skateboard
		AttachEntityToEntity(Skateboard.Entity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.1, 0.0, -0.2, 70.0, 0.0, 270.0, 1, 1, 0, 0, 2, 1)

		TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 8.0, -8.0, -1, 0, 0, false, false, false)

		Wait(800)

		DetachEntity(Skateboard.Entity, false, true)

		PlaceObjectOnGroundProperly(Skateboard.Entity)
	elseif param == "pick" then
		-- Pick usa_skateboard
		Wait(100)

		TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 8.0, -8.0, -1, 0, 0, false, false, false)

		Wait(600)
	
		AttachEntityToEntity(Skateboard.Entity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.1, 0.0, -0.2, 70.0, 0.0, 270.0, 1, 1, 0, 0, 2, 1)
		
		Wait(900)
		
		-- Clear 
		Skateboard.Clear()

	end

end

Skateboard.Clear = function(models)
	DetachEntity(Skateboard.Entity)
	DeleteEntity(Skateboard.Skate)
	DeleteVehicle(Skateboard.Entity)
	DeleteEntity(Skateboard.Driver)

	Skateboard.UnloadModels()
	Attach = false
	Attached  = false

	TriggerServerEvent("usa_skateboard:GiveItem")
end


Skateboard.LoadModels = function(models)
	for modelIndex = 1, #models do
		local model = models[modelIndex]

		if not Skateboard.CachedModels then
			Skateboard.CachedModels = {}
		end

		table.insert(Skateboard.CachedModels, model)

		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)	
				Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
				Wait(10)
			end    
		end
	end
end

Skateboard.UnloadModels = function()
	for modelIndex = 1, #Skateboard.CachedModels do
		local model = Skateboard.CachedModels[modelIndex]

		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)   
		end
	end
end
local vehiclesMuted = {}

Skateboard.AttachPlayer = function(toggle)
	if toggle then
		TaskPlayAnim(player, "move_strafe@stealth", "idle", 8.0, 8.0, -1, 1, 1.0, false, false, false)
		AttachEntityToEntity(player, Skateboard.Entity, 20, 0.0, 0.15, 0.05, 0.0, 0.0, -15.0, true, true, false, true, 1, true)
		SetEntityCollision(player, true, true)
		Attached = true		
		TriggerServerEvent("usa_skateboard:ImOnSkateboard")
	elseif not toggle then
		DetachEntity(player, false, false)
		Attached = false
		StopAnimTask(player, "move_strafe@stealth", "idle", 1.0)	
	end	
end

RegisterNetEvent("usa_skateboard:OnSkateboard")
AddEventHandler("usa_skateboard:OnSkateboard", function(id) 
	local player = GetPlayerFromServerId(id)
	local vehicle = GetEntityAttachedTo(GetPlayerPed(player))
	if not vehiclesMuted[vehicle] then
		CreateThread(function() 
			vehiclesMuted[vehicle] = true
			while vehicle do
				Wait(10)
				ForceVehicleEngineAudio(vehicle, 0)
			end
			table.remove(vehiclesMuted, vehicle)
		end)
	end	
end)