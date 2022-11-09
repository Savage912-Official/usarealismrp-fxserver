TO_RENDER = nil

---Show Help Notification
---@param txt string
function ShowHelpNotification(txt)
    AddTextEntry('showHelpNotify', txt)
    BeginTextCommandDisplayHelp('showHelpNotify')
    EndTextCommandDisplayHelp(0, false, true, -1)
end

---Show a notification
---@param txt string
function Notify (txt)
	AddTextEntry('rcore_notify', txt)
	BeginTextCommandThefeedPost('rcore_notify')
	EndTextCommandThefeedPostTicker(false)
end
---The game subtext that shows information
---@param msg any
function Subtext (msg)
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint()
end

--- Notification
function NotifyBigMessage(text, time)
    local sec = time
    local ScaleformHandle = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE") -- The scaleform you want to use
    while not HasScaleformMovieLoaded(ScaleformHandle) do -- Ensure the scaleform is actually loaded before using
        Wait(0)
    end
    PlaySoundFrontend(-1, "CHALLENGE_UNLOCKED", "HUD_AWARDS", true)
	BeginScaleformMovieMethod(ScaleformHandle, 'SHOW_SHARD_WASTED_MP_MESSAGE')
	PushScaleformMovieMethodParameterString(text)
	EndScaleformMovieMethod()

	while sec > 0 do
		Wait(1)
		sec = sec - 0.01

		DrawScaleformMovieFullscreen(ScaleformHandle, 255, 255, 255, 255)
	end

	SetScaleformMovieAsNoLongerNeeded(ScaleformHandle)
end

function DrawControls()
	if not TO_RENDER then
		TO_RENDER = LoadControls()
	end
    DrawScaleformMovieFullscreen(TO_RENDER, 255, 255, 255, 255, 0)
end


function LoadControls()
	local scaleControls = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
	while not HasScaleformMovieLoaded(scaleControls) do
		Wait(0)
	end

	DrawScaleformMovieFullscreen(scaleControls, 255, 255, 255, 0, 0)

	BeginScaleformMovieMethod(scaleControls, "CLEAR_ALL")
	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(scaleControls, "SET_DATA_SLOT")
	ScaleformMovieMethodAddParamInt(0)
	PushScaleformMovieMethodParameterString("~INPUT_VEH_MELEE_LEFT~")
	PushScaleformMovieMethodParameterString(_U("SHOT"))
	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(scaleControls, "SET_DATA_SLOT")
	ScaleformMovieMethodAddParamInt(1)
	PushScaleformMovieMethodParameterString("~INPUT_VEH_MELEE_RIGHT~")
	PushScaleformMovieMethodParameterString(_U("ZOOM"))
	EndScaleformMovieMethod()
	

	BeginScaleformMovieMethod(scaleControls, "SET_DATA_SLOT")
	ScaleformMovieMethodAddParamInt(2)
	PushScaleformMovieMethodParameterString("~INPUT_LOOK_UD~")
	PushScaleformMovieMethodParameterString(_U("AIM"))
	EndScaleformMovieMethod()


	BeginScaleformMovieMethod(scaleControls, "SET_DATA_SLOT")
	ScaleformMovieMethodAddParamInt(3)
	PushScaleformMovieMethodParameterString("~INPUT_CELLPHONE_CANCEL~")
	PushScaleformMovieMethodParameterString(_U("CANCEL"))
	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(scaleControls, "DRAW_INSTRUCTIONAL_BUTTONS")
	ScaleformMovieMethodAddParamInt(0)
	EndScaleformMovieMethod()

	return scaleControls
end

function LoadTimerBars()
	CreateThread(function ()
		Citizen.Await(LOADED_F)
		if not HasStreamedTextureDictLoaded('timerbars') then
			RequestStreamedTextureDict('timerbars')
			while not HasStreamedTextureDictLoaded('timerbars') do
				Wait(0)
			end
		end
	end)
end

function LoadLeave()
	local leaveControl = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
	while not HasScaleformMovieLoaded(leaveControl) do
		Wait(0)
	end

	DrawScaleformMovieFullscreen(leaveControl, 255, 255, 255, 0, 0)

	BeginScaleformMovieMethod(leaveControl, "CLEAR_ALL")
	EndScaleformMovieMethod()


	BeginScaleformMovieMethod(leaveControl, "SET_DATA_SLOT")
	ScaleformMovieMethodAddParamInt(3)
	PushScaleformMovieMethodParameterString("~INPUT_CELLPHONE_CANCEL~")
	PushScaleformMovieMethodParameterString(_U("CANCEL"))
	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(leaveControl, "DRAW_INSTRUCTIONAL_BUTTONS")
	ScaleformMovieMethodAddParamInt(0)
	EndScaleformMovieMethod()
	return leaveControl
end

function DrawLeave()
	if not TO_RENDER then
		TO_RENDER = LoadLeave()
	end
    DrawScaleformMovieFullscreen(TO_RENDER, 255, 255, 255, 255, 0)
end

function drawHelpTxt(x,y ,width,height,scale, text, r,g,b,a,font)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end

function DrawTimerBar()
	local X, Y, W; H = 0.0125
	local Duration = 7500
	local timer = GetGameTimer()
	local correction = ((1.0 - round(GetSafeZoneSize(), 2)) * 100) * 0.005
	X, Y = 0.9255 - correction, 0.94 - correction
	Set_2dLayer(0)
	DrawSprite('timerbars', 'all_black_bg', X, Y, 0.15, 0.0325, 0.0, 255, 255, 255, 180)
	SetTextColour(255, 255, 255, 180)
	SetTextFont(0)
	SetTextScale(0.3, 0.3)
	SetTextCentre(true)
	SetTextEntry('STRING')
	AddTextComponentString(_U("SHOTCLOCK"))
	Set_2dLayer(3)
	DrawText(X - 0.03, Y - 0.012)
	local mins, secs = Clock(TIME)
	SetTextColour(255, 255, 255, 180)
	SetTextFont(0)
	SetTextScale(0.40, 0.40)
	SetTextCentre(true)
	SetTextEntry('STRING')
	AddTextComponentString(mins..":"..secs)
	Set_2dLayer(3)
	DrawText(X + 0.05, Y - 0.015)
end

function GetClosestObjectOfType(x, y, z, radius)
	dbg.info('Searching for object...')
	local hash = GetHashKey('prop_dart_bd_cab_01')
    local objects = GetGamePool('CObject')
	local table = 0
	local distance = 50
    for i = 1, #objects do
        local v = objects[i]
        local coords = vector3(x, y, z)
        local objCoords = GetEntityCoords(v)
		local dist = #(coords - objCoords)
        if dist < radius and dist < distance then
			distance = dist
            if GetEntityModel(v) == hash then
				dbg.info('Found object in distance: ' .. dist)
				table = v
            end
        end
    end
	return table
end