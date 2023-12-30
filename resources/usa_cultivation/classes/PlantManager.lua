PlantManager = {}

PlantManager.WATER_MAX = 100.0
PlantManager.FOOD_MAX = 100.0
PlantManager.WATER_REPLENISH_AMOUNT = 50.0
PlantManager.FOOD_REPLENISH_AMOUNT = 50.0

PlantManager.newPlant = function(char, type, coords, cb)
    local product = PRODUCTS[type]
    local model = product.stages[1].objectModels[math.random(#(product.stages[1].objectModels))] -- random object model from first stage
    local newPlant = {
        type = type,
        owner = {
            id = char.get("_id"),
            steam = GetPlayerIdentifiers(char.get("source"))[1],
            name = char.get("name")
        },
        coords = coords,
        plantedAt = os.time(),
        lastWaterTime = os.time(),
        lastFeedTime = os.time(),
        stage = product.stages[1]
    }
    TriggerEvent("es:exposeDBFunctions", function(db)
        db.createDocument("cultivation", newPlant, function(docID)
            print("plant created in DB!")
            newPlant._id = docID
            PLANTED[docID] = newPlant
            cb(newPlant)
        end)
    end)
end

-- set food and water strings for client as well as check for death events when levels reach 0
PlantManager.setSustenenaceLevels = function(plant)
    local function getWaterLevelString()
        local hoursSinceWatered = exports.globals:GetHoursFromTime(plant.lastWaterTime)
        local starvationPercent = (hoursSinceWatered / 24) / MAX_DAYS_NO_WATER
        if starvationPercent <= 1/3 then
            return "~g~Not thirsty~w~"
        elseif starvationPercent <= 2/3 then
            return "~y~Thirsty~w~"
        elseif starvationPercent < 3/3 then
            return "~r~Very Thirsty~w~"
        else
            return "Dead"
        end
    end

    local function getFoodLevelString()
        local hoursSinceFed = exports.globals:GetHoursFromTime(plant.lastFeedTime)
        local starvationPercent = (hoursSinceFed / 24) / MAX_DAYS_NO_FOOD
        if starvationPercent <= 1/3 then
            return "~g~Not hungry~w~"
        elseif starvationPercent <= 2/3 then
            return "~y~Hungry~w~"
        elseif starvationPercent < 3/3 then
            return "~r~Very Hungry~w~"
        else
            return "Dead"
        end
    end

    TriggerEvent("es:exposeDBFunctions", function(db)

        if not plant.lastWaterTime then
            plant.lastWaterTime = os.time()
            db.updateDocument("cultivation", plant._id, { lastWaterTime = os.time() }, function(doc, err) end)
        end
        if not plant.lastFeedTime then
            plant.lastFeedTime = os.time()
            db.updateDocument("cultivation", plant._id, { lastFeedTime = os.time() }, function(doc, err) end)
        end
        if not plant.waterLevel then
            plant.waterLevel = {}
        end
        if not plant.foodLevel then
            plant.foodLevel = {}
        end

        -- food / water level display strings --
        plant.waterLevel.asString = getWaterLevelString()
        plant.foodLevel.asString = getFoodLevelString()

        -- save any death events --
        if plant.waterLevel.asString == "Dead" or plant.foodLevel.asString == "Dead" then
            plant.isDead = true
            plant.deathTimestamp = os.time()
            db.updateDocument("cultivation", plant._id, { isDead = true, deathTimestamp = os.time() }, function(doc, err)
                --print("plant death event recorded, time: " .. os.time())
            end)
        end

        -- save --
        PLANTED[plant._id] = plant

    end)
end

-- set plant's object for client based on time since planted
PlantManager.setPlantStage = function(plant)
    local hoursSincePlanted = exports.globals:GetHoursFromTime(plant.plantedAt)
    if not plant.stage then
        plant.stage = PRODUCTS[plant.type].stages[1]
    end
    for i = 1, #PRODUCTS[plant.type].stages do
        local stageInfo = PRODUCTS[plant.type].stages[i]
        if hoursSincePlanted < stageInfo.lengthInHours then
            -- not in last stage
            plant.stage.objectModels = stageInfo.objectModels
            plant.stage.name = stageInfo.name
            PLANTED[plant._id] = plant
            return
        end
    end
    -- in last stage:
    plant.stage.objectModels = PRODUCTS[plant.type].stages[#PRODUCTS[plant.type].stages].objectModels
    plant.stage.name = "harvest"
    PLANTED[plant._id] = plant
    --[[
    if hoursSincePlanted < PLANT_STAGE_HOURS.VEGETATIVE then
        plant.stage.objectModels = { "bkr_prop_weed_01_small_01a", "bkr_prop_weed_01_small_01b", "bkr_prop_weed_01_small_01c" }
    elseif hoursSincePlanted < PLANT_STAGE_HOURS.FLOWER then
        plant.stage.objectModels = { "bkr_prop_weed_med_01a", "bkr_prop_weed_med_01b" }
    else
        plant.stage.objectModels = { "bkr_prop_weed_lrg_01b" }
        plant.stage.name = "harvest"
    end
    PLANTED[plant._id] = plant
    --]]
end

-- set lastWaterTime and save to DB:
PlantManager.waterPlant = function(id)
    local now = os.time()
    PLANTED[id].lastWaterTime = now
    PlantManager.setSustenenaceLevels(PLANTED[id])
    TriggerEvent("es:exposeDBFunctions", function(db)
        db.updateDocument("cultivation", id, { lastWaterTime = now }, function(doc, err)
            print("plant water time updated, set to: " .. now)
        end)
    end)
end

-- set lastFeedTime and save to DB:
PlantManager.feedPlant = function(id)
    local now = os.time()
    PLANTED[id].lastFeedTime = now
    PlantManager.setSustenenaceLevels(PLANTED[id])
    TriggerEvent("es:exposeDBFunctions", function(db)
        db.updateDocument("cultivation", id, { lastFeedTime = now }, function(doc, err)
            print("plant feed time updated, set to: " .. now)
        end)
    end)
end

PlantManager.harvestPlant = function(id)
    local plant = PLANTED[id]
    local rewardQuantity = math.random(PRODUCTS[plant.type].rewardQuantity.min, PRODUCTS[plant.type].rewardQuantity.max)
    local rewardItem = PRODUCTS[plant.type].harvestItem
    rewardItem.quantity = rewardQuantity
    rewardItem.coords = plant.coords
    return rewardItem
end

PlantManager.removePlant = function(id)
    if PLANTED[id] then
        TriggerEvent("es:exposeDBFunctions", function(db)
            db.deleteDocument("cultivation", id, function(ok)
                print("done deleteing plant doc")
                PLANTED[id] = nil
            end)
        end)
    end
end

PlantManager.hasBeenDeadLongEnoughToDelete = function(id)
    if PLANTED[id].isDead and PLANTED[id].deathTimestamp then
        local daysSinceDead = math.floor(exports.globals:GetHoursFromTime(PLANTED[id].deathTimestamp) / 24)
        if daysSinceDead >= DAYS_DEAD_BEFORE_DELETE then
            return true
        end
    end
    return false
end