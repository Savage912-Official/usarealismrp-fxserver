if Config.Framework.CUSTOM then
    function IsPlayerCop()
        local result = TriggerServerCallback {
            eventName = 'rcore_cam:getJob',
            args = {}
        }
        if result == "sheriff" or result == "corrections" then
            return true
        else
            return false
        end
    end

    RegisterNetEvent("rcore_cam:startRecording")
    AddEventHandler("rcore_cam:startRecording", function()
        print("start record")
        TriggerServerEvent("rcore_cam:startRecordingSV")
    end)
end
