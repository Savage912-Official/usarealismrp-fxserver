-- basically just using this script for the /dcs command since new player list (fax-scoreboard)

local _menuPool = NativeUI.CreatePool()
local mainMenu = NativeUI.CreateMenu("Players", "~b~View online players", 1400 --[[X COORD]], -10 --[[Y COORD]])
local dcMenu = NativeUI.CreateMenu("Players", "~b~View disconnected players", 1400 --[[X COORD]], -10 --[[Y COORD]])
_menuPool:Add(mainMenu)
_menuPool:Add(dcMenu)

local activePlayerlist = {}
local playerlist = {
	key = 170,
	active = false,
	group = 'user'
}
local playersToShow = {
	active = false,
	ids = {}
} -- interiors

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		_menuPool:MouseControlsEnabled(false)
		_menuPool:ControlDisablingEnabled(false)
		_menuPool:DisableInstructionalButtons(false)
		_menuPool:WidthOffset(-40)
		_menuPool:ProcessMenus()
		--[[
		if IsControlJustPressed(0, playerlist.key) and GetLastInputMethod(0) then
			TriggerServerEvent('playerlist:getPlayers')
		end
		--]]
	end
end)

RegisterNetEvent('playerlist:displayPlayerlist')
AddEventHandler('playerlist:displayPlayerlist', function(players, group)
	local displayTime = 15000
	if group ~= "user" then
		displayTime = displayTime + 99999 -- staff can hold menu open longer than non-staff (to prevent meta gaming)
	end
	playerlist.group = group
	mainMenu:Clear()
	RefreshMenu(players)
	_menuPool:RefreshIndex()
	mainMenu:Visible(true)
	PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	local beginTime = GetGameTimer()
	while IsControlPressed(0, playerlist.key) and GetGameTimer() - beginTime < displayTime do
		ShowIds()
		Citizen.Wait(0)
	end
	mainMenu:Visible(false)
	PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)

RegisterNetEvent('playerlist:dcList')
AddEventHandler('playerlist:dcList', function(players)
	dcMenu:Clear()
	RefreshDCMenu(players)
	_menuPool:RefreshIndex()
	dcMenu:Visible(true)
	PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)

RegisterNetEvent('playerlist:setUserGroup')
AddEventHandler('playerlist:setUserGroup', function(group)
	playerlist.group = group
end)

function RefreshMenu(players)
	_menuPool:TotalItemsPerPage(21)
	table.sort(players, function(a,b)
		return a.id > b.id
	end)
	for i = 1, #players do
		local player = players[i]
		local playerItem = NativeUI.CreateItem(player.id .. ' | ' .. HexIdToSteamId(player.steam), 'Ping: '..player.ping..'ms')
		if playerlist.group ~= 'user' then
			playerItem = NativeUI.CreateItem(player.id .. ' | ' .. player.steam, 'Name: '..tostring(player.fullname)..' \nJob: '  ..tostring(player.job))
			if player.job ~= "civ" and player.job ~= "sheriff" and player.job ~= "corrections" then
				playerItem:SetRightBadge(18) -- star
			end
		end
		mainMenu:AddItem(playerItem)
	end
end

function RefreshDCMenu(players)
	_menuPool:TotalItemsPerPage(21)
	if table.getIndex(players) > 0 then
		for player, info in pairs(players) do
			local playerItem = NativeUI.CreateItem(player .. ' | ' .. info[2], '')
			if playerlist.group ~= 'user' then
				playerItem = NativeUI.CreateItem(player .. ' | ' .. info[2], 'Name: '..tostring(info[1]))
			end
			dcMenu:AddItem(playerItem)
		end
	else
		playerItem = NativeUI.CreateItem('No players have recently left', '')
		dcMenu:AddItem(playerItem)
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

function HexIdToSteamId(hexId)
	if not hexId or not tonumber(string.sub(hexId, 7), 16) then
		return "UNDEFINED"
	end
    local cid = math.floor(tonumber(string.sub(hexId, 7), 16))
	local steam64 = math.floor(tonumber(string.sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
	local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end

function ShowIds()
	local viewDistance = 10
	local myCoords = GetEntityCoords(PlayerPedId())
	if playerlist.group ~= 'user' then
		viewDistance = 40
	end
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

function table.getIndex(table)
    local index = 0
    for key, value in pairs(table) do
        index = index + 1
    end
    return index
end
