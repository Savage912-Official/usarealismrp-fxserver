local BASE_PAY = 450

local DELIVERY_LOCATIONS = {
	{x = 92.51, y = 187.70, z = 105.26},
	{x = -969.79, y = -266.51, z = 38.54},
	{x = -992.74, y = -281.59, z = 38.18},
	{x = -1468.50, y= -398.31, z = 38.52},
	{x = -1566.01, y= -231.44, z = 49.46},
	{x = -1368.00, y = -647.18, z = 28.69},
	{x = -1399.43, y = -657.82, z = 28.67},
	{x = -1331.22, y = -739.83, z = 25.26},
	{x = -1357.83, y = -750.14, z = 22.16},
	{x = -1306.35, y = -801.77, z = 17.56},
	{x = -1286.91, y = -833.40, z = 17.09},
	{x = -1257.44, y = -1149.91, z = 7.60},
	{x = -1169.93, y = -1170.87, z = 5.62},
	{x = -1185.98, y= -1385.85, z = 4.62},
	{x = -1146.99, y = -1562.04, z = 4.4},
	{x = -1376.80, y = -913.27, z = 10.35},
	{x = -1314.63, y = -602.79, z = 29.38},
	{x = -1291.52, y = -280.35, z = 38.66},
	{x = -1321.17, y = -184.70, z = 49.97},
	{x = -1406.36, y = -253.62, z = 46.37},
	{x = -720.48, y = -424.24, z = 35.04},
	{x = 121.71, y= -239.95, z = 53.35},
	{x = 332.78, y = -180.64, z = 58.18},
	{x = 263.56, y = -309.62, z = 49.64},
	{x = 499.70, y = -652.06, z = 24.90},
	{x = 727.47, y = -777.88, z = 25.42},
	{x = 866.53, y = -967.46, z = 27.86},
	{x = 844.75, y = -1059.35, z = 28.31},
	{x = 896.49, y = -1036.31, z = 35.11},
	{x = 951.96, y = -1059.47, z = 37.06},
	{x = 724.90, y = -1189.87, z = 24.27},
	{x = 734.25, y = -1311.18, z = 26.99},
	{x = 746.90, y = -1399.38, z = 26.62},
	{x = 724.20, y = -697.28, z = 28.53},
	{x = 983.39, y = -1503.64, z = 31.51},
	{x = 981.07, y = -1705.99, z = 31.22},
	{x = 948.55, y = -1733.54, z = 31.64},
	{x = 981.32, y = -1805.71, z = 35.48},
	{x = 743.94, y = -1797.35, z = 29.29},
	{x = 849.33, y = -1937.99, z = 30.06},
	{x = 877.40, y = -2043.31, z = 31.58},
	{x = 1014.27, y = -2151.00, z = 31.61},
	{x = 853.29, y = -2207.53, z = 30.67},
	{x = 523.65, y = -1966.42, z = 26.54},
	{x = 459.82, y = -1869.54, z = 27.10},
	{x = 420.30, y = -2064.32, z = 22.13},
	{x = 188.91, y = -2019.11, z = 18.28},
	{x = 485.72, y = -1477.00, z = 29.28},
	{x = 216.23, y = -1462.22, z = 29.32},
	{x = -41.18, y = -1748.09, z = 29.56},
	{x = -326.44, y = -1300.56, z = 31.35},
	{x = -174.26, y = -1273.19, z = 32.59},
	{x = -45.31, y = -1290.08, z = 29.20},
	{x = -7.07, y = -1295.51, z = 29.34},
	{x = 106.41, y = -1280.93, z = 29.26},
	{x = 168.20, y = -1299.32, z = 29.37},
	{x = 366.22, y = -1250.87, z = 32.70},
	{x = 34.76, y = -1032.78, z = 29.50},
	{x = 30.15, y = -900.75, z = 29.96},
	{x = 328.46, y = -994.44, z = 29.31},
	{x = 372.88, y = -737.72, z = 29.27},
	{x = 1951.44, y = 3825.18, z = 32.16},
	{x = 1386.67, y = 3622.75, z = 35.01},
	{x = 1358.81, y = 3614.37, z = 34.88},
	{x = 906.34, y = 3655.02, z = 32.56},
	{x = 2467.88, y = 4100.83, z = 38.06},
	{x = 2510.44, y = 4214.50, z = 39.93},
	{x = 2531.17, y = 4114.46, z = 38.74},
	{x = 1702.85, y = 4917.17, z = 42.22},
	{x = 1701.14, y = 4865.64, z = 42.01},
	{x = 1698.26, y = 4836.88, z = 41.93},
	{x = 1646.55, y = 4844.14, z = 42.01},
	{x = 1644.54, y = 4858.02, z = 42.01},
	{x = 1639.51, y = 4879.42, z = 42.14},
	{x = 64.12, y = 6309.59, z = 31.49},
	{x = -39.05, y = 6420.52, z = 31.68},
	{x = -29.93, y = 6457.99, z = 31.45},
	{x = 17.96, y = 6512.31, z = 31.64},
	{x = -8.48, y = 6487.27, z = 31.51},
	{x = -80.211, y = 6502.14, z = 31.49},
	{x = 440.10, y = -981.14, z = 30.68}
}

local QUIT_JOB_FEE = 200

RegisterServerEvent('gopostal:toggleDuty')
AddEventHandler('gopostal:toggleDuty', function(location)
	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get("job")
	local license = char.getItem("Driver's License")
	if job == "gopostal" then -- sign out
		char.set("job", "civ")
		TriggerClientEvent("gopostal:onDuty", source, false, location)
		TriggerEvent("swayam:RemoveWayPoint_s", source)
	else -- sign in
		if license then
			if license.status ~= "suspended" then
				char.set("job", "gopostal")
				local destinations = GetRandomDestinations(3)
				TriggerClientEvent("gopostal:onDuty", source, true, location, destinations)
			else
				TriggerClientEvent("usa:notify", source, "Your driver's license is ~y~suspended~s~!")
			end
		else
			TriggerClientEvent("usa:notify", source, "You do not have a driver's license!")
		end
	end
end)

RegisterServerEvent('gopostal:payDriver')
AddEventHandler('gopostal:payDriver', function(destination, playerCoords, lastDestination)
	local distance = find_distance(destination.beginAt, destination.endAt)
	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get("job")
	local amountRewarded = math.ceil(BASE_PAY + (0.28 * distance))
	local isReasonableReward = amountRewarded < 50000
	local randomBonus = math.random(0, 300)
	amountRewarded =  amountRewarded + randomBonus
	if isReasonableReward and job == "gopostal" and IsNearDeliveryLocation(playerCoords) then
		char.giveMoney(amountRewarded)
		TriggerClientEvent('usa:notify', source, 'Delivery completed, you have received: ~y~$'..amountRewarded..'.00')
		if lastDestination then
			char.set("job", "civ")
		end
	end
end)

RegisterServerEvent('gopostal:quitJob')
AddEventHandler('gopostal:quitJob', function(src, fee)
	if src then
		source = src
	end
	TriggerClientEvent('gopostal:quitJob', source, fee)
	local char = exports["usa-characters"]:GetCharacter(source)
	char.removeBank(200, "GoPostal Quit Fee")
	TriggerEvent("swayam:RemoveWayPoint_s", source)
end)

RegisterServerEvent('gopostal:getDeliveryLocations')
AddEventHandler('gopostal:getDeliveryLocations', function()
	TriggerClientEvent("gopostal:getDeliveryLocations", source, DELIVERY_LOCATIONS)
end)

TriggerEvent('es:addJobCommand', 'quitdelivery', { "gopostal" }, function(source, args, char)
	char.removeBank(QUIT_JOB_FEE, "GoPostal Quit Fee")
	TriggerEvent('gopostal:quitJob', source, QUIT_JOB_FEE)
end, {
	help = "Forcefully quit the current GoPostal job"
})

function GetRandomDestinations(count)
	local d = {}
	for i = 1, count do
		local r = DELIVERY_LOCATIONS[math.random(#DELIVERY_LOCATIONS)]
		if i == count then
			r.last = true
		end
		table.insert(d, r)
	end
	return d
end

function IsNearDeliveryLocation(coords)
	for i = 1, #DELIVERY_LOCATIONS do
		local location = DELIVERY_LOCATIONS[i]
		if find_distance(coords, location) < 70.0 then
			return true
		end
	end
	return false
end

function find_distance(coords1, coords2)
  xdistance =  math.abs(coords1.x - coords2.x)

  ydistance = math.abs(coords1.y - coords2.y)

  zdistance = math.abs(coords1.z - coords2.z)

  return nroot(3, (xdistance ^ 3 + ydistance ^ 3 + zdistance ^ 3))
end

function nroot(root, num)
  return num^(1/root)
end
