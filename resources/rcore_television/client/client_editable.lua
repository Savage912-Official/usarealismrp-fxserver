-- adding suggestions messages for commands
CreateThread(function()
    TriggerEvent('chat:addSuggestion', "/" .. Config.volumeCommand, _U("volume_info") or 'Will set a new volume for TV', {
        { name = _U("volume_argument") or "volume", help = "0-100" },
    })

    TriggerEvent('chat:addSuggestion', "/" .. Config.playUrl, _U("playlink_info") or 'Will play a custom URL in the TV.', {
        { name = "URL", help = _U("play_url_info") or "Your URL for website" },
    })
end)

-- fetching cache
CreateThread(function()
    TriggerServerEvent("rcore_television:fetchCache")
end)