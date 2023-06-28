exports.globals:PerformDBCheck("usa-crafting", "craft-count")

RegisterServerEvent("crafting:fetchUnlockedRecipes")
AddEventHandler("crafting:fetchUnlockedRecipes", function()
    local src = source
    local char = exports["usa-characters"]:GetCharacter(src)
    local closest = getClosestStation(src)
    local unlockedRecipes = getUnlockedRecipesOfType(char.get("_id"), closest.type)
    TriggerClientEvent("crafting:sendNUIMessage", src, {type = "gotUnlockedRecipes", unlockedRecipes = unlockedRecipes})
end)

RegisterServerEvent("crafting:attemptCraft")
AddEventHandler("crafting:attemptCraft", function(recipe)
    -- check if player has required items for recipe
    local char = exports["usa-characters"]:GetCharacter(source)
    if doesCharHaveAllRequiredItems(char, recipe) then
        -- begin crafting item
        print("has all items! going to craft: " .. recipe.name)
        TriggerClientEvent("crafting:beginCrafting", source, recipe)
    else
        TriggerClientEvent("usa:notify", source, "Missing required items", "INFO: That requires items: " .. getStringListOfRequiredItems(recipe))
    end
end)

RegisterServerEvent("crafting:finishedCrafting")
AddEventHandler("crafting:finishedCrafting", function(recipe, securityToken)
    if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
		return false
	end
    local char = exports["usa-characters"]:GetCharacter(source)
    if not didFailCraft(char.get("_id"), recipe.type) then
        if doesCharHaveAllRequiredItems(char, recipe) then
            -- remove recipe required item(s) from char
            for i = 1, #recipe.requires do
                char.removeItem(recipe.requires[i].name, recipe.requires[i].quantity)
            end
            -- drop produced item(s)
            for i = 1, #recipe.produces do
                local item = recipe.produces[i]
                item.coords = GetEntityCoords(GetPlayerPed(char.get("source")))
                local newCoords = {
                    x = item.coords.x,
                    y = item.coords.y,
                    z = item.coords.z
                }
                newCoords.x = newCoords.x + (math.random() * 0.5)
                newCoords.y = newCoords.y + (math.random() * 0.5)
                newCoords.z = newCoords.z - 0.85
                item.coords = newCoords
		item.uuid = exports.globals:generateID()
                if item.type == "weapon" then
                    item.serialNumber = item.uuid
                end
                TriggerEvent("interaction:addDroppedItem", item)
                TriggerClientEvent("usa:notify", char.get("source"), "Crafted: " .. recipe.produces[i].quantity .. "x " .. recipe.produces[i].name)
            end
            -- increment crafting success count
            local prevCount = getNumberOfSuccessfulCraftsOfType(char.get("_id"), recipe.type)
            local newCount = IncrementCraftCount(char.get("_id"), recipe.type)
            TriggerClientEvent("usa:notify", char.get("source"), "You've crafted " .. (recipe.type or "") .. " " .. newCount .. " times!", "You've crafted " .. (recipe.type or "") .. " " .. newCount .. " times!")
            -- notify if leveled up
            local prevLevel = getCurrentCraftingLevelOfType(prevCount, recipe.type)
            local levelAfterCraft = getCurrentCraftingLevelOfType(newCount, recipe.type)
            if levelAfterCraft > prevLevel then
                TriggerClientEvent("usa:notify", char.get("source"), "You have leveled up!", "^0INFO: You have leveled up! New " .. recipe.type .. " crafting level: " .. levelAfterCraft .. "!")
            end
        else
            TriggerClientEvent("usa:notify", char.get("source"), "Craft failed!")
        end
    else
        TriggerClientEvent("usa:notify", char.get("source"), "Craft failed!", "Crafting of " .. recipe.name .. " failed!")
    end
end)

function doesCharHaveAllRequiredItems(char, recipe)
    for i = 1, #recipe.requires do
        if not char.hasItemOfQuantity(recipe.requires[i].name, recipe.requires[i].quantity) then
            return false
        end
    end
    return true
end

function getStringListOfRequiredItems(recipe)
    local list = recipe.requires[1].name
    for i = 2, #recipe.requires do
        list = list .. ", " .. recipe.requires[i].name
    end
    return list
end

function getNumberOfSuccessfulCraftsOfType(charID, recipeType)
    local waiting = true
    local retVal = nil
    TriggerEvent("es:exposeDBFunctions", function(db)
        db.getDocumentById("craft-count", charID, function(doc)
            retValue = (doc and doc[recipeType] and doc[recipeType].count or 0)
            waiting = false
        end)
    end)
    while waiting do
        Wait(1)
    end
    return retValue
end

function getCurrentCraftingLevelOfType(numCrafts, recipeType)
    local ret = 1
    if recipeType == "weapons" then
        if numCrafts <= Config.LEVEL_1_MAX_CRAFT_COUNT then
            ret = 1
        elseif numCrafts <= Config.LEVEL_2_MAX_CRAFT_COUNT then
            ret = 2
        elseif numCrafts <= Config.LEVEL_3_MAX_CRAFT_COUNT then
            ret = 3
        else
            ret = 4
        end
    end
    return ret
end

function getUnlockedRecipesOfType(charID, recipeType)
    -- get number of successful crafts
    local numCrafts = getNumberOfSuccessfulCraftsOfType(charID, recipeType)
    local currentCraftingLevel = getCurrentCraftingLevelOfType(numCrafts, recipeType)
    -- calculate and return list of unlocked recipes
    local unlockedRecipes = {}
    if Config.recipes[recipeType] then
        for i = 1, #Config.recipes[recipeType] do
            local recipe = Config.recipes[recipeType][i]
            if recipe.requiredCraftingLevel <= currentCraftingLevel then
                table.insert(unlockedRecipes, recipe)
            end
        end
    end
    return unlockedRecipes
end

function updateCraftCount(charID, recipeType, value)
    TriggerEvent("es:exposeDBFunctions", function(db)
        local updates = {}
        updates[recipeType] = {
            count = value
        }
        db.updateDocument("craft-count", charID, updates, function(ok) 
            if not ok then 
                print("failed updating craft count... creating new doc..")
                db.createDocumentWithId("craft-count", updates, charID, function(ok) end)
            end
        end)
    end)
end

function IncrementCraftCount(charID, recipeType)
    local current = getNumberOfSuccessfulCraftsOfType(charID, recipeType)
    current = current + 1
    updateCraftCount(charID, recipeType, current)
    return current
end

function didFailCraft(charID, recipeType)
    local currentCraftCount = nil
    local waiting = true
    TriggerEvent("es:exposeDBFunctions", function(db)
        db.getDocumentById("craft-count", charID, function(doc)
            if doc then
                currentCraftCount = (doc.count or 0)
            else
                currentCraftCount = 0
            end
            waiting = false
        end)
    end)
    while waiting do
        Wait(1)
    end
    local failChance = Config.MAX_FAIL_CHANCE - (Config.FAILURE_COEFFICIENT * currentCraftCount)
    failChance = math.max(failChance, 0.05)
    if math.random() > failChance then
        return false
    else
        return true
    end
end

function getClosestStation(source)
    local recordedClosest = {
        dist = 99999999,
        stationInfo = nil
    }
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    for i = 1, #Config.craftingLocations do
        local dist = #(Config.craftingLocations[i].coords - playerCoords)
        if dist < recordedClosest.dist then
            recordedClosest = {
                dist = dist,
                stationInfo = Config.craftingLocations[i]
            }
        end
    end
    return recordedClosest.stationInfo
end
