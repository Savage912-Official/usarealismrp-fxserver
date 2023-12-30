-- STAGE 1 - Thermite the electronic locks to gain access to the doors.
local thermite_loc = {x = -607.29, y = -245.78, z = 50.24}
local THERMITE_PLANT_ANIMATION_TIME = 30000

local canBeRobbed = false -- only available during certain hours

Citizen.CreateThread(function()
    while true do
        if GetClockHours() >= 0 and GetClockHours() < 9 then
            canBeRobbed = true
        else
            canBeRobbed = false
        end
        Wait(30000)
    end
end)

Citizen.CreateThread(function()
    while true do
        if canBeRobbed then
            local myped = PlayerPedId()
            if nearMarker(thermite_loc.x, thermite_loc.y, thermite_loc.z) and not IsEntityDead(myped) then
                exports.globals:DrawText3D(thermite_loc.x, thermite_loc.y, thermite_loc.z, '[E] - Rig Thermite')
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent('jewelleryheist:doesUserHaveThermiteToUse')
                end
            end
        end
        Wait(0)
    end
end)

RegisterNetEvent("jewelleryheist:plantThermite")
AddEventHandler("jewelleryheist:plantThermite", function()
    if canBeRobbed then
        local myped = PlayerPedId()
        local start = GetGameTimer()
        exports.globals:loadAnimDict("anim@move_m@trash")
        while GetGameTimer() - start < THERMITE_PLANT_ANIMATION_TIME do
            exports.globals:DrawTimerBar(start, THERMITE_PLANT_ANIMATION_TIME, 1.42, 1.475, 'Planting Thermite')
            if not IsEntityPlayingAnim(myped, "anim@move_m@trash", "pickup", 3) then
                TaskPlayAnim(myped, "anim@move_m@trash", "pickup", 8.0, 1.0, -1, 11, 1.0, false, false, false)
            end
            Wait(1)
        end
        ClearPedTasksImmediately(myped)
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 7, 'thermite', 0.5)
        Wait(2000)
        while securityToken == nil do
            Wait(1)
        end
        TriggerServerEvent('jewelleryheist:plantThermite', securityToken)
    end
end)

-- STAGE 2 - ROB THIS MOFUGGA
local BASE_SMASH_N_GRAB_TIME = 10000

local JewelleryCases = {}

RegisterNetEvent("jewelleryheist:loadCases")
AddEventHandler("jewelleryheist:loadCases", function(cases)
    JewelleryCases = cases
end)

TriggerServerEvent("jewelleryheist:loadCases")

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if canBeRobbed then
            local pid = PlayerPedId()
            local plyCoords = GetEntityCoords(pid, false)
            for k = 1, #JewelleryCases do
                if not JewelleryCases[k].robbed then
                    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, JewelleryCases[k].x, JewelleryCases[k].y, JewelleryCases[k].z)
                    if dist < 1.5 then
                        exports.globals:DrawText3D(JewelleryCases[k].x, JewelleryCases[k].y, JewelleryCases[k].z, '[E] - Smash')
                        if dist < 0.5 then
                            if IsControlJustPressed(1,51) then
                                if IsPedArmed(pid, 7) then
                                    TriggerServerEvent("jewelleryheist:attemptSmashNGrab", k)
                                else 
                                    exports.globals:notify("Can't break the glass!")
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("jewelleryheist:performSmashNGrab")
AddEventHandler("jewelleryheist:performSmashNGrab", function()
    local pid = PlayerPedId()
    local beginTime = GetGameTimer()
    exports.globals:loadAnimDict("missheist_jewel@first_person")
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 7, 'glassbreak', 0.5)
    local thisCaseTime = BASE_SMASH_N_GRAB_TIME + math.random(1000, 3000)
    while GetGameTimer() - beginTime < thisCaseTime do
        if not IsEntityPlayingAnim(pid, "missheist_jewel@first_person", "smash_case_e", 3) then
            TaskPlayAnim(pid, "missheist_jewel@first_person", "smash_case_e", 8.0, 1.0, -1, 11, 1.0, false, false, false)
        end
        exports.globals:DrawTimerBar(beginTime, thisCaseTime, 1.42, 1.475, 'Stealing Jewellery')
        Wait(1)
    end
    ClearPedTasks(pid)
    while securityToken == nil do
        Wait(1)
    end
    TriggerServerEvent('jewelleryheist:stolengoods', securityToken)
end)

RegisterNetEvent("jewelleryheist:caseSmashed")
AddEventHandler("jewelleryheist:caseSmashed", function(caseIndex)
    JewelleryCases[caseIndex].robbed = true
end)

RegisterNetEvent("jewelleryheist:resetCases")
AddEventHandler("jewelleryheist:resetCases", function()
    for i = 1, #JewelleryCases do
        JewelleryCases[i].robbed = false
    end
end)

-- Stage 3 if not caught, sell the stolen goods!
local purchaser = 'g_m_y_mexgoon_01'
local purchase_location = {-444.36715698242, 287.39889526367, 83.306907653809, 352.11660766602}
local BASE_SELL_TIME = 5000

local NPCHandle = nil
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId(), false)
        local x,y,z = table.unpack(purchase_location)
        if Vdist(playerCoords, x, y, z) < 40 then
            if not NPCHandle then
                RequestModel(GetHashKey(purchaser))
                while not HasModelLoaded(purchaser) do
                    RequestModel(purchaser)
                    Wait(1)
                end
                NPCHandle = CreatePed(0, purchaser, x, y, z, 0.1, false, false) -- need to add distance culling
                SetEntityCanBeDamaged(NPCHandle,false)
                SetPedCanRagdollFromPlayerImpact(NPCHandle,false)
                SetBlockingOfNonTemporaryEvents(NPCHandle,true)
                SetPedFleeAttributes(NPCHandle,0,0)
                SetPedCombatAttributes(NPCHandle,17,1)
            end
        else
            if NPCHandle then
                DeletePed(NPCHandle)
                NPCHandle = nil
            end
        end
        Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        local x,y,z = table.unpack(purchase_location)
        if nearMarker(x,y,z) then
            exports.globals:DrawText3D(x, y, z, '[E] - Sell Stolen Goods')
            promptSale(location)
        end
        Wait(0)
    end
end)

function promptSale()
    if IsControlJustPressed(0, 38) then
        TriggerServerEvent('jewelleryheist:doesUserHaveGoodsToSell')
    end
end

RegisterNetEvent('jewelleryheist:sellGoods')
AddEventHandler('jewelleryheist:sellGoods', function() -- action of selling to the ped spawned
    local thisSellTime = BASE_SELL_TIME + math.random(1000, 5000)
    local beginTime = GetGameTimer()
    while GetGameTimer() - beginTime < thisSellTime do
        exports.globals:DrawTimerBar(beginTime, thisSellTime, 1.42, 1.475, 'Selling Jewellery')
        DisableControlAction(0, 244, true) -- 244 = M key (interaction menu / inventory)
        DisableControlAction(0, 86, true) -- prevent spam clicking
        Wait(1)
    end
    TriggerServerEvent("jewelleryheist:sellstolengoods")
end)

function nearMarker(x, y, z)
    local p = GetEntityCoords(GetPlayerPed(-1))
    return Vdist(x, y, z, p.x, p.y, p.z) < 3
end