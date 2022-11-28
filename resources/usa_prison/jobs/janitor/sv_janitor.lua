local cleaningLocations = {
    ["tables"] = {
        {x = 1759.0582275391, y = 2484.3369140625, z = 46.561180114746},
        {x = 1763.8211669922, y = 2487.0903320313, z = 46.561172485352},
        {x = 1768.84375, y = 2489.9106445313, z = 46.561157226563}
    },
    ["gym"] = {
        {x = 1746.9866943359, y = 2481.8576660156, z = 45.740688323975},
        {x = 1742.3884277344, y = 2481.8435058594, z = 45.740657806396},
        {x = 1745.3166503906, y = 2483.8564453125, z = 45.740657806396},
        {x = 1747.2858886719, y = 2479.1188964844, z = 45.740657806396}
    },
    --[[
    ["kitchen"] = {

    },
    ["cells"] = {

    }
    --]]
}

local REDUCE_TIME_RATES = {
    tables = math.random(0, 2),
    gym = math.random(0, 3)
}

local PAY_RATES = {
    tables = math.random(20, 60),
    gym = math.random(25, 75)
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
        char.set("jailTime", time)
        char.giveBank(payment)
        TriggerClientEvent("usa:notify", src, "You've been paid: $" .. exports.globals:comma_value(payment))
        TriggerClientEvent("usa:notify", src, "Reduced Prison Time, New Time: " .. time)
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