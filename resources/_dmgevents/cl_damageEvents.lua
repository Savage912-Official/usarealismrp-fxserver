local littleTrickToSkipGettingScrambledByParser = "gameEventTriggered"
local BEANBAG_HASH = GetHashKey("WEAPON_BEANBAGSHOTGUN")
local TASER_HASH = GetHashKey("WEAPON_STUNGUN")
local before_shotgun
local before_taser

function countdown_and_stop(time_ms)
    Citizen.CreateThread(function()
        before_shotgun = GetGameTimer()
        while GetGameTimer() - before_shotgun < time_ms do
            Wait(100)
        end
        AnimpostfxStopAll()
        StopGameplayCamShaking(true)
    end)
end

AddEventHandler(littleTrickToSkipGettingScrambledByParser, function(event, data)
    if event == "CEventNetworkEntityDamage" then
        victim = data[1]
        attacker = data[2]
        victimDied = data[6]
        weaponHash = data[7]
        isMeleeDamage = data[12]
        vehicleDamageTypeFlag = data[13]

        if IsEntityAPed(victim) and IsPedAPlayer(victim) and PlayerPedId() == victim then
            if weaponHash == BEANBAG_HASH then
                SetPedToRagdoll(PlayerPedId(), 2500, 2500, 0, 0, 0, 0)
                ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
                AnimpostfxPlay("DefaultFlash", 15000, false)
                AnimpostfxPlay("BeastTransition", 15000, false)
                AnimpostfxPlay("CrossLine", 15000, false)
                countdown_and_stop(15000)
            elseif weaponHash == TASER_HASH then
                ShakeGameplayCam("DRUNK_SHAKE", 1.0)
                AnimpostfxPlay("DefaultFlash", 15000, false)
                AnimpostfxPlay("Dont_tazeme_bro", 15000, false)
                countdown_and_stop(15000)
            end
        end
        if victim and attacker then
            if victimDied then
                if IsEntityAVehicle(victim) then 
                    TriggerEvent("DamageEvents:VehicleDestroyed", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                else
                    if IsEntityAPed(victim) then
                        if IsEntityAVehicle(attacker, true) then 
                            TriggerEvent("DamageEvents:PedKilledByVehicle", victim, attacker)
                        elseif IsEntityAPed(attacker) then 
                            if IsPedAPlayer(attacker) then 
                                player = NetworkGetPlayerIndexFromPed(attacker)
                                TriggerEvent("DamageEvents:PedKilledByPlayer", victim, player, weaponHash, isMeleeDamage)
                            else 
                                TriggerEvent("DamageEvents:PedKilledByPed", victim, attacker, weaponHash, isMeleeDamage)
                            end
                        else 
                            TriggerEvent("DamageEvents:PedDied", victim, attacker, weaponHash, isMeleeDamage)
                        end
                    else 
                        TriggerEvent("DamageEvents:EntityKilled", victim, attacker, weaponHash, isMeleeDamage)
                    end
                end
            else 
                if not IsEntityAVehicle(victim) then
                    TriggerEvent("DamageEvents:EntityDamaged", victim, attacker, weaponHash, isMeleeDamage)
                else 
                    TriggerEvent("DamageEvents:VehicleDamaged", victim, attacker, weaponHash, isMeleeDamage, vehicleDamageTypeFlag)
                end
            end
        end
    end
end)
