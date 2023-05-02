local VEHICLES = {
    {
        MODEL = "BMW M3 GTS (e92)",
        HASH = "m3e92gts",
        COORDS = vector3(-1253.7752685547, -364.77194213867, 35.933825683594),
        HEADING = 295.0,
        PRICE = 190000,
        CAPACITY = 180
    },
    {
        MODEL = "BMW M3 (e92)",
        HASH = "bmwm3e92",
        COORDS = vector3(-1248.1538085938, -361.98043823242, 35.907482147217),
        HEADING = 115.0,
        PRICE = 135000,
        CAPACITY = 180
    },
    {
        MODEL = "BMW M4 (f82)",
        HASH = "f82st",
        COORDS = vector3(-1268.9112548828, -364.60543823242, 35.907493591309),
        HEADING = 117.0,
        PRICE = 180000,
        CAPACITY = 220
    },
    {
        MODEL = "BMW M4 Widebody (f82lw)",
        HASH = "f82lw",
        COORDS = vector3(-1243.0841064453, -345.67370605469, 36.342809448242),
        HEADING = 211.0,
        PRICE = 190000,
        CAPACITY = 220
    },
    {
        MODEL = "BMW M2",
        HASH = "m2",
        COORDS = vector3(-1270.4283447266, -358.63748168945, 35.907474517822),
        HEADING = 68.0,
        PRICE = 165000,
        CAPACITY = 180
    },
    {
        MODEL = "2016 BMW X5 M",
        HASH = "X5M2016",
        COORDS = vector3(-1265.2856445313, -354.64617919922, 35.907466888428),
        HEADING = 25.0,
        PRICE = 160000,
        CAPACITY = 300
    },
    {
        MODEL = "BMW M5",
        HASH = "bmci",
        COORDS = vector3(-1258.8269042969, -362.40911865234, 35.907482147217),
        HEADING = 298.0,
        PRICE = 170000,
        CAPACITY = 220
    },
    {
        MODEL = "BMW i8",
        HASH = "i8",
        COORDS = vector3(-1252.8897705078, -359.19836425781, 35.907455444336),
        HEADING = 115.0,
        PRICE = 245000,
        CAPACITY = 120
    },
    {
        MODEL = "BMW M3 (e36)",
        HASH = "rmodm3e36",
        COORDS = vector3(-1237.3372802734, -354.88641357422, 36.292712249756),
        HEADING = 24.0,
        PRICE = 70000,
        CAPACITY = 180
    },
    {
        MODEL = "BMW M3 (e30)",
        HASH = "alpinae30",
        COORDS = vector3(-1233.5505371094, -352.83551025391, 36.317181243896),
        HEADING = 21.0,
        PRICE = 80000,
        CAPACITY = 180
    },
    {
        MODEL = "BMW M5 (e60)",
        HASH = "m5e60",
        COORDS = vector3(-1229.9564208984, -350.99856567383, 36.371473846436),
        HEADING = 20.0,
        PRICE = 150000,
        CAPACITY = 220
    },
    {
        MODEL = "BMW Z3 M Coupe",
        HASH = "z3",
        COORDS = vector3(-1233.3747558594, -345.14904785156, 36.332824707031),
        HEADING = 114.0,
        PRICE = 80000,
        CAPACITY = 160
    },
    {
        MODEL = "BMW M3 (e46)",
        HASH = "m3e46",
        COORDS = vector3(-1240.7839355469, -357.05194091797, 36.332832336426),
        HEADING = 21.0,
        PRICE = 80000,
        CAPACITY = 180
    },
    {
        MODEL = "BMW M5 (e34)",
        HASH = "e34",
        COORDS = vector3(-1256.7427978516, -355.42782592773, 35.907447814941),
        HEADING = 120.0,
        PRICE = 90000,
        CAPACITY = 220
    },
    --[[
    {
        MODEL = "BMW M3 Custom (e46)",
        HASH = "m3kean",
        COORDS = vector3(-1241.0963134766, -345.73568725586, 37.332790374756),
        HEADING = 209.0,
        PRICE = 135000,
        CAPACITY = 130
    }
    --]]
}

RegisterServerEvent("bmwshop:loadVehicles")
AddEventHandler("bmwshop:loadVehicles", function()
    TriggerClientEvent("bmwshop:loadVehicles", source, VEHICLES)
end)

RegisterServerEvent("bmwshop:buy")
AddEventHandler("bmwshop:buy", function(index)
    local src = source
    local char = exports["usa-characters"]:GetCharacter(src)
    if char.get("money") >= VEHICLES[index].PRICE then
        local vehicles = char.get("vehicles")
        local owner_name = char.getFullName()
        local plate = generate_random_number_plate()
        local vehicle = {
            owner = owner_name,
            make = "",
            model = VEHICLES[index].MODEL,
            hash = VEHICLES[index].HASH,
            plate = plate,
            stored = false,
            price = VEHICLES[index].PRICE,
            inventory = exports["usa_vehinv"]:NewInventory(VEHICLES[index].CAPACITY),
            storage_capacity = VEHICLES[index].CAPACITY
        }
        -- add to database --
        AddVehicleToDB(vehicle, function(ok)
            if ok then
                -- remove money --
                char.removeMoney(VEHICLES[index].PRICE)
                -- give to player --
                table.insert(vehicles, vehicle.plate)
                char.set("vehicles", vehicles)
                -- put keys in car --
                local key = {
                    name = "Key -- " .. plate,
                    quantity = 1,
                    type = "key",
                    owner = owner_name,
                    make = "BMW",
                    model = VEHICLES[index].MODEL,
                    plate = plate
                }
                TriggerEvent("vehicle:storeItemInFirstFreeSlot", src, vehicle.plate, key, false, function(success, inv) end)
                VEHICLES[index].plate = plate
                TriggerClientEvent("bmwshop:spawn", src, VEHICLES[index])
                local chatSentence1 = "Purchased a " .. VEHICLES[index].MODEL .. " for $" .. exports.globals:comma_value(VEHICLES[index].PRICE)
                local chatSentence2 = "The keys are in the car!"
                TriggerClientEvent("usa:notify", src, chatSentence1, "^3INFO:^0 " .. chatSentence1)
                TriggerClientEvent("usa:notify", src, chatSentence2, "^3INFO:^0 " .. chatSentence2)
            else
                print("[usa_bmwshop] *** ERROR WHEN BUYING BMW!!!! **")
            end
        end)
    else 
        TriggerClientEvent("usa:notify", src, "Need: $" .. exports.globals:comma_value(VEHICLES[index].PRICE), "^3INFO:^0 Need: $" .. exports.globals:comma_value(VEHICLES[index].PRICE))
    end
end)

function generate_random_number_plate()
    local charset = {
      numbers = {},
      letters = {}
    }
    -- QWERTYUIOPASDFGHJKLZXCVBNM1234567890
    for i = 48,  57 do table.insert(charset.numbers, string.char(i)) end -- add numbers 1 - 9
    for i = 65,  90 do table.insert(charset.letters, string.char(i)) end -- add capital letters
    local number_plate = ""
    number_plate = number_plate .. charset.numbers[math.random(#charset.numbers)] -- number
    number_plate = number_plate .. charset.numbers[math.random(#charset.numbers)] -- number
    number_plate = number_plate .. charset.letters[math.random(#charset.letters)] -- letter
    number_plate = number_plate .. charset.letters[math.random(#charset.letters)] -- letter
    number_plate = number_plate .. charset.letters[math.random(#charset.letters)] -- letter
    number_plate = number_plate .. charset.numbers[math.random(#charset.numbers)] -- number
    number_plate = number_plate .. charset.numbers[math.random(#charset.numbers)] -- number
    number_plate = number_plate .. charset.numbers[math.random(#charset.numbers)] -- number
    return number_plate
end

-- Insert new vehicle into DB --
function AddVehicleToDB(vehicle, cb)
    TriggerEvent('es:exposeDBFunctions', function(couchdb)
        couchdb.createDocumentWithId("vehicles", vehicle, vehicle.plate, function(success)
        if success then
            cb(true)
            --print("* Vehicle created in DB!! *")
        else
            --print("* Error: vehicle was not created in DB!! *")
            cb(false)
        end
        end)
    end)
end