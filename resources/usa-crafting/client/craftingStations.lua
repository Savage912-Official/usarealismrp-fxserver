local globals = exports.globals
local isMenuOpen = false
local alreadyCrafting = false

function spawnCraftingStation(station)
    local handle = CreateObject(station.object.model, station.coords, false, false, false)
    SetEntityAsMissionEntity(handle)
    SetEntityHeading(handle, station.object.heading)
    FreezeEntityPosition(handle, true)
    return handle
end

function ToggleGui()
    SendNUIMessage({
        type = "toggle"
    })
    SetNuiFocus(not isMenuOpen, not isMenuOpen)
    isMenuOpen = not isMenuOpen
end

RegisterNUICallback("close", function(data)
    ToggleGui()
end)

RegisterNUICallback("attemptCraft", function(data)
    TriggerServerEvent("crafting:attemptCraft", data.recipe)
end)

RegisterNUICallback("fetchUnlockedRecipes", function(data)
    TriggerServerEvent("crafting:fetchUnlockedRecipes")
end)

Citizen.CreateThread(function()
    local craftStationObjectHandles = {}
    while true do
        local mycoords = GetEntityCoords(PlayerPedId())
        for i = #Config.craftingLocations, 1, -1 do
            local station = Config.craftingLocations[i]
            local dist = #(mycoords - station.coords)
            if dist < Config.CRAFT_STATION_OBJECT_DISTANCE then
                if not craftStationObjectHandles[i] and station.object then
                    craftStationObjectHandles[i] = spawnCraftingStation(station)
                end
                if dist < Config.CRAFT_INTERACT_DISTANCE then
                    exports.globals:DrawText3D(station.coords.x, station.coords.y, station.coords.z + 1.0, "[E] - Craft")
                    if IsControlJustPressed(0, Config.CRAFT_KEY) then
                        ToggleGui()
                    end
                end
            else
                -- delete object if exists
                if craftStationObjectHandles[i] then
                    DeleteObject(craftStationObjectHandles[i])
                    craftStationObjectHandles[i] = nil
                end
            end
        end
        Wait(1)
    end
end)

RegisterNetEvent("crafting:sendNUIMessage")
AddEventHandler("crafting:sendNUIMessage", function(msg)
    SendNUIMessage(msg)
end)

RegisterNetEvent("crafting:beginCrafting")
AddEventHandler("crafting:beginCrafting", function(recipe)
    if not alreadyCrafting then
        alreadyCrafting = true
        TriggerEvent("dpemotes:command", 'e', GetPlayerServerId(PlayerId()), {"weld"})
        ToggleGui()

        if lib.progressCircle({
            duration = (recipe.craftDurationSeconds or Config.DEFAULT_CRAFT_DURATION_SECONDS) * 1000,
            label = 'Crafting...',
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true,
            },
            anim = {
                dict = 'amb@world_human_welding@male@idle_a',
                clip = 'idle_a',
                flag = 39,
            },
        }) then
            while securityToken == nil do
                Wait(1)
            end
            TriggerServerEvent("crafting:finishedCrafting", recipe, securityToken)
            TriggerEvent("dpemotes:command", 'e', GetPlayerServerId(PlayerId()), {"c"})
            alreadyCrafting = false
        else
            TriggerEvent("dpemotes:command", 'e', GetPlayerServerId(PlayerId()), {"c"})
            alreadyCrafting = false
        end

    else
       exports.globals:notify("Already crafting")
    end
end)
