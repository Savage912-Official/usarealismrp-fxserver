function onInteract(targetData,itemData)
    print(targetData.name,targetData.label) --> my_buffalo_target   Buffalo
    print(itemData.name,itemData.label)     --> lock_door           Lock Door
end

function onATMInteract(targetData, itemData)
    if itemData.name == "use" then
        local coords = GetEntityCoords(exports.banking:GetClosestATM())
        TriggerServerEvent("bank:getBalanceForGUI", coords)
    elseif itemData.name == "hack" then
        local hasDrill = TriggerServerCallback {
            eventName = "interaction:hasItem",
            args = { "Drill" }
        }
        if hasDrill then
            TriggerEvent("banking:DrillATM")
        else
            exports.globals:notify("Need a drill")
        end
    end
end

function onPlantInteract(targetData, itemData)
    if itemData.name == "water" then
        local hasRequiredItem = TriggerServerCallback {
            eventName = "interaction:hasItem",
            args = { "Watering Can" }
        }
        if hasRequiredItem then
            TriggerEvent("cultivation:water")
        else
            exports.globals:notify("Need a watering can")
        end
    elseif itemData.name == "feed" then
        local hasRequiredItem = TriggerServerCallback {
            eventName = "interaction:hasItem",
            args = { "Fertilizer" }
        }
        if hasRequiredItem then
            TriggerEvent("cultivation:feed")
        else
            exports.globals:notify("Need fertilizer")
        end
    end
end

function onVehicleOptionSelect(a, buttonInfo, hitHandle)
    -- enable ui and go to correction page
    local vehPlate = GetVehicleNumberPlateText(hitHandle)
    if buttonInfo.label == "Open" then
        EnableGui(vehPlate, "vehicleActions.open")
    elseif buttonInfo.label == "Close" then
        EnableGui(vehPlate, "vehicleActions.close")
    elseif buttonInfo.label == "Inventory" then
        if busy then
            exports.globals:notify("Busy!")
            return
        end
        EnableGui(vehPlate, "inventory")
    elseif buttonInfo.label == "Hide Trunk" then
        TriggerEvent('trunkhide:hideInNearestTrunk')
    elseif buttonInfo.label == "Impound" then
        TriggerServerEvent("impound:impoundVehicle", hitHandle, GetVehicleNumberPlateText(hitHandle))
    elseif buttonInfo.label == "Tow" then
        TriggerEvent('towJob:towVehicle')
    elseif buttonInfo.label == "Repair" then
        TriggerEvent("mechanic:repairJobCheck")
    elseif buttonInfo.label == "Check Upgrades" then
        local upgrades = TriggerServerCallback { 
            eventName = "mechanic:getVehicleUpgrades",
            args = {vehPlate}
        }
        if upgrades then
            exports.globals:notify(false, "^3INFO: ^0Vehicle upgrades")
            for i = 1, #upgrades do
                exports.globals:notify(false, upgrades[i])
            end
        else
            exports.globals:notify("No upgrades found!", "INFO: No upgrades found on vehicle with plate " .. vehPlate)
        end
    elseif buttonInfo.label == "Stickers" then
        TriggerEvent("rcore_stickers:open")
    elseif buttonInfo.label == "Slash Tire" then
        exports.slashtires:TargetTireSlash(PlayerPedId())
    end
end

function onPersonOptionSelect(a, b, hitHandle) end

function addCivPlayerOptions()
    target.addPlayer("personOptions", "Person", "fas fa-male", 1.75, onPersonOptionSelect, {
        {
            name = 'give-money',
            label = 'Give Money',
            onSelect = function(a, b, entityHandle)
                -- had to save closest player ID for some reason --
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                -- Get desired amount to give from user --
                local amount = tonumber(exports.globals:GetUserInput())
                if amount then
                    -- Give cash to nearest player --
                    TriggerServerEvent("bank:givecash", playerServerId, amount)
                end
            end
        },
        {
            name = 'rob',
            label = 'Rob',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerEvent("crim:attemptToRobNearestPerson", playerServerId)
            end
        },
        {
            name = 'tie',
            label = 'Tie',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                local myped = PlayerPedId()
                local playerCoords = GetEntityCoords(myped)
                local playerHeading = GetEntityHeading(myped)
                local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(myped, 0.0, 0.65, -1.0))
                TriggerServerEvent("crim:foundPlayerToTie", playerServerId, true, x, y, z, playerHeading)
            end
        },
        {
            name = 'untie',
            label = 'Untie',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                local myped = PlayerPedId()
                local playerCoords = GetEntityCoords(myped)
                local playerHeading = GetEntityHeading(myped)
                local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(myped, 0.0, 0.65, -1.0))
                TriggerServerEvent("crim:foundPlayerToTie", playerServerId, false, x, y, z, playerHeading)
            end
        },
        {
            name = 'drag',
            label = 'Drag',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerEvent("drag:attemptToDragNearest", playerServerId)
            end
        },
        {
            name = 'blindfold',
            label = 'Blindfold',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerEvent("crim:attemptToBlindfoldNearestPerson", true, playerServerId)
            end
        },
        {
            name = 'remove-blindfold',
            label = 'Remove Blindfold',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerEvent("crim:attemptToBlindfoldNearestPerson", false, playerServerId)
            end
        },
        {
            name = 'place',
            label = 'Place',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerServerEvent("place:placePerson", playerServerId)
            end
        },
        {
            name = 'search',
            label = 'Search',
            onSelect = function(a, b, entityHandle)
                if busy then
                    exports.globals:notify("Busy!")
                    return
                end
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerEvent("search:attemptToSearchNearestPerson", playerServerId)
            end
        },
        {
            name = 'inspect',
            label = 'Inspect',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                local myServerId = GetPlayerServerId(PlayerId())
                TriggerServerEvent('injuries:getPlayerInjuries', playerServerId, myServerId)
            end
        },
    })
end

function addLEOPlayerOptions()
    target.addPlayer("personOptions", "Person", "fas fa-male", 2.0, onPersonOptionSelect, {
        {
            name = 'cuff',
            label = 'Cuff',
            onSelect = function(a, b, entityHandle)
                TriggerEvent("cuff:attemptToCuffNearest")
            end
        },
        {
            name = 'frisk',
            label = 'Frisk',
            onSelect = function(a, b, entityHandle)
                local src = GetPlayerServerId(PlayerId())
                TriggerEvent("police:friskNearest", src)
            end
        },
        {
            name = 'bandage',
            label = 'Bandage',
            onSelect = function(a, b, entityHandle)
                TriggerEvent("injuries:bandageNearestPed")
            end
        },
        {
            name = 'give-money',
            label = 'Give Money',
            onSelect = function(a, b, entityHandle)
                -- had to save closest player ID for some reason --
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                -- Get desired amount to give from user --
                local amount = tonumber(exports.globals:GetUserInput())
                if amount then
                    -- Give cash to nearest player --
                    TriggerServerEvent("bank:givecash", playerServerId, amount)
                end
            end
        },
        {
            name = 'untie',
            label = 'Untie',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                local myped = PlayerPedId()
                local playerCoords = GetEntityCoords(myped)
                local playerHeading = GetEntityHeading(myped)
                local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(myped, 0.0, 0.65, -1.0))
                TriggerServerEvent("crim:foundPlayerToTie", playerServerId, false, x, y, z, playerHeading)
            end
        },
        {
            name = 'drag',
            label = 'Drag',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerEvent("drag:attemptToDragNearest", playerServerId)
            end
        },
        {
            name = 'remove-blindfold',
            label = 'Remove Blindfold',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerEvent("crim:attemptToBlindfoldNearestPerson", false, playerServerId)
            end
        },
        {
            name = 'place',
            label = 'Place',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerServerEvent("place:placePerson", playerServerId)
            end
        },
        {
            name = 'search',
            label = 'Search',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerEvent("search:attemptToSearchNearestPerson", playerServerId)
            end
        },
        {
            name = 'inspect',
            label = 'Inspect',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                local myServerId = GetPlayerServerId(PlayerId())
                TriggerServerEvent('injuries:getPlayerInjuries', playerServerId, myServerId)
            end
        },
    })
end

function addEMSPlayerOptions()
    target.addPlayer("personOptions", "Person", "fas fa-male", 2.0, onPersonOptionSelect, {
        {
            name = 'bandage',
            label = 'Bandage',
            onSelect = function(a, b, entityHandle)
                TriggerEvent("injuries:bandageNearestPed")
            end
        },
        {
            name = 'give-money',
            label = 'Give Money',
            onSelect = function(a, b, entityHandle)
                -- had to save closest player ID for some reason --
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                -- Get desired amount to give from user --
                local amount = tonumber(exports.globals:GetUserInput())
                if amount then
                    -- Give cash to nearest player --
                    TriggerServerEvent("bank:givecash", playerServerId, amount)
                end
            end
        },
        {
            name = 'untie',
            label = 'Untie',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                local myped = PlayerPedId()
                local playerCoords = GetEntityCoords(myped)
                local playerHeading = GetEntityHeading(myped)
                local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(myped, 0.0, 0.65, -1.0))
                TriggerServerEvent("crim:foundPlayerToTie", playerServerId, false, x, y, z, playerHeading)
            end
        },
        {
            name = 'drag',
            label = 'Drag',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerEvent("drag:attemptToDragNearest", playerServerId)
            end
        },
        {
            name = 'remove-blindfold',
            label = 'Remove Blindfold',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerEvent("crim:attemptToBlindfoldNearestPerson", false, playerServerId)
            end
        },
        {
            name = 'place',
            label = 'Place',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerServerEvent("place:placePerson", playerServerId)
            end
        },
        {
            name = 'search',
            label = 'Search',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                TriggerEvent("search:attemptToSearchNearestPerson", playerServerId)
            end
        },
        {
            name = 'inspect',
            label = 'Inspect',
            onSelect = function(a, b, entityHandle)
                local playerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHandle))
                local myServerId = GetPlayerServerId(PlayerId())
                TriggerServerEvent('injuries:getPlayerInjuries', playerServerId, myServerId)
            end
        },
    })
end

function addCivVehicleOptions()
    target.addVehicle("vehicleOptions", "Vehicle", 'fas fa-car', 1.0, onVehicleOptionSelect, {
        {
            name = "open",
            label = "Open"
        },
        {
            name = "close",
            label = "Close"
        },
        {
            name = "inventory",
            label = "Inventory"
        },
        {
            name = "hideTrunk",
            label = "Hide Trunk"
        },
        {
            name = "stickers",
            label = "Stickers"
        },
        {
            name = "tow",
            label = "Tow"
        },
        {
            name = "slashtire",
            label = "Slash Tire"
        },
    })
end

function addLEOVehicleOptions()
    target.addVehicle("vehicleOptions", "Vehicle", 'fas fa-car', 1.0, onVehicleOptionSelect, {
        {
            name = "impound",
            label = "Impound"
        },
        {
            name = "open",
            label = "Open"
        },
        {
            name = "close",
            label = "Close"
        },
        {
            name = "inventory",
            label = "Inventory"
        },
        {
            name = "hideTrunk",
            label = "Hide Trunk"
        }
    })
end

function addMechanicVehicleOptions()
    target.addVehicle("vehicleOptions", "Vehicle", 'fas fa-car', 1.0, onVehicleOptionSelect, {
        {
            name = "tow",
            label = "Tow"
        },
        {
            name = "repair",
            label = "Repair"
        },
        {
            name = "open",
            label = "Open"
        },
        {
            name = "close",
            label = "Close"
        },
        {
            name = "inventory",
            label = "Inventory"
        },
        {
            name = "hideTrunk",
            label = "Hide Trunk"
        },
        {
            name = "checkUpgrades",
            label = "Check Upgrades"
        }
    })
end

function addCivModelOptions()
    local atmModels = {
        -1126237515,
        -870868698,
        506770882
    }
    local weedPlantModels = {
        GetHashKey("bkr_prop_weed_01_small_01a"),
        GetHashKey("bkr_prop_weed_01_small_01b"),
        GetHashKey("bkr_prop_weed_01_small_01c"),
        GetHashKey("bkr_prop_weed_med_01a"),
        GetHashKey("bkr_prop_weed_med_01b"),
        GetHashKey("bkr_prop_weed_lrg_01b")
    }
    local atmTargetIds = target.addModels('ATMs', 'ATM', 'fas fa-usd-circle', atmModels, 1.0, onATMInteract, {
        {
            name = 'use',
            label = 'Use'
        },
        {
            name = 'hack',
            label = 'Hack'
        }
    })
    local plantTargetIds = target.addModels('Plants', 'Plant', 'fa fa-leaf', weedPlantModels, 1.0, onPlantInteract, {
        {
            name = 'water',
            label = 'Water'
        },
        {
            name = 'feed',
            label = 'Feed'
        }
    })
end

addCivPlayerOptions()
addCivVehicleOptions()
addCivModelOptions()

RegisterNetEvent("thirdEye:updateActionsForNewJob")
AddEventHandler("thirdEye:updateActionsForNewJob", function(job)
    target.removeTarget("personOptions")
    target.removeTarget("vehicleOptions")
    if job == "sheriff" or job == "corrections" then
        addLEOPlayerOptions()
        addLEOVehicleOptions()
    elseif job == "ems" then
        addEMSPlayerOptions()
        addCivVehicleOptions()
    elseif job == "mechanic" then
        addCivPlayerOptions()
        addMechanicVehicleOptions()
    else
        addCivPlayerOptions()
        addCivVehicleOptions()
    end
end)

target.addPoint("UHH", "Art", "fas fa-money-bill", vector3(288.0126, -2981.809, 5.866447), 1, function() end, {
    {
        name = 'sellArt',
        label = 'Sell Art',
        onSelect = function(a, b, entityHandle)
            TriggerEvent("vt-artheist:finishHeist")
        end
    },
})

target.addPoint("911CallPoint", "911", "fas fa-siren", vector3(1776.873, 2572.845, 45.79781), 1, function() end, {
    {
        name = 'call',
        label = 'Call 911',
        onSelect = function(a, b, entityHandle)
            local msg = exports.globals:GetUserInput("message", 100)
            local mycoords = GetEntityCoords(PlayerPedId())
            TriggerServerEvent("911:PlayerCall", mycoords.x, mycoords.y, mycoords.z, "Bolingbroke Prison (Cell Block)", msg)
        end
    },
})

-- CatCafe ThirdEye Items
target.addPoint("catCafeSignIn", "Cat Cafe", "fas fa-cat", vector3(-597.52642822266, -1053.5493164063, 22.344202041626), 1, function() end, {
    {
        name = 'signIn',
        label = 'Toggle Sign In',
        onSelect = function(a, b, entityHandle)
            TriggerEvent("catcafe:toggleClockOn")
        end
    },
})
target.addPoint("catCafeLeaderboard", "Cat Cafe", "fas fa-cat", vector3(-593.94860839844, -1052.7293701172, 22.344200134277), 1, function() end, {
    {
        name = 'leaderboard',
        label = 'Check Leaderboard',
        onSelect = function(a, b, entityHandle)
            TriggerEvent("catcafe:leaderboard")
        end
    },
})
-- End of CatCafe ThirdEye