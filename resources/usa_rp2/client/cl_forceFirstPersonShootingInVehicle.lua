local BLACKLISTED_VEHICLES = {
    [`impala`] = true,
    [`16charger`] = true,
    [`16challenger`] = true,
    [`tahoe08`] = true,
    [`srt8`] = true,
    [`pontiacg8`] = true,
    [`models`] = true,
    [`hellephantdurango`] = true,
    [`benze55`] = true,
    [`chr20`] = true,
    [`ctsv16`] = true
}

local LEFT_CLICK = 24

local modeBeforeChange = nil

function forceFirstPerson(ped)
    if modeBeforeChange == nil then
        modeBeforeChange = GetFollowVehicleCamViewMode()
        SetFollowVehicleCamViewMode(4)
        for i = 2, 7 do
            SetCamViewModeForContext(i, 4)
        end
    end
end

function undoFirstPerson(ped)
    SetFollowVehicleCamViewMode(modeBeforeChange)
    for i = 2, 7 do
        SetCamViewModeForContext(i, modeBeforeChange)
    end
    modeBeforeChange = nil
end

Citizen.CreateThread(function()
    local WEAPON_UNARMED_HASH = `WEAPON_UNARMED`
    while true do
        local me = PlayerPedId()
        if IsPedInAnyVehicle(me) then
            local veh = GetVehiclePedIsIn(me)
            if me == GetPedInVehicleSeat(veh, -1) or not BLACKLISTED_VEHICLES[GetEntityModel(veh)] then
                local selectedPedWeapon = GetSelectedPedWeapon(me)
                if IsPedDoingDriveby(me) then
                    forceFirstPerson(me)
                elseif IsControlPressed(0, LEFT_CLICK) then
                    if me ~= GetPedInVehicleSeat(veh, -1) then -- not in driver seat
                        forceFirstPerson(me)
                    end
                elseif modeBeforeChange ~= nil then
                    undoFirstPerson(me)
                end
            end
        end
        Wait(1)
    end
end)
