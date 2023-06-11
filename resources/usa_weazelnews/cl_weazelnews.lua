local holdingCam = false
local usingCam = false
local holdingMic = false
local usingMic = false
local camModel = "prop_v_cam_01"
local camanimDict = "missfinale_c2mcs_1"
local camanimName = "fin_c2_mcs_1_camman"
local micModel = "prop_microphone_02"
local micanimDict = "missheistdocksprep1hold_cellphone"
local micanimName = "hold_cellphone"
local mic_net = nil
local cam_net = nil
local lastCompletedCall = nil

local CALL_COMPLETE_DIST = 15

--- 911 calls ---
local current_call = {}
local mute_calls = false
-----------------

local van_out = false
local locations = {
	["Paleto"] = {
		duty_ped = {
			x = -249.6443,
			y = 6235.7524,
			z = 30.4893,
			heading = 180.0,
			model = "a_m_y_business_01"
		},
		van_garage = {
			x = -244.5831,
			y = 6238.2236,
			z = 30.4895,
			heading = -138.0
		}
	},
	["Los Santos"] = {
		duty_ped = {
			x = -588.72094726563,
			y = -936.03741455078,
			z = 23.877563476563,
			heading = 10.0,
			model = "a_m_y_business_01"
		},
		van_garage = {
			x = -620.3,
			y = -924.0,
			z = 23.1,
			heading = -170.0
		}
	}
}

local isCheckPlateDone = false
local isNewsVan = false
RegisterNetEvent("weazelnews:checkPlateDone")
AddEventHandler("weazelnews:checkPlateDone", function(returnVal)
	isNewsVan = returnVal
	isCheckPlateDone = true
end)

---------------------------------------------------------------------------
-- Toggling Cam --
---------------------------------------------------------------------------
RegisterNetEvent("weazelnews:ToggleCam")
AddEventHandler("weazelnews:ToggleCam", function()
	if holdingMic then
		TriggerEvent("usa:notify", "You are already holding a microphone!")
		return
	end

	local targetVehicle = getVehicleInFrontOfUser()
	local plate = GetVehicleNumberPlateText(targetVehicle)
	TriggerServerEvent("weazelnews:checkPlate", plate)
	while not isCheckPlateDone do
		Citizen.Wait(100)
	end
	isCheckPlateDone = false

	--local weazelNewsVanHash = 1162065741

    if not holdingCam then
		if not isNewsVan and not isPlayerAtWeazelNewsGarage() then
			TriggerEvent("usa:notify", "You must be at a Weazel News van or the Weazel News garage to pull out a camera!")
			return
		end
        RequestModel(GetHashKey(camModel))
        while not HasModelLoaded(GetHashKey(camModel)) do
            Citizen.Wait(100)
        end

        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        local camspawned = CreateObject(GetHashKey(camModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        Citizen.Wait(1000)
        local netid = ObjToNet(camspawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(camspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        -- 50 = 32 + 16 + 2
        TaskPlayAnim(GetPlayerPed(PlayerId()), camanimDict, camanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
        cam_net = netid
        holdingCam = true
		DisplayNotification("Press ~INPUT_PICKUP~ to enter camera mode")
    else
		if not isNewsVan and not isPlayerAtWeazelNewsGarage() then
			TriggerEvent("usa:notify", "You must be at a Weazel News van or the Weazel News garage to put away your camera!")
			return
		end
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(cam_net), 1, 1)
        DeleteEntity(NetToObj(cam_net))
        cam_net = nil
        holdingCam = false
        usingCam = false
        camera = false
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if holdingCam then
			while not HasAnimDictLoaded(camanimDict) do
				RequestAnimDict(camanimDict)
				Citizen.Wait(100)
			end

			if not IsEntityPlayingAnim(PlayerPedId(), camanimDict, camanimName, 3) then
				TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
				TaskPlayAnim(GetPlayerPed(PlayerId()), camanimDict, camanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
			end
		end
	end
end)

---------------------------------------------------------------------------
-- Cam Functions --
---------------------------------------------------------------------------

local fov_max = 70.0
local fov_min = 5.0
local zoomspeed = 10.0
local speed_lr = 8.0
local speed_ud = 8.0

local camera = false
local fov = (fov_max+fov_min)*0.5

---------------------------------------------------------------------------
-- Threads --
---------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed)

		if holdingCam and IsControlJustReleased(1, 38) then
			camera = true

			SetTimecycleModifier("default")

			SetTimecycleModifierStrength(0.3)

			local scaleform = RequestScaleformMovie("security_camera")
			local scaleform2 = RequestScaleformMovie("breaking_news")


			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end
			while not HasScaleformMovieLoaded(scaleform2) do
				Citizen.Wait(10)
			end

			local vehicle = GetVehiclePedIsIn(playerPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

			AttachCamToEntity(cam, playerPed, 0.0,0.0,1.0, true)
			SetCamRot(cam, 2.0,1.0,GetEntityHeading(playerPed))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunction(scaleform2, "breaking_news")
			PopScaleformMovieFunctionVoid()

			while camera and not IsEntityDead(playerPed) and (GetVehiclePedIsIn(playerPed) == vehicle) and true do
				if IsControlJustPressed(0, 177) then
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					camera = false
				end

				SetEntityRotation(playerPed, 0, 0, new_z,2, true)

				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam, zoomvalue)

				HandleZoom(cam)
				HideHUDThisFrame()

				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				DrawScaleformMovie(scaleform2, 0.5, 0.63, 1.0, 1.0, 255, 255, 255, 255)

				local camHeading = GetGameplayCamRelativeHeading()
				local camPitch = GetGameplayCamRelativePitch()
				if camPitch < -70.0 then
					camPitch = -70.0
				elseif camPitch > 42.0 then
					camPitch = 42.0
				end
				camPitch = (camPitch + 70.0) / 112.0

				if camHeading < -180.0 then
					camHeading = -180.0
				elseif camHeading > 180.0 then
					camHeading = 180.0
				end
				camHeading = (camHeading + 180.0) / 360.0

				Citizen.InvokeNative(0xD5BB4025AE449A4E, playerPed, "Pitch", camPitch)
				Citizen.InvokeNative(0xD5BB4025AE449A4E, playerPed, "Heading", camHeading * -1.0 + 1.0)

				--RenderFirstPersonCam(true, 0, 3)
				Citizen.Wait(10)
			end

			camera = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false, false, 0, 1, 0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
		end
	end
end)

-- S P A W N  J O B  P E D S
local createdJobPeds = {}
Citizen.CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId(), false)
		for name, data in pairs(locations) do
			if Vdist(data.duty_ped.x, data.duty_ped.y, data.duty_ped.z, playerCoords.x, playerCoords.y, playerCoords.z) < 60 then
				if not createdJobPeds[name] then
					local hash = GetHashKey(data.duty_ped.model)
					RequestModel(hash)
					while not HasModelLoaded(hash) do
						RequestModel(hash)
						Citizen.Wait(0)
					end
					local ped = CreatePed(4, hash, data.duty_ped.x, data.duty_ped.y, data.duty_ped.z, data.duty_ped.heading, false, true)
					SetEntityCanBeDamaged(ped,false)
					SetPedCanRagdollFromPlayerImpact(ped,false)
					TaskSetBlockingOfNonTemporaryEvents(ped,true)
					SetPedFleeAttributes(ped,0,0)
					SetPedCombatAttributes(ped,17,1)
					SetPedRandomComponentVariation(ped, true)
					TaskStartScenarioInPlace(ped, "WORLD_HUMAN_AA_SMOKE", 0, true)
					createdJobPeds[name] = ped
				end
			else 
				if createdJobPeds[name] then
					DeletePed(createdJobPeds[name])
					createdJobPeds[name] = nil
				end
			end
		end
		Wait(1)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		if IsControlJustPressed(0, 38) then
			local playerCoords = GetEntityCoords(playerPed)
			for locationName, data in pairs(locations) do
				if Vdist(playerCoords, data.duty_ped.x, data.duty_ped.y, data.duty_ped.z) < 3 then
					TriggerServerEvent('weazelnews:toggleDuty')
				elseif Vdist(playerCoords, data.van_garage.x, data.van_garage.y, data.van_garage.z) < 4 then
					if IsPedInAnyVehicle(playerPed) then
						local playerVeh = GetVehiclePedIsIn(playerPed, false)
						TriggerServerEvent('weazelnews:verifyReturnVan', GetVehicleNumberPlateText(playerVeh))
					else
						TriggerServerEvent('weazelnews:verifySpawnVan', locationName)
					end
				end
			end
		end
		for locationName, data in pairs(locations) do
			DrawText3D(data.duty_ped.x, data.duty_ped.y, data.duty_ped.z, 10, '[E] - On/Off Duty (~y~Weazel News~s~)')
			DrawText3D(data.van_garage.x, data.van_garage.y, data.van_garage.z, 20, '[E] - Garage (~y~Weazel News~s~)')
		end
	end
end)

function ClearCurrentCall(dist)
	TriggerServerEvent('weazelnews:completeCall', dist)
	RemoveBlip(current_call.handle)
	lastCompletedCall = current_call
	current_call = {}
end

RegisterNetEvent('weazelNews:cancelCall')
AddEventHandler('weazelNews:cancelCall', function()
	ClearCurrentCall()
end)

Citizen.CreateThread(function()
	while true do
		if current_call.handle then
			local playerCoords = GetEntityCoords(PlayerPedId())
			local player = current_call.player_coords
			local call = current_call.call_coords
			if Vdist(playerCoords, call[1], call[2], call[3]) < CALL_COMPLETE_DIST then
				Wait(10000)
				if Vdist(playerCoords, call[1], call[2], call[3]) < CALL_COMPLETE_DIST then
					local dist = Vdist(player[1], player[2], player[3], call[1], call[2], call[3])
					ClearCurrentCall(dist)
				end
			end
		end
		Wait(5000)
	end
end)

RegisterNetEvent('character:setCharacter')
AddEventHandler('character:setCharacter', function()
		--- 911 calls ---
	local current_call = {}
	local mute_calls = false
	-----------------

	local van_out = false
end)

---------------------------------------------------------------------------
-- Events --
---------------------------------------------------------------------------

RegisterClientCallback {
	eventName = "news:clientCheck",
	eventCallback = function()
		if lastCompletedCall and lastCompletedCall.call_coords then
			local x = lastCompletedCall.call_coords[1]
			local y = lastCompletedCall.call_coords[2]
			local z = lastCompletedCall.call_coords[3]
			local dist = #(GetEntityCoords(PlayerPedId()) - vector3(x, y, z))
			if dist <= CALL_COMPLETE_DIST then
				return true
			else
				return false
			end
		end
	end
}

RegisterNetEvent('weazelnews:911call')
AddEventHandler('weazelnews:911call', function(string, x, y, z, blipText)
	local pX, pY, pZ = table.unpack(GetEntityCoords(PlayerPedId()))
	if not mute_calls and not current_call.handle and Vdist(pX, pY, pZ, x, y, z) > 20 then
		TriggerEvent("chatMessage", "", { 0, 0, 0 }, "^3^*[SCANNER] ^r^7"..string)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'demo', 0.1)
		current_call.handle = AddBlipForCoord(x, y, z)
		SetBlipSprite(current_call.handle, 304)
		SetBlipDisplay(current_call.handle, 2)
		SetBlipScale(current_call.handle, 1.2)
		SetBlipColour(current_call.handle, 29)
		SetBlipAsShortRange(current_call.handle, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(blipText)
		EndTextCommandSetBlipName(current_call.handle)
        current_call.created_at = GetGameTimer()	
        current_call.call_coords = {x, y, z}
        current_call.player_coords = {pX, pY, pZ}
        current_call.name = blipText
	end
end)

-- Activate camera
RegisterNetEvent('camera:Activate')
AddEventHandler('camera:Activate', function()
	camera = not camera
end)

--FUNCTIONS--
function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	local lPed = GetPlayerPed(-1)
	if not ( IsPedSittingInAnyVehicle( lPed ) ) then

		if IsControlJustPressed(0,241) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	end
end

function DrawSpecialText(m_text)
  	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(250, 1)
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
    local factor = (string.len(text)) / 430
    DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
  end
end

---------------------------------------------------------------------------
-- Toggling Mic --
---------------------------------------------------------------------------
RegisterNetEvent("weazelnews:ToggleMic")
AddEventHandler("weazelnews:ToggleMic", function()
	if holdingCam then
		TriggerEvent("usa:notify", "You are already holding a camera!")
		return
	end

	local targetVehicle = getVehicleInFrontOfUser()
	local plate = GetVehicleNumberPlateText(targetVehicle)
	TriggerServerEvent("weazelnews:checkPlate", plate)
	while not isCheckPlateDone do
		Citizen.Wait(100)
	end
	isCheckPlateDone = false

	--local weazelNewsVanHash = 1162065741

    if not holdingMic then
		if not isNewsVan and not isPlayerAtWeazelNewsGarage() then
			TriggerEvent("usa:notify", "You must be at a Weazel News van or Weazel News garage to pull out a microphone!")
			return
		end
        RequestModel(GetHashKey(micModel))
        while not HasModelLoaded(GetHashKey(micModel)) do
            Citizen.Wait(100)
        end

		while not HasAnimDictLoaded(micanimDict) do
			RequestAnimDict(micanimDict)
			Citizen.Wait(100)
		end

        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        local micspawned = CreateObject(GetHashKey(micModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        Citizen.Wait(1000)
        local netid = ObjToNet(micspawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(micspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), 0.08, 0.03, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        TaskPlayAnim(GetPlayerPed(PlayerId()), micanimDict, micanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
        mic_net = netid
        holdingMic = true
    else
		if not isNewsVan and not isPlayerAtWeazelNewsGarage() then
			TriggerEvent("usa:notify", "You must be at a Weazel News van or Weazel News garage to put away your microphone!")
			return
		end
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(mic_net), 1, 1)
        DeleteEntity(NetToObj(mic_net))
        mic_net = nil
        holdingMic = false
        usingMic = false
    end
end)

RegisterNetEvent("weazelnews:spawnVan")
AddEventHandler("weazelnews:spawnVan", function(locationName, plate)
	print("Weazel News van spawned!")
	Citizen.CreateThread(function()
		local numberHash = 0x4543B74D
        RequestModel(numberHash)
		while not HasModelLoaded(numberHash) do
			Citizen.Wait(100)
		end
		local coords = locations[locationName].van_garage
		local vehicle = CreateVehicle(numberHash, coords.x, coords.y, coords.z, coords.heading, true, false)
		TriggerEvent('persistent-vehicles/register-vehicle', vehicle)
		SetVehicleOnGroundProperly(vehicle)
		SetVehRadioStation(vehicle, "OFF")
		SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
		SetVehicleNumberPlateText(vehicle, plate)
		SetEntityAsMissionEntity(vehicle, true, true)
		SetVehicleLivery(vehicle, 0)

		local vehicle_key = {
			name = "Key -- " .. GetVehicleNumberPlateText(vehicle),
			quantity = 1,
			type = "key",
			owner = "Weazel News",
			make = "Vapid",
			model = "Van",
			plate = GetVehicleNumberPlateText(vehicle)
		}

		-- give key to owner
		TriggerServerEvent("garage:giveKey", vehicle_key)
		TriggerServerEvent('mdt:addTempVehicle', 'Bravado Rumpo (Weazel News)', "Weazel News Inc.", GetVehicleNumberPlateText(vehicle))
	end)
end)

RegisterNetEvent("weazelnews:returnVan")
AddEventHandler("weazelnews:returnVan", function()
	local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	if veh then
		TriggerEvent('persistent-vehicles/forget-vehicle', veh)
		DeleteVehicle(veh)
	end
end)

RegisterNetEvent("weazelnews:notify")
AddEventHandler("weazelnews:notify", function(message)
	SetNotificationTextEntry("STRING")
	SetNotificationMessage("CHAR_BARRY", "CHAR_BARRY", true, 1, "Weazel News", message)
	DrawNotification(0,1)
end)

function DisplayNotification(string)
	SetTextComponentFormat("STRING")
	AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function getVehicleInFrontOfUser()
	local playerped = GetPlayerPed(-1)
	local coordA = GetEntityCoords(playerped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)
	return targetVehicle
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function isPlayerAtWeazelNewsGarage()
	local playerCoords = GetEntityCoords(GetPlayerPed(-1), false)
	for locationName, data in pairs(locations) do
		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, data.van_garage.x, data.van_garage.y, data.van_garage.z, true) < 3 then
			return true
		end
	end

	return false
end