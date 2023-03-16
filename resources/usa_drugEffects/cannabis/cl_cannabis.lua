--# Cannabis use effects: slight increase in HP + Armor, visual effect for x minutes
--# Required items: lighter, bong/joint or blunt paper, packaged weed
--# Perform animation when smoking, then apply effects
--# by: minipunch
--# OG for: USA REALISM RP (https://usarrp.net)

RegisterNetEvent("drugs:use")
RegisterNetEvent("drugs:cancel")

local wasCanceled = false
local isBusy = false

local anim = {
    rolling = {
        dict = "amb@world_human_partying@female@partying_cellphone@idle_a",
        name = "idle_a"
    },
    smoking = {
        dict = "amb@world_human_smoking_pot@male@idle_a",
        name = "idle_c",
        object = "p_cs_joint_02"
    }
}

--# increase player HP + armor slightly
--# apply visual effects for x minutes
AddEventHandler("drugs:use", function(name)
    local me = PlayerPedId()
    if name == Config.cannabis.itemName then
        if isBusy then 
            exports.globals:notify("You are already rolling!")
            return
        end
        isBusy = true
        -- # playing emote / rolling joint
        local startTime = GetGameTimer()
        while GetGameTimer() - startTime < (Config.cannabis.jointRollTimeSeconds) * 1000 and not wasCanceled do 
            exports.globals:DrawTimerBar(startTime, Config.cannabis.jointRollTimeSeconds * 1000, 1.42, 1.475, 'Rolling Joint')
            if not IsEntityPlayingAnim(me, anim.rolling.dict, anim.rolling.name, 3) then
                TriggerEvent("usa:playAnimation", anim.rolling.dict, anim.rolling.name, -8, 1, -1, 16, 0, 0, 0, 0)
                Wait(10)
            end
            Wait(0)
        end

        if wasCanceled then
            wasCanceled = false
            isBusy = false
            return
        end

        StopAnimTask(me, anim.rolling.dict, anim.rolling.name, 1.0)

        exports.globals:notify("You rolled a joint!")
        TriggerServerEvent("drugs:rolledCannabis")

        isBusy = false
    elseif name == Config.joint.itemName then
        if isBusy then 
            exports.globals:notify("You are already smoking!")
            return
        end
        isBusy = true
        local jointObj = GivePedObject(60309, anim.smoking.object, 0.00, 0.0, 0.0, -270.0, 0.0, -0.06)
        local startTime = GetGameTimer()
        while GetGameTimer() - startTime < Config.joint.smokeTimeSeconds * 1000 and not wasCanceled do 
            exports.globals:DrawTimerBar(startTime, Config.joint.smokeTimeSeconds * 1000, 1.42, 1.475, 'Consuming')
            if not IsEntityPlayingAnim(me, anim.smoking.dict, anim.smoking.name, 3) then
                TriggerEvent("usa:playAnimation", anim.smoking.dict, anim.smoking.name, -8, 1, -1, 48, 0, 0, 0, 0)
                Wait(10)
            end
            Wait(0)
        end
        StopAnimTask(me, anim.smoking.dict, anim.smoking.name, 1.0)
        if wasCanceled then
            wasCanceled = false
            isBusy = false
            return
        end
        DeleteObject(jointObj)
        isBusy = false
        ApplyEffects(me)
    end
end)

AddEventHandler("drugs:cancel", function()
    wasCanceled = true
end)

function ApplyEffects(me)
    ApplyHPandArmorBuff(me)
    ApplyVisualEffect(me)
end

function ApplyHPandArmorBuff(me)
    local JOINT_ARMOR_BUFF_CAP_PERCENT = 0.85
    local maxHealth = GetEntityMaxHealth(me)
    SetEntityHealth(me, GetEntityHealth(me) + math.random(math.floor(0.10*maxHealth), math.floor(0.15*maxHealth)))
    local maxArmor = GetPlayerMaxArmour(PlayerId())
    local currentArmor = GetPedArmour(me)
    local newArmor = currentArmor + math.random(math.floor(0.15*maxArmor), math.floor(0.25*maxArmor))
    if currentArmor > JOINT_ARMOR_BUFF_CAP_PERCENT * maxArmor then
        return
    end
    if newArmor > JOINT_ARMOR_BUFF_CAP_PERCENT * maxArmor then
        newArmor = math.floor(JOINT_ARMOR_BUFF_CAP_PERCENT * maxArmor)
    end
    if newArmor > currentArmor then
        SetPedArmour(me, newArmor)
    end
end

function ApplyVisualEffect(me)
    DoScreenFadeOut(1000)
    DoScreenFadeIn(1000)
    local visualEffectStr = "HeistCelebPass"
    StartScreenEffect(visualEffectStr, 1000, true)
    SetPedMotionBlur(me, true)

    startTime = GetGameTimer()
    while GetGameTimer() - startTime < Config.joint.effectTimeMinutes * 60 * 1000 do 
        Wait(1)
    end

    SetPedMotionBlur(me, false)
    StopScreenEffect(visualEffectStr)
end

function GivePedObject(target_bone, object, x, y, z, rotX, rotY, rotZ)
	object = GetHashKey(object)
	local ped = GetPlayerPed(-1)
	local coords = GetEntityCoords(ped)
    local bone = GetPedBoneIndex(ped, target_bone)
  	RequestModel(object)
  	while not HasModelLoaded(object) do
  		Citizen.Wait(100)
  	end
  	spawned_object = CreateObject(object, coords.x, coords.y, coords.z, 1, 1, 1)
	if rotX and rotY and rotZ and x and y and z then
  		AttachEntityToEntity(spawned_object, ped, bone, x, y, z, rotX, rotY, rotZ, 1, 1, 0, 0, 2, 1)
	else
		AttachEntityToEntity(spawned_object, ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
    end
    return spawned_object
end