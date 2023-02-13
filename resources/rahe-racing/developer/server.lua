function isPlayerAllowedToJoinRace(playerId)
    -- print('isPlayerAllowedToJoinRace')
    -- print(playerId)
    return true
end

AddEventHandler('rahe-racing:server:playerJoinedRace', function(playerId)
    -- print('rahe-racing:server:playerJoinedRace')
    -- print(playerId)
end)

AddEventHandler('rahe-racing:server:newRaceCreated', function(startCoords)
    -- print('rahe-racing:server:raceCreated')
    -- print('startcoords: '.. startCoords)
end)

AddEventHandler('rahe-racing:server:raceStarted', function(startCoords, participants)
    -- print('rahe-racing:server:raceStarted')
    -- print('startCoords: ' ..startCoords)
    -- print('participants:')
    -- print(DumpTable(participants))
    TriggerEvent('911:IllegalRacing', startCoords.x, startCoords.y, startCoords.z)
end)