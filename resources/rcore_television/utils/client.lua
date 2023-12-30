------------------------------------------------------------------
-- Need to be changed to your framework, for now default is ESX --
------------------------------------------------------------------
if Config.FrameWork == 1 then
    local PlayerData = {}
    ESX = GetEsxObject()

    CreateThread(function()
        if ESX then
            if ESX.IsPlayerLoaded() then
                PlayerData = ESX.GetPlayerData()
            end
        end
    end)

    RegisterNetEvent(Config.EsxPlayerLoaded or 'esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
    end)

    RegisterNetEvent(Config.EsxSetJob or 'esx:setJob', function(job)
        PlayerData.job = job
    end)

    function IsAtJob(name, grade)
        if not PlayerData or not PlayerData.job then
            print("ERROR", "the job for ESX is nil value please check if your  events are correct.")
            return true
        end

        if grade and grade == "*" and PlayerData.job.name == name then
            return true
        end
        if grade then
            return PlayerData.job.name == name and PlayerData.job.grade_name == grade
        end
        return PlayerData.job.name == name
    end
end

if Config.FrameWork == 2 then
    local PlayerData = {}
    local QBCore
    function UpdatePlayerDataForQBCore()
        local pData = QBCore.Functions.GetPlayerData()

        local jobName = "none"
        local gradeName = "none"

        if pData.job then
            jobName = pData.job.name or "none"

            if pData.job.grade then
                gradeName = pData.job.grade.name
            end
        end

        PlayerData = {
            job = {
                name = jobName,
                grade_name = gradeName,
            }
        }
    end

    CreateThread(function()
        QBCore = Config.GetQBCoreObject()

        if QBCore and QBCore.Functions.GetPlayerData() then
            UpdatePlayerDataForQBCore()
        end
    end)

    -- Will load player job + update markers
    RegisterNetEvent(Config.OnPlayerLoaded, function()
        UpdatePlayerDataForQBCore()
    end)

    -- Will load player job + update markers
    RegisterNetEvent(Config.OnJobUpdate, function()
        UpdatePlayerDataForQBCore()
    end)

    function IsAtJob(name, grade)
        if not PlayerData or not PlayerData.job then
            print("ERROR", "the job for QBcore is nil value please check if your  events are correct.")
            return true
        end

        if grade and grade == "*" and PlayerData.job.name == name then
            return true
        end
        if grade then
            return PlayerData.job.name == name and PlayerData.job.grade_name == grade
        end
        return PlayerData.job.name == name
    end
end

if Config.FrameWork == 0 then
    function IsAtJob(name, grade)
        return true
    end
end
------------------------
-- Optional to change --
------------------------
-- This will allow to open any TV if true, other players wont be able to interact but will albe to see
-- what is playing on TVscreen
function CustomPermission()
    return true
end

function showNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(0, 1)
end

RegisterNetEvent('rcore_tv:notification')
AddEventHandler('rcore_tv:notification', showNotification)

--- call callback

---TAKEN FROM rcore framework
---https://githu.com/Isigar/relisoft_core
---https://docs.rcore.cz

local clientCallbacks = {}
local currentRequest = 0

function callCallback(name, cb, ...)
    clientCallbacks[currentRequest] = cb
    TriggerServerEvent(TriggerName('callCallback'), name, currentRequest, GetPlayerServerId(PlayerId()), ...)

    if currentRequest < 65535 then
        currentRequest = currentRequest + 1
    else
        currentRequest = 0
    end
end

exports('callCallback', callCallback)

RegisterNetEvent(TriggerName('callback'))
AddEventHandler(TriggerName('callback'), function(requestId, ...)
    if clientCallbacks[requestId] == nil then
        return
    end
    clientCallbacks[requestId](...)
end)
