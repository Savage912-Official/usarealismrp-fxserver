local KEYS = {
    SHIFT = 21
}

local TOO_SMALL_WEAPONS = {
    [`WEAPON_UNARMED`] = true,
    [`WEAPON_KNIFE`] = true,
    [`WEAPON_SWITCHBLADE`] = true,
    [`WEAPON_DAGGER`] = true,
    [`WEAPON_MACHETE`] = true,
    [`WEAPON_SNSPISTOL`] = true,
    [`WEAPON_SNSPISTOL_MK2`] = true,
    [`WEAPON_STUNGUN`] = true,
    [`WEAPON_FLAREGUN`] = true,
    --[[
    [`WEAPON_PISTOL`] = true,
    [`weapon_pistol_mk2`] = true,
    [`weapon_combatpistol`] = true,
    [`weapon_appistol`] = true,
    [`weapon_stungun`] = true,
    [`weapon_pistol50`] = true,
    [`weapon_snspistol`] = true,
    [`weapon_snspistol_mk2`] = true,
    [`weapon_heavypistol`] = true,
    [`weapon_vintagepistol`] = true,
    [`weapon_flaregun`] = true,
    [`weapon_marksmanpistol`] = true,
    [`weapon_revolver`] = true,
    [`weapon_revolver_mk2`] = true,
    [`weapon_doubleaction`] = true,
    [`weapon_raypistol`] = true,
    [`weapon_ceramicpistol`] = true,
    [`weapon_navyrevolver`] = true,
    [`weapon_gadgetpistol`] = true,
    [`weapon_stungun_mp`] = true,
    [`weapon_pistolxm3`] = true,
    --]]
}

local COOLDOWN_SECONDS = 12
local KNOCKOUT_SECONDS = 7

local lastKnockoutAttemptTime = GetGameTimer()

function knockoutNearest()
    if IsControlPressed(0, KEYS.SHIFT) then
        -- look for nearest ped, confirm nearby
        local nearbyPlayerId, ped, coords = lib.getClosestPlayer(GetEntityCoords(PlayerPedId()), 1.0, false)
        if nearbyPlayerId and ped and coords then
            if GetGameTimer() - lastKnockoutAttemptTime >= COOLDOWN_SECONDS * 1000 then
                if IsPedArmed(PlayerPedId(), 1 | 4) then
                    if not TOO_SMALL_WEAPONS[GetSelectedPedWeapon(PlayerPedId())] then
                        -- ask server to knockout target for x seconds!
                        TriggerServerEvent("usa:knockout", GetPlayerServerId(nearbyPlayerId))
                        lastKnockoutAttemptTime = GetGameTimer()
                        lib.progressCircle({
                            duration = 1 * 1000,
                            label = 'Knocking out',
                            position = 'bottom',
                            useWhileDead = false,
                            canCancel = false,
                            disable = {
                                car = true,
                                move = true,
                                combat = true,
                            },
                            anim = {
                                dict = 'missheist_jewel@first_person',
                                clip = 'smash_case_e',
                                flag = 39,
                            },
                        })
                    else
                        exports.globals:notify("Weapon too small")
                    end
                else
                    exports.globals:notify("Need weapon")
                end
            else
                exports.globals:notify("On cooldown!")
            end
        end
    end
end

RegisterCommand("knockoutNearest", knockoutNearest)

RegisterKeyMapping('knockoutNearest', 'Knockout', 'keyboard', 'G')

RegisterNetEvent("usa:knockout")
AddEventHandler("usa:knockout", function()
    knocked_out = true
    -- play animation and temporarily prevent moving
    ClearPedTasksImmediately(PlayerPedId())
    if lib.progressCircle({
        duration = KNOCKOUT_SECONDS * 1000,
        label = 'Knocked out',
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = 'missarmenian2',
            clip = 'drunk_loop',
            flag = 39,
        },
    }) then
        -- reset
        knocked_out = false
    end
end)