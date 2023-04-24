if Config.FrameWork == "1" then
    function payMoney(source, price)
        local char = exports["usa-characters"]:GetCharacter(source)
        local cash = char.get("money")
        local bank = char.get("bank")
        if cash >= price then
            char.removeMoney(price)
            TriggerClientEvent("usa:notify", source, "You paid $" .. price .. " in cash.")
            return true
        elseif bank >= price then
            char.removeBank(price, "Gunrange")
            TriggerClientEvent("usa:notify", source, "You paid $" .. price .. " from bank")
            return true
        else
            TriggerClientEvent("usa:notify", source, "You beed $" .. price .. " in the bank or cash!")
        end
        return false
    end
end