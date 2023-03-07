local speakers = {}

local speakerItem = { name = "Speaker", price = 10000, legality = "legal", quantity = 1, type = "misc", weight = 20, objectModel = "sm_prop_smug_speaker", doNotAutoRemove = true }

RegisterServerEvent("speaker:load")
AddEventHandler("speaker:load", function()
    for id, info in pairs(speakers) do
        speakers[id].currentTimestamp = os.difftime(os.time(), info.startedAt)
    end
    TriggerClientEvent("speaker:loaded", source, speakers)
end)

RegisterServerEvent("speaker:create")
AddEventHandler("speaker:create", function(coords)
    local newSpeaker = {
        id = exports.globals:generateID(),
        coords = coords,
        model = "sm_prop_smug_speaker"
    }
    TriggerClientEvent("speaker:create", -1, newSpeaker)
    speakers[newSpeaker.id] = newSpeaker
    local char = exports["usa-characters"]:GetCharacter(source)
    char.removeItem("Speaker", 1)
end)

RegisterServerEvent("speaker:play")
AddEventHandler("speaker:play", function(data)
    TriggerClientEvent("speaker:play", -1, data)
    speakers[data.id].url = data.url
    speakers[data.id].distance = data.distance
    speakers[data.id].volume = data.volume
    speakers[data.id].startedAt = os.time()
end)

RegisterServerEvent("speaker:stop")
AddEventHandler("speaker:stop", function(data)
    TriggerClientEvent("speaker:stop", -1, data)
    speakers[data.id].url = nil
    speakers[data.id].distance = nil
    speakers[data.id].startedAt = nil
end)

RegisterServerEvent("speaker:pickUp")
AddEventHandler("speaker:pickUp", function(data)
    if speakers[data.id] then
        speakers[data.id] = nil
        TriggerClientEvent("speaker:pickUp", -1, data)
        local char = exports["usa-characters"]:GetCharacter(source)
        char.giveItem(speakerItem)
    end
end)

RegisterServerEvent("speaker:updateVolume")
AddEventHandler("speaker:updateVolume", function(data)
    speakers[data.id].volume = data.new
    TriggerClientEvent("speaker:updateVolume", -1, data)
end)