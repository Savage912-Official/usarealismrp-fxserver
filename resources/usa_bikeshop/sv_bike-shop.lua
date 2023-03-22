RegisterServerEvent("bikeShop:requestPurchase")
AddEventHandler("bikeShop:requestPurchase", function(index, location)
  local char = exports["usa-characters"]:GetCharacter(source)
  local bike = Config.Bikes[index]
  local vehicles = char.get("vehicles")
  if bike.price <= char.get("money") then -- see if user has enough money
    char.removeMoney(bike.price)
    local owner_name = char.getFullName()
    local plate = generate_random_number_plate()
    local vehicle = {
      owner = owner_name,
      make = bike.name,
      model = 'Bicycle',
      hash = bike.hash,
      plate = plate,
      stored = false,
      price = bike.price,
      inventory = {},
      storage_capacity = 5.0
    }
    table.insert(vehicles, vehicle.plate)
    char.set("vehicles", vehicles)
    -- add to database --
    AddVehicleToDB(vehicle)
    TriggerEvent("lock:addPlate", vehicle.plate)
    TriggerClientEvent("usa:notify", source, "You have purchased a ~y~" .. bike.name .. "~s~, you may store it in a garage.")
    TriggerClientEvent("bikeShop:spawnBike", source, bike, location, plate)
    TriggerClientEvent("bikeShop:toggleMenu", source, false)
  else
    TriggerClientEvent("usa:notify", source, "Not enough money!")
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
function AddVehicleToDB(vehicle)
  TriggerEvent('es:exposeDBFunctions', function(couchdb)
    couchdb.createDocumentWithId("vehicles", vehicle, vehicle.plate, function(success)
      if success then
        --print("* Vehicle created in DB!! *")
      else
        --print("* Error: vehicle was not created in DB!! *")
      end
    end)
  end)
end