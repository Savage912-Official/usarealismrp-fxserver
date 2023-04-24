local lib = exports.loaf_lib:GetLib()

---Check if a vehicle is out
---@param plate string
---@param vehicles any
---@return boolean out
---@return number | nil vehicle
local function IsVehicleOut(plate, vehicles)
    if not vehicles then
        vehicles = GetAllVehicles()
    end

    for i = 1, #vehicles do
        local vehicle = vehicles[i]
        if DoesEntityExist(vehicle) and GetVehicleNumberPlateText(vehicle):gsub("%s+", "") == plate:gsub("%s+", "") then
            return true, vehicle
        end
    end

    return false
end

lib.RegisterCallback("phone:garage:findCar", function(source, cb, plate)
    local source = source
    local phoneNumber = GetEquippedPhoneNumber(source)

    local out, vehicle = IsVehicleOut(plate)
    if out then
        cb(GetEntityCoords(vehicle))
    else
        local vehicle = exports["essentialmode"]:getDocument("vehicles", plate)
        if vehicle.impounded then
            if phoneNumber then
                SendNotification(phoneNumber, {
                    source = source,
                    app = "Garage",
                    title = L("BACKEND.GARAGE.VALET"),
                    content = L("BACKEND.GARAGE.COULDNT_FIND"),
                })
            end
            cb(false)
        end
        if vehicle.stored_location then
            if type(vehicle.stored_location) == "table" then
                local garage_location = vector3(vehicle.stored_location.x, vehicle.stored_location.y, vehicle.stored_location.z)
                cb(garage_location)
            else
                local query = {
                    ["name"] = vehicle.stored_location
                }
                local garage = exports["essentialmode"]:getDocumentsByRows("properties", query)[1].garage_coords
                if garage ~= nil then
                    local garage_location = vector3(garage.x, garage.y, garage.z)
                    cb(garage_location)
                else
                    if phoneNumber then
                        SendNotification(phoneNumber, {
                            source = source,
                            app = "Garage",
                            title = L("BACKEND.GARAGE.VALET"),
                            content = L("BACKEND.GARAGE.COULDNT_FIND"),
                        })
                    end
                    cb(false)
                end
            end
        else
            if phoneNumber then
                SendNotification(phoneNumber, {
                    source = source,
                    app = "Garage",
                    title = L("BACKEND.GARAGE.VALET"),
                    content = L("BACKEND.GARAGE.COULDNT_FIND"),
                })
            end
            cb(false)
        end
    end
end)

lib.RegisterCallback("phone:garage:getVehicles", function(source, cb)
    GetPlayerVehicles(source, function(vehicles)
        if #vehicles > 0 then
            local allVehicles = GetAllVehicles()
            for i = 1, #vehicles do
                if IsVehicleOut(vehicles[i].plate, allVehicles) then
                    vehicles[i].locked = exports["_locksystem"]:isLocked(vehicles[i].plate)
                    vehicles[i].location = "out"
                end
            end
        end

        cb(vehicles)
    end)
end)

function GetVehicleCustomizations(plate, cb)
    local endpoint = "/vehicles/_design/vehicleFilters/_view/getVehicleCustomizationsByPlate"
    local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
    PerformHttpRequest(url, function(err, responseText, headers)
        if responseText then
            local customizations = {}
            local data = json.decode(responseText)
            if data.rows and data.rows[1].value then
                customizations = data.rows[1].value[1] -- customizations
            end
            cb(customizations)
        end
    end, "POST", json.encode({
        keys = { plate }
    }), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

lib.RegisterCallback("phone:garage:valetVehicle", function(source, cb, plate)
    local phoneNumber = GetEquippedPhoneNumber(source)
    if not phoneNumber then
        return cb()
    end

    if exports["essentialmode"]:getDocument("vehicles", plate).impounded then
        SendNotification(phoneNumber, {
            app = "Garage",
            title = L("BACKEND.GARAGE.VALET"),
            content = ("Vehicle is Impounded, go to a garage for more info!"),
        })
        return cb()
    end

    if IsVehicleOut(plate) then
        SendNotification(phoneNumber, {
            app = "Garage",
            title = L("BACKEND.GARAGE.VALET"),
            content = L("BACKEND.GARAGE.ALREADY_OUT"),
        })
        return cb()
    end

    if Config.Valet.Price and not RemoveMoney(source, Config.Valet.Price) then
        SendNotification(phoneNumber, {
            app = "Garage",
            title = L("BACKEND.GARAGE.VALET"),
            content = L("BACKEND.GARAGE.NO_MONEY"),
        })
        return cb()
    end

    GetVehicle(source, function(vehicleData)
        if not vehicleData then
            if Config.Valet.Price then
                AddMoney(source, Config.Valet.Price)
            end
            return cb()
        end

        SendNotification(phoneNumber, {
            app = "Garage",
            title = L("BACKEND.GARAGE.VALET"),
            content = L("BACKEND.GARAGE.ON_WAY"),
        })

        vehicleData.upgrades = exports["usa_mechanicjob"]:GetUpgradeObjectsFromIds(vehicleData.upgrades)
        GetVehicleCustomizations(vehicleData.plate, function(customizations)

            vehicleData.customizations = customizations

            exports["essentialmode"]:updateDocument("vehicles", plate, { impounded = false, stored = false, stored_location = "deleteMePlz!" })

        AddTransaction(GetEquippedPhoneNumber(source), -1 * Config.Valet.Price, "Valet Service", nil)

        cb(vehicleData)

        end)
    end, plate)
end)