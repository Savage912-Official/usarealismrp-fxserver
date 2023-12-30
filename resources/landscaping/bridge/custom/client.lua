function ShowNotification(text)
    exports.globals:notify(text, text)
end

function ShowHelpNotification(text)
    AddTextEntry('HelpNotification', text)
    BeginTextCommandDisplayHelp('HelpNotification')
    EndTextCommandDisplayHelp(0, false, false, -1)
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

function ToggleDuty(onduty)
    if onduty then
        -- give outfit
        local playerModel = GetEntityModel(PlayerPedId())
        if GetHashKey("mp_m_freemode_01") == playerModel then
            SetPedPropIndex(PlayerPedId(), 0, 114, 21, true)
        elseif GetHashKey("mp_f_freemode_01") == playerModel then
            SetPedPropIndex(PlayerPedId(), 0, 113, 21, true)
        end
        -- help text
        local help = "The green markers on your map are the available work sites. Head to one and either cut the grass, water the plant, or blow the leaves away. Make sure you buy the items needed from the store. You can also rent a vehicle for a fee to carry the driveable lawnmower to job sites. Use the items in your inventory after buying them to bring them out. Press backspace to put them away."
        exports.globals:notify(false, "^3INFO: ^0" .. help)
    else
        -- reset appeareance
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
        ['chain_1'] = "accessory", 
    }
    local textures = {
        ['tshirt_1'] = 'tshirt_2', 
        ['torso_1'] = 'torso_2',
        ['bproof_1'] = 'bproof_2',
        ['decals_1'] = 'decals_2',
        ['pants_1'] = 'pants_2',
        ['shoes_1'] = 'shoes_2',
        ['helmet_1'] = 'helmet_2',
        ['chain_1'] = 'chain_2',
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

RegisterNetEvent('character:loaded', function()
    TriggerServerEvent("pickle_landscaping:initializePlayer")
end)