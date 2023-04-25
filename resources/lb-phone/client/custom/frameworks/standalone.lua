local scriptStartTime = GetGameTimer()

CreateThread(function()
    if Config.Framework ~= "standalone" then
        return
    end

    local PlayerJob = nil

    while not NetworkIsSessionStarted() do
        Wait(500)
    end

    loaded = true

    RegisterNetEvent("character:loaded", function()
        LogOut()
        FetchPhone()
    end)

    RegisterNetEvent("character:jobUpdate", function(jobInfo)
        PlayerJob = jobInfo
    end)

    local lastPhoneNotif = 0

    function HasPhoneItem(number)
        if not Config.Item.Require then
            return true
        end

        if Config.Item.Unique then
            return HasPhoneNumber(number)
        end

        local hasPhone = lib.callback.await('lb-phone:hasPhone', false, number)
        
        if not hasPhone then
            if GetGameTimer() - lastPhoneNotif > 5000 and GetGameTimer() - scriptStartTime > 30000 then
                TriggerEvent("usa:notify", "You do not have a phone!", "You do not have a phone! Head to a general store to purchase a phone!")
                lastPhoneNotif = GetGameTimer()
            end
        end

        return hasPhone
    end

    function HasJob(jobs)
        for i = 1, #jobs do
            if jobs[i] == PlayerJob then
                return true
            end
        end
        return false
    end

    function isUnderglowOn(veh)
        local indexes = {0, 1, 2, 3}
        for i = 1, #indexes do
            if IsVehicleNeonLightEnabled(veh, indexes[i]) then
                return true
            end
        end
        return false
    end

    function CreateFrameworkVehicle(vehicleData, location)
        local playerVehicle = vehicleData
        local modelHash = vehicleData.hash
        local plateText = vehicleData.plate
        local numberHash = modelHash

        local vehicle_key = {
            name = "Key -- " .. vehicleData.plate,
            quantity = 1,
            type = "key",
            owner = vehicleData.owner,
            make = vehicleData.make,
            model = vehicleData.model,
            plate = vehicleData.plate
        }

        -- give key to owner
        TriggerServerEvent("garage:giveKey", vehicle_key)

        if type(numberHash) ~= "number" then
            numberHash = GetHashKey(numberHash)
        end

        RequestModel(numberHash)

        while not HasModelLoaded(numberHash) do
            Wait(500)
        end

        local vehicle = CreateVehicle(numberHash, location.x, location.y, location.z, 0.0, true, false)
        SetVehicleNumberPlateText(vehicle, plateText)
        SetVehicleOnGroundProperly(vehicle)
        SetVehRadioStation(vehicle, "OFF")
        SetVehicleEngineOn(vehicle, true, false, false)
        SetEntityAsMissionEntity(vehicle, true, true)
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetVehicleExplodesOnHighExplosionDamage(vehicle, false)

        -- Vehicle Wheel Fitment
        exports['ae-fitment']:GetWheelFitment(vehicle, playerVehicle.plate)

        -- car customizations
        if playerVehicle.customizations then
            local veh = playerVehicle.customizations
            local currentvehicle = vehicle

            local customizations = veh.mods
            local extracolor = veh.extracolor
            local color = veh.color
            local smokecolor = veh.smokecolor
            local plateindex = veh.plateindex
            local windowtint = veh.windowtint
            local wheeltype = veh.wheeltype
            local bulletProofTyres = veh.bulletProofTyres
            SetVehicleColours(currentvehicle, veh.color[1], veh.color[2])
            SetVehicleExtraColours(currentvehicle, veh.extracolor[1], veh.extracolor[2])
            SetVehicleTyreSmokeColor(currentvehicle,veh.smokecolor[1],veh.smokecolor[2],veh.smokecolor[3])
            SetVehicleNumberPlateTextIndex(currentvehicle,veh.plateindex)
            SetVehicleWheelType(currentvehicle, veh.wheeltype)
            SetVehicleTyresCanBurst(currentvehicle, not not veh.bulletProofTyres)

            -- set mods --
            SetVehicleModKit(currentvehicle,0)
            for x = 0, 48 do
                if x == 18 or x == 20 then -- turbo, tyre smoke
                    print("toggling vehicle mod!")
                    if customizations[x] then
                        ToggleVehicleMod(currentvehicle, x, customizations[x].mod)
                    else
                        ToggleVehicleMod(currentvehicle, x, customizations[tostring(x)].mod)
                    end
                elseif x == 23 then -- custom tires
                    if customizations[x] then
                        print("customizations[x].mod: " .. customizations[x].mod)
                        print("variation: " .. tostring(customizations[x].variation))
                        SetVehicleMod(currentvehicle, x, customizations[x].mod, customizations[x].variation)
                    else
                        print("customizations[tostring(x)].mod: " .. customizations[tostring(x)].mod)
                        print("variation: " .. tostring(customizations[tostring(x)].variation))
                        SetVehicleMod(currentvehicle, x, customizations[tostring(x)].mod, customizations[tostring(x)].variation)
                    end
                elseif x == 24 and IsThisModelABike(GetEntityModel(currentvehicle)) then
                    if customizations[x] then
                        print("customizations[x].mod: " .. customizations[x].mod)
                        print("variation: " .. tostring(customizations[x].variation))
                        SetVehicleMod(currentvehicle, x, customizations[x].mod, customizations[x].variation)
                    else
                        print("customizations[tostring(x)].mod: " .. customizations[tostring(x)].mod)
                        print("variation: " .. tostring(customizations[tostring(x)].variation))
                        SetVehicleMod(currentvehicle, x, customizations[tostring(x)].mod, customizations[tostring(x)].variation)
                    end
                else
                    if customizations[x] then
                        SetVehicleMod(currentvehicle, x, customizations[x].mod)
                    else
                        SetVehicleMod(currentvehicle, x, customizations[tostring(x)].mod)
                    end
                end
            end

            SetVehicleLivery(GetVehiclePedIsIn(PlayerPedId(), false), (veh.liveryIndex or 1))

            if veh.extras then
                for i = 1, 15 do
                    if veh.extras[i] then
                        SetVehicleExtra(currentvehicle, i, false)
                    else
                        SetVehicleExtra(currentvehicle, i, true)
                    end
                end
            end
        end

        -- veh fuel level
        if playerVehicle.stats then
            if playerVehicle.stats.fuel then
                TriggerServerEvent("fuel:setFuelAmount", playerVehicle.plate, playerVehicle.stats.fuel)
            end
        end

        -- any mechanic-installed upgrades
        if playerVehicle.upgrades then
            exports["usa_mechanicjob"]:ApplyUpgrades(vehicle, playerVehicle.upgrades)
        end

        -- record underglow if applicable (for optimization purposes)
        if isUnderglowOn(vehicle) then
            local currentR, currentG, currentB = GetVehicleNeonLightsColour(vehicle)
            lastUnderglowColorForVeh[plateText] = {
                r = currentR,
                g = currentG,
                b = currentB
            }
        end

        return vehicle
    end

     -- Company app (Not needed since we arent using these aspects)
    function GetCompanyData(cb)
        cb {}
    end

    function DepositMoney(amount, cb)
        cb(false)
    end

    function WithdrawMoney(amount, cb)
        cb(false)
    end

    function HireEmployee(source, cb)
        cb(false)
    end

    function FireEmployee(identifier, cb)
        cb(false)
    end

    function SetGrade(identifier, newGrade, cb)
        cb(false)
    end

    function ToggleDuty()
        return false    
    end

    RegisterNetEvent("lb-phone:reloadPhoneStandalone", function()
        RefreshPhone()
    end)
end)