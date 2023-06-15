local cleaningLocations = {
    ["tables"] = {
        {x = 1775.7236328125, y = 2585.8447265625, z = 46.590061187744},
        {x = 1779.7224121094, y = 2585.9016113281, z = 46.590114593506},
        {x = 1775.8326416016, y = 2582.4924316406, z = 46.590114593506},
        {x = 1779.740234375, y = 2582.2458496094, z = 46.590152740479},
        {x = 1783.2489013672, y = 2585.978515625, z = 46.59005355835},
        {x = 1783.2403564453, y = 2582.1547851563, z = 46.590110778809},
        {x = 1783.3665771484, y = 2578.2507324219, z = 46.590110778809},
        {x = 1775.7790527344, y = 2578.224609375, z = 46.590118408203}
    },
    ["shower"] = {
        {x = 1762.5603027344, y = 2584.1528320313, z = 45.79780960083},
        {x = 1762.4711914063, y = 2583.0393066406, z = 45.79780960083},
        {x = 1762.5052490234, y = 2581.9421386719, z = 45.79780960083},
        {x = 1762.5593261719, y = 2580.9379882813, z = 45.79780960083},
        {x = 1762.6495361328, y = 2579.7543945313, z = 45.79780960083},
        {x = 1764.2890625, y = 2579.771484375, z = 45.79780960083},
        {x = 1764.2041015625, y = 2580.8955078125, z = 45.79780960083},
        {x = 1764.2381591797, y = 2581.9560546875, z = 45.79780960083},
        {x = 1764.1721191406, y = 2583.0883789063, z = 45.79780960083},
        {x = 1764.2390136719, y = 2584.1032714844, z = 45.79780960083}
    },
    --[[
    ["kitchen"] = {

    },
    ["cells"] = {

    }
    --]]
}

local REDUCE_TIME_RATES = {
    tables = 1,
    shower = 1
}

local PAY_RATES = {
    tables = math.random(20, 100),
    shower = math.random(25, 100)
}

local CLEANING_TIME_SECONDS = 45

local currentlyCleaning = {}
local currentlyCleaningTaskName = {}

RegisterServerEvent("prison-janitor:toggleJob")
AddEventHandler("prison-janitor:toggleJob", function(targetSrc)
    local src = source
    if targetSrc then src = targetSrc end
    if not currentlyCleaning[src] then
        print("starting prison job")
        local options = getAvailableTaskOptions()
        local chosenTask = options[math.random(#options)]
        local locations = cleaningLocations[chosenTask]
        TriggerClientEvent("prison-janitor:startJobClient", src, locations, chosenTask)
        TriggerClientEvent("usa:notify", src, "You've started cleaning job: " .. chosenTask)
        currentlyCleaning[src] = deepcopy(locations)
        currentlyCleaningTaskName[src] = chosenTask
    else
        print("stopping job")
        -- calculate time for cleaned areas
        local char = exports["usa-characters"]:GetCharacter(src)
        local time = char.get("jailTime")
        local payment = 0
        for i = 1, #currentlyCleaning[src] do
            if currentlyCleaning[src][i].cleaned then
                time = time - REDUCE_TIME_RATES[currentlyCleaningTaskName[src]]
                payment = payment + PAY_RATES[currentlyCleaningTaskName[src]]
            end
        end
        char.set("jailTime", math.max(time, 1))
        char.giveBank(payment, "DOC Janitor Pay")
        TriggerClientEvent("usa:notify", src, "You've been paid: $" .. exports.globals:comma_value(payment), "^3INFO: ^0You've been paid: $" .. exports.globals:comma_value(payment))
        TriggerClientEvent("usa:notify", src, "Reduced Prison Time, New Time: " .. math.max(time, 1), "^3INFO: ^0Reduced Prison Time, New Time: " .. math.max(time, 1))
        -- record stoppage
        currentlyCleaning[src] = nil
        currentlyCleaningTaskName[src] = nil
        TriggerClientEvent("prison-janitor:removeCurrentJobLocations", src)
    end
end)

RegisterServerEvent("prison-janitor:markLocationAsCleaned")
AddEventHandler("prison-janitor:markLocationAsCleaned", function(index, securityToken)
    if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
		return false
	end
    if currentlyCleaning[source][index].startCleanTime and os.difftime(os.time(), currentlyCleaning[source][index].startCleanTime) >= CLEANING_TIME_SECONDS then
        print("marking table " .. index .. " as cleaned")
        currentlyCleaning[source][index].cleaned = true
        if getNumCleaned(currentlyCleaning[source]) >= #currentlyCleaning[source] then
            print("finished cleaning all locations for job")
            TriggerEvent("prison-janitor:toggleJob", source)
        else
            TriggerClientEvent("usa:notify", source, "Table cleaned!", "^3INFO: ^0Table cleaned!")
        end
    end
end)

RegisterServerEvent("prison-janitor:markLocationAsBeingCleaned")
AddEventHandler("prison-janitor:markLocationAsBeingCleaned", function(index, securityToken)
    if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
		return false
	end
    print("marking table " .. index .. " as being cleaned")
    currentlyCleaning[source][index].startCleanTime = os.time()
end)

AddEventHandler("playerDropped", function(reason)
    if currentlyCleaning[source] then
        currentlyCleaning[source] = nil
        currentlyCleaningTaskName[source] = nil
    end
end)

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function getNumCleaned(locations)
    local count = 0
    for i = 1, #locations do
        if locations[i].cleaned then
            count = count + 1
        end
    end
    return count
end

function getAvailableTaskOptions()
    local ret = {}
    for taskName, taskInfo in pairs(cleaningLocations) do
        table.insert(ret, taskName)
    end
    return ret
end

-- thread to remove people from job if they escape or are released:
Citizen.CreateThread(function()
    while true do
        for src, currentTaskName in pairs(currentlyCleaningTaskName) do
            local c = exports["usa-characters"]:GetCharacter(src)
            if c.get("jailTime") <= 0 then
                TriggerEvent("prison-janitor:toggleJob", src)
            end
        end
        Wait(1000)
    end
end)
