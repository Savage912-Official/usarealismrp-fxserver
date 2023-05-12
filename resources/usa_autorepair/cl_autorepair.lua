local KEY = 38
local repairingVehicle = false

local REPAIR_TIME = 45000

local EVENT_TRIGGER_DELAY = 2000

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
	-- {201.339, -1656.36, 27.2832}, -- los santos fire department in davis
	{1149.8494, -781.1504, 56.9987}, -- mirror park
	{-35.4, -1088.7, 25.55}, -- ls dealership
	--{-10.37, -1662.44, 28.74}, -- mosley dealership
	{-770.68, -231.39, 36.34}, -- rpg performance
	{58.345020294189, 2789.1938476562, 56.891422271729}, -- harmony
	{965.11193847656, -108.40106964111, 74.363616943359}, -- outlaw biker
	--{830.64587402344, -819.84143066406, 26.332593917847}, -- Otto's Repair
	{126.11426544189, -3022.9548339844, 6.0408930778503}, -- Tuner shop
	{-1417.4580078125, -446.09741210938, 34.90970993042}, -- hayes auto
	{937.69396972656, -970.66680908203, 38.543064117432}, -- autocare garage
	{473.4534, -1882.8077, 25.4803}, -- atomic autos
	{-214.37, -1336.91, 30.3} -- Benny's

}

local locationsData = {}
for i = 1, #vehicleRepairStation do
	table.insert(locationsData, {
		coords = vector3(vehicleRepairStation[i][1], vehicleRepairStation[i][2], vehicleRepairStation[i][3] + 1.0),
		text = "[E] - Auto Repair"
	})
end
exports.globals:register3dTextLocations(locationsData)

repairBlips = {
	{536.1182,  -178.5338,  53.08846},
	{2006.354,  3798.739,  30.83191},
	--{128.6394,  6620.741,  30.43497}, -- OG paleto spot v1
	{103.479,  6622.048,  30.8}, -- OG paleto spot v2
	--{1150.1766,  -774.4962,  57.1689},
	--{103.513,  6622.77,  30.1868}, -- paleto
	--{-222.407,-1329.69,30.89},
	{480.805,-1317.43,29.2},
	-- {1149.8494, -781.1504, 56.9987},
	{-32.622695922852, -1066.1967773438, 27.396472930908},
	-- {58.345020294189, 2789.1938476562, 56.891422271729}, -- harmony
	--{830.64587402344, -819.84143066406, 26.332593917847}, -- Otto's Repair
	{125.62088012695, -3047.0888671875, 7.040892124176}, -- Tuner shop
	{473.4534, -1882.8077, 25.4803} -- atomic autos
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
	TriggerEvent("kq_wheeldamage:fixCar", playerVeh)
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
					local plate = GetVehicleNumberPlateText(playerVeh)
					if canBeRepaired then
						if GetIsVehicleEngineRunning(playerVeh) then
							TriggerEvent('usa:notify', '~y~Vehicle engine must be off!')
						else
							local business = exports["usa-businesses"]:GetClosestStore(15) or ""
							while securityToken == nil do
								Wait(1)
							end
							TriggerServerEvent('autoRepair:checkMoney', plate, (business or false), engineHp, bodyHp, securityToken)
							local begin = GetGameTimer()
							while GetGameTimer() - begin < EVENT_TRIGGER_DELAY do
								Wait(1)
							end
						end
					else
						TriggerEvent('usa:notify', '~y~Your vehicle does not require any repairs!')
					end
				end
			end
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
