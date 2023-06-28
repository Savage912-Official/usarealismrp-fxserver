local xSound = exports.xsound

local bankCoords = {
	{ coords = { x = 252.95, y = 228.60, z = 102.00 }, name = "Pacific Standard", camID = "bank1", timeToTapSeconds = 5 }, -- pacific standard
}

local clerkCoords = {x = 253.57, y = 221.05, z = 106.28}

local STOP_ALARM_BUTTON = vector3(264.82235717773, 219.84594726563, 101.68328094482)
local ALARM_COORDS = vector3(257.08541870117, 220.17054748535, 106.28491210938)

local currentlyHacking = nil
local mainHacking = nil
local VaultDoor = nil

local startedFinalHack = false

local KEY_K = 311
local drilling_spots = {}
local openVault = false

local mainHackLocation = {x = 265.06, y = 213.79, z = 101.68}

local shouldBePlayingAnim = false
local clearedAnim = false
local dictLoaded = false
local DRILLING = {
	ANIM = {
		DICT = "anim@heists@fleeca_bank@drilling",
		NAME = "drill_straight_idle"
	},
	OBJECT = {
		NAME = "hei_prop_heist_drill",
		handle = nil
	}
}

local shouldBeShowingHelpText = false

local GUARDS = {
	{
		model = `s_m_m_security_01`,
		weapon = `WEAPON_HEAVYPISTOL`,
		pos = vector3(257.84271240234, 205.50750732422, 110.28303527832),
		heading = 79.0
	},
	{
		model = `s_m_m_security_01`,
		weapon = `WEAPON_HEAVYPISTOL`,
		pos = vector3(236.15869140625, 213.71444702148, 110.2829208374),
		heading = 79.0
	},
	{
		model = `s_m_m_security_01`,
		weapon = `WEAPON_HEAVYPISTOL`,
		pos = vector3(265.85189819336, 219.23295593262, 110.28303527832),
		heading = 79.0
	},
	{
		model = `s_m_m_security_01`,
		weapon = `WEAPON_HEAVYPISTOL`,
		pos = vector3(267.16900634766, 218.59368896484, 110.28303527832),
		heading = 294.0
	},
}

local isInsideBank = false

local hackPasses = 0
local hackAttempts = 0

local didAskForCashCartData = false

local carts = {} 
local safes = {}

RegisterNetEvent('bank:loadDrillingSpots')
AddEventHandler('bank:loadDrillingSpots', function(spots)
	drilling_spots = spots
end)

TriggerServerEvent('bank:loadDrillingSpots')


local hacked = false
Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		for i = 1, #bankCoords do
			local dist = Vdist(playerCoords, bankCoords[i].coords.x, bankCoords[i].coords.y, bankCoords[i].coords.z)
			if dist < 50.0 then
				if not VaultDoor or not DoesEntityExist(VaultDoor) then
					VaultDoor = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 100.0, 961976194, 0, 0, 0)
					if DoesEntityExist(VaultDoor) then
						FreezeEntityPosition(VaultDoor, true)
					end
				end
				if dist < 5.0 then
					DrawText3D(bankCoords[i].coords.x, bankCoords[i].coords.y, bankCoords[i].coords.z, '[HOLD K] - Rob Bank')
					if IsControlJustPressed(0, 311) then
						Citizen.CreateThread(function()
							Wait(500)
							if IsControlPressed(0, 311) then
								TriggerServerEvent('bank:beginRobbery', bankCoords[i])
							end
						end)
					end
				end
			end
		end

		local clerkDist = Vdist(playerCoords, clerkCoords.x, clerkCoords.y, clerkCoords.z)
		if clerkDist < 5.0 then
			DrawText3D(clerkCoords.x, clerkCoords.y, clerkCoords.z, '[E] - Bank Clerk')
			if IsControlJustPressed(0, 38) and clerkDist < 2.0 then
				TriggerServerEvent('bank:clerkTip')
			end
		end

		for i = 1, #drilling_spots do
			local dist = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, drilling_spots[i].x, drilling_spots[i].y, drilling_spots[i].z)
			if dist < 1 then
				exports.globals:DrawText3D(drilling_spots[i].x, drilling_spots[i].y, drilling_spots[i].z, '[K] - Drill Deposit Box')
				if IsControlJustPressed(0, KEY_K) then
					local hasDoorBeenThermited = TriggerServerCallback {
						eventName = "bank:hasDoorBeenThermited",
						args = {}
					}
					if hasDoorBeenThermited then
						while securityToken == nil do
							Wait(1)
						end
						TriggerServerEvent('bank:doesUserHaveDrill', i, securityToken)
					end
				end
			end
		end

		local alarmButtonDist = #(playerCoords - STOP_ALARM_BUTTON)
		if alarmButtonDist < 2.5 then
			DrawText3D(STOP_ALARM_BUTTON.x, STOP_ALARM_BUTTON.y, STOP_ALARM_BUTTON.z, '[E] - Stop Alarm')
			if IsControlJustPressed(0, 38) then
				TriggerServerEvent("bank:toggleAlarm", false)
			end
		end
		Wait(1)
	end
end)

---------------
-- mini game --
---------------
RegisterNetEvent("bank:startHacking")
AddEventHandler("bank:startHacking", function(bank)
	hackPanel()
end)

-- vault stuff --
RegisterNetEvent('bank:openVaultDoor')
AddEventHandler('bank:openVaultDoor', function()
	openVault =  true
end)

RegisterNetEvent('bank:resetVault')
AddEventHandler('bank:resetVault', function()
	local playerCoords = GetEntityCoords(PlayerPedId())
	VaultDoor = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 100.0, 961976194, 0, 0, 0)
	if DoesEntityExist(VaultDoor) then
		SetEntityHeading(VaultDoor, 160.0)
		FreezeEntityPosition(VaultDoor, true)
	end
	openVault =  false
end)

Citizen.CreateThread(function()
	while true do
		if openVault then
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			for i = 1, #bankCoords do
				local dist = Vdist(playerCoords, bankCoords[i].coords.x, bankCoords[i].coords.y, bankCoords[i].coords.z)
				if dist < 30.0 then
					if DoesEntityExist(VaultDoor) then
						local CurrentHeading = GetEntityHeading(VaultDoor)
						if round(CurrentHeading, 1) == 158.7 then
							CurrentHeading = CurrentHeading - 0.1
						end

						while round(CurrentHeading, 1) ~= 0.0 do -- slowly open door
							Wait(0)
							SetEntityHeading(VaultDoor, round(CurrentHeading, 1) - 0.4)
							CurrentHeading = GetEntityHeading(VaultDoor)
						end

						FreezeEntityPosition(VaultDoor, true)
					else
						VaultDoor = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 100.0, 961976194, 0, 0, 0)
					end
				end
			end
		end
		Wait(0)
	end
end)

-- functions --
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
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

function DisplayHelpText(Text)
	SetTextComponentFormat('STRING')
    AddTextComponentString(Text)
    DisplayHelpTextFromStringLabel(0, 0, true, -1)
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function GetIsControlPressed(Control)
	if IsControlPressed(1, Control) or IsDisabledControlPressed(1, Control) then
		return true
	end
	return false
end

RegisterNetEvent('bank:startDrilling')
AddEventHandler('bank:startDrilling', function(boxIndex)
	local box = drilling_spots[boxIndex]
	TaskTurnPedToFaceCoord(PlayerPedId(), box.x, box.y, box.z, 2000)
	Wait(2000)
	shouldBePlayingAnim = true
	TriggerEvent("Drilling:Start", function(success)
		if success then
			while securityToken == nil do
				Wait(1)
			end
			TriggerServerEvent('bank:drilledGoods', securityToken)
		else
			exports.globals:notify("The drill bit is too hot!")
		end
		shouldBePlayingAnim = false
	end)
	shouldBeShowingHelpText = true
	TriggerEvent('InteractSound_CL:PlayWithinDistance', PlayerId(), 10.0, "drill", 0.5)
end)

Citizen.CreateThread(function()
	while true do
		if shouldBePlayingAnim then
			if not dictLoaded then
				exports.globals:loadAnimDict(DRILLING.ANIM.DICT)
				dictLoaded = true
			end
			local myped = PlayerPedId()
			if not IsEntityPlayingAnim(myped, DRILLING.ANIM.DICT, DRILLING.ANIM.NAME, 3) then
				TaskPlayAnim(myped, DRILLING.ANIM.DICT, DRILLING.ANIM.NAME, 2.0, 2.0, -1, 51, 0, false, false, false)
				clearedAnim = false
			end
			if not DRILLING.OBJECT.handle then
				giveDrillObject(myped)
			end
		else
			if not clearedAnim then
				local myped = PlayerPedId()
				ClearPedTasksImmediately(myped)
				clearedAnim = true
			end
			if DRILLING.OBJECT.handle then
				DeleteObject(DRILLING.OBJECT.handle)
				DRILLING.OBJECT.handle = nil
			end
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		if shouldBeShowingHelpText and shouldBePlayingAnim then
			DisplayHelpText('Tap ~INPUT_CELLPHONE_LEFT~ to Slow Down the Drill, ~INPUT_CELLPHONE_RIGHT~ to speed up the drill')
			Wait(8000)
			if not shouldBePlayingAnim then return end
			DisplayHelpText('Tap ~INPUT_CELLPHONE_UP~ to drill the locks, ~INPUT_CELLPHONE_DOWN~ to pull the drill out')
			Wait(8000)
			if not shouldBePlayingAnim then return end
			DisplayHelpText('Cool down the drill by pulling the drill out for a few seconds.')
			Wait(8000)
			if not shouldBePlayingAnim then return end
			shouldBeShowingHelpText = false
		end
		Wait(1)
	end
end)

function giveDrillObject(ped)
	local rightHandBoneId = 57005
	local pedCoords = GetEntityCoords(ped, false)
	local drillObjectHash = GetHashKey(DRILLING.OBJECT.NAME)
	RequestModel(drillObjectHash)
	while not HasModelLoaded(drillObjectHash) do
		Wait(100)
	end
	DRILLING.OBJECT.handle = CreateObject(drillObjectHash, pedCoords.x, pedCoords.y, pedCoords.z+0.2,  true,  true, true)
	SetEntityAsMissionEntity(DRILLING.OBJECT.handle, true, true)
	AttachEntityToEntity(DRILLING.OBJECT.handle, ped, GetPedBoneIndex(ped, rightHandBoneId), 0.15, 0.0, -0.05, 100.0, -90.0, 150.0, true, true, false, true, 1, true)
end

RegisterClientCallback {
	eventName = "bank:useThermite",
	eventCallback = function(door)
		meltDoor(door)
		return true
	end
}

function meltDoor(door)
	local playerPedId = PlayerPedId()
    dasvidania = false

    Citizen.CreateThread(function()
        local timer = GetGameTimer() + 6700
        while timer >= GetGameTimer() do
            if(IsPedDeadOrDying(playerPedId) and not dasvidania)then

                dasvidania = true

                while (bag == nil or scene == nil)do
                    Citizen.Wait(100)
                end

                NetworkStopSynchronisedScene(scene)
                DeleteObject(bag)
            end
            Wait(100)
        end
    end)

    SetCurrentPedWeapon(playerPedId, `WEAPON_UNARMED`, true)
    
    Citizen.Wait(500)

    while 
    (
    IsEntityPlayingAnim(playerPedId, "reaction@intimidation@cop@unarmed", "intro", 3) or
    IsEntityPlayingAnim(playerPedId, "reaction@intimidation@1h", "outro", 3)
    ) 
    do
        Citizen.Wait(100)
    end

    RequestNamedPtfxAsset("scr_ornate_heist")

    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")

    RequestModel("hei_p_m_bag_var22_arm_s")

    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
        Citizen.Wait(100)
    end

    while not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
        Citizen.Wait(100)
    end

    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(100)
    end

    SetEntityHeading(playerPedId, door.anim.h)

    Citizen.Wait(200)

    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(playerPedId)))

    scene = NetworkCreateSynchronisedScene(door.anim.x, door.anim.y, door.anim.z, rotx, roty, rotz + door.anim.extra, 2, false, false, 1065353216, 0, 1.3)

    bag = CreateObject(`hei_p_m_bag_var22_arm_s`, door.anim.x, door.anim.y, door.anim.z,  true,  true, false)

    SetEntityCollision(bag, false, true)

    NetworkAddPedToSynchronisedScene(playerPedId, scene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)

    local prevComponentVariation = GetPedDrawableVariation(playerPedId, 5)
    SetPedComponentVariation(playerPedId, 5, 0, 0, 0)

    NetworkStartSynchronisedScene(scene)

    Citizen.Wait(2000)

    if(not dasvidania)then
        local x, y, z = table.unpack(GetEntityCoords(playerPedId))
        thermite = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)

        --SetEntityCollision(thermite, true, false)
        
        AttachEntityToEntity(thermite, playerPedId, GetPedBoneIndex(playerPedId, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)

        Citizen.Wait(4000)

        DeleteObject(bag)
        SetPedComponentVariation(playerPedId, 5, prevComponentVariation, 0, 0)
        DetachEntity(thermite, 1, 1)
        --FreezeEntityPosition(thermite, true)

		TriggerServerEvent("pacificBankRobbery:server:thermiteEffect", door)
        
        NetworkStopSynchronisedScene(scene)
		
        Citizen.Wait(30000)
        
        DeleteObject(thermite)

    end

end

RegisterNetEvent('pacificBankRobbery:client:thermiteEffect')
AddEventHandler('pacificBankRobbery:client:thermiteEffect', function(door)
    Citizen.CreateThread(function()
		local myped = PlayerPedId()

		RequestNamedPtfxAsset("scr_ornate_heist")
	
		while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
			Citizen.Wait(10)
		end
		
		SetPtfxAssetNextCall("scr_ornate_heist")

		local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", door.thermitefx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

		Citizen.CreateThread(function()

			local animating = false
	
			while effect ~= nil do
				Citizen.Wait(100)
				local mycoords = GetEntityCoords(PlayerPedId())
				if(#(mycoords - door.thermitefx) < 2.5)then
					if(not animating)then
						animating = true

						while #(mycoords - door.thermitefx) < 2.5 do
							mycoords = GetEntityCoords(PlayerPedId())
							Citizen.Wait(100)
							if not IsEntityPlayingAnim(myped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop" , 3) then
								TaskPlayAnim(myped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
								TaskPlayAnim(myped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
							end
						end

					end
				else
					if(animating)then
						ClearPedTasks(myped)
						animating = false
					end
				end
			end
	
		end)

		Citizen.Wait(30000)

		AddExplosion(door.thermitefx.x, door.thermitefx.y, door.thermitefx.z, 1, scale, true, false, 0)

		StopParticleFxLooped(effect, 0)
		effect = nil
            
    end)
end)

RegisterNetEvent('bank:toggleAlarm')
AddEventHandler('bank:toggleAlarm', function(doPlay)
	local soundID = "bank-alarm-" .. PlayerId()
	if doPlay then
		xSound:PlayUrlPos(soundID,"https://www.mboxdrive.com/store-alarm.mp3", 0.1, ALARM_COORDS, true)
		xSound:Distance(soundID, 30)
	else
		xSound:Destroy(soundID)
	end
end)

RegisterNetEvent('bank:makeGuardsAggressive')
AddEventHandler('bank:makeGuardsAggressive', function()
	makeGuardsAggressive(true)
end)

RegisterNetEvent('bank:spawnGuards')
AddEventHandler('bank:spawnGuards', function(alsoMakeAggressive)
	spawnGuards()
	if alsoMakeAggressive then
		TriggerServerEvent("bank:makeGuardsAggressiveForAll")
	end
end)

local Pacific = PolyZone:Create({
    vector2(232.71, 211.31),
    vector2(229.84, 218.54),
    vector2(250.70, 274.82),
    vector2(298.05, 258.32),
    vector2(275.69, 196.06)
}, {
    name = "Pacific",
    debugGrid = false,
    maxZ = 115.61,
    gridDivisions = 45
})

Pacific:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
		TriggerServerEvent("bank:getSafeData")
		isInsideBank = true
    else
		isInsideBank = false
		makeGuardsAggressive(false)
		for i = 1, #safes do
			if DoesEntityExist(safes[i].handle) then
				DeleteObject(safes[i].handle)
			end
		end
		safes = {}
	end
end)

local PacificVault = PolyZone:Create({
    vector2(255.32051086426, 222.8811340332),
	vector2(251.59022521973, 224.24731445313),
	vector2(247.59226989746, 217.11033630371),
	vector2(266.07070922852, 210.73509216309),
	vector2(267.40737915039, 216.49540710449)
}, {
    name = "PacificVault",
    debugGrid = false,
    maxZ = 115.61
})

PacificVault:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
		if not carts[1] then
			TriggerServerEvent("bank:getCashCartData")
		end
    else
		for i = 1, #carts do
			DeleteObject(carts[i].handle)
		end
		carts = {}
	end
end)

RegisterNetEvent("bank:gotCashCartData")
AddEventHandler("bank:gotCashCartData", function(cartData)
	for i = 1, #cartData do
		if not carts[i] then
			if not cartData[i].stolen then
				RequestModel(`hei_prop_hei_cash_trolly_01`)
				while not HasModelLoaded(`hei_prop_hei_cash_trolly_01`) do
					Citizen.Wait(100)
				end
				cartData[i].handle = CreateObject(`hei_prop_hei_cash_trolly_01`, cartData[i].x, cartData[i].y, cartData[i].z, false, false, false)
				if not cartData[i].rotation then
					cartData[i].rotation = 0.00
				end
				SetEntityHeading(cartData[i].handle,GetEntityHeading(cartData[i].handle)+getRotation(0.144 + cartData[i].rotation))
			else
				RequestModel(`prop_gold_trolly`)
				while not HasModelLoaded(`prop_gold_trolly`) do
					Citizen.Wait(100)
				end
				cartData[i].handle = CreateObject(`prop_gold_trolly`, cartData[i].x, cartData[i].y, cartData[i].z, false, false, false)
				if not cartData[i].rotation then
					cartData[i].rotation = 0.00
				end
				SetEntityHeading(cartData[i].handle,GetEntityHeading(cartData[i].handle)+getRotation(0.144 + cartData[i].rotation))
			end
			table.insert(carts, cartData[i])
		end
	end
end)

RegisterNetEvent('bank:swapCartModel')
AddEventHandler('bank:swapCartModel', function(cartData)
	CreateModelSwap(cartData.x, cartData.y, cartData.z, 0.5, `hei_prop_hei_cash_trolly_01`, `prop_gold_trolly`, true)
end)

function makeGuardsAggressive(toggle)
	if toggle then
		if isInsideBank then
			local guardModel = GetHashKey("s_m_m_security_01")
			local p = PlayerPedId()
			local mycoords = GetEntityCoords(p)
			SetPedRelationshipGroupHash(p, GetHashKey("PLAYER"))
			AddRelationshipGroup('bankSecurity')
			SetRelationshipBetweenGroups(0, GetHashKey("bankSecurity"), GetHashKey("bankSecurity"))
			SetRelationshipBetweenGroups(5, GetHashKey("bankSecurity"), GetHashKey("PLAYER"))
			SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("bankSecurity"))
			local MAX_DIST = 100
			for ped in exports.globals:EnumeratePeds() do
				local pedModel = GetEntityModel(ped)
				if pedModel == guardModel then
					local dist = Vdist(GetEntityCoords(ped), mycoords)
					if dist < MAX_DIST then
						SetPedRelationshipGroupHash(ped, GetHashKey("bankSecurity"))
					end
				end
			end
		end
	else
		SetRelationshipBetweenGroups(0, GetHashKey("bankSecurity"), GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("bankSecurity"))
	end
end

function spawnGuards()
	for i = 1, #GUARDS do
		local guard = GUARDS[i]
		RequestModel(guard.model)
		while not HasModelLoaded(guard.model) do
			Wait(1)
		end
		local ped = CreatePed(4, guard.model, guard.pos.x, guard.pos.y, guard.pos.z, guard.heading, true, true)
		NetworkRegisterEntityAsNetworked(ped)
		SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(ped), true)
		SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(ped), true)
		SetPedCanSwitchWeapon(ped, true)
		SetPedArmour(ped, 100)
		SetPedAccuracy(ped, math.random(70,90))
		SetEntityInvincible(ped, false)
		SetEntityVisible(ped, true)
		SetEntityAsMissionEntity(ped)
		GiveWeaponToPed(ped, guard.weapon, 255, false, false)
		SetPedDropsWeaponsWhenDead(ped, false)
		SetPedFleeAttributes(ped, 0, false)	
		SetPedRelationshipGroupHash(ped, GetHashKey("bankSecurity"))
	end
end

function getRotation(input)
	return 360/(10*input)
end

function hackPanel()

	local me = PlayerPedId()

    SetCurrentPedWeapon(me, `WEAPON_UNARMED`, true)

    Citizen.Wait(500)

    while 
    (
    IsEntityPlayingAnim(me, "reaction@intimidation@cop@unarmed", "intro", 3) or
    IsEntityPlayingAnim(me, "reaction@intimidation@1h", "outro", 3)
    ) 
    do
        Citizen.Wait(100)
    end

    local targetPosition, targetRotation = (vec3(GetEntityCoords(me))), vec3(GetEntityRotation(me))

    RequestAnimDict("anim@heists@ornate_bank@hack")

    while not HasAnimDictLoaded("anim@heists@ornate_bank@hack") do
        Citizen.Wait(100)
    end

	local HACK_COORDS = vector3(253.25367736816, 228.12664794922, 101.68327331543)
	local HACK_HEADING = 70.0

    local animation = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@hack", "hack_enter", HACK_COORDS.x, HACK_COORDS.y, HACK_COORDS.z, HACK_COORDS.x, HACK_COORDS.y, HACK_COORDS.z, 0, 2)

    local animation2 = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@hack", "hack_loop", HACK_COORDS.x, HACK_COORDS.y, HACK_COORDS.z, HACK_COORDS.x, HACK_COORDS.y, HACK_COORDS.z, 0, 2)

    local animation3 = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@hack", "hack_exit", HACK_COORDS.x, HACK_COORDS.y, HACK_COORDS.z, HACK_COORDS.x, HACK_COORDS.y, HACK_COORDS.z, 0, 2)

    SetEntityHeading(me, HACK_HEADING)

    Citizen.Wait(100)

    FreezeEntityPosition(me, true)

    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_prop_heist_card_hack_02")

    while not HasModelLoaded("hei_p_m_bag_var22_arm_s") or not HasModelLoaded("hei_prop_hst_laptop") or not HasModelLoaded("hei_prop_heist_card_hack_02")do
        Citizen.Wait(100)
    end

    local scene = NetworkCreateSynchronisedScene(animation, targetRotation, 2, false, false, 1065353216, 0, 1.3)

    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)

    local laptop = CreateObject(`hei_prop_hst_laptop`, targetPosition, 1, 1, 0)

    local card = CreateObject(`hei_prop_heist_card_hack_02`, targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(me, scene, "anim@heists@ornate_bank@hack", "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene, "anim@heists@ornate_bank@hack", "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, scene, "anim@heists@ornate_bank@hack", "hack_enter_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, scene, "anim@heists@ornate_bank@hack", "hack_enter_card", 4.0, -8.0, 1)

    local scene2 = NetworkCreateSynchronisedScene(animation2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(me, scene2, "anim@heists@ornate_bank@hack", "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@heists@ornate_bank@hack", "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, scene2, "anim@heists@ornate_bank@hack", "hack_loop_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, scene2, "anim@heists@ornate_bank@hack", "hack_loop_card", 4.0, -8.0, 1)

    local scene3 = NetworkCreateSynchronisedScene(animation3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(me, scene3, "anim@heists@ornate_bank@hack", "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@heists@ornate_bank@hack", "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, scene3, "anim@heists@ornate_bank@hack", "hack_exit_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, scene3, "anim@heists@ornate_bank@hack", "hack_exit_card", 4.0, -8.0, 1)

    local prevComponentVariation = GetPedDrawableVariation(me, 5)
    SetPedComponentVariation(me, 5, 0, 0, 0)

    Citizen.Wait(200)
    NetworkStartSynchronisedScene(scene)
    Citizen.Wait(6000)
    NetworkStartSynchronisedScene(scene2)
    Citizen.Wait(500)
    
    local timer = 0
	while(timer <= 15000 and not IsPedDeadOrDying(me))do
		
		local mycoords = GetEntityCoords(me)
		DrawText3D(mycoords.x, mycoords.y, mycoords.z+0.10, "[X] - Cancel")
		DrawText3D(mycoords.x, mycoords.y, mycoords.z, "Running pacificHack.exe - " .. round(timer / 150, 1) .. "%")
		timer = timer + math.random(4, 8)

		local X_KEY = 73
		if IsControlJustPressed(1, X_KEY) then
			Citizen.Wait(1500)
			NetworkStartSynchronisedScene(scene3)
			Citizen.Wait(4600)
			NetworkStopSynchronisedScene(scene3)
			DeleteObject(bag)
			DeleteObject(laptop)
			DeleteObject(card)
			FreezeEntityPosition(me, false)
			SetPedComponentVariation(me, 5, prevComponentVariation, 0, 0)
			return
		end

		Citizen.Wait(5)
	end

	TriggerEvent("mhacking:seqstart", {3, 2, 1}, 60, function(pass, timeRemaining)
		hackAttempts = hackAttempts + 1
		if pass then
			hackPasses = hackPasses + 1
		end
		if hackAttempts >= 3 then
			Citizen.Wait(1500)
			NetworkStartSynchronisedScene(scene3)
			Citizen.Wait(4600)
			NetworkStopSynchronisedScene(scene3)
		
			DeleteObject(bag)
			DeleteObject(laptop)
			DeleteObject(card)
		
			FreezeEntityPosition(me, false)
			SetPedComponentVariation(me, 5, prevComponentVariation, 0, 0)

			if pass then
				while securityToken == nil do
					Wait(1)
				end
				TriggerServerEvent("bank:vaultDoorHacked", securityToken)
			end
		end
		if not pass and DoesEntityExist(bag) then
			Citizen.Wait(1500)
			NetworkStartSynchronisedScene(scene3)
			Citizen.Wait(4600)
			NetworkStopSynchronisedScene(scene3)
			DeleteObject(bag)
			DeleteObject(laptop)
			DeleteObject(card)
			FreezeEntityPosition(me, false)
			SetPedComponentVariation(me, 5, prevComponentVariation, 0, 0)
		end
	end)
	

end

Citizen.CreateThread(function()
	local E_KEY = 38
	while true do
		if isInsideBank and carts[1] then
			for i = 1, #carts do
				local dist = #(GetEntityCoords(PlayerPedId()) - vector3(carts[i].x, carts[i].y, carts[i].z))
				if dist <= 2 then
					-- draw 3d text
					DrawText3D(carts[i].x - 0.5, carts[i].y + 0.2, carts[i].z + 1.0, '[E] - Grab')
					-- listen for keypress
					if IsControlJustPressed(0, E_KEY) then
						local hasDoorBeenThermited = TriggerServerCallback {
							eventName = "bank:hasDoorBeenThermited",
							args = {}
						}
						if hasDoorBeenThermited then
							stealCash(carts[i])
						end
					end
				end
			end
		end
		Wait(1)
	end
end)

function stealCash(cart)

	local hasBeenStolen = TriggerServerCallback {
		eventName = "bank:isCartLooted",
		args = {cart, true}
	}

	if hasBeenStolen then
		exports.globals:notify("Already taken!")
		return
	end

	local me = PlayerPedId()

    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_hei_cash_trolly_01")

    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") or not HasModelLoaded("hei_prop_hei_cash_trolly_01") do
        Citizen.Wait(100)
    end

    local targetPosition, targetRotation = (vec3(cart.x, cart.y, cart.z+0.49)), vec3(GetEntityRotation(cart.rotation))
    local animPos = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@grab_cash", "grab", targetPosition, targetRotation, 0, 2)

    FreezeEntityPosition(me, true)

    local scene = NetworkCreateSynchronisedScene(targetPosition, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(me, scene, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(cart.handle, scene, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)

    NetworkStartSynchronisedScene(scene)

    local timerStart = GetGameTimer()
	while GetGameTimer() - timerStart < 25000 do
		Wait(1)
	end

    NetworkStopSynchronisedScene(scene)

    DeleteObject(bag)

    FreezeEntityPosition(me, false)

	while securityToken == nil do
		Wait(1)
	end

	TriggerServerEvent("bank:cartLooted", cart, securityToken)
end

RegisterNetEvent("bank:gotSafeData")
AddEventHandler("bank:gotSafeData", function(safeData)
	if not safes[1] then
		for i = 1, #safeData do
			CreateSafe(safeData[i])
			table.insert(safes, safeData[i])
		end
	end
end)

function CreateSafe(safeData)
	local model = ""
	if safeData.stolen then
		model = `bkr_prop_biker_safebody_01a`
	else
		model = `p_v_43_safe_s`
	end
	
	RequestModel(model)
	
    while not HasModelLoaded(model) do
        Citizen.Wait(100)
	end

	if safeData.stolen then
		safeData.handle = CreateObject(model, safeData.stolenX, safeData.stolenY, safeData.z, false, false, false)
	else
		safeData.handle = CreateObject(model, safeData.x, safeData.y, safeData.z, false, false, false)
	end

    SetEntityHeading(safeData.handle,GetEntityHeading(safeData.handle)+getRotation(safeData.rotation))

	FreezeEntityPosition(safeData.handle, true)
end

Citizen.CreateThread(function()
	local E_KEY = 38
	while true do
		if isInsideBank and safes[1] then
			for i = 1, #safes do
				local dist = #(GetEntityCoords(PlayerPedId()) - vector3(safes[i].x, safes[i].y, safes[i].z))
				if dist <= 2 then
					if not safes[i].stolen then
						-- draw 3d text
						if safes[i].text3dX then
							DrawText3D(safes[i].text3dX - 0.5, safes[i].text3dY + 0.2, safes[i].z + 1.0, '[E] - Crack')
						else
							DrawText3D(safes[i].x - 0.5, safes[i].y + 0.2, safes[i].z + 1.0, '[E] - Crack')
						end
						-- listen for keypress
						if IsControlJustPressed(0, E_KEY) and not cracking then
							local hasDoorBeenThermited = TriggerServerCallback {
								eventName = "bank:hasDoorBeenThermited",
								args = {}
							}
							local enoughCopsOn = TriggerServerCallback {
								eventName = "bank:areEnoughCopsOn",
								args = {}
							}
							if hasDoorBeenThermited and enoughCopsOn then
								TriggerEvent("pacific_safecracking:loop", i)
							end
						end
					end
				end
			end
		end
		Wait(1)
	end
end)

RegisterNetEvent('bank:safeLooted')
AddEventHandler('bank:safeLooted', function(safeIndex)
	local safeData = safes[safeIndex]
	safeData.stolen = true
	if DoesEntityExist(safeData.handle) then
		DeleteObject(safeData.handle)
	end
	CreateSafe(safeData)
end)

function call911(bank)
	local playerPed = PlayerPedId()
	local x, y, z = table.unpack(GetEntityCoords(playerPed))
	local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
	local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)	
	local isMale = true
	if GetEntityModel(playerPed) == GetHashKey("mp_f_freemode_01") then
	  isMale = false
	elseif GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01") then 
	  isMale = true
	else
	  isMale = IsPedMale(playerPed)
	end
	TriggerServerEvent("911:BankRobbery", x, y, z, lastStreetNAME, isMale, (bank and bank.name or "Pacific Standard Bank"), (bank and bank.camID or "N/A"))
end

exports("getBankCoords", function()
	return vector3(bankCoords[1].coords.x, bankCoords[1].coords.y, bankCoords[1].coords.z)
end)