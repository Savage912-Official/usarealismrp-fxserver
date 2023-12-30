local currentlyAdmitted = false
local currentBed = nil
local hospitalCoords = vector3(354.032, -589.411, 42.415)
local BED_TRANSITION_TIME_MS = 5000

RegisterNetEvent("ems:hospitalize")
AddEventHandler("ems:hospitalize", function(treatmentTimeMinutes, bed, index)
    CreateThread(function()
        local playerPed = PlayerPedId()
        if index then
            TriggerServerEvent('ems:occupyBed', index)
        end
        DoScreenFadeOut(500)
        Citizen.Wait(500)
        Citizen.Wait(1000)
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'door-shut', 0.3)
        TriggerEvent("crim:untieHands", GetPlayerServerId(PlayerId()))
        TriggerEvent("crim:blindfold", false, true)
        TriggerEvent('injuries:checkin')
        currentlyAdmitted = true
        if bed then
            currentBed = bed
            bx, by, bz = table.unpack(currentBed.coords)
            ActivateBed(bx, by, bz, currentBed.model)
        else
            DoScreenFadeIn(1000)
        end
        TriggerServerEvent("hospital:saveTreatmentTime", treatmentTimeMinutes)
        local admitTime = GetGameTimer()
        while GetGameTimer() - admitTime < (treatmentTimeMinutes * 60 * 1000) do
            Wait(1)
        end
        SetEntityHealth(playerPed, 200)
        ClearPedBloodDamage(playerPed)
        currentlyAdmitted = false
        TriggerEvent('usa:showHelp', 'You have been treated.')
        TriggerServerEvent("hospital:saveTreatmentTime", 0)
    end)
end)

RegisterNetEvent('ems:admitMe')
AddEventHandler('ems:admitMe', function(bed, reasonForAdmission)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    SetEntityHealth(playerPed, 200)
    local treatmentTimeMinutes = 2
    local playerInjuries = exports.usa_injury:getPlayerInjuries()
    for bone, injuries in pairs(playerInjuries) do
        for injury, data in pairs(playerInjuries[bone]) do
            if injuries[injury].string == "High-speed Projectile" then 
                treatmentTimeMinutes = treatmentTimeMinutes + 4
            elseif injuries[injury].string == "Knife Puncture" then 
                treatmentTimeMinutes = treatmentTimeMinutes + 2
            elseif injuries[injury].string == "Explosion" then 
                treatmentTimeMinutes = treatmentTimeMinutes + 4
            elseif injuries[injury].string == "Large Sharp Object" then 
                treatmentTimeMinutes = treatmentTimeMinutes + 2
            end
        end
    end
    if treatmentTimeMinutes > 15 then
        treatmentTimeMinutes = 15
    end
    TriggerEvent('ems:hospitalize', treatmentTimeMinutes, bed)
    TriggerEvent("chatMessage", '^3^*[HOSPITAL] ^r^7You have been admitted to the hospital. (' .. reasonForAdmission .. ')')
end)

RegisterNetEvent('ems:getNearestBedIndex')
AddEventHandler('ems:getNearestBedIndex', function(hospitalBeds)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #hospitalBeds do
        local x, y, z = table.unpack(hospitalBeds[i].objCoords)
        if Vdist(playerCoords, x, y, z) < 2.0 and not currentBed and not hospitalBeds[i].occupied then
            TriggerServerEvent('ems:occupyBed', i)
            currentBed = hospitalBeds[i]
            ActivateBed(x, y, z, hospitalBeds[i].objModel)
        end
    end
end)

function ActivateBed(x, y, z, model)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        RequestCollisionAtCoord(x, y, z)
        SetEntityCoords(playerPed, x, y, z + 0.1)
        while not HasCollisionLoadedAroundEntity(playerPed) do
            SetEntityCoords(playerPed, x, y, z + 0.1)
            Wait(1)
        end
        local coordSetTime = GetGameTimer()
        while GetGameTimer() - coordSetTime <= BED_TRANSITION_TIME_MS do
            Wait(1)
        end
        local bedObject = GetClosestObjectOfType(x, y, z, 5.0, model, false, false, false)
        local x, y, z = table.unpack(GetEntityCoords(bedObject))
        local rx, ry, rz = table.unpack(GetEntityRotation(bedObject))
        local dict = 'anim@mp_bedmid@left_var_04'
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
        DoScreenFadeIn(1000)
        --TaskPlayAnim(GetPlayerPed(-1), 'anim@mp_bedmid@left_var_02' , 'f_sleep_l_loop_bighouse' ,8.0, 1.0, -1, 1, 1.0, false, false, false )
        while currentBed do
            Citizen.Wait(1)
            if not currentlyAdmitted then
                DrawTxt(0.965, 1.455, 1.0, 1.0, 0.40, 'Press ~g~E~s~ to leave bed', 255, 255, 255, 255)
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent('ems:resetBed')
                    FreezeEntityPosition(playerPed, false)
                    TaskPlayAnim(playerPed, dict, 'f_getout_l_bighouse', 8.0, -1, -1, 1, 1.0, false, false, false)
                    Citizen.Wait(2000)
                    SetEntityCollision(bedObject, false)
                    Citizen.Wait(2500)
                    SetEntityCollision(bedObject, true)
                    ClearPedTasks(playerPed)
                    currentBed = nil
                    return
                end
            end
            TaskPlayAnimAdvanced(playerPed, dict, 'f_sleep_l_loop_bighouse', x, y+0.05, z+1.175, rx, ry, rz-180.0, 1.0, 1.0, -1, 1, 0.0, false, false)
            FreezeEntityPosition(playerPed, true)
        end
    end)
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
