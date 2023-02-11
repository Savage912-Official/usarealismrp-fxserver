if Config.FrameWork == "3" then
    local QBCore = Config.GetQBCoreObject()

    --- You can edit this function to take money from player
    --- It needs to return true/false if payment was successfull
    function payMoney(source, price)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer.Functions.GetMoney("cash") >= price then
            xPlayer.Functions.RemoveMoney("cash", price)
            return true
        end
        return false
    end
end