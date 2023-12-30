local Sites = {}

function InitializeSites() 
    for i=1, #Config.Sites do 
        local cfg = Config.Sites[i]
        local modelcfg = Config.Models[cfg.model]
        local site = {
            points = {},
        }
        for j=1, #modelcfg.points do 
            site.points[j] = {
                durability = nil
            }
        end
        Sites[i] = site
    end
    UpdateSite()
    UpdateDurability()
end

function UpdateSite(id, target)
    TriggerClientEvent("pickle_construction:updateSite", target or -1, id or Sites, id and Sites[id] or nil)
end

function UpdateDurability()
    for i=1, #Sites do 
        local data = Sites[i]
        for j=1, #data.points do 
            if data.points[j].durability then 
                local durability = (data.points[j].durability - Config.Durability.durability)
                Sites[i].points[j].durability = (durability > 0 and durability or nil)
            end
        end
    end
    UpdateSite()
    SetTimeout(Config.Durability.time * 1000, UpdateDurability)
end

function CanPlayerBuild(source, index, pointIndex, startBuild) 
    local cfg = Config.Sites[index]
    local modelcfg = Config.Models[cfg.model]
    local data = Sites[index]
    local pcfg = modelcfg.points[pointIndex]
    local point = data.points[pointIndex]
    if not point then return false end
    if not GetDuty(source) then return false, _L("workplace_not_duty") end
    if pcfg.required then 
        for i=1, #pcfg.required do
            local item = pcfg.required[i] 
            local count = Search(source, item.name)
            if count < item.count then 
                return false, _L("item_missing", item.name, item.count - count)
            end
        end
    end
    if startBuild and pcfg.required then 
        for i=1, #pcfg.required do
            local item = pcfg.required[i] 
            RemoveItem(source, item.name, item.count)
        end
    end
    return true
end

RegisterServerCallback {
    eventName = "pickle_construction:checkBuildRequirements",
    eventCallback = function(src, index, pointIndex)
        return CanPlayerBuild(src, index, pointIndex)
    end
}

RegisterNetEvent("pickle_construction:buildPoint", function(index, pointIndex) 
    local source = source
    local success, msg = CanPlayerBuild(source, index, pointIndex, true) 
    if not success then return ShowNotification(source, msg) end
    
    local cfg = Config.Sites[index]
    local modelcfg = Config.Models[cfg.model]
    local data = Sites[index]
    local pcfg = modelcfg.points[pointIndex]
    local point = data.points[pointIndex]
    if not point.durability then 
        data.points[pointIndex].durability = pcfg.durability
        Sites[index] = data
        UpdateSite(index)
        local count = math.random(pcfg.reward.min, pcfg.reward.max)
        count = count + math.random(600, 900)
        AddItem(source, pcfg.reward.name, count)
        ShowNotification(source, _L("site_build_success"))
        TriggerClientEvent("usa:notify", source, false, "^3INFO: ^0Earned $" .. exports.globals:comma_value(count))
    else
        ShowNotification(source, _L("site_build_already"))
    end
end)

InitializeSites()