
-- Gets triggered when a wheel gets put in players hands
function OnPutWheelInHands(wheelObject, wheelType)

end

-- Gets triggered when the wheel gets removed from players hands
function OnRemoveWheelFromHands()

end

-- Gets triggered when a vehicle gets lowered (this does not necessarily mean that the tires have changed)
function OnSetVehicleHasDriftTires(vehicle, bool)

end

-- Gets triggered when a vehicle gets raised
function OnVehicleRaised(vehicle)

end

-- Gets triggered when a vehicle gets lowered
function OnVehicleLowered(vehicle)

end

-- Gets triggered when a player uses (puts a wheel inside) a balancer
function OnUseBalancer(balancer)

end

-- Gets triggered when a player takes a wheel off the balancer
function OnTakeWheelOffBalancer()

end

-- Gets triggered when a wheel is taken off a vehicle
function OnWheelTakenOff(vehicle, wheel, type)

end

-- Gets triggered when a wheel gets put on a vehicle
function OnWheelPutOn(vehicle, wheel, type)

end


--------------------------------------------------------------------------
--- SERVER EVENTS YOU CAN CALL
--------------------------------------------------------------------------

--- kq_drifttires:server:setHasDriftTires (netId, value)
-- netId = NetworkId of the vehicle
-- value = Boolean whether or not the car has drift tires
-- This event allows you to change tire types on any vehicle (automatically saves the data to the db)

--- kq_drifttires:server:setPressure (netId, pressure)
-- netId = NetworkId of the vehicle
-- pressure = new tire pressure you want to apply/save to the vehicle
-- This event allows you to change tire pressure on any vehicle (with drift tires!) (automatically saves the data to the db)

--- kq_drifttires:server:requestVehicleLoad (netId)
-- netId = NetworkId of the vehicle
-- This event requests the server to load vehicle data from the database and apply it to the vehicle

