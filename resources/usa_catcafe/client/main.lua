-- CONFIG STUFF
local ITEMS = {}
TriggerServerEvent("catcafe:loadItems")

local standardPress = "[E] - "
local startWork = standardPress .. "Start work"
local quitWork = standardPress .. "Quit work"

local MAX_TIME_BEFORE_STRIKE_ISSUED = 600 * 1000

local signedIn = nil

local utils = {
    {x = -586.24530029297, y = -1061.9525146484, z = 22.344198226929, model = "hot"},
    {x = -590.30438232422, y = -1058.7884521484, z = 22.344200134277, model = "cold"},
    {x = -590.22509765625, y = -1056.5557861328, z = 22.355806350708, model = "indiv"},
    {x = -590.33337402344, y = -1062.9862060547, z = 22.356174468994, model = "combos"}
}
-- Default variables. No touchy
local working = "no"
local createdMenus = {}
local CurrentRank = nil
local rankTime = 1.5

-- Pay/Bonus variables
local payBonus = 0
local PayCounter = 0

-- xp things
local cooldown = false
local checker = false

-- CONFIG END

-- MENUS
_menuPool = NativeUI.CreatePool()

individualItem = NativeUI.CreateMenu("Individual Menu", "~b~Please select an item!", 0 --[[X COORD]], 320 --[[Y COORD]])
table.insert(createdMenus, { menu = individualItem, category = "indiv", model = "indiv"})
comboItems = NativeUI.CreateMenu("Combo Menu", "~b~Please select an item!", 0 --[[X COORD]], 320 --[[Y COORD]])
table.insert(createdMenus, { menu = comboItems, category = "combos", model = "combos"})
hotDrinks = NativeUI.CreateMenu("Hot Drinks", "~b~Please select an item!", 0 --[[X COORD]], 320 --[[Y COORD]])
table.insert(createdMenus, { menu = hotDrinks, category = "hotdrinks", model = "hot"})
coldDrinks = NativeUI.CreateMenu("Cold Drinks", "~b~Please select an item!", 0 --[[X COORD]], 320 --[[Y COORD]])
table.insert(createdMenus, { menu = coldDrinks, category = "colddrinks", model = "cold"})

for i = 1, #createdMenus do
    _menuPool:Add(createdMenus[i].menu)
end

RegisterNetEvent("catcafe:loadItems")
AddEventHandler("catcafe:loadItems", function(items)
    ITEMS = items
    for i = 1, #createdMenus do
        CreateMenu(createdMenus[i].menu, createdMenus[i].category)
    end
    _menuPool:RefreshIndex()
end)
-- MENU END

RegisterNetEvent('catcafe:checkStrikes')
AddEventHandler('catcafe:checkStrikes', function(strikes)
    if strikes >= 3 then
        hrNotify('You have 3 or more strikes to your name. You will now need to pay $3,000 to clear the strikes against you.','error')
        showPay()
    else
        TriggerServerEvent("catcafe:startJob")
        working = 'yes'
        hrNotify('You are now working for Cat Cafe. Welcome!', 'success')
        signedIn = GetGameTimer()
        ShowHelp()
    end
end)

RegisterNetEvent('catcafe:xpNotify')
AddEventHandler('catcafe:xpNotify', function(xpEarning)
    local earned = xpEarning
    xpnotify(earned)
end)

RegisterNetEvent('catcafe:quitJob')
AddEventHandler('catcafe:quitJob', function()
    working = 'no'
    hrNotify('You are no longer working for Cat Cafe.', 'inform')
end)

RegisterNetEvent('catcafe:rank')
AddEventHandler('catcafe:rank', function(rank)
    CurrentRank = rank
end)

RegisterNetEvent('catcafe:updateRank')
AddEventHandler('catcafe:updateRank', function(rank)
    if rank ~= CurrentRank then
        CurrentRank = rank
        rankTime = config_cl.ranks[rank].craftAdjustmentTime
        payBonus = config_cl.ranks[rank].PayBonus
        hrNotify("You have reached a new rank! Your rank is now "..rank.."! Congrats!", 'success')
    end
end)

RegisterNetEvent('catcafe:loaddata')
AddEventHandler('catcafe:loaddata', function(data)
    CurrentRank = data.a
    rankTime = data.b
    payBonus = data.c
    if config_cl.debugMode then
        print("Rank - "..CurrentRank.." | AdjustmentTime - "..rankTime.." | Pay Bonus - "..payBonus..".")
    end
end)

RegisterNetEvent('catcafe:firsttime')
AddEventHandler('catcafe:firsttime', function(data)
    CurrentRank = "Trainee"
    rankTime = 1.5
    payBonus = 100
end)

local aCounter = 0
RegisterNetEvent('catcafe:paybonus')
AddEventHandler('catcafe:paybonus', function(amount)
    local bonus = amount
    if PayCounter >= config_cl.payRandomizer then
        PayCounter = 0
        hrNotify("You've received a bonus of $"..bonus.."!")
        TriggerServerEvent("catcafe:payB", true)
        if config_cl.debugMode then
            aCounter = aCounter + 1
            print("Bonus received of $"..bonus)
            print("Received ["..aCounter.."] bonuses.")
        end
    end
end)

RegisterNetEvent('catcafe:toggleClockOn')
AddEventHandler('catcafe:toggleClockOn', function()
    if working == 'no' then
        TriggerServerEvent('catcafe:checkCriminalHistory')
        TriggerServerEvent("catcafe:getrank")
        TriggerServerEvent('catcafe:retrievestats')
    else
        TriggerServerEvent("catcafe:quitJob")
        working = "no"
        addStrikeCheck()
    end
end)

-- handles kitchen actions
Citizen.CreateThread(function()
    while true do
        if _menuPool:IsAnyMenuOpen() then
            _menuPool:MouseControlsEnabled(false)
            _menuPool:ControlDisablingEnabled(false)
            _menuPool:ProcessMenus()
        end
        if working == 'yes' then
            for k = 1, #utils do
                local location = table.pack(utils[k].x, utils[k].y, utils[k].z)
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
                if dist > 12 then
                    _menuPool:CloseAllMenus(utils[k].model)
                end
            end
        end
        Wait(1)
    end
end)

-- Spawn NPC to clock in
local employerNPCHandle = nil
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId(), false)
        local x,y,z = table.unpack(config_cl.NPC_COORDS)
        if Vdist(playerCoords, x, y, z) < 40 then
            if not employerNPCHandle then
                RequestModel(GetHashKey(config_cl.NPC_PED_MODEL))
                while not HasModelLoaded(config_cl.NPC_PED_MODEL) do
                    RequestModel(config_cl.NPC_PED_MODEL)
                    Wait(1)
                end
                employerNPCHandle = CreatePed(0, config_cl.NPC_PED_MODEL, x, y, z, config_cl.NPC_HEADING, false, false) -- need to add distance culling
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
            if Vdist(playerCoords, -580.74768066406, -1061.9881591797, 22.347269058228) > 40 then
                TriggerServerEvent("catcafe:quitJob")
                hrNotify("Leaving already? You're done buddy. Here's a strike", 'error')
                working = "no"
                addStrikeCheck()
                if config_cl.debugMode then
                    print("User went too far from work radius. Adding strike & forcing quit.")
                end
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
                    local hasBeenStationaryTooLong = GetGameTimer() - startTimeBeingStationary > (config_cl.stationaryKickTime * 60 * 1000)
                    if hasBeenStationaryTooLong then
                        TriggerServerEvent("catcafe:quitJob")
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

CreateThread(function()
    local cooldownTimer = config_cl.xpCooldown * 60 * 1000
    local timer = nil
	while true do
        if working == "yes" then
            if cooldown then
                Wait(cooldownTimer)
                cooldown = false
                if config_cl.debugMode then
                    print("Setting cooldown to false")
                end
            end
        end
        Wait(500)
	end
end)

local spawned = false
local cats = {}

CreateThread(function()
    while true do
        Wait(500)
        local plyPed = PlayerPedId()
        local coord = GetEntityCoords(plyPed)
        local catcafe = vector3(-579.46893310547, -1058.4190673828, 22.344200134277)
        if Vdist(coord.x, coord.y, coord.z, catcafe.x, catcafe.y, catcafe.z) < 30.0 then
            if not spawned then
                spawnCats()
                spawned = true
                if config_cl.debugMode then
                    print("Cats are spawning")
                end
            end
        else
            if spawned then
                deleteCats()
                spawned = false
                if config_cl.debugMode then
                    print("Cats are despawning")
                end
            end
        end
    end
end)

function spawnCats()
    local hash = GetHashKey('a_c_cat_01')
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(10)
    end
    for key, value in pairs(config_cl.Gatos) do
        local pedCoords = vector3(value.coords.x, value.coords.y, value.coords.z - 1.0)
        local pedHeading = value.coords.w
        local ped = CreatePed(28, hash, pedCoords, pedHeading, false, true)
        SetPedCanBeTargetted(ped, false)
        SetEntityAsMissionEntity(ped, true, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        if value.sitting then
            DoRequestAnimSet('creatures@cat@amb@world_cat_sleeping_ground@idle_a')
            TaskPlayAnim(ped, 'creatures@cat@amb@world_cat_sleeping_ground@idle_a', 'idle_a', 8.0, -8, -1, 1, 0, false, false, false)
        else
            TaskWanderStandard(ped, 10.0, 0)
        end
        cats[key] = ped
    end
    SetModelAsNoLongerNeeded(hash)
end

function deleteCats()
    for key, ped in pairs(cats) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
        cats[key] = nil
    end
end

function DoRequestAnimSet(anim)
	RequestAnimDict(anim)
	while not HasAnimDictLoaded(anim) do
		Citizen.Wait(1)
	end
end

function addStrikeCheck()
    if signedIn then
        local strikeCounter = signedIn + MAX_TIME_BEFORE_STRIKE_ISSUED
        if GetGameTimer() < strikeCounter then
            TriggerServerEvent("catcafe:addStrike")
            hrNotify('Clocking out already? You have gained 1 strike against your name.', 'error')
            Wait(8000)
            hrNotify('If you get 3 strikes you will have to pay a fine to work again.', 'inform')
        end
    end
end

function nearMarker(x, y, z)
    local mycoords = GetEntityCoords(GetPlayerPed(-1))
    return GetDistanceBetweenCoords(x, y, z, mycoords.x, mycoords.y, mycoords.z, true) < config_cl.textDistance
end

function promptJob(location)
    local x,y,z = table.unpack(location)
    if working == 'no' then
        DrawText3D(x,y,z, 8, startWork)
        if IsControlJustPressed(0, 38) then
            TriggerServerEvent('catcafe:checkCriminalHistory')
            TriggerServerEvent("catcafe:getrank")
            TriggerServerEvent('catcafe:retrievestats')
        end
    else
        DrawText3D(x,y,z,  5, quitWork)
        if IsControlJustPressed(0, 38) then
            TriggerServerEvent("catcafe:quitJob")
            working = "no"
            addStrikeCheck()
            if config_cl.debugMode then
                print("User quit job.")
            end
        end
    end
end

function CreateMenu(menu, category)
    for i = 1, #ITEMS[category] do
        local product = ITEMS[category][i]
        local item = NativeUI.CreateItem(product.name, "Ingredients Cost: $" .. exports["globals"]:comma_value(product.price))
        item.Activated = function(parentmenu, seleseted)
            local adjustment = rankTime
            if config_cl.debugMode then
                print(config_cl.prepTimes[category].time * 1000)
                print(config_cl.prepTimes[category].time * 1000 * adjustment)
                if CurrentRank ~= nil then
                    print("Rank - "..CurrentRank.." | AdjustmentTime - "..rankTime.." | Pay Bonus - "..payBonus..".")
                end
            end
            local PlayerHasMoney = TriggerServerCallback {
                eventName = "catcafe:PlayerHasIngredientMoney",
                args = {category, i}
            }
            if not PlayerHasMoney then
                notify('Cafe Alert','You can not craft this item! You do not have the funds.','error')
                return
            end
            if lib.progressBar({
                duration = config_cl.prepTimes[category].time * 1000 * adjustment,
                label = 'Preparing',
                useWhileDead = false,
                canCancel = true,
                anim = {
                    dict = 'amb@prop_human_bbq@male@idle_a',
                    clip = 'idle_a'
                },
                prop = {
                    model = 'bkr_prop_coke_spatula_02',
                    pos = vec3(0.03, 0.03, 0.02),
                    rot = vec3(0.0, 0.0, -1.5)
                },
                disable = {
                    move = true,
                    combat = true
                },
            }) then 
                -- When completed
                local itemsFound = TriggerServerCallback {
                    eventName = "catcafe:removecashforingredients",
                    args = {category, i}
                }
                taskCompleted(itemsFound)
            else 
                -- When Cancelled 
                notify('Cafe Alert','You stopped crafting your item!','error')
            end
        end
        if product.name ~= "" then
            menu:AddItem(item)
        end
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

function showPay()
    TriggerEvent("chatMessage", "", {}, "^3INFO: ^0To pay your fine use the following /payuwufines")
    Wait(3000)
end

function ShowHelp()
    TriggerEvent("chatMessage", "", {}, "^3INFO: ^0If you do not work here for a minimum of 10 minutes you will receive a strike against your name. 3 strikes and you will not be able to come back and work without paying a fine.")
    Wait(3000)
    TriggerEvent("chatMessage", "", {}, "^3INFO: ^0Head into the kitchen. Press ^3E ^0 on some of the utilities to make food and drink for customers.")
    Wait(3000)
end

function hrNotify(message,type)
    lib.notify({
        title = "Cat Cafe Human Resources",
        description = message,
        type = type,
        duration = 7000,
        position = 'top'
    })
end

function notify(title,message,type)
    lib.notify({
        title = title,
        description = message,
        type = type,
        duration = 7000,
        position = 'top'
    })
end

function xpnotify(xp)
    lib.notify({
        title = "XP Earned",
        description = "You earned "..xp.." xp!",
        type = 'success',
        duration = 5000,
        position = 'top'
    })
end

function taskCompleted(bool)
    if bool then
        TriggerServerEvent('catcafe:addxp', cooldown)
        if not cooldown then
            cooldown = true
            if config_cl.debugMode then print("XP Cooldown is set to true") end
        end
        TriggerServerEvent('catcafe:rankStatus')
        PayCounter = PayCounter + 1
        TriggerEvent("catcafe:paybonus", payBonus)
        notify('Cafe', 'You successfully crafted an item.')
    else
        notify('Cafe Alert','Your item was not crafted!','error')
        if config_cl.debugMode then print("Result was false, sending error alert.") end
    end
end