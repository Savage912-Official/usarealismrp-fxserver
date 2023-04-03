local DROPPED_ITEMS = {}
local E_KEY = 246
local NEARBY_DROPPED_ITEM_POLL_INTERVAL_SECONDS = 0.5
local NEARBY_DROPPED_ITEM_RANGE = 100

local nearbyDroppedItems = {}

RegisterNetEvent("interaction:getDroppedItems")
AddEventHandler("interaction:getDroppedItems", function(items)
  DROPPED_ITEMS = items
  for i = 1, #DROPPED_ITEMS do
    if DROPPED_ITEMS[i].objectModel then
      local objectHash = GetHashKey(DROPPED_ITEMS[i].objectModel)
      local handle = CreateObject(objectHash, DROPPED_ITEMS[i].coords.x, DROPPED_ITEMS[i].coords.y, DROPPED_ITEMS[i].coords.z, false, false, false)
      DROPPED_ITEMS[i].objectHandle = handle
    end
  end
end)

TriggerServerEvent("interaction:getDroppedItems")

RegisterNetEvent("interaction:addDroppedItem")
AddEventHandler("interaction:addDroppedItem", function(item)
  if item.objectModel then
    local handle = CreateObject(GetHashKey(item.objectModel), item.coords.x, item.coords.y, item.coords.z, false, false, false)
    SetEntityAsMissionEntity(handle, true, true)
    local heading = item.coords.h
    if (heading == nil) then
      heading = GetEntityHeading(PlayerPedId())
    end
    SetEntityHeading(handle, heading)
    PlaceObjectOnGroundProperly(handle)
    item.objectHandle = handle
  end
  table.insert(DROPPED_ITEMS, item)
end)

RegisterNetEvent("interaction:removeDroppedItem")
AddEventHandler("interaction:removeDroppedItem", function(index)
  if DROPPED_ITEMS[index] then
    if DROPPED_ITEMS[index].objectModel and DROPPED_ITEMS[index].objectHandle then
      DeleteObject(DROPPED_ITEMS[index].objectHandle)
    end
    table.remove(DROPPED_ITEMS, index)
  end
end)

RegisterNetEvent("interaction:finishedPickupAttempt")
AddEventHandler("interaction:finishedPickupAttempt", function()
  attemptingPickup = false
end)

RegisterNetEvent("interaction:dropMultiple")
AddEventHandler("interaction:dropMultiple", function(items)
  for i = 1, #items do
    items[i].objectHandle = SpawnObjectModel(items[i])
    table.insert(DROPPED_ITEMS, items[i])
  end
end)

Citizen.CreateThread(function()
  local lastPoll = 0
  while true do
    local mycoords = GetEntityCoords(PlayerPedId())
    while GetGameTimer() - lastPoll < NEARBY_DROPPED_ITEM_POLL_INTERVAL_SECONDS * 1000 do
      Wait(1)
    end
    lastPoll = GetGameTimer()
    nearbyDroppedItems = getNearbyDroppedItems(NEARBY_DROPPED_ITEM_RANGE)
  end
end)

Citizen.CreateThread(function()
  while true do
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    for i, isNearby in pairs(nearbyDroppedItems) do
      if DROPPED_ITEMS[i] then
        local item = DROPPED_ITEMS[i]
        if not item.objectModel then
          DrawMarker(27, item.coords.x, item.coords.y, item.coords.z, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 1.0, 240, 30, 140, 100, 0, 0, 2, 0, 0, 0, 0)
        end
        if Vdist(coords.x, coords.y, coords.z, item.coords.x, item.coords.y, item.coords.z) < 3.5 then
          DrawText3Ds(item.coords.x, item.coords.y, item.coords.z + 0.2, 370, 16, '[Y] - ' .. item.name)
          if IsControlJustPressed(1, E_KEY) and not attemptingPickup and not IsPedInAnyVehicle(ped, true) then
            TriggerServerEvent("interaction:attemptPickupWithGUI", coords)
            break
          end
        end
      end
    end
    Wait(1)
  end
end)

function DrawText3Ds(x,y,z,q,a, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    if dist < a then
	    SetTextScale(0.35, 0.35)
	    SetTextFont(4)
	    SetTextProportional(1)
	    SetTextColour(255, 255, 255, 215)
	    SetTextEntry("STRING")
	    SetTextCentre(1)
	    AddTextComponentString(text)
	    DrawText(_x,_y)
	    local factor = (string.len(text)) / q
	    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
	end
end

function SpawnObjectModel(item)
  local handle = nil
  if item.objectModel then
    handle = CreateObject(GetHashKey(item.objectModel), item.coords.x, item.coords.y, item.coords.z, false, false, false)
    SetEntityAsMissionEntity(handle, true, true)
  end
  return handle
end

function getNearbyDroppedItems(range)
  local mycoords = GetEntityCoords(PlayerPedId())
  local nearby = {}
	for i = #DROPPED_ITEMS, 1, -1 do
    local item = DROPPED_ITEMS[i]
		local dist = Vdist(item.coords.x, item.coords.y, item.coords.z, mycoords)
		if dist < range then
      nearby[i] = true
		end
	end
  return nearby
end