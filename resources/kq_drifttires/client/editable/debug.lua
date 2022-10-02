if Config.debug then
    RegisterCommand("lower", function()
        Citizen.CreateThread(function()
            LowerVehicle()
        end)
    end)
    
    RegisterCommand("raise", function()
        Citizen.CreateThread(function()
            RaiseCar()
        end)
    end)
    
    RegisterCommand("settirepressure", function(source, args)
        local veh = GetVehiclePedIsIn(PlayerPedId())
        
        Entity(veh).state:set('tirePressure', tonumber(args[1]), 1)
    end)
    
    RegisterCommand("chands", function()
        DeleteEntity(wheelInHands)
        local closest = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey('prop_tornado_wheel'), false)
        if closest then
            SetEntityAsMissionEntity(closest, true, true)
            DeleteEntity(closest)
        end
    end)
    
    RegisterCommand("whands", function()
        PutWheelInHands(0, 0)
    end)
end


function Debug(message, ...)
    if Config.debug then
        print(message, ...)
    end
end


RegisterNetEvent('kq_drifttires:client:prepareRestart')
AddEventHandler('kq_drifttires:client:prepareRestart', function(source)
    local model = 'kq_wheel_balancer'
    
    local coords = GetEntityCoords(PlayerPedId())
    local closest = GetClosestObjectOfType(coords, 15000.0, GetHashKey(model), false)
    
    for k, obj in pairs(wheelBalancers) do
        DeleteEntity(obj)
    end
    
    while closest ~= 0 do
        SetEntityAsMissionEntity(closest, true, true)
        DeleteEntity(closest)
        closest = GetClosestObjectOfType(coords, 15000.0, GetHashKey(model), false)
        Citizen.Wait(1)
    end
    
    if source == GetPlayerServerId(PlayerId()) then
        Citizen.CreateThread(function()
            Citizen.Wait(500)
            ExecuteCommand('ensure ' .. GetCurrentResourceName())
        end)
    end
end)
