local sqlDriver = nil

--- We did this to allow for having different default drivers per framework.
if Config.qbSettings.enabled then
    sqlDriver = Config.qbSettings.sqlDriver
end
if Config.esxSettings.enabled then
    sqlDriver = Config.esxSettings.sqlDriver
end
if Config.standaloneSettings.enabled then
    sqlDriver = Config.standaloneSettings.sqlDriver
end
---


RegisterNetEvent('kq_drifttires:server:jackstandUsed')
AddEventHandler('kq_drifttires:server:jackstandUsed', function()
    RemovePlayerItem(source, Config.items.carjackItem, 1)
end)

RegisterNetEvent('kq_drifttires:server:tookOutTire')
AddEventHandler('kq_drifttires:server:tookOutTire', function(type)
    if type == 1 then
        RemovePlayerItem(source, Config.items.driftTireItem, 1)
    else
        RemovePlayerItem(source, Config.items.regularTireItem, 1)
    end
end)

RegisterNetEvent('kq_drifttires:server:tookInTire')
AddEventHandler('kq_drifttires:server:tookInTire', function(type)
    if type == 1 then
        AddPlayerItem(source, Config.items.driftTireItem, 1)
    else
        AddPlayerItem(source, Config.items.regularTireItem, 1)
    end
end)

function SaveVehicleData(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle):gsub(' ', '')
    
    local existingData = GetVehicleData(vehicle)

    if Entity(vehicle).state.hasDriftTires then
        local pressure = Entity(vehicle).state.tirePressure or 50
        
        if #existingData > 0 then
            local query = "UPDATE kq_drifttires SET pressure = @pressure WHERE id = @id AND plate = @plate;"
            local data = {
                ['@id'] = existingData[1].id,
                ['@plate'] = plate,
                ['@pressure'] = pressure,
            }
            
            SqlInsert(query, data)
        else
            local query = "INSERT INTO kq_drifttires (`plate`, `pressure`) VALUES(@plate, @pressure);"
            local data = {
                ['@plate'] = plate,
                ['@pressure'] = pressure,
            }
            
            SqlInsert(query, data)
        end
    else
        if #existingData > 0 then
            local query = "DELETE FROM kq_drifttires WHERE `plate` = @plate;"
            local data = {
                ['@plate'] = plate,
            }
    
            SqlInsert(query, data)
        end
    end
end

function GetVehicleData(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle):gsub(' ', '')
    
    local query = "SELECT * FROM kq_drifttires WHERE plate = @plate"
    local data = {
        ['plate'] = plate,
    }
    
    return SqlFetch(query, data)
end


function SqlFetch(query, data)
    if sqlDriver == 'mysql' then
        return MySQL.Sync.fetchAll(query, data or {})
    end
    
    if sqlDriver == 'oxmysql' then
        if Config.newOxMysql then
            return exports[sqlDriver]:fetchSync(query, data)
        end
        return exports[sqlDriver]:query_async(query, data)
    else
        return exports[sqlDriver]:executeSync(query, data)
    end
end

function SqlInsert(query, data)
    if sqlDriver == 'mysql' then
        MySQL.Sync.insert(query, data)
        return
    end
    
    if sqlDriver == 'oxmysql' then
        exports[sqlDriver]:insertSync(query, data)
    else
        exports[sqlDriver]:executeSync(query, data)
    end
end
