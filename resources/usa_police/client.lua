local policeLockerRooms = {
	-- {x = -1059.8253, y = -806.2991, z = 11.6244}, -- vespucci PD male
	-- {x=-1071.4558, y=-809.0568, z=11.6252}, -- vespucci PD female
	{x = -1108.5192871094, y = -847.15698242188, z = 19.316898345947}, -- vespuscci old
	{x = 370.3, y = -1608.4, z = 29.5}, -- davis PD (OLD)
	-- {x = 362.76776123047, y = -1593.638671875, z = 25.451694488525}, -- DavisPD (NEW)
	--{x = 826.5, y = -1291.3, z = 27.3}, -- la mesa PD
	{x = 638.9, y = 1.9, z = 82.8}, -- vinewood PD, elgin ave.
	{x = 463.69451904297, y = -998.14770507813, z = 30.842144012451}, -- mrpd (GABZ MLO)
	--{x = 454.70092773438, y = -992.3134765625, z = 30.68932723999}, -- MRPD 
	{x = -1812.9343261719, y = 2998.0632324219, z = 32.809730529785}, -- Fort Zancudo
	-- {x = -1976.4815673828, y = 2816.5910644531, z = 32.810386657715}, -- Fort Zancudo (FAKE)
}

local policeArmourys = {
	-- {x = -1054.6794, y = -811.4606, z = 11.9252}, -- vespucci PD
	{x = -1110.2474365234, y = -844.9677734375, z = 19.316892623901}, -- vespucci old
	{x = 1860.4114990234, y = 3692.1384277344, z = 34.219429016113}, -- Sandy SO
	-- {x = 365.51690673828, y = -1598.5163574219, z = 25.451700210571}, -- davis PD (NEW)
	{x = 637.5, y = -2.7, z = 82.8}, -- vinewood PD, elgine ave.
	{x = 479.06399536133, y = -996.77844238281, z = 30.691987991333}, --MRPD (GABZ MLO)
	--{x = 452.36810302734, y = -980.05767822266, z = 30.68931388855}, -- MRPD
	{x = 836.92388916016, y = -1286.1893310547, z = 28.244941711426}, -- La Mesa PD
	{x = -1807.0364990234, y = 3002.6257324219, z = 32.809722900391} -- Fort Zancudo
}

local locationsData = {}
for i = 1, #policeLockerRooms do
	table.insert(locationsData, {
		coords = vector3(policeLockerRooms[i].x, policeLockerRooms[i].y, policeLockerRooms[i].z),
		text = "[E] - Locker Room"
	})
end
for i = 1, #policeArmourys do
	table.insert(locationsData, {
		coords = vector3(policeArmourys[i].x, policeArmourys[i].y, policeArmourys[i].z),
		text = "[E] - Armory"
	})
end
exports.globals:register3dTextLocations(locationsData)

local weapons = {} -- armory items

local policeoutfitamount = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 , 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30}

local MAX_COMPONENT = 270
local MAX_COMPONENT_TEXTURE = 100
local MAX_PROP = 200
local MAX_PROP_TEXTURE = 100
local arrSkinGeneralCaptions = {"LSPD Male","LSPD Female","Motor Unit","SWAT","Sheriff Male","Sheriff Female","Traffic Warden","Custom Male","Custom Female","FBI 1","FBI 2","FBI 3","FBI 4","Detective Male","Detective Female","Ranger Male", "Ranger Female", "Tactical", "Pilot"}
local arrSkinGeneralValues = {"s_m_y_cop_01","s_f_y_cop_01","S_M_Y_HwayCop_01","S_M_Y_SWAT_01","S_M_Y_Sheriff_01","S_F_Y_Sheriff_01","ig_trafficwarden","mp_m_freemode_01","mp_f_freemode_01","mp_m_fibsec_01","ig_stevehains","ig_andreas","s_m_m_fiboffice_01","s_m_m_ciasec_01","ig_karen_daniels","S_M_Y_Ranger_01","S_F_Y_Ranger_01", "s_m_y_blackops_01", "s_m_m_pilot_02"}
local arrSkinHashes = {}
for i=1,#arrSkinGeneralValues do
	arrSkinHashes[i] = GetHashKey(arrSkinGeneralValues[i])
end
local components = {"Face","Head","Hair","Arms/Hands","Legs","Back","Feet","Ties","Shirt","Vests","Textures","Torso"}
local props = { "Head", "Glasses", "Ear Acessories", "Watch"}
local MENU_OPEN_KEY = 38
local closest_shop = nil

-- load armory items --
TriggerServerEvent("police:loadArmoryItems")

-- Events --
RegisterNetEvent("policestation2:setciv")
AddEventHandler("policestation2:setciv", function(character, playerWeapons)
	Citizen.CreateThread(function()
		local model
		if not character.hash then -- does not have any customizations saved
			model = -408329255 -- some random black dude with no shirt on, lawl
		else
			model = character.hash
		end
        RequestModel(model)
        while not HasModelLoaded(model) do -- Wait for model to load
            Wait(100)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
		-- give model customizations if available
		if character.hash then
			for key, value in pairs(character["components"]) do
				--if tonumber(key) ~= 0 or tonumber(key) ~= 1 or tonumber(key) ~= 2 then -- emit barber shop features
					SetPedComponentVariation(GetPlayerPed(-1), tonumber(key), value, character["componentstexture"][key], 0)
				--end
			end
			for key, value in pairs(character["props"]) do
				SetPedPropIndex(GetPlayerPed(-1), tonumber(key), value, character["propstexture"][key], true)
			end
		end
		TriggerServerEvent("spawn:loadCustomizations")
		-- give weapons
		if playerWeapons then
			for i = 1, #playerWeapons do
				local currentWeaponAmmo = ((playerWeapons[i].magazine and playerWeapons[i].magazine.currentCapacity) or 0)
				TriggerEvent("interaction:equipWeapon", playerWeapons[i], true, currentWeaponAmmo, false)
			end
		end
    end)
end)

RegisterNetEvent("policestation2:isWhitelisted")
AddEventHandler("policestation2:isWhitelisted", function()
	CreateUniformMenu(mainMenu)
	mainMenu:Visible(true)
end)

RegisterNetEvent("policestation2:showArmoury")
AddEventHandler("policestation2:showArmoury", function()
	CreateArmoryMenu(mainMenu)
	mainMenu:Visible(true)
end)

RegisterNetEvent("policestation2:setCharacter")
AddEventHandler("policestation2:setCharacter", function(character)
	local ped = GetPlayerPed(-1)
	if character then
		for key, value in pairs(character["components"]) do
			SetPedComponentVariation(ped, tonumber(key), value, character["componentstexture"][key], 0)
		end
		for key, value in pairs(character["props"]) do
			SetPedPropIndex(ped, tonumber(key), value, character["propstexture"][key], true)
		end
		SetPedArmour(ped, 100)
	end
end)

RegisterNetEvent("police:loadArmoryItems")
AddEventHandler("police:loadArmoryItems", function(items)
	weapons = items
end)

-- Menu --
--// Main Menu
--//	Skin Selection (array)
--//  Components (submenu)
--//  Props (submenu)
--//  Load Default Uniform
--//  Save Default Uniform
--//  Off Duty

-----------------
-- Set up menu --
-----------------
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("SASP", "~b~San Andreas State Police", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(mainMenu)

function CreateUniformMenu(menu)
	local ped = GetPlayerPed(-1)
	menu:Clear()

	local submenu2 = _menuPool:AddSubMenu(menu, "Outfits", "Save and load outfits", true)
	local selectedSaveSlot = 1
    local selectedLoadSlot = 1
    local saveslot = UIMenuListItem.New("Slot to Save", policeoutfitamount)
    local saveconfirm = UIMenuItem.New('Confirm Save', 'Save outfit into the above number')
    saveconfirm:SetRightBadge(BadgeStyle.Tick)
    local loadslot = UIMenuListItem.New("Slot to Load", policeoutfitamount)
    local loadconfirm = UIMenuItem.New('Load Outfit', 'Load outfit from above number')
    loadconfirm:SetRightBadge(BadgeStyle.Clothes)
    submenu2.SubMenu:AddItem(loadslot)
    submenu2.SubMenu:AddItem(loadconfirm)
    submenu2.SubMenu:AddItem(saveslot)
    submenu2.SubMenu:AddItem(saveconfirm)

    submenu2.SubMenu.OnListChange = function(sender, item, index)
        if item == saveslot then
            selectedSaveSlot = item:IndexToItem(index)
        elseif item == loadslot then
            selectedLoadSlot = item:IndexToItem(index)
        end
    end
    submenu2.SubMenu.OnItemSelect = function(sender, item, index)
        if item == saveconfirm then
            local character = {
			["components"] = {},
			["componentstexture"] = {},
			["props"] = {},
			["propstexture"] = {}
			}
			local ply = GetPlayerPed(-1)
			--local debugstr = "| Props: "
			for i=0,2 -- instead of 3?
				do
				character.props[i] = GetPedPropIndex(ply, i)
				character.propstexture[i] = GetPedPropTextureIndex(ply, i)
				--debugstr = debugstr .. character.props[i] .. "->" .. character.propstexture[i] .. ","
			end
			--debugstr = debugstr .. "| Components: "
			for i=0,11
				do
				character.components[i] = GetPedDrawableVariation(ply, i)
				character.componentstexture[i] = GetPedTextureVariation(ply, i)
				--debugstr = debugstr .. character.components[i] .. "->" .. character.componentstexture[i] .. ","
			end
			--print(debugstr)
			TriggerServerEvent("policestation2:saveOutfit", character, selectedSaveSlot)
        elseif item == loadconfirm then
            DoScreenFadeOut(500)
            Citizen.Wait(500)
            TriggerServerEvent('policestation2:loadOutfit', selectedLoadSlot)
			TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1, 'zip-close', 1.0)
			Citizen.Wait(2000)
			DoScreenFadeIn(500)
            TriggerEvent("usa:playAnimation", 'clothingshirt', 'try_shirt_positive_d', -8, 1, -1, 48, 0, 0, 0, 0, 3)
        end
    end
	-- Components --
	local submenu = _menuPool:AddSubMenu(menu, "Components", "Modify components", true --[[KEEP POSITION]])
	for i = 1, #components do
		local selectedComponent = GetPedDrawableVariation(ped, i - 1)
		local selectedTexture = GetPedTextureVariation(ped, i - 1)
		local maxComponent = GetNumberOfPedDrawableVariations(ped, i - 1)
		--local maxTexture = GetNumberOfPedTextureVariations(ped, i - 1, selectedComponent)
		local arr = {}
		for j = 0, maxComponent + 1 do arr[j] = j - 1 end
		local listitem = UIMenuListItem.New(components[i], arr, selectedComponent)
		listitem.OnListChanged = function(sender, item, index)
			if item == listitem then
				--print("Selected ~b~" .. index .. "~w~...")
				selectedComponent = index - 1
				SetPedComponentVariation(ped, i - 1, selectedComponent, 0, 0)
				selectedTexture = 0
			end
		end
		submenu.SubMenu:AddItem(listitem)
		--if maxTexture > 1 then
			arr = {}
			for j = 0, MAX_COMPONENT_TEXTURE + 1 do arr[j] = j - 1 end
			local listitem = UIMenuListItem.New(components[i] .. " Texture", arr, selectedTexture)
			listitem.OnListChanged = function(sender, item, index)
				if item == listitem then
					selectedTexture = index - 1
					SetPedComponentVariation(ped, i - 1, selectedComponent, selectedTexture, 0)
				end
			end
			submenu.SubMenu:AddItem(listitem)
		--end
	end
	-- Props --
	local submenu = _menuPool:AddSubMenu(menu, "Props", "Modify props", true --[[KEEP POSITION]])
	for i = 1, 3 do
		local selectedProp = GetPedPropIndex(ped, i - 1)
		local selectedPropTexture = GetPedPropTextureIndex(ped, i - 1)
		--local maxProp = GetNumberOfPedPropDrawableVariations(ped, i - 1)
		--local maxPropTexture = GetNumberOfPedPropTextureVariations(ped, i - 1, selectedProp)
		local arr = {}
		for j = 0, MAX_PROP + 1 do arr[j] = j - 1 end
		local listitem = UIMenuListItem.New(props[i], arr, selectedProp)
		listitem.OnListChanged = function(sender, item, index)
			if item == listitem then
				--print("Selected ~b~" .. index .. "~w~...")
				selectedProp = index - 1
				if selectedProp > -1 then
					SetPedPropIndex(ped, i - 1, selectedProp, 0, true)
				else
					ClearPedProp(ped, i - 1)
				end
			end
		end
		submenu.SubMenu:AddItem(listitem)
		-- add texture variation --
		--if maxPropTexture > 1 and selectedProp > -1 then
			arr = {}
			for j = 0, MAX_PROP_TEXTURE do arr[j] = j - 1 end
			local listitem = UIMenuListItem.New(props[i] .. " Texture", arr, selectedPropTexture)
			listitem.OnListChanged = function(sender, item, index)
				if item == listitem then
					--print("Selected ~b~" .. index .. "~w~...")
					selectedPropTexture = index - 1
					SetPedPropIndex(ped, i - 1, selectedProp, selectedPropTexture, true)
				end
			end
			submenu.SubMenu:AddItem(listitem)
		--end
	end
	local item = NativeUI.CreateItem("Clear Props", "Reset props.")
	item.Activated = function(parentmenu, selected)
		ClearPedProp(ped, 0)
		ClearPedProp(ped, 1)
		ClearPedProp(ped, 2)
	end
	submenu.SubMenu:AddItem(item)
	-- Custom Peds
	local pedsubmenu = _menuPool:AddSubMenu(menu, "Custom Peds", "Honorary Trooper Peds", true)
	local listitem = NativeUI.CreateItem("Edna Minyon", "Only for Emmma#3769")
	listitem.Activated = function(parentmenu, selected)
		local modelhashed = GetHashKey("ig_old_lady_cop")
		RequestModel(modelhashed)
		while not HasModelLoaded(modelhashed) do
			Citizen.Wait(100)
		end
		SetPlayerModel(PlayerId(), modelhashed)
	end
	pedsubmenu.SubMenu:AddItem(listitem)
	local listitem = NativeUI.CreateItem("Tarvis Yelnats", "Only for Prophet#1738")
	listitem.Activated = function(parentmenu, selected)
		local modelhashed = GetHashKey("ig_yelnats")
		RequestModel(modelhashed)
		while not HasModelLoaded(modelhashed) do
			Citizen.Wait(100)
		end
		SetPlayerModel(PlayerId(), modelhashed)
	end
	pedsubmenu.SubMenu:AddItem(listitem)
	-- Clock Out --
	local item = NativeUI.CreateItem("Clock Out", "Sign off duty")
	item:SetRightBadge(BadgeStyle.Lock)
	item.Activated = function(parentmenu, selected)
		RemoveAllPedWeapons(ped)
		TriggerServerEvent("policestation2:offduty")
		TriggerEvent("interaction:setPlayersJob", "civ") -- set interaction menu javascript job variable to "civ"
		TriggerEvent("ptt:isEmergency", false)
	end
	menu:AddItem(item)
end

function CreateArmoryMenu(menu)
	local playerPed = PlayerPedId()
	menu:Clear()
	for i = 1, #weapons do
      local item = NativeUI.CreateItem(weapons[i].name, "Purchase price: $" .. comma_value(weapons[i].price))
      item.Activated = function(parentmenu, selected)
         TriggerServerEvent("policestation2:requestPurchase", i)
      end
      menu:AddItem(item)
    end
    local item = NativeUI.CreateItem('Police Armor', 'Equip heavy-duty body armor')
    --item:SetRightBadge(BadgeStyle.Armour)
    item.Activated = function(parentmenu, selected)
    	SetPedArmour(playerPed, 100)
    	TriggerEvent('usa:notify', 'Armor has been re-equipped.')
    end
    menu:AddItem(item)
end

_menuPool:RefreshIndex()

-- Script Loop --
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed, false)
		_menuPool:MouseControlsEnabled(false)
		_menuPool:ControlDisablingEnabled(false)
		_menuPool:ProcessMenus()
		for i = 1, #policeLockerRooms do
			if Vdist(playerCoords, policeLockerRooms[i].x, policeLockerRooms[i].y, policeLockerRooms[i].z)  <  2 then
				if IsControlJustPressed(1, MENU_OPEN_KEY) then
					closest_shop = policeLockerRooms[i] --// set shop player is at
					if not mainMenu:Visible() then
						TriggerServerEvent("policestation2:checkWhitelistForLockerRoom")
					else
						mainMenu:Visible(false)
						mainMenu:Clear()
					end
				end
			elseif Vdist(playerCoords, policeArmourys[i].x, policeArmourys[i].y, policeArmourys[i].z)  <  2 then
				if IsControlJustPressed(1, MENU_OPEN_KEY) then
					closest_shop = policeArmourys[i] --// set shop player is at
					if not mainMenu:Visible() then
						TriggerServerEvent("policestation2:checkWhitelistForArmory")
					else
						mainMenu:Visible(false)
						mainMenu:Clear()
					end
				end
			else
				if closest_shop then
					closest_shop = nil
					if mainMenu:Visible() then
						mainMenu:Visible(false)
						mainMenu:Clear()
					end
				end
			end
		end
	end
end)

function comma_value(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

-- Check Window Tint --
RegisterNetEvent("usa_police:checkwindowtint")
AddEventHandler("usa_police:checkwindowtint", function()
	local vehicle = exports.globals:getClosestVehicle(1.5)
	local me = PlayerPedId()
	local GetTint = GetVehicleWindowTint(vehicle)

    if vehicle then
		if not IsPedInVehicle(me, vehicle, false) then
			TriggerEvent("dpemotes:command", 'e', GetPlayerServerId(PlayerId()), {"parkingmeter"})
			if lib.progressBar({
				duration = 7 * 1000,
				label = 'Checking Tint...',
				useWhileDead = false,
				canCancel = true,
				disable = {
					car = true,
					move = true,
					combat = true,
				},
			}) then
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1, '1beep', 1.0)
				TriggerEvent("dpemotes:command", 'e', GetPlayerServerId(PlayerId()), {"c"})
				if GetTint == -1  then
					TriggerEvent("chatMessage", '', {0,0,0}, "^1[Tint Meter]^0 None")
				elseif GetTint == 0 then
					TriggerEvent("chatMessage", '', {0,0,0}, "^1[Tint Meter]^0 Stock")
				elseif GetTint == 1 then
					TriggerEvent("chatMessage", '', {0,0,0}, "^1[Tint Meter]^0 Pure Black (5%)")
				elseif GetTint == 2 then
					TriggerEvent("chatMessage", '', {0,0,0}, "^1[Tint Meter]^0 Dark Smoke (20%)")
				elseif GetTint == 3 then
					TriggerEvent("chatMessage", '', {0,0,0}, "^1[Tint Meter]^0 Light Smoke (35%)")
				end
			else
				TriggerEvent("dpemotes:command", 'e', GetPlayerServerId(PlayerId()), {"c"})
			end
		else
			exports.globals:notify("Can't do this while in vehicle.")
		end
    else
        exports.globals:notify("No Vehicle Nearby")
    end
end)
