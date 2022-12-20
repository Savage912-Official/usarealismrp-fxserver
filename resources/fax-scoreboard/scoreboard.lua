local OPEN_KEY = 170 -- F3
local NUI_FOCUS_KEY = 25 -- right click

local listOn = false
local nuiFocusOn = false

local fetchingData = false
local lastNuiUnfocusedTime = GetGameTimer()

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlPressed(0, OPEN_KEY) and GetLastInputMethod(0) then
            if not listOn then
                listOn = true
                SendNUIMessage({ text = "" })
                fetchPlayerListData()
                while listOn do
                    ShowIds()
                    Wait(0)
                    if not IsNuiFocused() and not IsControlPressed(0, OPEN_KEY) and GetGameTimer() - lastNuiUnfocusedTime > 1000 then
                        listOn = false
                        SendNUIMessage({
                            meta = 'close'
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
end)

function sanitize(txt)
    local replacements = {
        ['&' ] = '&amp;', 
        ['<' ] = '&lt;', 
        ['>' ] = '&gt;', 
        ['\n'] = '<br/>'
    }
    return txt
        :gsub('[&<>\n]', replacements)
        :gsub(' +', function(s) return ' '..('&nbsp;'):rep(#s-1) end)
end

function ShowIds()
	local viewDistance = 40
	local myCoords = GetEntityCoords(PlayerPedId())
    for id = 0, 255 do
        local playerPed = GetPlayerPed(id)
        local playerCoords = GetEntityCoords(playerPed)
        if NetworkIsPlayerActive(id) and Vdist(playerCoords, myCoords) < viewDistance and IsEntityVisible(playerPed) then
            if NetworkIsPlayerTalking(id) then
                DrawTracerText(tostring(GetPlayerServerId(id)), 1.2, true, playerPed)
            else
                DrawTracerText(tostring(GetPlayerServerId(id)), 1.2, false, playerPed)
            end
        end
    end
end

function DrawTracerText(text, spacing, talking, playerPed)
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local scale = (1/dist)*40
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
        TriggerServerCallback {
            eventName = "playerlist:getData",
            args = {},
            callback = function(data)
                local tableRows = {}
                for i = 1, #data do
                    table.insert(tableRows, 
                    '<tr style=\"color: rgb(' .. 255 .. ', ' .. 255 .. ', ' .. 255 .. ')\"><td>' .. data[i].serverId .. '</td><td>' .. sanitize(data[i].identifier) .. '</td><td>' .. '</td></tr>'
                    )
                end
                SendNUIMessage({ text = table.concat(tableRows) })
                fetchingData = false
            end
        }
    end
end

RegisterNUICallback('removeNuiFocus', function(data, cb)
    SetNuiFocus(false, false)
    nuiFocusOn = false
    lastNuiUnfocusedTime = GetGameTimer()
end)