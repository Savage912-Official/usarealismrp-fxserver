local DiffTrigger = 0.25
local MinSpeed    = 25.0 --THIS IS IN m/s -- todo: to make sure you still fly out at high speeds with no belt on, but not at speeds < 60 mph anymore
local speedBuffer  = {}
local velBuffer    = {}
local wasInCar     = false
beltOn = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        collectgarbage()
    end
end) -- Fix RAM leaks by collecting garbage


Citizen.CreateThread(function()
    local alarmtimes = 0
    while true do
        Citizen.Wait(3000)
        local ped = GetPlayerPed(-1)
        if DoesEntityExist(ped) and IsPedInAnyVehicle(ped, false) and IsBeltVehicle(GetVehiclePedIsIn(ped, false)) and not IsEntityDead(ped) and GetEntitySpeed(GetVehiclePedIsIn(ped, false))*2.236936 >= 15 and alarmtimes < 3 and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == GetPlayerPed(-1) and not beltOn then
            alarmtimes = alarmtimes + 1
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'seatbelt-alarm', 0.1)
            Citizen.Wait(1000)
        elseif (not IsPedInAnyVehicle(ped, false) or beltOn) then
            alarmtimes = 0
        end
    end
end)

IsCar = function(veh)
            local vc = GetVehicleClass(veh)
            local model = GetEntityModel(veh)
            return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 15 and vc <= 20) and model ~= GetHashKey("polbike3")
        end

Fwv = function (entity)
            local hr = GetEntityHeading(entity) + 90.0
            if hr < 0.0 then hr = 360.0 + hr end
            hr = hr * 0.0174533
            return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end

Citizen.CreateThread(function()
    Citizen.Wait(500)
    while true do

        local ped = PlayerPedId()
        local car = GetVehiclePedIsIn(ped)

        if car ~= 0 and (wasInCar or IsCar(car)) then

            wasInCar = true

            if beltOn then DisableControlAction(0, 75, true) end

            speedBuffer[2] = speedBuffer[1]
            speedBuffer[1] = GetEntitySpeed(car)

            if speedBuffer[2] ~= nil
               and GetEntitySpeedVector(car, true).y > 1.0
               and speedBuffer[1] > 5.0
               and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * DiffTrigger)
               and GetPedInVehicleSeat(car, 1) ~= GetPlayerPed(-1)
               and GetPedInVehicleSeat(car, 2) ~= GetPlayerPed(-1)
               and IsBeltVehicle(car) then
               local damagedEngine = GetVehicleEngineHealth(car)-speedBuffer[1]
               if not beltOn and speedBuffer[1] > MinSpeed then
                    ShakeStrength = GetEntitySpeed(car)/15

                    local co = GetEntityCoords(ped)
                    local fw = Fwv(ped)
                    SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
                    SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
                    Citizen.Wait(1)
                    SetEntityHealth(ped, (GetEntityHealth(ped)-50))
                    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeStrength)
                    SetPedToRagdoll(ped, 100000, 1000, 000, 0, 0, 0)
                end

            end

            velBuffer[2] = velBuffer[1]
            velBuffer[1] = GetEntityVelocity(car)

            if IsControlJustReleased(0, 311) and GetLastInputMethod(0) and (GetPedInVehicleSeat(car, -1) == ped or GetPedInVehicleSeat(car, 0) == ped) then
                beltOn = not beltOn
                TriggerServerEvent('hud:getBelt', beltOn)
                TriggerServerEvent('display:shareDisplay', 'clicks seatbelt', 2, 470, 10, 3000)
                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'seatbelt-click', 0.2)
            end

        elseif wasInCar then
            wasInCar = false
            beltOn = false
            speedBuffer[1], speedBuffer[2] = 0.0, 0.0
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        local roll = GetEntityRoll(vehicle)
        if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
            DisableControlAction(2,59,true) -- Disable left/right
            DisableControlAction(2,60,true) -- Disable up/down
        end
    end
end)

function IsBeltVehicle(vehicle)
    if GetVehicleClass(vehicle) ~= 8
    and GetVehicleClass(vehicle) ~= 13
    and GetVehicleClass(vehicle) ~= 14
    and GetVehicleClass(vehicle) ~= 16
    and GetVehicleClass(vehicle) ~= 19
    and GetVehicleClass(vehicle) ~= 21
     then
        return true
    else
        return false
    end
end 