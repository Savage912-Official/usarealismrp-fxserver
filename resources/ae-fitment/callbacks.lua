-- READ ME BEFORE EDITING ANYTHING IN THIS FILE.
-- These sql queries will work for ESX and QBCore, there shouldn't be any need to edit them unless you're adapting to another framework or database structure.

-- Functions

local function trim(s)
    if not s or s == nil or s == '' then return end
    return string.gsub(s, "^%s*(.-)%s*$", "%1")
end

-- Callbacks

-- Callback recives vehicle's number plate given by GetVehicleNumberPlateText() and an array.
-- SQL query updates Config.Column in Config.Database that matches the number plate recived from the client callback.
lib.callback.register('ae-fitment:SaveWheelFitment', function(source, uplate, data)
    local plate = trim(uplate)

    MySQL.update('UPDATE ' .. Config.Database .. ' SET ' .. Config.Column .. ' = ? WHERE plate = ?', { json.encode(data), plate })
end)

-- Callback recives vehicle's number plate given by GetVehicleNumberPlateText().
-- SQL query returns data from the Config.Column in the Config.Database that matches the number plate recived from the client callback.
lib.callback.register('ae-fitment:GetWheelFitment', function(source, uplate)
    local plate = trim(uplate)

    if plate ~= nil then
        local platedata = MySQL.query.await('SELECT * FROM veh_fitment WHERE plate = ?', {plate})
        if platedata[1] ~= nil then
            local data = MySQL.query.await('SELECT ' .. Config.Column .. ' FROM ' .. Config.Database .. ' WHERE plate = ?', { plate })
            return json.decode(data[1].fitment) or false
        else
            MySQL.insert('INSERT INTO veh_fitment (plate) VALUES (?)', { plate })
        end
    end
end)