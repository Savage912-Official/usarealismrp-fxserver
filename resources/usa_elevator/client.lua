local LockedElevatorDoors = {
	vector3(-1094.3522, -848.3550, 8.8769),
	vector3(-1096.7560, -850.1392, 8.8769),
	vector3(-1096.1476, -850.5088, 4.5087),
	vector3(-1093.8693847656, -848.84191894531, 4.5087199211121),
	vector3(-1096.8215332031, -850.00946044922, 13.337592124939),
	vector3(-1094.5942382813, -848.18481445313, 13.337586402893),
	vector3(-1094.6762695313, -847.96807861328, 19.332754135132),
	vector3(-1096.8286132813, -850.20483398438, 19.332754135132),
	vector3(-1094.4957275391, -848.34942626953, 22.930694580078),
	vector3(-1096.96484375, -850.28466796875, 22.930694580078),
	vector3(-1096.7907714844, -849.93170166016, 26.953842163086),
	vector3(-1094.5675048828, -848.09197998047, 26.953842163086),
	vector3(-1094.3858642578, -848.30950927734, 30.916748046875),
	vector3(-1096.6856689453, -850.10229492188, 30.916748046875),
	vector3(-1094.1881103516, -848.16119384766, 34.639865875244),
	vector3(-1096.6798095703, -850.37023925781, 34.639865875244),
	vector3(-1066.0889892578, -833.16571044922, 4.8650617599487),
	vector3(-1066.1832275391, -832.81274414063, 8.8768320083618),
	vector3(-1066.1727294922, -832.81597900391, 13.332990646362),
	vector3(-1066.6997070313, -833.42169189453, 19.332748413086),
	vector3(-1065.3070068359, -832.23223876953, 19.332735061646),
	vector3(-1066.3269042969, -832.69787597656, 22.929609298706),
	vector3(-1065.6649169922, -832.70196533203, 26.953695297241),
}

local elevatorShafts = {
	[1] = {
		name = "Vespucci PD Elevator 1",
		floors = {
			-- {coords = vector3(-1096.0742187500, -849.05603027344, 34.639865875244), name = "Floor 5", desc = "On-Call Flight Service"}, -- Disabled cos room not load
			{coords = vector3(-1095.8829345703, -848.80572509766, 30.916748046875), name = "Floor 4", desc = "Conference"},
			{coords = vector3(-1095.9305419922, -848.87792968750, 26.953836441040), name = "Floor 3", desc = "Detective Unit, Cafeteria"},
			{coords = vector3(-1095.7580566406, -848.75970458984, 22.930576324463), name = "Floor 2", desc = "Chief of Staff Office, Operations Unit"},
			{coords = vector3(-1095.8386230469, -848.82183837891, 19.332763671875), name = "Floor 1", desc = "Main Hall, Press Room, Testimony"},
			{coords = vector3(-1095.7462158203, -849.12042236328, 13.337587356567), name = "Basement 1", desc = "Locker Rooms, Armory, Interrogation, Holding Cells"},
			{coords = vector3(-1096.0853271484, -848.51428222656, 8.8768911361694), name = "Basement 2", desc = "Forensics"},
			{coords = vector3(-1095.9346923828, -848.74890136719, 4.8650169372559), name = "Basement 3", desc = "Garages"},
		},
		jobs = {"sheriff", "corrections"}
	},
	[2] = {
		name = "Vespucci PD Elevator 2",
		floors = {
			{coords = vector3(-1066.2354736328, -832.96258544922, 26.953632354736), name = "Floor 3", desc = "Detective Unit, Cafeteria"},
			{coords = vector3(-1066.3294677734, -832.89196777344, 22.929658889771), name = "Floor 2", desc = "Chief of Staff Office, Operations Unit"},
			{coords = vector3(-1066.3283691406, -832.94006347656, 19.332738876343), name = "Floor 1", desc = "Main Hall, Press Room, Testimony"},
			{coords = vector3(-1066.3439941406, -832.82312011719, 13.33758354187), name = "Basement 1", desc = "Locker Rooms, Armory, Interrogation, Holding Cells"},
			{coords = vector3(-1066.4045410156, -832.84204101563, 8.876841545105), name = "Basement 2", desc = "Forensics"},
			{coords = vector3(-1066.3767089844, -832.70184326172, 4.8650569915771), name = "Basement 3", desc = "Garages"},
		},
		jobs = {"sheriff", "corrections"}
	}
}

local locationsData = {}
for i,e in ipairs(elevatorShafts) do
	for f,v in ipairs(e.floors) do
		table.insert(locationsData, {
			coords = v.coords,
			text = "[E] - Elevator"
		})
	end
end
exports.globals:register3dTextLocations(locationsData)

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Elevator", "Use the menu to go to the right floor!", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(mainMenu)

local menuOpenedAt = nil
local menuOpen = false

Citizen.CreateThread(function()
	while true do
		while menuOpen do
			Citizen.Wait(0)
			_menuPool:MouseControlsEnabled(false)
			_menuPool:ControlDisablingEnabled(false)
			_menuPool:ProcessMenus()
			if not mainMenu:Visible() then
				mainMenu:Visible(false)
				mainMenu:Clear()
				menuOpenedAt = nil
				menuOpen = false
			end
		end
		Citizen.Wait(100)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(10)
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed, false)
		if IsControlJustPressed(1, 38) then
			for i = 1, #elevatorShafts do
				for e,f in ipairs(elevatorShafts[i].floors) do
					if Vdist(playerCoords, f.coords.x, f.coords.y, f.coords.z)  <  2 then
						if not mainMenu:Visible() then
							TriggerServerEvent("usa_elevator:checkJob", elevatorShafts[i].jobs, i)
						else
							mainMenu:Visible(false)
							mainMenu:Clear()
							menuOpenedAt = nil
							menuOpen = false
						end
					end
				end
			end
		end
		if menuOpenedAt ~= nil then
			if #(GetEntityCoords(PlayerPedId()) - menuOpenedAt) > 5.0 then
				mainMenu:Visible(false)
				mainMenu:Clear()
				menuOpenedAt = nil
				menuOpen = false
			end
		end
	end
end)

RegisterNetEvent("usa_elevator:openMenu")
AddEventHandler("usa_elevator:openMenu", function(number)
	menuOpen = true
	CreateElevatorMenu(elevatorShafts[number], mainMenu)
    mainMenu:Visible(true)
    menuOpenedAt = GetEntityCoords(PlayerPedId())
end)

function CreateElevatorMenu(elevator, menu)
	local playerPed = PlayerPedId()
	menu:Clear()
	for i = 1, #elevator.floors do
      local item = NativeUI.CreateItem(elevator.floors[i].name, elevator.floors[i].desc)
      item.Activated = function(parentmenu, selected)
      	DoScreenFadeOut(500)
      	Wait(500)
      	SetEntityCoords(playerPed, elevator.floors[i].coords.x, elevator.floors[i].coords.y, elevator.floors[i].coords.z, 0, 0, 0, 0)
      	Wait(500)
      	DoScreenFadeIn(500)
      end
      menu:AddItem(item)
    end
end

_menuPool:RefreshIndex()

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		local player = PlayerPedId()
		local playerCoords = GetEntityCoords(player)
		for i,v in ipairs(LockedElevatorDoors) do
			if #(playerCoords - v) < 20 then
				local gateObject1 = GetClosestObjectOfType(v, 6.0, 1219957182, false, false, false)
				FreezeEntityPosition(gateObject1, true)
				local gateObject2 = GetClosestObjectOfType(v, 6.0, -1225363909, false, false, false)
				FreezeEntityPosition(gateObject2, true)
			end
		end
	end
end)