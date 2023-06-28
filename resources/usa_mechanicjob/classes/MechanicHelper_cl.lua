MechanicHelper = {}
MechanicHelper.animations = {}
MechanicHelper.animations.repair = {}
MechanicHelper.animations.repair.dict = "mini@repair"
MechanicHelper.animations.repair.name = "fixing_a_player"

local LONG_SKILL_CHECK = {areaSize = 40, speedMultiplier = 0.4}

MechanicHelper.UPGRADE_FUNC_MAP = {
    ["topspeed1"] = function(veh, amountIncrease)
        ModifyVehicleTopSpeed(veh, 0.0) -- reset first to avoid doubling up issue
        ModifyVehicleTopSpeed(veh, amountIncrease)
    end,
    ["topspeed2"] = function(veh, amountIncrease)
        ModifyVehicleTopSpeed(veh, 0.0) -- reset first to avoid doubling up issue
        ModifyVehicleTopSpeed(veh, amountIncrease)
    end,
    ["topspeed3"] = function(veh, amountIncrease)
        ModifyVehicleTopSpeed(veh, 0.0) -- reset first to avoid doubling up issue
        ModifyVehicleTopSpeed(veh, amountIncrease)
    end,
    ["topspeed4"] = function(veh, amountIncrease)
        ModifyVehicleTopSpeed(veh, 0.0) -- reset first to avoid doubling up issue
        ModifyVehicleTopSpeed(veh, amountIncrease)
    end,
    ["low-grip-tires"] = function(veh)
        SetDriftTyresEnabled(veh, true)
    end,
    ["normal-tires"] = function(veh)
        SetDriftTyresEnabled(veh, false)
    end,
    ["underglow-kit"] = function(veh)
        SetVehicleNeonLightEnabled(veh, 0, true)
		SetVehicleNeonLightEnabled(veh, 1, true)
		SetVehicleNeonLightEnabled(veh, 2, true)
		SetVehicleNeonLightEnabled(veh, 3, true)
        -- get saved underglow state (saved by storing at garage after using RGB controller to apply desired color)
        local rgb = TriggerServerCallback {
            eventName = "mechanic:getUnderglow",
            args = {GetVehicleNumberPlateText(veh)}
        }
        if rgb then
            SetVehicleNeonLightsColour(veh, rgb.r,  rgb.g, rgb.b)
        end
    end,
    ["xenon-headlights"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        ToggleVehicleMod(veh, 22, true)
    end,
    ["stage-1-brakes"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        SetVehicleMod(veh, 12, 1, false)
    end,
    ["stage-2-brakes"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        SetVehicleMod(veh, 12, 2, false)
    end,
    ["tint-remover"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        SetVehicleWindowTint(veh, 0)
    end,
    ["5-percent-tint"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        SetVehicleWindowTint(veh, 1)
    end,
    ["20-percent-tint"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        SetVehicleWindowTint(veh, 2)
    end,
    ["35-percent-tint"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        SetVehicleWindowTint(veh, 3)
    end,
    ["stage-1-transmission"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        SetVehicleMod(veh, 13, 1)
    end,
    ["stage-2-transmission"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        SetVehicleMod(veh, 13, 2)
    end,
    ["turbo"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        ToggleVehicleMod(veh, 18, true)
    end,
    ["20-percent-armor"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        SetVehicleMod(veh, 16, 0)
    end,
    ["stage-1-intake"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        SetVehicleMod(veh, 11, 1)
    end,
    ["stage-2-intake"] = function(veh)
        if GetVehicleModKit(veh) ~= 0 then
            SetVehicleModKit(veh, 0)
        end
        SetVehicleMod(veh, 11, 2)
    end,
}

MechanicHelper.getClosestVehicle = function(maxRange)
    local me = PlayerPedId()
    local mycoords = GetEntityCoords(me)
    local closest = {}
    closest.dist = 999999999
    closest.veh = nil
    for veh in exports.globals:EnumerateVehicles() do
        local vehCoords = GetEntityCoords(veh)
        local dist = Vdist(mycoords.x, mycoords.y, mycoords.z, vehCoords.x, vehCoords.y, vehCoords.z)
        if dist < closest.dist and dist < (maxRange or 500) then
            closest.dist = dist
            closest.veh = veh
        end
    end
    return closest.veh
end

MechanicHelper.useMechanicTools = function(veh, repairCount, cb)
    local beforeRepairHealth = GetVehicleEngineHealth(veh)
    local success = false

    if beforeRepairHealth < 800 then
        if not IsPedInVehicle(PlayerPedId(), veh, false) then
            SetVehicleDoorOpen(veh, 4, false, false)
            TriggerEvent("dpemotes:command", 'e', GetPlayerServerId(ped), {"mechanic"})
            
            local todoSkillChecks = {}
            local numLongSkillChecks = nil
            local easyMedium = {areaSize = 50, speedMultiplier = 1.25}
            
            if repairCount >= Config.LEVEL_3_RANK_THRESH then
                todoSkillChecks = {'easy', easyMedium, 'easy', 'easy', 'easy', 'easy'}
                numLongSkillChecks = 6
            elseif repairCount >= Config.LEVEL_2_RANK_THRESH then
                todoSkillChecks = {'easy', easyMedium, 'easy', 'easy'}
                numLongSkillChecks = 10
            else
                todoSkillChecks = {'easy', easyMedium, 'easy', easyMedium, easyMedium}
                numLongSkillChecks = 14
            end
            for i = 1, numLongSkillChecks do
                table.insert(todoSkillChecks, 1, LONG_SKILL_CHECK)
            end
            
            local passed = lib.skillCheck(todoSkillChecks)

            if passed then
                if not IsVehicleDriveable(veh, true) then -- damaged and red
                    SetVehicleUndriveable(veh, false)
                    SetVehicleEngineHealth(veh, 500.0)
                else -- Damaged but not red, so prob orange
                    SetVehicleEngineHealth(veh, 800.0)
                end

                FixAllTires(veh)
                TriggerEvent("kq_wheeldamage:fixCar", veh)
                success = true
                cb(true)
            else 
                cb(false)
            end
            Wait(500)
            TriggerEvent("dpemotes:command", 'e', GetPlayerServerId(ped), {"c"})
            SetVehicleDoorShut(veh, 4, false)
        else
            TriggerEvent("usa:notify", "Must be outside vehicle!")
        end
    end
end

MechanicHelper.useRepairKit = function(veh, repairCount, cb)
    local beforeRepairHealth = GetVehicleEngineHealth(veh)
    local success = false
    if beforeRepairHealth < 800 then
        if not IsPedInVehicle(PlayerPedId(), veh, false) then
            SetVehicleDoorOpen(veh, 4, false, false)
            TriggerEvent("dpemotes:command", 'e', GetPlayerServerId(ped), {"mechanic"})
            local todoSkillChecks = {}
            local numLongSkillChecks = nil
            local easyMedium = {areaSize = 50, speedMultiplier = 1.25}
            
            if repairCount >= Config.LEVEL_3_RANK_THRESH then
                todoSkillChecks = {'easy', easyMedium, 'easy', 'easy', 'easy', 'easy'}
                numLongSkillChecks = 6
            elseif repairCount >= Config.LEVEL_2_RANK_THRESH then
                todoSkillChecks = {'easy', easyMedium, 'easy', 'easy'}
                numLongSkillChecks = 10
            else
                todoSkillChecks = {'easy', easyMedium, 'easy', easyMedium, easyMedium}
                numLongSkillChecks = 14
            end

            for i = 1, numLongSkillChecks do
                table.insert(todoSkillChecks, 1, LONG_SKILL_CHECK)
            end
            
            local passed = lib.skillCheck(todoSkillChecks)
            if passed then
                SetVehicleDoorShut(veh, 4, false)
                if not IsVehicleDriveable(veh, true) then
                    SetVehicleUndriveable(veh, false)
                    SetVehicleEngineHealth(veh, 650.0)
                else
                    SetVehicleEngineHealth(veh, 850.0)
                end
                
                FixAllTires(veh)
                TriggerEvent("kq_wheeldamage:fixCar", veh)
                success = true
                cb(true)
            else
                cb(false)
            end
	    if math.random() > 0.50 then
                TriggerServerEvent("usa:removeItem", "Repair Kit", 1)
                TriggerEvent("usa:notify", "Repair Kit has worn out!")
            end
            Wait(500)
            TriggerEvent("dpemotes:command", 'e', GetPlayerServerId(ped), {"c"})
            SetVehicleDoorShut(veh, 4, false)
        else
            TriggerEvent("usa:notify", "Must be outside vehicle!")
        end
    end
end

MechanicHelper.installUpgrade = function(veh, upgrade, cb)
    TriggerEvent("interaction:setBusy", true)
    SetVehicleDoorOpen(veh, 4, false, false)

    if lib.progressBar({
        duration = Config.UPGRADE_INSTALL_TIME,
        label = 'Installing Part...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = MechanicHelper.animations.repair.dict,
            clip = MechanicHelper.animations.repair.name,
            flag = 39,
        },
    }) then
        if MechanicHelper.UPGRADE_FUNC_MAP[upgrade.id] then
            MechanicHelper.UPGRADE_FUNC_MAP[upgrade.id](veh, upgrade.increaseAmount) -- call appropriate native
        end
        Wait(500)
        SetVehicleDoorShut(veh, 4, false)
        cb(true)
        TriggerEvent("interaction:setBusy", false)
    else
        cb(false)
        TriggerEvent("interaction:setBusy", false)
    end

end

MechanicHelper.installUpgradeNoAnim = function(veh, upgrade)
    MechanicHelper.UPGRADE_FUNC_MAP[upgrade.id](veh, upgrade.increaseAmount) -- call appropriate native
end

function FixAllTires(veh)
    SetVehicleTyreFixed(veh, 0)
    SetVehicleTyreFixed(veh, 1)
    SetVehicleTyreFixed(veh, 2)
    SetVehicleTyreFixed(veh, 3)
    SetVehicleTyreFixed(veh, 4)
end

--[[
local veh = GetVehiclePedIsIn(PlayerPedId(), true)
ModifyVehicleTopSpeed(veh, 20.0)
--]]
