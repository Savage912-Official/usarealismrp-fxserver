local currentMapBlips = {}

RegisterNetEvent("businesses:addMapBlip")
AddEventHandler("businesses:addMapBlip", function(coords)
	local b = AddBlipForCoord(coords[1], coords[2], coords[3])
	SetBlipSprite(b, 40)
	SetBlipDisplay(b, 4)
	SetBlipScale(b, 0.75)
	SetBlipColour(b, 24)
	SetBlipAsShortRange(b, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Owned Business')
	EndTextCommandSetBlipName(b)
	table.insert(currentMapBlips, b)
end)

RegisterNetEvent("businesses:addMapBlips")
AddEventHandler("businesses:addMapBlips", function(mapBlipData)
	RemoveBlips()
	for name, coords in pairs(mapBlipData) do
        local b = AddBlipForCoord(coords[1], coords[2], coords[3])
        SetBlipSprite(b, 40)
        SetBlipDisplay(b, 4)
        SetBlipScale(b, 0.75)
		SetBlipColour(b, 24)
        SetBlipAsShortRange(b, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Owned Business')
        EndTextCommandSetBlipName(b)
        table.insert(currentMapBlips, b)
    end
end)

function RemoveBlips()
    for i = 1, #currentMapBlips do
        RemoveBlip(currentMapBlips[i])
    end
end

-- ROB ON KEY HOLD --
Citizen.CreateThread(function()
	while true do
		if IsControlJustPressed(0, KEYS.K) then
			local me = PlayerPedId()
			Wait(500)
			if IsControlPressed(0, KEYS.K) then
				local closestStore = GetClosestStore(1.5)
				if closestStore and not BUSINESSES[closestStore].notRobbable then
					if IsPedArmed(me, 7) then
						if not isRobbingStore then
							local isMale = true
							if GetEntityModel(me) == GetHashKey("mp_f_freemode_01") then
								isMale = false
							elseif GetEntityModel(me) == GetHashKey("mp_m_freemode_01") then 
								isMale = true
							else
								isMale = IsPedMale(me)
							end
							TriggerServerEvent('business:beginRobbery', closestStore, isMale, GetNumberOfPlayers())
						end
					else
						exports.globals:notify("I am not intimidated!")
					end
				end
			end
		end
		Wait(0)
	end
end)

-- OPEN MENU ON KEY PRESS --
Citizen.CreateThread(function()
	while true do
		if IsControlJustPressed(0, KEYS.E) then
			local closestStore = GetClosestStore(1.5)
			if closestStore and BUSINESSES[closestStore].price then
				Wait(500)
				if IsControlPressed(0, KEYS.E) then
					TriggerServerEvent("business:lease", closestStore)
	      		else
	        		TriggerServerEvent("business:tryOpenMenuByName", closestStore)
				end
				Wait(1000)
			end
		end
    Wait(0)
	end
end)

local NEARBY_BUSINESSES = {}

-- thread to record nearby businesses as an optimization
Citizen.CreateThread(function()
	while true do
		for name, data in pairs(BUSINESSES) do
			local location = data.position
			local mycoords = GetEntityCoords(PlayerPedId())
			if #(mycoords - vector3(location[1], location[2], location[3])) < 4 then
				NEARBY_BUSINESSES[name] = true
			else
				NEARBY_BUSINESSES[name] = nil
			end
		end
		Wait(1000)
	end
end)

-- DRAW 3D TEXT  --
Citizen.CreateThread(function()
	while true do
		for name, isNearby in pairs(NEARBY_BUSINESSES) do
			local data = BUSINESSES[name]
			local pos = data.position
			if not data.notRobbable then
				DrawText3D(pos[1], pos[2], pos[3], '[E] - Business Menu | [HOLD K] - Rob')
			else
				DrawText3D(pos[1], pos[2], pos[3], '[E] - Business Menu')
			end
		end
		Wait(1)
	end
end)

-- Get closest store within given range or nil if not close to any --
function GetClosestStore(range)
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)
  for name, data in pairs(BUSINESSES) do
    local pos = data.position
    if #(vector3(playerCoords.x, playerCoords.y, playerCoords.z) - vector3(pos[1], pos[2], pos[3])) < range then
      return name
    end
  end
	return nil
end

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
  end