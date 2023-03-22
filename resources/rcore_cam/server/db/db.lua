
function DbSaveRecording(camId, storageName)
    local generatedId = GenerateUniqueId()

    local id = MySQL.Sync.insert([[
        INSERT INTO camera_recordings (`id`, `groupId`, `stored`, `recordedAt`) VALUES (@id, @groupId, @stored, NOW())
    ]], {
        ['@id'] = generatedId,
        ['@groupId'] = camId,
        ['@stored'] = storageName,
    })

    return generatedId
end

function DbRecordExistsWithId(id)
    local id = MySQL.Sync.fetchScalar('SELECT id FROM camera_recordings WHERE id=@id', {['@id'] = id})

    if id then
        return true
    else
        return false
    end
end

function DbGetRecordById(id)
    local recs = MySQL.Sync.fetchAll('SELECT * FROM camera_recordings WHERE id=@id', {['@id'] = id})

    if recs and recs[1] then
        return recs[1]
    end

    return nil
end

function DbGetRecordings(place, placeOnlyStart)
    return MySQL.Sync.fetchAll([[
        SELECT id, groupId, `stored`, DATE_FORMAT(recordedAt, '%Y-%m-%d %H:%i:%s') as recordedAt 
        FROM camera_recordings 
        WHERE `stored` LIKE @place
        ORDER BY recordedAt DESC
    ]], {
        ['@place'] = place
    })
end

function DbGetOldRecordings()
    return MySQL.Sync.fetchAll([[
        SELECT id, groupId, `stored`, DATE_FORMAT(recordedAt, '%Y-%m-%d %H:%i:%s') as recordedAt 
        FROM camera_recordings 
        WHERE recordedAt < DATE_SUB(NOW(), INTERVAL 7 DAY)
    ]])
end

function DbDeleteRecording(id)
    MySQL.Sync.execute([[
        DELETE FROM camera_recordings 
        WHERE id=@id
    ]], {
        ['@id'] = id,
    })
end


function DbTransferRecording(id, newPlace)
    MySQL.Sync.execute([[
        UPDATE camera_recordings 
        SET `stored`=@place
        WHERE id=@id
    ]], {
        ['@id'] = id,
        ['@place'] = newPlace,
    })
end