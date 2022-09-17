local _menuPool = NativeUI.CreatePool()
local mainMenu = NativeUI.CreateMenu("Insurance", "~b~Manage your plan", 0 --[[X COORD]], 320 --[[Y COORD]])
local MENU_KEY = 38
local vehiclesToClaim

local MENU_COORDS = {
	{name = "LS", x = -1083.146484375, y = -248.03326416016, z = 37.763290405273},
	{name = "Grapeseed", x = 1682.8721923828, y = 4855.3203125, z = 42.061218261719, blipScale = 0.7}
}
local MENU_OPEN_MAX_DIST = 1.2

_menuPool:Add(mainMenu)

RegisterNetEvent("insurance:loadedVehicles")
AddEventHandler("insurance:loadedVehicles", function(vehicles)
	if vehicles then
		--menu.vehicles = vehicles
		vehiclesToClaim = {}
		for i = 1, #vehicles do
			if not vehicles[i].stored_location  or vehicles[i].stored_location == "" then
				table.insert(vehiclesToClaim, vehicles[i]) -- add only vehicles not stored at a property (prevent duplication by making a claim when stored at your house)
			end
		end
	end
end)

function CreateMenu(menu)
	Citizen.CreateThread(function()
		local playerPed = PlayerPedId()

		-- Info --
		local infoItem = NativeUI.CreateItem("Info", "See more information about auto insurance...")
		infoItem.Activated = function(parentmenu, selected)
			TriggerEvent("chatMessage", "LIFEINVADER INSURANCE", { 255, 78, 0 }, "LifeInvader will put your mind at ease by making sure you'll always have a ride even if yours gets stolen, lost, or totaled.")
		end
		menu:AddItem(infoItem)
		-- Make a claim --
		claim_submenu = _menuPool:AddSubMenu(menu, "Make a Claim", "Issue a claim for a damaged or lost vehicle.", true)
		-- Purchase --
		local purchaseItem = NativeUI.CreateItem("Purchase or Renew", "If not insured, purchase or renew now for $5,000.")
		purchaseItem.Activated = function(parentmenu, selected)
			TriggerServerEvent("insurance:checkPlayerInsurance")
		end
		menu:AddItem(purchaseItem)
		-- Listeners --
		menu.OnItemSelect = function(menu, item, index)
			local selected = item.Text._Text
			if selected == "Make a Claim" then
				vehiclesToClaim = nil
				claim_submenu.SubMenu:Clear()
				TriggerServerEvent("insurance:loadVehicles", true)

				while not vehiclesToClaim do
					Wait(100)
				end

				if vehiclesToClaim then
					if #vehiclesToClaim > 0 then
						for i = 1, #vehiclesToClaim do
							local vehicle = vehiclesToClaim[i]
							if vehicle then
								local vehName = "Undefined"
								if vehicle.make then
									vehName = vehicle.make .. " " .. vehicle.model
								else
									vehName = vehicle.model
								end
								if vehicle.stored == false then
									if vehicle.price then
										local item = NativeUI.CreateItem(vehicle.make .. " " .. vehicle.model, "Claim this vehicle for a small base fee + $" .. comma_value(.03 * vehicle.price))
										item.Activated = function(parentmenu, selected)
											local business = exports["usa-businesses"]:GetClosestStore(15)
											TriggerServerEvent("insurance:fileClaim", vehicle, business)
											_menuPool:CloseAllMenus()
										end
										claim_submenu.SubMenu:AddItem(item)
									end
								end
							end
						end
					else
						local item = NativeUI.CreateItem("No vehicles to claim or no insurance!", "You have no vehicles to claim or no auto insurance.")
						claim_submenu.SubMenu:AddItem(item)
					end
				else
					local item = NativeUI.CreateItem("No vehicles to claim or no insurance!", "You have no vehicles to claim or no auto insurance.")
					claim_submenu.SubMenu:AddItem(item)
				end
			end
		end
	end)
end

CreateMenu(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
	CreateBlips()
	while true do
		local playerPed = PlayerPedId()
		local wasNearby = false
		for i = 1, #MENU_COORDS do
			DrawText3D(MENU_COORDS[i].x, MENU_COORDS[i].y, MENU_COORDS[i].z, 5, '[E] - Insurance')
			-----------------------------------------------------------
			-- watch for entering store and menu open keypress event --
			-----------------------------------------------------------
			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), MENU_COORDS[i].x, MENU_COORDS[i].y, MENU_COORDS[i].z, true) < MENU_OPEN_MAX_DIST then
				wasNearby = true
				if IsControlJustPressed(1, MENU_KEY) then
					if not mainMenu:Visible() then
						mainMenu:Visible(not mainMenu:Visible())
					end
				end
			end
		end
		-- closing when too far:
		if not wasNearby and mainMenu:Visible() then
			mainMenu:Visible(false)
		end
		----------------------
		-- process menu --
		----------------------
		--if mainMenu:Visible() then
			_menuPool:MouseControlsEnabled(false)
			_menuPool:ControlDisablingEnabled(false)
			_menuPool:ProcessMenus()
		--end
		Wait(1)
	end
end)

function DrawText3D(x, y, z, distance, text)
    if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) < distance then
    	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	    SetTextScale(0.35, 0.35)
	    SetTextFont(4)
	    SetTextProportional(1)
	    SetTextColour(255, 255, 255, 215)
	    SetTextEntry("STRING")
	    SetTextCentre(1)
	    AddTextComponentString(text)
	    DrawText(_x,_y)
	    local factor = (string.len(text)) / 500
	    DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
	end
end

function comma_value(amount)
	if not amount then return end
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function CreateBlips()
	for i = 1, #MENU_COORDS do
		MENU_COORDS[i].blipHandle = AddBlipForCoord(MENU_COORDS[i].x, MENU_COORDS[i].y, MENU_COORDS[i].z)
		SetBlipSprite(MENU_COORDS[i].blipHandle, 408)
		SetBlipDisplay(MENU_COORDS[i].blipHandle, 4)
		SetBlipScale(MENU_COORDS[i].blipHandle, (MENU_COORDS[i].blipScale or 0.8))
		SetBlipAsShortRange(MENU_COORDS[i].blipHandle, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Insurance')
		EndTextCommandSetBlipName(MENU_COORDS[i].blipHandle)
	end
end