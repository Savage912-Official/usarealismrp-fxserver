local lastRobTime = nil

local lastRewardRequestTime = {}

local hasDoorBeenThermited = false
local haveGuardsSpawned = false

RegisterServerCallback {
    eventName = "artHeist:hasDoorBeenThermited",
    eventCallback = function(source)
        return hasDoorBeenThermited
    end
}

RegisterServerCallback {
    eventName = "artHeist:haveGuardsSpawned",
    eventCallback = function(source)
        return haveGuardsSpawned
    end
}

RegisterServerCallback {
    eventName = "artHeist:getCops",
    eventCallback = function(source)
        local numCops = nil
        local waiting = true
        exports.globals:getNumCops(function(num)
            numCops = num
            waiting = false
        end)
        while waiting do
            Wait(1)
        end
        return numCops
    end
}

RegisterServerCallback {
    eventName = "artHeist:checkRobTime",
    eventCallback = function(source)
        if lastRobTime == nil or os.time() - lastRobTime >= Config.CooldownHours * 60 * 60 then
            hasDoorBeenThermited = false
            haveGuardsSpawned = false
            exports.usa_doormanager:toggleDoorLockByName("Art Mansion Front", true)
            lastRobTime = os.time()
            return true
        else
            TriggerClientEvent("usa:notify", source, "Not ready to be robbed yet", "^3INFO: ^0Not ready to be robbed yet")
            return false
        end
    end
}

RegisterServerEvent('artHeist:makeGuardsAggressiveForAll')
AddEventHandler('artHeist:makeGuardsAggressiveForAll', function()
    TriggerClientEvent("artHeist:makeGuardsAggressive", -1)
    haveGuardsSpawned = true
end)

RegisterServerEvent('vt-artheist:server:syncHeistStart')
AddEventHandler('vt-artheist:server:syncHeistStart', function()
    TriggerClientEvent('vt-artheist:client:syncHeistStart', -1)
end)

RegisterServerEvent('vt-artheist:server:syncPainting')
AddEventHandler('vt-artheist:server:syncPainting', function(x)
    TriggerClientEvent('vt-artheist:client:syncPainting', -1, x)
end)

RegisterServerEvent('vt-artheist:server:syncAllPainting')
AddEventHandler('vt-artheist:server:syncAllPainting', function()
    TriggerClientEvent('vt-artheist:client:syncAllPainting', -1)
end)

RegisterServerEvent('vt-artheist:server:rewardItem')
AddEventHandler('vt-artheist:server:rewardItem', function(scene)
    local src = source
    local item = scene['rewardItem']
    local char = exports["usa-characters"]:GetCharacter(src)

    for _, info in pairs(Config["ArtHeist"]["painting"]) do
        if info.rewardItem == item then
            if #(GetEntityCoords(GetPlayerPed(src)) - info.objectPos) < 10 then
                break
            else
                return
            end
        end
    end

    if not char.getItem("Switchblade") then
        return
    end

    if char then
        local itemObj = {
            name = item,
            quantity = 1,
            weight = 15
        }
        char.giveItem(itemObj)
    end
end)

RegisterServerCallback {
    eventName = "artHeist:hasItems",
    eventCallback = function(source)
        local src = source
        local char = exports["usa-characters"]:GetCharacter(src)
        local ge = char.getItem(Config.Items.paintinge)
        local gi = char.getItem(Config.Items.paintingi)
        local gh = char.getItem(Config.Items.paintingh)
        local gj = char.getItem(Config.Items.paintingj)
        local gf = char.getItem(Config.Items.paintingf)
        local gg = char.getItem(Config.Items.paintingg)
        if ge and gi and gh and gj and gf and gg then
            return true
        else
            return false
        end
    end
}

RegisterServerCallback {
    eventName = "artHeist:hasThermite",
    eventCallback = function(source)
        local src = source
        local char = exports["usa-characters"]:GetCharacter(src)
        local thermite = char.getItem('Thermite')
        if thermite then
            return true
        else
            return false
        end
    end
}

RegisterNetEvent('vt-artheist:server:items', function()
    local src = source
    local char = exports["usa-characters"]:GetCharacter(src)
    if not char then return end

    if lastRewardRequestTime[src] and os.time() - lastRewardRequestTime[src]["money"] <= Config.CooldownHours * 60 * 60 then
        TriggerClientEvent("usa:notify", src, "Too soon for money reward, try again later")
        print("too soon for money reward")
        return
    end
    if not lastRewardRequestTime[src] then
        lastRewardRequestTime[src] = {}
    end
    lastRewardRequestTime[src]["money"] = os.time()

    local ge = char.getItem(Config.Items.paintinge)
    local gi = char.getItem(Config.Items.paintingi)
    local gh = char.getItem(Config.Items.paintingh)
    local gj = char.getItem(Config.Items.paintingj)
    local gf = char.getItem(Config.Items.paintingf)
    local gg = char.getItem(Config.Items.paintingg)
    if ge ~= nil and gi ~= nil and gh ~= nil and gj ~= nil and gf ~= nil and gg ~= nil then
        char.removeItem(Config.Items.paintinge, 1)
        char.removeItem(Config.Items.paintingi, 1)
        char.removeItem(Config.Items.paintingh, 1)
        char.removeItem(Config.Items.paintingj, 1)
        char.removeItem(Config.Items.paintingf, 1)
        char.removeItem(Config.Items.paintingg, 1)
        char.giveMoney(Config.Price.paintingeSellAll)
        local commaVal = exports.globals:comma_value(Config.Price.paintingeSellAll)
        TriggerClientEvent("usa:notify", src, "Earned: $" .. commaVal, "^3INFO: ^0You earned $" .. commaVal .. " from the paintings")
    end
end)

RegisterServerEvent('artHeist:useThermite')
AddEventHandler('artHeist:useThermite', function()
    print("toggling door locks")
    -- remove thermite
    local char = exports["usa-characters"]:GetCharacter(source)
    if not char.hasItem("Thermite") then
        TriggerClientEvent("usa:notify", source, "Missing thermite item")
        return
    end
    char.removeItem("Thermite", 1)
    -- unlock mansion doors
    exports.usa_doormanager:toggleDoorLockByName("Art Mansion Front", false)
    hasDoorBeenThermited = true
    -- 911 call from 'neighbor'
    local chance = math.random()
    if chance <= 0.50 then
        TriggerEvent("911:call", 1386.7722167969, 1139.8897705078, 114.33452606201, "Explosion and loud noises heard by nearby hikers at mansion", "Mansion disturbance")
    end
end)

RegisterServerEvent('artHeist:thermiteEffect')
AddEventHandler('artHeist:thermiteEffect', function(door)
    TriggerClientEvent("artHeist:thermiteEffect", -1, door)
end)

AddEventHandler("playerDropped", function(r)
    if lastRewardRequestTime[source] then
        lastRewardRequestTime[source] = nil
    end
end)