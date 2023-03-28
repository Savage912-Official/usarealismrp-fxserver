local z, coords, destinocoords, misioncoords, vehiculo, blip, PlayerJob
local cargado, enMision, carjack, spawneados, entregado = false, false, false, false, false
local guardias = {}
QBCore = nil
ESX = nil

Citizen.CreateThread(function()
	if Config.Framework == 'ESX' then
		ESX = nil
		while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
		while ESX.GetPlayerData().job == nil do
			Citizen.Wait(10)
		end
		PlayerJob = ESX.GetPlayerData().job.name
		ESX.TriggerServerCallback('av_deliveries:zone',function(c,y)
			coords = c
			z = y
			cargado = true
		end)
	elseif Config.Framework == 'QBCORE' then
		QBCore = exports['qb-core']:GetCoreObject()
		QBCore.Functions.TriggerCallback('av_deliveries:zone', function(c,y)
			coords = c
			z = y
			cargado = true
		end)
		QBCore.Functions.GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job.name
        end)
	elseif Config.Framework == 'VRP' then
		vRPsb = Proxy.getInterface("vrp_extended")
		local result = TriggerServerCallback {
			eventName = 'av_deliveries:zone',
			args = {}
		}
		coords = {result[1][1], result[1][2], result[1][3]}
		z = result[2]
		cargado = true
	elseif Config.Framework == 'CUSTOM' then
		local result = TriggerServerCallback {
			eventName = 'av_deliveries:zone',
			args = {}
		}
		coords = {result[1][1], result[1][2], result[1][3]}
		z = result[2]
		cargado = true
	end
end)

Citizen.CreateThread(function()
	while not cargado do
		Citizen.Wait(100)
	end
	while true do
		local w = 1000
		if #(GetEntityCoords(PlayerPedId())- vector3(coords[1], coords[2], coords[3])) < 3 then
			w = 3
			DrawText3Ds(coords[1], coords[2], coords[3], Config.Lang['Door'])
			if IsControlJustPressed(0,38) then
				if enMision then 
					TriggerEvent('av_deliveries:notify', Config.Lang['Busy'])
				else
					FreezeEntityPosition(PlayerPedId(), true)
					Animacion("timetable@jimmy@doorknock@")
					TaskPlayAnim(PlayerPedId(), "timetable@jimmy@doorknock@", "knockdoor_idle", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
					Wait(3500)
					ClearPedTasksImmediately(PlayerPedId())
					FreezeEntityPosition(PlayerPedId(), false)
					Jobs()
				end
			end
		end
		Citizen.Wait(w)
	end
end)

function Jobs()
	local trabajos = {}
	if Config.Framework == 'ESX' then
		ESX.TriggerServerCallback('av_deliveries:cdpersonal', function(cd)
			if not cd then
				ESX.TriggerServerCallback('av_deliveries:jobs',function(jobs,cops)
					for i = 1, #jobs do
						if jobs[i].available and cops >= jobs[i].minCops then
							table.insert(trabajos,{
								id = i, 
								header = jobs[i].jobName, 
								txt = Config.Lang['JobPrice']..''..jobs[i].price, 
								params = {event = 'av_deliveries:start', 
								args = {trabajo = jobs[i], id = i}
								}
							})
						end
					end
					if #trabajos > 0 then
						TriggerEvent('nh-context:sendMenu', trabajos)
					else
						TriggerEvent('av_deliveries:notify', Config.Lang['NoJobs'])
					end
				end)
			else
				TriggerEvent('av_deliveries:notify', Config.Lang['personalcd'])
			end
		end)
	elseif Config.Framework == 'QBCORE' then
		QBCore.Functions.TriggerCallback('av_deliveries:cdpersonal', function(cd)
			if not cd then
				QBCore.Functions.TriggerCallback('av_deliveries:jobs',function(jobs,cops)
					for i = 1, #jobs do
						if jobs[i].available and cops >= jobs[i].minCops then
							table.insert(trabajos,{
								id = i, 
								header = jobs[i].jobName, 
								txt = Config.Lang['JobPrice']..''..jobs[i].price, 
								params = {event = 'av_deliveries:start', 
								args = {trabajo = jobs[i], id = i}
								}
							})
						end
					end
					if #trabajos > 0 then
						TriggerEvent('nh-context:sendMenu', trabajos)
					else
						TriggerEvent('av_deliveries:notify', Config.Lang['NoJobs'])
					end
				end)
			else
				TriggerEvent('av_deliveries:notify', Config.Lang['personalcd'])
			end
		end)
	elseif Config.Framework == 'VRP' then
		local cd = TriggerServerCallback {
			eventName = 'av_deliveries:cdpersonal',
			args = {}
		}
		if not cd then
			local jobs = TriggerServerCallback {eventName = 'av_deliveries:jobs', args = {}}
			local cops = TriggerServerCallback {eventName = 'av_deliveries:cops', args = {}}
			for i = 1, #jobs do
				if jobs[i].available and cops >= jobs[i].minCops then
					table.insert(trabajos,{
						id = i, 
						header = jobs[i].jobName, 
						txt = Config.Lang['JobPrice']..''..jobs[i].price, 
						params = {event = 'av_deliveries:start', 
						args = {trabajo = jobs[i], id = i}
						}
					})
				end
			end
			if #trabajos > 0 then
				TriggerEvent('nh-context:sendMenu', trabajos)
			else
				TriggerEvent('av_deliveries:notify', Config.Lang['NoJobs'])
			end
		else
			TriggerEvent('av_deliveries:notify', Config.Lang['personalcd'])
		end
	elseif Config.Framework == 'CUSTOM' then
		local cd = TriggerServerCallback {
			eventName = 'av_deliveries:cdpersonal',
			args = {}
		}
		if not cd then
			local jobs = TriggerServerCallback {eventName = 'av_deliveries:jobs', args = {}}
			local cops = TriggerServerCallback {eventName = 'av_deliveries:cops', args = {}}
			local menuOptions = {}

			for i = 1, #jobs do
				if jobs[i].available and cops >= jobs[i].minCops then
					table.insert(menuOptions, {
						title = jobs[i].jobName, description = Config.Lang['JobPrice']..''..jobs[i].price, event = 'av_deliveries:start', args = {trabajo = jobs[i], id = i},
					})
					lib.registerContext({
						id = 'trabajos',
						title = 'Available Jobs',
						options = menuOptions
					})
				end
			end
			--if #trabajos > 0 then
				lib.showContext("trabajos")
			--else
			--	TriggerEvent('av_deliveries:notify', Config.Lang['NoJobs'])
			--end
		else
			TriggerEvent('av_deliveries:notify', Config.Lang['personalcd'])
		end
	end
end

RegisterNetEvent('av_deliveries:start')
AddEventHandler('av_deliveries:start', function(x)
	local id = x.id
	local job = x.trabajo	
	if Config.Framework == 'ESX' then	
		ESX.TriggerServerCallback('av_deliveries:pagar', function(p)
			if p then Mision(id,job) end
		end,job.account,job.price)
	elseif Config.Framework == 'QBCORE' then
		QBCore.Functions.TriggerCallback('av_deliveries:pagar', function(p)
			if p then Mision(id,job) end
		end,job.account,job.price)
	elseif Config.Framework == 'VRP' then
		local result = TriggerServerCallback {eventName = 'av_deliveries:pagar', args = {job.account, job.price}}
		if result then Mision(id,job) end
	elseif Config.Framework == 'CUSTOM' then
		local result = TriggerServerCallback {eventName = 'av_deliveries:pagar', args = {job.price}}
		if result then Mision(id,job) end
	end
end)

RegisterNetEvent('av_deliveries:policiablip')
AddEventHandler('av_deliveries:policiablip', function(x, y, z)
	local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
	local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
	TriggerServerEvent('911:call', x, y, z, "Illegal activies in progress) (" .. lastStreetNAME .. ")")
end)

function Mision(id,job)
	local p = PlayerPedId()
	enMision = true
	TriggerServerEvent('av_deliveries:cooldown',id,z)
	TriggerEvent('av_deliveries:notify', Config.Lang['jobStarted'])
	misioncoords = job.vehicleLocation
	destinocoords = job.deliveryLocation	
	blip = AddBlipForCoord(misioncoords.x, misioncoords.y, misioncoords.z)
	SetBlipRoute(blip, true)
	while not spawneados do
		local dist = #(GetEntityCoords(p) - vector3(misioncoords.x, misioncoords.y, misioncoords.z))
		if dist < 200 and not spawneados then
			spawneados = Spawn(job)
			RemoveBlip(blip)
			blip = nil
		end
		Citizen.Wait(50)
		if muerto() then Cancelar() return end
	end
	while not carjack do
		local vehcoords = GetEntityCoords(vehiculo)
		if #(GetEntityCoords(p) - vehcoords) < 3.5 then
			DrawText3Ds(vehcoords.x,vehcoords.y,vehcoords.z+1.0,Config.Lang['lockpick'])
			if IsControlJustPressed(0,74) then
				carjack = true
				Animacion("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
				TaskPlayAnim(p,"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer",1.0, -1.0, -1, 49, 0, 0, 0, 0)
				Citizen.Wait(2000)
				ClearPedTasksImmediately(p)
				SetVehicleDoorsLockedForAllPlayers(vehiculo, false)
				for i = 1, #guardias do
					if IsEntityDead(guardias[i]) then
						SetEntityAsNoLongerNeeded(guardias[i])
					end
				end
			end
		end
		Citizen.Wait(3)
		if muerto() then Cancelar() return end
	end
	entregado = false
	blip = AddBlipForCoord(destinocoords.x, destinocoords.y, destinocoords.z)
	SetBlipRoute(blip, true)
	TriggerEvent('av_deliveries:notify', Config.Lang['Delivery'])
	while not entregado do
		local dist = #(GetEntityCoords(p) - vector3(destinocoords.x, destinocoords.y, destinocoords.z))
		if dist < 5 then
			DrawText3Ds(destinocoords.x, destinocoords.y, destinocoords.z,Config.Lang['Deliver'])
		end
		if IsControlJustPressed(0,38) and dist < 5 and IsPedInAnyVehicle(p, false) then		
			local v = GetVehiclePedIsIn(p, false)
			if v == vehiculo then
				entregado = true
				RemoveBlip(blip)
				blip = nil
				if job.useCutscene then
					LoadCutscene(job.cutscene)
					SetEntityAsNoLongerNeeded(vehiculo)
					DeleteEntity(vehiculo)
					BeginCutsceneWithPlayer()
					Finish()
					RemoveCutscene()
					DoScreenFadeIn(500)			
				else
					SetEntityAsNoLongerNeeded(vehiculo)
					DeleteEntity(vehiculo)
				end				
				TriggerServerEvent('av_deliveries:pago',z,id)
				enMision = false
				spawneados = false
				carjack = false			
			else
				entregado = true
				RemoveBlip(blip)
				blip = nil
				TriggerEvent('av_deliveries:notify', Config.Lang['wrong_veh'])
				Cancelar()
			end
		end
		Citizen.Wait(4)
		if muerto() then Cancelar() return end
	end
end

function Spawn(job)
	SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER"))
	AddRelationshipGroup('Guardias')
	for i = 1, job.guardsToSpawn do
		local n = math.random(1,#job.guardsModels)
		local modelo = job.guardsModels[n]
		local b = math.random(1,#job.guardsWeapons)
		local arma = job.guardsWeapons[b]
		CargarModelo(modelo)
		guardias[i] = CreatePed(4, GetHashKey(modelo), job.guardsLocation[i][1],job.guardsLocation[i][2],job.guardsLocation[i][3], math.random(0,200), true, true)
		SetPedCanSwitchWeapon(guardias[i], true)
		SetPedArmour(guardias[i], 100)
		SetPedAccuracy(guardias[i], math.random(70,90))
		SetEntityInvincible(guardias[i], false)
		SetEntityVisible(guardias[i], true)
		GiveWeaponToPed(guardias[i], GetHashKey(arma), 255, false, false)
		SetPedDropsWeaponsWhenDead(guardias[i], false)
		SetPedFleeAttributes(guardias[i], 0, false)	
		SetPedRelationshipGroupHash(guardias[i], GetHashKey("Guardias"))	
--		TaskGuardCurrentPosition(guardias[i], 5.0, 5.0, 1)
		SetPedAlertness(guardias[i],3)
		Citizen.Wait(100)
		SetRelationshipBetweenGroups(0, GetHashKey("Guardias"), GetHashKey("Guardias"))
		SetRelationshipBetweenGroups(5, GetHashKey("Guardias"), GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("Guardias"))
		SetModelAsNoLongerNeeded(modelo)
	end
	CargarModelo(job.vehicleModel)
	vehiculo = CreateVehicle(GetHashKey(job.vehicleModel),job.vehicleLocation.x, job.vehicleLocation.y, job.vehicleLocation.z, job.vehicleLocation.heading, true, false)
	FreezeEntityPosition(vehiculo, true)
	SetVehicleOnGroundProperly(vehiculo)
	FreezeEntityPosition(vehiculo, false)
	SetEntityAsMissionEntity(vehiculo, true, true)
	SetVehicleDoorsLockedForAllPlayers(vehiculo, true)
	SetVehicleTyresCanBurst(vehiculo, false)
	SetVehicleEngineCanDegrade(vehiculo, false)
	SetModelAsNoLongerNeeded(job.vehicleModel)
	SetPedCanBeTargetted(PlayerPedId(), true)
	SetEntityCanBeTargetedWithoutLos(PlayerPedId(), true)

	if job.callCops then
		TriggerServerEvent('av_deliveries:policia', job.vehicleLocation.x, job.vehicleLocation.y, job.vehicleLocation.z) 
	end
	return true
end

function Cancelar()
	enMision = false
	spawneados = false
	entregado = false
	carjack = false
	if DoesEntityExist(vehiculo) then
		SetEntityAsNoLongerNeeded(vehiculo)
		DeleteEntity(vehiculo)
	end
	if #guardias > 0 then
		for i = 1, #guardias do
			SetEntityAsNoLongerNeeded(guardias[i])
		end
	end
	if blip then
		RemoveBlip(blip)
		blip = nil
	end
	TriggerEvent('av_deliveries:notify', Config.Lang['died'])
end

function muerto()
	if GetEntityHealth(PlayerPedId()) <= 5 then
		return true
	end
	return false
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function Animacion(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
end

function CargarModelo(EntityModel)
	RequestModel(GetHashKey(EntityModel))
	while not HasModelLoaded(GetHashKey(EntityModel)) or not HasCollisionForModelLoaded(GetHashKey(EntityModel)) do
		Wait(1)
	end
end

function Finish(timer)
	local tripped = false
	repeat
		Wait(0)
		if (timer and (GetCutsceneTime() > timer))then
			DoScreenFadeOut(250)
			tripped = true
		end
		if (GetCutsceneTotalDuration() - GetCutsceneTime() <= 250) then
		DoScreenFadeOut(250)
		tripped = true
		end
	until not IsCutscenePlaying()
	if (not tripped) then
		DoScreenFadeOut(100)
		Wait(150)
	end
	return
end

function LoadCutscene(cut, flag1, flag2)
	if (not flag1) then
		RequestCutscene(cut, 8)
	else
		RequestCutsceneEx(cut, flag1, flag2)
	end
	while (not HasThisCutsceneLoaded(cut)) do Wait(0) end
	return
end

function BeginCutsceneWithPlayer()
	local plyrId = PlayerPedId()
		
	local playerClone = ClonePedEx(plyrId, 0.0, false, true, 1)
	local playerClone2 = ClonePedEx(plyrId, 0.0, false, true, 1)
	local playerClone3 = ClonePedEx(plyrId, 0.0, false, true, 1)
	local playerClone4 = ClonePedEx(plyrId, 0.0, false, true, 1)
	local playerClone5 = ClonePedEx(plyrId, 0.0, false, true, 1)

	SetBlockingOfNonTemporaryEvents(playerClone, true)
	SetEntityVisible(playerClone, false, false)
	SetEntityInvincible(playerClone, true)
	SetEntityCollision(playerClone, false, false)
	FreezeEntityPosition(playerClone, true)
	SetPedHelmet(playerClone, false)
	RemovePedHelmet(playerClone, true)

	SetCutsceneEntityStreamingFlags('MP_1', 0, 1)
	RegisterEntityForCutscene(plyrId, 'MP_1', 0, GetEntityModel(plyrId), 64)
	
	SetCutsceneEntityStreamingFlags('MP_2', 0, 1)
	RegisterEntityForCutscene(playerClone2, 'MP_2', 0, GetEntityModel(playerClone2), 64)

	SetCutsceneEntityStreamingFlags('MP_3', 0, 1)
	RegisterEntityForCutscene(playerClone3, 'MP_3', 0, GetEntityModel(playerClone3), 64)
	
	SetCutsceneEntityStreamingFlags('MP_4', 0, 1)
	RegisterEntityForCutscene(playerClone4, 'MP_4', 0, GetEntityModel(playerClone4), 64)
	
	SetCutsceneEntityStreamingFlags('MP_5', 0, 1)
	RegisterEntityForCutscene(playerClone5, 'MP_5', 0, GetEntityModel(playerClone5), 64)
	
	Wait(10)
	StartCutscene(0)
	Wait(10)
	ClonePedToTarget(playerClone, plyrId)
	Wait(10)
	DeleteEntity(playerClone)
	DeleteEntity(playerClone2)
	DeleteEntity(playerClone3)
	DeleteEntity(playerClone4)
	DeleteEntity(playerClone5)
	Wait(50)
	DoScreenFadeIn(250)

  return playerClone
end

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo.name
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerJob = job.name
end)

if Config.Framework == 'VRP' then
	function tvRP.setCop(flag)
		if flag == true then
			PlayerJob = 'police'
		else
			PlayerJob = ''
		end
	end
end