local MENU_KEY = 38 -- "E"

local locations = {
	--{ x=-447.723, y=6013.65, z=30.700 },
	--{ x=441.301, y=-981.434, z=29.689 },
	--{ x=1853.616, y=3687.966, z=33.267 },
	-- {x = -544.857, y = -204.422, z = 38.3152}, -- LS
	{x = -448.14, y = 6013.261, z = 31.9}, -- paleto
	{x = 1852.6024169922, y = 3687.2468261719, z = 34.219371795654}, -- sandy
	{x = 441.06921386719, y = -981.13000488281, z = 30.689334869385}, -- MRPD
	{x = -544.04626464844, y = -197.26399230957, z = 38.226985931396} -- Cityhall
}

local DL_PRICE = 250

function isPlayerAtDMV()
	local playerCoords = GetEntityCoords(PlayerPedId() --[[Ped]], false)
	for i = 1, #locations do
		if Vdist(playerCoords.x,playerCoords.y,playerCoords.z,locations[i].x,locations[i].y,locations[i].z) < 2.0 then
			return true
		end
	end
	return false
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

----------------------
-- Set up main menu --
----------------------
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("DMV", "~b~Department of Motor Vehicles", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(mainMenu)

function CreateDMVMenu(menu)
	----------------------
	-- Purchase License --
	----------------------
	local item = NativeUI.CreateItem("Driver's License", "Purchase price: $" .. DL_PRICE)
	item.Activated = function(parentmenu, selected)
		TriggerServerEvent("dmv:buyLicense")
	end
	menu:AddItem(item)
	-------------------------
	-- See any suspensions --
	-------------------------
	local item2 = NativeUI.CreateItem("Suspensions", "Check any license suspensions")
	item2.Activated = function(parentmenu, selected)
		TriggerServerEvent("dmv:getLicenseStatus")
	end
	menu:AddItem(item2)
	-- custom license plate:
	local item3 = NativeUI.CreateItem("Custom license plate", "Order a customer license plate")
	item3.Activated = function(parentmenu, selected)
		menu:Visible(false)
		TriggerEvent("dmv:openCustomPlateMenu")
	end
	menu:AddItem(item3)
end

----------------
-- add to GUI --
----------------
CreateDMVMenu(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId() --[[Ped]], false)
	    -- Process Menu --
	    _menuPool:MouseControlsEnabled(false)
	    _menuPool:ControlDisablingEnabled(false)
	    _menuPool:ProcessMenus()
	    -------------------
	    -- draw help txt --
	    -------------------
	    for i = 1, #locations do
	    	if Vdist(playerCoords.x,playerCoords.y,playerCoords.z,locations[i].x,locations[i].y,locations[i].z) < 5.0 then
	    		DrawText3D(locations[i].x,locations[i].y,locations[i].z, '[E] - DMV')
	    	end
	    end

	    if mainMenu:Visible() and not isPlayerAtDMV() then
	        mainMenu:Visible(false)
	    end
	    --------------------------
	    -- Listen for menu open --
	    --------------------------
		if IsControlJustPressed(1, MENU_KEY) and isPlayerAtDMV() then
	    	mainMenu:Visible(not mainMenu:Visible())
		end
	end
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 470
    DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
end