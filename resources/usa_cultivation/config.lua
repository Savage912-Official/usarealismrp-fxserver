PRODUCTS = {
    ["cannabis"] = {
        item = {
            name = "Small Weed Plant",
            quantity = 1,
            weight = 20.0,
            legality = "legal"
        },
        harvestItem = {
            name = "Weed Bud",
            quantity = 1,
            weight = 4.0,
            type = "drug",
            legality = "legal",
            objectModel = "bkr_prop_weed_bud_01a"
        },
        rewardQuantity = {
            min = 10,
            max = 18
        },
        cost = 75,
        stages = {
            { name = "vegetative", lengthInHours = 3 * 24, objectModels = { "bkr_prop_weed_01_small_01a", "bkr_prop_weed_01_small_01b", "bkr_prop_weed_01_small_01c" } },
            { name = "flower", lengthInHours = 7 * 24, objectModels = { "bkr_prop_weed_med_01a", "bkr_prop_weed_med_01b" } },
            { name = "harvest", lengthInHours = 7 * 24, objectModels = { "bkr_prop_weed_lrg_01b" } }
        }
    },
    ["corn"] = {
        item = {
            name = "Small Corn Plant",
            quantity = 1,
            weight = 5.0,
            legality = "legal"
        },
        harvestItem = {
            name = "Raw Corn",
            quantity = 1,
            weight = 4.0,
            type = "food",
            substance = 15.0,
            legality = "legal",
            objectModel = "v_res_fa_tincorn"
        },
        rewardQuantity = {
            min = 10,
            max = 30
        },
        cost = 75,
        stages = {
            { name = "vegetative", lengthInHours = 7 * 24, objectModels = { "prop_veg_corn_01" } },
            { name = "harvest", lengthInHours = 7 * 24, objectModels = { "prop_veg_corn_01" } }
        }
    }
}

exports["interaction-menu"]:registerUsableItem("Small Corn Plant", function(src)
    TriggerClientEvent("cultivation:plant", src, "corn", "Small Corn Plant")
end)

PLANTED = {} -- global table of all currently planted plants (sort of an in-memory cache between DB and server)

PLANT_CHECK_INTERVAL_MINUTES = 30

MAX_DAYS_NO_FOOD = 3
MAX_DAYS_NO_WATER = 2

--[[
PLANT_STAGE_HOURS = {
    VEGETATIVE = 5 * 24,
    FLOWER = 10 * 24,
    HARVEST = 14 * 24 -- two weeks (14 days) until ready for harvest
}
--]]

NEARBY_DISTANCE = 400

DAYS_DEAD_BEFORE_DELETE = 7 -- auto delete when dead for X days

--[[
local testobj = {}
testobj["_id"] = "1994a81632cf65f5d39e4c3c5727031a"
testobj["_rev"] = "1-2f6e02937023cd858f7ed387eccdf317"
testobj["waterLevel"] = {
        ["val"] = 85.0,
        ["asString"] = "~r~Very Thirsty~w~"
    }
testobj["stage"] = {
    ["objectModels"] = {
        "bkr_prop_weed_01_small_01a",
        "bkr_prop_weed_01_small_01b",
        "bkr_prop_weed_01_small_01c"
    },
    ["name"] = "vegetative",
    ["lengthInHours"] = 48
}
testobj["plantedAt"] = 1575570530 -- harvest stage
--testobj["plantedAt"] = 1578364462 -- flower stage
--testobj["plantedAt"] = os.time() -- vegetative stage
testobj["type"] = "cannabis"
testobj["foodLevel"] = {
    ["val"] = 16.25,
    ["asString"] = "~g~Slightly Hungry~w~"
}
testobj["coords"] = {
    ["x"] = -1073.2800292969,
    ["y"] = -1671.2197265625,
    ["z"] = 3.462993144989
}
testobj["owner"] = {
    ["name"] = {
        ["last"] = "LenneyIII",
        ["middle"] = "",
        ["first"] = "William"
    }
}
testobj["steam"] = "steam:1100001177bdebd"
testobj["id"] = "64bb494a96ba8b98ad0e5ee23d13f835"

table.insert(PLANTED, testobj)
--]]