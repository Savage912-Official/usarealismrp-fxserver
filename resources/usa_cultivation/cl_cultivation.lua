local PRODUCTS = {}
local NEARBY_PLANTS = {}
local BUY_MENU = nil

local me = {
    ped = nil,
    coords = nil
}

local MENU_RADIUS = 1.5
local MENU_TEXT_RADIUS = 40
local PLANT_TEXT_RADIUS = 2.0

local ANIMATION_TIME_SECONDS = 10
local HARVEST_TIME_SECONDS = 60

local CLOSEST_PLANTS_BUFFER_INTERVAL_SECONDS = 3
local OBJECT_CULLING_DIST = 300.0

local KEYS = {
    E = 38
}

local POLL_INTERVAL_SECONDS = 5

local Whitelisted_Plant_Locations = {
	{
		coords = vector3(-8.560081, -2519.72, -9.939499),
		distance = 20
	},
}

local PLANT_BUY_LOCATION = vector3(413.22399902344, 6539.4467773438, 27.734628677368)

local function isAtWhitelistedLocation()
    local playerCoords = GetEntityCoords(PlayerPedId())
	for i = 1, #Whitelisted_Plant_Locations do
        if #(playerCoords - Whitelisted_Plant_Locations[i].coords) < Whitelisted_Plant_Locations[i].distance then
			return true
		end
	end
	return false
end

function DrawText3D(x, y, z, text)
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

function GetClosestPlant()
    if not me.ped then
        return
    end
    local closest = {
        _id = nil,
        dist = 9999999999
    }
    if NEARBY_PLANTS then
        for id, plant in pairs(NEARBY_PLANTS) do
            local dist = Vdist(me.coords.x, me.coords.y, me.coords.z, plant.coords.x, plant.coords.y, plant.coords.z)
            if dist < closest.dist and dist < 5.0 then
                closest._id = id
                closest.dist = dist
            end
        end
    end
    return closest
end

function DisablePlayerControls()
    DisableControlAction(0, 86, true)
    DisableControlAction(0, 244, true)
    DisableControlAction(0, 245, true)
    DisableControlAction(0, 288, true)
    DisableControlAction(0, 79, true)
    DisableControlAction(0, 73, true)
    DisableControlAction(0, 75, true)
    DisableControlAction(0, 37, true)
    DisableControlAction(0, 311, true)
end

function doAdjustZCoord(objName)
    local zCoordAdjustmenTable = {}
    zCoordAdjustmenTable["bkr_prop_weed_med_01a"] = -2.5
    zCoordAdjustmenTable["bkr_prop_weed_med_01b"] = -2.5
    zCoordAdjustmenTable["bkr_prop_weed_lrg_01b"] = -2.5

    if zCoordAdjustmenTable[objName] then
        return zCoordAdjustmenTable[objName]
    else
        return nil
    end
end

function ShowHelp()
    local msg = "'Use' the plant in your inventory to plant it. It will take about 14 whole days to enter its final stage at which point it becomes harvestable by 'using' large scisossors near it. Make sure you buy a watering can from the 24/7 and fertilizer from the hardware store and 'use' them near your plants to keep them alive! After harvesting, you can take weed buds to that big barn off Senora Freeway just North of the hardware store under Grapeseed to process them for sale. Corn can be processed at O'Neill's ranch and sold at the Grapeseed farmer's market."
    TriggerEvent("chatMessage", "", {}, "^3INFO: ^0" .. msg)
end

function LoadPlantModel(model)
    if not HasModelLoaded(model) then
        RequestModel(model)
    end
    while not HasModelLoaded(model) do
        Wait(10)
    end
end

function createPlantObject(plant)
    local objectModel = plant.stage.objectModels[1] -- use 1 because others have invisible collision issue
    local hash = GetHashKey(objectModel)
    local handle = nil
    if objectModel then
        local zCoordAdjustment = doAdjustZCoord(objectModel)
        if zCoordAdjustment then
            handle = CreateObject(hash, plant.coords.x, plant.coords.y, plant.coords.z + zCoordAdjustment, 0, 0, 0)
        else
            handle = CreateObject(hash, plant.coords.x, plant.coords.y, plant.coords.z, 0, 0, 0)
        end
        SetEntityAsMissionEntity(handle, 1, 1)
        FreezeEntityPosition(handle, true)
    end
    return handle
end

function updatePlantObjectStage(plant)
    local id = plant._id
    if NEARBY_PLANTS[id] then
        if NEARBY_PLANTS[id].objectHandle then -- plant object exists for client
            local obj = NEARBY_PLANTS[id].objectHandle
            DeleteObject(obj)
            local nextStageObj = plant.stage.objectModels[math.random(#(plant.stage.objectModels))]
            local hash = GetHashKey(nextStageObj)
            local zCoordAdjustment = doAdjustZCoord(nextStageObj)
            if zCoordAdjustment then
                obj = CreateObject(hash, plant.coords.x, plant.coords.y, plant.coords.z + zCoordAdjustment, 0, 0, 0)
            else 
                obj = CreateObject(hash, plant.coords.x, plant.coords.y, plant.coords.z, 0, 0, 0)
            end
            SetEntityAsMissionEntity(obj, 1, 1)
            NEARBY_PLANTS[id].objectHandle = obj
        end
    end
end

function updatePlantSustenance(plant)
    local id = plant._id
    if NEARBY_PLANTS[id] then
        NEARBY_PLANTS[id].foodLevel = plant.foodLevel
        NEARBY_PLANTS[id].waterLevel = plant.waterLevel
        NEARBY_PLANTS[id].isDead = plant.isDead
    end
end

RegisterNetEvent("cultivation:loadProducts")
AddEventHandler("cultivation:loadProducts", function(products)
    PRODUCTS = products
    BUY_MENU = {
        {
            header = "Select a plant:"
        }
    }
    for name, info in pairs(PRODUCTS) do
        table.insert(BUY_MENU,  {
            header = "(1x) " .. info.item.name,
            context = "$" .. exports.globals:comma_value(math.floor(info.cost)) .. " / ea.",
            --image = "show a cool image ending in jpg, png, gif, etc"  -- todo
            event = "cultivation:buy",
            args = {
                name
            }
        })
    end
end)

TriggerServerEvent("cultivation:loadProducts")

RegisterNetEvent("cultivation:loadNearbyPlants")
AddEventHandler("cultivation:loadNearbyPlants", function(nearbyPlants)
    -- add new nearby plants, update still nearby plants --
    for id, plant in pairs(nearbyPlants) do
        if not NEARBY_PLANTS[id] then
            NEARBY_PLANTS[id] = plant
            NEARBY_PLANTS[id].objectHandle = createPlantObject(plant)
        else
            for k, v in pairs(plant) do -- to avoid overwriting client side variables (like plant object handle)
                NEARBY_PLANTS[id][k] = v
            end
        end
    end
    -- delete plants that were close but now are too far away --
    for id, plant in pairs(NEARBY_PLANTS) do
        if not nearbyPlants[id] then
            if plant.objectHandle then
                DeleteObject(plant.objectHandle)
                plant.objectHandle = nil
            end
            NEARBY_PLANTS[id] = nil
        end
    end
end)

RegisterNetEvent("cultivation:plant")
AddEventHandler("cultivation:plant", function(type, itemName)
    if not IsPedInAnyVehicle(me.ped, true) then
        local plantCoords = { x = me.coords.x + 0.5, y = me.coords.y + 0.5, z = me.coords.z + 1.0 }
        if not IsPointOnRoad(plantCoords.x, plantCoords.y, plantCoords.z, vehicle) or isAtWhitelistedLocation() then
            local unkBool, groundZ = GetGroundZCoordWithOffsets(plantCoords.x, plantCoords.y, plantCoords.z)
            plantCoords.z = groundZ
            -- trigger server event to keep track of new plant
            TriggerServerEvent("cultivation:plant", type, itemName, plantCoords)
        else 
            exports.globals:notify("Can't place on road or not at a registered location!")
        end
    end
end)

RegisterNetEvent("cultivation:clientNewPlant")
AddEventHandler("cultivation:clientNewPlant", function(plant)
    NEARBY_PLANTS[plant._id] = plant
    NEARBY_PLANTS[plant._id].objectHandle = createPlantObject(plant)
end)

-- update's plant object model on stage update --
RegisterNetEvent("cultivation:updatePlantStageIfNearby")
AddEventHandler("cultivation:updatePlantStageIfNearby", function(plant)
    updatePlantObjectStage(plant)
end)

RegisterNetEvent("cultivation:updateSustenanceIfNearby")
AddEventHandler("cultivation:updateSustenanceIfNearby", function(plant)
    updatePlantSustenance(plant)
end)

RegisterNetEvent("cultivation:water")
AddEventHandler("cultivation:water", function()
    -- find nearest plant
    local closest = GetClosestPlant()
    if closest._id then
        if not HasAnimDictLoaded("anim@move_m@trash") then
            exports.globals:loadAnimDict("anim@move_m@trash")
        end
        local start = GetGameTimer()
        while GetGameTimer() - start < ANIMATION_TIME_SECONDS * 1000 do
            exports.globals:DrawTimerBar(start, ANIMATION_TIME_SECONDS * 1000, 1.42, 1.475, 'WATERING')
            DisablePlayerControls()
            if not IsEntityPlayingAnim(me.ped, "anim@move_m@trash", "pickup", 3) then
                TaskPlayAnim(me.ped, "anim@move_m@trash", "pickup", 8.0, 1.0, -1, 11, 1.0, false, false, false)
            end
            Wait(1)
        end
        ClearPedTasks(me.ped)
        TriggerServerEvent("cultivation:water", closest._id)
    else
        exports.globals:notify("No plant found!")
    end
end)

RegisterNetEvent("cultivation:feed")
AddEventHandler("cultivation:feed", function()
    -- find nearest plant
    local closest = GetClosestPlant()
    if closest._id then
        if not HasAnimDictLoaded("anim@move_m@trash") then
            exports.globals:loadAnimDict("anim@move_m@trash")
        end
        local start = GetGameTimer()
        while GetGameTimer() - start < ANIMATION_TIME_SECONDS * 1000 do
            exports.globals:DrawTimerBar(start, ANIMATION_TIME_SECONDS * 1000, 1.42, 1.475, 'FEEDING')
            DisablePlayerControls()
            if not IsEntityPlayingAnim(me.ped, "anim@move_m@trash", "pickup", 3) then
                TaskPlayAnim(me.ped, "anim@move_m@trash", "pickup", 8.0, 1.0, -1, 11, 1.0, false, false, false)
            end
            Wait(1)
        end
        ClearPedTasks(me.ped)
        TriggerServerEvent("cultivation:feed", closest._id)
    else
        exports.globals:notify("No plant found!")
    end
end)

RegisterNetEvent("cultivation:harvest")
AddEventHandler("cultivation:harvest", function()
    -- find nearest plant
    local closest = GetClosestPlant()
    if closest._id then
        if NEARBY_PLANTS[closest._id] and not NEARBY_PLANTS[closest._id].isDead then
            if not HasAnimDictLoaded("anim@move_m@trash") then
                exports.globals:loadAnimDict("anim@move_m@trash")
            end
            local start = GetGameTimer()
            while GetGameTimer() - start < HARVEST_TIME_SECONDS * 1000 do
                exports.globals:DrawTimerBar(start, HARVEST_TIME_SECONDS * 1000, 1.42, 1.475, 'HARVESTING')
                DisablePlayerControls()
                if not IsEntityPlayingAnim(me.ped, "anim@move_m@trash", "pickup", 3) then
                    TaskPlayAnim(me.ped, "anim@move_m@trash", "pickup", 8.0, 1.0, -1, 11, 1.0, false, false, false)
                end
                Wait(1)
            end
            ClearPedTasks(me.ped)
            TriggerServerEvent("cultivation:harvest", closest._id)
        else 
            exports.globals:notify("This plant is dead!", "^3INFO: ^0This plant is dead! Use a shovel to remove it!")
        end
    else
        exports.globals:notify("No plant found!")
    end
end)

RegisterNetEvent("cultivation:remove")
AddEventHandler("cultivation:remove", function(id, msg)
    if NEARBY_PLANTS[id] then
        if NEARBY_PLANTS[id].objectHandle then
            DeleteObject(NEARBY_PLANTS[id].objectHandle)
            NEARBY_PLANTS[id] = nil
        end
        if msg then 
            exports.globals:notify(msg)
        end
    end
end)

RegisterNetEvent("cultivation:shovel")
AddEventHandler("cultivation:shovel", function()
    -- find nearest plant
    local closest = GetClosestPlant()
    if closest._id then
        if not HasAnimDictLoaded("anim@move_m@trash") then
            exports.globals:loadAnimDict("anim@move_m@trash")
        end
        local start = GetGameTimer()
        while GetGameTimer() - start < ANIMATION_TIME_SECONDS * 1000 do
            exports.globals:DrawTimerBar(start, ANIMATION_TIME_SECONDS * 1000, 1.42, 1.475, 'SHOVELING')
            DisablePlayerControls()
            if not IsEntityPlayingAnim(me.ped, "anim@move_m@trash", "pickup", 3) then
                TaskPlayAnim(me.ped, "anim@move_m@trash", "pickup", 8.0, 1.0, -1, 11, 1.0, false, false, false)
            end
            Wait(1)
        end
        ClearPedTasks(me.ped)
        TriggerServerEvent("cultivation:shovel", closest._id)
    else
        exports.globals:notify("No plant found!")
    end
end)

RegisterNetEvent("cultivation:attemptToRemoveNearest")
AddEventHandler("cultivation:attemptToRemoveNearest", function()
    local closest = GetClosestPlant()
    TriggerServerEvent("cultivation:remove", closest._id)
end)

-- draw 3D text for all NEARBY_PLANTS within PLANT_TEXT_RADIUS distance --
Citizen.CreateThread(function()
    while true do
        if NEARBY_PLANTS and me.coords then
            for id, plant in pairs(NEARBY_PLANTS) do
                local dist = Vdist(me.coords.x, me.coords.y, me.coords.z, plant.coords.x, plant.coords.y, plant.coords.z)
                if dist < PLANT_TEXT_RADIUS then
                    local water = plant.waterLevel.asString
                    local food = plant.foodLevel.asString
                    if not plant.isDead then
                        DrawText3D(plant.coords.x, plant.coords.y, plant.coords.z, plant.type .. " Plant | " .. water .. " | " .. food .. (plant.stage.name == "harvest" and " | Ready" or ""))
                    else
                        DrawText3D(plant.coords.x, plant.coords.y, plant.coords.z, plant.type .. " Plant | ~r~Dead~w~")
                    end
                end
            end
        end
        Wait(1)
    end
end)

-- update global player ped and ped coords variables --
Citizen.CreateThread(function()
    while true do
        me.ped = PlayerPedId()
        me.coords = GetEntityCoords(me.ped)
        Wait(1)
    end
end)

-- poll the server for nearest plant data every POLL_INTERVAL_SECONDS seconds --
Citizen.CreateThread(function()
    local lastCheck = 0
    while true do
        if GetGameTimer() - lastCheck > POLL_INTERVAL_SECONDS * 1000 then
            local mycoords = GetEntityCoords(PlayerPedId())
            TriggerServerEvent("cultivation:loadNearbyPlants", mycoords)
            lastCheck = GetGameTimer()
        end
        Wait(1)
    end
end)

-- listen for plant purchase keypress, display purchase text --
Citizen.CreateThread(function()
    while true do
        if me.coords then
            local distance = Vdist(me.coords.x, me.coords.y, me.coords.z, PLANT_BUY_LOCATION.x, PLANT_BUY_LOCATION.y, PLANT_BUY_LOCATION.z)
            if distance < MENU_TEXT_RADIUS then
                DrawText3D(PLANT_BUY_LOCATION.x, PLANT_BUY_LOCATION.y, PLANT_BUY_LOCATION.z, "[E] - Buy Plants | [Hold E] - Help")
            end
            if distance < MENU_RADIUS then
                if IsControlJustPressed(0, KEYS.E) then
                    Wait(500)
                    if IsControlPressed(0, KEYS.E) then
                        ShowHelp()
                    else
                        TriggerEvent('nh-context:createMenu', BUY_MENU)
                    end
                    Wait(500)
                end
            end
        end
        Wait(1)
    end
end)

RegisterNetEvent("cultivation:buy", function(itemName)
    TriggerServerEvent("cultivation:buy", itemName)
end)