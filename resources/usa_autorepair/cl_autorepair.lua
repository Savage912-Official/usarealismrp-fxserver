local KEY = 38
local repairingVehicle = false

local REPAIR_TIME = 45000

-----------------------------------------------------------------------
----------------------------GARAGE-LOCATION----------------------------
-----------------------------------------------------------------------

vehicleRepairStation = {
	{536.1182,  -178.5338,  53.08846},
	{2006.354,  3798.739,  30.83191},
	--{128.6394,  6620.741,  30.43497}, -- OG paleto spot v1
	{103.479,  6622.048,  30.8}, -- OG paleto spot v2
	--{1150.1766,  -774.4962,  57.1689},
	--{103.513,  6622.77,  30.1868}, -- paleto
	{-456.078,5984.27,30.0}, -- Paleto Bay SO
	{-355.011,6109.35,30.0},-- Paleto Bay FD
	--{-222.407,-1329.69,30.89},
	{480.805,-1317.43,29.2},
	{201.339, -1656.36, 27.2832}, -- los santos fire department in davis
	{1146.7, -775.8, 56.79},
	{-35.4, -1088.7, 25.55}, -- ls dealership
	--{-10.37, -1662.44, 28.74}, -- mosley dealership
	{-770.68, -231.39, 36.34 } -- rpg performance
}

repairBlips = {
	{536.1182,  -178.5338,  53.08846},
	{2006.354,  3798.739,  30.83191},
	--{128.6394,  6620.741,  30.43497}, -- OG paleto spot v1
	{103.479,  6622.048,  30.8}, -- OG paleto spot v2
	--{1150.1766,  -774.4962,  57.1689},
	--{103.513,  6622.77,  30.1868}, -- paleto
	--{-222.407,-1329.69,30.89},
	{480.805,-1317.43,29.2},
	{1146.7, -775.8, 56.79}
}

RegisterNetEvent("autoRepair:repairVehicle")
AddEventHandler("autoRepair:repairVehicle", function(cost)
	repairingVehicle = true
	local playerPed = PlayerPedId()
	local playerVeh = GetVehiclePedIsIn(playerPed, false)
	local beginTime = GetGameTimer()
	Citizen.CreateThread(function()
		while GetGameTimer() - beginTime < REPAIR_TIME do
			Wait(0)
			SetVehicleEngineOn(playerVeh, false, true, false)
		end
	end)
	while GetGameTimer() - beginTime < REPAIR_TIME do
		Citizen.Wait(0)
		DrawTimer(beginTime, REPAIR_TIME, 1.42, 1.475, 'REPAIRING')
	end
	SetVehicleDirtLevel(playerVeh, 0.0)
	SetVehicleFixed(playerVeh)
	SetVehicleDeformationFixed(playerVeh)
	SetVehicleUndriveable(playerVeh, false)
	repairingVehicle = false
	exports.globals:notify("Vehicle repaired for: $" .. cost)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
		if IsControlJustPressed(0, KEY) and IsPedSittingInAnyVehicle(playerPed) and not repairingVehicle then
			for i = 1, #vehicleRepairStation do
				local repairStation = vehicleRepairStation[i]
				if Vdist(GetEntityCoords(playerPed), repairStation[1], repairStation[2], repairStation[3]) < 3 and GetPedInVehicleSeat(playerVeh, -1) == playerPed and not IsEntityDead(playerPed) then
					local engineHp = GetVehicleEngineHealth(playerVeh)
					local bodyHp = GetVehicleBodyHealth(playerVeh)
					local canBeRepaired = engineHp < 1000.0 or bodyHp < 1000.0
					if canBeRepaired then
						if GetIsVehicleEngineRunning(playerVeh) then
							TriggerEvent('usa:notify', '~y~Vehicle engine must be off!')
						else
							local business = exports["usa-businesses"]:GetClosestStore(15) or ""
							TriggerServerEvent('autoRepair:checkMoney', business, engineHp, bodyHp)
						end
					else
						TriggerEvent('usa:notify', '~y~Your vehicle does not require any repairs!')
					end
				end
			end
		end
		for i = 1, #vehicleRepairStation do
			local repairStation = vehicleRepairStation[i]
			DrawText3D(repairStation[1], repairStation[2], (repairStation[3] + 1.0), 5, '[E] - Auto Repair')
		end
	end
end)


----------------------
---- Set up blips ----
----------------------
for i = 1, #repairBlips do
	local blip = AddBlipForCoord(repairBlips[i][1], repairBlips[i][2], repairBlips[i][3])
	SetBlipSprite(blip, 402)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.9)
	SetBlipColour(blip, 27)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Auto Repair')
	EndTextCommandSetBlipName(blip)
end
-----------------
-----------------
-----------------

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

function GetAllRepairShopCoords()
	return vehicleRepairStation
end