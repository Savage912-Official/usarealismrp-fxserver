local target = Config.system.target
local menu = Config.system.menu
local close = Config.system.close
local thermiteUI = Config.system.MgameUI -- Don't change
local looted1 = false
local looted2 = false

ArtHeist = {
    ['start'] = false,
    ['cuting'] = false,
    ['startPeds'] = {},
    ['sellPeds'] = {},
    ['cut'] = 0,
    ['objects'] = {},
    ['scenes'] = {},
    ['painting'] = {}
}

CreateThread(function()
    for k, v in pairs(Config['ArtHeist']['startHeist']['peds']) do
        loadModel(v['ped'])
        ArtHeist['startPeds'][k] = CreatePed(4, GetHashKey(v['ped']), v['pos']['x'], v['pos']['y'], v['pos']['z'] - 0.95, v['heading'], false, true)
        FreezeEntityPosition(ArtHeist['startPeds'][k], true)
        SetEntityInvincible(ArtHeist['startPeds'][k], true)
        SetBlockingOfNonTemporaryEvents(ArtHeist['startPeds'][k], true)
    end
    for k, v in pairs(Config['ArtHeist']['sellPainting']['peds']) do
        loadModel(v['ped'])
        ArtHeist['sellPeds'][k] = CreatePed(4, GetHashKey(v['ped']), v['pos']['x'], v['pos']['y'], v['pos']['z'] - 0.95, v['heading'], false, true)
        FreezeEntityPosition(ArtHeist['sellPeds'][k], true)
        SetEntityInvincible(ArtHeist['sellPeds'][k], true)
        SetBlockingOfNonTemporaryEvents(ArtHeist['sellPeds'][k], true)
    end
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local sleep = 1000
        local heistDist = #(pedCo - Config['ArtHeist']['startHeist']['pos'])
        local sellDist = #(pedCo - Config['ArtHeist']['sellPainting']['pos'])
        if heistDist <= 3.0 then
            sleep = 1
            --DrawTxt(0.932, 1.35, 1.0, 1.0, 0.50, Strings['start_heist'], 255, 255, 255, 255)
            exports.globals:notify(Strings['start_heist'])
            if IsControlJustPressed(0, 38) then
                TriggerEvent("vt-artheist:starttheheist")
            end
        end
        if ArtHeist['start'] then
            for k, v in pairs(Config['ArtHeist']['painting']) do
                local dist = #(pedCo - v['scenePos'])
                if dist <= 1.0 then
                    sleep = 1
                    if not v['taken'] then
                        --DrawTxt(0.932, 1.35, 1.0, 1.0, 0.50, Strings['start_stealing'], 255, 255, 255, 255)
                        exports.globals:notify(Strings['start_stealing'])
                        if IsControlJustPressed(0, 38) then
                            local hasDoorBeenThermited = TriggerServerCallback {
                                eventName = "artHeist:hasDoorBeenThermited",
                                args = {}
                            }
                            if hasDoorBeenThermited then
                                local weapon = GetSelectedPedWeapon(ped)
                                if weapon == GetHashKey('WEAPON_SWITCHBLADE') then
                                    if not ArtHeist['cuting'] then
                                        HeistAnimation(k)
                                    else
                                        exports.globals:notify(Strings['already_cuting'])
                                    end
                                else
                                    exports.globals:notify('Need a switchblade', "^3INFO: ^0Need a switchblade")
                                end
                            else
                                print("door not thermited")
                            end
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function policeAlert()
	-- exports['qb-dispatch']:Artheist() -- Project-SLoth qb-dispatch
	-- TriggerServerEvent('police:server:policeAlert', 'Artheist Robbery') -- Regular VTCore
    --exports['ps-dispatch']:Artheist(camId)
    -- These are just examples, you'll have to implement your own police alert system!
    print('Test Police Alerts')
end

RegisterNetEvent('vt-artheist:client:syncHeistStart', function()
    ArtHeist['start'] = not ArtHeist['start']
end)

RegisterNetEvent('vt-artheist:client:syncPainting', function(x)
    Config['ArtHeist']['painting'][x]['taken'] = true
end)

RegisterNetEvent('vt-artheist:client:syncAllPainting', function(x)
    for k, v in pairs(Config['ArtHeist']['painting']) do
        v['taken'] = false
    end
end)

RegisterNetEvent("vt-artheist:finishHeist", function()
    local HasItems = TriggerServerCallback {
        eventName = "artHeist:hasItems",
        args = {}
    }
    if HasItems then
        if lib.progressCircle({
            duration = 2500,
            label = 'Finishing',
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true,
            },
            anim = {
                dict = 'mp_common',
                clip = 'givetake1_a',
                flag = 8,
            },
        }) then
            TriggerServerEvent('vt-artheist:server:items')
            exports.globals:notify(Strings['sucess_sell'], "^3INFO: ^0" .. Strings['sucess_sell'])
            FinishHeist()
            looted1 = false
            looted2 =false
        else
            exports.globals:notify(Strings['access_denied'], "^3INFO: ^0" .. Strings['access_denied'])
        end
    else
        exports.globals:notify(Strings['youdont_pictures'], "^3INFO: ^0" .. Strings['youdont_pictures'])
    end
end)

function FinishHeist()
    for k, v in pairs(ArtHeist['sellPeds']) do
        TaskTurnPedToFaceEntity(v, PlayerPedId(), 1000)
    end
    RemoveBlip(sellBlip)
    if DoesBlipExist(stealBlip) then
        RemoveBlip(stealBlip)
    end
end

-- Events
--[[
RegisterNetEvent('vt-artheist:client:Thermite', function()
    CoreName.Functions.TriggerCallback('vt-artheist:server:HasThermite', function(result)
        local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if result then
            if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
                TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(PlayerPedId()))
            end
            CoreName.Functions.TriggerCallback('vt-artheist:server:getCops', function(cops)
                if #(coords - Config.Thermite) < 2.0 then
					if cops >= Config.RequiredCops then
						PlantThermite()
						exports[thermiteUI]:Thermite(function(success)
						   if success then
							   ThermiteEffect()
						   else
							CoreName.Functions.Notify(Strings['termite'], "error")
                            policeAlert()
						   end
						end, Config.ThermiteSettings.time, Config.ThermiteSettings.gridsize, Config.ThermiteSettings.incorrectBlocks)
					else
						CoreName.Functions.Notify(Strings['mincops'], "error")
					end
				end
            end)
        else
            CoreName.Functions.Notify(Strings['someone'], "error", 2500)
        end
    end)
end)
--]]

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

function ThermiteEffect()
    local ped = PlayerPedId()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do Wait(50) end
    Wait(1500)
    TriggerServerEvent("vt-jewellery:server:ThermitePtfx")
    Wait(500)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Wait(25000)
    ClearPedTasks(ped)
    Wait(2000)
        TriggerServerEvent('qb-doorlock:server:updateState', Config.DoorId, false, false, false, true, false, false)
        TriggerServerEvent('qb-doorlock:server:updateState', Config.DoorId1, false, false, false, true, false, false)
        TriggerServerEvent('qb-doorlock:server:updateState', Config.DoorId2, false, false, false, true, false, false)
        TriggerServerEvent('qb-doorlock:server:updateState', Config.DoorId3, false, false, false, true, false, false)
        TriggerServerEvent('qb-doorlock:server:updateState', Config.DoorId4, false, false, false, true, false, false)
        TriggerServerEvent('qb-doorlock:server:updateState', Config.DoorId5, false, false, false, true, false, false)
end

function PlantThermite()
    TriggerServerEvent("vt-jewellery:server:remove")
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") or not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
    local ped = PlayerPedId()
    local pos = vector4(1392.99, 1127.35, 114.33, 8.64)
    SetEntityHeading(ped, pos.w)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local netscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local thermite = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(thermite, false, true)
    AttachEntityToEntity(thermite, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    NetworkAddPedToSynchronisedScene(ped, netscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(netscene)
    Wait(5000)
    DetachEntity(thermite, 1, 1)
    FreezeEntityPosition(thermite, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(netscene)
    CreateThread(function()
        Wait(15000)
        DeleteEntity(thermite)
    end)
end

function meltDoor(door)
	local playerPedId = PlayerPedId()
    dasvidania = false

    Citizen.CreateThread(function()
        local timer = GetGameTimer() + 6700
        while timer >= GetGameTimer() do
            if(IsPedDeadOrDying(playerPedId) and not dasvidania)then

                dasvidania = true

                while (bag == nil or scene == nil)do
                    Citizen.Wait(100)
                end

                NetworkStopSynchronisedScene(scene)
                DeleteObject(bag)
            end
            Wait(100)
        end
    end)

    SetCurrentPedWeapon(playerPedId, `WEAPON_UNARMED`, true)
    
    Citizen.Wait(500)

    while 
    (
    IsEntityPlayingAnim(playerPedId, "reaction@intimidation@cop@unarmed", "intro", 3) or
    IsEntityPlayingAnim(playerPedId, "reaction@intimidation@1h", "outro", 3)
    ) 
    do
        Citizen.Wait(100)
    end

    RequestNamedPtfxAsset("scr_ornate_heist")

    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")

    RequestModel("hei_p_m_bag_var22_arm_s")

    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
        Citizen.Wait(100)
    end

    while not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
        Citizen.Wait(100)
    end

    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(100)
    end

    SetEntityHeading(playerPedId, door.anim.h)

    Citizen.Wait(200)

    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(playerPedId)))

    scene = NetworkCreateSynchronisedScene(door.anim.x, door.anim.y, door.anim.z, rotx, roty, rotz + door.anim.extra, 2, false, false, 1065353216, 0, 1.3)

    bag = CreateObject(`hei_p_m_bag_var22_arm_s`, door.anim.x, door.anim.y, door.anim.z,  true,  true, false)

    SetEntityCollision(bag, false, true)

    NetworkAddPedToSynchronisedScene(playerPedId, scene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)

    local prevComponentVariation = GetPedDrawableVariation(playerPedId, 5)
    SetPedComponentVariation(playerPedId, 5, 0, 0, 0)

    NetworkStartSynchronisedScene(scene)

    Citizen.Wait(2000)

    if(not dasvidania)then
        local x, y, z = table.unpack(GetEntityCoords(playerPedId))
        thermite = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)

        --SetEntityCollision(thermite, true, false)
        
        AttachEntityToEntity(thermite, playerPedId, GetPedBoneIndex(playerPedId, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)

        Citizen.Wait(4000)

        DeleteObject(bag)
        SetPedComponentVariation(playerPedId, 5, prevComponentVariation, 0, 0)
        DetachEntity(thermite, 1, 1)
        --FreezeEntityPosition(thermite, true)

		TriggerServerEvent("artHeist:thermiteEffect", door)
        
        NetworkStopSynchronisedScene(scene)
		
        Citizen.Wait(30000)
        
        DeleteObject(thermite)

    end

end

RegisterNetEvent('artHeist:thermiteEffect')
AddEventHandler('artHeist:thermiteEffect', function(door)
    Citizen.CreateThread(function()
		local myped = PlayerPedId()

		RequestNamedPtfxAsset("scr_ornate_heist")
	
		while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
			Citizen.Wait(10)
		end
		
		SetPtfxAssetNextCall("scr_ornate_heist")

		local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", door.thermitefx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

		Citizen.CreateThread(function()

			local animating = false
	
			while effect ~= nil do
				Citizen.Wait(100)
				local mycoords = GetEntityCoords(PlayerPedId())
				if(#(mycoords - door.thermitefx) < 2.5)then
					if(not animating)then
						animating = true

						while #(mycoords - door.thermitefx) < 2.5 do
							mycoords = GetEntityCoords(PlayerPedId())
							Citizen.Wait(100)
							if not IsEntityPlayingAnim(myped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop" , 3) then
								TaskPlayAnim(myped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
								TaskPlayAnim(myped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
							end
						end

					end
				else
					if(animating)then
						ClearPedTasks(myped)
						animating = false
					end
				end
			end
	
		end)

		Citizen.Wait(30000)

		AddExplosion(door.thermitefx.x, door.thermitefx.y, door.thermitefx.z, 1, scale, true, false, 0)

		StopParticleFxLooped(effect, 0)
		effect = nil
            
    end)
end)

RegisterNetEvent('vt-artheist:starttheheist', function()
    Vank17a['functions'].OpenNui(true)
end)

RegisterNetEvent('artHeist:useThermite', function()
    -- play anim stuff
    local door = {
        anim = {
            h = 265.0,
            x = 1395.8444824219,
            y = 1141.6290283203,
            z = 114.63697814941,
            extra = 0.0,
        },
        thermitefx = vector3(1395.8, 1142.62, 114.6404)
    }
    meltDoor(door)
    -- remove item, call 911, unlock doors
    TriggerServerEvent("artHeist:useThermite")
end)

RegisterNUICallback("exit", function(data)
    Vank17a['functions'].OpenNui(false)
end)

RegisterNUICallback("starting", function(data)
    StartHeist()
    Vank17a['functions'].OpenNui(false)
end)

function StartHeist()
    local time = TriggerServerCallback {
        eventName = "artHeist:checkRobTime",
        args = {}
    }
    if time then
        if ArtHeist['start'] then exports.globals:notify(Strings['already_heist'], Strings['already_heist']) return end
        for k, v in pairs(ArtHeist['startPeds']) do
            TaskTurnPedToFaceEntity(v, PlayerPedId(), 1000)
        end
        Wait(3000)
        TriggerServerEvent('vt-artheist:server:syncHeistStart')
        looted2 = true
        exports.globals:notify(Strings['go_steal'], Strings['go_steal'])
        stealBlip = addBlip(vector3(1397.66, 1140.42, 114.268), 439, 0, Strings['steal_blip'])
        repeat
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local dist = #(pedCo - Config['ArtHeist']['painting'][1]['scenePos'])
            Wait(1)
        until dist <= 100.0
        -- create painting objects
        for k, v in pairs(Config['ArtHeist']['painting']) do
            loadModel(v['object'])
            ArtHeist['painting'][k] = CreateObjectNoOffset(GetHashKey(v['object']), v['objectPos'], 1, 1, 0)
            SetEntityRotation(ArtHeist['painting'][k], 0, 0, v['objHeading'], 2, true)
        end
        -- create armed guards
        spawnGuards()
        TriggerServerEvent("artHeist:makeGuardsAggressiveForAll")
    end
end

function HeistAnimation(sceneId)
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local scenes = {false, false, false, false}
    local animDict = "anim_heist@hs3f@ig11_steal_painting@male@"
    local scene = Config['ArtHeist']['painting'][sceneId]
    TriggerServerEvent('vt-artheist:server:syncPainting', sceneId)
    loadAnimDict(animDict)

    for k, v in pairs(Config['ArtHeist']['objects']) do
        loadModel(v)
        ArtHeist['objects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
    end

    ArtHeist['objects'][3] = ArtHeist['painting'][sceneId]

    for i = 1, 10 do
        ArtHeist['scenes'][i] = NetworkCreateSynchronisedScene(scene['scenePos']['x'], scene['scenePos']['y'], scene['scenePos']['z'], scene['sceneRot'], 2, true, false, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(ped, ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][3], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][3], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][1], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][4], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][2], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][5], 1.0, -1.0, 1148846080)
    end

    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 0, 3000, 1, 0)

    ArtHeist['cuting'] = true
    FreezeEntityPosition(ped, true)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][1])
    PlayCamAnim(cam, 'ver_01_top_left_enter_cam_ble', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][2])
    PlayCamAnim(cam, 'ver_01_cutting_top_left_idle_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    repeat
        DrawTxt(0.932, 1.35, 1.0, 1.0, 0.50, Strings['cute_right'], 255, 255, 255, 255)
        if IsControlJustPressed(0, 38) then
            scenes[1] = true
        end
        Wait(1)
    until scenes[1] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][3])
    PlayCamAnim(cam, 'ver_01_cutting_top_left_to_right_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][4])
    PlayCamAnim(cam, 'ver_01_cutting_top_right_idle_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    repeat
        DrawTxt(0.932, 1.35, 1.0, 1.0, 0.50, Strings['cute_down'], 255, 255, 255, 255)
        if IsControlJustPressed(0, 38) then
            scenes[2] = true
        end
        Wait(1)
    until scenes[2] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][5])
    PlayCamAnim(cam, 'ver_01_cutting_right_top_to_bottom_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][6])
    PlayCamAnim(cam, 'ver_01_cutting_bottom_right_idle_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    repeat
        DrawTxt(0.932, 1.35, 1.0, 1.0, 0.50, Strings['cute_left'], 255, 255, 255, 255)
        if IsControlJustPressed(0, 38) then
            scenes[3] = true
        end
        Wait(1)
    until scenes[3] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][7])
    PlayCamAnim(cam, 'ver_01_cutting_bottom_right_to_left_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    repeat
        DrawTxt(0.932, 1.35, 1.0, 1.0, 0.50, Strings['cute_down'], 255, 255, 255, 255)
        if IsControlJustPressed(0, 38) then
            scenes[4] = true
        end
        Wait(1)
    until scenes[4] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][9])
    PlayCamAnim(cam, 'ver_01_cutting_left_top_to_bottom_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(1500)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][10])
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    Wait(7500)
    TriggerServerEvent('vt-artheist:server:rewardItem', scene)
    ClearPedTasks(ped)
	FreezeEntityPosition(ped, false)
    RemoveAnimDict(animDict)
    for k, v in pairs(ArtHeist['objects']) do
        DeleteObject(v)
    end
    DeleteObject(ArtHeist['painting'][sceneId])
    ArtHeist['objects'] = {}
    ArtHeist['scenes'] = {}
    ArtHeist['cuting'] = false
    ArtHeist['cut'] = ArtHeist['cut'] + 1
    scenes = {false, false, false, false}
    if ArtHeist['cut'] == 1 then
        policeAlert()
    end
    if ArtHeist['cut'] == #Config['ArtHeist']['painting'] then
        TriggerServerEvent('vt-artheist:server:syncHeistStart')
        TriggerServerEvent('vt-artheist:server:syncAllPainting')
        exports.globals:notify("Go to the LS docks to sell the paintings", Strings['go_sell'])
        RemoveBlip(stealBlip)
        sellBlip = addBlip(Config['ArtHeist']['sellPainting']['pos'], 500, 0, Strings['sell_blip'])
        ArtHeist['cut'] = 0
        looted1 = true
    end
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(50)
    end
end

function loadModel(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(50)
    end
end

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function addBlip(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

function DrawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

AddEventHandler('onResourceStop', function (resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(ArtHeist['painting']) do
            DeleteObject(v)
        end
        for k, v in pairs(ArtHeist['objects']) do
            DeleteObject(v)
        end
    end
end)

exports("getMansionCoords", function()
    return Config["ArtHeist"]["painting"][1].objectPos
end)