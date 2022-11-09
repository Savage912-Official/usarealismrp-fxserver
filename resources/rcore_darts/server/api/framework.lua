

CreateThread(function()
    if not Config.Framework ~= Framework.Standalone then
        if Config.Framework == Framework.ESX then
            ESX = exports['es_extended']:getSharedObject()
            if not ESX then return print("[rcore_darts] [error] Are you sure that you are using ESX?") end
            GetPlayerFromId = function (source)
                local xPlayer = { }
                local xplayer = ESX.GetPlayerFromId(source)
                xPlayer.addMoney = function (money)
                    return xplayer.addMoney(money)
                end
                xPlayer.removeMoney = function (money)
                    return xplayer.removeMoney(money)
                end
                xPlayer.getMoney = function (money)
                    return xplayer.getMoney()
                end
                return xPlayer
            end

        elseif Config.Framework == Framework.QBCore then
            QBCore = exports['qb-core']:GetCoreObject()
            if not QBCore then return print("[rcore_darts] [error] Are you sure that you are using QBCore?") end
            
            
            GetPlayerFromId = function(source)
                local xPlayer = {}
                local qbPlayer = QBCore.Functions.GetPlayer(source)
                ---------
                xPlayer.identifier = qbPlayer.PlayerData.citizenid
                ---------
                xPlayer.license = qbPlayer.PlayerData.license
                ---------
                xPlayer.job = {
                    name = qbPlayer.PlayerData.job.name,
                    label = qbPlayer.PlayerData.job.label,
                    grade = {
                        name = qbPlayer.PlayerData.job.grade.name or "none",
                        level = qbPlayer.PlayerData.job.grade.level or -1,
                    },
                }
                ---------
                xPlayer.getMoney = function()
                    return qbPlayer.Functions.GetMoney("cash")
                end
                ---------
                xPlayer.getAccount = function(type)
                    return {
                        money = qbPlayer.Functions.GetMoney(type) or 0
                    }
                end
                ---------
                xPlayer.removeAccountMoney = function(type, money)
                    qbPlayer.Functions.RemoveMoney(type, money)
                end
                ---------
                xPlayer.removeMoney = function(money)
                    qbPlayer.Functions.RemoveMoney("cash", money)
                end
                ---------
                xPlayer.canCarryItem = function(itemName, count)
                    local item = qbPlayer.Functions.GetItemByName(itemName) or {}
                    local ItemInfo = {
                        name = itemName,
                        count = item.amount or 0,
                        label = item.label or "none",
                        weight = item.weight or 0,
                        usable = item.useable or false,
                        rare = false,
                        canRemove = false,
                    }
            
                    local totalWeight = QBCore.Player.GetTotalWeight(qbPlayer.PlayerData.items)
                    return (totalWeight + (ItemInfo.weight * count)) <= QBCore.Config.Player.MaxWeight
                end
                ---------
                xPlayer.addInventoryItem = function(itemName, count)
                    qbPlayer.Functions.AddItem(itemName, count, false)
                end
                ---------
                xPlayer.removeInventoryItem = function(itemName, count)
                    qbPlayer.Functions.RemoveItem(itemName, count, false)
                end
                ---------
                xPlayer.getInventoryItem = function(itemName)
                    local item = qbPlayer.Functions.GetItemByName(itemName) or {}
            
                    local ItemInfo = {
                        name = itemName,
                        count = item.amount or 0,
                        label = item.label or "none",
                        weight = item.weight or 0,
                        usable = item.useable or false,
                        rare = false,
                        canRemove = false,
                    }
                    return ItemInfo
                end

                xPlayer.addMoney = function (money)
                    qbPlayer.Functions.AddMoney('cash', tonumber(money))
                end
                
                ---------
            
                return xPlayer
            end
        end
    end
end)

