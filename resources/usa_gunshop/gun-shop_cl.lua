--# Gun store that also inserts a firearm permit.
--# For this to work without modification, you will need the latest copy of the usa_rp resource
--# Created for USA REALISM RP
--# by: minipunch
local MENU_KEY = 38 -- "E"
local playerWeapons
local locations = {
	{ x = -327.72702026367, y = 6080.2001953125, z = 31.454776763916 }, -- Paleto
	{ x = -3168.2614746094, y = 1085.2199707031, z = 20.838739395142 }, -- Great Ocean Hwy. / Chumash
	{ x = -1114.3781738281, y = 2696.111328125, z = 18.55428314209 }, -- Route 68
	{ x = 1696.3111572266, y = 3756.3647460938, z = 34.705326080322 }, -- Sandy Shores / Algonquin
	{ x = 248.02490234375, y = -49.66752243042, z = 69.941246032715 }, -- Spanish Ave
	{ x = -1309.8179931641, y = -392.07473754883, z = 36.695777893066 }, -- Boulevard Del Perro
	{ x = -661.37243652344, y = -939.52880859375, z = 21.829343795776 }, -- Linsday Circus
	{ x = 15.989282608032, y = -1109.3151855469, z = 29.797222137451 }, -- Adam's / Elgin Ave
	{ x = 843.20684814453, y = -1029.1872558594, z = 28.194852828979 }, -- Olympic Fwy / Vespucci 
	{ x = 2566.8959960938, y = 298.49291992188, z = 108.73505401611 }, -- Palomino Fwy
	{ x = 814.80017089844, y = -2153.0910644531, z = 29.619186401367 }, -- Popular St
  { x = -542.51873779297, y = -583.68939208984, z = 34.681762695313}, -- New Mall MLO
  {x = -1305.2866210938, y = -3388.1235351563, z = 13.940147399902} -- paintball arena at LSIA
}

local locationsData = {}
for i = 1, #locations do
  table.insert(locationsData, {
	coords = vector3(locations[i].x, locations[i].y, locations[i].z),
	text = "[E] - Ammunation"
  })
end
exports.globals:register3dTextLocations(locationsData)

local purchasedWeapons = 0

local recentWeapon911 = false

local STORE_ITEMS = {}

TriggerServerEvent("gunShop:getItems")

RegisterNetEvent("gunShop:getItems")
AddEventHandler("gunShop:getItems", function(items)
	STORE_ITEMS = items
	CreateWeaponShopMenu(mainMenu)
	_menuPool:RefreshIndex()
end)

-- create map blips --
for i = 1, #locations do
	TriggerEvent("usa_map_blips:addMapBlip", {locations[i].x, locations[i].y, locations[i].z}, 119, 4, 0.8, 50, true, 'Gun Store', 'gun_stores') --coords, sprite, display, scale, color, shortRange, name, groupName)
end

-------------------
-- utility funcs --
-------------------
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

----------------------
-- Set up main menu --
----------------------
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Ammunation", "~b~Welcome!", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(mainMenu)

--------------------------------
-- Construct GUI menu buttons --
--------------------------------
function CreateWeaponShopMenu(menu)
  -----------------------------------
  -- Adds button for each category --
  -----------------------------------
  for category, weapons in pairs(STORE_ITEMS) do
    local submenu = _menuPool:AddSubMenu(menu, category, "See our selection of " .. category, true --[[KEEP POSITION]])
    for i = 1, #weapons do
      ---------------------------------------------
      -- Button for each weapon in each category --
      ---------------------------------------------
      local item = NativeUI.CreateItem(weapons[i].name, "Purchase price: $" .. comma_value(weapons[i].price))
      item.Activated = function(parentmenu, selected)
        local business = exports["usa-businesses"]:GetClosestStore(15)
         TriggerServerEvent("gunShop:requestPurchase", category, i, business)
         Wait(1000)
      end
      ----------------------------------------
      -- add to sub menu created previously --
      ----------------------------------------
      submenu.SubMenu:AddItem(item)
    end
  end
  local helpBtn = NativeUI.CreateItem("Help", "Which magazines do I need?")
  helpBtn.Activated = function(parentmenu, selected)
    TriggerServerEvent("ammo:showHelpText", STORE_ITEMS)
  end
  menu:AddItem(helpBtn)
end

-------------------------------------------
-- open menu when near gun shop location --
-------------------------------------------
Citizen.CreateThread(function()
	local menu_opened = false
	local closest_location = nil
  while true do
    Citizen.Wait(0)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    _menuPool:ProcessMenus()
    local mycoords = GetEntityCoords(GetPlayerPed(-1))
		-- see if close to any stores --
    for i = 1, #locations do
    	if IsControlJustPressed(1, MENU_KEY) and not _menuPool:IsAnyMenuOpen() then
				if Vdist(mycoords.x, mycoords.y, mycoords.z, locations[i].x, locations[i].y, locations[i].z) < 1.3 then
					Wait(500)
					if not IsControlPressed(1, MENU_KEY) then -- not held
	    			TriggerServerEvent('gunShop:requestOpenMenu')
						closest_location = locations[i]
					else -- held
						local business = exports["usa-businesses"]:GetClosestStore(15)
						TriggerServerEvent("gunShop:purchaseLicense", business)
					end
				end
    	end
    end
		-- close menu when far away --
		if closest_location then
      if Vdist(mycoords.x, mycoords.y, mycoords.z, closest_location.x, closest_location.y, closest_location.z) > 1.3 then
        if _menuPool then
          if _menuPool:IsAnyMenuOpen() then
            closest_location = nil
            _menuPool:CloseAllMenus()
          end
        end
			end
		end
  end
end)

RegisterNetEvent("mini:equipWeapon")
AddEventHandler("mini:equipWeapon", function(hash, attachments, equipNow)
  if equipNow == nil then
    equipNow = true
  end
	local playerPed = GetPlayerPed(-1)
	if hash ~= GetHashKey("GADGET_PARACHUTE") then	--Dont auto equip parachutes from gunstore
    GiveWeaponToPed(playerPed, hash, 0, false, equipNow)
		if attachments then
			for i = 1, #attachments do
				if type(attachments[i]) ~= "number" then
					GiveWeaponComponentToPed(playerPed, hash, GetHashKey(attachments[i]))
				else
					GiveWeaponComponentToPed(playerPed, hash, attachments[i])
				end
			end
		end
	end
end)

RegisterNetEvent('gunShop:openMenu')
AddEventHandler('gunShop:openMenu', function()
	mainMenu:Visible(not mainMenu:Visible())
end)

RegisterNetEvent('gunShop:addRecentlyPurchased')
AddEventHandler('gunShop:addRecentlyPurchased', function(buyerName)
  purchasedWeapons = purchasedWeapons + 1
  if purchasedWeapons > 3 and not recentWeapon911 then
    local playerPed = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(playerPed))
    local lastStreetHASH = GetStreetNameAtCoord(x, y, z)
    local lastStreetNAME = GetStreetNameFromHashKey(lastStreetHASH)
    TriggerServerEvent('911:SuspiciousWeaponBuying', x, y, z, lastStreetNAME, buyerName)
    recentWeapon911 = true
  end
end)

RegisterNetEvent("gunShop:showCCWTerms")
AddEventHandler("gunShop:showCCWTerms", function()
	TriggerEvent('chatMessage', '', { 0, 0, 0 }, "^01) The license holder is legally allowed to carry a weapon so long as it remains ^3CONCEALED^0 at all times.")
	Wait(4000)
	TriggerEvent('chatMessage', '', { 0, 0, 0 }, "^02) If contacted by a law enforcement officer for any reason, and the license holder is armed, the license holder shall immediately inform the officer they are a CCW licensee and when the officer requests the license holder’s CCW license, the license holder will provide their CCW license as proof they are legally carrying a concealed weapon.")
	Wait(9000)
	TriggerEvent('chatMessage', '', { 0, 0, 0 }, "^03) License holder shall surrender the CCW license and/or concealed weapon to any sworn peace officer upon demand.")
	Wait(5000)
	TriggerEvent('chatMessage', '', { 0, 0, 0 }, "^04) License holder shall not unnecessarily display or expose the concealed weapon or license.")
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(90000)
    -- Citizen.Wait(10000)
    if purchasedWeapons > 0  then
      purchasedWeapons = purchasedWeapons - 1
    	if purchasedWeapons == 0 then
    		recentWeapon911 = false
    	end
    end
  end
end)

--------------------
-- Spawn job peds --
--------------------
local JOB_PEDS = {
  --{x = -331.043, y = 6086.09, z = 30.40, heading = 180.0}
}

Citizen.CreateThread(function()
	for i = 1, #JOB_PEDS do
		local hash = -1064078846
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			RequestModel(hash)
			Citizen.Wait(0)
		end
		local ped = CreatePed(4, hash, JOB_PEDS[i].x, JOB_PEDS[i].y, JOB_PEDS[i].z, JOB_PEDS[i].heading --[[Heading]], false --[[Networked, set to false if you just want to be visible by the one that spawned it]], true --[[Dynamic]])
		SetEntityCanBeDamaged(ped,false)
		SetPedCanRagdollFromPlayerImpact(ped,false)
		TaskSetBlockingOfNonTemporaryEvents(ped,true)
		SetPedFleeAttributes(ped,0,0)
		SetPedCombatAttributes(ped,17,1)
		SetPedRandomComponentVariation(ped, true)
    	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true);
	end
end)

function ShowCCWTerms(src)
	TriggerEvent('chatMessage', '', { 0, 0, 0 }, "^01) The license holder is legally allowed to carry a weapon so long as it remains ^3CONCEALED^0 at all times.")
	Wait(4000)
	TriggerEvent('chatMessage', '', { 0, 0, 0 }, "^02) If contacted by a law enforcement officer for any reason, and the license holder is armed, the license holder shall immediately inform the officer they are a CCW licensee and when the officer requests the license holder’s CCW license, the license holder will provide their CCW license as proof they are legally carrying a concealed weapon.")
	Wait(9000)
	TriggerEvent('chatMessage', '', { 0, 0, 0 }, "^03) License holder shall surrender the CCW license and/or concealed weapon to any sworn peace officer upon demand.")
	Wait(5000)
	TriggerEvent('chatMessage', '', { 0, 0, 0 }, "^04) License holder shall not unnecessarily display or expose the concealed weapon or license.")
end
