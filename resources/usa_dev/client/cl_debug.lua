-- Command --
RegisterCommand("debug", function(source, args, rawCommand)
	local isStaff = TriggerServerCallback {
		eventName = "usa_dev:isStaff",
		args = {}
	}

	if isStaff then
		if args[1] == "vehicle" or args[1] == "veh" then
			TriggerEvent("usa_dev:vehdebug:toggle")
		elseif args[1] == nil then
			TriggerEvent("usa_dev:debug:toggle", source)
		end
	else
		print("You don't have permission to use this!")
	end
end)

-- Regular Debug --
local debugEnabled = false

RegisterNetEvent("usa_dev:debug:toggle")
AddEventHandler("usa_dev:debug:toggle",function()
	debugEnabled = not debugEnabled
    if debugEnabled then
        print("Debug: Enabled")
    else
        print("Debug: Disabled")
    end
end)

function DrawText3Ds(coords, text)
    local onScreen,_x,_y=World3dToScreen2d(coords.x, coords.y, coords.z)
	
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

local objTable = {}

function updateObjTable()
	objTable = {}

	for obj in EnumerateObjects() do
		if obj ~= 0 then
			objTable[#objTable+1] = obj
		end
	end
end

local vehTable = {}

function updateVehTable()
	vehTable = {}
	for veh in EnumerateVehicles() do
		if veh ~= 0 then
			vehTable[#vehTable+1] = veh
		end
	end
end

local pedTable = {}

function updatePedTable()
	pedTable = {}
	for ped in EnumeratePeds() do
		if ped ~= 0 and ped ~= PlayerPedId() then
			pedTable[#pedTable+1] = ped
		end
	end
end

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end

        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()

        if not id or id == 0 then
            disposeFunc(iter)

            return
        end

        local enum = {
            handle = iter,
            destructor = disposeFunc
        }

        setmetatable(enum, entityEnumerator)
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

local relationships = {
	[GetHashKey("PLAYER")] = "PLAYER",
	[GetHashKey("CIVMALE")] = "CIVMALE",
	[GetHashKey("CIVFEMALE")] = "CIVFEMALE",
	[GetHashKey("COP")] = "COP",
	[GetHashKey("SECURITY_GUARD")] = "SECURITY_GUARD",
	[GetHashKey("PRIVATE_SECURITY")] = "PRIVATE_SECURITY",
	[GetHashKey("FIREMAN")] = "FIREMAN",
	[GetHashKey("GANG_1")] = "GANG_1",
	[GetHashKey("GANG_2")] = "GANG_2",
	[GetHashKey("GANG_9")] = "GANG_9",
	[GetHashKey("GANG_10")] = "GANG_10",
	[GetHashKey("AMBIENT_GANG_LOST")] = "AMBIENT_GANG_LOST",
	[GetHashKey("AMBIENT_GANG_MEXICAN")] = "AMBIENT_GANG_MEXICAN",
	[GetHashKey("AMBIENT_GANG_FAMILY")] = "AMBIENT_GANG_FAMILY",
	[GetHashKey("AMBIENT_GANG_BALLAS")] = "AMBIENT_GANG_BALLAS",
	[GetHashKey("AMBIENT_GANG_MARABUNTE")] = "AMBIENT_GANG_MARABUNTE",
	[GetHashKey("AMBIENT_GANG_CULT")] = "AMBIENT_GANG_CULT",
	[GetHashKey("AMBIENT_GANG_SALVA")] = "AMBIENT_GANG_SALVA",
	[GetHashKey("AMBIENT_GANG_WEICHENG")] = "AMBIENT_GANG_WEICHENG",
	[GetHashKey("AMBIENT_GANG_HILLBILLY")] = "AMBIENT_GANG_HILLBILLY",
	[GetHashKey("DEALER")] = "DEALER",
	[GetHashKey("HATES_PLAYER")] = "HATES_PLAYER",
	[GetHashKey("HEN")] = "HEN",
	[GetHashKey("WILD_ANIMAL")] = "WILD_ANIMAL",
	[GetHashKey("SHARK")] = "SHARK",
	[GetHashKey("COUGAR")] = "COUGAR",
	[GetHashKey("NO_RELATIONSHIP")] = "NO_RELATIONSHIP",
	[GetHashKey("SPECIAL")] = "SPECIAL",
	[GetHashKey("MISSION2")] = "MISSION2",
	[GetHashKey("MISSION3")] = "MISSION3",
	[GetHashKey("MISSION4")] = "MISSION4",
	[GetHashKey("MISSION5")] = "MISSION5",
	[GetHashKey("MISSION6")] = "MISSION6",
	[GetHashKey("MISSION7")] = "MISSION7",
	[GetHashKey("MISSION8")] = "MISSION8",
	[GetHashKey("ARMY")] = "ARMY",
	[GetHashKey("GUARD_DOG")] = "GUARD_DOG",
	[GetHashKey("AGGRESSIVE_INVESTIGATE")] = "AGGRESSIVE_INVESTIGATE",
	[GetHashKey("MEDIC")] = "MEDIC",
	[GetHashKey("CAT")] = "CAT",
}

local currentStreetName = ""

local lastTableUpdate = 0
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait(0)
        
		if debugEnabled then
			local ply = PlayerPedId()
            local pos = GetEntityCoords(ply)

			local x, y, z = table.unpack(GetEntityCoords(ply, true))
			
			local plyHeading = GetEntityHeading(ply)
			local attachedEnt = GetEntityAttachedTo(ply)
			local plyHealth = GetEntityHealth(ply)
			local hag = GetEntityHeightAboveGround(ply)
			local plyModel = GetEntityModel(ply)
			local speed = GetEntitySpeed(ply)

			drawTxt(0.2, 0.72, 0.4,0.4,0.30, 
				"\nHeading: " .. plyHeading ..
				"\nCoords: " .. pos ..
				"\nAttached Ent: " .. attachedEnt
				, 255, 255, 255, 255)
			drawTxt(0.2, 0.77, 0.4,0.4,0.30, 
				"\nHealth: " .. plyHealth ..
				"\nH a G: " .. hag .. 
				"\nModel: " .. plyModel ..
				"\nSpeed: " .. speed, 255, 255, 255, 255)
			drawTxt(0.2, 0.84, 0.4,0.4,0.30, 
				"\nFrame Time: " .. GetFrameTime() ..
				"\nStreet: " .. currentStreetName, 255, 255, 255, 255)

			if lastTableUpdate < GetGameTimer() then
				updatePedTable()
				updateVehTable()
				updateObjTable()

				local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(pos.x, pos.y, pos.z, currentStreetHash, intersectStreetHash)
				currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
				lastTableUpdate = GetGameTimer() + 1000
			end
			
			for i = 1, #pedTable do
				local ped = pedTable[i]
				local pedCoords = GetEntityCoords(ped)
				local plyPed = PlayerPedId()
				local plyCoords = GetEntityCoords(plyPed)

				if #(pedCoords - plyCoords) < 15.0 then
					if IsEntityTouchingEntity(plyPed, ped) then
						DrawText3Ds(pedCoords, "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship: " .. relationships[GetPedRelationshipGroupHash(ped)] .. " TOUCHING" )
					else
						DrawText3Ds(pedCoords, "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship: " .. relationships[GetPedRelationshipGroupHash(ped)] )
					end
				end
			end

			for i = 1, #objTable do
				local obj = objTable[i]
				local objCoords = GetEntityCoords(obj)
				local plyPed = PlayerPedId()
				local plyCoords = GetEntityCoords(plyPed)

				if #(objCoords - plyCoords) < 15.0 then
					if IsEntityTouchingEntity(plyPed, obj) then
						DrawText3Ds(objCoords + vector3(0,0,1), "Obj: " .. obj .. " Model: " .. GetEntityModel(obj) .. " IN CONTACT" )
					else
						DrawText3Ds(objCoords + vector3(0,0,1), "Obj: " .. obj .. " Model: " .. GetEntityModel(obj) .. "" )
					end
				end
			end

			for i = 1, #vehTable do
				local veh = vehTable[i]
				local vehCoords = GetEntityCoords(veh)
				local plyPed = PlayerPedId()
				local plyCoords = GetEntityCoords(plyPed)

				if #(vehCoords - plyCoords) < 15.0 then
					if IsEntityTouchingEntity(plyPed, ped) then
						DrawText3Ds(vehCoords + vector3(0,0,1), "Veh: " .. veh .. " Model: " .. GetDisplayNameFromVehicleModel(GetEntityModel(veh)) .. " IN CONTACT" )
					else
						DrawText3Ds(vehCoords + vector3(0,0,1), "Veh: " .. veh .. " Model: " .. GetDisplayNameFromVehicleModel(GetEntityModel(veh)) .. "" )
					end
				end
			end
        else
            Citizen.Wait(500)
        end
    end
end)

-- Vehicle Debug --
local vehdebug
local topSpeed = 0
local countdown0 = 0
local countdown1 = 0
local countdown2 = 0
local count0 = true
local count1 = true
local count2 = true
local mph = 2.236936

RegisterNetEvent("usa_dev:vehdebug:toggle")
AddEventHandler("usa_dev:vehdebug:toggle",function()
	vehdebug = not vehdebug
    if vehdebug then
        print("Vehicle Debug Enabled")
    else
		print("Vehicle Debug Disabled")
    end
end)

Citizen.CreateThread(function()
	while true do 	
		Citizen.Wait(1)
		if vehdebug then
			if IsPedInAnyVehicle(PlayerPedId(), false) then
				ped = PlayerPedId()
				veh = GetVehiclePedIsIn(ped, false)
				vehModel = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
			
				drawTxt(0.2, 0.46, 0.4,0.4,0.30, "Model: " .. vehModel, 255, 255, 255, 255)
				drawTxt(0.2, 0.48, 0.4,0.4,0.30, "Speed: " .. (GetEntitySpeed(veh)*mph), 255, 255, 255, 255)
				
				if GetVehicleCurrentGear(veh) == 0 then currGear = "R" else currGear = GetVehicleCurrentGear(veh) end
				drawTxt(0.2, 0.56, 0.4,0.4,0.30, "Gear: " .. currGear .. "/" .. GetVehicleHighGear(veh), 255, 255, 255, 255)
				
				if (GetVehicleCurrentRpm(veh)*6000) < 1201 then currRPM = 0 else currRPM = (GetVehicleCurrentRpm(veh)*6000) end
				drawTxt(0.2, 0.58, 0.4,0.4,0.30, "RPM: " .. currRPM, 255, 255, 255, 255)

				if topSpeed < (GetEntitySpeed(veh)*mph) then
					topSpeed = (GetEntitySpeed(veh)*mph)
					drawTxt(0.2, 0.60, 0.4,0.4,0.30, "Top Speed: " .. topSpeed, 255, 255, 255, 255)
				elseif topSpeed > (GetEntitySpeed(veh)*mph) then
					drawTxt(0.2, 0.60, 0.4,0.4,0.30, "Top Speed: " .. topSpeed, 255, 255, 255, 255)
				else 
					topSpeed = 0
					drawTxt(0.2, 0.60, 0.4,0.4,0.30, "Top Speed: " .. topSpeed, 255, 255, 255, 255)
				end

				if count0 then
					drawTxt(0.2, 0.62, 0.4,0.4,0.30, "0-45: " .. countdown0 .. "s", 255, 255, 255, 255)
				elseif not count0 then
					drawTxt(0.2, 0.62, 0.4,0.4,0.30, "0-45: " .. countdown0 .. "s", 255, 255, 255, 255)
				end

				if count1 then
					drawTxt(0.2, 0.64, 0.4,0.4,0.30, "0-60: " .. countdown1 .. "s", 255, 255, 255, 255)
				elseif not count1 then
					drawTxt(0.2, 0.64, 0.4,0.4,0.30, "0-60: " .. countdown1 .. "s", 255, 255, 255, 255)
				end

				if count2 then
					drawTxt(0.2, 0.66, 0.4,0.4,0.30, "0-100: " .. countdown2 .. "s", 255, 255, 255, 255)
				elseif not count2 then
					drawTxt(0.2, 0.66, 0.4,0.4,0.30, "0-100: " .. countdown2 .. "s", 255, 255, 255, 255)
				end

				drawTxt(0.2, 0.50, 0.4,0.4,0.30, "Engine: " .. GetVehicleEngineHealth(veh), 255, 255, 255, 255)
				drawTxt(0.2, 0.52, 0.4,0.4,0.30, "Body: " .. GetVehicleBodyHealth(veh), 255, 255, 255, 255)
				drawTxt(0.2, 0.54, 0.4,0.4,0.30, "Tank: " .. GetVehiclePetrolTankHealth(veh), 255, 255, 255, 255)

				drawTxt(0.2, 0.68, 0.4,0.4,0.30, "[C] Fix Vehicle", 255, 255, 255, 255)
				drawTxt(0.2, 0.70, 0.4,0.4,0.30, "[Z] Reset Numbers", 255, 255, 255, 255)
			else
				drawTxt(0.2, 0.72, 0.4,0.4,0.30, "You are not in a vehicle", 255, 255, 255, 255)
			end
			if (IsControlJustReleased(1, 20)) then
				if (GetEntitySpeed(veh)*mph) > 1 then
					print("Numbers reset, but you are still driving")
				else
					print("Numbers reset")
				end
				topSpeed = 0
                countdown0 = 0
				countdown1 = 0
				countdown2 = 0
				count0 = true
				count1 = true
				count2 = true
			end
			if (IsControlJustReleased(1, 26)) then
				SetVehicleBodyHealth(veh, 1000)
				SetVehiclePetrolTankHealth(veh, 1000)
				SetVehicleBodyHealth(veh, 1000)
				SetVehicleFixed(veh)
				SetVehicleDirtLevel(veh, 0)
				print("Fixed vehicle")
			end 
		else
			Citizen.Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if vehdebug then
			if (GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))*mph) > 1 and count1 then
				if (GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))*mph) < 45 then
					countdown0 = (countdown0 + 0.1)
				end

				if (GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))*mph) >= 45 then
					count0 = false
				end
			end

			if (GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))*mph) > 1 and count1 then
				if (GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))*mph) < 60 then
					countdown1 = (countdown1 + 0.1)
				end

				if (GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))*mph) >= 60 then
					count1 = false
				end
			end

			if (GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))*mph) > 1 and count2 then
				if (GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))*mph) < 100 then
					countdown2 = (countdown2 + 0.1)
				end

				if (GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))*mph) >= 100 then
					count2 = false
				end
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25, 0.25)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end