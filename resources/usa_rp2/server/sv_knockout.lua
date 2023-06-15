RegisterServerEvent("usa:knockout")
AddEventHandler("usa:knockout", function(targetId)
    local curPedVeh = GetVehiclePedIsIn(GetPlayerPed(targetId), false)
    if not DoesEntityExist(curPedVeh) then
        TriggerClientEvent("usa:knockout", targetId)
    else
        TriggerClientEvent("usa:notify", source, "Missed!")
    end
end)