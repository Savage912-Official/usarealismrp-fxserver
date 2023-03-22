local IsRecalibrating = false
local CalibratedCams = {}
local LastCalibratedId = -1

RegisterCommand('camrecalibrate', function(source, args)
    IsRecalibrating = true
    
    if source == 0 then
        source = args[1]
    end

    TriggerClientEvent('rcore_cam:recalibrate', source, LastCalibratedId)
end, true)

TriggerEvent('es:addGroupCommand', 'camrecalibrate', 'admin', function(source, args, char)
    IsRecalibrating = true

    TriggerClientEvent('rcore_cam:recalibrate', source, LastCalibratedId)
end, {
    help = "CCTV Recalibration.",
    params = {
    }
})

RegisterNetEvent('rcore_cam:recalibrate', function(data, groupId)
    table.insert(CalibratedCams, data)
    LastCalibratedId = groupId
end)

RegisterNetEvent('rcore_cam:recalibrateCleanup', function()
    if IsRecalibrating then
        SaveResourceFile(GetCurrentResourceName(), 'cameras.json', json.encode(CalibratedCams), -1)
        IsRecalibrating = false
    end
end)