local CONTRABAND_SPAWN_LOCATIONS = {
    {x = 1762.8768310547, y = 2584.4411621094, z = 45.7978515625}, -- shower 1
    {x = 1762.880859375, y = 2579.7138671875, z = 45.880451202393}, -- shower 2
    {x = 1764.0368652344, y = 2579.7194824219, z = 45.797798156738}, -- shower 3
    {x = 1764.0438232422, y = 2584.4367675781, z = 45.797840118408}, -- shower 4
    {x = 1765.1763916016, y = 2599.7731933594, z = 45.797840118408}, -- gym water cooler
    {x = 1776.4080810547, y = 2599.146484375, z = 45.797840118408}, -- kitchen 1
    {x = 1780.5495605469, y = 2596.6528320313, z = 45.797840118408}, -- kitchen 2
    {x = 1767.5595703125, y = 2586.5549316406, z = 45.797840118408}, -- lower cell 8
    {x = 1767.5573730469, y = 2582.5402832031, z = 45.797840118408}, -- lower cell 7
    {x = 1767.5617675781, y = 2578.7133789063, z = 45.797840118408}, -- lower cell 6
    {x = 1767.8166503906, y = 2574.6467285156, z = 45.797840118408}, -- lower cell 5
    {x = 1791.2562255859, y = 2573.2216796875, z = 45.797840118408}, -- lower cell 4
    {x = 1791.2561035156, y = 2577.0673828125, z = 45.797840118408}, -- lower cell 3
    {x = 1791.2584228516, y = 2581.0261230469, z = 45.797840118408}, -- lower cell 2
    {x = 1791.2557373047, y = 2584.5236816406, z = 45.797801971436}, -- lower cell 1
    {x = 1790.5904541016, y = 2598.6057128906, z = 50.549671173096}, -- upper cell 1
    {x = 1791.0819091797, y = 2584.9045410156, z = 50.549671173096}, -- upper cell 2
    {x = 1791.0841064453, y = 2577.0261230469, z = 50.549667358398}, -- upper cell 3
    {x = 1791.0853271484, y = 2572.9738769531, z = 50.549667358398}, -- upper cell 4
    {x = 1785.1704101563, y = 2567.3498535156, z = 50.549667358398}, -- upper cell 5
    {x = 1773.4113769531, y = 2567.3471679688, z = 50.549682617188}, -- upper cell 7
    {x = 1768.0294189453, y = 2579.0327148438, z = 50.54967880249}, -- upper cell 8
    {x = 1768.0277099609, y = 2586.9138183594, z = 50.54967880249}, -- upper cell 9
    {x = 1768.4625244141, y = 2594.3125, z = 50.54967880249}, -- upper cell 10
    {x = 1768.0307617188, y = 2596.4873046875, z = 50.554759979248}, -- upper cell 11
    {x = 1766.5052490234, y = 2577.8801269531, z = 50.549682617188}, -- upstairs storage room 1
    {x = 1763.0809326172, y = 2582.6928710938, z = 50.549682617188}, -- upstairs storage room 2
}

for i = 1, #CONTRABAND_SPAWN_LOCATIONS do
    CONTRABAND_SPAWN_LOCATIONS[i].z = CONTRABAND_SPAWN_LOCATIONS[i].z - 0.85
end

local CONTRABAND_ITEMS = {
    { name = 'Advanced Pick', type = 'misc', price = 150, legality = 'illegal', quantity = 1, weight = 7, objectModel = "prop_tool_screwdvr03", doNotAutoRemove = true},
    { name = "Broken Bottle", type = "weapon", hash = -102323637, price = 75, legality = "illegal", quantity = 1, weight = 15, objectModel = "ng_proc_beerbottle_01a", notStackable = true },
    { name = "Shiv", type = "weapon", hash = GetHashKey("WEAPON_SHIV"), price = 50, legality = "illegal", quantity = 1, weight = 5, objectModel = "w_me_shiv", notStackable = true},
    { name = "Cell Phone", price = 650, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "prop_npc_phone_02", notStackable = true }
}

local ITEM_SPAWN_INTERVAL = 1

local ITEM_SPAWN_CHANCE = 0.17

local DEBUG_MODE = false

-- randomly have a chance of spawning one of the contraband items at one of the contraband locations every ITEM_SPAWN_INTERVAL hours
Citizen.CreateThread(function()
    while true do
        local lastCheckTime = os.time()
        while os.difftime(os.time(), lastCheckTime) < ITEM_SPAWN_INTERVAL * 60 * 60 do
            Wait(1)
        end
        if math.random() <= ITEM_SPAWN_CHANCE then
            -- add dropped item
            local contrabandItemToDrop = CONTRABAND_ITEMS[math.random(#CONTRABAND_ITEMS)]
            local contrabandSpawnLocation = CONTRABAND_SPAWN_LOCATIONS[math.random(#CONTRABAND_SPAWN_LOCATIONS)]
            contrabandItemToDrop.uuid = exports.globals:generateID()
            contrabandItemToDrop.coords = contrabandSpawnLocation
            TriggerEvent("interaction:addDroppedItem", contrabandItemToDrop)
            if DEBUG_MODE then
                print("dropping item:\n" .. exports.globals:dump(contrabandItemToDrop))
            end
        end
        Wait(1)
    end
end)
