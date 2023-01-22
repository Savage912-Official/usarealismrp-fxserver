function onInteract(targetData,itemData)
    print(targetData.name,targetData.label) --> my_buffalo_target   Buffalo
    print(itemData.name,itemData.label)     --> lock_door           Lock Door
end

function onVehicleOptionSelect(a, buttonInfo, hitHandle)
    -- enable ui and go to correction page
    local vehPlate = GetVehicleNumberPlateText(hitHandle)
    if buttonInfo.label == "Open" then
        EnableGui(vehPlate, "vehicleActions.open")
    elseif buttonInfo.label == "Close" then
        EnableGui(vehPlate, "vehicleActions.close")
    elseif buttonInfo.label == "Inventory" then
        EnableGui(vehPlate, "inventory")
    elseif buttonInfo.label == "Hide Trunk" then
        TriggerEvent('trunkhide:hideInNearestTrunk')
    end
end

function onPersonOptionSelect(a, b, hitHandle) end

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
    }
})

target.addPlayer("personOptions", "Person", "fas fa-male", 3.0, onPersonOptionSelect, {
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

-- todo: LEO/EMS job player actions (cuff, frisk, bandage, etc)
-- todo: actions for peds (sell drugs, etc)