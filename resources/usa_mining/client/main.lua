local MINING = {
    {x = 1797.88, y = -2831.8, z = 3.57, radius = 30},
    {x = -592.55, y = 2076.86, z = 131.37, radius = 30}
}

local currentlyMining = false

Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        for i = 1, #MINING do
            if nearMarker(MINING[i].x, MINING[i].y, MINING[i].z, MINING[i].radius) then
                exports.globals:DrawText3D(MINING[i].x, MINING[i].y, MINING[i].z, '[E] - Start Mining')
                if IsControlJustPressed(0, 86) and not IsPedInAnyVehicle(player) and not currentlyMining then
                    TriggerServerEvent('mining:doesUserHaveCorrectItems')
                end
            end
        end
        Wait(0)
    end
end)

RegisterNetEvent('mining:startMining')
AddEventHandler('mining:startMining', function()
    if not currentlyMining then
        currentlyMining = true
        local ped = PlayerPedId()
        local begintime = GetGameTimer()
        local mycoords = GetEntityCoords(ped)
        local propaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), mycoords.x, mycoords.y, mycoords.z,  true,  true, true)
        exports.globals:loadAnimDict("melee@large_wpn@streamed_core")
        FreezeEntityPosition(ped, true)
        while GetGameTimer() - begintime < Config.MINING_ANIM_DURATION do
            exports.globals:DrawTimerBar(begintime, 15000, 1.42, 1.475, 'Mining')
            DisableControlAction(0, 244, true) -- 244 = M key (interaction menu / inventory)
            DisableControlAction(0, 86, true) -- prevent spam clicking
            if not IsEntityPlayingAnim(ped, "melee@large_wpn@streamed_core", "ground_attack_on_spot", 3) then
                AttachEntityToEntity(propaxe, ped, GetPedBoneIndex(ped, 57005), 0.08, -0.4, -0.10, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
                TaskPlayAnim(ped, "melee@large_wpn@streamed_core", "ground_attack_on_spot", 8.0, 1.0, 15000, 1.0, false, false, false)
            end
            Wait(1)
        end
        FreezeEntityPosition(ped, false)
        ClearPedTasksImmediately(ped)
        DetachEntity(propaxe, 1, 1)
        DeleteObject(propaxe)
        TriggerServerEvent('mining:giveUserMiningGoods')
        currentlyMining = false
    end
end)

local purchaser = 'a_f_y_business_01'
local purchase_location = {x = -629.08, y = -265.75, z = 38.79}
local BASE_SELL_TIME = 5000

local NPCHandle = nil
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId(), false)
        if Vdist(playerCoords, purchase_location.x, purchase_location.y, purchase_location.z) < 40 then
            if not NPCHandle then
                RequestModel(GetHashKey(purchaser))
                while not HasModelLoaded(purchaser) do
                    RequestModel(purchaser)
                    Wait(1)
                end
                NPCHandle = CreatePed(0, purchaser, purchase_location.x, purchase_location.y, purchase_location.z, 0.1, false, false)
                SetEntityCanBeDamaged(NPCHandle, false)
                SetPedCanRagdollFromPlayerImpact(NPCHandle, false)
                SetBlockingOfNonTemporaryEvents(NPCHandle, true)
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
        if nearMarker(purchase_location.x, purchase_location.y, purchase_location.z, 3) then
            exports.globals:DrawText3D(purchase_location.x, purchase_location.y, purchase_location.z, '[E] - Sell Goods | [H] - Hint')
            if IsControlJustPressed(0, 86) and not IsPedInAnyVehicle(PlayerPedId()) then
                local thisSellTime = BASE_SELL_TIME + math.random(1000, 5000)
                local beginTime = GetGameTimer()
                while GetGameTimer() - beginTime < thisSellTime do
                    exports.globals:DrawTimerBar(beginTime, thisSellTime, 1.42, 1.475, 'Selling Mined Goods')
                    DisableControlAction(0, 244, true) -- 244 = M key (interaction menu / inventory)
                    DisableControlAction(0, 38, true) -- prevent spam clicking
                    Wait(1)
                end
                TriggerServerEvent('mining:sellMinedItems')
            elseif IsControlJustPressed(0, 104) then
                exports.globals:notify("Hey!", "Buyer: I'll buy any mined goods you have or any rare jewels you might have!")
            end
        end
        Wait(1)
    end
end)


function nearMarker(x, y, z, radius)
    local coords = GetEntityCoords(PlayerPedId())
    return Vdist(x, y, z, coords.x, coords.y, coords.z) < radius
end
