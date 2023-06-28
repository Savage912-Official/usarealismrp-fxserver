function ShowNotification(text)
    exports.globals:notify(text)
end

function ShowHelpNotification(text)
    exports.globals:notify(text, "^3INFO: ^0" .. text)
end

function GetPlayersInArea(coords, maxDistance)
    local players = GetActivePlayers()
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    local distance = distance or 5
    local closePlayers = {}
    for _, player in pairs(players) do
        local target = GetPlayerPed(player)
        local targetCoords = GetEntityCoords(target)
        local targetdistance = #(targetCoords - coords)
        if targetdistance <= distance then
            closePlayers[#closePlayers + 1] = player
        end
    end
    return closePlayers
end

function CanAccessGroup(data)
    --[[
    if not data then return true end
    local pdata = QBCore.Functions.GetPlayerData()
    for k,v in pairs(data) do 
        if (pdata.job.name == k and pdata.job.grade.level >= v) then return true end
    end
    return false
    --]]
    return true
end 

function GiveKeys(vehicle)
end

function ToggleDutyEvent(onduty)
    if onduty then
        -- give hard hat
        local playerModel = GetEntityModel(PlayerPedId())
        if GetHashKey("mp_m_freemode_01") == playerModel then
            SetPedPropIndex(PlayerPedId(), 0, 155, 1, true)
        elseif GetHashKey("mp_f_freemode_01") == playerModel then
            SetPedPropIndex(PlayerPedId(), 0, 154, 1, true)
        end
        -- help text
        local help = "The hammers marked on your map are the available work sites. Head to one and interact with the yellow build point markers to build structures. Make sure you buy the materials needed from the material store. You can also rent a vehicle for a fee to take to the job site. Place down a lift to reach high build points."
        exports.globals:notify(false, "^3INFO: ^0" .. help)
    else
        -- reset appearance
        TriggerServerEvent("usa:loadPlayerComponents")
    end
end

function GetConvertedClothes(oldClothes)
    local clothes = {}
    local components = {
        ['arms'] = "arms",
        ['tshirt_1'] = "t-shirt", 
        ['torso_1'] = "torso2", 
        ['bproof_1'] = "vest",
        ['decals_1'] = "decals", 
        ['pants_1'] = "pants", 
        ['shoes_1'] = "shoes", 
        ['helmet_1'] = "hat", 
    }
    local textures = {
        ['tshirt_1'] = 'tshirt_2', 
        ['torso_1'] = 'torso_2',
        ['bproof_1'] = 'bproof_2',
        ['decals_1'] = 'decals_2',
        ['pants_1'] = 'pants_2',
        ['shoes_1'] = 'shoes_2',
        ['helmet_1'] = 'helmet_2',
    }
    for k,v in pairs(oldClothes) do 
        local component = components[k]
        if component then 
            local texture = textures[k] and (oldClothes[textures[k]] or 0) or 0
            clothes[component] = {item = v, texture = texture}
        end
    end
    return clothes
end

CreateThread(function()
    for k,v in pairs(Config.Workplace.outfit) do
        Config.Workplace.outfit[k] = GetConvertedClothes(Config.Workplace.outfit[k])
    end
end)

RegisterNetEvent(GetCurrentResourceName()..":showNotification", function(text)
    ShowNotification(text)
end)