local Sites = {}
local LocalSites = {}
local LocalSiteBlips = {}

function GetSiteEntity(index)
    return LocalSites[index]
end

function CreateSiteEntity(index)
    local cfg = Config.Sites[index]
    local prop = CreateProp(cfg.model, cfg.location.x, cfg.location.y, cfg.location.z, false, true)
    FreezeEntityPosition(prop, true)
    SetEntityHeading(prop, cfg.heading)
    LocalSites[index] = prop
    return prop
end

function DeleteSiteEntity(index)
    if (LocalSites[index]) then 
        DeleteEntity(LocalSites[index])
        LocalSites[index] = nil
    end
end

function GetSiteBlip(index)
    return LocalSiteBlips[index]
end

function EnsureSiteBlip(index)
    local blip = GetSiteBlip(index)
    if not GetDuty() then 
        if blip then DeleteSiteBlip(index) end
        return
    end
    if blip then return blip end
    local cfg = Config.Sites[index]
    LocalSiteBlips[index] = CreateBlip({
        ID = 566,
        Color = 5,
        Scale = 0.85,
        Display = 4, 
        Location = cfg.location,
        Label = _L("blip_site")
    })
    return LocalSiteBlips[index]
end

function DeleteSiteBlip(index)
    if (LocalSiteBlips[index]) then 
        RemoveBlip(LocalSiteBlips[index])
        LocalSiteBlips[index] = nil
    end
end

function InteractSitePoint(index, pointIndex)
    dprint("Site Index: ".. index, "Model Point: " .. pointIndex)
    local cfg = Config.Sites[index]
    local modelcfg = Config.Models[cfg.model]
    local data = Sites[index]
    local pcfg = modelcfg.points[pointIndex]
    local point = data.points[pointIndex]
    CreateThread(function()
        local pass = TriggerServerCallback {
            eventName = "pickle_construction:checkBuildRequirements",
            args = {index, pointIndex}
        }
        if not pass then return ShowNotification("Missing build items") end
        TriggerEvent("interaction:setBusy", true)
        local success = Config.Actions[pcfg.action.type](pcfg.action.args)
        TriggerEvent("interaction:setBusy", false)
        if success then
            TriggerServerEvent("pickle_construction:buildPoint", index, pointIndex)
        else
            ShowNotification(_L("site_build_fail"))
        end
    end)
end

CreateThread(function() 
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local sites = Sites
        local wait = 1500
        for i=1, #sites do 
            local cfg = Config.Sites[i]
            local data = sites[i]
            local dist = #(cfg.location - coords)
            local entity = GetSiteEntity(i)
            local durable = -1
            if (dist < Config.RenderDistance) then 
                wait = 0
                durable = 0
                if not entity then 
                    entity = CreateSiteEntity(i)
                end
                for j=1, #data.points do 
                    local modelcfg = Config.Models[cfg.model]
                    local pcfg = modelcfg.points[j]
                    local point = data.points[j]
                    if not point.durability then 
                        local location = GetOffsetFromEntityInWorldCoords(entity, pcfg.location.x, pcfg.location.y, pcfg.location.z)
                        local pdist = #(location - coords)
                        if GetDuty() then
                            DrawMarker(0, location.x, location.y, location.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.35, 0.35, 0.35, 255, 172, 28, 127, false, false)
                            if pdist < 1.25 and not ShowInteractText(_L("sites_build_point")) and IsControlJustPressed(1, 51) then
                                InteractSitePoint(i, j)
                            end 
                        end
                    else
                        durable = durable + 1
                    end
                end

                local alpha = math.ceil((durable / #data.points) * 255)
                if alpha < 102 then
                    alpha = 102
                elseif alpha >= 204 and durable ~= #data.points then 
                    alpha = 204
                end
                SetEntityAlpha(entity, alpha)
            elseif (entity) then
                DeleteSiteEntity(i)
            end
            if durable < 0 then 
                durable = 0
                for j=1, #data.points do 
                    local modelcfg = Config.Models[cfg.model]
                    local pcfg = modelcfg.points[j]
                    local point = data.points[j]
                    if point.durability then 
                        durable = durable + 1
                    end
                end
            end
            if (durable / #data.points) < 1 then 
                EnsureSiteBlip(i)
            elseif GetSiteBlip(i) then 
                DeleteSiteBlip(i)
            end
        end 
        Wait(wait)
    end
end)

RegisterNetEvent("pickle_construction:updateSite", function(id, data)
    if type(id) == "table" then 
        Sites = id
    else
        Sites[id] = data
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for k,v in pairs(LocalSites) do 
        DeleteEntity(v)
    end
end)
  

RegisterCommand("constructoffset", function()
    local closest = {}
    local sites = Sites
    local coords = GetEntityCoords(PlayerPedId())
    for i=1, #sites do 
        local cfg = Config.Sites[i]
        local data = sites[i]
        local dist = #(cfg.location - coords)
        if (not closest.dist or closest.dist > dist) then
            closest.index = i
            closest.dist = dist
        end 
    end 
    local entity = GetSiteEntity(closest.index)
    local offset = GetOffsetFromEntityGivenWorldCoords(entity, coords.x, coords.y, coords.z)
    dprint("Site Model: ".. Config.Sites[closest.index].model, "Site Offset: " .. offset)
end)