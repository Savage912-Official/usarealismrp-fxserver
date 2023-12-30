------------------------------------------------------------------
-- Need to be changed to your framework, for now default is ESX --
------------------------------------------------------------------
ESX = nil
QBCore = nil

if Config.FrameWork == 1 then
    ESX = GetEsxObject()
end

if Config.FrameWork == 2 then
    QBCore = Config.GetQBCoreObject()
end


function HavePlayerControler(source, itemName)
    if Config.FrameWork == 1 then
        local sourceItem = ESX.GetPlayerFromId(source).getInventoryItem(itemName)
        return (sourceItem ~= nil and sourceItem.count ~= 0)
    end
    if Config.FrameWork == 2 then
        local qbPlayer = QBCore.Functions.GetPlayer(source)
        local item = qbPlayer.Functions.GetItemByName(itemName) or {}
        local ItemInfo =  {
            name = itemName,
            count = item.amount or 0,
            label = item.label or "none",
            weight = item.weight or 0,
            usable = item.useable or false,
            rare = false,
            canRemove = false,
        }

        return ItemInfo.count ~= 0
    end
    return true
end


--- call callback
---TAKEN FROM rcore framework
---https://githu.com/Isigar/relisoft_core
---https://docs.rcore.cz
local serverCallbacks = {}
local callbacksRequestsHistory = {}

function registerCallback(cbName, callback)
    serverCallbacks[cbName] = callback
end

RegisterNetEvent(TriggerName('callCallback'))
AddEventHandler(TriggerName('callCallback'), function(name, requestId, source, ...)
    if serverCallbacks[name] == nil then
        return
    end
    callbacksRequestsHistory[requestId] = {
        name = name,
        source = source,
    }
    local call = serverCallbacks[name]
    call(source, function(...)
        TriggerClientEvent(TriggerName('callback'), source, requestId, ...)
    end, ...)
end)
