RegisterNetEvent('fire:setEMS')
AddEventHandler('fire:setEMS', function(bool)
    TriggerEvent('fhose:canUseNozzles', bool)
end)

AddEventHandler('fhose:onPumpBreak', function()
    ShowNotification("~r~You Broke The Fire Hose!")
end)

AddEventHandler('fhose:requestEquipPump', function()
    TriggerEvent("fhose:equipPump")
end)

AddEventHandler('fhose:playSplashParticle', function(pdict, pname, posx, posy, posz, heading)
	Citizen.CreateThread(function()
        UseParticleFxAssetNextCall(pdict)
        local pfx = StartParticleFxLoopedAtCoord(pname, posx, posy, posz, 0.0, 0.0, heading, 1.0, false, false, false, false)
        Citizen.Wait(200)
        StopParticleFxLooped(pfx, 0)
    end)
end)

function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end