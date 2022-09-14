local currentlyTowedVehicle = nil
local vehicleToImpound = nil
local lastTowTruck = nil
local interactKey = 38
onDuty = "no"

local TIME_WARN_MINUTES = 15
local TIME_KICK_MINUTES = 20

local lastRecordedTimeDoingJob = 0

local isRepairing = false

local KEYS = {
	E = 38,
	V = 0
}

locations = {
	["Paleto"] = {
		duty = {
			x = -196.027,
			y = 6265.625,
			z = 30.489
		},
		truck_spawn = {
			x = -176.32,
			y = 6283.17,
			z = 31.489,
			heading = 40.0
		},
		impound = {
			x = -171.624,
			y = 6277.602,
			z = 30.489
		},
		ped = {
			x = -196.027,
			y = 6265.625,
			z = 30.489,
			heading = 0.0,
			model = "amy_downtown_01"
		},
		show_blip = {
			disable_blip = false
		}
	},
	["Sandy"] = {
		duty = {
			x = 2363.89,
			y = 3126.85,
			z = 47.211
		},
		truck_spawn = {
			x = 2369.98,
			y = 3129.17,
			z = 48.82,
			heading = 218.0
		},
		impound = {
			x = 2398.42,
			y = 3108.48,
			z = 47.1806
		},
		ped = {
			x = 2363.89,
			y = 3126.85,
			z = 47.211,
			heading = 0.0,
			model = "amm_farmer_01"
		},
		show_blip = {
			disable_blip = false
		}
	},
	["Los Santos - Davis"] = {
		duty = {
			x = 409.78,
			y = -1623.41,
			z = 28.29
		},
		truck_spawn = {
			x = 404.18,
			y = -1642.03,
			z = 29.29,
			heading = 225.0
		},
		impound = {
			x = 403.24,
			y = -1633.48,
			z = 28.29
		},
		ped = {
			x = 408.03,
			y = -1624.62,
			z = 28.29,
			heading = -90.0,
			model = "amy_downtown_01"
		},
		show_blip = {
			disable_blip = false
		}
	},
	["Luxury Autos - Max W"] = {
		duty = {
			x = -794.27,
			y = -219.09,
			z = 36.08,
		},
		truck_spawn = {
			x = -762.97,
			y = -228.29,
			z = 37.28,
			heading = 216.46
		},
		impound = nil,
		ped = nil,
		show_blip = {
			disable_blip = true
		}
	},
	["Elgin Ave"] = {
		duty = {
			x = 550.58752441406,
			y = -182.13092041016,
			z = 53.493202209473
		},
		truck_spawn = {
			x = 541.54089355469,
			y = -210.18563842773,
			z = 53.542335510254,
			heading = 183.0
		},
		impound = nil,
		ped = nil,
		show_blip = {
			disable_blip = true
		}
	},
	["Power St"] = {
		duty = {
			x = -39.881568908691,
			y = -1056.2325439453,
			z = 27.39649772644
		},
		truck_spawn = {
			x = -19.854124069214,
			y = -1019.0305175781,
			z = 28.914356231689,
			heading = 70.0
		},
		impound = {
			x = -238.21029663086,
			y = -1181.4978027344,
			z = 22.044040679932
		},
		ped = {
			x = -41.055442810059,
			y = -1055.7590332031,
			z = 28.39649772644,
			heading = 300.0
		},
		show_blip = {
			disable_blip = true
		}
	},
	["Mirror Park"] = {
		duty = {
			x = 1154.6276,
			y = -792.1779,
			z = 56.6051,
		},
		truck_spawn = {
			x = 1147.9426,
			y = -799.1232,
			z = 57.5782,
			heading = 91.5599
		},
		impound = nil,
		ped = nil,
		show_blip = {
			disable_blip = true
		}
	},
	["Otto's Auto Repair - Popular St."] = {
		duty = {
			x = 838.67279052734,
			y = -799.18878173828,
			z = 26.279302597046,
		},
		truck_spawn = {
			x = 826.77111816406,
			y = -797.47302246094,
			z = 26.20956993103,
			heading = 90.0
		},
		impound = nil,
		ped = {
			x = 838.67279052734,
			y = -799.18878173828,
			z = 26.279302597046,
			heading = 75.0
		},
		show_blip = {
			disable_blip = false
		}
	},
	["Tuner Shop"] = {
		duty = {
			x = 153.05549621582, 
			y = -3050.2783203125, 
			z = 6.0408916473389,
		},
		truck_spawn = {
			x = 165.74934387207, 
			y = -3049.3461914063, 
			z = 5.8909130096436,
			heading = 267.5
		},
		impound = nil,
		ped = {
			x = 153.05549621582, 
			y = -3050.2783203125, 
			z = 7.0408916473389,
			heading = 30.1
		},
		show_blip = {
			disable_blip = false
		}
	}
}
	
-- S P A W N  J O B  P E D S
local createdJobPeds = {}
Citizen.CreateThread(function()
	EnumerateBlips()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId(), false)
		for name, data in pairs(locations) do
			if data.ped then
				if Vdist(data.ped.x, data.ped.y, data.ped.z, playerCoords.x, playerCoords.y, playerCoords.z) < 50 then
					if not createdJobPeds[name] then
						local hash = -1806291497
						RequestModel(hash)
						while not HasModelLoaded(hash) do
							RequestModel(hash)
							Wait(0)
						end
						local ped = CreatePed(4, hash, data.ped.x, data.ped.y, data.ped.z, data.ped.heading, false, true)
						SetEntityCanBeDamaged(ped,false)
						SetPedCanRagdollFromPlayerImpact(ped,false)
						TaskSetBlockingOfNonTemporaryEvents(ped,true)
						SetPedFleeAttributes(ped,0,0)
						SetPedCombatAttributes(ped,17,1)
						SetPedRandomComponentVariation(ped, true)
						TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
						createdJobPeds[name] = ped
					end
				else 
					if createdJobPeds[name] then 
						DeletePed(createdJobPeds[name])
						createdJobPeds[name] = nil
					end
				end
			end
		end
		Wait(1)
	end
end)

-- draw 3D text --
Citizen.CreateThread(function()
	while true do
		if not isMechanicPartMenuOpen then
			for name, data in pairs(locations) do
				if onDuty == "no" then
					DrawText3D(data.duty.x, data.duty.y, (data.duty.z + 1.0), 5, '[E] - Sign in (~g~Mechanic~s~)')
				else
					DrawText3D(data.duty.x, data.duty.y, (data.duty.z + 1.0), 5, '[E] - Sign out (~g~Mechanic~s~) | [Hold E] - Order Parts | [Hold V] - Retrieve Truck')
				end
				if data.impound then
					DrawText3D(data.impound.x, data.impound.y, (data.impound.z + 1.5), 15, '[E] - Impound Vehicle')
				end
			end
		end
		Wait(1)
	end
end)

-- listen for key presses --
Citizen.CreateThread(function()
	local timeout = 0
	while true do
		Wait(0)
		
		if IsControlJustPressed(0, KEYS.E) then
			Wait(500)
			if IsControlPressed(0, KEYS.E) then
				if isNearSignOnSpot(5) then
					TriggerServerEvent("mechanic:openPartsMenu")
				end
			else
				local playerPed = PlayerPedId()
				local playerCoords = GetEntityCoords(playerPed)
				for name, data in pairs(locations) do
					local playerPed = PlayerPedId()
					if Vdist(playerCoords, data.duty.x, data.duty.y, data.duty.z) < 3 then
						if timeout > 3 then
							TriggerEvent('usa:notify', "You have clocked in and out too much recently, ~y~please wait~s~.")
						else
							timeout = timeout + 1
							if timeout > 3 then
								Citizen.CreateThread(function()
									local beginTime = GetGameTimer()
									while GetGameTimer() - beginTime < 10000 do
										Citizen.Wait(100)
									end
									timeout = 0
								end)
							end
							TriggerServerEvent("towJob:setJob")
						end
					elseif data.impound and Vdist(playerCoords, data.impound.x, data.impound.y, data.impound.z) < 15.0 then
						if onDuty == "yes" then
							ImpoundVehicle()
						end
					end
				end
			end
		end

		
		if IsControlJustPressed(0, KEYS.V) and GetLastInputMethod(0) and onDuty == "yes" then
			Wait(500)
			if IsControlPressed(0, KEYS.V) then
				if isNearSignOnSpot(5) then
					if not (lastTowTruck and DoesEntityExist(lastTowTruck)) then
						--TriggerServerEvent("mechanic:spawnTruck")
						TriggerServerEvent("mechanic:openTruckSpawnMenu")
					else
						exports.globals:notify("Already retrieved truck")
					end
				end
			end
		end
	end
end)

-- Kick player from job if player has not used tow truck recently enough or been at any mechanic shops --
Citizen.CreateThread(function()
	local warnedKick = false
	while true do
		local me = PlayerPedId()
		if onDuty == "yes" then
			if IsPedInAnyVehicle(me) then 
				local veh = GetVehiclePedIsIn(me, false)
				local vehModel = GetEntityModel(veh)
				if vehModel == GetHashKey("flatbed") or vehModel == GetHashKey("isgtow") then
					lastRecordedTimeDoingJob = GetGameTimer()
				end
			end
			if isNearAnyRepairShop() then
				lastRecordedTimeDoingJob = GetGameTimer()
			end
			local timeSinceLastDoingJob = GetGameTimer() - lastRecordedTimeDoingJob
			if timeSinceLastDoingJob > TIME_WARN_MINUTES * 60000 and timeSinceLastDoingJob < TIME_KICK_MINUTES * 60000 then
				if not warnedKick then
					exports.globals:notify("You are about to be kicked from the mechanic job! Get back to work!")
					warnedKick = true
				end
			elseif timeSinceLastDoingJob >= TIME_KICK_MINUTES * 60000 then 
				exports.globals:notify("You have been removed from the tow job!")
				TriggerServerEvent("tow:forceRemoveJob")
			end
		end
		if onDuty == "no" and warnedKick then
			warnedKick = false
		end
		Wait(5000)
	end
end)

-- help register towed vehicles for impounding for money when using the 'isgtow' model truck --
Citizen.CreateThread(function()
	local ISGTOW_HASH = GetHashKey("isgtow")
	while true do
		if onDuty == "yes" then
			local me = PlayerPedId()
			if IsPedInAnyVehicle(me, false) then
				local myveh = GetVehiclePedIsIn(me, false)
				if ISGTOW_HASH == GetEntityModel(myveh) then
					local towingveh = GetEntityAttachedToTowTruck(myveh)
					if towingveh > 0 then
						vehicleToImpound = towingveh
					end
				end
			end
		end
		Wait(2000)
	end
end)

RegisterNetEvent("towJob:onDuty")
AddEventHandler("towJob:onDuty", function(isRank3)
	exports.globals:notify('You are now ~g~on-duty~s~ as a mechanic.')
	onDuty = "yes"
	lastRecordedTimeDoingJob = GetGameTimer()
	ShowHelp(isRank3)
end)

RegisterNetEvent("towJob:offDuty")
AddEventHandler("towJob:offDuty", function()
	exports.globals:notify('You are now ~y~off-duty~s~ as a mechanic.')
	DelVehicle(lastTowTruck)
	onDuty = "no"
	lastTowTruck = nil
end)

RegisterNetEvent('towJob:towVehicle')
AddEventHandler('towJob:towVehicle', function()
	local playerPed = PlayerPedId()
	if lastTowTruck then
		local targetVehicle = MechanicHelper.getClosestVehicle(15)
		if not IsEntityAMissionEntity(targetVehicle) then
			SetEntityAsMissionEntity(targetVehicle, true, true)
		end
		if currentlyTowedVehicle == nil and not IsPedInAnyVehicle(playerPed, true) then
			if targetVehicle ~= 0 then
				local targetVehicleCoords = GetEntityCoords(targetVehicle, true)
				local towTruckCoords = GetEntityCoords(lastTowTruck, true)
				if Vdist(targetVehicleCoords, towTruckCoords) < 12.0 and IsVehicleWhitelisted(targetVehicle) then
					if lastTowTruck ~= targetVehicle and IsVehicleSeatFree(targetVehicle, -1) then
						local dict = "mini@repair"
						RequestAnimDict(dict)
						while not HasAnimDictLoaded(dict) do Citizen.Wait(100) end
						TriggerServerEvent('InteractSound_SV:PlayOnSource', 'tow-truck', 0.5)
						local beginTime = GetGameTimer()
						while GetGameTimer() - beginTime < 8000 do
							Citizen.Wait(1)
							DrawTimer(beginTime, 8000, 1.42, 1.475, 'ATTACHING')
							if not IsEntityPlayingAnim(playerPed, dict, 'fixing_a_player', 3) then
								TaskPlayAnim(playerPed, dict, "fixing_a_player", 8.0, 1.0, -1, 15, 1.0, 0, 0, 0)
							end
						end
						ClearPedTasks(playerPed)
						NetworkRequestControlOfEntity(targetVehicle)
						while not NetworkHasControlOfEntity(targetVehicle) do
							Wait(100)
						end
						AttachEntityToEntity(targetVehicle, lastTowTruck, GetEntityBoneIndexByName(lastTowTruck, 'bodyshell'), 0.0, -2.35, 0.75, 0, 0, 0, 1, 1, 0, 1, 0, 1)
						currentlyTowedVehicle = targetVehicle
						vehicleToImpound = currentlyTowedVehicle
					end
				else
					TriggerEvent('usa:notify', 'Towable vehicle not found. (1)')
				end
			else
				TriggerEvent('usa:notify', 'Towable vehicle not found. (2)')
			end
		else
			local detachCoords = GetOffsetFromEntityInWorldCoords(lastTowTruck, 0.0, -12.0, 0.0)
			local dict = "mini@repair"
			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do Citizen.Wait(100) end
			local beginTime = GetGameTimer()
			TriggerServerEvent('InteractSound_SV:PlayOnSource', 'tow-truck', 0.5)
			while GetGameTimer() - beginTime < 8000 do
				Citizen.Wait(1)
				DrawTimer(beginTime, 8000, 1.42, 1.475, 'DETACHING')
				if not IsEntityPlayingAnim(playerPed, dict, 'fixing_a_player', 3) and not IsPedInAnyVehicle(playerPed, true) then
					TaskPlayAnim(playerPed, dict, "fixing_a_player", 8.0, 1.0, -1, 15, 1.0, 0, 0, 0)
				end
			end
			ClearPedTasks(playerPed)
			DetachEntity(currentlyTowedVehicle, true, true)
			SetEntityCoords(currentlyTowedVehicle, detachCoords)
			currentlyTowedVehicle = nil
		end
	end
end)

RegisterNetEvent('character:setCharacter')
AddEventHandler('character:setCharacter', function()
	onDuty = "no"
	vehicleToImpound = nil
	lastTowTruck = nil
	currentlyTowedVehicle = nil
end)

RegisterNetEvent("mechanic:repairJobCheck")
AddEventHandler("mechanic:repairJobCheck", function()
	if not isRepairing then
		local me = PlayerPedId()
		local veh = MechanicHelper.getClosestVehicle()
		if not IsPedInAnyVehicle(me) then
			if veh then
				local engineHP = GetVehicleEngineHealth(veh)
				local driveable = IsVehicleDriveable(veh, true)
				local isAnyTireBurst = IsAnyVehicleTireBursted(veh)
				if engineHP < 600 or not driveable or isAnyTireBurst then
					TriggerServerEvent("mechanic:repairJobCheck")
				else
					exports.globals:notify("Vehicle does not need repairs!")
				end
			end
		else 
			exports.globals:notify("Must be outside vehicle!")
		end
	else 
		exports.globals:notify("Please wait!")
	end
end)

RegisterNetEvent("mechanic:repair")
AddEventHandler("mechanic:repair", function(repairCount)
	if not isRepairing then
		isRepairing = true
		local veh = MechanicHelper.getClosestVehicle(5)
		if veh then
			MechanicHelper.repairVehicle(veh, repairCount, function(success)
				if success then
					print("repair succeeded!")
					TriggerServerEvent("mechanic:vehicleRepaired")
					exports.globals:notify("Vehicle repaired!")
				else 
					print("repair failed")
					exports.globals:notify("Vehicle repair failed!")
				end
			end)
		else 
			exports.globals:notify("No vehicle found!")
		end
		isRepairing = false
	else
		exports.globals:notify("Busy")
	end
end)

RegisterNetEvent("mechanic:tryInstall")
AddEventHandler("mechanic:tryInstall", function(upgrade, rank)
	if isNearAnyRepairShop() then
		local veh = MechanicHelper.getClosestVehicle(5)
			if veh then
				exports.globals:notify("Installing " .. upgrade.displayName .. " upgrade!")
				MechanicHelper.installUpgrade(veh, upgrade, function()
					local plate = GetVehicleNumberPlateText(veh)
					plate = exports.globals:trim(plate)
					TriggerServerEvent("mechanic:installedUpgrade", plate, VehToNet(veh), rank)
				end)
			else
				exports.globals:notify("No vehicle found!")
			end
	else
		exports.globals:notify("You must be at a mechanic shop!")
	end
end)

RegisterNetEvent('mechanic:syncUpgrade')
AddEventHandler('mechanic:syncUpgrade', function(vehNetId, upgrade)
	local veh = NetToVeh(vehNetId)
	if veh then
		MechanicHelper.installUpgradeNoAnim(veh, upgrade)
	end
end)

RegisterNetEvent("mechanic:spawnTruck")
AddEventHandler("mechanic:spawnTruck", function(repairCount)
	local me = PlayerPedId()
	local mycoords = GetEntityCoords(me, false)
	for name, info in pairs(locations) do
		local dutyCoordsVector = vector3(info.duty.x, info.duty.y, info.duty.z)
		if Vdist(mycoords, dutyCoordsVector) < 10 then
			if repairCount >= MechanicHelper.LEVEL_3_RANK_THRESH then
				SpawnHeavyHauler(info.truck_spawn)
			else
				SpawnTowFlatbed(info.truck_spawn)
			end
			return
		end
	end
end)

RegisterNetEvent("mechanic:usedPart")
AddEventHandler("mechanic:usedPart", function(part)
	local nearbyVeh = MechanicHelper.getClosestVehicle(5)
	local vehPlate = exports.globals:trim(GetVehicleNumberPlateText(nearbyVeh))
	TriggerServerEvent("mechanic:usedPart", part, vehPlate)
end)

function isNearAnyRepairShop()
	local me = PlayerPedId()
	local mycoords = GetEntityCoords(me)
	local coordList = exports["usa_autorepair"]:GetAllRepairShopCoords()
	for num, info in pairs(exports["lscustoms"]:getLocations()) do
		table.insert(coordList, {info.inside.x, info.inside.y, info.inside.z})
	end
	for i = 1, #coordList do
		local dist = Vdist(mycoords.x, mycoords.y, mycoords.z, coordList[i][1], coordList[i][2], coordList[i][3])
		if dist < 45.0 then
			return true
		end
	end
	return false
end

function EnumerateBlips()
	for name, data in pairs(locations) do
		if not data.show_blip.disable_blip then
			local blip = AddBlipForCoord(data.duty.x, data.duty.y, data.duty.z)
			SetBlipSprite(blip, 68)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.75)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Tow Company')
			EndTextCommandSetBlipName(blip)
		end
	end
end

function ImpoundVehicle()
	local targetVehicle = MechanicHelper.getClosestVehicle(5)
	if targetVehicle == vehicleToImpound then
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		if DoesEntityExist(targetVehicle) then
			local targetPlate = GetVehicleNumberPlateText(targetVehicle, false)
			targetPlate = exports.globals:trim(targetPlate)
			TriggerServerEvent("impound:impoundVehicle", targetVehicle, targetPlate)
			NetworkRequestControlOfEntity(targetVehice)
			SetEntityAsMissionEntity(targetVehicle, true, true)
			DelVehicle(targetVehicle)
			exports.globals:notify("Impounding...")
			Citizen.CreateThread(function()
				Wait(3000)
				if not DoesEntityExist(targetVehicle) then
					while securityToken == nil do
						Wait(1)
					end
					TriggerServerEvent("towJob:giveReward", securityToken)
					exports.globals:notify("Impounded!")
					vehicleToImpound = nil
				end
			end)
		end
	end
end

function SpawnHeavyHauler(coords)
	local numberHash = 'isgtow' -- tow truck
	Citizen.CreateThread(function()
		RequestModel(numberHash)
		while not HasModelLoaded(numberHash) do
			RequestModel(numberHash)
			Citizen.Wait(0)
		end
		local vehicle = CreateVehicle(numberHash, coords.x, coords.y, coords.z, coords.heading, true, false)
		local vehPlate = GetVehicleNumberPlateText(vehicle)
		vehPlate = exports.globals:trim(vehPlate)
		TriggerServerEvent("fuel:setFuelAmount", vehPlate, 100)
		SetVehicleOnGroundProperly(vehicle)
		SetVehRadioStation(vehicle, "OFF")
		SetEntityAsMissionEntity(vehicle, true, true)
		SetVehicleExplodesOnHighExplosionDamage(vehicle, true)
		SetVehicleExtra(vehicle, 1, false)
		SetVehicleExtra(vehicle, 2, true)
		SetVehicleExtra(vehicle, 3, true)
		SetVehicleExtra(vehicle, 4, true)
		lastTowTruck = vehicle
		lastRecordedTimeDoingJob = GetGameTimer()
		local vehicle_key = {
			name = "Key -- " .. vehPlate,
			quantity = 1,
			type = "key",
			owner = "Bubba's Mechanic",
			make = "MTL",
			model = "Industrial",
			plate = vehPlate
		}

		-- give key to owner
		TriggerServerEvent("garage:giveKey", vehicle_key)
		TriggerServerEvent('mdt:addTempVehicle', 'MTL Flatbed', "Bubba's Mechanic Co.", vehPlate)

		-- give repair kit to start with --
		--TriggerServerEvent("mechanic:giveRepairKit", vehPlate)
	end)
end

function SpawnTowFlatbed(coords)
	local numberHash = 1353720154 -- tow truck
	Citizen.CreateThread(function()
		RequestModel(numberHash)
		while not HasModelLoaded(numberHash) do
			RequestModel(numberHash)
			Citizen.Wait(0)
		end
		local vehicle = CreateVehicle(numberHash, coords.x, coords.y, coords.z, coords.heading, true, false)
		local vehPlate = GetVehicleNumberPlateText(vehicle)
		vehPlate = exports.globals:trim(vehPlate)
		TriggerServerEvent("fuel:setFuelAmount", vehPlate, 100)
		SetVehicleOnGroundProperly(vehicle)
		SetVehRadioStation(vehicle, "OFF")
		SetEntityAsMissionEntity(vehicle, true, true)
		SetVehicleExplodesOnHighExplosionDamage(vehicle, true)
		lastTowTruck = vehicle
		lastRecordedTimeDoingJob = GetGameTimer()
		local vehicle_key = {
			name = "Key -- " .. vehPlate,
			quantity = 1,
			type = "key",
			owner = "Bubba's Mechanic",
			make = "MTL",
			model = "Flatbed",
			plate = vehPlate
		}

		-- give key to owner
		TriggerServerEvent("garage:giveKey", vehicle_key)
		TriggerServerEvent('mdt:addTempVehicle', 'MTL Flatbed', "Bubba's Mechanic Co.", vehPlate)

		-- give repair kit to start with --
		TriggerServerEvent("mechanic:giveRepairKit", vehPlate)
	end)
end

function IsVehicleWhitelisted(entity)
	if GetVehicleClass(entity) == 14 or GetVehicleClass(entity) == 15 or
	GetVehicleClass(entity) == 16 or GetVehicleClass(entity) == 21 or
	GetVehicleClass(entity) == 19 then
		return false
	else
		return true
	end
end

function DelVehicle(entity)
	DeleteVehicle(entity)
end

function isPlayerAtTowSpot()
	local playerCoords = GetEntityCoords(GetPlayerPed(-1), false)

	for name, data in pairs(locations) do
		if data.impound then
			if GetDistanceBetweenCoords(playerCoords.x,playerCoords.y,playerCoords.z,data.impound.x,data.impound.y,data.impound.z,true) < 5 then
				return true
			end
		end
	end

	return false

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

function IsAnyVehicleTireBursted(veh)
    if IsVehicleTyreBurst(veh, 0, false) then return true end
    if IsVehicleTyreBurst(veh, 1, false) then return true end
    if IsVehicleTyreBurst(veh, 2, false) then return true end
    if IsVehicleTyreBurst(veh, 3, false) then return true end
    if IsVehicleTyreBurst(veh, 4, false) then return true end
    return false
end

function ApplyUpgrades(veh, upgrades)
	for i = 1, #upgrades do
		print("applying upgrade: " .. upgrades[i].id)
		local upgrade = upgrades[i]
		if MechanicHelper.UPGRADE_FUNC_MAP[upgrade.id] then
			MechanicHelper.UPGRADE_FUNC_MAP[upgrade.id](veh, upgrade.increaseAmount)
		end
	end
end

function ShowHelp(isRank3)
	TriggerEvent("chatMessage", "", {}, "^3INFO: ^0Use ^3/dispatch [id] [msg]^0 to respond to a tow request!")
	Wait(3000)
	TriggerEvent("chatMessage", "", {}, "^3INFO: ^0Use ^3/ping [id]^0 to request a person\'s location.")
	Wait(3000)
	if isRank3 then
		TriggerEvent("chatMessage", "", {}, "^3INFO: ^0Use ^3NUMPAD 8^0 to raise the tow arm and ^3NUMPAD 5^0 to lower the arm. Hold ^3H^0 to release the vehicle. Press ^3E^0 to toggle light bar.")
		Wait(3000)
	else
		TriggerEvent("chatMessage", "", {}, "^3INFO: ^0Use ^3/tow^0 when near a vehicle to load/unload it from the flatbed.")
		Wait(3000)
	end
	TriggerEvent("chatMessage", "", {}, "^3INFO: ^0You can order parts from the parts store and install them by 'using' them in your inventory near a vehicle (must be lvl 2 mechanic).")
	Wait(3000)
	TriggerEvent("chatMessage", "", {}, "^3INFO: ^0You can use the repair kit that is in your truck to repair vehicles.")
end

function isNearSignOnSpot(range)
	local mycoords = GetEntityCoords(PlayerPedId())
	for name, info in pairs(locations) do
		if Vdist(mycoords, info.duty.x, info.duty.y, info.duty.z) < (range or 5) then
			return true
		end
	end
	return false
end
