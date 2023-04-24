local lib = exports.loaf_lib:GetLib()

RegisterNUICallback("Home", function(data, cb)
    local action = data.action

    if action == "getHomes" then
        if Config.HouseScript == "loaf_housing" then
            local ownedHouses = exports.loaf_housing:GetOwnedHouses()

            local toSend = {}
            for _, v in pairs(ownedHouses) do
                if v then
                    toSend[#toSend+1] = {
                        label = v.label .. " (" .. v.uniqueId .. ")",
                        id = v.id,
                        uniqueId = v.uniqueId,
                        locked = lib.TriggerCallbackSync("loaf_housing:get_locked", v.id, v.uniqueId),
                        keyholders = v.keyHolders
                    }
                end
            end

            cb(toSend)
        end
    elseif action == "removeKeyholder" then
        if Config.HouseScript == "loaf_housing" then
            cb(exports.loaf_housing:RemoveKeyHolder(data.id, data.identifier))
        end
    elseif action == "addKeyholder" then
        if Config.HouseScript == "loaf_housing" then
            if exports.loaf_housing:GiveKey(data.id, tonumber(data.source)) then
                SetTimeout(500, function()
                    cb(exports.loaf_housing:GetKeyHolders(data.id))
                end)
            end
        end
    elseif action == "toggleLocked" then
        if Config.HouseScript == "loaf_housing" then
            TriggerServerEvent("loaf_housing:used_key", {
                key_id = ("housing_key_%i_%s"):format(data.id, data.uniqueId)
            })

            SetTimeout(500, function()
                cb(lib.TriggerCallbackSync("loaf_housing:get_locked", data.id, data.uniqueId))
            end)
        end
    elseif action == "setWaypoint" then
        if Config.HouseScript == "loaf_housing" then
            exports.loaf_housing:MarkProperty(data.id)
        end
    end
end)