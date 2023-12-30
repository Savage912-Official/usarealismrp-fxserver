-- uhh
Citizen.CreateThread(function()
    for k,v in ipairs(Config.Zones) do
        local rblip = AddBlipForRadius(v.coords, v.radius)
        local blip = AddBlipForCoord(v.coords)
        SetBlipColour(rblip, 1)
        SetBlipAlpha(rblip, 80)
        SetBlipSprite(blip, 16)
        SetBlipScale(blip, 1.0)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(Config.BlipText)
		EndTextCommandSetBlipName(blip)

    end
end)

Citizen.CreateThread(function()
    while true do
        local me = PlayerPedId()
        local mycoords = GetEntityCoords(me)
        local curVeh = GetVehiclePedIsIn(me)
        if curVeh and GetVehicleEngineHealth(curVeh) > 0 then
            for i = 1, #Config.Zones do
                local zoneCoords = Config.Zones[i].coords
                if #(mycoords - zoneCoords) <= Config.Zones[i].radius then
                    if not IsAllowed(Config.Zones[i].allowedJobs) then
                        if IsPedInAnyHeli(me) and isInDriverSeat(me) then -- issue first warning after initially entering airspace
                            TriggerEvent("chatMessage", "US Air Force", { 240, 0, 0 }, "RESTRICTED AREA - LEAVE NOW OR BE TAKEN DOWN")
                            exports.globals:sleep(1000)
                            TriggerEvent("chatMessage", "US Air Force", { 240, 0, 0 }, "RESTRICTED AREA - LEAVE NOW OR BE TAKEN DOWN")
                            exports.globals:sleep(Config.timeToLeaveBeforeShootingSeconds * 1000)
                            mycoords = GetEntityCoords(me)
                            if #(mycoords - zoneCoords) <= Config.Zones[i].radius then -- still in the airspace after timeToLeaveBeforeShootingSeconds? full send!
                                TriggerServerEvent('911:USAF', zoneCoords.x, zoneCoords.y, zoneCoords.z)
                                TriggerServerEvent("jail:startalarmSV", -1)
                                local copsOnDuty = TriggerServerCallback {
                                    eventName = "antiaircraft:numCopsOn",
                                    args = {}
                                }
                                if copsOnDuty >= Config.CopsNeeded then
                                    if math.random() < Config.chanceToHit then
                                        DestroyVehicle()
                                        TriggerServerEvent('911:call', zoneCoords.x, zoneCoords.y, zoneCoords.z, "US Air Force reports target destroyed. Anti-Air entering cooldown.")
                                    else
                                        TriggerServerEvent('911:call', zoneCoords.x, zoneCoords.y, zoneCoords.z, "US Air Force reports missle missed the target. Aircraft has been warned and lethal is authorized.")
                                    end
                                else -- If no cops on duty 100%
                                    DestroyVehicle()
                                    TriggerServerEvent('911:call', zoneCoords.x, zoneCoords.y, zoneCoords.z, "US Air Force reports target destroyed.")
                                end
                                exports.globals:sleep(Config.cooldownTimeSeconds * 1000)
                            end
                        end
                    end
                end
            end
        end
        Wait(1)
    end
end)

function DestroyVehicle(...)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if GetVehicleEngineHealth(veh) > 0 then
        if not HasWeaponAssetLoaded(GetHashKey("WEAPON_RPG")) then
            RequestWeaponAsset(GetHashKey("WEAPON_RPG"), 31, 0)
            while not HasWeaponAssetLoaded(GetHashKey("WEAPON_RPG")) do
                Wait(0)
            end
        end
        local pCoords = GetEntityCoords(veh)
        local f_coords, h_coords = CalHitCoords(pCoords, veh)

        ShootSingleBulletBetweenCoords(f_coords, h_coords, 5000, true, GetHashKey("WEAPON_RPG"), PlayerPedId(), true, false, 2000.0)
        Citizen.Wait(500)

        AddExplosion(h_coords, 10, 1.0, true, false, 1.0)
    end
end

function CalHitCoords(c, v)
    local speed = GetEntitySpeed(v)

    local forward = GetEntityForwardVector(v)

    local fireCoords = c + forward * (100.0) + vector3(0.0, 0.0, 30.0)

    

    while GetEntitySpeed(v) > 10.0 do
        Debug("Wait Fire")
        Citizen.Wait(50)
    end

    local hit = GetEntityCoords(v)
    
    return fireCoords, hit

end

function IsAllowed(...)
    local args = {...}
    local currentJob = TriggerServerCallback {
        eventName = "antiaircraft:checkJob",
        args = {}
    }
    if #args[1] > 0 then
        for k,v in ipairs(args[1]) do
            if v == currentJob then
                return true
            end
        end
    else
        return true
    end
    return false

end

--DEBUG--
function Debug(...)
    local args = {...}
    if Config.DebugMode then
        print(args[1])
    end
end

function isInDriverSeat(ped)
    return GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped
end