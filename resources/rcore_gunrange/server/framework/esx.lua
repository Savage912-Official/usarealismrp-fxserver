if Config.FrameWork == "2" then
    ESX = nil

    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    ---You can edit this function to take money from player
    ---It needs to return true/false if payment was successfull
    function payMoney(source, price)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            return true
        end
        return false
    end
end