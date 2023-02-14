UPGRADES = {
    ["topspeed4"] = {
        id = "topspeed4",
        displayName = "Top Speed Tune",
        increaseAmount = 20.0,
        doSync = true,
        requiresItem = "Top Speed Tune"
    },
    ["nitrokit"] = {
        id = "nitrokit",
        displayName = "NOS Install Kit",
        requiresItem = "NOS Install Kit"
    },
    ["nitrobottle1"] = {
        id = "nitrobottle1",
        displayName = "NOS Bottle (Stage 1)",
        requiresItem = "NOS Bottle (Stage 1)",
        requiresUpgrades = {
            "nitrokit"
        },
        maxCapacity = 4000,
        postInstall = function(vehPlate)
            local done = false
            MechanicHelper.db.getDocumentById("vehicle-nitro-fuel", vehPlate, function(doc)
                if doc then
                    MechanicHelper.db.updateDocument("vehicle-nitro-fuel", vehPlate, {nitroFuelLevel = UPGRADES["nitrobottle1"].maxCapacity}, function(ok) done = true end)
                else
                    MechanicHelper.db.createDocumentWithId("vehicle-nitro-fuel", {nitroFuelLevel = UPGRADES["nitrobottle1"].maxCapacity, maxCapacity = UPGRADES["nitrobottle1"].maxCapacity}, vehPlate, function(ok) done = true end)
                end
            end)
            while not done do
                Wait(1)
            end
        end
    },
    ["nitrobottle2"] = {
        id = "nitrobottle2",
        displayName = "NOS Bottle (Stage 2)",
        requiresItem = "NOS Bottle (Stage 2)",
        requiresUpgrades = {
            "nitrokit"
        },
        maxCapacity = 8000,
        postInstall = function(vehPlate)
            local done = false
            MechanicHelper.db.getDocumentById("vehicle-nitro-fuel", vehPlate, function(doc)
                if doc then
                    MechanicHelper.db.updateDocument("vehicle-nitro-fuel", vehPlate, {nitroFuelLevel = UPGRADES["nitrobottle2"].maxCapacity}, function(ok) done = true end)
                else
                    MechanicHelper.db.createDocumentWithId("vehicle-nitro-fuel", {nitroFuelLevel = UPGRADES["nitrobottle2"].maxCapacity, maxCapacity = UPGRADES["nitrobottle2"].maxCapacity}, vehPlate, function(ok) done = true end)
                end
            end)
            while not done do
                Wait(1)
            end
        end
    },
    ["nitrobottle3"] = {
        id = "nitrobottle3",
        displayName = "NOS Bottle (Stage 3)",
        requiresItem = "NOS Bottle (Stage 3)",
        requiresUpgrades = {
            "nitrokit"
        },
        maxCapacity = 16000,
        postInstall = function(vehPlate)
            local done = false
            MechanicHelper.db.getDocumentById("vehicle-nitro-fuel", vehPlate, function(doc)
                if doc then
                    MechanicHelper.db.updateDocument("vehicle-nitro-fuel", vehPlate, {nitroFuelLevel = UPGRADES["nitrobottle3"].maxCapacity}, function(ok) done = true end)
                else
                    MechanicHelper.db.createDocumentWithId("vehicle-nitro-fuel", {nitroFuelLevel = UPGRADES["nitrobottle3"].maxCapacity, maxCapacity = UPGRADES["nitrobottle3"].maxCapacity}, vehPlate, function(ok) done = true end)
                end
            end)
            while not done do
                Wait(1)
            end
        end
    },
    ["nitrogauge"] = {
        id = "nitrogauge",
        displayName = "NOS Gauge",
        requiresItem = "NOS Gauge",
        requiresUpgrades = {
            "nitrokit"
        }
    },
    ["custom-radio"] = {
        id = "custom-radio",
        displayName = "Custom Radio",
        requiresItem = "Custom Radio",
        postInstall = function(vehPlate)
            exports.rcore_radiocar:GiveRadioToCar(vehPlate, function() print("added radio to car") end)
        end
    },
    ["manual-conversion-kit"] = {
        id = "manual-conversion-kit",
        displayName = "Manual Conversion Kit",
        requiresItem = "Manual Conversion Kit",
        postInstall = function(vehPlate)
            print("car converted to manual!")
        end
    },
    ["auto-conversion-kit"] = {
        id = "auto-conversion-kit",
        displayName = "Auto Conversion Kit",
        requiresItem = "Auto Conversion Kit",
        postInstall = function(vehPlate)
            print("car converted to automatic!")
            -- remove manual upgrade since it was converted to automatic and also auto conversion kit since it is no longer needed since auto is default
            MechanicHelper.removeVehicleUpgrades(vehPlate, {"manual-conversion-kit", "auto-conversion-kit"})
        end
    },
    ["low-grip-tires"] = {
        id = "low-grip-tires",
        displayName = "Low Grip Tires",
        requiresItem = "Low Grip Tires",
        postInstall = function(vehPlate)
            -- remove opposite tire upgrade if applicable
            MechanicHelper.removeVehicleUpgrades(vehPlate, {"normal-tires"})
        end
    },
    ["normal-tires"] = {
        id = "normal-tires",
        displayName = "Normal Tires",
        requiresItem = "Normal Tires",
        postInstall = function(vehPlate)
            -- remove opposite tire upgrade if applicable
            MechanicHelper.removeVehicleUpgrades(vehPlate, {"low-grip-tires"})
        end
    },
    ["underglow-kit"] = {
        id = "underglow-kit",
        displayName = "Underglow Kit",
        requiresItem = "Underglow Kit",
        postInstall = function(vehPlate) end
    },
    ["xenon-headlights"] = {
        id = "xenon-headlights",
        displayName = "Xenon Headlights",
        requiresItem = "Xenon Headlights",
        postInstall = function(vehPlate) end
    },
    ["stage-1-brakes"] = {
        id = "stage-1-brakes",
        displayName = "Stage 1 Brakes",
        requiresItem = "Stage 1 Brakes",
        postInstall = function(vehPlate)
            MechanicHelper.removeVehicleUpgrades(vehPlate, {"stage-2-brakes"})
        end
    },
    ["stage-2-brakes"] = {
        id = "stage-2-brakes",
        displayName = "Stage 2 Brakes",
        requiresItem = "Stage 2 Brakes",
        postInstall = function(vehPlate)
            MechanicHelper.removeVehicleUpgrades(vehPlate, {"stage-1-brakes"})
        end
    },
    ["tint-remover"] = {
        id = "tint-remover",
        displayName = "Tint Remover",
        requiresItem = "Tint Remover",
        postInstall = function(vehPlate)
            MechanicHelper.removeVehicleUpgrades(vehPlate, {"5-percent-tint", "20-percent-tint", "35-percent-tint", "tint-remover"})
        end
    },
    ["5-percent-tint"] = {
        id = "5-percent-tint",
        displayName = "5% Window Tint",
        requiresItem = "5% Window Tint",
        postInstall = function(vehPlate)
            MechanicHelper.removeVehicleUpgrades(vehPlate, {"20-percent-tint", "35-percent-tint"})
        end
    },
    ["20-percent-tint"] = {
        id = "20-percent-tint",
        displayName = "20% Window Tint",
        requiresItem = "20% Window Tint",
        postInstall = function(vehPlate)
            MechanicHelper.removeVehicleUpgrades(vehPlate, {"5-percent-tint", "35-percent-tint"})
        end
    },
    ["35-percent-tint"] = {
        id = "35-percent-tint",
        displayName = "35% Window Tint",
        requiresItem = "35% Window Tint",
        postInstall = function(vehPlate)
            MechanicHelper.removeVehicleUpgrades(vehPlate, {"20-percent-tint", "5-percent-tint"})
        end
    },
    ["stage-1-transmission"] = {
        id = "stage-1-transmission",
        displayName = "Stage 1 Transmission",
        requiresItem = "Stage 1 Transmission",
        postInstall = function(vehPlate)
            MechanicHelper.removeVehicleUpgrades(vehPlate, {"stage-2-transmission"})
        end
    },
    ["stage-2-transmission"] = {
        id = "stage-2-transmission",
        displayName = "Stage 2 Transmission",
        requiresItem = "Stage 2 Transmission",
        postInstall = function(vehPlate)
            MechanicHelper.removeVehicleUpgrades(vehPlate, {"stage-1-transmission"})
        end
    }
}