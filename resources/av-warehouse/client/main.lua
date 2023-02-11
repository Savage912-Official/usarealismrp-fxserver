local coordx, coordy, coordz = nil, nil, nil
local currentlyInsideWarehouse, coord = false,false
local a, sC = 0, nil
local guardias = {}
local cajasObj = {}
local PlayerData = {
	job = {
		name = "civ"
	}
}
local m = {
	[1] = 'ex_prop_crate_biohazard_bc', 
	[2] = 'ex_prop_crate_bull_bc_02', 
	[3] = 'ex_prop_crate_elec_bc',
	[4] = 'ex_prop_crate_expl_bc', 
	[5] = 'ex_prop_crate_gems_bc', 
	[6] = 'ex_prop_crate_jewels_bc', 
	[7] = 'ex_prop_crate_med_bc', 
	[8] = 'ex_prop_crate_money_bc',
	[9] = 'ex_prop_crate_narc_bc',
	[10] = 'ex_prop_crate_tob_bc',
	[11] = 'ex_prop_crate_ammo_bc'
}
local doorText = Config.Lang["hack_door"]

Citizen.CreateThread(function()
	local data = TriggerServerCallback {
		eventName = 'av_warehouse:entrada',
		args = {}
	}
	coordx = data.x
	coordy = data.y
	coordz = data.z
	coord  = true
	a = data.n
end)

local crates = {}

Citizen.CreateThread(function()
	local fetchedDoorStatus = false
	while not coord do
		Citizen.Wait(0)
	end
	while true do
		local w = 1000
		local p = PlayerPedId()
		local e = #(GetEntityCoords(p) - vector3(coordx, coordy, coordz))
		local s = #(GetEntityCoords(p) - vector3(1073.03, -3102.28, -38.99))
		if e < 5 then
			w = 5
			if not fetchedDoorStatus then
				fetchedDoorStatus = true
				local hasBeenHacked = TriggerServerCallback {
					eventName = "av_warehouse:hasBeenHacked",
					args = {}
				}
				if hasBeenHacked then
					doorText = Config.Lang["enter"]
				else
					doorText = Config.Lang["hack_door"]
				end
			end
			DrawText3D(coordx, coordy, coordz, doorText)
			if IsControlJustPressed(0,38) and e < 1.5 then		
				-- has already been hacked? (just enter if so, otherwise continue down)
				local hasBeenHacked = TriggerServerCallback{ 
					eventName = 'av_warehouse:hasBeenHacked',
					args = {}
				}
				-- is being hacked right now? (just abort if so, otherwise continue down)
				local isBeingHacked = TriggerServerCallback{ 
					eventName = 'av_warehouse:isBeingHacked',
					args = {}
				}
				-- enough cops and has hack item? (abort if not, otherwise continue down)
				local notEnoughCopsOrNoItem = TriggerServerCallback{ 
					eventName = 'av_warehouse:copAndItemCheck',
					args = {}
				}
				if hasBeenHacked then
					TriggerEvent("av_warehouse:teleport")
				elseif isBeingHacked then
					exports.globals:notify("Already being hacked")
				elseif notEnoughCopsOrNoItem then
					exports.globals:notify("Try again later and make sure you have a cell phone")
				else
					-- start hacking
					TriggerServerEvent("av_warehouse:setIsHacking", true)
					TriggerEvent('av_warehouse:startHacking')
					sC = GetEntityCoords(p)
				end
			end
		else
			fetchedDoorStatus = false
		end
		if s < 2 then
			w = 5
			DrawText3D(1073.03, -3102.28, -38.99, Config.Lang['exit'])
			if IsControlJustPressed(0,38) and s < 1.5 then
				exports["_anticheese"]:Disable()
				if PlayerData.job.name == Config.PoliceJobName then
					if sC ~= nil then
						DoScreenFadeOut(1000)
						Citizen.Wait(1500)
						SetEntityCoords(p,sC)
						SetEntityHeading(p,180.90)
						Citizen.Wait(1000)
						DoScreenFadeIn(1500)
					else
						DoScreenFadeOut(1000)
						Citizen.Wait(1500)
						SetEntityCoords(p, Config.DefaultCoords[1], Config.DefaultCoords[2], Config.DefaultCoords[3])
						Citizen.Wait(1000)
						DoScreenFadeIn(1500)
					end				
				else
					if not currentlyInsideWarehouse then
						DoScreenFadeOut(1000)
						Citizen.Wait(1500)
						SetEntityCoords(p, Config.DefaultCoords[1], Config.DefaultCoords[2], Config.DefaultCoords[3])
						Citizen.Wait(1000)
						DoScreenFadeIn(1500)
					else
						BorrarCajas()
						DoScreenFadeOut(1000)
						Citizen.Wait(1500)
						SetEntityCoords(p,sC)
						SetEntityHeading(p,180.90)
						Citizen.Wait(1000)
						DoScreenFadeIn(1500)
						currentlyInsideWarehouse = false
					end
				end
				exports["_anticheese"]:Enable()
			end
		end	
		Citizen.Wait(w)
	end
end)

function Cajas3D()
	while currentlyInsideWarehouse do
		Citizen.Wait(5)					
		local coords = GetEntityCoords(PlayerPedId())	
		for i = 1, #crates do
			local ca = crates[i]
			if not ca.opened then
				if #(coords - vector3(ca.x,ca.y,ca.z)) < 2 and not ca.abierta then 
					DrawText3D(ca.x,ca.y,ca.z+0.5,Config.Lang['open_crate'])
					if IsControlJustPressed(0, 38) then
						local hasCrowbar = TriggerServerCallback {
							eventName = "av_warehouse:hasCrowbar",
							args = {}
						}
						if hasCrowbar then
							ca.abierta = true
							FreezeEntityPosition(PlayerPedId(),true)
							RequestAnimDict("anim_heist@hs3f@ig14_open_car_trunk@male@")
							while not HasAnimDictLoaded("anim_heist@hs3f@ig14_open_car_trunk@male@") do
								Citizen.Wait(50)
							end
							TaskPlayAnim(PlayerPedId(), "anim_heist@hs3f@ig14_open_car_trunk@male@", "open_trunk_rushed", 1.0, 1.0, -1, 1, 0, 0, 0, 0 )
							Citizen.Wait(3500)
							ClearPedTasksImmediately(PlayerPedId())
							FreezeEntityPosition(PlayerPedId(),false)
							TriggerEvent("av_warehouse:openCrate")
							while securityToken == nil do
								Wait(1)
							end
							TriggerServerEvent('av_warehouse:loot', a, i, securityToken)
						else
							exports.globals:notify("Need crowbar!")
						end
					end					
				end
			end
		end		
	end
end

RegisterNetEvent("av_warehouse:startHacking")
AddEventHandler("av_warehouse:startHacking", function()
	local p = PlayerPedId()
	FreezeEntityPosition(p,true)
	TaskStartScenarioInPlace(p, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
	Citizen.Wait(1500)
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start",Config.HackBlocks,Config.HackTime,hackeoEvent)
end)

function hackeoEvent(success)
	TriggerServerEvent("av_warehouse:setIsHacking", false)
	local p = PlayerPedId()
	TriggerEvent('mhacking:hide')	
	if success then	
		TriggerServerEvent('av_warehouse:hacked')		
		ClearPedTasks(p)
		FreezeEntityPosition(p, false)
		if Config.CallCopsOnSucess then
			if math.random() >= 0.50 then
				local coords = GetEntityCoords(GetPlayerPed(-1), true)
				Citizen.Wait(Config.TimeBeforeAlert * 60 * 1000)
				alertPolice(coords)
			end
		end
	else
		ClearPedTasks(p)
		FreezeEntityPosition(p, false)
		if Config.CallCopsOnFail then
			if math.random() <= 0.25 then
				local coords = GetEntityCoords(GetPlayerPed(-1), true)
				Citizen.Wait(Config.TimeBeforeAlert * 60 * 1000)
				alertPolice(coords)
			end
		end
	end			
end

RegisterNetEvent('av_warehouse:npc')
AddEventHandler('av_warehouse:npc', function()
	ClearAreaOfEverything(1058.38, -3102.17, -38.99, 30.0, true, true, true, true)
	local p = PlayerPedId()
	SetPedRelationshipGroupHash(p, GetHashKey("PLAYER"))
	AddRelationshipGroup('Guardias')
	local x = 0
	for i=1, #Config.Guards do
		local guardia = Config.Guards[i]
		RequestModel(GetHashKey(guardia.ped))
		while not HasModelLoaded(GetHashKey(guardia.ped)) do
			Wait(1)
		end
		guardias[x] = CreatePed(4, GetHashKey(guardia.ped), guardia.pos[1], guardia.pos[2], guardia.pos[3], guardia.pos[4], false, true)
		NetworkRegisterEntityAsNetworked(guardias[x])
		SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(guardias[x]), true)
		SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(guardias[x]), true)
		SetPedCanSwitchWeapon(guardias[x], true)
		SetPedArmour(guardias[x], guardia.armour)
		SetPedAccuracy(guardias[x], math.random(70,90))
		SetEntityInvincible(guardias[x], false)
		SetEntityVisible(guardias[x], true)
		SetEntityAsMissionEntity(guardias[x])
		GiveWeaponToPed(guardias[x], GetHashKey(guardia.weapon), 255, false, false)
		SetPedDropsWeaponsWhenDead(guardias[x], false)
		SetPedFleeAttributes(guardias[x], 0, false)	
		SetPedRelationshipGroupHash(guardias[x], GetHashKey("Guardias"))	
		TaskGuardCurrentPosition(guardias[x], 5.0, 5.0, 1)
		x = x + 1
	end
	Citizen.Wait(1000)
	SetRelationshipBetweenGroups(0, GetHashKey("Guardias"), GetHashKey("Guardias"))
	SetRelationshipBetweenGroups(5, GetHashKey("Guardias"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("Guardias"))
end)

RegisterNetEvent('av_warehouse:loadCrates')
AddEventHandler('av_warehouse:loadCrates', function()
	crates = TriggerServerCallback {
		eventName = "av_warehouse:loadCrates",
		args = {}
	}
	local x = 1
	for i = 1, #crates do
		c = crates[i]
		if c.opened then
			cajasObj[x] = CreateObject(GetHashKey(m[math.random(1,11)]), c.x, c.y, c.z, true, true, true)
		else
			cajasObj[x] = CreateObject(GetHashKey("ex_prop_crate_closed_bc"), c.x, c.y, c.z, true, true, true)
		end
		SetEntityHeading(cajasObj[x], c.h)
		x = x + 1
	end
end)

RegisterNetEvent("av_warehouse:notify")
AddEventHandler("av_warehouse:notify", function(coords)
	if PlayerData.job.name == Config.PoliceJobName then
		exports.globals:notify(Config.Lang['police_notify'])
		blipRobbery = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(blipRobbery, 161)
		SetBlipScale(blipRobbery, 2.0)
		SetBlipColour(blipRobbery, 3)
		PulseBlip(blipRobbery)
		Wait(90000)
		RemoveBlip(blipRobbery)				
	end
end)

RegisterNetEvent("av_warehouse:teleport")
AddEventHandler("av_warehouse:teleport", function()
	exports["_anticheese"]:Disable()
	if hintBlipHandle then
		RemoveBlip(hintBlipHandle)
		hintBlipHandle = nil
	end
	local p = PlayerPedId()
	DoScreenFadeOut(1000)
	Citizen.Wait(1500)
	SetEntityHeading(p, 88.37)
	sC = GetEntityCoords(p)
	SetEntityCoords(p,1071.48, -3102.28, -38.99)	
	currentlyInsideWarehouse = true
	if Config.SpawnGuards then
		local haveAlreadyBeenSpawned = TriggerServerCallback {
			eventName = "av_warehouse:haveGuardsSpawned",
			args = {}
		}
		if not haveAlreadyBeenSpawned then
			-- spawn peds and make aggresive
			TriggerEvent('av_warehouse:npc')
			TriggerServerEvent("av_warehouse:setGuardsSpawned", true)
		else
			-- peds already exist, but we still need to make them aggresive towards the player here
			makeNearbyGuardsAggresive()
		end
	end
	TriggerEvent('av_warehouse:loadCrates')
	Citizen.Wait(1000)
	DoScreenFadeIn(1500)
	exports["_anticheese"]:Enable()
	Cajas3D()
end)

function BorrarCajas()
	for i = 1, #cajasObj do
		DeleteEntity(cajasObj[i])
	end
end

function DrawText3D(x, y, z, text)
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

RegisterNetEvent("av_warehouse:reset")
AddEventHandler("av_warehouse:reset", function(x,y,z)
	coordx = x
	coordy = y
	coordz = z
end)

RegisterNetEvent("av_warehouse:openCrate")
AddEventHandler("av_warehouse:openCrate", function(crateIndex)
	if currentlyInsideWarehouse then
		local c = crates[crateIndex]
		if c then
			CreateModelSwap(c.x, c.y, c.z, 0.5, GetHashKey('ex_prop_crate_closed_bc'), GetHashKey(m[math.random(1, #m)]), true)
		end
	end
end)

RegisterNetEvent("av_warehouse:setDoorText")
AddEventHandler("av_warehouse:setDoorText", function(text)
	doorText = text
end)

function makeNearbyGuardsAggresive()
	local guardPedModel1 = GetHashKey("mp_s_m_armoured_01")
	local guardPedModel2 = GetHashKey("s_m_m_armoured_02")
	local mycoords = GetEntityCoords(PlayerPedId())
	local p = PlayerPedId()
	SetPedRelationshipGroupHash(p, GetHashKey("PLAYER"))
	AddRelationshipGroup('Guardias')
	SetRelationshipBetweenGroups(0, GetHashKey("Guardias"), GetHashKey("Guardias"))
	SetRelationshipBetweenGroups(5, GetHashKey("Guardias"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("Guardias"))
	local MAX_DIST = 100
	for ped in exports.globals:EnumeratePeds() do
		local pedModel = GetEntityModel(ped)
		if pedModel == guardPedModel1 or pedModel == guardPedModel2 then
			local dist = Vdist(GetEntityCoords(ped), mycoords)
			if dist < MAX_DIST then
				SetPedRelationshipGroupHash(ped, GetHashKey("Guardias"))
			end
		end
	end
end

function alertPolice(coords)
	local x, y, z = table.unpack(coords)
	local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
	local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
	TriggerServerEvent('911:call', x, y, z, "Warehouse burglary alarm triggered (" .. lastStreetNAME .. ")", "Warehouse Burglary")
end

exports("getWarehouseLocations", function()
	local locations = TriggerServerCallback {
		eventName="av-warehouse:getLocations",
		args = {}
	}
	return locations
end)