RegisterCommand('recordings', function(Source)
    local place = 'char_' .. GetPlayerIdentifier(Source)
    local dbRecs = DbGetRecordings(place)

    TriggerClientEvent('rcore_cam:openPlayerRecordings', Source, dbRecs)
end)

TriggerEvent('es:addJobCommand', 'recordings', { 'sheriff', 'police', "corrections"}, function(source, args, char)
    local place = 'char_' .. GetPlayerIdentifier(source)
    local dbRecs = DbGetRecordings(place)

    TriggerClientEvent('rcore_cam:openPlayerRecordings', source, dbRecs)
end, {
    help = "Open your taken recordings.",
    params = {
    }
})