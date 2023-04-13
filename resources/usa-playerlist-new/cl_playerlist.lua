local OPEN_KEY = 170 -- F3
local NUI_FOCUS_KEY = 25 -- right click

local listOn = false
local nuiFocusOn = false

local fetchingData = false
local lastNuiUnfocusedTime = GetGameTimer()

local viewDistance = 40

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlPressed(0, OPEN_KEY) and GetLastInputMethod(0) then
            Wait(100)
            if IsControlPressed(0, OPEN_KEY) and GetLastInputMethod(0) then
                if not listOn then
                    listOn = true
                    SendNUIMessage({ type = "toggle" })
                    fetchPlayerListData()
                    while listOn do
                        Wait(0)
                        ShowIds()
                        if not IsNuiFocused() and not IsControlPressed(0, OPEN_KEY) and GetGameTimer() - lastNuiUnfocusedTime > 1000 then
                            listOn = false
                            SendNUIMessage({
                                type = "toggle"
                            })
                            SetNuiFocus(false, false)
                            nuiFocusOn = false
                            break
                        elseif IsControlJustPressed(0, NUI_FOCUS_KEY) then
                            nuiFocusOn = not nuiFocusOn
                            SetNuiFocus(nuiFocusOn, nuiFocusOn)
                        end

                        if nuiFocusOn then
                            disableMovementControls(true)
                        end
                    end
                end
            end
        end
    end
end)

function ShowIds()
    local currentInCarCounts = {}
	local myCoords = GetEntityCoords(PlayerPedId())
    for id = 0, 255 do
        local playerPed = GetPlayerPed(id)
        local playerCoords = GetEntityCoords(playerPed)
        if NetworkIsPlayerActive(id) and Vdist(playerCoords, myCoords) < viewDistance and IsEntityVisible(playerPed) then
            local spacing = 1.2
            local curPedVeh = GetVehiclePedIsIn(playerPed)
            local vehicleSeat = ""
            if DoesEntityExist(curPedVeh) then
                if not currentInCarCounts[curPedVeh] then
                    currentInCarCounts[curPedVeh] = 0
                end
                spacing = 1.0 + (0.15 * currentInCarCounts[curPedVeh])
                currentInCarCounts[curPedVeh] = currentInCarCounts[curPedVeh] + 1
                if GetPedInVehicleSeat(curPedVeh, -1) == playerPed then
                    vehicleSeat = " (driver)"
                elseif GetPedInVehicleSeat(curPedVeh, 0) == playerPed then
                    vehicleSeat = " (front right)"
                elseif GetPedInVehicleSeat(curPedVeh, 1) == playerPed then
                    vehicleSeat = " (back left)"
                elseif GetPedInVehicleSeat(curPedVeh, 2) == playerPed then
                    vehicleSeat = " (back right)"
                end
            end
            if NetworkIsPlayerTalking(id) then
                DrawTracerText(tostring(GetPlayerServerId(id)) .. vehicleSeat, spacing, true, playerPed, DoesEntityExist(curPedVeh))
            else
                DrawTracerText(tostring(GetPlayerServerId(id)) .. vehicleSeat, spacing, false, playerPed, DoesEntityExist(curPedVeh))
            end
        end
    end
end

function DrawTracerText(text, spacing, talking, playerPed, isInVeh)
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scaleConstant = 40
    if isInVeh then
        scaleConstant = 25
    end
	local scale = (1/dist)*scaleConstant
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov

	SetTextFont(0)
	SetTextProportional(1)
	if talking then
		SetTextColour(0, 0, 255, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	SetDrawOrigin(x, y, z+spacing, 0)
	SetTextScale(0.2*scale, 0.05*scale)
	DrawText(0.0, 0.0)
	ClearDrawOrigin()
end

function disableMovementControls(status)
    DisableControlAction(29, 241, status)
    DisableControlAction(29, 242, status)
    DisableControlAction(0, 1, status)
    DisableControlAction(0, 2, status)
    DisableControlAction(0, 142, status)
    DisableControlAction(0, 106, status)
end

function fetchPlayerListData()
    if not fetchingData then
        fetchingData = true
        local data = TriggerServerCallback {
            eventName = "playerlist:getData",
            args = {}
        }
        SendNUIMessage({ type = "playerData", data = data })
        fetchingData = false
    end
end

RegisterNUICallback('removeNuiFocus', function(data, cb)
    SetNuiFocus(false, false)
    nuiFocusOn = false
    lastNuiUnfocusedTime = GetGameTimer()
end)

RegisterNetEvent("playerlist:setViewDistance")
AddEventHandler("playerlist:setViewDistance", function(dist)
    viewDistance = dist
end)