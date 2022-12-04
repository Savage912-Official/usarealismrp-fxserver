-- CONFIG STUFF
local ITEMS = {}
TriggerServerEvent("burgerjob:loadItems")

local standardPress = "[E] - "
local startWork = standardPress .. "Start work"
local quitWork = standardPress .. "Quit work"

local NPC_PED_MODEL = "csb_burgerdrug"
local NPC_COORDS = {-1190.24, -897.37, 14.0}

local JOB_START_TEXT_DIST = 1.5

local STATIONARY_TIME_KICK_MINS = 10
local MAX_TIME_BEFORE_STRIKE_ISSUED = 600 * 1000

local ANIMATION_TIME_SECONDS = 50

local signedIn = nil

local utils = {
    {x = -1198.91, y = -895.17, z = 14.0, model = "smoothie"},
    {x = -1199.66, y = -900.84, z = 14.0, model = "burgers"},
    {x = -1201.17, y = -898.72, z = 14.0, model = 'frying'}
}

local working = "no"
local createdMenus = {}
-- CONFIG END

-- MENUS
_menuPool = NativeUI.CreatePool()

foodMenu = NativeUI.CreateMenu("Burger Menu", "~b~Please select an item!", 0 --[[X COORD]], 320 --[[Y COORD]])
table.insert(createdMenus, { menu = foodMenu, category = "Burgers", model = "burgers"})
sodaMenu = NativeUI.CreateMenu("Soda Machine", "~b~Please select an item!", 0 --[[X COORD]], 320 --[[Y COORD]])
table.insert(createdMenus, { menu = sodaMenu, category = "Soda", model = "smoothie"})
waterMenu = NativeUI.CreateMenu("Frying Menu", "~b~Please select an item!", 0 --[[X COORD]], 320 --[[Y COORD]])
table.insert(createdMenus, { menu = waterMenu, category = "Fry", model = "frying"})

for i = 1, #createdMenus do
    _menuPool:Add(createdMenus[i].menu)
end

RegisterNetEvent("burgerjob:loadItems")
AddEventHandler("burgerjob:loadItems", function(items)
    ITEMS = items
    for i = 1, #createdMenus do
        CreateMenu(createdMenus[i].menu, createdMenus[i].category)
    end
    _menuPool:RefreshIndex()
end)
-- MENU END

RegisterNetEvent('burgerjob:checkStrikes')
AddEventHandler('burgerjob:checkStrikes', function(strikes)
    if strikes >= 3 then
        exports.globals:notify('You have 3 or more strikes to your name. You will now need to pay $3,000 to clear the strikes against you.')
        showPay()
    else
        TriggerServerEvent("burgerjob:startJob")
        working = 'yes'
        exports.globals:notify('You are now working for Burger Shot.')
        signedIn = GetGameTimer()
        ShowHelp()
    end
end)

RegisterNetEvent('burgerjob:quitJob')
AddEventHandler('burgerjob:quitJob', function()
    working = 'no'
    exports.globals:notify('You are no longer working for Burger Shot.')
end)

-- handle clocking in / out
Citizen.CreateThread(function()
    while true do
        local x,y,z = table.unpack(NPC_COORDS)
        if nearMarker(x,y,z) then
            promptJob(NPC_COORDS)
        end
        Wait(0)
    end
end)

-- handles kitchen actions
Citizen.CreateThread(function()
    while true do
        _menuPool:MouseControlsEnabled(false)
        _menuPool:ControlDisablingEnabled(false)
        _menuPool:ProcessMenus()
        for k = 1, #utils do
            local location = table.pack(utils[k].x, utils[k].y, utils[k].z)
            if working == 'yes' then
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, utils[k].x, utils[k].y, utils[k].z)
                if dist < 1 then
                    DrawText3D(utils[k].x, utils[k].y, utils[k].z, 1, "[E] - Open Menu")
                    if IsControlJustPressed(0, 38) then
                        if _menuPool:IsAnyMenuOpen() then
                            _menuPool:CloseAllMenus()
                        end
                        for j = 1, #createdMenus do
                            if utils[k].model == createdMenus[j].model then
                                createdMenus[j].menu:Visible(true)
                            end
                        end
                        break
                    end
                end
                if Vdist(plyCoords.x, plyCoords.y, plyCoords.z, utils[k].x, utils[k].y, utils[k].z) > 6 then
                    _menuPool:CloseAllMenus(utils[k].model)
                end
            end
        end
        Wait(0)
    end
end)

-- Spawn NPC to clock in
local employerNPCHandle = nil
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId(), false)
        local x,y,z = table.unpack(NPC_COORDS)
        if Vdist(playerCoords, x, y, z) < 40 then
            if not employerNPCHandle then
                RequestModel(GetHashKey(NPC_PED_MODEL))
                while not HasModelLoaded(NPC_PED_MODEL) do
                    RequestModel(NPC_PED_MODEL)
                    Wait(1)
                end
                employerNPCHandle = CreatePed(0, NPC_PED_MODEL, x, y, z, 0.1, false, false) -- need to add distance culling
                SetEntityCanBeDamaged(employerNPCHandle,false)
                SetPedCanRagdollFromPlayerImpact(employerNPCHandle,false)
                SetBlockingOfNonTemporaryEvents(employerNPCHandle,true)
                SetPedFleeAttributes(employerNPCHandle,0,0)
                SetPedCombatAttributes(employerNPCHandle,17,1)
            end
        else 
            if employerNPCHandle then
                DeletePed(employerNPCHandle)
                employerNPCHandle = nil
            end
        end
        Wait(1)
    end
end)

-- If player travels away from the location then kick them from the job.
Citizen.CreateThread(function ()
    while true do
        if working == 'yes' then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed, true)
            if Vdist(playerCoords, -1194.31, -892.23, 14.0) > 40 then
                TriggerServerEvent("burgerjob:quitJob")
                exports.globals:notify("You have been removed from working at BurgerShot!")
                working = "no"
                addStrikeCheck()
            end
        end
        Wait(1)
    end
end)

-- Kick the player after X mins if they're just standing still
Citizen.CreateThread(function()
    local startTimeBeingStationary = nil
    local startCoordsBeingStationary = nil
    while true do
        local myped = PlayerPedId()
        local mycoords = GetEntityCoords(myped)
        if working == 'yes' then
            if startTimeBeingStationary and startCoordsBeingStationary then
                if Vdist(mycoords, startCoordsBeingStationary) < 1.5 then
                    local hasBeenStationaryTooLong = GetGameTimer() - startTimeBeingStationary > (STATIONARY_TIME_KICK_MINS * 60 * 1000)
                    if hasBeenStationaryTooLong then
                        TriggerServerEvent("burgerjob:quitJob")
                        addStrikeCheck()
                    end
                else
                    startTimeBeingStationary = GetGameTimer()
                    startCoordsBeingStationary = mycoords
                end
            else 
                startTimeBeingStationary = GetGameTimer()
                startCoordsBeingStationary = mycoords
            end
        else 
            if startCoordsBeingStationary and startTimeBeingStationary then
                startTimeBeingStationary = nil
                startCoordsBeingStationary = nil
            end
        end
        Wait(100)
    end
end)

function addStrikeCheck()
    if signedIn then
        local strikeCounter = signedIn + MAX_TIME_BEFORE_STRIKE_ISSUED
        if GetGameTimer() < strikeCounter then
            TriggerServerEvent("burgerjob:addStrike")
            exports.globals:notify('Clocking out already? You have gained 1 strike against your name.')
            Wait(8000)
            exports.globals:notify('If you get 3 strikes you will have to pay a fine to work again.')
        end
    end
end

function nearMarker(x, y, z)
    local mycoords = GetEntityCoords(GetPlayerPed(-1))
    return GetDistanceBetweenCoords(x, y, z, mycoords.x, mycoords.y, mycoords.z, true) < JOB_START_TEXT_DIST
end

function promptJob(location)
    local x,y,z = table.unpack(location)
    if working == 'no' then
        DrawText3D(x,y,z, 8, startWork)
        if IsControlJustPressed(0, 38) then
            TriggerServerEvent('burgerjob:checkCriminalHistory')
        end
    else
        DrawText3D(x,y,z,  5, quitWork)
        if IsControlJustPressed(0, 38) then
            TriggerServerEvent("burgerjob:quitJob")
            exports.globals:notify('You are no longer working for Burger Shot.')
            working = "no"
            addStrikeCheck()
        end
    end
end

function CreateMenu(menu, category)
    for i = 1, #ITEMS[category] do
        local product = ITEMS[category][i]
        local item = NativeUI.CreateItem(product.name, "Ingredients Cost: $" .. exports["globals"]:comma_value(product.price))
        item.Activated = function(parentmenu, seleseted)
            local beginTime = GetGameTimer()
            local pid = PlayerPedId()
            RequestAnimDict("friends@")
            while (not HasAnimDictLoaded("friends@")) do Citizen.Wait(0) end
            while GetGameTimer() - beginTime < ANIMATION_TIME_SECONDS * 1000 do
                if not IsEntityPlayingAnim(pid, "friends@", "pickupwait", 3) then
                    TaskPlayAnim(pid, "friends@", "pickupwait", 8.0, 1.0, -1, 11, 1.0, false, false, false)
                end
                DrawTimer(beginTime, ANIMATION_TIME_SECONDS * 1000, 1.42, 1.475, 'Preparing')
                Citizen.Wait(1)
            end
            ClearPedTasks(pid)
            TriggerServerEvent('burgerjob:removecashforingredients', category, i)
        end
        menu:AddItem(item)
    end
end

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
        local factor = (string.len(text)) / 470
        DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 11, 41, 68)
    end
end

function DrawTimer(beginTime, duration, x, y, text)
    if not HasStreamedTextureDictLoaded('timerbars') then
        RequestStreamedTextureDict('timerbars')
        while not HasStreamedTextureDictLoaded('timerbars') do
            Citizen.Wait(0)
        end
    end

    if GetTimeDifference(GetGameTimer(), beginTime) < duration then
        w = (GetTimeDifference(GetGameTimer(), beginTime) * (0.085 / duration))
    end

    local correction = ((1.0 - math.floor(GetSafeZoneSize(), 2)) * 100) * 0.005
    x, y = x - correction, y - correction

    Set_2dLayer(0)
    DrawSprite('timerbars', 'all_black_bg', x, y, 0.15, 0.0325, 0.0, 255, 255, 255, 180)

    Set_2dLayer(1)
    DrawRect(x + 0.0275, y, 0.085, 0.0125, 100, 0, 0, 180)

    Set_2dLayer(2)
    DrawRect(x - 0.015 + (w / 2), y, w, 0.0125, 150, 0, 0, 180)

    SetTextColour(255, 255, 255, 180)
    SetTextFont(0)
    SetTextScale(0.3, 0.3)
    SetTextCentre(true)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    Set_2dLayer(3)
    DrawText(x - 0.06, y - 0.012)
end

function showPay()
    TriggerEvent("chatMessage", "", {}, "^3INFO: ^0To pay your fine use the following /paybsfine")
    Wait(3000)
end

function ShowHelp()
    TriggerEvent("chatMessage", "", {}, "^3INFO: ^0If you do not work here for a minimum of 10 minutes you will receive a strike against your name. 3 strikes and you will not be able to come back and work without paying a fine.")
    Wait(3000)
    TriggerEvent("chatMessage", "", {}, "^3INFO: ^0Head into the kitchen. Press ^3E ^0 on some of the utilities to make food and drink for customers.")
    Wait(3000)
end